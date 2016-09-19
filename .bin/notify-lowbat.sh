#!/usr/bin/env bash

perc=$(acpi | awk '{print $4}' | awk '{print $1}' FS=%)
state=$(acpi | awk '{print $1}' FS=, | awk '{print $3}' FS=\ )

if [[ "$state" == "Discharging" && "$perc" -le 90 ]]; then
    notify-send "Low battery!" "Battery percentage at $perc% and falling!" -u critical -i /usr/share/icons/Adwaita/48x48/status/battery-caution.png -t 3000
fi
