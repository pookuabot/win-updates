## WinUpdates.ps1
# Created by: Brian Good
# Version   : v0.1
#
# This scripts checks for Windows Updates
# Then sends it to the server team

# Update Variables
$update_dir  = "C:\updates"
$update_list = "C:\updates\Updates.txt"
$update_now = "C:\updates\WinUpdates.txt"

#########################
### Check for updates ###
#########################

# This creates the temporary update directory
New-Item -ItemType directory -Path $update_dir

# This checks for any updats that need installed
# and then exports it to a list
$Session = New-Object -ComObject Microsoft.Update.Session
$Searcher = $Session.CreateUpdateSearcher()
$Searcher.Search("IsInstalled=0").Updates | Select-Object Title | Out-File $update_list

# This will bypass the sendEmail -m "message" is
# missing error.  The file is being sent as the
# message instead
Get-Content $update_list | Set-Content $update_now

##########################
### Email Notification ###
##########################

# Emails the list of updates that need installed
mail -s smtp.myserver.com -t pookuabot@myserver.com -f admin@winsvr01.myserver.com -b winsvr01.myserver.com -u "Windows Update Notification" -o "message-file=$updates_now"

################################
### Remove Updates Directory ###
################################

# Removes the update directory after the email is sent
Remove-Item -Recurse -Force $update_dir
