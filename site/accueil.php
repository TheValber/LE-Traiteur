<?php
include("header.php");
?>


<div class="clear"></div>
<h1 class="titrecateg">Bienvenue chez LE Traiteur</h1>

<p class="parag">Chez LE Traiteur, vous pourrez retrouver une grande quantité de plats fait maison par un grand chef étoilé. Nous vous proposons des livraisons à domicile ou une récupération de la commande dans nos locaux.</p>

<?php

include("connexion.inc.php");

echo '<div class="clear"></div>';
echo '<h1 class="titrecateg">Nos meilleurs plats</h1>';

$plats = $dbh->query("SELECT idplat, sum(nombre) AS nbcommande, image, nomplat, prix FROM contient NATURAL JOIN plat GROUP BY idplat, image, nomplat, prix ORDER BY nbcommande DESC LIMIT 9;");
$plats->setFetchMode(PDO::FETCH_ASSOC);

foreach($plats as $plat) {
  echo '<a href="plat_details.php?plat='.$plat['idplat'].'"><div class="plat">';
  echo '<img src="images/'.$plat['image'].'" alt="Image" class="photo_plat">';
  echo '<p>'.$plat['nomplat'].'</p>';
  echo '<p><span class="prix">'.$plat['prix'].' €</span> la part</p>';
  echo '<p><span class="prix">'.$plat['nbcommande'].'</span> commande'.($plat['nbcommande']>1?'s':'').'</p>';
  echo '</div></a>';
}

echo '<a href="plats.php"><div class="plat">';
echo '<div class="plus">Voir plus</div>';
echo '</div></a>';

?>

<?php
include("footer.php");
?>
