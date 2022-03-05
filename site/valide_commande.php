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

$req = "SELECT * FROM commande NATURAL JOIN contient NATURAL JOIN compose WHERE idcli='".$_SESSION["idcli"]."' AND numcom = ".$_GET['commande'].";";
$res = $dbh->query($req);
$res->setFetchMode(PDO::FETCH_ASSOC);
$res2 = $res->fetchAll();

if (count($res2) == 0) {
  header('Location: commande_details.php?commande='.$_GET['commande']);
  exit();
}

foreach ($res as $plat) {
  $req = "UPDATE ingredient SET quantite = quantite - ".($plat["nombre"] * $plat["quantite"])." WHERE idingr = '".$plat["idingr"]."';";
  $dbh->exec($req);
}

$req = "UPDATE commande SET avancement = 'attente' WHERE numcom = ".$_GET['commande'].";";
$dbh->exec($req);

header('Location: commandes.php');
exit();

?>
