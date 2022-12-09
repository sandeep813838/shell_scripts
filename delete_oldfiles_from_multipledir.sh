#!/bin/bash
#Author : Sampath (L2 Linux)
#Version:v0.1
#purpose: This shell script used to delete the files older than 45 days from the list of directory
#dir_list.txt is the file that holds the list of directory_path
###############################################################################
##Variables
#NEXT_DAY=$(date +%m-%d-%Y --date='next day')
LIST_OF_DIR="/home/ss025384/dir_list"
LIST_OF_FILES="/tmp/files.out"
prev_count=0
###################################################################################
for DIR_PATH in $(cat $LIST_OF_DIR)
do
  find $DIR_PATH -maxdepth 1 -type d -mtime +45  -exec rm -rvf {} \; >> $LIST_OF_FILES
done
count=$(cat $LIST_OF_FILES | wc -l)
if [ "$prev_count" -lt "$count" ] ; then
MESSAGE="/tmp/mail.out"
echo "Files older then +45 days has deleted from below list of directories" >> $MESSAGE
echo  "" >> "$MESSAGE"
echo "+-------------------DIR LIST---------------------------------+" >> $MESSAGE
echo "$(cat $LIST_OF_DIR)" >> $MESSAGE
echo "+----------------------------------------------------+" >> $MESSAGE
echo "" >> "$MESSAGE"
SUBJECT="CSPFTC01: Attached file having the list of deleted files"
TO="ssingrapu@ep.com,ftpadmins@ep.com"
CC="L2_Linux@ep.com,crodriguez@ep.com"
mail -s "$SUBJECT" -a $LIST_OF_FILES  "$TO" -c "$CC" < "$MESSAGE"
rm $MESSAGE $LIST_OF_FILES
fi
