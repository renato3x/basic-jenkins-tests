#!/bin/bash

RESULT="`curl 'http://localhost:3000/'`"

if [$? -eq 0]
then
  echo 'All is running'
elif [[ $RESULT == *"visits"* ]]
then
  echo 'Expected data returned'
  echo $RESULT
else
  echo 'Something is not running'
