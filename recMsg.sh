#! /bin/bash

owner="data/owner.txt"
contacts="data/contacts.txt"
messages="data/messages.txt"

recMsg() {
    read -r -p "Your name: " name
    read -r -p "Your number: " num
    if grep -i -q "^$name,$num" "$contacts"; then
        read -r -p "To (name or number): " search
        if grep -i -q "$search" "$owner"; then
            curro=$(grep -i "$search" "$owner")
            read -p "Message content: " msg
            echo "$name,$num,$curro,$msg" >> "$messages"
            echo "Message sent to $search."
        else
            echo "Recipient does not match the current owner."
        fi
    else
        echo "You are not in the contacts. Message cannot be sent."
    fi
}


recMsg