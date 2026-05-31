<#
.SYNOPSIS
skrypt robi raport podstawowych parametrów urządzenia
.DESCRIPTION
skrypt pobiera podstawowe informacje na  temat urządzenia z utworzonego pliku po czym
robi raport tych które są oznaczone jako 'TRUE'. Wyniki wysyła do pliku txt.
.EXAMPLE
.\host_raport.ps1
.INPUTS
-
.OUTPUTS
plik .txt z parametrami hosta
.NOTES
-
#>

function tworzenie_pliku_csv(){
    #wypisanie całej zawartości pliku
    $zawartość = Write-Output "Component;GenerateRaport`nComputername;True`nManufacturer;True`nModel;True`nSerialNumber;True`nCpuName;False`nRAM;True"
    #przekazanie wypisanego tekstu do nowo utworzonego pliku 
    $zawartość | New-Item -Path "C:\Users\malgo\input_file.csv" -Itemtype "File" -Force
}
#wywołanie funkcji tworzenie_pliku_csv
tworzenie_pliku_csv

function dane_z_pliku_csv{
    #pobieranie danych z pliku csv i stworzenie z niego obiektu
    #przypisanie danych w kazdej linijce dzielimy znakiem ";"
    $dane = Import-Csv -Path "C:\Users\malgo\input_file.csv" -Delimiter ";"
    #zwrócenie danych jako wynik całej funkcji
    return $dane
}
#wywołanie funkcji dane_z_pliku_csv
dane_z_pliku_csv

#dla każdych danych z wiersza wyciągamy wartość componentu dla odpowiedniej
#nazwy  sprawdzamy czy wartość raportu jest prawdziwa, jeżeli tak, wypisujemy
#nazwe componentu i wartość odpowiadającej mu zawartości komendy Get-ComputerInfo
#(niestety nie mam pojęcia czy to jest poprawnie zrobione ale wynik wypisuje dobry)
function Raport(){
    foreach ($wiersz in dane_z_pliku_csv) {
        switch ($($wiersz.Component)){
        "ComputerName" {
            if ( ($wiersz).GenerateRaport -eq "True" ){
                Write-Output "$($wiersz.Component): $((Get-ComputerInfo).CsName)"
            }}
        "Manufacturer" {
            if ( ($wiersz).GenerateRaport -eq "True" ){
                Write-Output "$($wiersz.Component): $((Get-ComputerInfo).CsManufacturer)"
            }}
        "Model" {
            if ( ($wiersz).GenerateRaport -eq "True" ){
                Write-Output "$($wiersz.Component): $((Get-ComputerInfo).CsSystemFamily)"
            }}
        "SerialNumber" {
            if ( ($wiersz).GenerateRaport -eq "True" ){
                Write-Output "$($wiersz.Component): $((Get-ComputerInfo).BiosSeralNumber)"
            }}
        "CpuName" {
            if ( ($wiersz).GenerateRaport -eq "True" ){
                Write-Output "$($wiersz.Component): $((Get-ComputerInfo).CsProcessors.name)"
            }}
        "RAM" {
            if ( ($wiersz).GenerateRaport -eq "True" ){
                Write-Output "$($wiersz.Component): $((Get-ComputerInfo).CsTotalPhysicalMemory)"
            }}
        }
    }
}
#wywołanie funkcji
Raport
function przesłanie_do_pliku.txt(){
    #pobranie nazwy pliku aby nazwa była taka w całej funkcji i nie zmieniały się sekundy
    $ścieżka_pliku = "C:\Users\malgo\ComputerReport_$(Get-Date -Format 'yyyyMMdd-HHmmss').txt"
    #przekazanie wyniku funkcji do nowo utworzonego pliku 
    Raport | Out-File -FilePath $ścieżka_pliku -Force
    #wypisanie w jakim pliku zostały zapisane dane skryptu
    Write-Output "Raport został zapisany w pliku: $ścieżka_pliku"
}
#wywołanie funkcji
przesłanie_do_pliku.txt