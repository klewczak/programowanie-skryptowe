<#
.SYNOPSIS
skrypt przenosi pliki .txt
.DESCRIPTION
po uruchomieniu skrypt przenosi wszystkie pliki .txt z katalogu, który nie ma mieć żadnych
wskazanych plików do katalogu do tego przeznaczonego.
.EXAMPLE
.\file_watcher
.INPUTS
-
.OUTPUTS
skrypt przenosi pliki .txt z jednego folderu do drugiego
.NOTES
-
#>

#podanie sciezki do folderu ktory ma byc obserwowany
$oldpath="C:\Users\Kacper\Documents\Bez_txt"
#podanie sciezki do nowego folderu
$newpath="C:\Users\Kacper\Documents\Z_txt"
#utworzenie tych folderow (na rzecz cwiczenia)
New-Item -Path $newpath -ItemType "Directory" -Force
New-Item -Path $oldpath -ItemType "Directory" -Force
#utworzenie nowego obiektu z gotowca System.IO.FileSystemWatcher
$watcher=New-Object System.IO.FileSystemWatcher
#dodanie sciezki ktora obiekt ma obserwowac
$watcher.Path = $oldpath
#dodanie filtru dla obiektu na ktorego ma reagowac
$watcher.Filter = "*.txt"
#wlaczenie reagowania na eventy
$watcher.EnableRaisingEvents=$true
#utworzenie akcji ktora bedzie wykonywac nasz nowo utworzony obiekt FileSystemWatcher
$action={
    #utowrzenie zmiennych dla obecnego pliku wykrytego przez obserwatora
    $sciezka = $Event.SourceEventArgs.FullPath
    $nazwa = $Event.SourceEventArgs.Name
    #przeniesienie go do nowego folderu
    Move-Item -Path $sciezka -Destination "$newpath\$nazwa"
    Write-Host "pomyślnie przeniesiono $nazwa z $oldpath do $newpath"
}
#utworzenie nowej pracy dla obiektu
Register-ObjectEvent -InputObject $watcher -EventName "Created" -SourceIdentifier FileCreated -Action $action