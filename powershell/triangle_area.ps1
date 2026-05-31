<#
.SYNOPSIS
skrypt oblicza pole trójkąta
.DESCRIPTION
skrypt pobiera podstawe i wysokość trójkąta po czym oblicza jego pole i wypisuje je
.EXAMPLE
.\triangle_area.ps1
.INPUTS
-
.OUTPUTS
pole trójkąta
.NOTES
-
#>

#stworzenie zmiennej przechowującej długość podstawy trójkąta
#[int]$podstawa= Read-Host -prompt "podaj długość podstawy trójkąta"
#stworzenie zmiennej przechowującej długość wysokości trójkąta
#[int]$wysokość= Read-Host -prompt "podaj wysokość trójkąta"
#obliczenie pola i wypisanie wyniku
function pole_trojkata{
    #podanie parametrów funkcji
    param(
        [int]$podstawa,
        [int]$wysokość
    )
    #wypisanie i obliczenie pola trójkąta
    Write-Host "pole trójkąta wynosi $($wysokość*$podstawa/2)"
}
pole_trojkata 5 6