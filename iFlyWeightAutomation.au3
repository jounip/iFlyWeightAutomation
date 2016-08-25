
#include <GuiComboBox.au3>
#include <StringConstants.au3>
#include <MsgBoxConstants.au3>
#include <File.au3>

; CHANGE FROM HERE TO SUIT YOUR NEEDS
; CHANGE FROM HERE TO SUIT YOUR NEEDS
; CHANGE FROM HERE TO SUIT YOUR NEEDS
; CHANGE FROM HERE TO SUIT YOUR NEEDS

;Path and executable to config Tool
$path = "E:\P3DV3\iFly\737NG\Tool\"
$exe = "E:\P3DV3\iFly\737NG\Tool\ConfigTool.exe"

;temporary txt file for printing
$temp_filename = "iflyweights.txt"

;load full tanks to left and right and keep center tank empty
;TODO, dialog to ask how much fuel is loaded

$fuel_lr_percentage = "100"
$fuel_center_percentage = "0"

; DO NOT CHANGE ANYTHING BELOW ON NORMAL USAGE
; DO NOT CHANGE ANYTHING BELOW ON NORMAL USAGE
; DO NOT CHANGE ANYTHING BELOW ON NORMAL USAGE
; DO NOT CHANGE ANYTHING BELOW ON NORMAL USAGE

$title = "ConfigTool for Prepar3D"
$wintext = "Select Aircraft Model"

$title_update = "ConfigTool"
$wintext_update = "Done"

$combo = "[CLASS:ComboBox;INSTANCE:1]"
$random_button = "[CLASS:Button;INSTANCE:4]"
$exit_button = "[CLASS:Button;INSTANCE:2]"
$update_button = "[CLASS:Button;INSTANCE:1]"

$update_done_button = "[CLASS:Button;INSTANCE:1]"

$pax_static = "[CLASS:Static;INSTANCE:28]"
$cargo_static = "[CLASS:Static;INSTANCE:29]"
$zfw_static = "[CLASS:Static;INSTANCE:30]"
$fuel_static = "[CLASS:Static;INSTANCE:45]"
$gross_static = "[CLASS:Static;INSTANCE:48]"
$cg_static = "[CLASS:Static;INSTANCE:26]"

$fuel_left ="[CLASS:Edit;INSTANCE:1]"
$fuel_center ="[CLASS:Edit;INSTANCE:2]"
$fuel_right ="[CLASS:Edit;INSTANCE:3]"



;Start the config tool
Run($exe,$path)

;For testing
;WinActivate($title,$wintext)

;Wait until config tool is loaded and window active
WinWaitActive($title,$wintext)


;Press combobox 3 times to get Boeing 737-800
ControlSend($title, $wintext,$combo,'{Down}')
ControlSend($title, $wintext,$combo,'{Down}')
ControlSend($title, $wintext,$combo,'{Down}')

;load fuel
ControlClick ( $title, $wintext, $fuel_left,"Left",2)
ControlSend($title, $wintext,$fuel_left,$fuel_lr_percentage)

ControlClick ( $title, $wintext, $fuel_right,"Left",2)
ControlSend($title, $wintext,$fuel_right,$fuel_lr_percentage)

ControlClick ( $title, $wintext, $fuel_center,"Left",2)
ControlSend($title, $wintext,$fuel_center,$fuel_center_percentage)

;Randomize load
Do
	ControlClick ( $title, $wintext, $random_button)
	$error = WinGetText ( $title, "Warning:" )
Until $error = False

;Find pax
$pax = ControlGetText( $title, $wintext, $pax_static )

;Find cargo
$cargo = ControlGetText( $title, $wintext, $cargo_static )

;Find Fuel
$fuel = ControlGetText( $title, $wintext, $fuel_static )

;Find CG
$cg = ControlGetText( $title, $wintext, $cg_static )

; Compare wrights to ints for calculations
$pax_weight = StringReplace($pax," kgs","")
$cargo_weight = StringReplace($cargo," kgs","")
$fuel_weight = StringReplace($fuel," kgs","")

; basic weights
$dow_weight = "41822"
$crew_weight = "408"

; calculate pax,zfw and gross weights
$pax_only = $pax_weight-$crew_weight
$paxs = $pax_only / 91
$zfw_weight = $dow_weight + $pax_only + $cargo_weight
$gross_weight = $zfw_weight + $fuel_weight

; Update the config
ControlClick ( $title, $wintext, $update_button)

; wait for dialog
WinWaitActive($title_update, $wintext_update)

; Click ok
ControlClick ( $title_update, $wintext_update, $update_done_button)

;Wait until config tool window active again
WinWaitActive($title,$wintext)

; Exit the config tool
ControlClick ( $title, $wintext, $exit_button)

$print = "DOW:" & @TAB & $dow_weight & @CRLF & "PAX:" & @TAB & $pax_only & " (" & int($paxs) & ")" & @CRLF & "Cargo:" & @TAB & $cargo_weight & @CRLF & "ZFW:" & @TAB & $zfw_weight & @CRLF & "Fuel:" & @TAB & $fuel_weight  & @CRLF & "Total:" & @TAB & $gross_weight& @CRLF & "CG:" & @TAB & $cg

;msgbox(1, "Weight info", $print )

FileDelete($temp_filename)

$file = FileOpen($temp_filename, 1)
FileWriteLine($file, $print  )
$file_close = FileClose($file)

_FilePrint($temp_filename)
