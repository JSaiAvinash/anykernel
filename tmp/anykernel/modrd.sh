#!/sbin/sh
# modrd.sh initially made by Ziddey
#
# Updated for Lollipop use by Zaclimon
#

# Check to see if there's any occurence of performance profile script in the ramdisk
performanceprofiles=`grep -c "import init.performance_profiles.rc" init.mako.rc`

# Detect the presence of nash tweaks into init.mako.rc
nashtweaks=`grep -c "on property:sys.boot_completed=1" init.mako.rc`

# Copy nash boot script
cp ../nashscript.sh sbin/

# Add permissions to be executable
chmod 0750 sbin/nashscript.sh

# Apply performance profiles stuff
if [ $performanceprofiles -eq 0 ] ; then
sed '/import init.mako.tiny.rc/a \import init.performance_profiles.rc' -i init.mako.rc
cp ../init.performance_profiles.rc ./
chmod 0755 init.performance_profiles.rc
fi

# Modifications to init.mako.rc
if [ $performanceprofiles -eq 0 ] ; then
sed '/scaling_governor/ s/ondemand/interactive/g' -i init.mako.rc
sed '/ondemand/d' -i init.mako.rc
sed '/cpu.notify_on_migrate /s/1/0/g' -i init.mako.rc
sed '/group radio system/a \    disabled' -i init.mako.rc
sed '/group root system/a \    disabled' -i init.mako.rc
fi

# Modidfications to init.rc
if [ $performanceprofiles -eq 0 ] ; then
sed '/seclabel u:r:install_recovery:s0/d' -i init.rc
fi

# Applying some nash stuff after boot
if [ $nashtweaks -eq 0 ] ; then
echo "
service nashscript /sbin/nashscript.sh
    class late_start
    user root
    disabled
    oneshot

on property:sys.boot_completed=1
    start nashscript
    write /sys/class/timed_output/vibrator/amp 100
    write /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor "elementalx"
    write /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor "elementalx"
    write /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor "elementalx"
    write /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor "elementalx"
    write /sys/devices/system/cpu/cpufreq/elementalx/gboost 0
    write /sys/devices/system/cpu/cpufreq/elementalx/sampling_rate 50000
    write /sys/devices/system/cpu/cpufreq/elementalx/ui_sampling_rate 30000
    write /sys/devices/system/cpu/cpufreq/elementalx/down_differential 5
    write /sys/devices/system/cpu/cpufreq/elementalx/sampling_down_factor 1
    write /sys/devices/system/cpu/cpufreq/elementalx/optimal_freq 384000
    write /sys/devices/system/cpu/cpufreq/elementalx/sync_freq 384000
    write /sys/devices/system/cpu/cpufreq/elementalx/input_event_timeout 500
    write /sys/devices/system/cpu/cpufreq/elementalx/up_threshold 90
    write /sys/devices/system/cpu/cpufreq/elementalx/up_threshold_any_cpu_load 80
    write /sys/devices/system/cpu/cpufreq/elementalx/up_threshold_multi_core 80

    write /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor "blu_active"
    write /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor "blu_active"
    write /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor "blu_active"
    write /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor "blu_active"
    write /sys/devices/system/cpu/cpufreq/blu_active/hispeed_freq 1026000
    write /sys/devices/system/cpu/cpufreq/blu_active/go_hispeed_load 90
    write /sys/devices/system/cpu/cpufreq/blu_active/sampling_down_factor 100000
    write /sys/devices/system/cpu/cpufreq/blu_active/min_sample_time 40000
    write /sys/devices/system/cpu/cpufreq/blu_active/timer_rate 40000
    write /sys/devices/system/cpu/cpufreq/blu_active/above_hispeed_delay "20000 800000:40000 1300000:20000"
    write /sys/devices/system/cpu/cpufreq/blu_active/boostpulse_duration 10000
    write /sys/devices/system/cpu/cpufreq/blu_active/timer_slack 30000
    write /sys/devices/system/cpu/cpufreq/blu_active/io_is_busy 1
    write /sys/devices/system/cpu/cpufreq/blu_active/up_threshold_any_cpu_load 75
    write /sys/devices/system/cpu/cpufreq/blu_active/sync_freq 1026000
    write /sys/devices/system/cpu/cpufreq/blu_active/up_threshold_any_cpu_freq 1350000

    write /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor "ondemand"
    write /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor "ondemand"
    write /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor "ondemand"
    write /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor "ondemand"
    write /sys/devices/system/cpu/cpufreq/ondemand/up_threshold 95
    write /sys/devices/system/cpu/cpufreq/ondemand/sampling_rate 20000
    write /sys/devices/system/cpu/cpufreq/ondemand/io_is_busy 1
    write /sys/devices/system/cpu/cpufreq/ondemand/sampling_down_factor 4

    write /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor "interactive"
    write /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor "interactive"
    write /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor "interactive"
    write /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor "interactive"
    write /sys/devices/system/cpu/cpufreq/interactive/above_hispeed_delay "20000 800000:40000 1300000:20000"
    write /sys/devices/system/cpu/cpufreq/interactive/go_hispeed_load 90
    write /sys/devices/system/cpu/cpufreq/interactive/hispeed_freq 1134000
    write /sys/devices/system/cpu/cpufreq/interactive/io_is_busy 1
    write /sys/devices/system/cpu/cpufreq/interactive/target_loads "85 800000:90 1300000:70"
    write /sys/devices/system/cpu/cpufreq/interactive/min_sample_time "40000 1200000:80000"
    write /sys/devices/system/cpu/cpufreq/interactive/sampling_down_factor 100000
    write /sys/devices/system/cpu/cpufreq/interactive/timer_rate 60000
    write /sys/devices/system/cpu/cpufreq/interactive/input_boost_freq 1026000
    write /sys/devices/system/cpu/cpufreq/interactive/max_freq_hysteresis 100000

    write /sys/module/blu_plug/parameters/up_timer_cnt 2
    write /sys/module/blu_plug/parameters/down_timer_cnt 6
    write /sys/module/blu_plug/parameters/up_threshold 80
    write /sys/module/blu_plug/parameters/max_cores_screenoff 2

    write /sys/module/msm_thermal/parameters/enabled "Y"
    write /sys/module/msm_thermal/core_control/enabled 1
    write /sys/module/msm_thermal/parameters/core_limit_temp_degC 65
    write /sys/module/msm_thermal/parameters/limit_temp_degC 70
    write /sys/module/msm_thermal/parameters/core_control_mask 12

    write /sys/devices/platform/kgsl-3d0.0/kgsl/kgsl-3d0/pwrscale/trustzone/governor "simple"
    write /sys/devices/platform/kgsl-3d0.0/kgsl/kgsl-3d0/max_gpuclk 400000000 " >> init.mako.rc
fi
