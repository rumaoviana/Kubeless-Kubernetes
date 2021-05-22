#! /bin/sh

ts=$(date +%s%N)

$@

kubeless function deploy hello --runtime python3.8 \
                                --from-file test.py \
                                --handler test.hello

echo $((($(date +%s%N) - $ts)/1000000))
