echo input the computer name 
read computername

sudo scutil --set ComputerName "$computername"
sudo scutil --set LocalHostName "$computername"
sudo scutil --set HostName "$computername"

echo change password policy
sudo pwpolicy setaccountpolicies passwdpolicy.xml
passwd