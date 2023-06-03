#!/bin/bash

#Defining default variables
input="null"
option="null"

#Loop to update input variable with user input
if [[ $1 == "-i" ]] || [[ $1 == "--input" ]]; then
  input=$2
else
  echo "Invalid argument form."
  exit
fi

#Prompting user for option
printf "
Remove lines from:
[1]The OpenFOAM header
[2]The solver DICPCG for the pressure equation
[3]The solver DILUPBiCG for the velocity and enthalphy equations
[4]The solver smoothSolver fot the species transport equations
[5]The time step continuity errors\n
"
read -p "Choose the desired option inputing the single respective integer: " option 

#Testing if the option is in the correct form
if [[ ! $option =~ ^[1-5] ]]; then
  echo "Invalid option"
  exit
fi

case $option in
  1)
    sed -i '/Create time/,$!d' $input
  ;;
  2)
    sed -i '/DICPCG/d' $input
  ;;
  3)
    sed -i '/DILUPBiCG/d' $input
  ;;
  4)
    sed -i '/smoothSolver/d' $input
  ;;
  5)
    sed -i '/time step continuity errors :/d' $input
esac

exit 0
