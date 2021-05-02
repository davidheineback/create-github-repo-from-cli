#!/bin/bash

# To run script from the current directory in terminal run: sh /path/to/script
# ex. sh ~/scripts/add-to-github.sh

#!/bin/bash

# Gather constant vars
CURRENTDIR=${PWD##*/}
REMOTENAME='origin'
# github username
USERNAME='add github username here'

# For macOS you can choose to either write the github token directly in the variable or to use grep and place token in separate file and just add path to the file as example between <> below.
#  See the README.md for format of the token file.
# For Windows you need to insert your github token directly in the AUTH_TOKEN variable.
 AUTH_TOKEN=`grep -oE 'token [^\}]+' <~/scripts/tokens/add-to-github-token.rtf> | sed 's/token //g'`


 if [ ${#AUTH_TOKEN} -lt 1 ]; then
  echo Token not found
 fi


# Get user input
echo "Enter name for new repo, or just <return> to make it $CURRENTDIR"
read REPONAME
echo "Enter <return> to make the new repo private, 'x' for public"
read PRIVATE_ANSWER
echo "Enter name of new remote, or just <return> to make it 'origin'"
read OVERRIDE_REMOTENAME

if [ "$PRIVATE_ANSWER" == "x" ]; then
  PRIVACYWORD=public
  PRIVATE_TF=false
else
  PRIVACYWORD=private
  PRIVATE_TF=true
fi

REPONAME=${REPONAME:-${CURRENTDIR}}
USERNAME=${USERNAME}
REMOTENAME=${OVERRIDE_REMOTENAME:-${REMOTENAME}}


echo "Will create a new *$PRIVACYWORD* repo named $REPONAME"
echo "on github.com in user account $USERNAME"
echo "Type 'y' to proceed, any other character to cancel."
read OK
if [ "$OK" != "y" ]; then
  echo "User cancelled"
  exit
fi

# Curl some json to the github API
curl -u $USERNAME:$AUTH_TOKEN https://api.github.com/user/repos  -d "{\"name\":\"$REPONAME\", \"private\": \"$PRIVATE_TF\"}"
 
echo https://github.com/$USERNAME/$REPONAME.git

# Set the freshly created repo to the origin and push
# You'll need to have added your public key to your github account

if [ "$REMOTENAME" == "origin" ]; then
    git init
    echo ".DS_*" >> .gitignore
    echo "node_modules" >> .gitignore
    git add .
    git commit -m "init commit"
    git branch -M master
    git remote add origin https://github.com/$USERNAME/$REPONAME.git
    git push -u origin master
else
    git remote add $REMOTENAME https://github.com/$USERNAME/$REPONAME.git
    git config --global alias.pushall '!git remote | xargs -L1 git push --all'
    git pushall
fi
