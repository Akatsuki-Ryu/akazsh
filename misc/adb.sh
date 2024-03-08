sudo pkill -f Adobe*
sudo pkill -f CCX*
sudo pkill -f CCL*
sudo pkill -f CCF*

cd /Library/Application\ Support/Adobe
rm -r SLCache*
rm -r SLStore*
cd ~/Library/Application\ Support/Adobe/
rm -r OOBE
cd ~/Library/Saved\ Application\ State
rm -r com.adobe*
cd /Library/Caches/
rm -r .*
cd ~/Library/Preferences/Adobe
rm -r .*
