#!/usr/bin/env sh

set -e

trap cleanup INT KILL HUP EXIT

test_makefile=Makefile.test

# Ensure the test makefile is removed
function cleanup {
    rm $test_makefile
}

# Consistent logging
function log {
    local type=$1
    local shell=$2
    local message=${@:3}

    printf "%-6s [%-4s]  :  %s\n" $type $shell "$message"
}

# Run the makefile on a specific sehell and check for errors
function test_shell {
    local shell=$1

    log "INFO" $shell 'Testing shell'

    echo SHELL = $shell > $test_makefile
    cat Makefile >> $test_makefile

    make -f $test_makefile clean build

    if ls -1 static/* | grep -E "delete$"
    then
        log "ERROR" $shell "Files not deleted"
        exit
    fi

    if grep -E "(API|CDN)_URL" static/*
    then
        log "ERROR" $shell "Placeholders not replaced"
        exit
    fi
}

function main {
    local shells=${@:-bash sh dash}

    for shell in $shells
    do
        test_shell $shell
    done
}

main $@