sudo pkill -f Adobe*
sudo pkill -f CCX*
sudo pkill -f CCL*
sudo pkill -f CCF*

cd /Library/Application\ Support/Adobe || exit
rm -r SLCache*
rm -r SLStore*
cd ~/Library/Application\ Support/Adobe/ || exit
rm -r OOBE
cd ~/Library/Saved\ Application\ State || exit
rm -r com.adobe*
cd /Library/Caches/ || exit
rm -r .*
cd ~/Library/Preferences/Adobe || exit
rm -r .*
