<?php

function connected()
{
	if(isset($_SESSION['id']) && isset($_SESSION['name']) && isset($_SESSION['email']) && isset($_SESSION['ip']))
		return 1;
	return 0;
}

function deconnexion()
{
	session_destroy();
	unset($_SESSION['id']);
	unset($_SESSION['name']);
	unset($_SESSION['email']);
	unset($_SESSION['ip']);
}

function test_connexion()
{
	if(isset($_POST['c_name']) && isset($_POST['c_mdp']))
	{
		if(connexion($_POST['c_name'], $_POST['c_mdp']))
			return ERR_CONNECT;
		return '0';
	}
	return '1';
}

function connexion($name, $mdp)
{
	$db = db_connect();
	$req = $db->prepare('SELECT `m.id`, `m.name`, `m.email`, `m.inscription`, `m.ip` FROM members WHERE LOWER(`m.name`) = ? AND `m.mdp` = ?');
	$req->execute(array(strtolower($name), sha1($mdp)));
	if(!($data = $req->fetch()))
	{
		$req->closeCursor();
		return 1;
	}
	$_SESSION['id'] = $data['m.id'];
	$_SESSION['name'] = $data['m.name'];
	$_SESSION['email'] = $data['m.email'];
	$_SESSION['ip'] = $data['m.ip'];
	$_SESSION['inscription'] = $data['m.inscription'];
	$req->closeCursor();
	
	$req = $db->prepare('UPDATE members SET `m.lastconnexion` = NOW() WHERE `m.id` = ?');
	$req->execute(array($data['m.id']));
	return 0;
}

function test_inscription()
{
	if(isset($_POST['i_name']) && isset($_POST['i_mdp']) && isset($_POST['i_cmdp']) && isset($_POST['i_email']))
	{
		if(!preg_match('#^[0-9a-zA-Z_.-]{4,16}$#', $_POST['i_name']))
			$error = ERR_INSCR_NAME;
		elseif(!preg_match('#^.{6,}$#', $_POST['i_mdp']))
			$error = ERR_INSCR_MDP;
		elseif(!preg_match('#^[0-9a-z_.-]+@[1-9a-z\-_.]{2,}\.[a-z]{2,4}$#', $_POST['i_email']))
			$error = ERR_INSCR_EMAIL;
		elseif($_POST['i_mdp'] != $_POST['i_cmdp'])
			$error = ERR_INSCR_CONF;
		elseif(!isset($_POST['i_cgu']))
			$error = ERR_INSCR_CGU;
		elseif(inscription($_POST['i_name'], $_POST['i_mdp'], $_POST['i_email']))
			$error = ERR_INSCR_USED;
		else
			return '0';
		return $error;
	}
	return '1';
}

function inscription($name, $mdp, $email)
{
	$db = db_connect();
	$req = $db->prepare('SELECT `m.name` FROM members WHERE `m.name` = ?');
	$req->execute(array($name));
	if($req->fetch())
	{
		$req->closeCursor();
		return 1;
	}
	$req->closeCursor();
	
	$req = $db->prepare('INSERT INTO members VALUES(\'\', ?, ?, ?, NOW(), NOW(), ?)');
	$req->execute(array($name, sha1($mdp), $email, $_SERVER["REMOTE_ADDR"]));
	return 0;
}

function changeMDP($id, $mdp)
{
	if(!preg_match('#^.{6,}$#', $mdp))
		return 1;
	$db = db_connect();
	$req = $db->prepare('UPDATE members SET `m.mdp` = ? WHERE `m.id` = ?');
	$req->execute(array(sha1($mdp), $id));
	return 0;
}

function changeEmail($id, $email)
{
	if(!preg_match('#^[0-9a-z_.-]+@[1-9a-z\-_.]{2,}\.[a-z]{2,4}$#', $email))
		return 1;
	$db = db_connect();
	$req = $db->prepare('UPDATE members SET `m.email` = ? WHERE `m.id` = ?');
	$req->execute(array($email, $id));
	if(connected())
	{
		if($_SESSION['id'] == $id)
			$_SESSION['email'] = $email;
	}
	return 0;
}

function newTopic($name, $forum_id, $author_id, $text)
{
	$db = db_connect();
	$req = $db->prepare('SELECT `f.name` FROM forums WHERE `f.id` = ?');
	$req->execute(array($forum_id));
	if(!($req->fetch()))
	{
		$req->closeCursor();
		return 1;
	}
	$req->closeCursor();
	
	$req = $db->prepare('INSERT INTO topics VALUES(\'\', ?, 0, ?, ?, 0)');
	$req->execute(array($name, $author_id, $forum_id));
	
	newPost($text, $db->lastInsertId(), $author_id);
	return 0;
}

function newPost($text, $topic_id, $author_id)
{
	$db = db_connect();
	$req = $db->prepare('SELECT `t.forum_id` FROM topics WHERE `t.id` = ?');
	$req->execute(array($topic_id));
	if(!($data = $req->fetch()))
	{
		$req->closeCursor();
		return 1;
	}
	$req->closeCursor();
	
	$req = $db->prepare('INSERT INTO posts VALUES(\'\', ?, NOW(), ?, ?)');
	$req->execute(array($text, $author_id, $topic_id));
	$id = $db->lastInsertId();
	
	$req = $db->prepare('UPDATE topics SET `t.lastpost_id` = ? WHERE `t.id` = ?');
	$req->execute(array($id, $topic_id));
	
	$req = $db->prepare('UPDATE forums SET `f.lastpost_id` = ? WHERE `f.id` = ?');
	$req->execute(array($id, $data['t.forum_id']));
	return 0;
}

?>