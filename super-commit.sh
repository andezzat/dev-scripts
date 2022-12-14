#!/bin/zsh

# errexit:  Exit immediately if a command exits with a non-zero status.
# nounset:  Treat unset variables as an error when substituting.
# pipefail: The return value of a pipeline is the status of the last command
#           to exit with a non-zero status, or zero if no command exited with
#           a non-zero status.
set -o errexit -o nounset -o pipefail

# ๐ Customize the types & scopes available here ๐
TYPES="build chore ci docs feat fix perf refactor revert style test"
SCOPES=("react-app" "react-native-app" "graphql-api" "config-api")

hash gum 2>/dev/null || {
  echo "๐บ Gum is missing, installing via Brew..."
  echo ""
  brew install gum
  echo ""
  echo "๐ฏ Ready to roll!"
}

gum style \
	--foreground 135 --border-foreground 135 --border double \
	--align center --width 30 --margin 1 --padding 1 \
	"๐ฆธ $(gum style --bold 'Super') Commit!"

CURRENT_PATH=$0
DIR=$(dirname $0)
BIN_DIR="/usr/local/bin"

function required() {
  if [[ -z $1 ]] then
    echo "โ๏ธ $2 is required, try again!"
    exit 1
  fi
}

function setup() {
  if [[ $DIR == $BIN_DIR ]] then
    return
  fi

  echo "๐ง First time running"
  gum spin -s moon --title "Initialising..." sleep 1

  echo -e "\n๐ท  What alias would you like to use for Super Commit?"
  ALIAS=$(gum input --value "super")
  required "$ALIAS" "An alias"

  SYMLINK_PATH="$BIN_DIR/$ALIAS"
  gum spin -s meter --title "Symlinking to $SYMLINK_PATH ..." sleep 2

  if [[ -f $SYMLINK_PATH ]] then
    echo "๐ Looks like we've already set you up!"
  else
    echo "๐ Symlinking to $SYMLINK_PATH ..."
    sudo ln -s $CURRENT_PATH $SYMLINK_PATH
    echo -e "\nโ All done!"
  fi
  
  echo -e "๐ Type $ALIAS to get started ๐\n"
  exit 0
}

setup

if [[ -z $(git status -s) ]] then
  echo -e "๐งน You have no changes to commit"
  exit 0
fi

BRANCH=$(git symbolic-ref --short HEAD)
typeset -u BRANCH
ISSUE=${BRANCH%%/*}

TYPE=$(echo ${TYPES// /\\n} | gum filter --indicator.foreground 129 --match.foreground 135 --prompt.foreground 135)
SCOPE=$(gum choose --cursor.foreground 135 ${SCOPES[@]})
ISSUE=$(gum input --cursor.foreground 135 --value $ISSUE)
required "$ISSUE" "An issue #"

SUMMARY=$(gum input --cursor.foreground 135 --value "$TYPE($SCOPE): [$ISSUE] ")
required "$SUMMARY" "A summary"
DESCRIPTION=$(gum write --cursor.foreground 135 --placeholder "Details of this change")

function commit() {
  if [[ -z $DESCRIPTION ]] then
    git commit -m $SUMMARY
  else
    git commit -m $SUMMARY -m $DESCRIPTION
  fi

 [[ $? -eq 0 ]] && echo -e "\nโจ Commit created" || echo -e "\n๐ Something went wrong..."
}

gum style \
  --border-foreground 75 --border rounded --padding '0 1' --margin '0 1' \
  "$(gum style --foreground 75 --bold 'Summary') $SUMMARY"

[[ -n $DESCRIPTION ]] && gum style \
  --border-foreground 199 --border rounded --padding '0 1' --margin '0 1' \
  "$(gum style --foreground 199 --bold 'Description') $DESCRIPTION"

gum confirm --selected.background 129 --default "Create commit?" && commit || gum style --margin '1 1' "Nws, cya! ๐"
