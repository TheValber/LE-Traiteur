<?php session_start(); ?>
<?php

if (!isset($_SESSION["idcli"])) {
  header('Location: accueil.php');
  exit();
}

include("connexion.inc.php");

$req = "SELECT * FROM commande WHERE numcom='".$_GET['commande']."';";
$res = $dbh->query($req);
$res = $res->fetchAll();

if ($_SESSION["idcli"] != $res[0]["idcli"]) {
  header('Location: accueil.php');
  exit();
}

if ($_POST["livraison"] == "oui" && $_POST["adresse"] == "") {
  header('Location: commande_details.php?commande='.$_GET['commande']);
  exit();
}

if ($_POST["livraison"] == "non") {
  $req = "UPDATE commande SET livraison = 'non' WHERE numcom = ".$_GET['commande'].";";
  $dbh->exec($req);
  $req = "UPDATE commande SET adresse = NULL WHERE numcom = ".$_GET['commande'].";";
  $dbh->exec($req);
  $req = "UPDATE commande SET montant = montant - 10 WHERE numcom = ".$_GET['commande'].";";
  $dbh->exec($req);
} else {
  $req = "UPDATE commande SET livraison = 'oui' WHERE numcom = ".$_GET['commande'].";";
  $dbh->exec($req);
  $req = "UPDATE commande SET adresse = '".$_POST["adresse"]."' WHERE numcom = ".$_GET['commande'].";";
  $dbh->exec($req);
  $req = "UPDATE commande SET montant = montant + 10 WHERE numcom = ".$_GET['commande'].";";
  $dbh->exec($req);
}

header('Location: commande_details.php?commande='.$_GET['commande']);
exit();

?>
