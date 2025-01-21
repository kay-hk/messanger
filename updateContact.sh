#! /bin/bash

updateContact() {
    read -r -p "Contact to update: " cname
    if grep -q "^$cname," $contacts; then
        contact=$(grep "^$cname," $contacts)
        echo "Existing Contact: $contact"
        read -p "Update 1. Name, 2. Number, 3. Both: " ch
        currcname=$(echo $contact | cut -d ',' -f 1)
        currcnum=$(echo $contact | cut -d ',' -f 2)
        case $ch in
            1) read -p "Enter new name: " ncname 
                sed -i "s/^$currcname,$currcnum/$ncname,$currcnum/" $contacts
                echo "Contact name successfully updated to $ncname." ;;
            2) read -p "Enter new number: " ncnum 
                sed -i "s/^$currcname,$currcnum/$currcname,$ncnum/" $contacts
                echo "Contact number successfully updated to $ncnum." ;;
            3) read -p "Enter new name: " ncname
                read -p "Enter new number: " ncnum 
                sed -i "s/^$currcname,$currcnum/$ncname,$ncnum/" $contacts 
                echo "Contact name and number successfully updated to $ncname and $ncnum." ;;
            *) echo "Invalid choice. Please choose again." ;;
        esac
    else
        echo "No contact named $cname found."
        return
    fi
}