#!/bin/bash

#Customize this stuff
IF="Master"         # audio channel: Master|PCM

err() {
  echo "$1"
  exit 1
}

usage() {
  echo "usage: notify-volume.sh [option] [argument]"
  echo
  echo "Options:"
  echo "     -i, --increase - increase volume by \`argument'"
  echo "     -d, --decrease - decrease volume by \`argument'"
  echo "     -p, --print    - print current status/volume only"
  echo "     -t, --toggle   - toggle mute on and off"
  echo "     -h, --help     - display this"
  exit
}

#Argument Parsing
case "$1" in
  '-i'|'--increase')
    [ -z "$2" ] && err "No argument specified for increase."
    [ -n "$(tr -d [0-9] <<<$2)" ] && err "The argument needs to be an integer."
    AMIXARG="${2}%+"
    ;;
  '-d'|'--decrease')
    [ -z "$2" ] && err "No argument specified for decrease."
    [ -n "$(tr -d [0-9] <<<$2)" ] && err "The argument needs to be an integer."
    AMIXARG="${2}%-"
    ;;
  '-p'|'--print')
    AMIXOUT="$(amixer get "$IF" | tail -n 1)"
    MUTE="$(cut -d '[' -f 4 <<<"$AMIXOUT")"
    if [ "$MUTE" == "off]" ]; then
        echo off
    else
        VOL="$(cut -d '[' -f 2 <<<"$AMIXOUT" | sed 's/%.*//g')"
        echo $VOL
    fi
    exit
    ;;
  '-t'|'--toggle')
    AMIXARG="toggle"
    ;;
  ''|'-h'|'--help')
    usage
    ;;
  *)
    err "Unrecognized option \`$1', see dvol --help"
    ;;
esac

#Actual volume changing (readability low)

AMIXOUT="$(amixer -c 1 set "$IF" "$AMIXARG" | tail -n 1)"
MUTE="$(cut -d '[' -f 4 <<<"$AMIXOUT")"
VOL="$(cut -d '[' -f 2 <<<"$AMIXOUT" | sed 's/%.*//g')"

# Force conky to update
killall -SIGUSR1 statobar
