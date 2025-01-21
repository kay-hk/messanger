#! /bin/bash

deleteContact() {
    read -r -p "Contact to delete: " cname
    if grep -q "^$cname," $contacts; then
        sed -i "/^$cname,/d" "$contacts"
        echo "Deleted $cname from Contacts."
        return
    else
        echo "Contact named $cname not found."
        return
    fi
}