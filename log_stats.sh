#!/bin/bash

#Defining default variables
glob="*.out"
file="logstats"

#Deliting file if it already exists
if [ -f $file ]; then
  rm $file
fi
 
#Loop to update glob and file variables with user input
while [[ $# -gt 0 ]]; do
  case $1 in
    -p | --pattern)
      if [[ -n $2 ]] && [[ $2 != -* ]]; then
        glob=$2
        shift 2
      else
	echo "Invalid argument form."
	exit
      fi
      ;;
    -f | --file)
      if [[ -n $2 ]] && [[ $2 != -* ]]; then
        file=$2
        shift 2
      else
        echo "Invalid argument form."
        exit
      fi
      ;;
  esac
done


#Print the number of log files
find . -not -path "*/.*" -name $glob | wc -l | tr -d "\n" > $file
echo " log lifes were found" >> $file

#Print the first file and last file
find . -not -path "*/.*" -name $glob -exec ls -ltr --time-style=long-iso {} + | awk 'NR==1{printf "First file (%s %s): %s\n", $6, $7, $8};  END{printf "Last file (%s %s): %s\n", $6, $7, $8}' >> $file

#Print the largest and smallest file
find . -not -path "*/.*" -name $glob -exec du -b {} \; | sort -n | awk 'NR==1{printf "Smallest file (%s MB): %s\n", $1, $2}; END{printf "Largest file (%s MB): %s\n", $1, $2}' >> $file

exit 0

