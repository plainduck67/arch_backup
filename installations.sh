set -e
echo "Updating system..."

sudo pacman -Syu --noconfirm

echo "Installing packages..."

sudo pacman -S --needed --noconfirm - < pkglist.txt

echo "Enabling NetworkManager..."

sudo systemctl enable NetworkManager.service

echo "Enabling Bluetooth..."

sudo systemctl enable bluetooth.service

echo "Setup complete."
