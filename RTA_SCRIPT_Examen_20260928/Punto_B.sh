#!/bin/bash
echo "muestro la estructura"

sudo mkdir -p /Examenes-UTN/{profesores,alumno_{1..3}/parcial_{1..3}}

echo "muestro la estructura"
tree /Examenes-UTN

#!/bin/bash

DISCO=$(sudo fdisk -l |grep "10 G" | awk '{print $2}' | awk -F ':' '{ print $1}')

#Creo Particiones
sudo fdisk $DISCO  << EOF
n
e
1


n

+1G
n

+1G
n

+1G
n

+1G
n

+1G
n

+1G
n

+1G
n

+1G
n

+1G
n


w
EOF

sudo partprobe $DISCO
#Muestro las particiones:
sudo fdisk -l $DISCO

read -p "Enter para continuar: "

# Formateo
printf "/dev/sdc%s\n" {5..14} | xargs -I {} sudo mkfs.ext4 {}


read -p "Enter para continuar: "

#replico la estructura del punto_A.sh
sudo mkdir -p /Examenes-UTN/{profesores,alumno_{1..3}/parcial_{1..3}}

echo "Add Montaje Persistente: "
echo

  

# DEVICEMOUNT-POINTTYPEOPTIONESDUMPCHECK
cat << EOF | sudo tee -a /etc/fstab

${DISCO}5  /Examenes-UTN/alumno_1/parcial_1  ext4   defaults        0   0
${DISCO}6  /Examenes-UTN/alumno_1/parcial_2  ext4   defaults        0   0
${DISCO}7  /Examenes-UTN/alumno_1/parcial_3  ext4   defaults        0   0
${DISCO}8  /Examenes-UTN/alumno_2/parcial_1  ext4   defaults        0   0
${DISCO}9  /Examenes-UTN/alumno_2/parcial_2  ext4   defaults        0   0
${DISCO}10 /Examenes-UTN/alumno_2/parcial_3  ext4   defaults        0   0
${DISCO}11 /Examenes-UTN/alumno_3/parcial_1  ext4   defaults        0   0
${DISCO}12 /Examenes-UTN/alumno_3/parcial_2  ext4   defaults        0   0
${DISCO}13 /Examenes-UTN/alumno_3/parcial_3  ext4   defaults        0   0
${DISCO}14 /Examenes-UTN/profesores          ext4   defaults        0   0

EOF

echo 
echo "monto todo"
sudo mount -a 

echo
echo "muestro lo que esta montado"
echo
sudo df -h  |grep -E 'Filesystem|Examenes-UTN'
