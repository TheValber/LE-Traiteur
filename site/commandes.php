<?php
include("header.php");
?>

<?php

  if (!isset($_SESSION["idcli"])) {
    header('Location: accueil.php');
    exit();
  }

  include("connexion.inc.php");

  $req = "SELECT * FROM commande WHERE idcli='".$_SESSION["idcli"]."' ORDER BY numcom DESC;";
  $commandes = $dbh->query($req);
  $commandes->setFetchMode(PDO::FETCH_ASSOC);

  echo '<div class="clear"></div>';
  echo '<h1 class="titrecateg">Vos commandes</h1>';

  foreach($commandes as $com) {
    echo '<a href="commande_details.php?commande='.$com['numcom'].'" class="commande">';
    echo '<p> Commande n°'.$com['numcom'].'</p>';
    echo '<p>Montant de la commande : <span class="prix">'.$com['montant'].' €</span></p>';
    echo '<p>Etat : En '.$com['avancement'].'</p>';
    echo '</a>';
  }


?>


<?php
include("footer.php");
?>
