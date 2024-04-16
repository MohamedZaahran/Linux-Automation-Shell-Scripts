#!/bin/bash

# THIS SCRIPT IS MADE TO WORK WITH THE SYSLOG FORMAT. YOU CAN TEST WITH THE 'syslog-sample' FILE INCLUDED IN THE SAME SCRIPT FOLDER.
#
# This script displays the number of failed login attempts by IP address and location.
#

# Check if a file is provided as an argument.
if [[ "${#}" -eq 0 ]]
then
  echo "Usage: ${0} FILE_NAME" >&2
  exit 1
fi

# Check if that file exists or not AND is readable or not.
FILE_NAME=${1}
if [[ ! -e "${FILE_NAME}" ]]
then
  echo "Cannot open file: ${FILE_NAME}" >&2
  exit 1
fi

# Counts the number of failed login attempts by IP address and sorts them with descending order..
FAILED_LOGIN_ATTEMPTS=$(grep "Failed" ${FILE_NAME} | awk '{print $(NF - 3)}' | sort | uniq -c | sort -nr)

# Create a CSV file with a header of Count, IP, Location.
echo 'Count,IP,Location' > ${FILE_NAME}.csv

# Loop through the IP addresses which failed for more than 10 times and add them to the CSV file.
while read -r COUNT IP_ADDRESS
do
  if [[ "${COUNT}" -gt '10' ]]
  then
    LOCATION=$(geoiplookup ${IP_ADDRESS} | cut -d ' ' -f 5-)
    echo "${COUNT},${IP_ADDRESS},${LOCATION}" >> ${FILE_NAME}.csv
  else
    break # As they're sorted, so if it's not greather than 10, it would never be.
  fi
done <<< "${FAILED_LOGIN_ATTEMPTS}"

echo "Data is saved in: ${FILE_NAME}.csv"

exit 0
