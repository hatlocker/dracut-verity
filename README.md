# dracut-verity
Dracut module to mount DM-Verity volumes

This is basically the 10verity-generator plugin from https://github.com/coreos/bootengine
with small changes (explicitly: removing the After=ignition-disks).
It has e2size (https://github.com/coreos/seismograph/tree/master/src/e2size) in-tree.
