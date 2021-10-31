#!/bin/bash

if [ "$USER" != "root" ]; then
    echo "Necessita de root!"
    exit 1
fi


echo "Iniciando configuração de interface de rede!"
echo "Escolha o método de configuração:"
echo "1 - DHCP"
echo "2 - STATIC IP"

interface=`cat /proc/net/dev | tail -n 1 | cut -f 1 -d ':'`

echo "a sua interface é $interface"

read metodo

if [ "$metodo" -eq "1" ]; then
    echo "
    # This file describes the network interfaces available on your system
    # and how to activate them. For more information, see interfaces(5).

    source /etc/network/interfaces.d/*

    # The loopback network interface
    auto lo
    iface lo inet loopback

    # The primary network interface
    allow-hotplug $interface
    iface $interface inet dhcp" > /etc/network/interfaces

    sleep 1
        
    echo "A configuração em DHCP esta finalizada"
    echo "Pode ser necessária a reinicialização do sistema"
    sleep 1

else 
    echo "Insira o endereço IPV4"
    read adrs
    echo "Insira o Gateway"
    read gtwy
    echo "Insira a Mascara de Subrede "
    read netmsk
    echo "Insira o Broadcast" 
    read brdct
    echo "Insira a Network"
    read ntwrk
    echo "Insira os nameservers"
    read nmsrv
    echo "
    # This file describes the network interfaces available on your system
    # and how to activate them. For more information, see interfaces(5).

    source /etc/network/interfaces.d/*

    # The loopback network interface
    auto lo
    iface lo inet loopback

    # The primary network interface
    allow-hotplug $interface
    iface $interface inet static
    address $adrs
    gateway $gtwy
    netmask $netmsk
    broadcast $brdct
    network $ntwrk
    nameservers $nmsrv " > /etc/network/interfaces

    echo "A configuração em DHCP esta finalizada"
    echo "Pode ser necessária a reinicialização do sistema"
    sleep 1

    fi

#This code was writed by jaijunior