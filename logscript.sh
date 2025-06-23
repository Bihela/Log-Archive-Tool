#!/bin/bash

logfile="$1"

if [ -z "$logfile" ]; then
	echo "Error: Please provide the log directory location as a argument."
	exit 1
fi

if [ ! -d "$logfile" ]; then
	echo "Error: log directory '$logfile' is not found"
	exit 1
fi

current_date=$(date +"%Y-%m-%d")
archive_output="./output"

tar -czvf "${archive_output}/logs_archieve_${current_date}.tar.gz" "${logfile}"

echo "log ${logfile} has been successfully archived to ${archive_output}"

Recipient="sandeshwanasekara@gmail.com"
Subject="Logarchive update on ${current_date}"
Message=$(cat <<END_OF_EMAIL
This is an automated update on the archieve log

Details: New logfile called logs_archive_${current_date} have been archived to this folder ${archive_output}
END_OF_EMAIL
)

echo "$Message" | mail -s "$Subject" "$Recipient"
echo "Email sent to ${Recipient} with subject: ${Subject}"

