#!/bin/bash

check_program_exists()
{
    echo "Checking for $1..."
    if ! (command -v $1 > /dev/null)
    then
        echo $1 not found on PATH
        return 1
    fi
    echo "Program found at [$(which $1)]"
    return 0
}

check_command()
{
    echo "Checking for ${*:1}..."
    echo "Querying command [$(which $1) ${@:2}]"
    if ! (command -v "${*:1}" > /dev/null)
    then
        echo "${*:1} returned an error"
        return 1
    fi
    echo "Command OK [$(which $1) ${@:2}]"
    return 0
}

check_program_exists podman
PODMAN=$?
if [ $PODMAN -eq 0 ]
then
    echo Podman available as the container engine
    check_program_exists podman-compose
    PODMAN_COMPOSE=$?
    if [ $PODMAN_COMPOSE -eq 0 ]
    then
        echo Podman Compose selected as container orchestration tool
        echo Using MongoDB password found in password.txt
        DB_PASSWORD=$(cat password.txt)
        sed -i "s/<mongdb_pass>/$DB_PASSWORD/" init-mongo.js
        MONGO_DB_PASSWORD=$DB_PASSWORD podman-compose up -d
        COMPOSE_UP_STATUS=$?
        echo "Execution result [$COMPOSE_UP_STATUS]"
    fi
fi

# TODO: Docker as runtime
