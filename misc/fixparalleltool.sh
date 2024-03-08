#install parallels tools with fix to linux kernel 5
mkdir -p ~/Desktop/parallels_fixed/
cp -r /media/cdrom/* ~/Desktop/parallels_fixed/
cd ~/Desktop/parallels_fixed/kmods/
sudo tar xvf prl_mod.tar.gz
sed -e 's/MS_/SB_/g' -i prl_fs/SharedFolders/Guest/Linux/prl_fs/super.c
sudo rm prl_mod.tar.gz
sudo tar cvf prl_mod.tar.gz . dkms.conf Makefile.kmods
cd ../
./install-gui