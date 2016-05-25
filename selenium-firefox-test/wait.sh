#!/bin/bash

function wait_for_proxy() {
   echo "wait for $1 proxy to appear (makes $2 attempts every 5s)"
   COUNTER=1
   FAILED=0
   until $(curl --output /dev/null --silent --head --fail $1); do
      printf '.'
      sleep 5
      let COUNTER=COUNTER+1
      if [ $COUNTER -gt $2 ]; then
             return 1
      fi
   done
   return 0
}
wait_for_proxy "$@"