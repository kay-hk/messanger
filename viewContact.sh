#! /bin/bash

viewContact() {
    if [ ! -f $contacts ]; then
        echo "Contacts do not exist." 
    else
        echo "Contacts: "
        cat $contacts
    fi
}