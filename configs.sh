chmod +x cman

sudo cp cman /bin

mkdir ~/.config/alacritty

cp alacritty.toml ~/.config/alacritty

cd ~

mkdir config_backups

mv .bashrc config_backups

cd arch_backup

cp .bashrc ~

cp .vimrc ~
