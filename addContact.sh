#! /bin/bash

addContact() {
    read -p "Enter contact name: " cname
    read -p "Enter contact number: " cnumber
    if grep -q ",$cnumber" $contacts || grep -q "$cname," $contacts ; then
        echo "The name or number already exists in contacts. Please update the contact instead."
        return
    else 
        echo "$cname,$cnumber" >> $contacts
    fi
}