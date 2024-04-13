#!/bin/bash

# Check if the script is executed with the root user.
if [[ "${UID}" -ne 0 ]]
then
  echo 'You are not the root user. Execute this script as a root user to proceed.' >&2
  exit 1
fi

# Provide usage statement if the user didn't supply an account name on the command line.
if [[ "${#}" -eq 0 ]]
then
  echo "Usage: ${0} USER_NAME [COMMENT]..." >&2
  exit 1
fi

# First argument for username, rest for comment.
USER_NAME=${1}
shift
COMMENT=${*}

adduser -c "${COMMENT}" -m ${USER_NAME} &> /dev/null

# Checking if the user account was created successfully.
if [[ "${?}" -ne 0 ]]
then
  echo 'An error occurred and cannot add the user.' >&2
  exit 1
fi

# Automatically generating a password for the new account.
PASSWORD=$(date +%s%N | sha256sum | head -c48)
echo ${PASSWORD} | passwd --stdin ${USER_NAME} &> /dev/null

# Checking if the password was assigned successfully.
if [[ "${?}" -ne "0" ]]
then
  echo 'An error occurred and cannot assign the password to the user.' >&2
  exit 1
fi

# Force the password to be changed upon login.
passwd -e ${USER_NAME} &> /dev/null

# Display the username, password, and hostname where the account was created.
echo -e "The username of the account:\n${USER_NAME}"
echo
echo -e "The password of the account:\n${PASSWORD}"
echo
echo -e "The host name that created that account:\n${HOSTNAME}"

exit 0
