Compilation of TAL to be done based on :
https://gitext.elektrobitautomotive.com/Bustools/Busmirror/pull/5477/files
and 
https://gitext.elektrobitautomotive.com/Bustools/Busmirror.git
and 
JIRA for reference :https://jira.elektrobit.com/browse/BUSTOOLS-5526

we get compiled TAL library to be used 
____________________________________________________________________________________________________________________________

The adtf is no GUI version for Arm 
Following steps are to be used for its use:

-Download Link:https://artifactory.digitalwerk.net/artifactory/Product-Releases/ADTF/3.12.5/Linux/armv8/gcc/5/

-Untar the download

-Get the lic file based on the mac address-IT Ticket

-in adtf directory:export ADTF_LICENSE_FILE="path to lic file"

-cd /data/ADTF/bin # depends on your installation directory

Intial TEST

./adtf_launcher -s ../src/examples/projects/adtf_example_project/adtfsessions/demo_standard_filters_session/demo_data_and_time_triggered_filter.adtfsession  --run

-make the project in ur machine then paste it to rasp and run through above way.
______________________________________________________________________________________________________________________________
