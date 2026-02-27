chmod +x cman

sudo cp cman /bin

mkdir ~/.config/sway

cp config ~/.config/sway

mkdir ~/.config/nvim

cp init.lua ~/.config/nvim

mkdir ~/.config/alacritty

cp alacritty.toml ~/.config/alacritty

mkdir ~/.config/wofi

cp style.css ~/.config/wofi

cd ~

mkdir config_backups

mv .bashrc config_backups

cd arch_backup

cp .bashrc ~

cp .vimrc ~
