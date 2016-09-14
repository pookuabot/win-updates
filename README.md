Win-Updates
===========

I wrote this script to check for Windows Updates and then email what needs installed.

I used sendEmail as an easy way to send emails without having to install/configure an email server.  You can use the Powershell send-mailmessage cmdlet but I found sendEmail having better options to pass.

* sendEmail - (http://caspian.dotconf.net/menu/Software/SendEmail/)

After downloading, move sendEmail to C:\Windows and rename it to mail. (Shorter names are always a great idea.)

You can have this run automatically by adding the script to Task Scheduler.