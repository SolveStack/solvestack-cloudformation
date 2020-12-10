#!/bin/bash

if [ ! $@ ]; then
    echo "Usage: ./cf_deploy.sh <environment_name>. There MUST be a <environment_name>-parameters.properties file in the same directory as this script. Also, if you get a syntax/YAML error on first run, please try it once more"
    exit 1
fi
PARAMSFILE=./$1-parameters.properties
if [ -f "$PARAMSFILE" ]; then
    aws cloudformation package --template-file master.yaml --s3-bucket solvestack-$1-cloudformation | tail -n +2 > $1.yaml
    sed -i -e '/^MUploading to/d' $1.yaml
    aws cloudformation deploy --template-file $1.yaml --stack-name $1 --capabilities CAPABILITY_NAMED_IAM --parameter-overrides $(cat ./$1-parameters.properties )
else
    echo $PARAMSFILE does not exist, please check your environment name.
    exit 1
fi

rm $1.yaml
