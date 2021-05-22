#! /bin/sh

ts=$(date +%s%N)

$@

kubeless function call hello --data 'Hello world!'

echo $((($(date +%s%N) - $ts)/1000000))
