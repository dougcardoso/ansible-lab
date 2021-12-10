#!/bin/sh
########################
#Author:Douglas Cardoso#
#run stop/start/restart for WLP liberty servers DBBE#
########################
clear
PS3='Want run command for a single wlp instance or for all wlp instance into a host?: '
options=("Single wlp instance" "Multiple wlp instances" "Option 3" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Option 1")
            echo "you chose choice 1"
            ;;
        "Option 2")
            echo "you chose choice 2"
            ;;
        "Option 3")
            echo "you chose choice $REPLY which is $opt"
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
