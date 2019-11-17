#!/bin/bash
# Autore: Matteo Pastorelli
# Nome: notifyScript.sh
# Funzione: Monitorare lo stato del servizio Apache e le modifiche sul file fileToMonitor
# ----------------------------------------------------

# Varibili

fileToMonitor="/etc/myprogram.conf"
emailToNotify="matteo.pastorelli@libero.it"
last=`ls -l "$fileToMonitor"`

while true; do
  sleep 1

# Viene controllato lo stato del servizio apache ed in caso sia spento invia mail
  if [ $(/etc/init.d/apache2 status | grep -i 'Apache2 is running'  | wc -l) == 0 ]
    then
     echo -e "!! WARNING !! : Service Apache2 Spento su SERVER $(hostname)" | /usr/bin/mail -s "URGENTE - Service Apache2 spento su SERVER $(hostname)" $emailToNotify

  fi

# Viene monitorata la data di modifica del file ed in caso di modifica recente invia mail

  new=`ls -l $fileToMonitor`
  if [ "$new" != "$last" ]; then
    echo -e "!! WARNING !! : File $fileToMonitor modificato su SERVER $(hostname)" | /usr/bin/mail -s "URGENTE - FILE MODIFICATO su SERVER $(hostname)" $emailToNotify
    last="$new"
  fi
done
