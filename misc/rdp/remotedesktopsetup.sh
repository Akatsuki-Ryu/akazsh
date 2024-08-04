sudo apt install xfce4 xfce4-goodies -y
sudo apt install xrdp -y
sudo systemctl start xrdp
sudo adduser xrdp ssl-cert
cp .xsessionrc ~/
