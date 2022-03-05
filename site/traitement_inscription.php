<?php session_start(); ?>
<?php

include("connexion.inc.php");

$req = "SELECT count(*) AS nb_login FROM client WHERE login='".$_POST["login"]."';";
$res = $dbh->query($req);
$res->setFetchMode(PDO::FETCH_ASSOC);

foreach($res as $ligne) {
  if ($ligne['nb_login'] > 0) {
    header('Location: inscription.php');
    exit();
  }
}

/*
if (!preg_match("#-'[A-Za-z0-9]#", $_POST["login"]) && strlen($_POST["login"]) > 25){
  header('Location: inscription.php');
  exit();
}
*/

if ($_POST["nom"] == "") {
  $nom = "NULL";
} else {
  /*
  if (!preg_match("#-'[A-Za-z0-9]#", $_POST["nom"]) && strlen($_POST["nom"]) > 25){
    header('Location: inscription.php');
    exit();
  }
  */
  $nom = "'".$_POST["nom"]."'";
}
if ($_POST["prenom"] == "") {
  $prenom = "NULL";
} else {
  /*
  if (!preg_match("#-'[A-Za-z0-9]#", $_POST["prenom"]) && strlen($_POST["prenom"]) > 25){
    header('Location: inscription.php');
    exit();
  }
  */
  $prenom = "'".$_POST["prenom"]."'";
}
if ($_POST["telephone"] == "") {
  $telephone = "NULL";
} else {
  $telephone = "'".$_POST["telephone"]."'";
}

do {
  $idCli = substr(uniqid(), 5, 8);
  $req = "SELECT count(*) AS nb_idcli FROM client WHERE idcli='".$idCli."';";
  $res = $dbh->query($req);
  $res->setFetchMode(PDO::FETCH_ASSOC);
  foreach ($res as $ligne) {
    $nb_idcli = $ligne['nb_idcli'];
  }
} while ($nb_idcli > 0);

$req = "INSERT INTO client VALUES ('".$idCli."', '".$_POST["login"]."', md5('".$_POST["mdp"]."'), ".$nom.", ".$prenom.", ".$telephone.");";
$dbh->exec($req);

$_SESSION['idcli'] = $idCli;
$_SESSION['login'] = $_POST["login"];
setcookie("idcli", $ligne['idcli'], time()+1000000);
setcookie("login", $ligne['login'], time()+1000000);

header('Location: accueil.php');
exit();

?>
