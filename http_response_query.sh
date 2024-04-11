#!/bin/bash

URL="https://example.com"
TIMEOUT=720
INTERVAL=5

echo "Polling $URL until it returns 200 OK or timeout ($TIMEOUT seconds) occurs..."
start_time=$(date +%s)
while true; do
    response_code=$(curl -s -o /dev/null -w "%{http_code}" "$URL")
    if [ "$response_code" -eq 200 ]; then
        echo "Site is up and running."
        exit 0
    fi
    current_time=$(date +%s)
    if [ "$((current_time - start_time))" -ge "$TIMEOUT" ]; then
        echo "Timeout reached. Site did not return 200 OK within $TIMEOUT seconds."
        exit 1
    fi
    sleep "$INTERVAL"
done
