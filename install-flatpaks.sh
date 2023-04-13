#!/bin/sh

# Flatpak crashes if home directory doesn't exist
mkdir -p /var/roothome


flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo \
    || exit 1

while read -r package; do
    flatpak install "${package}" \
        || exit 1
done < /tmp/flatpaks.txt