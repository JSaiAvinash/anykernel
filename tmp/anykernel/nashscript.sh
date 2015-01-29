#!/system/bin/sh

# disable sysctl.conf to prevent ROM interference with tunables
$bb mount -o rw,remount /system;
$bb [ -e /system/etc/sysctl.conf ] && $bb mv -f /system/etc/sysctl.conf /system/etc/sysctl.conf.bak;

# disable the PowerHAL since there is a kernel-side touch boost implemented
$bb [ -e /system/lib/hw/power.msm8960.so.bak ] || $bb cp /system/lib/hw/power.msm8960.so /system/lib/hw/power.msm8960.so.bak;
$bb [ -e /system/lib/hw/power.msm8960.so ] && $bb rm -f /system/lib/hw/power.msm8960.so;

# disable mpd and thermald
$bb [ -e /system/lib/hw/power.mako.so.bak ] || $bb cp /system/lib/hw/power.mako.so /system/lib/hw/power.mako.so.bak;
$bb [ -e /system/lib/hw/power.mako.so ] && $bb rm -f /system/lib/hw/power.mako.so;

$bb [ -e /system/bin/thermal-engine-hh.bak ] || $bb cp /system/bin/thermal-engine-hh /system/bin/thermal-engine-hh.bak;
$bb [ -e /system/bin/thermal-engine-hh ] && $bb rm -f /system/bin/thermal-engine-hh;

$bb [ -e /system/bin/mpdecision.bak ] || $bb cp /system/bin/mpdecision /system/bin/mpdecision.bak;
$bb [ -e /system/bin/mpdecision ] && $bb rm -f /system/bin/mpdecision;

$bb [ -e /system/bin/thermald.bak ] || $bb cp /system/bin/thermald /system/bin/thermald.bak;
$bb [ -e /system/bin/thermald ] && $bb rm -f /system/bin/thermald;

# create and set permissions for /system/etc/init.d if it doesn't already exist
if [ ! -e /system/etc/init.d ]; then
   mkdir /system/etc/init.d;
   chown -R root.root /system/etc/init.d;
   chmod -R 755 /system/etc/init.d;
fi;
 mount -o ro,remount /system;

# Gamma-Obsanity superAMOLED
echo "255 255 255" > sys/devices/platform/kcal_ctrl.0/kcal
echo "0" > sys/devices/virtual/misc/gammacontrol/red_greys
echo "119" > sys/devices/virtual/misc/gammacontrol/red_mids
echo "119" > sys/devices/virtual/misc/gammacontrol/red_blacks
echo "7" > sys/devices/virtual/misc/gammacontrol/red_whites
echo "0" > sys/devices/virtual/misc/gammacontrol/green_greys
echo "119" > sys/devices/virtual/misc/gammacontrol/green_mids
echo "119" > sys/devices/virtual/misc/gammacontrol/green_blacks
echo "7" > sys/devices/virtual/misc/gammacontrol/green_whites
echo "0" > sys/devices/virtual/misc/gammacontrol/blue_greys
echo "119" > sys/devices/virtual/misc/gammacontrol/blue_mids
echo "119" > sys/devices/virtual/misc/gammacontrol/blue_blacks
echo "7" > sys/devices/virtual/misc/gammacontrol/blue_whites
echo "0" > sys/devices/virtual/misc/gammacontrol/contrast
echo "0" > sys/devices/virtual/misc/gammacontrol/brightness
echo "119" > sys/devices/virtual/misc/gammacontrol/saturation

# dt2w area
echo "3" > sys/module/lge_touch_core/parameters/doubletap_area
