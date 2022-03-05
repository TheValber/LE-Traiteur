<?php session_start(); ?>
<?php

if (!isset($_SESSION["idcli"])) {
  header('Location: accueil.php');
  exit();
}

include("connexion.inc.php");

$req = "SELECT * FROM commande WHERE numcom='".$_GET['commande']."';";
$res = $dbh->query($req);
$res->setFetchMode(PDO::FETCH_ASSOC);

foreach($res as $com) {
  if ($_SESSION["idcli"] != $com["idcli"] || $com["avancement"] != "création") {
    header('Location: accueil.php');
    exit();
  }
}

$req = "SELECT * FROM plat NATURAL JOIN contient NATURAL JOIN commande WHERE numcom=".$_GET['commande']." AND idplat='".$_GET['plat']."';";
$res = $dbh->query($req);
$res = $res->fetchAll();

$prix = $res[0]["prix"] * $res[0]["nombre"];
echo $prix;

$req = "UPDATE commande SET montant = montant - ".$prix." WHERE numcom = '".$_GET['commande']."';";
$dbh->exec($req);

$req = "DELETE FROM contient WHERE numcom = ".$_GET['commande']." AND idplat = '".$_GET['plat']."';";
$dbh->exec($req);

header("Location: commande_details.php?commande=".$_GET['commande']);
exit();

?>
