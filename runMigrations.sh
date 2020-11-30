#!/bin/sh
response=`python ./manage.py migrate --list`
value=''
value_assign=0
IFS='
'
set -f
for line in $response; do
  if [[ $line != *"[X]"* ]] && [[ $line != *"[ ]"* ]] && [[ $line != *"Creating"* ]] && [[ $line != *"Destroying"* ]]  && [[ $line != *"(no migrations)"* ]]
   then
      value=$line
      value_assign=1
  fi
  if [[ $line = *"[ ]"* ]] && [[ $value_assign = 1 ]]
    then
    echo './manage.py migrate' $value
    python ./manage.py migrate $value
    value_assign=0
  fi
done
set +f
unset IFS
