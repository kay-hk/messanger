#! /bin/bash

owner="owner.txt"
contacts="contacts.txt"
messages="messages.txt"

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

viewContacts() {
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

sendMessages() {
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

viewMessages() {
    read -r -p "Contact (name or number): " contact

    if grep -iq "$contact" "$contacts"; then
        echo "Conversation with $contact:"
        echo "----------------"
	read -r -p "Do you want to see the most recent message :1 or the whole chat:2 " ch
	case $ch in
	1)
		 tac "$messages" | awk -F',' -v contact="$contact" '
		 {
			  if (($1 == contact || $2 == contact) || ($3 == contact || $4 == contact)) {
				  print "From: " $1 " (" $2 ") To: " $3 " (" $4 ") - " $5
				  exit  # Stop after the first match
				}
		}'
		;;

	2)
        tac "$messages" | grep -i "$contact" | awk -F',' -v contact="$contact" '
        {
            if ($1 == contact || $2 == contact) {
                print "From: " $1 " (" $2 ") To: " $3 " (" $4 ") - " $5
            } else if ($3 == contact || $4 == contact) {
                print "From: " $1 " (" $2 ") To: " $3 " (" $4 ") - " $5
            }
        }'
	;;
	*) echo "Invalid choice"
	;;
esac
    else
        echo "Invalid contact"
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
    if [ ! -f $messages ]; then
        touch $messages
        echo "FROM,FNUMBER,TO,TNUMBER,MESSAGE" > $messages
    fi
    curro=$(tail -n 1 "$owner")
    read -r -p "1. Change owner 2. Add Contacts 3. View Contacts 4. Delete Contacts 5. Update Contacts 6. Search Contacts 7. Send Messages 8. View Messages 9. Exit: " ch 
    case $ch in 
        1) changeOwner ;;
        2) addContact ;;
        3) viewContacts ;;
        4) deleteContact ;; 
        5) updateContact ;;
        6) searchContacts ;;
        7) sendMessages ;;
        8) viewMessages ;;
        9) break ;;
        *) echo "Invalid choice. Please choose again." ;;
    esac
done
