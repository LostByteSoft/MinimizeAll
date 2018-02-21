;;--- Head --- Informations --- AHK ---

;;	Compatibility: Windows
;;	All files must be in same folder. Where you want.
;;	64 bit AHK version : 1.1.24.2 64 bit Unicode

;;--- Softwares Var , files , options ---

	#NoEnv
	#SingleInstance Force
	#Persistent
	SetWorkingDir, %A_ScriptDir%

	SetEnv, title, MinimizeAll
	SetEnv, mode, Minimize all F12
	SetEnv, version, Version 2018-02-21-0648
	SetEnv, Author, LostByteSoft
	SetEnv, icofolder, C:\Program Files\Common Files
	Setenv, logoicon, ico_HotKeys.ico
	SetEnv, pause, 0
	SetEnv, debug, 0
	Setenv, minim, 0
	SetEnv, delay, 120

	;; specific files

	;; Common ico

	FileInstall, ico_about.ico, %icofolder%\ico_about.ico, 0
	FileInstall, ico_lock.ico, %icofolder%\ico_lock.ico, 0
	FileInstall, ico_options.ico, %icofolder%\ico_options.ico, 0
	FileInstall, ico_reboot.ico, %icofolder%\ico_reboot.ico, 0
	FileInstall, ico_shut.ico, %icofolder%\ico_shut.ico, 0
	FileInstall, ico_debug.ico, %icofolder%\ico_debug.ico, 0
	FileInstall, ico_HotKeys.ico, %icofolder%\ico_HotKeys.ico, 0
	FileInstall, ico_pause.ico, %icofolder%\ico_pause.ico, 0

	Menu, Tray, NoStandard
	Menu, tray, add, ---=== %title% ===---, about
	Menu, Tray, Icon, ---=== %title% ===---, %icofolder%\%logoicon%
	Menu, tray, add, Show logo, GuiLogo
	Menu, tray, add, Secret MsgBox, secret					; Secret MsgBox, just show all options and variables of the program
	Menu, Tray, Icon, Secret MsgBox, %icofolder%\ico_lock.ico
	Menu, tray, add, About && ReadMe, author
	Menu, Tray, Icon, About && ReadMe, %icofolder%\ico_about.ico
	Menu, tray, add, Author %author%, about
	menu, tray, disable, Author %author%
	Menu, tray, add, %version%, about
	menu, tray, disable, %version%
	Menu, tray, add,
	Menu, tray, add, --== Control ==--, about
	Menu, Tray, Icon, --== Control ==--, %icofolder%\ico_options.ico
	Menu, tray, add, Exit %title%, ExitApp					; Close exit program
	Menu, Tray, Icon, Exit %title%, %icofolder%\ico_shut.ico
	Menu, tray, add, Refresh (ini mod), doReload 				; Reload the script.
	Menu, Tray, Icon, Refresh (ini mod), %icofolder%\ico_reboot.ico
	Menu, tray, add, Set Debug (Toggle), debug
	Menu, Tray, Icon, Set Debug (Toggle), %icofolder%\ico_debug.ico
	Menu, tray, add, Pause (Toggle), pause
	Menu, Tray, Icon, Pause (Toggle), %icofolder%\ico_pause.ico
	Menu, tray, add,
	Menu, tray, add, --= Options =--, about
	Menu, Tray, Icon, --= Options =--, %icofolder%\ico_options.ico
	Menu, tray, add, Do it now !, do
	Menu, tray, add, Undo minimize !, undo
	Menu, tray, add,
	Menu, Tray, Tip, %mode%

;;--- Software start here ---

	Menu, Tray, Icon, %icofolder%\ico_HotKeys.ico

start:
	IfEqual, debug, 1, MsgBox, START: begin sleep

	t_UpTime := A_TickCount // 1000			; Elapsed seconds since start if uptime upper %delay% sec start imediately.
	IfGreater, t_UpTime, %delay%, goto, skip	; Elapsed seconds since start if uptime upper %delay% sec start imediately.
	sleep, %delay%000
	skip:
	WinMinimizeAll
	return

loop:
F12::
	IfEqual, debug, 1, MsgBox, F12: you press F12
	IfEqual, minim, 0, goto, do
	IfEqual, minim, 1, goto, undo

	do:
	IfEqual, debug, 1, MsgBox, DO: minim=%minim%
	WinMinimizeAll
	sleep, 1000
	Setenv, minim, 1
	Return

	undo:
	IfEqual, debug, 1, MsgBox, UNDO: minim=%minim%
	WinMinimizeAllUndo
	sleep, 1000
	Setenv, minim, 0
	Return

;;--- Debug Pause ---

debug:
	IfEqual, debug, 0, goto, debug1
	IfEqual, debug, 1, goto, debug0

	debug0:
	SetEnv, debug, 0
	TrayTip, %title%, Deactivated ! debug=%debug%, 1, 2
	Goto, start

	debug1:
	SetEnv, debug, 1
	TrayTip, %title%, Activated ! debug=%debug%, 1, 2
	Goto, start

pause:
	Ifequal, pause, 0, goto, paused
	Ifequal, pause, 1, goto, unpaused

	paused:
	SetEnv, pause, 1
	goto, sleep

	unpaused:	
	Menu, Tray, Icon, %logoicon%
	SetEnv, pause, 0
	Goto, start

	sleep:
	Menu, Tray, Icon, %icofolder%\ico_pause.ico
	sleep2:
	sleep, 500000
	goto, sleep2

;;--- Quit (escape , esc)

Escape::
Close:
ExitApp:
	ExitApp

doReload:
	Reload
	sleep, 100
	goto, Close

;;--- Tray Bar (must be at end of file) ---

about:
	TrayTip, %title%, %mode% by %Author%, 2, 2
	Return

author:
	MsgBox, 64, %title%, %title% %mode% %version% %author%. This software is usefull...`n`n`tGo to https://github.com/LostByteSoft
	Return

secret:
	msgbox, 49, %title%, title=%title% mode=%mode% version=%version% author=%author% logoicon=%logoicon% A_ScriptDir=%A_ScriptDir%`n`nDebug=%debug%
	Return

Version:
	TrayTip, %title%, %version%, 2, 2
	Return

GuiLogo:
	Gui, 4:Add, Picture, x25 y25 w400 h400, %icofolder%\%logoicon%
	Gui, 4:Show, w450 h450, %title% Logo
	;;Gui, 4:Color, 000000
	Sleep, 500
	Return

	4GuiClose:
	Gui 4:Cancel
	return

;;--- End of script ---
;
;            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
;   Version 3.14159265358979323846264338327950288419716939937510582
;                          March 2017
;
; Everyone is permitted to copy and distribute verbatim or modified
; copies of this license document, and changing it is allowed as long
; as the name is changed.
;
;            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
;   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
;
;              You just DO WHAT THE FUCK YOU WANT TO.
;
;		     NO FUCKING WARRANTY AT ALL
;
;      The warranty is not included. Look carefully you
;             might miss all theses small characters.
;
;	As is customary and in compliance with current global and
;	interplanetary regulations, the author of these pages disclaims
;	all liability for the consequences of the advice given here,
;	in particular in the event of partial or total destruction of
;	the material, Loss of rights to the manufacturer's warranty,
;	electrocution, drowning, divorce, civil war, the effects of
;	radiation due to atomic fission, unexpected tax recalls or
;	    encounters with extraterrestrial beings 'elsewhere.
;
;              LostByteSoft no copyright or copyleft.
;
;	If you are unhappy with this software i do not care.
;
;;--- End of file ---  