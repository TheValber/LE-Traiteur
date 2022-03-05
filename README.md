# LE Traiteur [EN]

University Project

Website of a caterer that works with a database.

(All the website is in French)

## How to install ?

1. Download all the files

2. Load the PostgreSQL database and upload data with the provided dump

3. Edit the connection.inc.php file with your database credentials

#### Online :

4. Upload all files/folders in the "site" folder (Skip if you want to run it locally)

5. Enter the site URL, this will launch index.php on your browser

#### Local :

4. Run index.php on your browser

## Site User Manual

When entering the site, the first page the user is on is the welcome page. Just click on "Miam" (Yum) to access the home page of the site.

At the top of the home page, like all the pages of the site (with the exception of the welcome page) there are two buttons: "connexion" (login) and "inscription" (registration), respectively allowing you to connect to your account, or to create a new one.

To create an account, you must enter an identifier and a password, and optionally a surname, a first name (both without accents, without special characters and having a maximum length of 25 characters) as well as a telephone number. Only the database owner can access this information.

Once registered, the connection is automatic. A single "déconnexion" (logout) button replaces the "connexion" (login) and "inscription" (registration) buttons. If you disconnect, you can reconnect without recreating an account using the "connexion" (login) button which will take you to the connection page.

This page is quite simple, enter the username and password associated with the account previously created to connect, and you will be redirected to the home page.

To order, simply click on a dish (on the home page, where the most ordered dishes are displayed, or in "Plats" (Dishes)), which leads to the detail page of the dish in question. By entering a quantity and clicking on "Ajouter à la commande" (Add to order), if no order is being created on your account, a new order containing the dish in the desired quantity will be created automatically.

Once the quantity is confirmed, you will be redirected to your order details. Several options are available to you: add a delivery option (rather than making a take-out order), validate the order or delete it permanently.

Validate the order, and its status will change from "en création" (in creation) to "en attente" (pending), indicating that your order has been confirmed and is now in preparation. All that's left to do is wait!

You can view your order history on the "Mes Commandes" (My Orders) page.

The "Notre équipe" (Our Team) page lists the staff of the site (none of these people actually exist).

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

Pour créer un compte, il faut obligatoirement renseigner un identifiant et un mot de passe, et optionnellement un nom, un prénom (tous deux sans accents, sans caractères spéciaux et ayant une longueur maximale de 25 caractères) ainsi qu’un numéro de téléphone. Seul propriétaire de la base de données peut accéder à ces informations.

Une fois inscrit, la connexion est automatique. Un unique bouton « déconnexion » remplace les boutons « connexion » et « inscription ». Si vous vous déconnectez, vous pouvez vous reconnecter sans recréer de compte grâce au bouton « connexion » qui va vous amener sur la page de connexion.

Cette page est plutôt simple, rentrez l’identifiant et le mot de passe associés au compte précédemment créé pour vous connecter, et vous serez redirigés vers la page d’accueil.
Pour commander, il suffit de cliquer sur un plat (sur la page d’accueil, où les plats les plus commandés sont affichés, ou dans « Plats »), ce qui amène sur la page de détail du plat en question. En rentrant une quantité et en cliquant sur « Ajouter à la commande », si aucune commande n’est en cours de création sur votre compte, une nouvelle commande contenant le plat dans la quantité désirée sera créée automatiquement.

Une fois la quantité confirmée, vous serez redirigé vers le détail de votre commande. Plusieurs options s’offrent à vous : ajouter une option de livraison (plutôt que de réaliser une commande à emporter), valider la commande ou la supprimer définitivement.

Validez la commande, et son statut passera de « en création » à « en attente », indiquant que votre commande a été confirmée et est désormais en préparation. Il n’y a plus qu’à attendre !

Vous pouvez consulter l’historique de vos commandes sur la page « Mes Commandes ».

La page « Notre équipe » liste le personnel du site (aucune de ces personnes n’existe réellement).
