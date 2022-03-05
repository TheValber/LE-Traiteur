<?php
include("header.php");
?>

<div class="clear"></div>
<h1 class="titrecateg">Connexion</h1>

<form action="traitement_connexion.php" method="post" class="inscription">
  <p>Identifiant : </p><input type="text" name="login" required/><br/>
  <p>Mot de passe : </p><input type="password" name="mdp" required/><br/><br/>
  <input type="submit" value="Se connecter" class="bouton_inscrire"/>
</form>

<div class="deja_compte">
<p>Vous n'avez pas encore un compte ?</p>
<a href="inscription.php">Inscrivez vous !</a>
</div>

<?php
include("footer.php");
?>
