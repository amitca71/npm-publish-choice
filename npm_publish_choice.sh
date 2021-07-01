#!/bin/bash -x
pid=$$

#checks if the error was because there is no such npm registry
grep "\"version\": \"[0-9+\.]*\",$" package.json
if [ $? -eq 0 ]; then
    echo "production version" 
    command=$(echo 'npm publish')
else
    echo "beta version"
    command=$(echo 'npm publish --tag beta')
fi
exec $command 
if [ $? -ne 0 ]; then
    echo "failed to publish npm version"
    exit 1
fi
echo "package published succesfully"
exit 0