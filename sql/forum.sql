-- phpMyAdmin SQL Dump
-- version 3.5.1
-- http://www.phpmyadmin.net
--
-- Client: localhost
-- Généré le: Ven 31 Mai 2013 à 14:43
-- Version du serveur: 5.5.24-log
-- Version de PHP: 5.3.13

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données: `forum`
--

-- --------------------------------------------------------

--
-- Structure de la table `cats`
--

CREATE TABLE IF NOT EXISTS `cats` (
  `c.id` int(11) NOT NULL AUTO_INCREMENT,
  `c.name` varchar(64) NOT NULL,
  PRIMARY KEY (`c.id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Contenu de la table `cats`
--

INSERT INTO `cats` (`c.id`, `c.name`) VALUES
(1, 'Sujets principaux'),
(2, 'Discussions gÃ©nÃ©rales');

-- --------------------------------------------------------

--
-- Structure de la table `forums`
--

CREATE TABLE IF NOT EXISTS `forums` (
  `f.id` int(11) NOT NULL AUTO_INCREMENT,
  `f.name` varchar(64) NOT NULL,
  `f.desc` varchar(128) NOT NULL,
  `f.cat_id` int(11) NOT NULL,
  `f.lastpost_id` int(11) NOT NULL,
  PRIMARY KEY (`f.id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Contenu de la table `forums`
--

INSERT INTO `forums` (`f.id`, `f.name`, `f.desc`, `f.cat_id`, `f.lastpost_id`) VALUES
(1, 'RÃ¨glement', 'RÃ¨gles a respecter pour utiliser ce forum.', 1, 12),
(2, 'PrÃ©sentation du forum', '', 1, 10),
(3, 'PrÃ©sentation des membres', 'Venez vous prÃ©senter ici.', 1, 11),
(4, 'Blabla', 'Parlez de tout et n''importe quoi ici.', 2, 17),
(5, 'BDM', 'Postez ici vos meilleures blagues.', 2, 14),
(6, 'Chuck Norris Facts', 'Chuck Norris > All.', 2, 16);

-- --------------------------------------------------------

--
-- Structure de la table `members`
--

CREATE TABLE IF NOT EXISTS `members` (
  `m.id` int(11) NOT NULL AUTO_INCREMENT,
  `m.name` varchar(32) NOT NULL,
  `m.mdp` varchar(128) NOT NULL,
  `m.email` varchar(128) NOT NULL,
  `m.lastconnexion` datetime NOT NULL,
  `m.inscription` datetime NOT NULL,
  `m.ip` varchar(32) NOT NULL,
  PRIMARY KEY (`m.id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Contenu de la table `members`
--

INSERT INTO `members` (`m.id`, `m.name`, `m.mdp`, `m.email`, `m.lastconnexion`, `m.inscription`, `m.ip`) VALUES
(1, 'PratLeStuw', '169c77919926a81493c515630ce74ecc08d2ed09', 'trololo@hotmail.fr', '2013-05-27 01:34:24', '2013-05-24 16:38:43', '127.0.0.1'),
(2, 'ThePatriot', '1612c2b744a7250d8b9ba902775f51e877d43f8a', 'ab-29@hotmail.fr', '2013-05-31 16:42:29', '2013-05-27 01:37:48', '127.0.0.1'),
(3, 'Mergwez', 'c7b4af88341d3d3fccc8767d94c5006ee11c8de1', 'opopop@hotmail.fr', '2013-05-27 01:40:15', '2013-05-27 01:40:15', '127.0.0.1'),
(4, 'Jambon-Fromage', '7a0e166c8f6752866e8b378fa8d0dde05b4d5440', 'ben.lecorre@hotmail.fr', '2013-05-31 15:54:31', '2013-05-29 08:20:17', '172.16.127.249'),
(5, 'Moderator', '940c0f26fd5a30775bb1cbd1f6840398d39bb813', 'solar.cribier@gmail.com', '2013-05-31 16:38:29', '2013-05-29 08:33:45', '172.16.126.12'),
(6, 'Alex_ich', '7403e3a8e68ffd71013f83d8be953141', 'opalexich@gmail.fr', '2013-05-29 08:52:57', '2013-05-29 08:52:57', '172.16.127.215'),
(7, 'TheCampagnards', 'ab0456ef620a5fcb95f907d356449b3ef1a82627', 'zboob@gmail.com', '2013-05-29 09:02:56', '2013-05-29 09:02:56', '172.16.127.215');

-- --------------------------------------------------------

--
-- Structure de la table `posts`
--

CREATE TABLE IF NOT EXISTS `posts` (
  `p.id` int(11) NOT NULL AUTO_INCREMENT,
  `p.text` text NOT NULL,
  `p.date` datetime NOT NULL,
  `p.author_id` int(11) NOT NULL,
  `p.topic_id` int(11) NOT NULL,
  PRIMARY KEY (`p.id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=18 ;

--
-- Contenu de la table `posts`
--

INSERT INTO `posts` (`p.id`, `p.text`, `p.date`, `p.author_id`, `p.topic_id`) VALUES
(1, 'Bonjour a tous, je m''appelle Bertrand dans la vraie vie, j''ai 39ans et je suis un fan inconsidÃ©rÃ© de patÃ© HÃ©naff. Je m''inscris donc sur ce forum pour partager cette passion et pouvoir en parler avec d''autres personnes. \nJe suis vendeur de chameaux, actuellement en CDI.\nA bientot sur le Forum!', '2013-05-29 08:32:36', 4, 1),
(2, 'Conditions d''utilisation du forum :\n\nRespect de la lÃ©gislation\n\n   ConformÃ©ment aux lÃ©gislations en vigueur, les actes suivants sont interdits sur ce forum :\n- L''atteinte Ã  la vie privÃ©e d''autrui (citation nominative de personnes sans leur accord explicite) ;\n- La diffamation et l''injure ;\n- L''incitation aux crimes et dÃ©lits et la provocation au suicide, la provocation Ã  la discrimination, Ã  - la haine notamment raciale, ou Ã  la violence ; \n- L''apologie de tous les crimes, notamment meurtre, viol, crime de guerre et crime contre l''humanitÃ©, la nÃ©gation de crimes contre l''humanitÃ© ; \n- La reproduction, reprÃ©sentation ou diffusion d''une oeuvre soumise Ã  des droits de propriÃ©tÃ© intellectuelle ne le permettant pas (copyrights, et cetera) ; \n- La publicitÃ© ou les messages Ã  vocation commerciale ; \n- Les discussions traitant de la copie de logiciels commerciaux pour un usage autre qu''une copie de sauvegarde dans les conditions prÃ©vues par le code de la propriÃ©tÃ© intellectuelle.\n   Les utilateurs commettant un ou plusieurs de ces actes seront immÃ©diatement bannis,  cependant, comme il est Ã©voquÃ© dans la section ConfidentialitÃ©, leurs donnÃ©es seront conservÃ©es pour permettre une Ã©ventuelle identification par les autoritÃ©s.\n\nConfidentialitÃ©\n\n   Ce forum garantit par ailleurs la confidentialitÃ© des donnÃ©es personnelles collectÃ©es (noms, adresses e-mails et mots de passe) lors de lâ€™inscription ; et conformÃ©ment Ã  la loi Informatique et LibertÃ©s du 6 janvier 1978, tout utilisateur dispose d''un droit d''accÃ¨s, de modification, de rectification et de suppression de ses donnÃ©es.\n   Cependant, ce forum ne peut garantir ni la confidentialitÃ© ni lâ€™effacement des donnÃ©es personnelles postÃ©es volontairement par lâ€™utilisateur dans les parties publiques du forum.Ainsi, ce forum ne saurait Ãªtre tenu responsable du "spam" subi par les utilisateurs des forums qui auraient dÃ©cidÃ© volontairement et spontanÃ©ment de publier en ligne leur adresse email. \n   ConformÃ©ment aux dispositions de la loi dans la Confiance dans lâ€™Ã©conomie numÃ©rique du 21 juin 2004, les donnÃ©es de nature Ã  permettre l''identification des internautes (et notamment les adresses IP) ayant contribuÃ© Ã  la crÃ©ation de contenus sur ce forum sont dÃ©tenues et conservÃ©es, et Ã  la disposition des autoritÃ©s.\n\nModÃ©ration\n\n   Les forums sont ouverts Ã  tout le monde, chacun est libre dâ€™y intervenir, de maniÃ¨re anonyme ou identifiÃ©e. Nous avons choisi de les modÃ©rer a posteriori pour les rendre plus vivants. Les messages postÃ©s sont donc immÃ©diatement visibles en ligne.\n   Les modÃ©rateurs surveillent les discussions et les organisent. Leur rÃ´le nâ€™est pas de censurer mais de vÃ©rifier que les propos tenus sur les forums de discussion restent courtois, respectueux et surtout conformes aux lois en vigueur. Les modÃ©rateurs pourront donc effacer immÃ©diatement les messages  qui vont Ã  l''encontre des rÃ¨gles Ã©noncÃ©es dans la section Respect de la lÃ©gislation. \n    En plus de ces rÃ¨gles, les modÃ©rateurs peuvent supprimer les messages inintelligibles (langage SMS, hors sujets ou postÃ©s dans plusieurs discussions Ã  la fois. \n   Il est aussi fortement conseiller de faire en sorte de poster dans la thÃ©matique adÃ©quate, ceci pour avoir plus de chance de recevoir des rÃ©ponses, mais aussi pour Ã©viter un certain dÃ©sordre dans le forum, qui serait arrangÃ© par la suppression du sujet mal placÃ©. De plus, tout message publiÃ© plusieurs fois dans des discussions diffÃ©rentes fera l''objet d''une modÃ©ration, et son utilisateur s''en verra averti.\n   Les conditions de bannissement d''un utilisateur varient en fonction du cas (gravitÃ© des propos, frÃ©quence de perturbation, profil, etc.). \n   Cependant, ce forum sâ€™efforce de maniÃ¨re gÃ©nÃ©rale de notifier aux internautes concernÃ©s une mise en garde avant toute sanction. \n   De plus, ce forum nâ€™assume aucune responsabilitÃ© au titre de la qualitÃ© et de la conformitÃ© lÃ©gale des contenus, quelque quâ€™ils soient (textes, sons, vidÃ©os, graphismes, photos ou autres) ainsi produits librement par les utilisateurs. Ce forum peut aussi, conformÃ©ment Ã  ses obligations lÃ©gales, supprimer lesdits contenus aprÃ¨s quâ€™un tiers ait fait valoir le caractÃ¨re illicite du contenu concernÃ©.\n   Ce forum peut prendre l''initiative, sans mise en demeure prÃ©alable, de supprimer, en totalitÃ© ou partiellement, tout contenu diffusÃ© sur les forums, si ce contenu est susceptible de porter atteinte aux lois et rÃ¨glements en vigueur ou aux bonnes moeurs.\n   En cas dâ€™abus rÃ©pÃ©tÃ©s, ce forum se rÃ©serve le droit de porter plainte et tiendra Ã  disposition de la justice les adresses IP des utilisateurs mis en cause.', '2013-05-31 15:20:26', 5, 2),
(3, 'Salut bien venu Jambon ^^\r\nps:j''aime le jambon formage ^^', '2013-05-31 15:36:50', 2, 1),
(4, '(post autiste by Konstantin)', '2013-05-31 15:39:12', 2, 1),
(5, 'Chuck Norris a battu Usain Bolt Ã  la course, en moonwalk.\r\nChuck Norris peut ressusciter un angle mort.\r\nUn jour, Chuck Norris a failli attraper Parkinson... Parkinson en tremble encore !\r\nChuck Norris a dÃ©jÃ  comptÃ© jusqu''Ã  l''infini. Deux fois.\r\nGoogle, c''est le seul endroit oÃ¹ tu peux taper Chuck Norris...\r\nDÃ®tes moi ce que vous en pensez :p !', '2013-05-31 15:56:42', 4, 3),
(6, 'Deux poules discutent:\r\n- Comment vas-tu ma cocotte?\r\n- Pas trÃ¨s bien. Je crois que je couve quelque chose ! \r\nAhahah postez vos blagues vous aussi !', '2013-05-31 15:58:09', 4, 4),
(7, 'Le pÃ¢tÃ© HÃ©naff et sont histoire est pour moi l''une des plus belles choses au monde, c''est pourquoi je veux vous en faire part :\r\n-DÃ©couvrir HÃ©naff\r\n\r\n	-Histoire: \r\n		-L''aventure HÃ©naff est l''une des plus belles aventures des entreprises de Bretagne:\r\n\r\nConserveur depuis 1907, HÃ©naff est aujourdâ€™hui le leader incontestÃ© des pÃ¢tÃ©s et rillettes en conserves en France Ã  travers une politique de qualitÃ© unique et diffÃ©renciÃ©e. Entreprise familiale et indÃ©pendante de lâ€™extrÃªme ouest de la Bretagne, l''entreprise doit sa rÃ©ussite Ã  son intransigeance sur la qualitÃ© des produits fabriquÃ©s, Ã  la conscience professionnelle exceptionnelle de ses collaborateurs et Ã  lâ€™engagement dÃ©vouÃ© de ses dirigeants pour le dÃ©veloppement du territoire et le respect de l''environnement. \r\n\r\n		-De la fourche Ã  la fourchette, leur culture de la haute qualitÃ© produit est aux fondements des valeurs de la marque:\r\n\r\nElle justifie les liens de la marque poussÃ©s avec les Ã©leveurs de porc et leurs filiÃ¨res dâ€™approvisionnement, leur politique dâ€™achat et leur cahier des charges porc, leurs mÃ©thodes de fabrication artisanales mais Ã  la pointe de la technologie, leur politique de relations humaines, la maÃ®trise en interne de la prÃ©servation de lâ€™environnement ou lâ€™exploitation dâ€™une boutique et dâ€™un musÃ©e dâ€™entreprise : La Maison du PÃ¢tÃ© HÃ©naff. \r\n\r\n		-En ce sens, l''entreprise HÃ©naff poursuit durablement l''oeuvre de son fondateur:\r\n\r\nEn effet, Jean HÃ©naff, alors simple paysan breton, imagine et fait construire une conserverie rÃ©servÃ©e Ã  la production locale de petits pois et de haricots verts en 1907. Il le fait pour permettre aux agriculteurs de vendre localement leur production, et limiter l''exode dont souffre alors le Pays bigouden en crÃ©ant des emplois. \r\nSept ans plus tard, pour combler lâ€™inactivitÃ© en basse saison, il se lance dans la production de pÃ¢tÃ© et le paysan-conserveur fait alors une dÃ©couverte Ã©tonnante, en associant notamment les morceaux les plus nobles du porc (jambons et filets) Ã  un savant mÃ©lange dâ€™Ã©pices, il crÃ©e une recette gourmande inÃ©dite. Câ€™est la naissance du fameux pÃ¢tÃ© HÃ©naff dÃ©jÃ  dans sa boÃ®te bleue et jaune, qui va faire la renommÃ©e de la Maison HÃ©naff.\r\n	-HÃ©naff en chiffres:\r\nLa sociÃ©tÃ© est une entreprise familiale dirigÃ©e par LoÃ¯c HÃ©naff, arriÃ¨re petit-fils du fondateur.\r\nJean-Jacques HÃ©naff, son pÃ¨re, reste PrÃ©sident du Conseil dâ€™Administration.\r\n Le capital de la sociÃ©tÃ© : 5.040.000â‚¬ est dÃ©tenu majoritairement par la famille. \r\n		-Chiffres d''Affaires, parts de marchÃ©...\r\n	-CA 2011 : + 5,2 % par rapport Ã  2010, soit 42,8 millions dâ€™euros. \r\n	-Part du PÃ¢tÃ© HÃ©naff dans le CA : environ 45% \r\n	-Export : 5% du CA dans 50 pays en Asie, Russie, Afrique, BrÃ©sil, Australie, â€¦ et 100 000 boÃ®tes de PÃ¢tÃ© HÃ©naff vendues aux USA en 2009. \r\n	-HÃ©naff est aujourdâ€™hui la 1Ã¨re marque de pÃ¢tÃ©s appertisÃ©s en France (26,7% de part de marchÃ© valeur) \r\n	-HÃ©naff est le 1er vendeur de boÃ®tes depuis 20 ans, et 1er vendeur de bocaux depuis 1 an ! \r\n		-Usine et production:\r\n	-SituÃ©e Ã  Pouldreuzic dans le FinistÃ¨re, lâ€™entreprise emploie 211 personnes. \r\n	-Une usine de 65 000 m2 Ã  Pouldreuzic \r\n	-Nombre de boÃ®tes de PÃ¢tÃ© HÃ©naff : 35 millions par an \r\n	-Nombre de porcs traitÃ©s dans les abattoirs HÃ©naff : 40 000 par an. 100 % des porcs abattus chez HÃ©naff ont Ã©tÃ© Ã©levÃ©s en Bretagne.Â  \r\n	-Outre son produit phare Â« Le PÃ¢tÃ© HÃ©naff Â» conditionnÃ© dans la petite boÃ®te bleue et jaune , HÃ©naff dÃ©veloppe une gamme complÃ¨te de pÃ¢tÃ©s : pÃ¢tÃ© de foie, de campagne, de jambon, mousse de canard, rillettes, etc. \r\n	-La Maison du PÃ¢tÃ© HÃ©naff : 1 boutique et 1 musÃ©e (7000 visiteurs parÂ  an) Ã  Pouldreuzic. \r\n	\r\n	-La recette du pÃ¢tÃ© HÃ©naff :\r\nSed auctor erat in arcu laoreet hendrerit. Nam mi lorem, euismod ut vehicula a, semper rhoncus erat. Donec suscipit, diam eget interdum ornare, nisl est faucibus neque, eu porta mauris metus eget lorem. Phasellus tincidunt sem vel ante tincidunt et mollis diam molestie. Nullam porttitor, diam ut placerat feugiat, tellus odio bibendum lectus, sed malesuada lectus diam vestibulum velit. Morbi ut urna leo. Nulla eget nisl libero. Etiam pulvinar convallis orci. \r\nPhasellus viverra eleifend libero, quis placerat risus feugiat lobortis. In porta, neque eu volutpat tincidunt, nunc turpis feugiat neque, non interdum quam neque in metus. Integer quis nunc magna. Vivamus est nulla, malesuada ac dapibus sed, iaculis ut mauris. Quisque odio dui, lacinia nec accumsan at, faucibus et nunc. In cursus iaculis elementum. Suspendisse at cursus massa. \r\nDonec ac enim magna, vitae rhoncus sem. Nunc pulvinar urna tristique metus tristique luctus at at leo. Maecenas sagittis, sapien in convallis facilisis, eros metus faucibus purus, ac rutrum tortor nunc at augue. Vivamus posuere convallis cursus. In tristique vehicula ante, a eleifend urna suscipit sit amet. Aliquam a nulla felis. Curabitur eu erat quis nibh pharetra commodo. Quisque imperdiet malesuada hendrerit. Nulla facilisi. Proin pharetra euismod metus at ultrices. Phasellus gravida tellus vel ante vestibulum tempus. Nam blandit, augue nec molestie blandit, dolor metus sollicitudin ante, vel lobortis nisl diam et mauris. ', '2013-05-31 16:00:34', 4, 5),
(8, 'Ahahah j''espÃ¨re que vous avez aimÃ© ma petite blague, la recette est bel est bien cachÃ©e aux yeux de tous !', '2013-05-31 16:01:25', 4, 5),
(9, 'Merci Ã  toi ThePatriot, prÃ©sente toi aussi, j''aimerai en apprendre plus sur toi!\r\nPs: J''ai oubliÃ© de prÃ©ciser prÃ©cÃ©demment que j''habite en Bourgogne, plus prÃ©cisÃ©ment Ã  St-Gapour!\r\nBises, Bertrand.', '2013-05-31 16:10:24', 4, 1),
(10, 'Ce forum Ã  pour but de proposer un moyen de communication entre les membres, de l''entraide et de la bonne humeur. Les utilisateurs sont libres de crÃ©er des topics, dans les sous-forum et catÃ©gories adaptÃ©es, ainsi que de poster des messages, tout en respectant le rÃ¨glement du Forum!\r\nA bientÃ´t sur le forum :) !', '2013-05-31 16:32:03', 4, 6),
(11, 'Salut. Je suis celui qui a fait les conditions d''utilisation (merci CTRL+C). Alors respectez-lez sinon je tue vos mÃ¨res Ã  coup de gland, dÃ©dicace Ã  Jambon-Fromage. Hodor !', '2013-05-31 16:36:23', 5, 7),
(12, 'MERGWEZ', '2013-05-31 16:36:26', 2, 2),
(13, 'Quel est le jeu prÃ©fÃ©rÃ© des super-hÃ©ros ?\r\nCap ou pas cap !!\r\nLOOOOOOOOOOOOOOOOOOOOOOOL', '2013-05-31 16:39:27', 5, 4),
(14, 'Pourquoi y a pas de ballon sur le plateau de Question pour un Champion ?\r\nParce que Julien Lepers.', '2013-05-31 16:40:29', 5, 4),
(15, 'Chuck Norris cueille les cerises avec la queue, alors que beaucoup galÃ¨rent encore avec la main.', '2013-05-31 16:41:30', 5, 3),
(16, 'Eh Jambon-Fromage c''est trop RIGOLOOOOOOO ce que tu mets ! @+++', '2013-05-31 16:42:11', 5, 3),
(17, 'Tout est dans le titre (mÃªme Prat).', '2013-05-31 16:42:55', 2, 8);

-- --------------------------------------------------------

--
-- Structure de la table `topics`
--

CREATE TABLE IF NOT EXISTS `topics` (
  `t.id` int(11) NOT NULL AUTO_INCREMENT,
  `t.name` varchar(64) CHARACTER SET utf8 NOT NULL,
  `t.nb_views` int(11) NOT NULL,
  `t.author_id` int(11) NOT NULL,
  `t.forum_id` int(11) NOT NULL,
  `t.lastpost_id` int(11) NOT NULL,
  PRIMARY KEY (`t.id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Contenu de la table `topics`
--

INSERT INTO `topics` (`t.id`, `t.name`, `t.nb_views`, `t.author_id`, `t.forum_id`, `t.lastpost_id`) VALUES
(1, 'PrÃ©sentation de Jambon-Fromage', 14, 4, 3, 9),
(2, 'Conditions d''utilisation', 26, 5, 1, 12),
(3, 'I <3 Chuck Norris 4 ever <33', 4, 4, 6, 16),
(4, 'Blagues Carambar', 5, 4, 5, 14),
(5, 'PÃ¢tÃ© HÃ©naff: ma passion!', 5, 4, 4, 8),
(6, 'But et fonctionnement', 2, 4, 2, 10),
(7, 'PrÃ©sentation de Moderator', 1, 5, 3, 11),
(8, 'BETTER NERF IRELIA !', 1002, 2, 4, 17);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
