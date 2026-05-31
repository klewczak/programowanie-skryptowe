<#
.SYNOPSIS
Skrypt pobiera kursy walut z nbp rest-api.
.DESCRIPTION
Skrypt prosi publiczne nbp rest-api o kursy waluty podanej jako parametr przez użytkownika np. USD, EUR. z ostatnich pięciu dni.
Parametr powinien zgadzać się ze standardem ISO 4217 i zostać zapisany w trzyliterowej formie. 
Skrypt następnie oblicza różnice pomiędzy następującymi po sobie dniami.
.EXAMPLE
.\Api_nbp "USD"
.INPUTS
Trzyliterowy kod waluty (standard ISO 4217).
.OUTPUTS
Skrytp wypisuje kursy podanej waluty dla odpowiednich dni oraz różnice pomiędzy nimi.
.NOTES
-
#>

#utworzenie parametru waluty
param(
    $waluta
)

#dodanie nagłówka do zapytania api, aby przyjmować odpowiedz w formacie json
$header=@{ "Accept" = "application/json" }

try {
#zapytanie typu GET o dane dotyczące konkretnej waluty z ostatnich 5 dni
$response=Invoke-RestMethod -Method Get -Uri "https://api.nbp.pl/api/exchangerates/rates/a/$waluta/last/5/" -Headers $header
}
catch {
    return Write-Output "Podana waluta nie istnieje lub wystąpił błąd "
}

#wypisanie polskiej nazwy waluty
Write-Output "Waluta: $($response.currency)"
Write-Output ""

Write-Output "Wartość waluty dla poszczególnych dni:"

#pętla przechodząca po każdym indeksie wyniku waluty
for ($x=0; $x -lt ($response.rates.mid.Count); $x++){
    
    Write-Output "$($response.rates.effectiveDate[$x]) -> $($response.rates.mid[$x])"

}

Write-Output ""
Write-Output "Różnice pomiędzy każdym dniem:"
#pętla przechodząca do przedostatniego indeksu tablicy otrzymanych wartości waluty ( 0->3 )
for ($x=0; $x -lt ($response.rates.mid.Count-1); $x++){
        
        #odjęcie otrzymanych wartości ( pierwszy dzień od drugiego, drugi dzień od trzeciego etc.)
        $subtracted=$response.rates.mid[$x] - $response.rates.mid[$x+1]
        
        #wypisanie dokładnej daty dni których wartości zostały odjęte
        Write-Output "$($response.rates.effectiveDate[$x]) - $($response.rates.effectiveDate[$x+1])"
        
        #wypisanie wyniku odejmowania
        Write-Output $subtracted

        Write-Output ""
}