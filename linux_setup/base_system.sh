#!/bin/bash

# --- Konfigurationsvariablen ---
# E-Mail-Konten
GMAIL_EMAIL="deineemail@gmail.com"
ICLOUD_EMAIL="deineemail@icloud.com"
GMAIL_PASSWORD="deinpasswort"
ICLOUD_PASSWORD="deinpasswort"

# --- Paketinstallationen ---
echo "System wird aktualisiert..."
sudo apt update && sudo apt upgrade -y

# Installiere grundlegende Abhängigkeiten
echo "Installiere grundlegende Abhängigkeiten..."
sudo apt install -y apt-transport-https curl ca-certificates software-properties-common unzip lsb-release tmux gnumeric abiword

# --- 1. Installiere Mutt ---
echo "Installiere Mutt..."
sudo apt install -y mutt

# --- 2. Konfiguriere Mutt für Gmail und iCloud ---
echo "Konfiguriere Mutt für Gmail und iCloud..."

cat <<EOL >> ~/.muttrc
# Gmail
set from = "$GMAIL_EMAIL"
set realname = "Dein Name"
set imap_user = "$GMAIL_EMAIL"
set imap_pass = "$GMAIL_PASSWORD"
set folder = "imaps://imap.gmail.com:993"
set spoolfile = "+INBOX"
set smtp_url = "smtp://$GMAIL_EMAIL@smtp.gmail.com:587/"
set smtp_pass = "$GMAIL_PASSWORD"

# iCloud
set from = "$ICLOUD_EMAIL"
set realname = "Dein Name"
set imap_user = "$ICLOUD_EMAIL"
set imap_pass = "$ICLOUD_PASSWORD"
set folder = "imaps://imap.mail.me.com:993"
set spoolfile = "+INBOX"
set smtp_url = "smtp://$ICLOUD_EMAIL@smtp.mail.me.com:587/"
set smtp_pass = "$ICLOUD_PASSWORD"
EOL

# --- 3. Installiere tmux ---
echo "Installiere tmux..."
sudo apt install -y tmux

# --- 4. Installiere Docker ---
echo "Installiere Docker..."
sudo apt install -y docker.io
sudo systemctl enable --now docker

# Füge den aktuellen Benutzer zur Docker-Gruppe hinzu
echo "Füge den Benutzer zur Docker-Gruppe hinzu..."
sudo usermod -aG docker $USER

# --- 5. Installiere Docker Compose ---
echo "Installiere Docker Compose..."
sudo curl -L "https://github.com/docker/compose/releases/download/$(curl -s https://api.github.com/repos/docker/compose/releases/latest | jq -r .tag_name)/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# --- 6. Installiere Sublime Text ---
echo "Installiere Sublime Text..."
curl -fsSL https://download.sublimetext.com/sublimehq-pub.gpg | sudo gpg --dearmor -o /usr/share/keyrings/sublimehq-archive.gpg
echo "deb [signed-by=/usr/share/keyrings/sublimehq-archive.gpg] https://download.sublimetext.com/apt/stable/ all main" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt update
sudo apt install -y sublime-text

# --- 7. Installiere Brave Browser ---
echo "Installiere Brave Browser..."
curl -fsSL https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install -y brave-browser

# --- 8. Installiere Python 3 und Pip ---
echo "Installiere Python 3 und Pip..."
sudo apt install -y python3 python3-pip

# --- 9. Installiere PHP ---
echo "Installiere PHP..."
sudo add-apt-repository ppa:ondrej/php -y
sudo apt update
sudo apt install -y php8.2 php8.2-cli php8.2-mbstring php8.2-xml php8.2-zip php8.2-curl php8.2-mysql

# --- 10. Installiere Composer ---
echo "Installiere Composer..."
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

# --- 11. Installiere FileZilla ---
echo "Installiere FileZilla..."
sudo apt install -y filezilla

# --- 12. Installiere SQLite ---
echo "Installiere SQLite..."
sudo apt install -y sqlite3 libsqlite3-dev

# --- 13. Installiere Newsboat ---
echo "Installiere Newsboat..."
sudo apt install -y newsboat

# --- 14. Installiere FFmpeg ---
echo "Installiere FFmpeg..."
sudo apt install -y ffmpeg

# --- 15. Installiere Zathura ---
echo "Installiere Zathura..."
sudo apt install -y zathura zathura-pdf-poppler

# --- 16. Installiere GIMP ---
echo "Installiere GIMP..."
sudo apt install -y gimp

# --- 17. Installiere Vim ---
echo "Installiere Vim..."
sudo apt install -y vim

# --- 18. Installiere Neovim ---
echo "Installiere Neovim..."
sudo apt install -y neovim

# --- 19. Installiere rsync ---
echo "Installiere rsync..."
sudo apt install -y rsync

# --- 20. Installiere GnuPG ---
echo "Installiere GnuPG..."
sudo apt install -y gnupg

# --- 21. Installiere GNU Backgammon ---
echo "Installiere GNU Backgammon..."
sudo apt install -y gnubg

# --- 22. Installiere tree ---
echo "Installiere tree..."
sudo apt install -y tree

# --- 23. Installiere curl und wget ---
echo "Installiere curl und wget..."
sudo apt install -y curl wget

# --- 24. Installiere net-tools ---
echo "Installiere net-tools..."
sudo apt install -y net-tools

# --- 25. Installiere htop ---
echo "Installiere htop..."
sudo apt install -y htop

# --- OpenVPN Konfiguration ---
echo "OpenVPN-Konfiguration wird geladen..."
if [ -f "$OPENVPN_CONFIG_PATH" ]; then
    sudo openvpn --config "$OPENVPN_CONFIG_PATH" &
    echo "OpenVPN läuft mit der Konfiguration: $OPENVPN_CONFIG_PATH"
else
    echo "Die OpenVPN-Konfigurationsdatei wurde nicht gefunden! Bitte überprüfen Sie den Pfad."
fi

# Abschließende Meldung
echo "Alle Programme wurden erfolgreich installiert!"
echo "Denken Sie daran, OpenVPN nach der Installation zu testen."
