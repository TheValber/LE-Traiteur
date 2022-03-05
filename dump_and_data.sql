DROP VIEW Preference;
DROP VIEW PlatTotal;
DROP TABLE Grossiste CASCADE;
DROP TABLE ComGrossiste CASCADE;
DROP TABLE Ingredient CASCADE;
DROP TABLE Caracteristique CASCADE;
DROP TABLE Plat CASCADE;
DROP TABLE Commande CASCADE;
DROP TABLE Client CASCADE;
DROP TABLE Compose CASCADE;
DROP TABLE Contient CASCADE;
DROP TABLE Restocke CASCADE;
DROP TABLE Possede CASCADE;

/* Tables */

CREATE TABLE Grossiste(
  idGrossiste varchar(8) PRIMARY KEY,
  nom varchar(40) NOT NULL,
  adresse varchar(50),
  numTel char(10) UNIQUE
);

CREATE TABLE ComGrossiste(
  numCom serial PRIMARY KEY,
  dateCom date NOT NULL,
  idGrossiste varchar(8),
  FOREIGN KEY (idGrossiste) REFERENCES Grossiste(idGrossiste)
  ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Ingredient(
  idIngr varchar(8) PRIMARY KEY,
  quantite int NOT NULL,
  uniteQuantite varchar(3),
  nomIngr varchar(25) NOT NULL,
  provenance varchar(50)
);

CREATE TABLE Caracteristique(
  idCarac varchar(8) PRIMARY KEY,
  descriptif text NOT NULL
);

CREATE TABLE Plat(
  idPlat varchar(8) PRIMARY KEY,
  description text,
  nomPlat varchar(50) NOT NULL,
  image varchar(25),
  prix numeric(8,2) NOT NULL
);

CREATE TABLE Client(
  idCli varchar(8) PRIMARY KEY,
  login varchar(15) NOT NULL UNIQUE,
  mdp varchar(50) NOT NULL,
  nom varchar(25),
  prenom varchar(25),
  telephone char(10)
);

CREATE TABLE Commande(
  numCom serial PRIMARY KEY,
  livraison varchar(3) NOT NULL,
  avancement varchar(11) NOT NULL,
  montant numeric(8,2) NOT NULL,
  adresse varchar(50),
  idCli varchar(8),
  CONSTRAINT oui_ou_non CHECK(livraison='oui' OR livraison='non'),
  FOREIGN KEY (idCli) REFERENCES Client(idCli) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Compose(
  idPlat varchar(8),
  idIngr varchar(8),
  quantite int NOT NULL,
  PRIMARY KEY(idPlat, idIngr),
  FOREIGN KEY (idPlat) REFERENCES Plat(idPlat) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (idIngr) REFERENCES Ingredient(idIngr) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Contient(
  idPlat varchar(8),
  numCom int,
  nombre int NOT NULL,
  PRIMARY KEY(idPlat, numCom),
  FOREIGN KEY (idPlat) REFERENCES Plat(idPlat) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (numCom) REFERENCES Commande(numCom) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Restocke(
  numCom int,
  idIngr varchar(8),
  dateLivr date,
  quantite int NOT NULL,
  PRIMARY KEY(numCom, idIngr),
  FOREIGN KEY (numCom) REFERENCES ComGrossiste(numCom) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (idIngr) REFERENCES Ingredient(idIngr) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Possede(
  idIngr varchar(8),
  idCarac varchar(8),
  PRIMARY KEY(idIngr, idCarac),
  FOREIGN KEY (idIngr) REFERENCES Ingredient(idIngr) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (idCarac) REFERENCES Caracteristique(idCarac) ON DELETE CASCADE ON UPDATE CASCADE
);

/* Vues */

CREATE VIEW PlatTotal(client, nbPlat) AS (
  SELECT idCli, sum(nombre) AS nbPlat
  FROM Commande NATURAL JOIN Contient
  GROUP BY idCli
  ORDER BY nbPlat DESC
);

CREATE VIEW Preference(client, platPref, nbCommande) AS(
  SELECT com1.idCli, c1.idPlat, sum(c1.nombre) AS nbCom
  FROM Commande AS com1, Contient AS c1
  WHERE com1.numCom = c1.numCom
  GROUP BY com1.idCli, idPlat
  HAVING sum(c1.nombre) >= all
    (
      SELECT sum(c2.nombre)
      FROM Commande AS com2, Contient AS c2
      WHERE com1.idCli = com2.idCli AND com2.numCom = c2.numCom
      GROUP BY c2.idPlat
    )
  ORDER BY idCli
);

/* Grossiste(idGrossiste, nom, adresse, numTel) */

INSERT INTO Grossiste VALUES ('W76HWDE2', 'Grosstock', '2 rue de la République', 0689954187);
INSERT INTO Grossiste VALUES ('TC3CY65R', 'Alimental', '4 avenue Charles de Gaulle', 0712132454);
INSERT INTO Grossiste VALUES ('FDZE7K9S', 'Extramiam', NULL, NULL);

/* ComGrossiste(numCom, dateCom, idGrossiste) */

INSERT INTO ComGrossiste(dateCom, idGrossiste) VALUES ('2016-06-30', 'W76HWDE2');
INSERT INTO ComGrossiste(dateCom, idGrossiste) VALUES ('2017-12-20', 'TC3CY65R');
INSERT INTO ComGrossiste(dateCom, idGrossiste) VALUES ('2018-05-14', 'W76HWDE2');
INSERT INTO ComGrossiste(dateCom, idGrossiste) VALUES ('2019-03-25', 'W76HWDE2');
INSERT INTO ComGrossiste(dateCom, idGrossiste) VALUES ('2020-04-18', 'TC3CY65R');
INSERT INTO ComGrossiste(dateCom, idGrossiste) VALUES ('2021-11-24', 'W76HWDE2');

/* Ingredient(idIngr, quantite, uniteQuantite, nomIngr, provenance) */

INSERT INTO Ingredient VALUES ('BOPOUL', 10000, 'g', 'Bouillon de poule', NULL);
INSERT INTO Ingredient VALUES ('CAROTTE', 10000, 'g', 'Carotte', NULL);
INSERT INTO Ingredient VALUES ('CHAMPI', 10000, 'g', 'Champignon', NULL);
INSERT INTO Ingredient VALUES ('JUSCITR', 10000, 'ml', 'Jus de citron', NULL);
INSERT INTO Ingredient VALUES ('FARINE', 10000, 'g', 'Farine', NULL);
INSERT INTO Ingredient VALUES ('VINBLC', 10000, 'ml', 'Vin blanc', NULL);
INSERT INTO Ingredient VALUES ('SEL', 10000, 'mg', 'Sel', NULL);
INSERT INTO Ingredient VALUES ('POIVRE', 10000, 'mg', 'Poivre', NULL);
INSERT INTO Ingredient VALUES ('VEAU', 10000, 'g', 'Veau', NULL);
INSERT INTO Ingredient VALUES ('BOLEGUM', 10000, 'g', 'Bouillon de légume', NULL);
INSERT INTO Ingredient VALUES ('OIGNON', 10000, 'g', 'Oignon', NULL);
INSERT INTO Ingredient VALUES ('CRMFRCHE', 10000, 'ml', 'Crème fraîche', NULL);
INSERT INTO Ingredient VALUES ('OEUF', 10000, NULL, 'Oeuf', NULL);
INSERT INTO Ingredient VALUES ('LAIT', 10000, 'ml', 'Lait', NULL);
INSERT INTO Ingredient VALUES ('BEURRE', 10000, 'g', 'Beurre', NULL);
INSERT INTO Ingredient VALUES ('PATES', 10000, 'g', 'Pâtes', NULL);
INSERT INTO Ingredient VALUES ('AIL', 10000, 'g', 'Ail', NULL);
INSERT INTO Ingredient VALUES ('TOMATE', 10000, 'g', 'Tomate', NULL);
INSERT INTO Ingredient VALUES ('EAU', 10000, 'cl', 'Eau', NULL);
INSERT INTO Ingredient VALUES ('VINRGE', 10000, 'ml', 'Vin Rouge', NULL);
INSERT INTO Ingredient VALUES ('EPICE', 10000, 'mg', 'Autres épices', NULL);
INSERT INTO Ingredient VALUES ('PARMESAN', 10000, 'g', 'Parmesan', NULL);
INSERT INTO Ingredient VALUES ('BOEUF', 10000, 'g', 'Boeuf', NULL);
INSERT INTO Ingredient VALUES ('FROMRAPE', 10000, 'g', 'Fromage râpé', NULL);
INSERT INTO Ingredient VALUES ('CHORIZO', 10000, NULL, 'Chorizo', NULL);
INSERT INTO Ingredient VALUES ('HUILE', 10000, 'ml', 'Huile', NULL);
INSERT INTO Ingredient VALUES ('OLIVE', 10000, 'g', 'Olive', NULL);
INSERT INTO Ingredient VALUES ('PUREE', 10000, 'g', 'Purée', NULL);
INSERT INTO Ingredient VALUES ('AUBERG', 10000, 'g', 'Aubergine', NULL);
INSERT INTO Ingredient VALUES ('PATATE', 10000, 'g', 'Pomme de terre', NULL);
INSERT INTO Ingredient VALUES ('MIEL', 10000, 'ml', 'Miel', NULL);
INSERT INTO Ingredient VALUES ('LARDON', 10000, 'g', 'Lardon', NULL);
INSERT INTO Ingredient VALUES ('SAUMON', 10000, 'g', 'Saumon', NULL);
INSERT INTO Ingredient VALUES ('MOUTARDE', 10000, 'g', 'Moutarde', NULL);
INSERT INTO Ingredient VALUES ('POULET', 10000, 'g', 'Poulet', NULL);
INSERT INTO Ingredient VALUES ('ECHALOTE', 10000, 'g', 'Echalote', NULL);
INSERT INTO Ingredient VALUES ('PATFEUIL', 10000, 'g', 'Pâte feuilletée', NULL);
INSERT INTO Ingredient VALUES ('PORC', 10000, 'g', 'Porc', NULL);
INSERT INTO Ingredient VALUES ('JAMBON', 10000, 'g', 'Jambon Blanc', NULL);

/* Caractéristique(idCarac, descriptif) */

INSERT INTO Caracteristique VALUES ('VIANDE', 'Contient de la viande');
INSERT INTO Caracteristique VALUES ('ALCOOL', 'Contient de l''alcool');
INSERT INTO Caracteristique VALUES ('BIO', 'Issu de l''agriculture biologique');
INSERT INTO Caracteristique VALUES ('RAD', 'Hautement radioactif');

/* Plat(idPlat, description, nomPlat, image, prix) */

INSERT INTO Plat VALUES ('BLQTVEAU', 'La blanquette de veau est une recette traditionnelle de cuisine française, à base de viande de veau cuite dans un bouillon avec carotte, poireau, oignon et bouquet garni, liée en sauce blanche à la crème et au beurre et aux champignons de Paris.', 'Blanquette de veau', 'blqveau.png', 25.99);
INSERT INTO Plat VALUES ('LASABOLO', 'Préparation utilisant des pâtes alimentaires en forme de larges plaques et généralement faite de couches alternées de pâtes, de fromage et d''une sauce tomate avec de la viande.', 'Lasagnes à la bolognaise', 'lasabolo.png', 10.59);
INSERT INTO Plat VALUES ('VEAUCHZO', 'Morceaux de veau revenus à feu vif dans une matière grasse accompagnée d''une sauce et de chorizo.', 'Sauté de veau au chorizo', 'veauchzo.png', 20.35);
INSERT INTO Plat VALUES ('FILMINCR', 'Morceau très tendre de porc avec du jambon blanc entouré d''une croûte parsemée de gruyère râpé.', 'Filet mignon en croûte', 'filmincr.png', 35.69);
INSERT INTO Plat VALUES ('HACHPARM', 'Le hachis Parmentier est un plat à base de purée de pommes de terre et de viande de bœuf hachée. Ce gratin doit son nom à l''apothicaire Antoine Parmentier, qui, convaincu que le tubercule pouvait combattre efficacement la disette, le fit goûter à Louis XVI.', 'Hachis Parmentier', 'hachparm.png', 17.00);
INSERT INTO Plat VALUES ('MOUSSAKA', 'La moussaka est un plat traditionnel des Balkans et du Moyen-Orient, mais le plus souvent associé à la Grèce ou la Turquie, composé d''aubergines grillées, d''oignons et de tomates.', 'Moussaka Grecque', 'moussaka.png', 6.99);
INSERT INTO Plat VALUES ('BRGIGNON', 'Le bœuf bourguignon est une recette de cuisine d''estouffade de bœuf, traditionnelle de la cuisine bourguignonne, cuisinée au vin rouge de Bourgogne, avec une garniture de champignons, de petits oignons et de lardons.', 'Boeuf bourguignon', 'brgignon.png', 22.50);
INSERT INTO Plat VALUES ('SAUMPAPI', 'Pavé de saumon accompagné de ses tomates cerise et champignons de Paris frais.', 'Saumon en papillote', 'saumpapi.png', 20.20);
INSERT INTO Plat VALUES ('POULCHMP', 'Poulet sur son lit de champignons accompagné de moutarde.', 'Poulet aux champignon', 'poulchmp.png', 19.90);

/* Client(idCli, login, mdp, nom, prenom, telephone) */

INSERT INTO Client VALUES ('f245923d', 'Fivereclums', '35df1fd9b0e4f91786e09f26e9f47a92', 'Hervieux', 'Belisarda', '0326756047');
INSERT INTO Client VALUES ('007931d6', 'Songdom', '22db6a4934022e835067a6d551bad46c', NULL, NULL, '0218900020');
INSERT INTO Client VALUES ('0a73beba', 'Xvier1972', 'b45319631eb2e6ae809285b66cb5e3c2', 'Montminy', 'Marcel', '0146380144');
INSERT INTO Client VALUES ('15157ba5', 'Coveress10', '58aeae79d0e3af1e599075359524cb18', 'Fugere', 'Roux', NULL);
INSERT INTO Client VALUES ('221c857d', 'Zing1949', '07655ac88af7c6b7fa617360b9163383', 'Paulet', 'Courtland', NULL);
INSERT INTO Client VALUES ('2a753f0c', 'Imente', '8bd3911462f3aeda84a9dfe43a948006', 'Baril', NULL, '0453216776');
INSERT INTO Client VALUES ('3346aa75', 'Rumne1932', 'f720ad86540d492331c9ceefdbc0354e', 'Leclerc', 'Oceane', '0182869103');
INSERT INTO Client VALUES ('377b3e44', 'Adarming', '153265f6f30525df46022ba5495d2f55', NULL, 'Harriette', NULL);
INSERT INTO Client VALUES ('3b290a90', 'Camuctued97', 'aea545c5fa2631670b27c5edb2c644e7', NULL, 'Babette', '0107249843');

/* Commande(numCom, livraison, avancement, montant, adresse, idCli) */

INSERT INTO Commande(livraison, avancement, montant, adresse, idCli) VALUES ('oui', 'terminée', 30.97, '5 boulevard Albin Duran Chalon-Sur-Saône', 'f245923d');
INSERT INTO Commande(livraison, avancement, montant, adresse, idCli) VALUES ('oui', 'attente', 71.58, '96 cours Marechal-Joffre Dieppe', '007931d6');
INSERT INTO Commande(livraison, avancement, montant, adresse, idCli) VALUES ('non', 'prête', 84.72, NULL, '007931d6');
INSERT INTO Commande(livraison, avancement, montant, adresse, idCli) VALUES ('non', 'création', 10.59, NULL, '007931d6');
INSERT INTO Commande(livraison, avancement, montant, adresse, idCli) VALUES ('non', 'attente', 103.96, NULL, '0a73beba');
INSERT INTO Commande(livraison, avancement, montant, adresse, idCli) VALUES ('oui', 'terminée', 90.80, '63 rue de Verdun Montgeron', '0a73beba');
INSERT INTO Commande(livraison, avancement, montant, adresse, idCli) VALUES ('oui', 'création', 180.72, '17 rue Roussy Noisy-Le-Sec', '0a73beba');
INSERT INTO Commande(livraison, avancement, montant, adresse, idCli) VALUES ('oui', 'préparation', 1710.00, 'ché moa', '15157ba5');
INSERT INTO Commande(livraison, avancement, montant, adresse, idCli) VALUES ('non', 'attente', 19.90, NULL, '221c857d');
INSERT INTO Commande(livraison, avancement, montant, adresse, idCli) VALUES ('non', 'attente', 20.35, NULL, '2a753f0c');
INSERT INTO Commande(livraison, avancement, montant, adresse, idCli) VALUES ('non', 'attente', 35.69, NULL, '3346aa75');
INSERT INTO Commande(livraison, avancement, montant, adresse, idCli) VALUES ('oui', 'livraison', 50.70, '11 bd de la Libération Marseille', '2a753f0c');
INSERT INTO Commande(livraison, avancement, montant, adresse, idCli) VALUES ('non', 'attente', 17.00, NULL, '377b3e44');
INSERT INTO Commande(livraison, avancement, montant, adresse, idCli) VALUES ('non', 'création', 17.00, NULL, '377b3e44');
INSERT INTO Commande(livraison, avancement, montant, adresse, idCli) VALUES ('non', 'attente', 35.16, NULL, '3b290a90');
INSERT INTO Commande(livraison, avancement, montant, adresse, idCli) VALUES ('non', 'création', 67.39, NULL, '3b290a90');

/* Compose(idPlat, idIngr, quantite) */

INSERT INTO Compose VALUES ('BLQTVEAU', 'BOPOUL', 3);
INSERT INTO Compose VALUES ('BLQTVEAU', 'CAROTTE', 63);
INSERT INTO Compose VALUES ('BLQTVEAU', 'CHAMPI', 25);
INSERT INTO Compose VALUES ('BLQTVEAU', 'JUSCITR', 20);
INSERT INTO Compose VALUES ('BLQTVEAU', 'FARINE', 5);
INSERT INTO Compose VALUES ('BLQTVEAU', 'VINBLC', 65);
INSERT INTO Compose VALUES ('BLQTVEAU', 'SEL', 5);
INSERT INTO Compose VALUES ('BLQTVEAU', 'POIVRE', 2);
INSERT INTO Compose VALUES ('BLQTVEAU', 'VEAU', 250);
INSERT INTO Compose VALUES ('BLQTVEAU', 'BOLEGUM', 3);
INSERT INTO Compose VALUES ('BLQTVEAU', 'OIGNON', 25);
INSERT INTO Compose VALUES ('BLQTVEAU', 'CRMFRCHE', 50);
INSERT INTO Compose VALUES ('BLQTVEAU', 'OEUF', 1);
INSERT INTO Compose VALUES ('LASABOLO', 'FARINE', 13);
INSERT INTO Compose VALUES ('LASABOLO', 'LAIT', 250);
INSERT INTO Compose VALUES ('LASABOLO', 'BEURRE', 16);
INSERT INTO Compose VALUES ('LASABOLO', 'PATES', 125);
INSERT INTO Compose VALUES ('LASABOLO', 'AIL', 2);
INSERT INTO Compose VALUES ('LASABOLO', 'EPICE', 3);
INSERT INTO Compose VALUES ('LASABOLO', 'CAROTTE', 31);
INSERT INTO Compose VALUES ('LASABOLO', 'TOMATE', 100);
INSERT INTO Compose VALUES ('LASABOLO', 'EAU', 2);
INSERT INTO Compose VALUES ('LASABOLO', 'VINRGE', 25);
INSERT INTO Compose VALUES ('LASABOLO', 'PARMESAN', 16);
INSERT INTO Compose VALUES ('LASABOLO', 'SEL', 5);
INSERT INTO Compose VALUES ('LASABOLO', 'POIVRE', 2);
INSERT INTO Compose VALUES ('LASABOLO', 'OIGNON', 33);
INSERT INTO Compose VALUES ('LASABOLO', 'BOEUF', 75);
INSERT INTO Compose VALUES ('VEAUCHZO', 'CHORIZO', 1);
INSERT INTO Compose VALUES ('VEAUCHZO', 'EPICE', 2);
INSERT INTO Compose VALUES ('VEAUCHZO', 'AIL', 2);
INSERT INTO Compose VALUES ('VEAUCHZO', 'HUILE', 5);
INSERT INTO Compose VALUES ('VEAUCHZO', 'VEAU', 250);
INSERT INTO Compose VALUES ('VEAUCHZO', 'TOMATE', 200);
INSERT INTO Compose VALUES ('VEAUCHZO', 'OLIVE', 40);
INSERT INTO Compose VALUES ('VEAUCHZO', 'OIGNON', 67);
INSERT INTO Compose VALUES ('HACHPARM', 'PUREE', 75);
INSERT INTO Compose VALUES ('HACHPARM', 'AIL', 4);
INSERT INTO Compose VALUES ('HACHPARM', 'TOMATE', 75);
INSERT INTO Compose VALUES ('HACHPARM', 'FARINE', 5);
INSERT INTO Compose VALUES ('HACHPARM', 'EPICE', 1);
INSERT INTO Compose VALUES ('HACHPARM', 'PARMESAN', 8);
INSERT INTO Compose VALUES ('HACHPARM', 'SEL', 5);
INSERT INTO Compose VALUES ('HACHPARM', 'POIVRE', 2);
INSERT INTO Compose VALUES ('HACHPARM', 'BOEUF', 100);
INSERT INTO Compose VALUES ('HACHPARM', 'OIGNON', 50);
INSERT INTO Compose VALUES ('HACHPARM', 'OEUF', 1);
INSERT INTO Compose VALUES ('HACHPARM', 'BEURRE', 8);
INSERT INTO Compose VALUES ('HACHPARM', 'FROMRAPE', 13);
INSERT INTO Compose VALUES ('MOUSSAKA', 'FARINE', 15);
INSERT INTO Compose VALUES ('MOUSSAKA', 'LAIT', 90);
INSERT INTO Compose VALUES ('MOUSSAKA', 'BEURRE', 13);
INSERT INTO Compose VALUES ('MOUSSAKA', 'AUBERG', 200);
INSERT INTO Compose VALUES ('MOUSSAKA', 'PATATE', 75);
INSERT INTO Compose VALUES ('MOUSSAKA', 'TOMATE', 225);
INSERT INTO Compose VALUES ('MOUSSAKA', 'HUILE', 10);
INSERT INTO Compose VALUES ('MOUSSAKA', 'EPICE', 2);
INSERT INTO Compose VALUES ('MOUSSAKA', 'MIEL', 3);
INSERT INTO Compose VALUES ('MOUSSAKA', 'SEL', 5);
INSERT INTO Compose VALUES ('MOUSSAKA', 'POIVRE', 2);
INSERT INTO Compose VALUES ('MOUSSAKA', 'BOEUF', 125);
INSERT INTO Compose VALUES ('MOUSSAKA', 'OIGNON', 25);
INSERT INTO Compose VALUES ('BRGIGNON', 'VINRGE', 125);
INSERT INTO Compose VALUES ('BRGIGNON', 'AIL', 3);
INSERT INTO Compose VALUES ('BRGIGNON', 'FARINE', 5);
INSERT INTO Compose VALUES ('BRGIGNON', 'EPICE', 1);
INSERT INTO Compose VALUES ('BRGIGNON', 'CHAMPI', 42);
INSERT INTO Compose VALUES ('BRGIGNON', 'SEL', 5);
INSERT INTO Compose VALUES ('BRGIGNON', 'POIVRE', 2);
INSERT INTO Compose VALUES ('BRGIGNON', 'BOEUF', 134);
INSERT INTO Compose VALUES ('BRGIGNON', 'LARDON', 17);
INSERT INTO Compose VALUES ('BRGIGNON', 'BEURRE', 9);
INSERT INTO Compose VALUES ('BRGIGNON', 'OIGNON', 33);
INSERT INTO Compose VALUES ('SAUMPAPI', 'TOMATE', 75);
INSERT INTO Compose VALUES ('SAUMPAPI', 'CHAMPI', 75);
INSERT INTO Compose VALUES ('SAUMPAPI', 'AIL', 3);
INSERT INTO Compose VALUES ('SAUMPAPI', 'EPICE', 1);
INSERT INTO Compose VALUES ('SAUMPAPI', 'HUILE', 10);
INSERT INTO Compose VALUES ('SAUMPAPI', 'JUSCITR', 10);
INSERT INTO Compose VALUES ('SAUMPAPI', 'SEL', 5);
INSERT INTO Compose VALUES ('SAUMPAPI', 'POIVRE', 2);
INSERT INTO Compose VALUES ('SAUMPAPI', 'SAUMON', 125);
INSERT INTO Compose VALUES ('POULCHMP', 'CHAMPI', 100);
INSERT INTO Compose VALUES ('POULCHMP', 'MOUTARDE', 10);
INSERT INTO Compose VALUES ('POULCHMP', 'HUILE', 4);
INSERT INTO Compose VALUES ('POULCHMP', 'SEL', 5);
INSERT INTO Compose VALUES ('POULCHMP', 'POIVRE', 2);
INSERT INTO Compose VALUES ('POULCHMP', 'POULET', 170);
INSERT INTO Compose VALUES ('POULCHMP', 'BOPOUL', 5);
INSERT INTO Compose VALUES ('POULCHMP', 'CRMFRCHE', 10);
INSERT INTO Compose VALUES ('POULCHMP', 'EPICE', 2);
INSERT INTO Compose VALUES ('POULCHMP', 'ECHALOTE', 10);
INSERT INTO Compose VALUES ('FILMINCR', 'PATFEUIL', 93);
INSERT INTO Compose VALUES ('FILMINCR', 'PORC', 133);
INSERT INTO Compose VALUES ('FILMINCR', 'JAMBON', 30);
INSERT INTO Compose VALUES ('FILMINCR', 'FROMRAPE', 34);
INSERT INTO Compose VALUES ('FILMINCR', 'OIGNON', 33);
INSERT INTO Compose VALUES ('FILMINCR', 'OEUF', 1);

/* Contient(idPlat, numCom, nombre) */

INSERT INTO Contient VALUES ('MOUSSAKA', 1, 3);
INSERT INTO Contient VALUES ('LASABOLO', 2, 2);
INSERT INTO Contient VALUES ('SAUMPAPI', 2, 2);
INSERT INTO Contient VALUES ('LASABOLO', 3, 8);
INSERT INTO Contient VALUES ('LASABOLO', 4, 1);
INSERT INTO Contient VALUES ('BLQTVEAU', 5, 4);
INSERT INTO Contient VALUES ('SAUMPAPI', 6, 4);
INSERT INTO Contient VALUES ('FILMINCR', 7, 4);
INSERT INTO Contient VALUES ('MOUSSAKA', 7, 4);
INSERT INTO Contient VALUES ('HACHPARM', 8, 100);
INSERT INTO Contient VALUES ('POULCHMP', 9, 1);
INSERT INTO Contient VALUES ('VEAUCHZO', 10, 2);
INSERT INTO Contient VALUES ('VEAUCHZO', 11, 1);
INSERT INTO Contient VALUES ('FILMINCR', 12, 1);
INSERT INTO Contient VALUES ('HACHPARM', 13, 1);
INSERT INTO Contient VALUES ('HACHPARM', 14, 1);
INSERT INTO Contient VALUES ('MOUSSAKA', 15, 2);
INSERT INTO Contient VALUES ('LASABOLO', 15, 2);
INSERT INTO Contient VALUES ('POULCHMP', 16, 2);
INSERT INTO Contient VALUES ('HACHPARM', 16, 1);
INSERT INTO Contient VALUES ('LASABOLO', 16, 1);
INSERT INTO Contient VALUES ('SAUMPAPI', 17, 1);
INSERT INTO Contient VALUES ('FILMINCR', 18, 1);
INSERT INTO Contient VALUES ('BRGIGNON', 18, 1);
INSERT INTO Contient VALUES ('BLQTVEAU', 19, 1);
INSERT INTO Contient VALUES ('LASABOLO', 19, 1);
INSERT INTO Contient VALUES ('VEAUCHZO', 19, 1);
INSERT INTO Contient VALUES ('FILMINCR', 19, 1);
INSERT INTO Contient VALUES ('HACHPARM', 19, 1);
INSERT INTO Contient VALUES ('MOUSSAKA', 19, 1);
INSERT INTO Contient VALUES ('BRGIGNON', 19, 1);
INSERT INTO Contient VALUES ('SAUMPAPI', 19, 1);
INSERT INTO Contient VALUES ('POULCHMP', 19, 1);

/* Restocke(numCom, idIngr, dateLivr, quantite) */

INSERT INTO Restocke VALUES (1, 'EPICE', '2016-07-01', 10000);
INSERT INTO Restocke VALUES (1, 'CRMFRCHE', '2016-08-03', 1000);
INSERT INTO Restocke VALUES (2, 'SAUMON', '2017-12-22', 1000);
INSERT INTO Restocke VALUES (3, 'TOMATE', '2018-05-17', 10000);
INSERT INTO Restocke VALUES (3, 'POULET', '2018-05-20', 1000);
INSERT INTO Restocke VALUES (3, 'OIGNON', '2018-05-20', 1000);
INSERT INTO Restocke VALUES (4, 'SEL', '2019-03-26', 10000);
INSERT INTO Restocke VALUES (4, 'PATFEUIL', '2019-03-26', 1000);
INSERT INTO Restocke VALUES (5, 'FARINE', '2020-04-20', 1000);
INSERT INTO Restocke VALUES (5, 'CHAMPI', '2020-04-23', 1000);
INSERT INTO Restocke VALUES (6, 'BEURRE', '2021-11-30', 10000);
INSERT INTO Restocke VALUES (6, 'SAUMON', '2021-10-20', 1000000);

/* Possede(idIngr, idCarac) */

INSERT INTO Possede VALUES ('CAROTTE', 'BIO');
INSERT INTO Possede VALUES ('CHAMPI', 'BIO');
INSERT INTO Possede VALUES ('OIGNON', 'BIO');
INSERT INTO Possede VALUES ('TOMATE', 'BIO');
INSERT INTO Possede VALUES ('AUBERG', 'BIO');
INSERT INTO Possede VALUES ('PATATE', 'BIO');

INSERT INTO Possede VALUES ('BOPOUL', 'VIANDE');
INSERT INTO Possede VALUES ('VEAU', 'VIANDE');
INSERT INTO Possede VALUES ('BOEUF', 'VIANDE');
INSERT INTO Possede VALUES ('CHORIZO', 'VIANDE');
INSERT INTO Possede VALUES ('LARDON', 'VIANDE');
INSERT INTO Possede VALUES ('POULET', 'VIANDE');
INSERT INTO Possede VALUES ('PORC', 'VIANDE');
INSERT INTO Possede VALUES ('JAMBON', 'VIANDE');

INSERT INTO Possede VALUES ('VINBLC', 'ALCOOL');
INSERT INTO Possede VALUES ('VINRGE', 'ALCOOL');
