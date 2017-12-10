#!/bin/bash
echo "Crawling for flash files."
getPidNum=$(lsof | grep Flash | grep deleted | tr -s " " | cut -d " " -f 2)
pidNum=""
for linePidNum in ${getPidNum}; do
    if [[ "$pidNum" != "$linePidNum" ]]; then
        pidNum=$linePidNum
        echo "PID Number Is ${pidNum}"
        getProcNum=$(ls -l /proc/${pidNum}/fd | grep Flash | tr -s " " | cut -d " " -f 9)
        procNum=""
        for lineProcNum in ${getProcNum}; do
            if [[ "$procNum" != "$lineProcNum" ]]; then
                procNum=$lineProcNum
                echo "File Number Is ${procNum}"
                echo "Copying /proc/${pidNum}/fd/${procNum} to '${procNum}.flv'"
                cp /proc/${pidNum}/fd/${procNum} "${procNum}.flv"
            fi
        done
    fi
done

