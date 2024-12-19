#!/bin/bash

# System aktualisieren
echo "System wird aktualisiert..."
sudo apt update && sudo apt upgrade -y

# i3wm, dmenu, URxvt, picom und andere notwendige Tools installieren
echo "i3wm, dmenu, URxvt und notwendige Tools werden installiert..."
sudo apt install -y i3 dmenu xbacklight feh lxappearance rxvt-unicode picom network-manager-gnome volumeicon-alsa pavucontrol blueman

# Autostart-Verzeichnis erstellen (falls nicht vorhanden)
mkdir -p ~/.config/autostart

# Autostart für Netzwerk-, Bluetooth- und Sound-Applets
cat <<EOL > ~/.config/autostart/nm-applet.desktop
[Desktop Entry]
Type=Application
Exec=nm-applet
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name=Network Manager Applet
Comment=Startet den NetworkManager
EOL

cat <<EOL > ~/.config/autostart/volumeicon.desktop
[Desktop Entry]
Type=Application
Exec=volumeicon
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name=Volume Icon
Comment=Startet den Lautstärkeregler
EOL

cat <<EOL > ~/.config/autostart/blueman-applet.desktop
[Desktop Entry]
Type=Application
Exec=blueman-applet
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name=Bluetooth Manager
Comment=Startet den Bluetooth-Manager
EOL

# i3wm-Konfiguration erstellen
echo "i3wm-Konfigurationsdatei wird erstellt..."
mkdir -p ~/.config/i3
cat <<EOL > ~/.config/i3/config
# Grundkonfiguration für i3wm
set \$mod Mod4  # Super/Windows-Taste als Modifikator

# Programme starten
bindsym \$mod+Return exec urxvt  # URxvt als Terminal starten
bindsym \$mod+d exec dmenu_run   # dmenu starten

# Fensterverwaltung
bindsym \$mod+h split h          # Horizontal teilen
bindsym \$mod+v split v          # Vertikal teilen
bindsym \$mod+q kill             # Fenster schließen
bindsym \$mod+f fullscreen       # Vollbildmodus

# Arbeitsbereiche
bindsym \$mod+1 workspace 1
bindsym \$mod+2 workspace 2
bindsym \$mod+3 workspace 3
bindsym \$mod+4 workspace 4
bindsym \$mod+5 workspace 5

# Statusleiste (i3status)
bar {
    status_command i3status
    position top
    font pango:monospace 10
}

# Hintergrundbild mit feh
exec --no-startup-id feh --bg-scale /usr/share/backgrounds/lubuntu-default-wallpaper.png

# Netzwerk-, Bluetooth- und Lautstärke-Applets starten
exec --no-startup-id nm-applet
exec --no-startup-id volumeicon
exec --no-startup-id blueman-applet

# Starte picom für Transparenz
exec --no-startup-id picom
EOL

# i3status-Konfiguration für die Statusleiste erstellen
echo "i3status-Konfiguration wird erstellt..."
mkdir -p ~/.config/i3status
cat <<EOL > ~/.config/i3status/config
general {
    output_format = "i3bar"
    colors = true
    interval = 5
}

order += "cpu_usage"
order += "load"
order += "disk /"
order += "volume master"
order += "battery 0"
order += "ethernet eth0"
order += "wireless wlan0"
order += "time"

cpu_usage {
    format = "CPU: %usage%%"
}

load {
    format = "Load: %1min"
}

disk "/" {
    format = "Disk: %avail"
}

volume master {
    format = "Volume: %volume"
}

battery 0 {
    format = "Battery: %status %percentage"
}

ethernet eth0 {
    format_up = "LAN: %ip"
    format_down = "LAN: down"
}

wireless wlan0 {
    format_up = "WLAN: %essid %ip"
    format_down = "WLAN: down"
}

time {
    format = "%Y-%m-%d %H:%M:%S"
}
EOL

# Konfiguration von URxvt (Transparenz und Aussehen)
echo "Konfiguration für URxvt wird erstellt..."
cat <<EOL > ~/.Xresources
# URxvt-Konfiguration
URxvt*transparent: true
URxvt*shading: 90
URxvt*background: rgba:0000/0000/0000/0000  # Transparenz aktivieren
URxvt*foreground: #d0d0d0  # Textfarbe
URxvt*font: xft:DejaVu Sans Mono:size=10
URxvt*boldFont: xft:DejaVu Sans Mono:bold:size=10
URxvt*scrollBar: false
URxvt*saveLines: 10000
URxvt*cursorBlink: true
EOL

# i3status-Konfiguration für die Statusleiste erstellen
echo "i3status-Konfiguration wird erstellt..."
mkdir -p ~/.config/i3status
cat <<EOL > ~/.config/i3status/config
general {
    output_format = "i3bar"
    colors = true
    interval = 5
}

order += "cpu_usage"
order += "load"
order += "disk /"
order += "volume master"
order += "battery 0"
order += "ethernet eth0"
order += "wireless wlan0"
order += "time"

cpu_usage {
    format = "CPU: %usage%%"
}

load {
    format = "Load: %1min"
}

disk "/" {
    format = "Disk: %avail"
}

volume master {
    format = "Volume: %volume"
}

battery 0 {
    format = "Battery: %status %percentage"
}

ethernet eth0 {
    format_up = "LAN: %ip"
    format_down = "LAN: down"
}

wireless wlan0 {
    format_up = "WLAN: %essid %ip"
    format_down = "WLAN: down"
}

time {
    format = "%Y-%m-%d %H:%M:%S"
}
EOL

# Fertigmeldung
echo "Installation und Grundkonfiguration von i3wm, URxvt und Bluetooth abgeschlossen!"
echo "Melde dich ab und wähle beim Login 'i3' als Sitzungsmanager aus."

