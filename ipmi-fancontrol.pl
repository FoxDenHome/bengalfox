#!/usr/bin/perl
use strict;
use warnings;
use List::Util qw[min max];

# This script controls SuperMicro server fan speeds via IPMI in response to CPU and GPU Temperatures.
# This script is tested on the SuperMicro X10 4027GR-TRT Server. It may work on other X9/X10/X11 motherboards.
#
# NOTE: The script puts your server into "Full Fan Speed Mode", and then modifies what "Full Speed" means,
#       You have to manually use IPMI to set it to e.g. "Optimal" when you're not using the script.
#
# NOTE: You use this script at your own risk, and no warranty is provided. Do not use in produciton environments.
#
# Author: Layla Mah <layla@insightfulvr.com>

my $debug_on = 0;

# System Configuration
my $number_of_fans      = 4;
my $number_of_cpus      = 2; # Number of CPUs to search for
my $min_temp_change     = 5; # *C minimum change to actually cause a fan speed update
my $seconds_to_sleep    = 5; # Number of seconds to sleep between update loops

# IPMI Configuration
my $ipmi_cmd_listall    = "sdr list full";

# CPU Temp -> Fan Speed Mappings
my %cpu_temp_to_fan_speed;
   $cpu_temp_to_fan_speed{80} = 0x64;
   $cpu_temp_to_fan_speed{75} = 0x56;
   $cpu_temp_to_fan_speed{70} = 0x48;
   $cpu_temp_to_fan_speed{60} = 0x40;
   $cpu_temp_to_fan_speed{55} = 0x32;
   $cpu_temp_to_fan_speed{50} = 0x16;
   $cpu_temp_to_fan_speed{10} = 0x08;

# Below this line follows the actual implementation of the script

my $g_current_fan_duty_cycle = 0;
my $g_current_cpu_temp = 0;
my $g_last_set_cpu_temp = 0;

#`ipmitool raw 0x30 0x91 0x5A 0x03 0x00 0x00`;
#`ipmitool raw 0x30 0x91 0x5A 0x03 0x01 0x00`;
#`ipmitool raw 0x30 0x91 0x5A 0x03 0x02 0x00`;
#`ipmitool raw 0x30 0x91 0x5A 0x03 0x03 0x00`;

sub Internal_DoSetFanSpeed
{
  my ( $fan_speed ) = @_;
  #`timeout 5 ipmitool raw 0x30 0x91 0x5A 0x3 0x11 $fan_speed`;
  #`timeout 5 ipmitool raw 0x30 0x91 0x5A 0x3 0x10 $fan_speed`;
  `timeout 5 ipmitool raw 0x30 0x70 0x66 0x01 0x00 $fan_speed`;
  `timeout 5 ipmitool raw 0x30 0x70 0x66 0x01 0x01 $fan_speed`;
}

sub dprint
{
  if ( $debug_on )
  {
    print @_;
  }
}

sub SetFanSpeed
{
  my ( $fan_speed ) = @_;

  my $cpu_temp_difference = $g_current_cpu_temp - $g_last_set_cpu_temp;
  if( (abs $cpu_temp_difference) > $min_temp_change )
  {
    # Set all 4 fan banks to operate at $fan_speed duty cycle (0x0-0xff valid range)
     dprint "\n";
     dprint "******************** Updating Fan Speeds ********************\n";
     dprint "We last updated fan speed $cpu_temp_difference *C ago (CPU Temperature).\n";
     dprint "Current CPU Temperature is $g_current_cpu_temp *C.\n";
     dprint "Setting Fan Speed on all fan banks to $fan_speed\n";
     dprint "*************************************************************\n";
    
    $g_last_set_cpu_temp = $g_current_cpu_temp;
    $g_current_fan_duty_cycle = $fan_speed;

    Internal_DoSetFanSpeed( $fan_speed );
  }
}

sub UpdateFanSpeed
{ 
  # Gather statistics for fan speed and CPU Temp and stuch
  my $ipmi_output = `timeout 5 ipmitool $ipmi_cmd_listall`;
  my @vals = split( "\n", $ipmi_output );

  my $current_cpu_temp = 0;
  my $min_fan_speed = 30000;
  my $max_fan_speed = 0;

  foreach my $value (@vals)
  {
  
    foreach my $fan (1..$number_of_fans)
    {
      if( $value =~ /^(FAN$fan)\s.*\s(\d+)\s.*RPM.*/gi )
      {
        #dprint "Value   : $value\n";
        #dprint "Matched : $1\n";
        #dprint "FanSpeed: $2 RPM\n";
        dprint "$1 ....: $2 RPM\n";
        my  $fan_speed = $2;
        $min_fan_speed = min( $fan_speed, $min_fan_speed );
        $max_fan_speed = max( $fan_speed, $max_fan_speed );
      }
    } # foreach my $fan (1..$number_of_fans)
     
    foreach my $cpu (1..$number_of_cpus)
    {
      if( $value =~ /^(CPU$cpu\sTemp).*\s(\d+)\s.*degrees\sC.*/gi )
      {
        #dprint "Value  : $value\n";
        #dprint "Matched: $1\n";
        #dprint "Temp   : $2 degrees C\n";
        dprint "$1: $2 degrees C\n";
        my      $cpu_temp = $2;
        $current_cpu_temp = max( $cpu_temp, $current_cpu_temp );
      }
    } # foreach my $cpu (1..$number_of_cpus)
    
  } # foreach my $value (@vals)

  $g_current_cpu_temp = $current_cpu_temp;

  dprint "Maximum CPU Temperature Seen: $current_cpu_temp degrees C.\n";
  dprint "Current Minimum Fan Speed: $min_fan_speed RPM\n";
  dprint "Current Maximum Fan Speed: $max_fan_speed RPM\n";

  my $desired_fan_speed = 0x0;
 
  my @cpu_temps = keys %cpu_temp_to_fan_speed;
  for my $cpu_temp (@cpu_temps)
  {
    if( $current_cpu_temp > $cpu_temp )
    {
      # If the current CPU temperature is higher than the temperature enumerated by this hash lookup,
      # Then set the desired fan speed (if our value is larger than the existing value)
      $desired_fan_speed = max( $cpu_temp_to_fan_speed{ $cpu_temp }, $desired_fan_speed );
      #dprint "The fan speed setting for CPU Temp $cpu_temp *C is $cpu_temp_to_fan_speed{$cpu_temp} % duty cycle\n";
    }
  }

  if( $desired_fan_speed == 0x0 )
  {
    dprint "\n***** ERROR: Failed to determine a desired fan speed. Forcing fans to 100% duty cycle as a safety fallback measure. *****\n";
    $desired_fan_speed = 0xff;
  }

  my $duty_cycle_perc = $g_current_fan_duty_cycle / 2.55;
  dprint "Current Fan Duty Cycle: $duty_cycle_perc%\n";
  my $duty_cycle_perc2 = $desired_fan_speed / 2.55;
  dprint "Desired Fan Duty Cycle: $duty_cycle_perc2%\n";

  SetFanSpeed( $desired_fan_speed );

}

dprint "Setting Fan mode to FULL SPEED.\n";
# Ensure Fan Mode is set to Full Speed
`ipmitool raw 0x30 0x45 0x01 0x01`;

while( 1 )
{
  dprint "\n";
  dprint "=================================================================\n";
  dprint "Calling UpdateFanSpeed()...\n";
  dprint "=================================================================\n";
  UpdateFanSpeed();
  dprint "=================================================================\n";
  dprint "Update Complete - going to sleep for $seconds_to_sleep seconds...\n";
  dprint "=================================================================\n";
  sleep $seconds_to_sleep;
}
