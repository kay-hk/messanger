#! /bin/bash

viewMessage() {
    read -r -p "Contact (name or number): " contact
    if grep -iq "$contact" "$contacts"; then
	read -r -p "Show 1. Latest Message 2. All Messages: " ch
	case $ch in
	1)  echo "Latest Message from $contact: "
        echo "----------------"
        tac "$messages" | awk -F',' -v contact="$contact" '
            {
                if ($1 == contact || $2 == contact) {
                    print "From: " $1 " (" $2 ") To: " $3 " (" $4 ") - " $5
                    exit  
                    } 
            }' ;;
	2)  echo "Conversation with $contact:"
        echo "----------------"
        tac "$messages" | grep -i "$contact" | awk -F',' -v contact="$contact" '
            {
                if ($1 == contact || $2 == contact) {
                    print "From: " $1 " (" $2 ") To: " $3 " (" $4 ") - " $5
                } else if ($3 == contact || $4 == contact) {
                    print "From: " $1 " (" $2 ") To: " $3 " (" $4 ") - " $5
                }
            }' ;;
	*) echo "Invalid choice" ;;
esac
    else
        echo "Invalid contact"
    fi
}