#!/usr/bin/env bash

# Example
# ./run.sh reports-size2-%d.csv 1000 'bundle exec bin/gp regression'

for i in $(seq 1 $2)
do
    $3 --report `printf $1 $i`
done
    
	 
