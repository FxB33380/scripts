#Script Sauvegarde quotidienne des Users sur le dossier sauvegarde sur le serveur 
# Version 1.0
# Auteur : FX BLADIER


 #On r�cup�re la liste des PC de l'AD
$PCS = dsquery computer  "OU=immeuble,DC=acmegroup,DC=fr" -o rdn

Foreach($thepc in $PCS)
{

#suppression des ""
$thepc= $thepc -replace '"',''

#Pour chaque PC de la liste,  on r�cupr�re les donn�es 
# /M :copie les fichers avec attribut archive, d�sactive l'attribut archive.
# /E :Copie les r�pertoires et sous-r�pertoires, y compris les r�pertoires vides.
# /G :Permet la copie des fichiers chiffr�s vers des destinations qui ne prennent pas en charge le chiffrement
# /Y :Supprime la demande de confirmation de remplacement de fichiers de destination existants.
           
xcopy "\\$thepc\C$\Users" "S:\Sauvegarde\$thepc\" /M /E /G /Y
}   