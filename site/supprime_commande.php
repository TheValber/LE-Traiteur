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

$req = "DELETE FROM commande WHERE numcom = ".$_GET['commande'].";";
$dbh->exec($req);

header('Location: commandes.php');
exit();

?>
