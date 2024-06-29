#!/usr/bin/env bash

set -euo pipefail

COMMAND=$(basename "${0}")

function usage {
    cat <<EOF
NAME
    ${COMMAND}

SYNOPSIS
    ${COMMAND} -t <token> -d <database_id> -u <user_id> [-h]

DESCRIPTION
    Creat event in Notion calendar.

OPTIONS
    -t  Notion API token.
    -d  Database ID.
    -u  User id.
    -h  help for ${COMMAND}.
EOF
}

while getopts d:t:u:h OPT
do
    case $OPT in
        d) export DATABASE_ID=${OPTARG};;
        t) TOKEN=${OPTARG};;
        u) export USER_ID=${OPTARG};;
        h) usage; exit;;
        *) usage; exit 1;;
    esac
done

curl -sf -X POST https://api.notion.com/v1/pages -H 'Authorization: Bearer '"${TOKEN}"'' -H "Content-Type: application/json" -H "Notion-Version: 2022-06-28" --data "$(envsubst < payload.json)"

# curl -sf https://api.notion.com/v1/users -H 'Authorization: Bearer '"${TOKEN}"'' -H "Notion-Version: 2022-06-28"
