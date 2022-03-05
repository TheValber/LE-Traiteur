<?php session_start(); ?>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title> Traiteur </title>
    <style>
      body {
        background-repeat: no-repeat;
        background-size: cover;
        background-image: url("images/fond_accueil.jpg");
        text-align: center;
        font-family: Verdana, Geneva, Tahoma, sans-serif;
      }

      .centre {
        background-color: rgba(255, 255, 255, 0.7);
        width: 500px;
        height: 300px;
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translateX(-50%) translateY(-50%);
        border-style: solid;
        border-color: black;
        border-width: 2px;
        border-radius: 20px;
      }

      .bouton {
        background-color: red;
        display: inline-block;
        width: 200px;
        height: 80px;
        color: white;
        text-decoration: none;
        text-align: center;
        font-size: 60px;
        font-weight: bold;
        position: absolute;
        top: 75%;
        left: 50%;
        transform: translateX(-50%) translateY(-50%);
        border-style: solid;
        border-color: black;
        border-width: 1px;
        border-radius: 20px;
      }

      h1 {
        line-height: 40px;
        font-size: 60px;
      }

      h2 {
        line-height: 20px;
        font-size: 40px;
      }
    </style>
  </head>
  <body>

    <?php
    if (isset($_COOKIE['idcli'])) {
      $_SESSION['idcli'] = $_COOKIE['idcli'];
      $_SESSION['login'] = $_COOKIE['login'];
    }
    if (isset($_SESSION["idcli"])) {
      header('Location: accueil.php');
      exit();
    }
    ?>

    <div class="centre">
      <h1>Bienvenue</h1>
      <h2>chez LE Traiteur</h2>
      <a href="accueil.php" class="bouton">Miam</a>
    </div>
    
  </body>
</html>