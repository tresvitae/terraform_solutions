#!/bin/bash
set -e
ip=$(dig +short myip.opendns.com @resolver1.opendns.com -4)
echo "{\"ip\": \"$ip\"}"
