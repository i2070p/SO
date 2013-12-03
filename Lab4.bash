#!/bin/bash

#przykladowe wywolanie:
#bash Lab4.bash Lab4_plik.txt folder P.Zelda

#link do pliku testowego: https://github.com/i2070p/SO/blob/master/Lab4_plik.txt

function m_chmod { #parametry $1 - sciezka do katalogu, $2 - przelaczniki do chmod
  ls "$1" | while read nazwa 
  do
    chmod "$2" "$1/$nazwa"
  done
}


if [ -e "$1" ]; then
  if [ ! -d "$2" ]; then
    mkdir "$2"
  fi
  u_folder=""
  dlugosc_pliku=`cat "$1" | wc -l`
  for ((i=1; i<="$dlugosc_pliku"; i++)); do	

    linia=`head -"$i" "$1" | tail -1`
    nazwa_grupy=`echo "$linia" | cut -f1 -d";"`
    imie_nazwisko=`echo "$linia" | cut -f2 -d";"`

    f_grupy="$2/$nazwa_grupy"
    if [ ! -d "$f_grupy" ]; then
      mkdir "$f_grupy"
    fi
    touch "$f_grupy/$imie_nazwisko"
    if [ "$imie_nazwisko" = "$3" ]; then
       u_folder="$nazwa_grupy"
    fi
  done

  m_chmod "$2/$u_folder" "-w"  
  chmod +w "$2/$u_folder/$3"
  m_chmod "$2" "-x"  
  chmod +x "$2/$u_folder"

else 
  echo "Plik o podanej nazwie nie istnieje."
fi
