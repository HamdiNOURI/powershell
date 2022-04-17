cls
write-host  "############################################################################"
write-host  "##############	   DEVELOPPED SCRIPT TO MANAGE AZURE ACCOUNT    ##############"
write-host  "############################################################################"





###############################################
############ BLOC DE VARIABLES LOCAL
###############################################
$MyDate=Get-Date -Format "yyyyMMdd"
# [int]$global:BuildNum = $ENV:BUILD_ID
# $DirPath="$ENV:WORKSPACE"   	

[int]$global:BuildNum = $args[1]
$DirPath = $args[0] 
# $DirPath="C:\Jenkins\workspace\Gestion-Compte-Azure"
write-host "Le build Num est : $BuildNum"
write-host "Le path est : $DirPath"

<#
###############################################
############ BLOC DE VARIABLES LOCAL
###############################################
$UsersListFile = "$DirPath\New\Liste_user.csv"
[int]$mode = ((Get-Content $UsersListFile)[0]).split(",").count

###################################################################################################################
function CreateAzureUser($UsersListFile) {
	$UsersToCreate = Import-CSV -Path $UsersListFile
	write-host "$UsersListFile" 
	ForEach ($User In $UsersToCreate) {
		Write-Host $($User.DisplayName + " | " + $User.GivenName + " | " )
		Start-Sleep -s 1
		<#
		CODE TO BE PAST HERE
		
	}
}
function UpdateAzureUserRights($UsersToAddRights) {
	$UsersToAddRights = Import-CSV -Path $UsersListFile
	write-host "$UsersListFile" 
	ForEach ($User In $UsersToCreate) {
		Write-Host $($User.UserPrincipalName)
		Start-Sleep -s 1
		<#
		CODE TO BE PAST HERE
		
	}
}
function KeepingFile{
	$command = "Rename-Item -Path `"$DirPath\New\Liste_user.csv`" `"$DirPath\New\$MyDate-$BuildNum`_Liste_user.csv`" "
	Invoke-Expression -Command $command
	$command2 = " Move-Item -Path `"$DirPath\New\$MyDate-$BuildNum`_Liste_user.csv`" -Destination `"$DirPath\OldExec`" -PassThru "
	Invoke-Expression -Command $command2
}



if ( $mode -eq 4 ) { 
	write-host " CALLING CREATION FUNCTION !! "
	CreateAzureUser($UsersListFile)
	KeepingFile($UsersListFile)
}
ElseIf ( $mode -eq 2 ) { 
	write-host " CALLING UPDATE FUNCTION !! "
	UpdateAzureUserRights($UsersToAddRights)
	KeepingFile($UsersListFile)
}
Else {
	write-host " WRONG FILE UPLOADED "
}
#>