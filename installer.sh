#!/bin/bash
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

function ctrl_c(){
 echo -e "\n\n${redColour}[!]Saliendo...${endColour}"
 tput cnorm && exit 1
}

#ctrl_C
trap ctrl_c INT

menuLista=(
	"${yellowColour}INSTALAR LIBRERIAS NECESARIAS PARA MYSQL CLUSTER(SE RECOMIENDA EN TODOS LOS NODOS)${endColour}"
	"${grayColour}INSTALAR LIBRERIAS EN NODO ADMINISTRADOR${endColour}"
	"${blueColour}INSTALAR LIBRERIAS MYSQL CLUSTER SERVER Y CLIENT EN NODOS REPLICATION${endColour}"
	"${greenColour}DESEMPAQUETAR${endColour}"
	"${redColour}SALIR${endColour}"
)


function descripcion_menu(){
 index=0
 for item in "${menuLista[@]}"; do
	((index = index +1))
	echo -e "[$index.]	${item}"
 done
}

function continuar(){
	while true; do
		echo -e "${blueColour}Deseas Continuar en la aplicacion S/N? : ${endColour}"
		read -p ''  yn
		case $yn in
			[Ss]*)
			menu 
			break
			;;
			[Nn]*)
			exit
			;;
			*) logWarn "Escriba S para continuar o N para Salir " ;;
			esac
	done
}

function libreriasNecesarias(){
apt install libclass-methodmaker-perl -y
apt install libaio1 libmecab2 -y
}

function instalarLibreriasNodoAdmin(){
wget https://dev.mysql.com/get/Downloads/MySQL-Cluster-8.0/mysql-cluster-community-management-server_8.0.33-1ubuntu18.04_amd64.deb
}

function instalarLibreriasNodos(){
wget https://dev.mysql.com/get/Downloads/MySQL-Cluster-8.0/mysql-cluster-community-client-plugins_8.0.33-1ubuntu18.04_amd64.deb
wget https://dev.mysql.com/get/Downloads/MySQL-Cluster-8.0/mysql-common_8.0.33-1ubuntu18.04_amd64.deb
wget https://dev.mysql.com/get/Downloads/MySQL-Cluster-8.0/mysql-cluster-community-client-core_8.0.33-1ubuntu18.04_amd64.deb
wget https://dev.mysql.com/get/Downloads/MySQL-Cluster-8.0/mysql-cluster-community-client_8.0.33-1ubuntu18.04_amd64.deb
wget https://dev.mysql.com/get/Downloads/MySQL-Cluster-8.0/mysql-client_8.0.33-1ubuntu18.04_amd64.deb
wget https://dev.mysql.com/get/Downloads/MySQL-Cluster-8.0/mysql-cluster-community-server-core_8.0.33-1ubuntu18.04_amd64.deb
wget https://dev.mysql.com/get/Downloads/MySQL-Cluster-8.0/mysql-cluster-community-server_8.0.33-1ubuntu18.04_amd64.deb
wget https://dev.mysql.com/get/Downloads/MySQL-Cluster-8.0/mysql-server_8.0.33-1ubuntu18.04_amd64.deb
wget https://dev.mysql.com/get/Downloads/MySQL-Cluster-8.0/mysql-cluster-community-data-node_8.0.33-1ubuntu18.04_amd64.deb

}


function desempaquetarLibrerias(){
dpkg -i mysql-*
}

function logWarn(){
	echo -e "Elige una opcion: "
}

function menu(){
	while true; do
		echo -e "\t----------------------------------------------------"
		descripcion_menu
		echo -e "\t----------------------------------------------------"
		read -p "ESCOJA LA OPCION CON EL NUMERO INDICADO: " op
		case $op in 
			1)
			libreriasNecesarias
			continuar
			break
			;;
			2)
			instalarLibreriasNodoAdmin
			continuar
			break
			;;
			3)
			instalarLibreriasNodos
			continuar
			break
			;;
			4)
			desempaquetarLibrerias
			continuar
			break
			;;
			5) 
			echo -e "${redColour}Saliendo..."
			exit	;;
			*)logWarn
			esac
	done
}

menu


