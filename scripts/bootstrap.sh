#!/usr/bin/env bash

## setup parameters
app_name='far-shell'
app_dir="$HOME/.far-shell"
[ -z "$git_repo" ] && git_repo='farrrr/far-shell.git'
git_branch='master'
debug_mode='0'

## basic setup tools
msg() {
    printf '%b\n' "$1" >&2
}

success() {
    if [ "$ret" -eq '0' ]; then
        msg "\e[32m[✔]\e[0m ${1}${2}"
    fi
}

error() {
    msg "\e[31m[✘]\e[0m ${1}${2}"
    exit 1
}

debug() {
    if [ "$debug_mode" -eq '1' ] && [ "$ret" -gt '1' ]; then
        msg "An error occurred in function \"${FUNCNAME[$i+1]}\" on line ${BASH_LINENO[$i+1]}, we're sorry for that."
    fi
}

program_exists() {
    local ret='0'
    type $1 >/dev/null 2>&1 || { local ret='1'; }

    # throw error on non-zero return value
    if [ ! "$ret" -eq '0' ]; then
        error "$2"
    fi
}

## setup functions

## main()
msg "Welcome to $app_name!"

for repos in "dotfiles" "bash-it" "far-vim"
do
    while true
    do
        read -p "Do you wanna install ${repos}? [Y/N] " RESP
        case $RESP
            in
            [yY])
                curl https://j.mp/far-${repos} -L > ${repos}.sh && sh ${repos}.sh
                success "Successfully Install ${repos}"
                break
                ;;
            [nN])
                break
                ;;
            *)
                msg "Please enter Y or N"
                ;;
        esac
    done
done

endpath="$app_dir"

$endpath/install.sh

msg "\nThanks for installing $app_name."
msg "© `date +%Y` https://farrrr.github.io/"
