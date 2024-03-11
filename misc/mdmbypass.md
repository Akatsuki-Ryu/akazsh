update 2024-03-11

use this url to bypass mdm
https://skipmdm.com

there is a code also in this folder you can run. find in mdmbypass2.sh

reference

https://gist.github.com/sghiassy/a3927405cf4ffe81242f4ecb01c382ac?permalink_comment_id=4591775

# Disable Device Enrollment Notification on Mac.md

## Restart the Mac in Recovery Mode by holding `Comment-R` during restart

#### Open Terminal in the recovery screen and type

```
csrutil disable
```

Restart computer

## Edit `com.apple.ManagedClient.enroll.plist`

In the terminal, type

```
sudo open /Applications/TextEdit.app /System/Library/LaunchDaemons/com.apple.ManagedClient.enroll.plist
```

change

```
<key>com.apple.ManagedClient.enroll</key>
        <true/>
```

to

```
<key>com.apple.ManagedClient.enroll</key>
        <false/>
```

### Restart Computer again.

So that the changes take effect

### Disable annoying Remote Management Pop-Up after upgrading to macOS Sonoma (14)

Apple further added a new gate preventing people from using their DEP-enabled Macs without installing the profiles in macOS Sonoma. After upgrading from a fully-working Ventura copy (with MDM servers blocked in hosts) to macOS Sonoma DP 1, your Mac will want to give you a pop-up window every 10 mins reminding you to install a DEP profile. Did some experiments and I think Apple is secretly pinging their MDM servers no matter you have an active profile associated w/ SN or not. As long as the servers are not reachable they will annoy you with their new pop-up system.

The Workaround
(1) Disable SIP in 1 True Recovery

(2)

```
sudo rm /var/db/ConfigurationProfiles/Settings/.cloudConfigHasActivationRecord

sudo rm /var/db/ConfigurationProfiles/Settings/.cloudConfigRecordFound

sudo touch /var/db/ConfigurationProfiles/Settings/.cloudConfigProfileInstalled

sudo touch /var/db/ConfigurationProfiles/Settings/.cloudConfigRecordNotFound

```

(3) you're all set. enjoy this boring upgrade
