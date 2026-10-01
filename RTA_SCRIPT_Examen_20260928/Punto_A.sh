#!/bin/bash
echo "Creo la estructura"

sudo mkdir -p /Examenes-UTN/{profesores,alumno_{1..3}/parcial_{1..3}}

echo "muestro la estructura"
tree /Examenes-UTN
