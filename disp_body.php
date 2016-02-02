<?php

function disp_error($error)
{
	echo '<div id="error"><p>';
	echo $error;
	echo '</p></div>';
}

function disp_link($id, $name, $type)
{
	if($name == NULL && $type == 'm')
		echo 'Auteur inconnu';
	else
	{ ?>
		<a href="index.php?p=<?php echo $type ?>&id=<?php echo $id ?>"><?php echo $name ?></a>
	<?php }
}

function disp_cats()
{
	$db = db_connect();
	$req = $db->prepare('SELECT `c.name`, `f.name`, `f.desc`, `f.id`, `p.date`, `t.id`, `t.name`, `m.id`, `m.name` 
						FROM cats LEFT JOIN forums ON `f.cat_id` = `c.id`
						LEFT JOIN posts ON `p.id` = `f.lastpost_id`
						LEFT JOIN topics ON `t.id` = `p.topic_id`
						LEFT JOIN members ON `m.id` = `p.author_id`
						ORDER BY `c.id`, `f.id`');
	$req->execute();
	
	$cat = '';
	
	?><div id="forum">
	<h2>Index du forum</h2>
	<table><tr> <th>Sous-forum</th> <th>Description</th> <th>Dernier message</th> </tr><?php
	while($data = $req->fetch())
	{
		if($cat != $data['c.name'])
		{
			echo '<tr><td colspan=3><h2>'.htmlspecialchars($data['c.name']).'</h2></td></tr>';
			$cat = $data['c.name'];
		}
		if($data['f.id'] != NULL)
		{ ?>
			<tr>
				<td><h3><?php disp_link($data['f.id'], htmlspecialchars($data['f.name']), 'f'); ?></h3></td>
				<td><p><?php echo $data['f.desc'] ?></p></td>
				<td><?php
					if($data['p.date'] == NULL || htmlspecialchars($data['t.name']) == NULL)
						echo NO_LASTPOST;
					else
					{
						disp_link($data['t.id'], htmlspecialchars($data['t.name']), 't'); ?>
						<br/><?php echo $data['p.date'] ?>
						<br/><?php disp_link($data['m.id'], $data['m.name'], 'm');
					}
				?></td>
			</tr>
		<?php } else { echo '<td colspan=3>'. NO_FORUM .'</td>'; }
	}
	?></table></div><?php
	$req->closeCursor();
}

function disp_forum($f_id)
{
	$db = db_connect();
	$req = $db->prepare('SELECT `c.name`, `f.name`, `t.id`, `t.name`, `t.nb_views`, `t.author_id`, m_a.`m.name` AS `t.author_name`, `p.date`, m_b.`m.name` AS `t.lastpost_author_name`, m_b.`m.id` AS `t.lastpost_author_id`
						FROM forums LEFT JOIN cats ON `c.id` = `f.cat_id`
						LEFT JOIN topics ON `t.forum_id` = `f.id`
						LEFT JOIN members AS m_a ON m_a.`m.id` = `t.author_id`
						LEFT JOIN posts ON `p.id` = `t.lastpost_id`
						LEFT JOIN members AS m_b ON m_b.`m.id` = `p.author_id`
						WHERE `f.id` = ?');
	$req->execute(array($f_id));
	
	if(!($data = $req->fetch()))
		return 1;
	if($data['c.name'] == NULL)
		return 2;
	
	?><div id="forum">
	<h2> <?php echo htmlspecialchars($data['f.name']) ?></h2>
	<p><a href="index.php">Index</a> -> <?php echo htmlspecialchars($data['c.name']).' -> '.htmlspecialchars($data['f.name']) ?></p>
	<table><tr> <th>Topics</th> <th>Auteur</th> <th>Nombre de vues</th> <th>Dernier message</th> </tr><?php
	if($data['t.name'] == NULL)
		echo '<tr><td colspan=4>'.NO_TOPIC.'</td></tr>';
	else
	{
		do
		{
			?><tr>
				<td><h3><?php disp_link($data['t.id'], htmlspecialchars($data['t.name']), 't'); ?></h3></td>
				<td class="center"><?php disp_link($data['t.author_id'], $data['t.author_name'], 'm'); ?></td>
				<td class="center"><?php echo $data['t.nb_views'] ?></td>
				<td><?php
					if($data['p.date'] == NULL)
						echo NO_LASTPOST;
					else
					{
						echo $data['p.date'].'<br/>';
						disp_link($data['t.lastpost_author_id'], $data['t.lastpost_author_name'], 'm');
					} ?>
				</td>
			</tr><?php
		} while($data = $req->fetch());
	}
	?></table><h3><a href="index.php?p=newt&id=<?php echo $f_id ?>">Créer un nouveau topic</a></h3></div><?php
	$req->closeCursor();
}

function disp_topic($t_id)
{
	$db = db_connect();
	$req = $db->prepare('SELECT `c.name`, `f.id`, `f.name`, `t.name`, `p.text`, `p.date`, `m.id`, `m.name`
						FROM topics LEFT JOIN forums ON `f.id` = `t.forum_id`
						LEFT JOIN cats ON `c.id` = `f.cat_id`
						LEFT JOIN posts ON `p.topic_id` = `t.id`
						LEFT JOIN members ON `m.id` = `p.author_id`
						WHERE `p.topic_id` = ?');
	$req->execute(array($t_id));
	
	if(!($data = $req->fetch()))
		return 1;
	if($data['c.name'] == NULL || $data['f.name'] == NULL)
		return 2;
	
	?><div id="forum">
	<h2> <?php echo htmlspecialchars($data['t.name']) ?></h2>
	<p><a href="index.php">Index</a> -> <?php echo htmlspecialchars($data['c.name']).' -> ';
	disp_link($data['f.id'], htmlspecialchars($data['f.name']), 'f');
	echo ' -> '.$data['t.name'] ?></p>
	
	<table><tr> <th>Auteur</th> <th>Date</th> <th>Message</th></tr><?php
	if($data['p.text'] == NULL)
		echo '<tr><td colspan=3>'.NO_POST.'</td></tr>';
	else
	{
		do
		{
			?><tr>
				<td><?php disp_link($data['m.id'], $data['m.name'], 'm'); ?></td>
				<td><?php echo $data['p.date'] ?></td>
				<td><p><?php echo nl2br(htmlspecialchars($data['p.text'])) ?></p></td>
			</tr><?php
		} while($data = $req->fetch());
	}
	?></table><h3><a href="index.php?p=newp&id=<?php echo $t_id ?>">Poster un nouveau message</a></h3></div><?php
	$req->closeCursor();
	$req = $db->prepare('UPDATE topics SET `t.nb_views` = `t.nb_views` + 1 WHERE `t.id` = ?');
	$req->execute(array($t_id));
}

function disp_member($m_id)
{
	$db = db_connect();
	$req = $db->prepare('SELECT `m.name`, `m.email`, `m.lastconnexion`, `m.inscription` FROM members WHERE `m.id` = ?');
	$req->execute(array($m_id));
	
	if(!($data = $req->fetch()))
		return 1;
	
	?><div id="member">
		<h2><?php echo $data['m.name'] ?></h2>
		<p>
			Inscrit sur le forum depuis le <?php echo $data['m.inscription'] ?>.<br/>
			Dernière connexion le <?php echo $data['m.lastconnexion'] ?>.<br/>
			Adresse email : <?php echo $data['m.email'] ?>.
		</p>
	</div><?php
}

function disp_gdc()
{
	if(!connected())
		return 1;
	?>
	<div id="gdc">
		<h2>Gestion de compte :</h2>
		<p>
			Vous êtes inscrit sur le forum depuis le <?php echo $_SESSION['inscription'] ?>.<br/>
			Adresse email : <?php echo $_SESSION['email'] ?>.<br/>
			Adresse IP actuelle : <?php echo $_SERVER["REMOTE_ADDR"] ?><br/>
			Adresse IP lors de l'inscription : <?php echo $_SESSION['ip'] ?><br/>
		</p>
		<p class="gdc_part">
			<form method="post" action="">
				<label for="gdc_email">Changer d'adresse email :</label><input id="gdc_email" type="text" name="gdc_email"/><br/>
				<input type="submit" value="Confirmer" src="valider.png"/>
			</form>
		</p>
		<p class="gdc_part">
			<form method="post" action="">
				<label for="gdc_mdp">Changer de mot de passe :</label><input id="gdc_mdp" type="text" name="gdc_mdp"/><br/>
				<label for="gdc_cmdp">Confirmation :</label><input id="gdc_cmdp" type="text" name="gdc_cmdp"/><br/>
				<input type="submit" value="Confirmer" src="valider.png"/>
			</form>
		</p>
	</div>
	<?php
	return 0;
}

function disp_inscriptionForm()
{
	?>
	<div id="inscription">
		<h2>Inscription</h2>
		<p>Votre pseudo doit être composé de 4 à 16 caractères alphanumériques, tirets, points ou underscores.
		<br/>Votre mot de passe doit être composé d'au moins 6 caractères.
		<br/>Votre adresse email doit être correcte.
		</p>
		<form method="post" action="">
			<label for="i_name">Pseudo : </label><input id="i_name" type="text" name="i_name" maxlength="16" /><br/>
			<label for="i_mdp" >Mot de Passe : </label><input id="i_mdp" type="password" name="i_mdp" maxlength="32" /><br/>
			<label for="i_cmdp">Confirmation du Mot de Passe : </label><input id="i_cmdp" type="password" name="i_cmdp" maxlength="32" /><br/>
			<label for="i_email">Adresse Email : </label><input id="i_email" type="text" name="i_email"/><br/>
			<br/>
			<input id="i_cgu" type="checkbox" name="i_cgu" />
			<label for="i_cgu">J'ai lu et j'accepte les <a href="index.php?p=t&id=2">Conditions d'utilisation</a>.</label>
			<br/><br/>
			<input type="submit" value="Confirmer" class="boutonV" src="valider.png"/>
			<input type="reset" value="Effacer" class="boutonR"/>
		</form>
	</div>
	<?php
}

function disp_body()
{
	if(!isset($_GET['p']))
	{
		disp_cats();
	}
	elseif(isset($_GET['id']))
	{
		if($_GET['p'] == 'f')
		{
			if(isset($_POST['topicname']) && isset($_POST['message']) && connected())
			{
				if(newTopic($_POST['topicname'], $_GET['id'], $_SESSION['id'], $_POST['message']))
					disp_error(ERR_404);
				elseif(disp_forum($_GET['id']))
					disp_error(ERR_404);
			}
			elseif(disp_forum($_GET['id']))
				disp_error(ERR_404);
		}
		else if($_GET['p'] == 't')
		{
			if(isset($_POST['message']) && connected())
			{
				if(newPost($_POST['message'], $_GET['id'], $_SESSION['id']))
					disp_error(ERR_404);
				elseif(disp_topic($_GET['id']))
					disp_error(ERR_404);
			}
			elseif(disp_topic($_GET['id']))
				disp_error(ERR_404);
		}
		else if($_GET['p'] == 'm')
		{
			if(disp_member($_GET['id']))
				disp_error(ERR_404);
		}
		elseif($_GET['p'] == 'newt' || $_GET['p'] == 'newp')
		{
			if(connected())
			{ ?>
				<div id="forum"><h2><?php if($_GET['p'] == 'newt') { ?>Créer un nouveau topic :<?php } else { ?>Poster un nouveau message : <?php } ?></h2>
				<form method="post" action="index.php?p=<?php if($_GET['p'] == 'newt') echo 'f'; else echo 't'; ?>&id=<?php echo $_GET['id'] ?>">
					<p>
						<?php if($_GET['p'] == 'newt') { ?><label for="topicname">Nom du topic :</label><input id="topicname" type="text" name="topicname" maxlength="64"/><br/><?php } ?>
						<label for="message">Message :</label><textarea id="message" name="message"></textarea><br/>
						<input type="submit" value="Valider"/>
					</p>
				</form>
				</div>
			<?php }
			else disp_error(ERR_GDC_DC);
		}
		else disp_error(ERR_404);
	}
	elseif($_GET['p'] == 'inscr')
	{
		disp_inscriptionForm();
	}
	elseif($_GET['p'] == 'dc')
	{
		?><p>Vous êtes maintenant déconnecté.</p><?php
	}
	elseif($_GET['p'] == 'co_ok')
	{
		?><p>Vous êtes maintenant connecté.</p><?php
	}
	elseif($_GET['p'] == 'inscr_ok')
	{
		?><p>Vous êtes maintenant incrit sur ce forum.</p><?php
	}
	elseif($_GET['p'] == 'gdc')
	{
		if(connected())
		{
			if(isset($_POST['gdc_mdp']) && isset($_POST['gdc_cmdp']))
			{
				if($_POST['gdc_mdp'] == $_POST['gdc_cmdp'])
				{
					if(changeMDP($_SESSION['id'], $_POST['gdc_mdp']))
						disp_error(ERR_INSCR_MDP);
					else
						echo '<div id="green"><p>'.GDC_MDP_CHANGED.'</p></div>';
				}
				else disp_error(ERR_INSCR_CONF);
			}
			elseif(isset($_POST['gdc_email']))
			{
				if(changeEmail($_SESSION['id'], $_POST['gdc_email']))
					disp_error(ERR_INSCR_EMAIL);
				else
					echo '<div id="green"><p>'.GDC_EMAIL_CHANGED.'</p></div>';
			}
			else disp_gdc();
		}
		else disp_error(ERR_GDC_DC);
	}
	else disp_error(ERR_404);
}

?>
