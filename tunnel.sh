#!/bin/bash
#Description:script that create an ssh tunnel
#Author: Luca Radaelli <lradaelli85@users.noreply.github.com>

SSH=`which ssh`
porta="0"
porta_locale="0"
remote_ports="0"

while [ -z "$nome" ]; do
echo "insert the ip address or the hostname of the remote host [destination server]:"
read nome
done

until [[ "$porta" =~ ^-?[0-9]+$ ]] && [ "$porta" -ge 1 ] && [ "$porta" -le 65535 ]; do
echo "insert the ports of the remote host [destination server] that you want to connect to"
read porta 
done

until [[ "$porta_locale" =~ ^-?[0-9]+$ ]] && [ "$porta_locale" -ge 1 ] && [ "$porta_locale" -le 65535 ]; do
echo "insert local port to use"
echo "maybe you should choose a port between 1025 and 65535"
read porta_locale 
done

while [ -z "$utente" ]; do
echo "insert ssh user to use for the ssh server connection"
read utente
done

while [ -z "$host_ssh" ]; do
echo "insert the ip address or the hostname of the ssh server"
read host_ssh
done

until [[ "$remote_ports" =~ ^-?[0-9]+$ ]] && [ "$remote_ports" -ge 1 ] && [ "$remote_ports" -le 65535 ]; do
echo "insert the port of the ssh server to use"
read remote_ports
done

$SSH -N -L $porta_locale:$nome:$porta $utente@$host_ssh -p $remote_ports

