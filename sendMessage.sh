#! /bin/bash

sendMessage() {
    read -r -p "To (name or number): " search
    if grep -i -q "^$search," "$contacts" || grep -i -q ",$search$" "$contacts"; then
        contact=$(grep -i "^$search," "$contacts" || grep -i ",$search$" "$contacts")
        echo "Found Contact: $contact"
        read -p "Message content: " msg
        echo "$curro,$contact,$msg" >> $messages
        echo "Message sent to $contact."
    else
        echo "No contact found with the name or number '$search'."
    fi
}