#! /bin/sh

x=1
while [ $x -le 30 ]
do
  kubeless function call hello --data 'Hello world!'
  x=$(( $x + 1 ))
  time
done

