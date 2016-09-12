# Update Variables
$update_dir  = "C:\updates"
$update_list = "C:\updates\WinUpdates.txt"

#########################
### Check for updates ###
#########################

# This creates the temporary update directory
New-Item -ItemType directory -Path $update_dir

# This checks for any updats that need installed
# and then exports it to a list
$Session = New-Object -ComObject Microsoft.Update.Session
$Searcher = $Session.CreateUpdateSearcher()
$Searcher.Search("IsInstalled=1").Updates | Select-Object Title | Out-File $update_list

##########################
### Email Notification ###
##########################

# Emails the list of updates that need installed
$From = "server@winsvr01.pookuabot.local"
$To = "serverteam@pookuabot.local"
$Subject = "Windows Update Notification"
$Body = Get-Content $update_list | Out-String
$SMTPServer = "smtp.pookuabot.local"
Send-MailMessage -From $From -To $To -Subject $Subject `
-Body $Body -SmtpServer $SMTPServer

################################
### Remove Updates Directory ###
################################

# Removes the update directory after the email is sent
Remove-Item -Recurse -Force $update_dir