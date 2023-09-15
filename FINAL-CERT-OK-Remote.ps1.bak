write-host  "############################################################################"
write-host  "##############	   DEVELOPPED SCRIPT TO Manage certificate    ##############"
write-host  "############################################################################"


######################################################### FOR LOCAL  EXEC
$global:BuildNum = $args[0]
$global:CN = $args[1]  									#####Should not be Empty
$global:FreindlyName = $args[2]    				#####Should not be Empty
$global:DNS = $args[3] 									#####Should not be Empty
$global:KeyPass = $args[4]  							#####Should not be Empty



######################################################### FOR LOCAL  EXEC
# $global:BuildNum = $ENV:BUILD_NUMBER
# $global:CN = $env:CN     									#####Should not be Empty
# $global:FreindlyName = $env:FreindlyName    				#####Should not be Empty
# $global:DNS = $env:DNS  									#####Should not be Empty
# $global:KeyPass = $env:Password  							#####Should not be Empty


Invoke-Command -ComputerName Super-serv -ScriptBlock {
###############################################
############ BLOC DE VARIABLES LOCAL
###############################################
$MyDate=Get-Date -Format "yyyyMMdd"
$DirPath='F:\ProjCert'   														### To Be Updated with the Good Path
$TempPath='F:\ProjCert\Template'   												### To Be Updated with the Good Path
####################################################################################################################



###############################################
############ CREATION DE REPERTOIR
###############################################
New-Item -Path "$DirPath\$MyDate-$Using:BuildNum" -ItemType Directory


###############################################
############ COPIE DE LA TEMPLATE DANS LE REP
###############################################
Copy-Item -Path "$TempPath\template_req.inf" -Destination "$DirPath\$MyDate-$Using:BuildNum\req.inf"

###############################################
############ EDITER LA TEMPLATE DANS LE REP
###############################################
$CNToModify = 6
$ColumnCN = 14
$File="$DirPath\$MyDate-$Using:BuildNum\req.inf"
(
  Get-Content $File | ForEach-Object {
    $Line = $_.ReadCount
    if($Line -eq $CNToModify) {
      $_.Insert($ColumnCN, "$Using:CN") } 
    else {
      $_
    }
  } 
) | Set-Content $File
###############################
$FNToModify = 12
$ColumnFN = 16
# $File="$DirPath\$MyDate\req.inf"
(
  Get-Content $File | ForEach-Object {
    $Line = $_.ReadCount
    if($Line -eq $FNToModify) {
      $_.Insert($ColumnFN, "$Using:FreindlyName") } 
    else {
      $_
    }
  } 
) | Set-Content $File

try 
{ 
$DNSTemp = $Using:DNS

Do{
	if (($DNSTemp.ToCharArray()) -contains '%'){
		write-host "existing separation"
	} else {
		write-host "pas de separation"
		ADD-content -path $File -value "_continue_ = `"$DNSTemp`""
	}
	$length = $DNSTemp.length
	$montest = $DNSTemp.LastIndexOf("%")
	write-host "separation trouvé : $montest"
	$var = $DNSTemp.substring($length -($length-$DNSTemp.LastIndexOf("%"))+1)
	write-host "ma variable $var"
	$DNSTemp = $DNSTemp.substring(0, $DNSTemp.LastIndexOf("%"))
	$TotalVar = "_continue_ = `"$var`&`""
	write-host "Ma variable total est $TotalVar"
	ADD-content -path $File -value "$TotalVar"
	}Until($montest -eq -1)

}
catch  
	{

		write-host "The Key Pass is $Using:KeyPass "
	}
}
	

