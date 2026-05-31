<#
.SYNOPSIS
skrypt przyjmuje hasło i nazwe użytkownika po czym sprawdza czy podane dane są poprawne
.DESCRIPTION
skrypt przyjmuje podane przez użytkownika dane logowania i sprawdza czy są one poprawne
stosowane jest również maskowanie hasła podanego przez użytkownika
.EXAMPLE
.\admin_login.ps1
.INPUTS
hasło, nazwa użytkownika
.OUTPUTS
informacja o statusie zalogowania
.NOTES
-
#>

#umożliwienie wpisania przez użytkownika nazwy konta
[string]$nazwa= Read-Host -prompt "podaj nazwe użytkownika"

#umożliwienie wpisania przez użytownika hasła z opcją zasłonięcia wpisywanych danych 
$hasło_secure= Read-Host -prompt "podaj hasło" -AsSecureString

#stworzenie nowego obiektu typu System.Net.NetworkCredential do którego pakujemy
#naszą nazwę użytkownika oraz zasłonięte hasło, które przechowuje je jako zaszyfrowane
#hasło oraz czysty tekst pod właściwością .Password
$dane= New-Object System.Net.NetworkCredential($nazwa, $hasło_secure)

#sprawdzenie czy podane przez użytkownika dane zgadzają się z podanym hasłem i nazwą
if (( $dane.UserName -eq "admin" ) -and ( $dane.Password -eq "password" )){
    Write-Host "Pomyślnie zalogowano."
}
else {
    Write-Host "Nie udało się zalogować. Spróbuj ponownie."
}