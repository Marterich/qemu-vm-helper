#!/bin/bash

VMNAME="win11"
ACTION=$1

start_vm() {
    VMNAME=$1
    echo "Starting the virtual machine '$VMNAME'..."
    virsh start "$VMNAME"

    # Check if the start command was successful
    if [ $? -eq 0 ]; then
        echo "Virtual machine '$VMNAME' started successfully."
        nohup virt-viewer "$VMNAME" &>/dev/null & 
    else
        echo "Failed to start the virtual machine '$VMNAME'."
    fi
}

shutdown_vm() {
    VMNAME=$1
    echo "Shutting down the virtual machine '$VMNAME'..."
    virsh shutdown "$VMNAME"
}

if [[ $ACTION == "start" ]]; then
    echo "Starting $VMNAME"
    start_vm "$VMNAME"
    sleep 5
elif [[ $ACTION == "stop" ]]; then
    shutdown_vm "$VMNAME"
elif [[ $ACTION == "show" ]]; then
    if virsh list --all | grep -q "$VMNAME"; then
        status=$(virsh list --all | grep "$VMNAME" | awk '{print $3}')
        if [ "$status" == "running" ]; then
            nohup virt-viewer "$VMNAME" &>/dev/null
        else
            start_vm "$VMNAME"
            sleep 5
        fi
    fi 
else
    echo "Virtual machine '$VMNAME' does not exist."
fi

#if virsh list --all | grep -q "$VMNAME"; then
#    status=$(virsh list --all | grep "$VMNAME" | awk '{print $3}')
#    if [ "$status" = "running" ]; then
#        shutdown_vm "$VMNAME"
#    else
#        start_vm "$VMNAME"
#    fi
#else
#    echo "Virtual machine '$VMNAME' does not exist."
#fi
sleeptime="5"
#echo "Sleep for '$sleeptime' seconds"
#sleep $sleeptime
