#!/bin/bash

type getarg >/dev/null 2>&1 || . /lib/dracut-lib.sh

for p in $(getargs rd.verity=);
do
    name=""
    datauuid=""
    hashuuid=""
    verityuuid=""
    roothash=""
    IFS=',' read -r -a values <<< "$p"
    for element in "${values[@]}"
    do
        if [[ ${element:0:10} == "rd.verity=" ]]
        then
            element=${element:10}
        fi
        IFS="=" read -r -a arg <<< "$element"
        if [[ ${arg[0]} == "name" ]]
        then
            name="${arg[1]}"
        elif [[ ${arg[0]} == "datauuid" ]]
        then
            datauuid="${arg[1]}"
        elif [[ ${arg[0]} == "hashuuid" ]]
        then
            hashuuid="${arg[1]}"
        elif [[ ${arg[0]} == "verityuuid" ]]
        then
            verityuuid="${arg[1]}"
        elif [[ ${arg[0]} == "roothash" ]]
        then
            roothash="${arg[1]}"
        else
            info "Invalid line, $p, unknown arg ${arg[0]}"
	    continue
        fi
    done

    if [[ "x$name" == "x" ]]
    then
        warn "Invalid line, $p, missing name"
        continue
    elif [[ "x$datauuid" == "x" ]]
    then
        warn "Invalid line, $p, missing data uuid"
        continue
    elif [[ "x$hashuuid" == "x" ]]
    then
        warn "Invalid line, $p, missing hash uuid"
        continue
    elif [[ "x$verityuuid" == "x" ]]
    then
        warn "Invalid line, $p, missing verity uuid"
        continue
    elif [[ "x$roothash" == "x" ]]
    then
        warn "Invalid line, $p, missing roothash"
        continue
    fi

    wait_for_dev "/dev/disk/by-uuid/$datauuid"
    wait_for_dev "/dev/disk/by-uuid/$hashuuid"

    info "Mounting verity volume $name"

    veritysetup create "$name" \
        "--uuid=$verityuuid" \
        "/dev/disk/by-uuid/$datauuid" \
        "/dev/disk/by-uuid/$hashuuid" \
        "$roothash"

    if [[ $? == 0 ]];
    then
        info "Verity volume $name mounted"
    else
        info "Mounting verity volume $name failed"
    fi
done
