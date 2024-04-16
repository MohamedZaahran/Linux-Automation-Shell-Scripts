#!/bin/bash
#
# This script executes a given command on multiple servers.
#

SERVER_FILE="/vagrant/servers"

# Functions:

usage() {
  echo "Usage: ${0} [-nsv] [-f FILE] COMMAND"
  echo 'Executes COMMAND as a single command on every server.'
  echo '  -f FILE  Use FILE for the list of servers. Default: /vagrant/servers.'
  echo '  -n       Dry run mode. Display the COMMAND that would have been executed and exit.'
  echo '  -s       Execute the COMMAND using sudo on the remote server.'
  echo '  -v       Verbose mode. Displays the server name before executing COMMAND.'
  exit 1
}

override_server_file() {
  if [[ -e "${1}" ]]
  then
    SERVER_FILE=${1}
  else
    echo "Cannot open server list file ${1}." >&2
    exit 1
  fi
}

#______________________________________________________________________________

# Check if the script is executed with the root user.
if [[ "${UID}" -eq 0 ]]
then
  echo 'Do not execute this script as root. Use the -s option instead.' >&2
  usage >&2
  exit 1
fi

# Checking what OPTIONS did the user choose & outputs usage if he supplied an invalid option.
while getopts nsvf: OPTION
do
  case ${OPTION} in
    n) DRY_RUN='true' ;;
    s) SUDO='sudo' ;;
    v) VERBOSE='true' ;;
    f) override_server_file ${OPTARG} ;;
    ?) usage >&2 ;;
  esac
done

# Remove the options while leaving the remaining arguments.
shift "$(( OPTIND - 1 ))"

# Provide usage statement if the user didn't supply atleast one argument on the command line.
if [[ "${#}" -lt 1 ]]
then
  usage >&2
fi

EXIT_STATUS='0'

# Executes all arguments as a single command on every server listed in the /vagrant/servers file by default.
ARGUMENTS=${*}
for SERVER in $(cat ${SERVER_FILE})
do
  if [[ "${VERBOSE}" = 'true' ]]
  then
    echo "${SERVER}"
  fi

  if [[ "${DRY_RUN}" = 'true' ]]
  then
    echo "DRY RUN: ssh -o ConnectTimeout=2 ${SERVER} ${SUDO} ${ARGUMENTS}"
  else
    ssh -o ConnectTimeout=2 ${SERVER} ${SUDO} ${ARGUMENTS}
    SSH_EXIT_STATUS="${?}"

    # Capture any non-zero exit status from the SSH command and report to the user.
    if [[ "${SSH_EXIT_STATUS}" -ne 0 ]]
    then
      EXIT_STATUS=${SSH_EXIT_STATUS}
      echo "Execution on ${SERVER} failed." >&2
    fi

 fi
done

exit ${EXIT_STATUS}
