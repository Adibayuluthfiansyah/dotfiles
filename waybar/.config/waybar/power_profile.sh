#!/bin/bash

current_profile=$(powerprofilesctl get)

case $1 in
"toggle")
  case $current_profile in
  "performance")
    powerprofilesctl set balanced
    ;;
  "balanced")
    powerprofilesctl set power-saver
    ;;
  "power-saver")
    powerprofilesctl set performance
    ;;
  esac
  ;;
esac

current_profile=$(powerprofilesctl get)

case $current_profile in
"performance")
  echo ""
  ;;
"balanced")
  echo ""
  ;;
"power-saver")
  echo ""
  ;;
*)
  echo "?"
  ;;
esac
