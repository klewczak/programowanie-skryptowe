#!/bin/bash

#zapytanie uzytkownika o plik do podpisania
read -p "podaj nazwe pliku do podpisania: " plik_wej

#sprawdzenie czy uzytkownik podal plik do podpisania
if [ ! -f "$plik_wej" ]
then
        echo "Podaj plik do podpisania!"
        exit -1
fi

#usuniecie koncowki z pliku np .txt
plik="${plik_wej%.*}"

#wygenerowanie klucza prywatnego algorytmem rsa
openssl genpkey -algorithm RSA -out "${plik}_priv_key.pem"

#wygenerowanie klucza publicznego przy pomocy klucza prywatnego
openssl rsa -in "${plik}_priv_key.pem" -pubout -out "${plik}_pub_key.pem"

#podpisanie pliku podanego przez uzytkownika przy pomocy wygenerowanego klucza prywatnego i algorytmu sha256
openssl dgst -sha256 -sign "${plik}_priv_key.pem" -out "${plik}.sig" "$plik_wej"

