#!/bin/bash
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
