#!/bin/bash
#############################################################################
# A small utility script to clean up files over a certain age (default 48
# hours from any directory structure.
#############################################################################

# A basic function to show the usage for this script.
function usage_message {
  printf "usage: %s [ -h hours]" $( basename $0 )
}

# Global variables.
DEFAULT_HOURS=48
typeset -i hours
hours=$DEFAULT_HOURS

while getopts "h:" opt; do
  case $opt in
    h)
      hours=$OPTARG ;;
    \?)
      usage_message
      echo "ERROR: invalid option: -$OPTARG" >&2
      exit 2
      ;;
  esac
done

if [ -z "$hours" ]; then
  usage_message
  echo "ERROR: You must specify the number of hours as a positive integer."
  exit 2
fi

(( mmin = hours * 60 ))

for dir in ${disk_cleanup_directory_list}; do
  dir_to_clean="/var/sky/gonzales/${application_name}/${dir}"
  DATE=`date +%F`
  LOGFILE="/var/sky/log/${application_name}/disk-cleanup.log"

  if [ -d $dir_to_clean ]; then
    find $dir_to_clean -type f -mmin +${mmin} -delete -exec bash -c 'for f do printf "[%(%F %H:%M:%S)T] disk-cleanup INFO [disk-cleanup] Deleting: %s\n" -1 "$f"; done' _ {} +  >> $LOGFILE
  fi
done

exit 0
