# Update Variables
$update_dir  = "C:\updates"
$update_list = "C:\updates\Updates.txt"
$update_now  = "C:\updates\WinUpdates.txt"

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

# Create new file to bypass the -m "message"
# missing error that sendEmail.exe gives
# It wants a -m "message" but we are sending
# the file as the message instead
cat $update_list >> $update_now

##########################
### Email Notification ###
##########################

# Emails the list of updates that need installed
mail -s smtp.mysmtpserver.com -t winsvrteam@myserver.com -f server@winsvr01.myserver.com -b winsvr01.myserver.com -u "Windows Update Notification" -o "message-file=$update_now"

################################
### Remove Updates Directory ###
################################

# Removes the update directory after the email is sent
Remove-Item -Recurse -Force $update_dir