#!/usr/bin/env bash
#------------------
#  DEPLOY.SH
#------------------
# dotfile deployment script
# macOS version

# --- functions

dots_dir=$(pwd)

declare -a conflist=$(/bin/ls -A ./config)
declare -a homelist=$(/bin/ls -A ./home)

confcheck(){
    for item in $conflist
    do
        if [ -e ~/.config/$item ]
        then
            echo -e "\x1B[1;31mWarning! $item is already in ~/.config\x1B[0m"
        fi
    done

    for item in $homelist
    do
        if [ -e $HOME/$item ]
        then
            echo -e "\x1B[1;31mWarning! $item is already in $HOME\x1B[0m"
        fi
    done
}

deployconfirm(){
    echo -e "\x1B[1;33m Are you sure you want to deploy configuration files? \x1B[0m"
    echo -e "\x1B[1;33m This will overwrite existing files.\n \x1B[0m"
    read -p "Answer [y/N]: " answer
    case $answer in
        [yY][eE][sS]|[yY])
            echo -e "\x1B[1;34m Deploying in 5.. \x1B[0m" && sleep 1
            echo -e "\x1B[1;34m Deploying in 4.. \x1B[0m" && sleep 1
            echo -e "\x1B[1;34m Deploying in 3.. \x1B[0m" && sleep 1
            echo -e "\x1B[1;34m Deploying in 2.. \x1B[0m" && sleep 1
            echo -e "\x1B[1;34m Deploying in 1.. \x1B[0m" && sleep 1;;
        [nN][oO][nN]|[nN])
            echo -e "\x1B[1;33m Deployment aborted. Exiting... \x1B[0m"
            exit 1;;
        *)
            echo -e "\x1B[1;33m Invalid input. Exiting... \x1B[0m"
            exit 1;;
    esac
}

link_conf(){
    echo -e "\x1B[1;34m Deploying into ~/.config... \x1B[0m" && sleep 1

    for item in $conflist
    do
        if [ -e ~/.config/$item ] 
        then
            rm -rf ~/.config/$item 1> /dev/null
            echo -e "\x1B[1;31mDeleted existing $item configuration in ~/.config \x1B[0m"
        fi
    done

    for item in $conflist
    do
        ln -s $dots_dir/config/$item $HOME/.config/$item
    done
}

link_home(){
    echo -e "\x1B[1;34m Deploying home-based configurations... \x1B[0m" && sleep 1

    for item in $homelist
    do
        if [ -e $HOME/$item ]
        then
            rm -rf $HOME/$item 1> /dev/null
            echo -e "\x1B[1;31mDeleted existing $item configuration in $HOME\x1B[0m"
        fi
    done

    for item in $homelist
    do
        ln -s $dots_dir/home/$item $HOME/$item
    done
}

deploy_finish(){
    echo -e "\x1B[1;32m The following dotfiles were successfully deployed:\n \x1B[0m"
    for item in $conflist
    do
        echo -e "\x1B[1;32m  - $item \x1B[0m"
    done
    for item in $homelist
    do
        echo -e "\x1B[1;32m  - $item \x1B[0m"
    done
}

# --- exec

confcheck && deployconfirm && link_conf && link_home && deploy_finish
