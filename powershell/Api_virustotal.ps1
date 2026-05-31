<#
.SYNOPSIS
skrypt wysyła plik do virustotal i podaje jego raport
.DESCRIPTION
skrypt pobiera ścieżke pliku podanego przez użytkownika, oblicza jego hasha i wysyła zapytanie do virustotal
o sprawdzenie pliku. Jeżeli strona posiada raport na temat pliku wysyła ile zagrażeń zawiera plik które są
wyświetlane użytkownikowi
.EXAMPLE
.\Api_virustotal .\Documents\file.txt
.INPUTS
ścieżka do pliku
.OUTPUTS
skrypt sprawdza czy podany plik jest bezpieczny i wypisuje otrzymany wynik
.NOTES
-
#>

#dodanie parametru path ktory zawiera sciezke pliku
param(
    $path
)
#obliczenie i podanie sumy kontrolnej pliku
$hash=(Get-FileHash -Path $path -Algorithm SHA256).Hash
Write-Host "suma kontrolna pliku o sciezce $path to: $hash"
#dodanie nagłówków zapytania ktore zawieraja klucz api i informuja o akceptacji formatu json
$headers=@{}
$headers.Add("accept", "application/json")
$headers.Add("x-apikey", $env:Apikey_virustotal)
#wysłanie zapytania do api virustotal o analize wybranego pliku
$analiza = Invoke-RestMethod -Uri "https://www.virustotal.com/api/v3/files/$hash" -Method GET -Headers $headers
#z otrzymanych danych wyciagniecie tylko ilości wykrytych niebezpieczenstw
$malicious=$analiza.data.attributes.last_analysis_stats.malicious
#sprawdzenie czy wykryto jakies niebezpieczenstwa
if ( $malicious -gt 0 ){
    Write-Host "Wykryto $malicious zagrozen! plik wydaje sie niebezpieczny."
}
else{
    Write-Host "Plik wydaje sie bezpieczny."
}
