<#
.SYNOPSIS
skrypt robi raport podstawowych parametrów urządzenia
.DESCRIPTION
skrypt wypisuje nazwe komputera, wersję systemu, obecną date, obecnego użytkownika i adresy ip
.EXAMPLE
.\computer_info.ps1
.INPUTS
-
.OUTPUTS
podstawowe informacje o urządzeniu
.NOTES
-
#>

function nazwa_komp(){
    #wypisanie zmiennej środowiskowej zawierającej nazwe komputera
    $env:COMPUTERNAME
}
function wersja_systemu(){
    #wyciągnięcie i wypisanie wersji systemu z obiektu PSVersionTable
    Write-Host "wersja systemu na $(nazwa_komp) to : $(($PSVersionTable).PSVersion)"
}
function obecna_data(){
    #wypisanie daty z cmdletu Get-Date
    Write-Host "obecna data na $(nazwa_komp) to: $(Get-Date)"
}
function obecny_użytkownik{
    #wypisanie obecnego użytkownika ze zmiennej środowiskowej
    Write-Host "obecny użytkownik na $(nazwa_komp) to $($env:USERNAME)"
}
function adres_ip{
    #wyciągnięcie i wypisanie adresu ipv6 i ipv4 interfaców z cmdletu Get-NetIPAddress
    Write-Host "obecne adresy ip na $(nazwa_komp) to $(Get-NetIPAddress).IPAddress"
}
#wywołanie każdej z funkcji
obecna_data
wersja_systemu
obecny_użytkownik
adres_ip