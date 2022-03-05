<?php
include("header.php");
?>

<?php

  if (!isset($_SESSION["idcli"])) {
    header('Location: accueil.php');
    exit();
  }

  include("connexion.inc.php");

  $req = "SELECT * FROM commande WHERE numcom='".$_GET['commande']."';";
  $res = $dbh->query($req);
  $res->setFetchMode(PDO::FETCH_ASSOC);

  echo '<div class="clear"></div>';

  foreach($res as $com) {
    if ($_SESSION["idcli"] != $com["idcli"]) {
      header('Location: accueil.php');
      exit();
    }
    echo '<h1 class="titrecateg">Commande n°'.$com['numcom'].'</h1>';
    echo '<div class="commande_details">';
    echo '<p><span class="legende">Montant de la commande :</span> '.$com['montant'].' €</p>';
    echo '<p><span class="legende">Etat :</span> En '.$com['avancement'].'</p>';
    echo '<p><span class="legende">Livraison :</span> '.$com['livraison'].($com['livraison']=="oui"?" (+ 10 €)":"").'</p>';
    if ($com['livraison'] == "oui") {
      echo '<p><span class="legende">Adresse :</span> '.$com['adresse'].'</p>';
    }
    if ($com['avancement'] == "création") {
      echo '<p><span class="legende">Changer le mode de livraison :</span></p>';
      echo '<form action="change_livraison.php?commande='.$com['numcom'].'" method="post" class="mode_livraison">';
      echo '<p>Livraison (10 €): </p>';
      echo '<input type="radio" id="oui" name="livraison" value="oui"><label for="oui">Oui</label>';
      echo '<input type="radio" id="non" name="livraison" value="non" checked><label for="non">Non</label>';
      echo '<p>Adresse : </p><input type="text" pattern="[a-z0-9A-Z-]{,50}" name="adresse" value="'.$com['adresse'].'"/><br/><br/>';
      echo '<input type="submit" value="Valider"/>';
      echo '</form>';
    }
    echo '</div>';
  }

  $req = "SELECT * FROM contient NATURAL JOIN plat WHERE numcom='".$_GET['commande']."';";
  $res = $dbh->query($req);
  $res->setFetchMode(PDO::FETCH_ASSOC);

  foreach($res as $plat) {
    echo '<div class="plat_commande">';
    echo '<img src="images/'.$plat['image'].'" alt="Image" class="photo_plat_commande">';
    echo '<div class="left">';
    echo '<p>'.$plat['nomplat'].'</p>';
    echo '<p><span class="gros">'.$plat['prix'].' €</span> la part</p>';
    echo '<p>Quantité : <span class="gros">'.$plat['nombre'].'</span></p>';
    echo '<p>Total : <span class="gros">'.($plat['prix'] * $plat['nombre']).' €</span></p>';
    echo '</div>';
    if ($com['avancement'] == "création") {
      echo '<a href="supprime_plat_commande.php?commande='.$_GET['commande'].'&plat='.$plat["idplat"].'" class="bouton_supprime_plat">X</a>';
    }
    echo '</div>';
  }

  if ($com['avancement'] == "création") {
    echo '<a href="valide_commande.php?commande='.$_GET['commande'].'" class="bouton_valide_commande">Valider la commande</a>';
    echo '<a href="supprime_commande.php?commande='.$_GET['commande'].'" class="bouton_supprime_commande">Supprimer la commande</a>';
  }
?>

<?php
include("footer.php");
?>
