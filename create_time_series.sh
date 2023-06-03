#!/bin/bash

#Defining default variables
input="null"
output="time_series.out"

#Loop to update input variables with user input
while [[ $# -gt 0 ]]; do
  case $1 in
    -i | --input)
      if [[ -n $2 ]] && [[ $2 != -* ]]; then
        input=$2
        shift 2
      else
        echo "Invalid argument form."
        exit
      fi
    ;;
    -o | --output)
      if [[ -n $2 ]] && [[ $2 != -* ]]; then
        output=$2
        shift 2
      else
        echo "Invalid argument form."
        exit
      fi
    ;;
    *)
      echo "Invalid flag."
      exit
    ;;
  esac
done

#Deleting output file if it already exists
if [ -f $output ]; then
  rm  $output
fi

#Printing header row to identify the parameters
printf "%-25s %-7s %-7s %-10s %-10s %-9s %-9s %-6s %s\n" Time_Step T_min T_max rho_min rho_max P_min P_max U_min U_max >> $output

#Using awk command to gather the data
awk '/Starting time loop/{found=1} found && /^Time/{printf "%-25s ", $3} found && /T gas min\/max/{printf "%-7s %-7s ", substr($5, 1, length($5)-1), $6} found && /rho min\/max/{printf "%-10s %-10s ", $4, $5} found && /P gas min\/max/{printf "%-9s %-9s ", substr($5, 1, length($5)-1), $6} found && /mag U min\/max/{printf "%-6s %s\n", substr($5, 1, length($5)-1), $6}' $input >> $output

exit 0
