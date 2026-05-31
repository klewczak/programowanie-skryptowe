#!/bin/bash

#zapytanie uzytkownika o plik do zaszyfrowania
read -p "podaj nazwe pliku do zaszyfrowania: " plik_wej

#sprawdzenie czy uzytkownik podal plik do zaszyfrowania
if [ ! -f $plik_wej ]
then
	echo "Podaj plik do zaszyfrowania! './encrypt_file file'"
	exit -1
fi

#zmienienie koncowki pliku na enc
plik_wyj="${plik_wej%.*}.enc"

#stworzenie pliku wyjsciowego ze zmieniona nazwa
touch "$plik_wyj"

#zaszyfrowanie pliku podanego przez uzytkownika uzywajac aes
openssl enc -aes-256-cbc -p -pbkdf2 -in $plik_wej -out $plik_wyj
