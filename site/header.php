<?php session_start(); ?>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title> LE Traiteur </title>
    <link rel="stylesheet" href="style.css" media="screen" type="text/css"/>
  </head>
  <body>
    <div class="page">
    <div class="entete">
      <h1 class="left">LE Traiteur</h1>
      <div class="login_header right">
        <?php
        if (isset($_COOKIE['idcli'])) {
          $_SESSION['idcli'] = $_COOKIE['idcli'];
          $_SESSION['login'] = $_COOKIE['login'];
        }
        if (isset($_SESSION['idcli'])) {
          echo '<p>Connecté en tant que <span>'.$_SESSION['login'].'</span></p>';
          echo '<a href="deconnexion.php">Déconnexion</a>';
        } else {
          echo '<a href="connexion.php">Connexion</a>';
          echo '<a href="inscription.php">Inscription</a>';
        }
        ?>
      </div>
    </div>
    <div class="menu">
      <a href="accueil.php" class="bouton_menu left">Accueil</a>
      <a href="plats.php" class="bouton_menu left">Plats</a>
      <a href="equipe.php" class="bouton_menu left">Notre équipe</a>
      <?php
      if (isset($_SESSION['idcli'])) {
          echo '<a href="commandes.php" class="bouton_menu right">Mes Commandes</a>';
        }
      ?>
    </div>
