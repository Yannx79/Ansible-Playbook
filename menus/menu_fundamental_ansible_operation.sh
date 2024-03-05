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
            2) operate_playbooks;;
            3) operate_hosts;;
            4)
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

        echo
        echo "=============================================================="
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
            cat "./playbooks/$pb_name"
        else 
            echo "Playbook $pb_name not found ..."
        fi
    fi
}

add_playbook() {
    read -p "Enter playbook name: " pb_name
    if [ ! -d "./playbooks/" ]; then
        mkdir "./playbooks/"
    fi
    vim -N "./playbooks/$pb_name"
}

update_playbook() {
    read -p "Enter playbook name: " pb_name
    if [ ! -d "./playbooks/" ]; then
        mkdir "./playbooks/"
        echo "Playbook $pb_name not found ..."
    else 
        if [ -f "./playbooks/$pb_name" ]; then
            vim -N "./playbooks/$pb_name"
        else 
            echo "Playbook $pb_name not found ..."
        fi
    fi
}

delete_playbook() {
    read -p "Enter playbook name: " pb_name
    if [ ! -d "./playbooks/" ]; then
        mkdir "./playbooks/"
        echo "Playbook $pb_name not found ..."
    else 
        if [ -f "./playbooks/$pb_name" ]; then
            rm "./playbooks/$pb_name"
            echo "Playbook $pb_name removed"
        else 
            echo "Playbook $pb_name not found ..."
        fi
    fi
}

operate_hosts() {
    while true; do
        show_trading_hosts
        get_input

        echo ""
        echo "=============================================================="
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
    if [ -s "/etc/ansible/hosts" ];then
        cat "/etc/ansible/hosts"
    else 
        echo "No host registered"
    fi
}

search_host() {
    read -p "Enter hostname: " hostname_host
    if grep -q "$hostname_host" "/etc/ansible/hosts"; then
        echo "Hostname $hostname_host exists"
    else
        echo "Hostname $hostname_host does not exist"
    fi
}
add_host() {
    read -p "Enter IP: " ip_host
    read -p "Enter hostname: " hostname_host

    ip_hostname="$ip_host $hostname_host"
    
    echo $ip_hostname >> /etc/hosts
    echo $hostname_host >> /etc/ansible/hosts
    echo "$hostname_host registered ..."
}

update_host() {
    read -p "Enter current hostname to update: " old_hostname
    read -p "Enter new hostname: " new_hostname
    read -p "Enter new IP address: " new_ip

    ansible_hosts="/etc/ansible/hosts"
    etc_hosts="/etc/hosts"

    # Update hostname in /etc/ansible/hosts
    if [ -f "$ansible_hosts" ]; then
        sed -i "s/\b$old_hostname\b/$new_hostname/" "$ansible_hosts"
        echo "Host $old_hostname updated to $new_hostname in $ansible_hosts."
    else
        echo "File $ansible_hosts not found."
    fi

    # Update IP and hostname in /etc/hosts
    if [ -f "$etc_hosts" ]; then
        sed -i "s/\b$old_hostname\b/$new_hostname/" "$etc_hosts"
        sed -i "s/\b$old_hostname\b/$new_ip/" "$etc_hosts"
        echo "Host $old_hostname updated to $new_hostname with IP $new_ip in $etc_hosts."
    else
        echo "File $etc_hosts not found."
    fi
}

delete_host() {
    read -p "Enter hostname: " hostname

    ansible_hosts="/etc/ansible/hosts"
    etc_hosts="/etc/hosts"

    if [ -f "$ansible_hosts" ]; then
        sed -i "/^$hostname\>/d" "$ansible_hosts"
        echo "Host $hostname deleted in $ansible_hosts."
    else
        echo "File $ansible_hosts not found."
    fi

    if [ -f "$etc_hosts" ]; then
        sed -i "/\b$hostname\b/d" "$etc_hosts"
        echo "Host $hostname deleted in $etc_hosts."
    else
        echo "File $etc_hosts not found."
    fi
}

# Init Menu

display
