#!/bin/bash

BASEPATH=$(dirname $(dirname "$(readlink -f "$0")")../)
ENVIRONMENTS=""
ENVIRONMENT=""
ENVIRONMENT_PATH=""

if [ -n "$1" ]; then
    ENVIRONMENT=$1
    ENVIRONMENT_PATH="/$1"
else
    ENVIRONMENTS_EXPRESSION=$(ls $BASEPATH/clusters | paste -sd "|" -)
fi

FILES=$(egrep -lri "^kind:\ssecret" $BASEPATH/**$ENVIRONMENT_PATH | xargs egrep -Lr "ENC.AES256")

for f in $FILES
do
    if [ "$ENVIRONMENT" != "" ]; then
        fEnvironment=$ENVIRONMENT
    else
        fEnvironment=$(echo $f | egrep -o $ENVIRONMENTS_EXPRESSION)
    fi

    fKeyfile=$BASEPATH/clusters/$fEnvironment/.sops.pub.asc

    if [ ! -f $fKeyfile ]; then
        continue
    fi

    gpg --import $fKeyfile >/dev/null 2>&1

    fPath=$(dirname $f)
    fFile=$(basename -- "$f")
    fExtension="${fFile##*.}"
    fName="${fFile%.*}"

    echo "Crypting $f"
    sops --config $BASEPATH/clusters/$fEnvironment/.sops.yaml --encrypt $f > $fPath/$fName-enc.$fExtension
    echo "Created $fPath/$fName-enc.$fExtension"
    rm $f
    echo "Deleted $f"
    echo ""
done