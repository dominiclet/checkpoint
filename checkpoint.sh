#!/bin/bash

help () {
    echo "
Checkpoint

Usage: checkpoint [command]

Commands:
    qsave(qs)       Quick save current directory location as checkpoint (will overwrite any previous quicksaves)
    qload(ql)       Change current working directory to quick saved directory
    show            Show the currently quick-saved checkpoint 
    swap            Quick save current working directory and change directory to previous quick-save location
    help            Display this help message
    "
}

qsave() {
    export QS_CHECKPOINT_LOCATION=$(pwd)
    echo "Quick saved current location: $QS_CHECKPOINT_LOCATION"
}

qload() {
    if [[ -z "${QS_CHECKPOINT_LOCATION}" ]]; then
        echo "No quick-saved location available to load"
        return 1
    fi
    echo "Changing directory to: $QS_CHECKPOINT_LOCATION"
    cd $QS_CHECKPOINT_LOCATION
}

swap() {
    if [[ -z "${QS_CHECKPOINT_LOCATION}" ]]; then
        echo "No quick-saved location available to load"
        return 1
    fi
    prev_qs=$QS_CHECKPOINT_LOCATION
    qsave
    echo "Changing directory to: $prev_qs"
    cd $prev_qs
}

show() {
    if [[ -z "${QS_CHECKPOINT_LOCATION}" ]]; then
        echo "No quicked saved location"
        return 1
    fi
    echo "Current quick-save: ${QS_CHECKPOINT_LOCATION}"
}

cmd=$1

if [ "$cmd" == "help" ] || [[ -z "${cmd}" ]]; then
    help
elif [ "$cmd" == "qsave" ] || [ "$cmd" == "qs" ]; then
    qsave
elif [ "$cmd" == "qload" ] || [ "$cmd" == "ql" ]; then
    qload
elif [ "$cmd" == "swap" ]; then
    swap
elif [ "$cmd" == "show" ]; then
    show
else
    echo "Unrecognised command \"${cmd}\""
    help
fi
