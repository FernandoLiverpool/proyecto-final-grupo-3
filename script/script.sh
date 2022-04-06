#!/bin/bash
NOM_BUCKET="crp-dev-iac-testing-bkt06"
PROYECT="crp-dev-iac-testing"
CLASS="STANDARD"
LOCATION="US"
GRUPO="grupo-03"
CARPETA="carpeta"
DATE=`date`
DATEFORMATO=`date +\%d\-%m\-%Y\_%H\%M`
LOG="grupo-03-$DATEFORMATO.log"
USER=`whoami`
DISTRIBUCION=`cat /etc/os-release | grep "PRETTY"`
TIPOACCESO=on

function_nombre(){
 echo "#################################"
 echo "GRUPO 3"
 echo "HORA Y FECHA DE EJECUCION"
 echo "$DATE"
 echo "$DISTRIBUCION"
 echo "$USER"
 echo "#################################"
}

fuction_crearbucket(){
 echo "Creacion del Bucket" > $LOG
 echo "Nombre del bucket: $NOM_BUCKET" >> $LOG
 echo "#################################"
 echo "CREACION DE BUCKET"
 gsutil mb -p "$PROYECT" -c "$CLASS" -l "$LOCATION" -b "$TIPOACCESO" gs://"$NOM_BUCKET"
 gsutil label ch -l grupo:"$GRUPO" gs://"$NOM_BUCKET"
 gsutil label ch -l proyecto:golondrinas gs://"$NOM_BUCKET"
}

function_crearcarpetagrupo(){
 echo "Creacion del Carpetas y Archivo" >> $LOG
 echo "#################################"
 echo "CREAR ARCHIVO EN LAS CARPETAS"
 touch sinceramente.txt
 for i in {001..100}; do
  echo "Se genera: $GRUPO / $CARPETA - $i " >> $LOG
  gsutil cp sinceramente.txt gs://"$NOM_BUCKET"/"$GRUPO"/"$CARPETA"-"$i"/ >>  $LOG
 done
}

function_contenido(){
  echo "Carpetas con archivo no vacio" >>  $LOG
  echo "Carpetas con archivo no vacio" 
  for i in {001..100}; do
    CARPETA=gs://"$NOM_BUCKET"/grupo-03/carpeta-${i}
    LS=$(gsutil ls -l $CARPETA/sinceramente.txt | grep '0 bytes')  
    if [ "$LS" != "TOTAL: 1 objects, 0 bytes (0 B)" ]; then
    echo "$CARPETA" >>  $LOG
    echo "$CARPETA"
    fi
   done
}

function_nombre > $LOG
function_nombre
fuction_crearbucket
function_crearcarpetagrupo