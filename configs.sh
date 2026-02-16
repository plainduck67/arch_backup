chmod +x cman

sudo cp cman /bin

cp Ashfall.profile ~/.local/share/konsole/

cp Ashfall.colorscheme ~/.local/share/konsole/

cd ~

mkdir config_backups

mv .bashrc config_backups

cd arch_backup

cp .bashrc ~

cp .vimrc ~
