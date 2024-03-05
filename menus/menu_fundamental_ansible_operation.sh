#!/bin/bash
# By: Yannick Funes
# Datetime: 05/03/2024 23:31
# 

title="Menu for Fundamental Ansible Operations"
description="The code is a Bash script for a menu-driven tool to manage Ansible playbooks and hosts. It provides functionalities to list, search, add, update, and delete playbooks and hosts."  
machine=`who am i | sed "s/^\(.*\)(\(.*\))\(.*\)/\2/" | sed "s/ //g"`
date=`date +%d/%m/%Y`
hour=`date +%H:%M:%Sc`
server=`logname`

# GENERAL

show_header() {
    clear

    echo "=============================================================="
    echo "Title         : $title"
    # echo "Description   : $description"
    echo "Machine       : $machine"
    echo "Server        : $server"
    echo "Date          : $date"
    echo "Hour          : $hour"
    echo "=============================================================="
    echo ""
}

show_main() {
    show_header
    
    echo "Main Menu"
    echo "1. Show Ansible Version"
    echo "2. Work Playbooks"
    echo "3. Work Hosts"
    echo "4. Exit"
}

get_input() {
    read -p "Choose your choice: " option
}

# WORKING PLAYBOOKS

show_trading_playbooks() {
    show_header

    echo "Playbook Menu"
    echo "1. List Playbooks"
    echo "2. Search Playbook"
    echo "3. Add Playbook"
    echo "4. Update Playbook"
    echo "5. Delete Playbook"
    echo "6. Go to Main Menu"
    echo "7. Exit"
}

# WORKING HOSTS

show_trading_hosts() {
    show_header

    echo "Hosts Menu"
    echo "1. List Hosts"
    echo "2. Search Host"
    echo "3. Add Hosts"
    echo "4. Update Host"
    echo "5. Delete Host"
    echo "6. Go to Main Menu"
    echo "7. Exit"
}

show_ansible_version() {
    ansible --version
}

display() {
    while true; do
        show_main
        get_input
        
        case $option in
            1) show_ansible_version;;
            2)
                operate_playbooks;;
            3)
                operate_hosts;;
            11)
                echo "Leaving the menu ..."
                sleep 1
                clear
                exit;;
            *)
                echo "Invalid option ...";;
        esac

        read -p "Press any key to continues ..."

    done
}

operate_playbooks() {
    while true; do
        show_trading_playbooks
        get_input

        case $option in
            1) list_playbooks;;
            2) search_playbook;;
            3) add_playbook;;
            4) update_playbook;;
            5) delete_playbook;;
            6) display;;
            7) 
                echo "Leaving the menu ..."
			    sleep 1
			    clear
			    exit;;
            *) 
                echo "Invalid option ...";;
        esac

        read -p "Press any key to continues ..."

    done
}

list_playbooks() {
    if [ ! -d "./playbooks/" ]; then 
        mkdir ./playbooks/
    fi
    ls -l ./playbooks
}

search_playbook() {
    read -p "Enter playbook name: " pb_name
    if [ ! -d "./playbooks/" ]; then
        mkdir ./playbooks/
        echo "Playbook $pb_name not found ..."
    else 
        if [ -f "./playbooks/$pb_name" ]; then
            ls -l "./playbooks/$pb_name"
            echo ""
            cat "./playbooks/$pb_name"
        else 
            echo "Playbook $pb_name not found ..."
        if
    fi

}

add_playbook() {
    read -p "Enter playbook name: " pb_name
    if [ ! -d "./playbooks/" ]; then
        mkdir "./playbooks/"
    if
    vim -N "./playboos/$pb_name"
}

update_playbook() {
    read -p "Enter playbook name: " pb_name
    if [ ! -d "./playbooks/" ]; then
        mkdir "./playbooks/"
        echo "Playbook $pb_name not found ..."
    else 
        if [ -f "./playbooks/$pb_name" ]; then
            vim -N "./playboos/$pb_name"
        else 
            echo "Playbook $pb_name not found ..."
        if
    if
}

delete_playbook() {
    read -p "Enter playbook name: " pb_name
    if [ ! -d "./playbooks/" ]; then
        mkdir "./playbooks/"
        echo "Playbook $pb_name not found ..."
    else 
        if [ -f "./playbooks/$pb_name" ]; then
            rm $pb_name
            echo "Playbook $pb_name removed"
        else 
            echo "Playbook $pb_name not found ..."
        if
    if
}

operate_hosts() {
    while true; do
        show_trading_hosts
        get_input

        case $option in
            1) list_hosts;;
            2) search_host;;
            3) add_host;;
            4) update_host;;
            5) delete_host;;
            6) display;;
            7) 
                echo "Leaving the menu ..."
			    sleep 1
			    clear
			    exit;;
            *) 
                echo "Invalid option ...";;
        esac

        read -p "Press any key to continues ..."

    done
}

list_hosts() {
    ansible all -m setup -f 1
}

search_host() {
    ls
}

add_host() {
    ls
}

update_host() {
    ls
}

delete_host() {
    ls
}

# Init Menu

display
