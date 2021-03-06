#Script Sauvegarde quotidienne des Dossiers  Users depuis les PCs sur le dossier sauvegarde sur le serveur 
# Version 2.0
# Auteur : FX BLADIER


#On récupère la liste des PC de l'AD
$PCS = dsquery computer  "OU=immeuble,DC=acmegroup,DC=fr" -o rdn
$nbpctotal = $pcs.Count
$nbpcsauvegardes = 0
Foreach ($thepc in $PCS) {
    #suppression des ""
    $thepc = $thepc -replace '"', ''
   

    #Pour chaque PC de la liste,  on récuprère les données 
    # /M :copie les fichers avec attribut archive, désactive l'attribut archive.
    # /E :Copie les répertoires et sous-répertoires, y compris les répertoires vides.
    # /G :Permet la copie des fichiers chiffrés vers des destinations qui ne prennent pas en charge le chiffrement
    # /Y :Supprime la demande de confirmation de remplacement de fichiers de destination existants.

    # On teste la connexion au PC 
    if (Test-Connection -ComputerName $thepc -Count 1 -Quiet) {  
    # on lance la sauvegarde des dossiers       
        xcopy "\\$thepc\C$\Users" "S:\Sauvegarde\$thepc\" /M /E /G /Y
        $nbpcsauvegardes++ 
        Write-Host "La sauvegarde de $thepc a �t� effectu�e"
        
    }
    else {
        Write-Host "$thepc est �teint"
    }
}
#on indique dans le journal d'�v�nements si la t�che s'est correctement ex�cut�e ou pas 
if ($nbpcsauvegardes -eq $nbpctotal) {
    Write-EventLog -LogName Application -Source "Backup PCS" -EntryType Information -EventId 1 -Message "Tous les Pcs ont été sauvergard�s"
}
elseif ($nbpcsauvegardes -eq 0) {
    Write-EventLog -LogName Application -Source "Backup PCS" -EntryType Error -EventId 1 -Message "Aucun PC sauvegard�"
}
else {
    Write-EventLog -LogName Application -Source "Backup PCS" -EntryType Warning -EventId 1 -Message "$nbpcsauvegardes / $nbpctotal PCS sauvegard�s"
}