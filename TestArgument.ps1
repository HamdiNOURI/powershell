# $global:BuildNum = $ENV:BUILD_NUMBER
# $global:CN = $env:CN     									#####Should not be Empty
# $global:FreindlyName = $env:FreindlyName    				#####Should not be Empty





$inifilename = $args[0]
$pass = $args[1] 

write-host " the first argument is $inifilename "
write-host "the seconde argument is $pass"