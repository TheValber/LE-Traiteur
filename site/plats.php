<?php
include("header.php");
?>

<?php

  include("connexion.inc.php");

  if (isset($_SESSION["idcli"])) {

    $req = "SELECT count(*) AS nb FROM preference JOIN plat ON preference.platpref = plat.idplat WHERE client='".$_SESSION["idcli"]."';";
    $nbpref = $dbh->query($req);
    $nbpref = $nbpref->fetchAll();

    echo '<div class="clear"></div>';
    if ($nbpref[0]["nb"] > 1) {
      echo '<h1 class="titrecateg">Vos plats préférés</h1>';
    } else {
      echo '<h1 class="titrecateg">Votre plat préféré</h1>';
    }
    

    $req = "SELECT * FROM preference JOIN plat ON preference.platpref = plat.idplat WHERE client='".$_SESSION["idcli"]."';";
    $plats = $dbh->query($req);
    $plats->setFetchMode(PDO::FETCH_ASSOC);

    foreach($plats as $plat) {
      echo '<a href="plat_details.php?plat='.$plat['idplat'].'"><div class="plat">';
      echo '<img src="images/'.$plat['image'].'" alt="Image" class="photo_plat">';
      echo '<p>'.$plat['nomplat'].'</p>';
      echo '<p><span class="prix">'.$plat['prix'].' €</span> la part</p>';
      echo '<p><span class="prix">'.$plat['nbcommande'].'</span> commande'.($plat['nbcommande']>1?'s':'').'</p>';
      echo '</div></a>';
    }

  }

  echo '<div class="clear"></div>';
  echo '<h1 class="titrecateg">Tous les plats</h1>';

  $plats = $dbh->query("SELECT * FROM plat WHERE image IS NOT NULL;");
  $plats->setFetchMode(PDO::FETCH_ASSOC);

  foreach($plats as $plat) {
    echo '<a href="plat_details.php?plat='.$plat['idplat'].'"><div class="plat">';
    echo '<img src="images/'.$plat['image'].'" alt="Image" class="photo_plat">';
    echo '<p>'.$plat['nomplat'].'</p>';
    echo '<p><span class="prix">'.$plat['prix'].' €</span> la part</p>';
    echo '</div></a>';
  }

  $plats = $dbh->query("SELECT * FROM plat WHERE image IS NULL;");
  $plats->setFetchMode(PDO::FETCH_ASSOC);

  foreach($plats as $plat) {
    echo '<a href="plat_details.php?plat='.$plat['idplat'].'"><div class="plat">';
    echo '<p>'.$plat['nomplat'].'</p>';
    echo '<p><span class="prix">'.$plat['prix'].' €</span> la part</p>';
    echo '</div></a>';
  }


?>

<?php
include("footer.php");
?>
