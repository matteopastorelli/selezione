#!/bin/bash
# Autore: Matteo Pastorelli
# Nome: ssh-multi-vm.sh
# Funzione: Lanciare i comandi deifniti nel file commandfile su una serie di vm remote
# ----------------------------------------------------

commandfile=/usr/local/bin/comandiDaEseguire.file

for server in vm-{01..50}.mydomanin
do
    cat $commandfile | ssh root@$server
done
