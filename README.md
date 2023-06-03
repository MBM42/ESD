## OpenFOAM data processing with shell scripts

Since parameter studies performed with OpenFOAM result in large datasets that encopass many cases, data processing is essential to be able to evaluate the data in an efficient manner.

With this in mind, hereby are presented 4 shell scripts that help one with this matter.


#### Script 1: log_stats.sh
##### Description
Searches in all directories and subdirectories for a certain glob (e.g. "*.out") and prints statistics about the logs to a file:\
-Prints the number of log files found;\
-Prints the first and last file;\
-Prints the largest and smallest file.

##### Usage
By default:\
-glob = "*.out"\
-file = "logstats"

The user can execute the the script inside the desired directory and has 4 options:\
-Using default glob and output file name: "./log_stats.sh"\
-Providing just an input glob via the flag "-p" or "--pattern": Ex: "./log_stats.sh -p *.txt"\
-Providing just the output file name, via the falg "-f" or "--file": Ex: "./log_stats.sh -f output"\
-Proving both the input glob and the output file name: Ex "./log_stats.sh -p *.txt -f output"

If any other form of input argument is set this will result in an error message ("Invalid argument form.") and the user will have to try again with the correct form.

#### Script 2: delete_time_steps.sh
##### Description
Some OpenFOAM simulations might have unecessary time steps. These are directories (such as "0.012") regarding the simulations. This script allows one to do one of two things:\
-Delete time steps that are too precise: Ex: all those with 3 or more decimal places ("0.012"; "0.0034");\
-Delete time steps that are too old: Ex: the N oldest time steps\

##### Usage
Precision mode:\
-Step 1: the user executes the script with the "-m" flag followed by "1" or "precision": Ex: "./delete_time_step.sh -m 1"\
-Step 2: the user is prompted to select the precision via an integer number.\

Oldest mode:\
-Step 1: the user executes the script with the "-m" flag followed by "2" or "oldest": Ex: "./delete_time_step.sh -m 2"\
-Step 2: the user is prompted to select the N oldest time steps to be deleted via an integer number.

If the user doesn't use the "-m" flag or inputs a wrong mode this will result in an error message that exits the script and the user will have to try again with the correct form.

#### Script 3: create_time_series.sh
##### Description
This script will tailor a selected logfile, gathering data from it and writing it to an output file that by default is called "time_series.out".

The output file will contain the following 9 columns of data from the simulation:\
-Time_Step;\
-T_min (Minimum Temperature);\
-T_max (Maximum Temperature);\
-rho_min (Minimum Density);\
-rho_max (Maximum Density);\
-P_min (Minimum Pressure);\
-P_max (Maximum Pressure);\
-U_min (Mininum Velocity);\
-U_max (Maximum Velocity)

##### Usage
The user can execute the script in two ways:\
-Providing just the logfile name (or path if not on the file's directory) via the flag "-i" or "--input": Ex: "./create_time_series -i file";\
-Providng both the logfile and output file names, the latter via the flag "-o" or "--output": Ex: "./create_time_series -i file -o data_file"

If the user doesn't use the correct flags or inputs wrong arguments, this will result in an error message that exits the script and the user will have to try again with the correct form.

#### Script 4: modify_log.sh
##### Description
This script will tailor a selected logfile by removing unecessary parts of it.

##### Usage
-Step 1: The user executes the script with the flag "-i" or "--input" followed by the logfile's name.

If the user inputs the wrong flag this will result in an error message ("Invalid argument form.") and the script execution will be exited. The user will have to execute the script again with the correct form.

Step 2: the user will be prompted with the following options on what he wants to remove from the log file:\
-[1]OpenFOAM header;\
-[2]Solver DICPCG for the pressure equation;\
-[3]Solver DILUPBiCG for the velocity and enthalpy equations;\
-[4]Solver smoothSolver for the species transport equations;\
-[5]Time step continuity errors

The user should then input an integer, from "1" to "5" to select the desired option.

If the user inserts any other integer number this will result in an error message ("Invalid option.") and the script execution will be exited. The user will have to execute the script again with the correct form.
