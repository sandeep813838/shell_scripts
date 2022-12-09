#!/bin/bash
#Author : Sampath (L2 Linux)
#Version:v0.1
#purpose: This shell script is used to SendMails for deleting the attached files/folders older than +45days from the given list of directories
#dir_list.txt is the file that holds the list of directory_path
###############################################################################
##Variables
NEXT_DAY=$(date +%m-%d-%Y --date='next day')
LIST_OF_DIR="/home/ss025384/dir_list"
LIST_OF_FILES="/tmp/files.out"
prev_count=0
###################################################################################
##Main script 
for DIR_PATH in $(cat $LIST_OF_DIR)
do
  echo "+----------------Below files are going to deleted on $NEXT_DAY--------------------------------------------+" >>$LIST_OF_FILES
  ls -d $DIR_PATH >>  $LIST_OF_FILES
  find $DIR_PATH -maxdepth 1 -type d -mtime +45  -exec ls -ld {} \; >> $LIST_OF_FILES
  echo "+----------------------------------------------------+" >> $LIST_OF_FILES
done
#####################################################################
## Condition to send mail notification 
count=$(cat $LIST_OF_FILES | wc -l)
if [ "$prev_count" -lt "$count" ] ; then
MESSAGE="/tmp/mail.out"
echo -e  "Files older then +45 days going to deleted on $NEXT_DAY from below list of directories" >> $MESSAGE
echo  "" >> "$MESSAGE"
echo "+-------------------DIR LIST---------------------------------+" >> $MESSAGE
echo "$(cat $LIST_OF_DIR)" >> $MESSAGE
echo "+----------------------------------------------------+" >> $MESSAGE
echo "" >> "$MESSAGE"
echo "Attached file contains the list, this list will going to delete tomorrow." >> $MESSAGE
echo -e "Kindly check and let us know if any one have any objections or comments" >>$MESSAGE
SUBJECT="CSPFTC01: Attached files going to deleted on Next Day"
TO="ssingrapu@ep.com,ftpadmins@ep.com"
#CC="L2_Linux@ep.com,crodriguez@ep.com"
mail -s "$SUBJECT" -a $LIST_OF_FILES  "$TO" < "$MESSAGE"
rm $MESSAGE $LIST_OF_FILES
fi
