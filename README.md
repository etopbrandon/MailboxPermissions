# MailboxPermissions
Update Exchange Online Mailbox Permissions

# What does this do?
This script will update a user's mailbox to allow another user within the organization to have either full editing with sending permissions, or allow read only permissions. It will also Automap the mailbox. The user will need to add the "From" field and send as addresses if it is not enabled in Outlook.

# Current known issues
Microsoft has a limit of 3 concurrent sessions at once in PowerShell. Functions are included to end PSSession at the end of execution, but you may experience a "Fail to create a runspace" error if running this script several times. Get-PSSession | Remove-PSSession should kill things that need to be killed at the end, please let me know if you get this error still. 