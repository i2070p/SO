#!/bin/bash

#przykladowe wywolanie
#bash Lab4.bash Lab4_plik.txt folder P.Zelda
if [ -e "$1" ]; then
  if [ ! -d "$2" ]; then
    mkdir "$2"
  fi
  u_folder=""
  dlugosc_pliku=`cat "$1" | wc -l`
  for ((i=1; i<="$dlugosc_pliku"; i++)); do	

    linia=`sed -n "$i"p "$1"`
    nazwa_grupy=`echo "$linia" | cut -f1 -d";"`
    imie_nazwisko=`echo "$linia" | cut -f2 -d";"`

    f_grupy="$2/$nazwa_grupy"
    if [ ! -d "$f_grupy" ]; then
      mkdir "$f_grupy"
    fi
    touch "$2/$nazwa_grupy/$imie_nazwisko.txt"
    
    if [ "$imie_nazwisko" != "$3" ]; then
       u_folder="$nazwa_grupy"
    fi
  done

  #najprostrze rozwiazanie jak ktos chce moze sie pobawic poleceniem - tr
  cd "$2/$u_folder"  
  chmod -w `ls`
  chmod +w "$3"
  cd .. 
  chmod -x `ls`
  chmod +x "$u_folder"

else 
  echo "Plik o podanej nazwie nie istnieje."
fi
