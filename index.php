<?php session_start();
header('Content-Type: text/html; charset=utf-8');

function db_connect()
{
	try
	{
		$db = new PDO('mysql:host=localhost;dbname=konstantin_sido', 'konstantin_sido', 'EpnpxDTy');
	}
	catch(Exception $e)
	{
		die('Erreur : ' . $e->getMessage());
	}
	return $db;
}

include('defines.php');
include('members.php');
include('disp_body.php');
include('disp_panels.php');

$test = test_inscription();
if($test == '0')
{
	connexion($_POST['i_name'], $_POST['i_mdp']);
	unset($_GET['id']);
	$_GET['p'] = 'inscr_ok';
}
elseif($test != '1')
	$error = $test;

$test = test_connexion();
if($test == '0')
{
	unset($_GET['id']);
	$_GET['p'] = 'co_ok';
}
elseif($test != '1')
	$error = $test;

if(isset($_GET['p']))
{
	if($_GET['p'] == 'dc')
		deconnexion();
}

if(!isset($redir)) { ?>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <link rel="stylesheet" href="design/design.css" />
        <title>Forum</title>
    </head>

    <body>
        <header><a href="index.php"><img src="design/banniere.png" alt="Bannière"/></a></header>
		<section>
			<div id="panel">
				<?php disp_connexion_p(); ?>
			</div>
			
			<div id="mid">
			<?php if(isset($error)) disp_error($error); else disp_body(); ?>
			</div>
			
			<div id="panel">
				<?php disp_members_p(); ?>
			</div>
		</section>
    </body>
</html>
<?php } ?>