#!/bin/bash

# Check if the script is executed with root user.
UID=${UID}
if [[ "${UID}" -ne "0" ]]
then
  echo 'You are not the root user. Execute this script as a root user to proceed.'
  exit 1
fi

# Getting the credentials of the user account.
read -p 'Enter your username: ' USER_NAME
read -p 'Enter your first/last name: ' COMMENT
read -p 'Enter your password: ' PASSWORD

# Creating the user account.
adduser -c "${COMMENT}" -m ${USER_NAME}

# Checking if the user account was created successfully.
if [[ "${?}" -ne "0" ]]
then
  echo 'An error happened and cannot add the user.'
  exit 1
fi

# Adding a password to the user account.

echo ${PASSWORD} | passwd --stdin ${USER_NAME}
passwd -e ${USER_NAME}

# Checking if the password was assigned successfully.
if [[ "${?}" -ne "0" ]]
then
  echo 'An error happened and cannot add the user.'
  exit 1
fi

# Display the username, password, and host name where the account was created.
echo "The username of the account is ${USER_NAME}"
echo "The password of the account is ${PASSWORD}"
echo "The host name that created that account is $(hostname)"

exit 0
