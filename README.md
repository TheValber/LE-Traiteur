# LE Traiteur [EN]

University Project

Website of a caterer that works with a database.



# LE Traiteur [FR]

Projet Universaitaire

Site d'un traiteur qui fonctionne avec une base de données.

## Comment installer ?

1. Téléchargez les fichiers

2. Chargez la base de données PostgreSQL et les données d'exemple aavec le dump fourni

3. Modifiez le fichier connexion.inc.php avec les identifiants de votre base de données

#### En ligne :

4. Uploadez tous les fichiers/dossiers du dossier "site"   (Passez si vous voulez le lancer en local)

5. Entrez l'URL du site, cela lancera index.php sur votre navigateur

#### En local :

4. Lancez index.php sur votre navigateur

## Manuel d'utilisation du site

En entrant sur le site, la première page sur laquelle se trouve l’utilisateur est la page de bienvenue. Il suffit de cliquer sur « Miam » pour accéder à la page d’accueil du site.

En haut de la page d’accueil, comme toutes les pages du site (à l’exception de la page de bienvenue) se trouve deux boutons : « connexion » et « inscription », permettant respectivement de se connecter à son compte, ou d’en créer un nouveau.

Pour créer un compte, il faut obligatoirement renseigner un identifiant et un mot de passe, et optionnellement un nom, un prénom (tous deux sans accents, sans caractères spéciaux et ayant une longueur maximale de 25 caractères) ainsi qu’un numéro de téléphone. Seul le personnel peut accéder à ces informations.

Une fois inscrit, la connexion est automatique. Un unique bouton « déconnexion » remplace les boutons « connexion » et « inscription ». Si vous vous déconnectez, vous pouvez vous reconnecter sans recréer de compte grâce au bouton « connexion » qui va vous amener sur la page de connexion.

Cette page est plutôt simple, rentrez l’identifiant et le mot de passe associés au compte précédemment créé pour vous connecter, et vous serez redirigés vers la page d’accueil.
Pour commander, il suffit de cliquer sur un plat (sur la page d’accueil, où les plats les plus commandés sont affichés, ou dans « Plats »), ce qui amène sur la page de détail du plat en question. En rentrant une quantité et en cliquant sur « Ajouter à la commande », si aucune commande n’est en cours de création sur votre compte, une nouvelle commande contenant le plat dans la quantité désirée sera créée automatiquement.

Une fois la quantité confirmée, vous serez redirigé vers le détail de votre commande. Plusieurs options s’offrent à vous : ajouter une option de livraison (plutôt que de réaliser une commande à emporter), valider la commande ou la supprimer définitivement.

Validez la commande, et son statut passera de « en création » à « en attente », indiquant que votre commande a été confirmée et est désormais en préparation. Il n’y a plus qu’à attendre !

Vous pouvez consulter l’historique de vos commandes sur la page « Mes Commandes ».

La page « Notre équipe » liste le personnel du site (aucune de ces personnes n’existe réellement).
