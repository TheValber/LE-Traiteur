<?php
include("header.php");
?>

<?php

  include("connexion.inc.php");

  $req = "SELECT * FROM Plat WHERE idPlat='".$_GET['plat']."';";
  $res = $dbh->query($req);
  $res->setFetchMode(PDO::FETCH_ASSOC);

  foreach($res as $plat) {
    echo '<img src="images/'.$plat['image'].'" alt="Image" class="photo_plat_grand">';
    echo '<div class="descplat">';
    echo '<p class="nom_plat">'.$plat['nomplat'].'</p>';
    echo '<p class="description_plat">'.$plat['description'].'</p>';
    echo '<p class="description_plat"><span class="prix_plat">'.$plat['prix'].' €</span> la part</p>';

    if (isset($_SESSION["idcli"])) {
      echo '<form action="ajout_plat_commande.php?plat='.$plat['idplat'].'" method="post">';
      echo '<p>Quantité : <input type="number" name="quantite" value=1 required/></p><br/>';
      echo '<input type="submit" value="Ajouter à la commande"/>';
      echo '</form>';
    } else {
      echo '<p class="description_plat">Veuillez vous connecter pour commander ce plat.</p>';
    }

    echo '<p class="description_plat">Liste des ingrédients :</p>';

    $req = "SELECT compose.quantite AS nb, unitequantite, nomingr FROM compose JOIN ingredient ON compose.idingr=ingredient.idingr WHERE idplat='".$plat['idplat']."';";
    $ingr = $dbh->query($req);
    $ingr->setFetchMode(PDO::FETCH_ASSOC);
    echo '<div class="descingredient">';
    foreach ($ingr as $ligne) {
      echo '<p>'.$ligne["nb"].$ligne["unitequantite"].' - '.$ligne["nomingr"].'</p>';
    }
    echo '</div></div>';
    
  }


?>

<?php
include("footer.php");
?>