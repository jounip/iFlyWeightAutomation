$cg = "25.4%"
$zfw = "54256 kg"
$cargo = "1025 kg"
$passangers = "109"
$fuel = "1200 kg"
$total = "56456 kg"

$print = "Passangers:" & @TAB & $passangers & @CRLF & "Cargo:" & @TAB & @TAB & $cargo & @CRLF & "ZFW:" & @TAB & @TAB & $zfw & @CRLF & "Fuel:" & @TAB & @TAB & $fuel  & @CRLF & "Total:" & @TAB & @TAB & $total& @CRLF & "CG:" & @TAB & @TAB & $cg

msgbox(1, "Weight info", $print )


