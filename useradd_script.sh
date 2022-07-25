#!/bin/bash
#Get the user name for login.
read -p 'Enter the username to create: ' USER_NAME
echo $USER_NAME
#Create the user account
useradd -m -d /home/$USER_NAME -s /bin/bash $USER_NAME
#Set the password
echo $USER_NAME | passwd --stdin $USER_NAME



# Force the user to change their password for the 1st login
passwd -e $USER_NAME



#ADD the user in the wheel group



usermod -aG wheel $USER_NAME



# Display the username, password, hostname.



echo
echo "UserName: $USER_NAME"
echo
echo "Password: $USER_NAME"
echo
echo "HostName/IPAddress: $(hostname -I)"
echo 
echo "This script is writen by sampath" 
