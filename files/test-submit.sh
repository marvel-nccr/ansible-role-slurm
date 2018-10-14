#!/bin/bash

set -e

THISSCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
THEPID=$$
FOLDER="${THISSCRIPTDIR}/test1"
echo "Writing to folder: $FOLDER"
mkdir "$FOLDER"
cd "$FOLDER"
cp "$THISSCRIPTDIR/job.sh" .
sbatch job.sh
sleep 1

echo "Current queue status:"
# Important to change format to have a long field for the name and avoid truncation
squeue --format "%.18i %.9P %.20j %.8u %.8T %.10M %.9l %.6D %R"

sleep 1

echo "  [Waiting for job to finish...]"
safecounter=0
while squeue --format "%.18i %.9P %.20j %.8u %.8T %.10M %.9l %.6D %R" | grep testsubmission 
do
    let safecounter=safecounter+1
    if [ "$safecounter" -gt 10 ]
    then
	echo "TIMEOUT while waiting for job to be scheduled!"
	exit 2
    fi
    echo "  [Waiting for job to finish...]"
    sleep 2
done

STDOUTCONTENT=`cat output.txt`
if [ "$STDOUTCONTENT" != "done" ]
then
    echo "ERROR! The submission completed but I couldn't find the expected stdout!"
    echo "I found:"
    cat output.txt
    exit 1
fi

echo "Submission completed successfully!"
