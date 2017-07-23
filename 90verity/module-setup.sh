#!/bin/bash

check() {
    require_binaries veritysetup || return 1
    return 0
}

depends() {
    echo dm rootfs-block crypt
    return 0
}

installkernel() {
    instmods dm_verity
}

install() {
    inst_hook cmdline 30 "$moddir/parse-verity.sh"
    inst veritysetup
    dracut_need_initqueue
}
