<#
.SYNOPSIS
skrypt sprawdza czy podana przez użytkownika liczba jest większa od 10
.DESCRIPTION
skrypt sprawdza wielkość liczby podanej przez użytkownika, czy liczba jest większa, mniejsza czy równa 10.
.EXAMPLE
.\number_check.ps1
.INPUTS
liczba rzeczywista
.OUTPUTS
informacja o wielkości podanej liczby
.NOTES
-
#>

#umożliwienie użytkownikowi podanie liczby która będzie sprawdzana pod podanymi warunkami
[int]$liczba= Read-Host -prompt "podaj liczbę, aby sprawdzić czy jest większa, równa lub mniejsza od 10"
#sprawdzenie czy liczba jest większa od 10
if ($liczba -gt 10){
    Write-Host "liczba większa od 10"
}
#sprawdzenie czy liczba jest równa 10
elseif ($liczba -eq 10){
       Write-Host "liczba równa 10"
}
#jeżeli powyższe stwierdzenia nie są prawdziwe wypisuje ostatnią możliwość
else{
    Write-Host "liczba mniejsza od 10"
}