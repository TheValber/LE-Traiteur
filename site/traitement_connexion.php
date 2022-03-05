<?php session_start(); ?>
<?php

include("connexion.inc.php");

$req = "SELECT idcli, login FROM client WHERE login='".$_POST["login"]."' AND mdp='".md5($_POST["mdp"])."';";
$res = $dbh->query($req);
$res->setFetchMode(PDO::FETCH_ASSOC);

foreach ($res as $ligne) {
  $_SESSION['idcli'] = $ligne['idcli'];
  $_SESSION['login'] = $ligne['login'];
  setcookie("idcli", $ligne['idcli'], time()+1000000);
  setcookie("login", $ligne['login'], time()+1000000);
  header('Location: accueil.php');
  exit();
}

header('Location: connexion.php');
exit();

?>
