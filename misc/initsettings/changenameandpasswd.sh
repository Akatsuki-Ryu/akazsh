# if this script is running in ubuntu

echo input the computer name
read computername

if [ "$(uname)" == "Darwin" ]; then
  echo running in macos
  sudo scutil --set ComputerName "$computername"
  sudo scutil --set LocalHostName "$computername"
  sudo scutil --set HostName "$computername"

  echo change password policy
  sudo pwpolicy setaccountpolicies passwdpolicy.xml
  passwd
  echo also change the keychain password
  security set-keychain-password
  exit 1
elif [ "$(uname)" == "Linux"]; then
  echo running in linux
  sudo hostnamectl set-hostname "$computername"
fi
