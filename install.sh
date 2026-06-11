#!/bin/bash

set -e

echo "===================================="
echo "         PACUDOTS INSTALLER"
echo "===================================="

# -----------------------------------
# UPDATE SYSTEM
# -----------------------------------

echo ""
echo "[1/8] Actualizando sistema..."

sudo pacman -Syu --noconfirm

# -----------------------------------
# PACMAN PACKAGES
# -----------------------------------

echo ""
echo "[2/8] Instalando paquetes oficiales..."

sudo pacman -S --needed --noconfirm \
  hyprland \
  waybar \
  rofi \
  kitty \
  neovim \
  zsh \
  firefox \
  thunar \
  thunar-archive-plugin \
  file-roller \
  fastfetch \
  cava \
  yazi \
  git \
  base-devel \
  stow \
  starship \
  mpv \
  obs-studio \
  pipewire \
  wireplumber \
  pavucontrol \
  bluez \
  bluez-utils \
  brightnessctl \
  grim \
  slurp \
  wl-clipboard \
  xdg-desktop-portal-hyprland \
  xdg-desktop-portal \
  polkit \
  nwg-look \
  gtk3 \
  gtk4 \
  qt5ct \
  qt6ct \
  ttf-jetbrains-mono-nerd \
  ttf-nerd-fonts-symbols \
  ttf-font-awesome \
  noto-fonts \
  noto-fonts-cjk \
  noto-fonts-emoji \
  playerctl \
  network-manager-applet \
  unzip \
  zip \
  wget \
  curl \
  hyprlock \
  hypridle \
  sddm

# -----------------------------------
# ENABLE SERVICES
# -----------------------------------

echo ""
echo "[3/8] Activando servicios..."

sudo systemctl enable bluetooth
sudo systemctl enable NetworkManager
sudo systemctl enable sddm

# -----------------------------------
# INSTALL PARU
# -----------------------------------

echo ""
echo "[4/8] Verificando paru..."

if ! command -v paru &>/dev/null; then
  echo "paru no encontrado. Instalando..."

  git clone https://aur.archlinux.org/paru.git /tmp/paru

  cd /tmp/paru

  makepkg -si --noconfirm

  cd ~

  rm -rf /tmp/paru
else
  echo "paru ya está instalado."
fi

# -----------------------------------
# AUR PACKAGES
# -----------------------------------

echo ""
echo "[5/8] Instalando paquetes AUR..."

paru -S --needed --noconfirm \
  localsend-bin \
  spotify \
  cohesion \
  bibata-cursor-theme-bin

# -----------------------------------
# CREATE IMPORTANT FOLDERS
# -----------------------------------

echo ""
echo "[6/8] Creando carpetas..."

mkdir -p ~/.config
mkdir -p ~/Downloads
mkdir -p ~/Documents

# -----------------------------------
# BACKUP OLD CONFIGS
# -----------------------------------

echo ""
echo "[7/8] Respaldando configs viejas..."

CONFIG_DIRS=(
  hypr
  kitty
  waybar
  rofi
  nvim
  cava
  yazi
  wlogout
  xfce4
  xsettingsd
  Thunar
  nwg-look
  gtk-3.0
  gtk-4.0
  fastfetch
  btop
)

for dir in "${CONFIG_DIRS[@]}"; do
  TARGET="$HOME/.config/$dir"

  if [ -e "$TARGET" ] && [ ! -L "$TARGET" ]; then
    echo "Backup -> $dir"
    mv "$TARGET" "$TARGET.backup"
  fi
done

# files
FILES=(
  mimeapps.list
  starship.toml
)

for file in "${FILES[@]}"; do
  TARGET="$HOME/.config/$file"

  if [ -f "$TARGET" ] && [ ! -L "$TARGET" ]; then
    echo "Backup -> $file"
    mv "$TARGET" "$TARGET.backup"
  fi
done

# -----------------------------------
# APPLY DOTFILES
# -----------------------------------

echo ""
echo "[8/8] Aplicando dotfiles..."

cd "$(dirname "$0")"

MODULES=(
  hypr
  kitty
  waybar
  rofi
  nvim
  cava
  yazi
  wlogout
  xfce4
  xsettingsd
  Thunar
  starship
  mimeapps
  nwg-look
  gtk
  fastfetch
)

for module in "${MODULES[@]}"; do
  echo "stow -> $module"
  stow "$module"
done

# -----------------------------------
# OPTIONAL MODULES
# -----------------------------------

# stow wallpapers
# stow sddm
# stow grub

# -----------------------------------
# ZSH DEFAULT SHELL
# -----------------------------------

if [ "$SHELL" != "/bin/zsh" ]; then
  echo ""
  echo "Cambiando shell a zsh..."
  chsh -s /bin/zsh
fi

# -----------------------------------
# FINISH
# -----------------------------------

echo ""
echo "===================================="
echo "      INSTALACIÓN COMPLETADA"
echo "===================================="
echo ""
echo "IMPORTANTE:"
echo "- Reiniciá la PC"
echo "- Logueate nuevamente"
echo "- Abrí nvim una vez"
echo "- Abrí Spotify una vez"
echo ""
echo "Disfrutá PACUDOTS."
