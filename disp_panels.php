<?php

function disp_connexion_p()
{
	?><div id="connexion_p"><?php
	if(connected()) { ?>
		<h4><?php echo $_SESSION['name']; ?></h4>
		<p><a href="index.php?p=gdc">Gestion de compte</a></p>
		<p><a href="index.php?p=dc">Déconnexion</a></p>
	<?php } else { ?>
		<h4>Connexion :</h4>
		<form method="post" action="">
			<p>
				<label for="c_name">Pseudo :</label><input id="c_name" type="text" name="c_name" maxlength="32"/><br/>
				<label for="c_mdp">MDP :</label><input id="c_mdp" type="password" name="c_mdp" maxlength="32"/><br/>
				<input type="submit" value="Connexion"/>
				<a href="index.php?p=inscr">S'inscrire</a>
			</p>
		</form>
	<?php }
	?></div><?php
}

function disp_members_p()
{
	?><div id="members_p">
		<h4>Liste des membres</h4>
		<p><?php
		$db = db_connect();
		$req = $db->prepare('SELECT `m.id`, `m.name` FROM members');
		$req->execute();
		while($data = $req->fetch())
		{
			disp_link($data['m.id'], $data['m.name'], 'm');
			?><br/><?php
		}
		$req->closeCursor();
		?></p>
	</div><?php
}

?>