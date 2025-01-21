#! /bin/bash

# Gobal variables
owner="data/owner.txt"
contacts="data/contacts.txt"
messages="data/messages.txt"

while true; do
    if [ ! -f $contacts ]; then
        touch $contacts
        echo "NAME,NUMBER" > $contacts
    fi
    if [ ! -f $owner ]; then
        read -p "Please enter your name: " oname
        read -p "Please enter your mobile number: " onum
        echo "$oname,$onum" > $owner
    fi
    if [ ! -f $messages ]; then
        touch $messages
        echo "FROM,FNUMBER,TO,TNUMBER,MESSAGE" > $messages
    fi
    curro=$(tail -n 1 "$owner")
    read -r -p "1. Change owner 2. Add Contacts 3. View Contacts 4. Delete Contacts 5. Update Contacts 6. Search Contacts 7. Send Messages 8. View Messages 9. Exit: " ch 
    case $ch in 
        1) source ./changeOwner.sh
            changeOwner ;;
        2) source ./addContact.sh
            addContact ;;
        3) source ./viewContact.sh
            viewContact ;;
        4) source ./deleteContact.sh
            deleteContact ;; 
        5) source ./updateContact.sh
            updateContact ;;
        6) source ./searchContact.sh
            searchContact ;;
        7) source ./sendMessage.sh
            sendMessage ;;
        8) source ./viewMessage.sh
            viewMessage ;;
        9) break ;;
        *) echo "Invalid choice. Please choose again." ;;
    esac
done
