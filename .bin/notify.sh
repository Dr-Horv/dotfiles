#!/usr/bin/env bash

id=$1
title=$2
content=$3

empty="â–"
full="â–‡"

bar=""

for (( i = 0; i < 7; i++ )); do
    bar=$bar$full
done
for (( i = 0; i < 3; i++ )); do
    bar=$bar$empty
done
perc="100%"
bar=$bar$perc

twmnc -d 5000  --pos top_right --aot --id $id -t $title -c $bar
