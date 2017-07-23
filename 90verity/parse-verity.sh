#!/bin/bash

type getarg >/dev/null 2>&1 || . /lib/dracut-lib.sh

for p in $(getargs rd.verity=);
do
    datauuid=""
    hashuuid=""
    roothash=""
    IFS=',' read -r -a values <<< "$p"
    for element in "${values[@]}"
    do
        if [[ ${element:0:10} == "rd.verity=" ]]
        then
            element=${element:10}
        fi
        IFS="=" read -r -a arg <<< "$element"
        if [[ ${arg[0]} == "datauuid" ]]
        then
            datauuid="${arg[1]}"
        elif [[ ${arg[0]} == "hashuuid" ]]
        then
            hashuuid="${arg[1]}"
        elif [[ ${arg[0]} == "roothash" ]]
        then
            roothash="${arg[1]}"
        else
            info "Invalid line, $p, unknown arg ${arg[0]}"
            exit 1
        fi
    done

    if [[ "x$datauuid" == "x" ]]
    then
        warn "Invalid line, $p, missing data uuid"
        continue
    elif [[ "x$hashuuid" == "x" ]]
    then
        warn "Invalid line, $p, missing hash uuid"
        continue
    elif [[ "x$roothash" == "x" ]]
    then
        warn "Invalid line, $p, missing roothash"
        continue
    fi

    info "Parsed $p, datauuid: $datauuid, hashuuid: $hashuuid, roothash: $roothash"

    wait_for_dev "/dev/disk/by-uuid/$datauuid"
    wait_for_dev "/dev/disk/by-uuid/$hashuuid"
done
