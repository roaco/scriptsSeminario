#!/bin/bash

#IP del servidor
SERVER_IP="192.168.1.6"
TAG_HOSTNAME=$(hostname)

# Definir colores
GREEN='\033[0;32m' # Verde
NC='\033[0m' # Sin color


# Funcion para mostrar el menu
function menu(){
    clear
    echo "**Menu de instalación de agente OCS Inventory**"
    echo "1. Instalar agente en SO UBUNTU."
    echo "2. Instalar agente en SO CENTOS."
    echo "3. Salir."
}

# Funcion para ingresar a la opcion seleccionada

function opcion(){
    read -p "Seleccione una opción: " opcion
    case $opcion in
        1)
         printf "\n${GREEN}## INSTALANDO EL AGENTE EN UBUNTU ${NC}\n\n"

        # Instalamos librerias necesarias para la instalacion del agente
        printf "\n${GREEN}## Instalando dependencias ${NC}\n\n"
        apt install -y libmodule-install-perl libxml-simple-perl  libnet-ip-perl libwww-perl libdigest-md5-perl libdata-uuid-perl libcrypt-ssleay-perl libnet-snmp-perl libproc-pid-file-perl libproc-daemon-perl libsys-syslog-perl smartmontools read-edid nmap libnet-netmask-perl make

        # Ingresamos al directorio /opt
        printf "\n${GREEN}## Ingreso al directorio /opt ${NC}\n\n"
        cd /opt/

        # Descargar el agente
        printf "\n${GREEN}## Descargar el agente ${NC}\n\n"
        wget https://github.com/OCSInventory-NG/UnixAgent/releases/download/v2.10.0/Ocsinventory-Unix-Agent-2.10.0.tar.gz

        # Extraer el archivo
        printf "\n${GREEN}## Extraer el archivo ${NC}\n\n"
        tar -xzf Ocsinventory-Unix-Agent-2.10.0.tar.gz

        # Ingresar a la carpeta del agente
        printf "\n${GREEN}## Ingresando a la carpeta del agente ${NC}\n\n"
        cd Ocsinventory-Unix-Agent-2.10.0

        # Creamos un script para la configuración
        printf "\n${GREEN}## Creamos un script para la configuración ${NC}\n\n"
        env PERL_AUTOINSTALL=1 perl Makefile.PL

        # Compilamos
        printf "\n${GREEN}## Compilamos ${NC}\n\n"
        make 

        # Instalar el agente de OCS
        printf "\n${GREEN}## Instalando el agente de OCS ${NC}\n\n"
        make install

        # Configuracion del agente
        printf "\n${GREEN}## Configuracion del agente ${NC}\n\n"
        perl postinst.pl --nowizard --server=$SERVER_IP --crontab --get-old-linux-agent-config --remove-old-linux-agent --tag=$TAG_HOSTNAME --now
        printf "\n${GREEN}## ¡OCS LINUX AGENT INSTALADO Y CONFIGURADO CON ÉXITO!${NC}\n\n"
        sleep 5
        exit
        
        ;;
        2)
        printf "\n${GREEN}## INSTALANDO EL AGENTE EN CENTOS ${NC}\n\n"
        
        # Instalar dependencias
        printf "\n${GREEN}## ## Instalando dependencias ${NC}\n\n"
        yum install -y wget
        yum install -y epel-release 
        yum install -y perl-XML-Simple perl-devel perl-Compress-Zlib perl-Net-IP perl-Digest-MD5 perl-Net-SSLeay perl-Data-UUID
        yum install -y perl-Crypt-SSLeay perl-Net-SNMP perl-Proc-Daemon perl-Proc-PID-File perl-Sys-Syslog pciutils smartmontools
        sleep 2

        # Descargar el agente
        printf "\n${GREEN}## Descargar el agente ${NC}\n\n"
        wget https://github.com/OCSInventory-NG/UnixAgent/releases/download/v2.10.0/Ocsinventory-Unix-Agent-2.10.0.tar.gz
        sleep 2

        # Extraer el archivo
        printf "\n${GREEN}## Extraer el archivo ${NC}\n\n"
        tar -xzf Ocsinventory-Unix-Agent-2.10.0.tar.gz
        sleep 2

        # Ingresar a la carpeta del agente
        printf "\n${GREEN}## Ingresando a la carpeta del agente ${NC}\n\n"
        cd Ocsinventory-Unix-Agent-2.10.0
        sleep 2

        # Creamos un script para la configuración
        printf "\n${GREEN}## Creamos un script para la configuración ${NC}\n\n"
        env PERL_AUTOINSTALL=1 perl Makefile.PL
        sleep 2

        # Compilamos
        printf "\n${GREEN}## Compilamos ${NC}\n\n"
        make 
        sleep 2

        # Instalar el agente de OCS
        printf "\n${GREEN}## Instalando el agente de OCS ${NC}\n\n"
        make install
        sleep 2

        # Configuración del agente
        printf "\n${GREEN}## Configuracion del agente ${NC}\n\n"
        perl postinst.pl --nowizard --server=$SERVER_IP --crontab --get-old-linux-agent-config --remove-old-linux-agent --tag=$TAG_HOSTNAME --now
        printf "\n\n${GREEN}## ¡OCS LINUX AGENT INSTALADO Y CONFIGURADO CON ÉXITO!${NC}\n\n"
        sleep 5
        exit

        ;;
        3)
        echo "Saliendo"
        exit 0
        ;;
        *)
        echo "opción no valida"
        opcion
        ;;

    esac
}

# Bucle principal
while true; do
    menu
    opcion
done