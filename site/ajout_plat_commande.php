<?php session_start(); ?>
<?php

if (!isset($_SESSION["idcli"])) {
  header('Location: accueil.php');
  exit();
}

if ($_POST["quantite"] < 1 || $_POST["quantite"] > 100) {
  header('Location: plat_details.php?plat='.$_GET["plat"].'');
  exit();
}

include("connexion.inc.php");

$req = "SELECT * FROM commande WHERE idcli='".$_SESSION["idcli"]."' ORDER BY numcom DESC LIMIT 1;";
$res = $dbh->query($req);
$commandes = $res->fetchAll();

if (count($commandes) == 0 || $commandes[0]["avancement"] != "création") {
  $req = "INSERT INTO commande(livraison, avancement, montant, adresse, idcli) VALUES ('non', 'création', 0, NULL, '".$_SESSION["idcli"]."');";
  $dbh->exec($req);
}

$req = "SELECT * FROM commande WHERE idcli='".$_SESSION["idcli"]."' ORDER BY numcom DESC LIMIT 1;";
$res = $dbh->query($req);
$commandes = $res->fetchAll();

$numcom = $commandes[0]["numcom"];

$req = "SELECT * FROM commande NATURAL JOIN contient WHERE idcli='".$_SESSION["idcli"]."' AND numcom = ".$numcom.";";
$res = $dbh->query($req);
$res->setFetchMode(PDO::FETCH_ASSOC);

$req = "SELECT prix FROM plat WHERE idplat='".$_GET["plat"]."';";
$plat = $dbh->query($req);
$plat = $plat->fetchAll();

foreach($res as $ligne) {
  if ($ligne["idplat"] == $_GET["plat"]) {
    if ($_POST["quantite"] + $ligne["nombre"] > 100) {
      header('Location: plat_details.php?plat='.$_GET["plat"].'');
      exit();
    }
    $req = "UPDATE contient SET nombre = nombre + ".$_POST["quantite"]." WHERE idplat = '".$_GET["plat"]."';";
    $dbh->exec($req);

    $req = "UPDATE commande SET montant = montant + ".$plat[0]["prix"]." * ".$_POST["quantite"]." WHERE numcom = '".$numcom."';";
    $dbh->exec($req);

    header('Location: commande_details.php?commande='.$numcom.'');
    exit();
  }
}

$req = "INSERT INTO contient VALUES ('".$_GET["plat"]."', ".$numcom.", ".$_POST["quantite"].");";
$dbh->exec($req);

$req = "UPDATE commande SET montant = montant + ".$plat[0]["prix"]." * ".$_POST["quantite"]." WHERE numcom = '".$numcom."';";
$dbh->exec($req);

header('Location: commande_details.php?commande='.$numcom.'');
exit();

?>
