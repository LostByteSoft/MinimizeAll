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
	SetEnv, version, Version 2018-05-10-1130
	SetEnv, Author, LostByteSoft
	SetEnv, icofolder, C:\Program Files\Common Files
	Setenv, logoicon, ico_min.ico
	SetEnv, pause, 0
	SetEnv, debug, 0
	SetEnv, delay, 120
	SetEnv, exitaftermin, 0
	SetEnv, variables,delay=%delay% exitaftermin=%exitaftermin%

	;; specific files
	FileInstall, MinimizeAll.ini, MinimizeAll.ini,0
	FileInstall, ico_txt.ico, %icofolder%\ico_txt.ico, 0
	FileInstall, ico_min.ico, %icofolder%\ico_min.ico, 0

	;; Common ico
	FileInstall, SharedIcons\ico_about.ico, %icofolder%\ico_about.ico, 0
	FileInstall, SharedIcons\ico_lock.ico, %icofolder%\ico_lock.ico, 0
	FileInstall, SharedIcons\ico_options.ico, %icofolder%\ico_options.ico, 0
	FileInstall, SharedIcons\ico_reboot.ico, %icofolder%\ico_reboot.ico, 0
	FileInstall, SharedIcons\ico_shut.ico, %icofolder%\ico_shut.ico, 0
	FileInstall, SharedIcons\ico_debug.ico, %icofolder%\ico_debug.ico, 0
	FileInstall, SharedIcons\ico_HotKeys.ico, %icofolder%\ico_HotKeys.ico, 0
	FileInstall, SharedIcons\ico_pause.ico, %icofolder%\ico_pause.ico, 0
	FileInstall, SharedIcons\ico_loupe.ico, %icofolder%\ico_loupe.ico, 0
	FileInstall, SharedIcons\ico_folder.ico, %icofolder%\ico_folder.ico, 0

	IniRead, exitaftermin, MinimizeAll.ini, options, exitaftermin
	IniRead, delay, MinimizeAll.ini, options, delay

;;--- Menu Tray options ---

	Menu, Tray, NoStandard
	Menu, tray, add, ---=== %title% ===---, about
	Menu, Tray, Icon, ---=== %title% ===---, %icofolder%\%logoicon%
	Menu, tray, add, Show logo, GuiLogo
	Menu, tray, add, Secret MsgBox, secret					; Secret MsgBox, just show all options and variables of the program.
	Menu, Tray, Icon, Secret MsgBox, %icofolder%\ico_lock.ico
	Menu, tray, add, About && ReadMe, author				; infos about author
	Menu, Tray, Icon, About && ReadMe, %icofolder%\ico_about.ico
	Menu, tray, add, Author %author%, about					; author msg box
	menu, tray, disable, Author %author%
	Menu, tray, add, %version%, about					; version of the software
	menu, tray, disable, %version%
	Menu, tray, add, Open project web page, webpage				; open web page project
	Menu, Tray, Icon, Open project web page, %icofolder%\ico_HotKeys.ico
	Menu, tray, add,
	Menu, tray, add, --== Control ==--, about
	Menu, Tray, Icon, --== Control ==--, %icofolder%\ico_options.ico
	;menu, tray, add, Show Gui (Same as click), msgbox2			; Default gui open
	;Menu, Tray, Icon, Show Gui (Same as click), %icofolder%\ico_loupe.ico
	;Menu, Tray, Default, Show Gui (Same as click)
	;Menu, Tray, Click, 1
	Menu, tray, add, Set Debug (Toggle), debug				; debug msg
	Menu, Tray, Icon, Set Debug (Toggle), %icofolder%\ico_debug.ico
	Menu, tray, add, Open A_WorkingDir, A_WorkingDir			; open where the exe is
	Menu, Tray, Icon, Open A_WorkingDir, %icofolder%\ico_folder.ico
	Menu, tray, add, Open Source, Source
	Menu, Tray, Icon, Open Source, %icofolder%\ico_txt.ico
	Menu, tray, add,
	Menu, tray, add, Exit %title%, ExitApp					; Close exit program
	Menu, Tray, Icon, Exit %title%, %icofolder%\ico_shut.ico
	Menu, tray, add, Refresh (Ini mod), doReload 				; Reload the script.
	Menu, Tray, Icon, Refresh (Ini mod), %icofolder%\ico_reboot.ico
	Menu, tray, add, Pause (Toggle), pause					; pause the script
	Menu, Tray, Icon, Pause (Toggle), %icofolder%\ico_pause.ico
	Menu, tray, add,
	Menu, tray, add, --== Options ==--, about
	Menu, Tray, Icon, --== Options ==--, %icofolder%\ico_options.ico
	Menu, tray, add, Open MinimizeAll.ini, ini
	Menu, Tray, Icon, Open MinimizeAll.ini, %icofolder%\ico_txt.ico
	Menu, tray, add,
	Menu, tray, add, Do it now ! F12, do
	Menu, tray, add, Un Do it !, undo
	Menu, tray, add,
	Menu, Tray, Tip, %mode%

;;--- Software start here ---

	Menu, Tray, Icon, %icofolder%\ico_min.ico

start:
	IfEqual, debug, 1, MsgBox, START: begin sleep

	t_UpTime := A_TickCount // 1000			; Elapsed seconds since start if uptime upper %delay% sec start imediately.
	IfGreater, t_UpTime, %delay%, goto, skip	; Elapsed seconds since start if uptime upper %delay% sec start imediately.
	sleep, %delay%000
	skip:
	WinMinimizeAll
	Sleep, 3000
	IfEqual, debug, 1, msgbox, %variables%
	edit:
	IfEqual, exitaftermin, 1, goto, ExitApp

loop:
	sleep, 500
F12::
doit:
	IfEqual, minim, 0, goto, do
	IfEqual, minim, 1, goto, undo

		do:
		IfEqual, debug, 1, MsgBox, F12: you press F12 DO: minim=%minim%
		WinMinimizeAll
		sleep, 1000
		Setenv, minim, 1
		goto, loop

		undo:
		IfEqual, debug, 1, MsgBox, F12: you press F12 UNDO: minim=%minim%
		WinMinimizeAllUndo
		sleep, 1000
		Setenv, minim, 0
		goto, loop

source:
	FileInstall, MinimizeAll.ahk, MinimizeAll.ahk, 1
	run, "%A_ScriptDir%\MinimizeAll.ahk"
	goto, loop

ini:
	run, "%A_ScriptDir%\MinimizeAll.ini"
	goto, edit

;;--- Quit Debug Pause ---

;; Escape::		; Debug purpose
	ExitApp

GuiClose:
	Gui, destroy
	goto, start

ExitApp:
	ExitApp

doReload:
	Reload
	sleep, 100
	goto, ExitApp

Debug:
	IfEqual, debug, 0, goto, enable
	IfEqual, debug, 1, goto, disable

		enable:
		SetEnv, debug, 1
		goto, loop

		disable:
		SetEnv, debug, 0
		goto, loop

pause:
	Ifequal, pause, 0, goto, paused
	Ifequal, pause, 1, goto, unpaused

		paused:
		Menu, Tray, Icon, %icofolder%\ico_pause.ico
		SetEnv, pause, 1
		goto, loop

		unpaused:	
		Menu, Tray, Icon, %icofolder%\%logoicon%
		SetEnv, pause, 0
		goto, loop

;;--- Tray Bar (must be at end of file) ---

about:
	TrayTip, %title%, %mode% by %Author%, 2, 2
	Return

author:
	MsgBox, 64, %title%, %title% %mode% %version% %author%. This software is usefull...`n`n`tGo to https://github.com/LostByteSoft
	Return

secret:
	msgbox, 49, %title%, title=%title% mode=%mode% version=%version% author=%author% logoicon=%logoicon% A_ScriptDir=%A_ScriptDir% Debug=%debug%`n`n%variables%
	Return

Version:
	TrayTip, %title%, %version%, 2, 2
	Return

GuiLogo:
	Gui, 4:Add, Picture, x25 y25 w400 h400, %icofolder%\%logoicon%
	Gui, 4:Show, w450 h450, %title% Logo
	Gui, 4:Color, 000000
	Sleep, 500
	Return

	4GuiClose:
	Gui 4:Cancel
	return

A_WorkingDir:
	IfEqual, debug, 1, msgbox, run, explorer.exe "%A_WorkingDir%"
	run, explorer.exe "%A_WorkingDir%"
	Return

webpage:
	run, https://github.com/LostByteSoft/%title%
	Return

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