#!/bin/bash

for p in $(getargs rd.verity=);
do
    echo "Testing verity, argument: $p"
done
