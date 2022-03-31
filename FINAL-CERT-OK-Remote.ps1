write-host  "############################################################################"
write-host  "##############	   DEVELOPPED SCRIPT TO Manage certificate    ##############"
write-host  "############################################################################"

Invoke-Command -ComputerName Super-serv -ScriptBlock {
###############################################
############ BLOC DE VARIABLES 
###############################################
$MyDate=Get-Date -Format "yyyyMMdd"
# write-host  "$MyDate"
$DirPath='F:\ProjCert'   														### To Be Updated with the Good Path
$TempPath='F:\ProjCert\Template'   												### To Be Updated with the Good Path
####################################################################################################################


# $CN = Read-Host -Prompt 'Input The CN '   										#####Should not be Empty
# $FreindlyName = Read-Host -Prompt 'Input The Freindly Name '   					#####Should not be Empty
# $DNS = Read-Host -Prompt 'Input The DNS '   									#####Should not be Empty
# $KeyPass = Read-Host -Prompt 'Input The Password '   							#####Should not be Empty
# $SAN=True|False  																### Menue deroulant

$CN = $env:CN     									#####Should not be Empty
$FreindlyName = $env:FreindlyName    				#####Should not be Empty
$DNS = $env:DNS  									#####Should not be Empty
$KeyPass = $env:Password  							#####Should not be Empty
# $SAN=True|False  																### Menue deroulant



###############################################
############ CREATION DE REPERTOIR
###############################################
New-Item -Path "$DirPath\$MyDate-$ENV:BUILD_NUMBER" -ItemType Directory

###############################################
############ COPIE DE LA TEMPLATE DANS LE REP
###############################################
Copy-Item -Path "$TempPath\template_req.inf" -Destination "$DirPath\$MyDate-$ENV:BUILD_NUMBER\req.inf"

###############################################
############ EDITER LA TEMPLATE DANS LE REP
###############################################

$CNToModify = 6
$ColumnCN = 14
$File="$DirPath\$MyDate-$ENV:BUILD_NUMBER\req.inf"
(
  Get-Content $File | ForEach-Object {
    $Line = $_.ReadCount
    if($Line -eq $CNToModify) {
      $_.Insert($ColumnCN, "$CN") } 
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
      $_.Insert($ColumnFN, "$FreindlyName") } 
    else {
      $_
    }
  } 
) | Set-Content $File
###############################
try 
{ 
	Do{
		$length = $DNS.length
		$montest = $DNS.LastIndexOf("%")
		# write-host "$montest"
		$var = $DNS.substring($length -($length-$DNS.LastIndexOf("%"))+1)
		# write-host "$var"
		$DNS = $DNS.substring(0, $DNS.LastIndexOf("%"))
		$TotalVar = "_continue_ = `"$var`""
		write-host "$TotalVar"
		ADD-content -path $File -value "$TotalVar"
		# Add-Content -Value "c:\Users\Administrator\Desktop\`"foobar.exe`"" 
	}Until($montest -eq -1)
}
catch  
	{

		write-host " te7cha "
	}
}