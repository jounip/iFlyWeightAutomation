#include <GuiComboBox.au3>
#include <StringConstants.au3>
#include <MsgBoxConstants.au3>

; CHANGE FROM HERE TO SUIT YOUR NEEDS
; CHANGE FROM HERE TO SUIT YOUR NEEDS
; CHANGE FROM HERE TO SUIT YOUR NEEDS
; CHANGE FROM HERE TO SUIT YOUR NEEDS

;Path and executable to config Tool
$path = "E:\P3DV3\iFly\737NG\Tool\"
$exe = "E:\P3DV3\iFly\737NG\Tool\ConfigTool.exe"

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
$updatewintext = "Done"

$combo = "[CLASS:ComboBox;INSTANCE:1]"
$random_button = "[CLASS:Button;INSTANCE:4]"
$exit_button = "[CLASS:Button;INSTANCE:2]"
$update_button = "[CLASS:Button;INSTANCE:1]"

$update_done_button = "[CLASS:Button;INSTANCE:1]"

$cg_static = "[CLASS:Static;INSTANCE:26]"
$zfw_static = "[CLASS:Static;INSTANCE:30]"


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
ControlSend($title, "",$combo,'{Down}')
ControlSend($title, "",$combo,'{Down}')
ControlSend($title, "",$combo,'{Down}')

;load fuel
ControlClick ( $title, "", $fuel_left,"Left",2)
ControlSend($title, "",$fuel_left,$fuel_lr_percentage)

ControlClick ( $title, "", $fuel_right,"Left",2)
ControlSend($title, "",$fuel_right,$fuel_lr_percentage)

ControlClick ( $title, "", $fuel_center,"Left",2)
ControlSend($title, "",$fuel_center,$fuel_center_percentage)

;Randomize load
Do
	ControlClick ( $title, "", $random_button)
	$error = WinGetText ( $title, "Warning:" )
Until $error = False

;Find CG
$cg = ControlGetText( $title, "", $cg_static )

;Find ZFW
$zfw = ControlGetText( $title, "", $zfw_static )

; Update the config
ControlClick ( $title, "", $update_button)

; wait for dialog
WinWaitActive($title_update, "")

; Click ok
ControlClick ( $title_update, "", $update_done_button)

;Wait until config tool window active again
WinWaitActive($title,$wintext)

; Exit the config tool
ControlClick ( $title, "", $exit_button)

MsgBox($MB_SYSTEMMODAL, "CG", $cg)
MsgBox($MB_SYSTEMMODAL, "ZFW", $zfw)
