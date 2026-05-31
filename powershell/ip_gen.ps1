<#
.SYNOPSIS
skrypt generuje adresy ip od 0 do 10 adresu sieciowego 192.168.1.0
.DESCRIPTION
skrypt generuje adresy adresu sieciowego 192.168.1.0 przechodzą od 0 do 10 zmieniając hosta
.EXAMPLE
.\ip_gen.ps1
.INPUTS
-
.OUTPUTS
10 adresów hosta z adresu sieciowego 192.168.1.0
.NOTES
-
#>

#stworzenie pętli która przechodzi od x=0 do x=9
for ($x=0; $x -lt 10; $x++){
    #wypisanie adresu ze zmienną $x na końcu
    Write-Host "192.168.1.$x"
}