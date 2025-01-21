#! /bin/bash

searchContact() {
    read -r -p "Name of contact to search: " cname
        if grep -i -q "^$cname," "$contacts"; then
            contact=$(grep "^$cname," "$contacts")
            echo "Found Contact: $contact"
        else
            echo "No contact found with the name '$cname'."
        fi
}