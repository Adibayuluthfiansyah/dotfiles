#!/bin/bash
# quicklink-icon — static scratchpad icons for the Quickshell bar.
# Usage: quicklink-icon <name>   (interval 3600 in shell.json — output static)
# Glyphs are Nerd Font codepoints (rendered via fontconfig fallback).
case "$1" in
  music)     echo "" ;;  # fa-music — togglespecialworkspace music
  whatsapp)  echo "" ;;  # fa-whatsapp — togglespecialworkspace whatsapp
  instagram) echo "" ;;  # fa-instagram — togglespecialworkspace instagram
  video)     echo "" ;;  # fa-video-camera — togglespecialworkspace video
  file)      echo "" ;;  # fa-folder — togglespecialworkspace file
  kitty)     echo "" ;;  # fa-terminal — togglespecialworkspace kitty
  browser)   echo "" ;;  # fa-globe — togglespecialworkspace browser
  obsidian)  echo "" ;;  # fa-book — togglespecialworkspace obsidian
  *)         echo "?" ;;
esac
