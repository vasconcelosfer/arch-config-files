#!/bin/bash

# Colores para la terminal
GREEN='\033[0;32m'
NC='\033[0m'

echo -e "${GREEN}--- Instalador de Paquetes para vasconcelosfer ---${NC}"

# 1. Definir categorías y paquetes
declare -A CATEGORIES
CATEGORIES["Base_Hyprland"]="hyprland hyprlock hypridle hyprpaper hyprpanel-git xdg-desktop-portal-hyprland polkit-gnome"
CATEGORIES["Audio_Pipewire"]="pipewire pipewire-pulse pipewire-alsa pipewire-jack wireplumber"
CATEGORIES["Drivers_Intel_Dell"]="intel-ucode mesa libva-intel-driver intel-media-driver thermald upower"
CATEGORIES["Drivers_AMD_Desktop"]="amd-ucode mesa vulkan-radeon libva-mesa-driver"
CATEGORIES["Terminal_y_ZSH"]="kitty zsh starship eza zsh-syntax-highlighting zsh-autosuggestions"
CATEGORIES["Fuentes_Iconos"]="ttf-jetbrains-mono-nerd ttf-font-awesome noto-fonts-emoji"
CATEGORIES["Utilidades_GUI"]="nwg-look wlogout rofi-lbonn-wayland-git dunst grim slurp swappy thunar gvfs tumbler"
CATEGORIES["Red_y_Seguridad"]="networkmanager nm-connection-editor gnome-keyring bluez bluez-utils"

# 2. Función para elegir
echo "Seleccioná qué categorías querés instalar (separadas por espacio):"
echo "1) Base Hyprland        5) Terminal y ZSH"
echo "2) Audio Pipewire       6) Fuentes e Iconos"
echo "3) Drivers Intel (Dell)  7) Utilidades GUI"
echo "4) Drivers AMD (Desktop) 8) Red y Seguridad"
echo "9) INSTALAR TODO"

read -p "Opción(es): " choice

TO_INSTALL=""

for i in $choice; do
    case $i in
        1) TO_INSTALL+="${CATEGORIES["Base_Hyprland"]} ";;
        2) TO_INSTALL+="${CATEGORIES["Audio_Pipewire"]} ";;
        3) TO_INSTALL+="${CATEGORIES["Drivers_Intel_Dell"]} ";;
        4) TO_INSTALL+="${CATEGORIES["Drivers_AMD_Desktop"]} ";;
        5) TO_INSTALL+="${CATEGORIES["Terminal_y_ZSH"]} ";;
        6) TO_INSTALL+="${CATEGORIES["Fuentes_Iconos"]} ";;
        7) TO_INSTALL+="${CATEGORIES["Utilidades_GUI"]} ";;
        8) TO_INSTALL+="${CATEGORIES["Red_y_Seguridad"]} ";;
        9) TO_INSTALL="${CATEGORIES[@]}"; break;;
    esac
done

# 3. Instalación
if [ -z "$TO_INSTALL" ]; then
    echo "No seleccionaste nada. Saliendo..."
else
    echo -e "${GREEN}Instalando los siguientes paquetes:${NC}"
    echo $TO_INSTALL | tr ' ' '\n'
    
    # Primero intentamos con pacman, si falla algun -git, el usuario deberá usar yay
    sudo pacman -S --needed $TO_INSTALL
    
    # Verificar si yay está instalado para los paquetes del AUR
    if command -v yay &> /dev/null; then
        yay -S --needed $TO_INSTALL
    else
        echo "Nota: Algunos paquetes (como hyprpanel) son del AUR. Instalalos con yay luego."
    fi
fi
