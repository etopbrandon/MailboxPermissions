<#Email permission tool with AutoMapping#>

$User = Read-Host "Please enter the email of the user who needs the mailbox"
$Identity = Read-Host "Please enter the email of the mailbox this user needs access to"
Write-Host "Permission Levels:" -ForegroundColor Yellow
Write-Host "(1) Full Editing Rights with Send-As permissions" -ForegroundColor Yellow
Write-Host "(2) Read-Only" -ForegroundColor Yellow
$PermissionSel = Read-Host "Please enter the number corresponding with the correct permission"

if ($PermissionSel -eq "1"){
    $Confirm = Read-Host "I will be granting $user full access to the $identity mailbox. Would you like me to proceed? (y/n)"
    if ($Confirm -eq "y"){
        Connect-ExchangeOnline
        Write-Host "Updating permissions, please wait..."
        Add-MailboxPermission -Identity $Identity -User $User -AccessRights FullAccess -InheritanceType All -AutoMapping $TRUE | Out-Null
        Add-RecipientPermission -Identity $Identity -AccessRights SendAs -Trustee $User -Confirm:$false | Out-Null
        Get-MailboxPermission -Identity $Identity -User $User
        Get-RecipientPermission -Identity $Identity
        Read-Host "I have made the above changes. Press enter to exit"
        Get-PSSession | Remove-PSSession
    }else{
        Read-host "Press enter to exit"
        Get-PSSession | Remove-PSSession
    }
} elseif ($PermissionSel -eq "2") {
    $Confirm = Read-Host "I will be granting $user read only access to the $identity mailbox. Would you like me to proceed? (y/n)"
    if ($Confirm -eq "y"){
        Connect-ExchangeOnline
        Write-Host "Updating permissions, please wait..."
        Add-MailboxPermission -Identity $Identity -User $User -AccessRights ReadPermission -InheritanceType All -AutoMapping $TRUE | Out-Null
        Get-MailboxPermission -Identity $Identity -User $User
        Read-Host "I have made the above changes. Press enter to exit"
        Get-PSSession | Remove-PSSession
    }else{
        Read-host "Press enter to exit"
        Get-PSSession | Remove-PSSession
    }
} else {
    Read-Host "Invalid entry, press enter to exit"
}