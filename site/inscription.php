<?php
include("header.php");
?>

<div class="clear"></div>
<h1 class="titrecateg">Inscription</h1>

<form action="traitement_inscription.php" method="post" class="inscription">
  <p>Identifiant * : </p><input type="text" pattern="[a-z0-9A-Z._-]{0,15}" name="login" required/><br/>
  <p>Mot de passe * : </p><input type="password" name="mdp" required/><br/>
  <p>Nom : </p><input type="text" pattern="[a-z0-9A-Z-]{0,25}" name="nom"/><br/>
  <p>Prénom : </p><input type="text" pattern="[a-z0-9A-Z-]{0,25}" name="prenom"/><br/>
  <p>Téléphone : </p><input type="tel" pattern="[0-9]{10}" name="telephone"/><br/>
  <small>Format : 0123456789</small><br/><br/>
  <input type="submit" value="S'inscrire" class="bouton_inscrire"/>
</form>

<div class="deja_compte">
<p>Vous avez déjà un compte ?</p>
<a href="connexion.php">Connectez vous !</a>
</div>

<?php
include("footer.php");
?>
