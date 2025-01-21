#! /bin/bash

owner="owner.txt"
contacts="contacts.txt"

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

displayContacts() {
    if [ ! -f $contacts ]; then
        echo "Contacts do not exist." 
    else
        echo "Contacts: "
        cat $contacts
    fi
}

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

searchContacts() {
    read -r -p "Name of contact to search: " cname
        if grep -i -q "^$cname," "$contacts"; then
            contact=$(grep "^$cname," "$contacts")
            echo "Found Contact: $contact"
        else
            echo "No contact found with the name '$cname'."
        fi
}

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
    curro=$(tail -n 1 "$owner")
    read -r -p "1. Change owner 2. Add Contacts 3. Display Contacts 4. Delete Contacts 5. Update Contacts 6. Search Contacts 7. Send Messages 8. Receive/View Messages 9. Exit: " ch 
    case $ch in 
        1) changeOwner ;;
        2) addContact ;;
        3) displayContacts ;;
        4) deleteContact ;; 
        5) updateContact ;;
        6) searchContacts ;;
        7) sendMessages ;;
        8) recviewMessages ;;
        9) break ;;
        *) echo "Invalid choice. Please choose again." ;;
    esac
done