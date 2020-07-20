# Cr�ation du script pour lister les membres d'un groupe avec export CSV
# Version 1.0
# Auteur : FX BLADIER 

# Importation de l'Active Directory

Import-Module ActiveDirectory

#Cr�ation de la fonction continue 

$continue = "yes"
while(($continue -eq "yes") -or ($continue -eq "y") -or ($continue -eq "oui") -or ($continue -eq "o")){

# Renseignement du groupe  extraire

$groupe = Read-Host "Merci de renseigner le nom du groupe � exporter"
 
  if($groupe -like "DM")
{
  $path ='S:\Sauvegarde\Listings\DIRECTION MARKETING'
      }
    elseif ($groupe -like "Accueil")
{
    $path ='S:\Sauvegarde\Listings\ACCUEIL'
    }
     elseif ($groupe -like "DIF")
{
    $path ='S:\Sauvegarde\Listings\DIRECTION FINANCIERE'
    }
         elseif ($groupe -like "DG")
{
    $path ='S:\Sauvegarde\Listings\DIRECTION GENERALE'
    }
           elseif ($groupe -like "DRH")
{
    $path ='S:\Sauvegarde\Listings\DIRECTION RESSOURCES HUMAINES'
    }
               elseif ($groupe  -like "DRT")
{
   $path ='S:\Sauvegarde\Listings\DIRECTION TECHNIQUE'   

}
               elseif ($groupe  -like "Stagiaires")
{
   $path ='S:\Sauvegarde\Listings\STAGIAIRES'   

}
else
{
echo " l'export ne peut pas �tre r�alis� car le groupe n'existe pas sur le Domaine"
exit 1 
}
#Cr�ation du Fichier d'export CSV

Get-ADGroupMember -identity $groupe |select name | sort-object -property name| Export-csv -Encoding UTF8 -path $path'-Membres.txt' -Delimiter ";" -NoTypeInformation
echo "L'export s'est correctement termin�"
$continue = Read-Host "voulez-vous continuer Oui ou non ?"
}
