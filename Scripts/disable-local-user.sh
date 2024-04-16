#!/bin/bash
#
# This script disables, deletes, and/or archives users on the local system.
#

# Functions

usage() {
  echo "Usage: ${0} [-dra] USER [USERN]"
  echo 'Disable a local Linux account'
  echo '  -d Deletes accounts instead of disabling them.'
  echo '  -r Removes the home directory associated with the account(s).'
  echo '  -a Creates an archive of the home directory associated with the account(s).'
  exit 1
}

# Outputs the success/fail messages to the screen.
log() {
  MESSAGE_FAIL=${2}
  MESSAGE_SUCCESS=${3}
  
  if [[ "${1}" -eq 1 ]]
  then
    echo "${MESSAGE_FAIL}" >&2
    exit 1
  else
    echo "${MESSAGE_SUCCESS}"
  fi
}

# Deletion of the user account (with the option to remove the home directory of that account '-r').
user_del() {
  RECURSIVE_OPTION=${2}

  if [[ "${RECURSIVE_OPTION}" = '-r' ]]
  then
     userdel -r ${USER_NAME}
     log ${?} "The account ${USER_NAME} cannot be deleted." "The account ${USER_NAME} was deleted with it's home directory."
  else
     userdel ${USER_NAME}
     log ${?} "The account ${USER_NAME} cannot be deleted." "The account ${USER_NAME} was deleted."
  fi
}

# Creating the archive directory (if not exist) and creating an archive of the account's home directory in it.
archive() {
  ARCHIVE_DIRECTORY="/archive"

  if [[ ! -d "${ARCHIVE_DIRECTORY}" ]]
  then
      mkdir -p "${ARCHIVE_DIRECTORY}"
      log ${?} "The archive directory ${ARCHIVE_DIRECTORY} could not be created." "${ARCHIVE_DIRECTORY} directory is created."

  fi
  
  tar -zcf /archive/${1}.tgz  /home/${1} &> /dev/null
  log ${?} "Archiving failed." "Archiving /home/${1} to /archive/{1}.tgz"
}

#______________________________________________________________________________

# Check if the script is executed with the root user.
if [[ "${UID}" -ne 0 ]]
then
  echo 'You are not the root user. Execute this script as a root user to proceed.' >&2
  exit 1
fi

# Checking what OPTIONS did the user choose & outputs usage if he supplied an invalid option.
while getopts dra OPTION
do
  case ${OPTION} in
    a) ARCHIVE='true' ;;
    d) DELETE='true' ;;
    r) REMOVE='true' ;;
    ?) usage >&2 ;;   
  esac
done

# Remove the options while leaving the remaining arguments.
OPTIONS_NUMBER=$(( OPTIND - 1 ))
shift "$(( OPTIND - 1 ))"

# Provide usage statement if the user didn't supply an account name on the command line.
if [[ "${#}" -le 0 ]]
then
  usage >&2
fi

# Entering the loop if we have atleast 1 username.
while [[ "${#}" -gt 0 ]]
do
  USER_NAME=${1}
  USERID=$(id -u ${USER_NAME} 2> /dev/null)
  
  if [[ "${?}" -ne 0 ]]
  then
    echo "The account ${USER_NAME} doesn't exist." >&2
    shift
    continue
  fi
  
  if [[ "${USERID}" -lt "1000" ]] # Checking if its a system account or not.
  then
    echo 'System accounts should only be modified by system administrators.' >&2
    exit 1
  fi

  if [[ "${OPTIONS_NUMBER}" -eq 0 ]] # Means that no options were given, so the intended functionality is disabling the account.
  then
    chage -E 0 ${USER_NAME}
    log ${?} "The account ${USER_NAME} cannot be disabled." "The account ${USER_NAME} was disabled."
  fi
 
  if [[ "${REMOVE}" = 'true' && "${DELETE}" = 'true' ]]
  then
    user_del "${USER_NAME}" -r
  elif [[ "${DELETE}" = 'true' ]]
  then
    user_del "${USER_NAME}"
  else
    if [[ "${ARCHIVE}" != 'true' ]]
    then
      usage >&2
    fi
  fi

  if [[ "${ARCHIVE}" = 'true' ]]
  then
    archive ${USER_NAME}
  fi

  shift # To get the next username to serve.
done      
