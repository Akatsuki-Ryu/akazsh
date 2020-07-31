;Keyboard Shortcut - Win + H
 #h::
 RegRead, HiddenFiles_Status, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden 
 If HiddenFiles_Status = 2
 RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden, 1
 Else
 RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden, 2
 send {F5}
 return


 ; Launch application
 #^P::Run "C:\Program Files\My\Program.exe"
 return

 ;Disable caps lock
SetCapsLockState, AlwaysOff
return

; NumLock always enabled
SetNumlockState, AlwaysOn
return

;Repurpose function keys
F4::Run "C:\Program Files\Open\Program.exe"
return



 ;Change volume
 ^NumpadAdd:: Send {Volume_Up} ;Ctrl + NumPad Plus
 ^NumpadSub:: Send {Volume_Down} ;Shift + NumPad Minus
 break::Send {Volume_Mute} ; Break key (mute)
 return


 ;Open webpages
 F1::Run "https://windowsloop.com"
 return

 ;Open folders
 #1:: Run, Explorer "C:\Downloads" ;Win + 1
 return

 ;Right-hand Alt Tab [press CTRL + \]
Ctrl & \::AltTab
return



;;basic remapping for the keys 

;remap control to alt 
^::!
return

;remap alt to win
!::#
return

;remap win to control 
#::^
return

;remap capslock to enter
 Capslock::Enter
 return

;quit an app 
^q::!F4
return

;move windows 

;run notepad
Caplocku::Run Notepad 
return
#