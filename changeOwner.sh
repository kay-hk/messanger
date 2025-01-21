#! /bin/bash

changeOwner() {
    echo "Current owner: $curro"
    read -p "Change owner? 1. Yes 2. No: " ch
    case $ch in 
        1) read -p "Owner name: " oname
            read -p "Owner number: " onum 
            echo "$oname,$onum" > $owner ;;
        2) echo "Owner change cancelled."
            return ;;
        *) echo "Invalid choice. Please choose again." ;;
    esac
}