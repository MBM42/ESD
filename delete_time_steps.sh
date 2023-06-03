#!/bin/bash

mode="null"
n_precision="null"
n_oldest="null"

#While loop to get user's mode selection
while getopts ":m:" flag; do
  if [ $flag = "m" ]; then
    mode=$OPTARG
  else
    echo "Invalid flag selection."
    exit 0
  fi
done

#Case to ask for user input depending on the selected mode
case $mode in
  1 | precision)
    read -p "Select precision (input integer): " n_precision
    #Fiding all time steps that are too precise and deleting them
    delete_list=$(find . -regextype sed -regex ".*/0\.[[:digit:]]\{$((n_precision+1)),\}") # -exec rm -rf {} +
    ;;
  2 | oldest)
    read -p "Select the number of oldest timesteps to be delete (input integer): " n_oldest
    #Finding the n_oldest time steps to be delete
    delete_list=$(find . -regextype sed -regex ".*/0\.[[:digit:]]*" -exec stat -c "%Y %n" {} \; | sort -n | tail -$n_oldest | awk '{ print $2 }') # | xargs rm -rf -- 
    ;;
  *)
    echo "Invalid mode selection."
    exit 0
    ;;
esac

#For loop to delete the folders
for folder in $delete_list; do
  rm -r $folder
done

exit 0
