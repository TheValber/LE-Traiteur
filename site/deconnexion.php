<?php session_start(); ?>
<?php

$_SESSION = array();
session_destroy();

setcookie("idcli", $ligne['idcli'], time()-3600);
setcookie("login", $ligne['login'], time()-3600);

header('Location: accueil.php');
exit();

?>