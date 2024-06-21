--------suppretion de base donnees base de donnees 
drop table GagnantNBA;
drop table Classement;
drop table inscrit;
drop table joueur;
drop table match;
drop table equipe;
drop table division;
drop table conference;


--------creation base de donnees 
create table conference (
 codConf char(2),
 nomc varchar(20),
 dateanneeC varchar(9) null,
 constraint pk_conference primary key(codConf),
 constraint ck_conference_nom check (nomc in ('conference Ouest','conference Est'))
 );

create table division (
  codDiv char(3),
  nomdiv varchar(20),
  datecreation date,
  conference char(2),
  constraint pk_divisio primary key(codDiv),
  constraint fk_conference_division foreign key(conference) references conference(codConf)
);

create table equipe(
codEquipe char(5),
 nomequipe varchar(30),
 budgetEquipe int,
 nomentraineur varchar(20),
 division char(3),
 constraint pk_equipe primary key(codEquipe),
 constraint fk_division_equipe foreign key(division) references division(codDiv),
 constraint ck_equipe_budgetEquipe check(budgetEquipe >0)
);
create table match (
numref char(6),
 dateM date,
 lieu varchar(20),
 Phase varchar(20),
 scoreR int ,
 scoreD int,
 EquipeR char(5) not null,
 EquipeD char(5) not null,
 tour varchar(9) null ,
 constraint pk_match primary key(numref),
 constraint ck_match_Phase check (Phase in ('saison reguliere','saison playoffs','saison final NBA')),
 constraint fk_equipeR_Jouer foreign key(EquipeR) references Equipe(codEquipe),
 constraint fk_EquipeD_Jouer foreign key(EquipeD) references Equipe(codEquipe)
);
create table joueur(
CodJoueur char(4),
 nomJ varchar(20),
 prenomJ varchar(20),
 DateNaiss date,
 NationJ varchar(10),
 taille varchar(20),
 equipe char(5),
 NumeroJ INT,
 constraint pk_joueur primary key(CodJoueur),
 constraint fk_equipe_joueur foreign key(equipe) references equipe(codEquipe)
);
create table inscrit(
 joueur char(4),
 Match char(6),
 tempsdejeu int,
 Nbrpointmarque int,
 Nbrdereponds int,
 NbrPassDecisives int ,
 Nbrdinterception int,
 Nbrdecontres int,
 porcentage2points float ,
 porcentage3points float ,
 porcentagedereussite float ,
 constraint pk_inscrit primary key(joueur,Match),
 constraint fk_joueur_inscrit foreign key(joueur) references joueur(CodJoueur),
 constraint fk_Match_inscrit foreign key(Match) references match(numref)
);
CREATE TABLE Classement (
 id_classement char(6) ,
 conference char(2),
 equipe char(5),
 points INT,
 victoires INT,
 defaites INT,
 dateNba varchar(9),
 pointsBonus Int ,
 constraint pk_classement primary key(id_classement,conference,equipe),
 constraint fk_classement_conferences FOREIGN KEY (conference) REFERENCES Conference(codConf),
 --constraint fk_classement_Division FOREIGN KEY (id_division) REFERENCES Division(id_division),
 constraint fk_classement_equipe FOREIGN KEY (equipe) REFERENCES Equipe(codEquipe)
);
CREATE TABLE GagnantNBA
(
 id_gagnant_nba char(2),
 equipe char(5),
 dateG varchar(9),
 constraint pk_gagnatnba primary key(id_gagnant_nba),
 constraint fk_gagnat_equipe FOREIGN KEY (equipe) REFERENCES Equipe(codEquipe)
);

-- pour correcter la date :ALTER SESSION SET NLS_DATE_FORMAT = 'DD/MM/YYYY';
---- jeu de d'assie 
----conference

insert into conference(codConf ,nomc ) values('c1','conference Ouest');
insert into conference(codConf ,nomc ) values('c2','conference Est');
---deision
insert into division(codDiv ,nomdiv,datecreation,conference ) values('d01','NORD-OUEST','15/06/1987','c1');
insert into division(codDiv ,nomdiv,datecreation,conference ) values('d02','PACIFIQUE','02/08/1976','c1');
insert into division(codDiv ,nomdiv,datecreation,conference ) values('d03','SUD-OUEST','19/08/1986','c1');
insert into division(codDiv ,nomdiv,datecreation,conference ) values('d04','ATLANTIQUE','19/08/1986','c2');
insert into division(codDiv ,nomdiv,datecreation,conference ) values('d05','SUD-EST','19/08/1989','c2');
insert into division(codDiv ,nomdiv,datecreation,conference ) values('d06','CENTRALE','19/08/1990','c2');
----equipe
insert into equipe(codEquipe ,nomequipe,budgetEquipe,nomentraineur,division ) values('EQ001','Nuggets de Denver',200000,'Malone','d01');
insert into equipe(codEquipe ,nomequipe,budgetEquipe,nomentraineur,division ) values('EQ002','Timberwolves du Minnesota',300000,'Steve Kerr','d01');
insert into equipe(codEquipe ,nomequipe,budgetEquipe,nomentraineur,division ) values('EQ003','Warriors de Golden State',300000,'Steve Kerr','d02');
insert into equipe(codEquipe ,nomequipe,budgetEquipe,nomentraineur,division ) values('EQ004','Clippers de Los Angeles',300000,'Steve Kerr','d02');
insert into equipe(codEquipe ,nomequipe,budgetEquipe,nomentraineur,division ) values('EQ005','Mavericks de Dallas',10000,'Jason Kidd','d03');
insert into equipe(codEquipe ,nomequipe,budgetEquipe,nomentraineur,division ) values('EQ006','Rockets de Houston',10000,'Jason Kidd','d03');
insert into equipe(codEquipe ,nomequipe,budgetEquipe,nomentraineur,division ) values('EQ007','Celtics de Boston',60000,'Joe Mazzulla','d04');
insert into equipe(codEquipe ,nomequipe,budgetEquipe,nomentraineur,division ) values('EQ008','Nets de Brooklyn',60000,'Joe Mazzulla','d04');
insert into equipe(codEquipe ,nomequipe,budgetEquipe,nomentraineur,division ) values('EQ009','Bulls de Chicago',90000,'Billy Donovan','d05');
insert into equipe(codEquipe ,nomequipe,budgetEquipe,nomentraineur,division ) values('EQ010','Cavaliers de Cleveland',90000,'Billy Donovan','d05');
insert into equipe(codEquipe ,nomequipe,budgetEquipe,nomentraineur,division ) values('EQ011','Hawks d''Atlanta',10000000,'Quin Snyder','d06');
insert into equipe(codEquipe ,nomequipe,budgetEquipe,nomentraineur,division ) values('EQ012','Hornets de Charlotte',10000000,'Taylor Jenkins','d06');
insert into equipe(codEquipe ,nomequipe,budgetEquipe,nomentraineur,division ) values('EQ013','Grizzlies de Memphis',2000000,'Taylor Jenkins','d03');
insert into equipe(codEquipe ,nomequipe,budgetEquipe,nomentraineur,division ) values('EQ014','Trail Blazers de Portland',300000,'Chauncey Billups','d01');
insert into equipe(codEquipe ,nomequipe,budgetEquipe,nomentraineur,division ) values('EQ015','Jazz de l''Utah',4560000,'Will Hardy','d01');

-----Match
-- Matchs de la saison reguliere de la division NORD-OUEST
-- Matchs de la saison reguliere de la division NORD-OUEST
INSERT INTO match(numref, dateM, lieu, Phase, scoreR, scoreD, EquipeR, EquipeD) VALUES ('SR_001', '02/01/2022', 'Denver', 'saison reguliere', 120, 115, 'EQ001', 'EQ002');
INSERT INTO match(numref, dateM, lieu, Phase, scoreR, scoreD, EquipeR, EquipeD) VALUES ('SR_002', '04/01/2022', 'Minneapolis', 'saison reguliere', 100, 98, 'EQ002', 'EQ001');
INSERT INTO match(numref, dateM, lieu, Phase, scoreR, scoreD, EquipeR, EquipeD) VALUES ('SR_003', '08/01/2022', 'Portland', 'saison reguliere', 110, 105, 'EQ001', 'EQ003');
INSERT INTO match(numref, dateM, lieu, Phase, scoreR, scoreD, EquipeR, EquipeD) VALUES ('SR_004', '10/01/2022', 'Oakland', 'saison reguliere', 115, 120, 'EQ003', 'EQ001');
INSERT INTO match(numref, dateM, lieu, Phase, scoreR, scoreD, EquipeR, EquipeD) VALUES ('SR_005', '14/01/2022', 'Minneapolis', 'saison reguliere', 105, 90, 'EQ002', 'EQ003');
INSERT INTO match(numref, dateM, lieu, Phase, scoreR, scoreD, EquipeR, EquipeD) VALUES ('SR_006', '18/01/2022', 'Denver', 'saison reguliere', 120, 112, 'EQ001', 'EQ002');
INSERT INTO match(numref, dateM, lieu, Phase, scoreR, scoreD, EquipeR, EquipeD) VALUES ('SR_007', '22/01/2022', 'Oakland', 'saison reguliere', 98, 100, 'EQ003', 'EQ001');
INSERT INTO match(numref, dateM, lieu, Phase, scoreR, scoreD, EquipeR, EquipeD) VALUES ('SR_008', '01/05/2022', 'Los Angeles', 'saison reguliere', 110, 98, 'EQ005', 'EQ006');
INSERT INTO match(numref, dateM, lieu, Phase, scoreR, scoreD, EquipeR, EquipeD) VALUES ('SR_009', '04/05/2022', 'Phoenix', 'saison reguliere', 95, 99, 'EQ006', 'EQ005');
INSERT INTO match(numref, dateM, lieu, Phase, scoreR, scoreD, EquipeR, EquipeD) VALUES ('SR_041', '09/05/2022', 'Oakland', 'saison reguliere', 94, 100, 'EQ013', 'EQ005');
INSERT INTO match(numref, dateM, lieu, Phase, scoreR, scoreD, EquipeR, EquipeD) VALUES ('SR_322', '19/05/2022', 'Phoenix', 'saison reguliere', 100, 102, 'EQ006', 'EQ013');
INSERT INTO match(numref, dateM, lieu, Phase, scoreR, scoreD, EquipeR, EquipeD) VALUES ('SR_043', '20/05/2022', 'Oakland', 'saison reguliere', 109, 88, 'EQ013', 'EQ006');
INSERT INTO match(numref, dateM, lieu, Phase, scoreR, scoreD, EquipeR, EquipeD) VALUES ('SR_044', '29/05/2022', 'Phoenix', 'saison reguliere', 100, 101, 'EQ005', 'EQ013');
INSERT INTO match(numref, dateM, lieu, Phase, scoreR, scoreD, EquipeR, EquipeD) VALUES ('SR_010', '07/05/2022', 'San Francisco', 'saison reguliere', 112, 108, 'EQ008', 'EQ007');
INSERT INTO match(numref, dateM, lieu, Phase, scoreR, scoreD, EquipeR, EquipeD) VALUES ('SR_211', '10/08/2022', 'Oakland', 'saison reguliere', 50,61, 'EQ007', 'EQ008');
INSERT INTO match(numref, dateM, lieu, Phase, scoreR, scoreD, EquipeR, EquipeD) VALUES ('SR_212', '16/08/2022', 'Ball Arena', 'saison reguliere', 68,61, 'EQ003', 'EQ004');
INSERT INTO match(numref, dateM, lieu, Phase, scoreR, scoreD, EquipeR, EquipeD) VALUES ('SR_213', '01/09/2022', 'Minneapolis', 'saison reguliere', 100,65, 'EQ004', 'EQ003');
INSERT INTO match(numref, dateM, lieu, Phase, scoreR, scoreD, EquipeR, EquipeD) VALUES ('SR_214', '05/09/2022', 'Denver', 'saison reguliere', 80,66, 'EQ010', 'EQ009');
INSERT INTO match(numref, dateM, lieu, Phase, scoreR, scoreD, EquipeR, EquipeD) VALUES ('SR_215', '12/10/2022', 'Portland', 'saison reguliere', 80,90, 'EQ009', 'EQ010');
INSERT INTO match(numref, dateM, lieu, Phase, scoreR, scoreD, EquipeR, EquipeD) VALUES ('SR_216', '18/10/2022', 'Phoenix', 'saison reguliere', 95,105, 'EQ005', 'EQ008');
INSERT INTO match(numref, dateM, lieu, Phase, scoreR, scoreD, EquipeR, EquipeD) VALUES ('SR_217', '15/11/2022', 'Minneapolis', 'saison reguliere', 119,61, 'EQ011', 'EQ012');
INSERT INTO match(numref, dateM, lieu, Phase, scoreR, scoreD, EquipeR, EquipeD) VALUES ('SR_218', '05/12/2022', 'Los Angeles', 'saison reguliere', 89,105, 'EQ012', 'EQ011');
-- Matchs de la saison playoffs 
INSERT INTO match(numref, dateM, lieu, Phase, scoreR, scoreD, EquipeR, EquipeD,tour) VALUES ('SR_300', '20/12/2022', 'Los Angeles', 'saison playoffs', 89,105, 'EQ002', 'EQ003','16eme');
INSERT INTO match(numref, dateM, lieu, Phase, scoreR, scoreD, EquipeR, EquipeD,tour) VALUES ('SR_301', '21/12/2022', 'Los Angeles', 'saison playoffs', 120,105, 'EQ001', 'EQ005','16eme');
-- Matchs de la saison playoffs 
INSERT INTO match(numref, dateM, lieu, Phase, scoreR, scoreD, EquipeR, EquipeD,tour) VALUES ('SR_400', '31/12/2022', 'Los Angeles', 'saison playoffs', 118,120, 'EQ003', 'EQ001','8eme');
-- Matchs de la saison playoffs 
INSERT INTO match(numref, dateM, lieu, Phase, scoreR, scoreD, EquipeR, EquipeD,tour) VALUES ('SR_401', '01/01/2023', 'Los Angeles', 'saison playoffs', 119,120, 'EQ001', 'EQ013','1/2');
INSERT INTO match(numref, dateM, lieu, Phase, scoreR, scoreD, EquipeR, EquipeD,tour) VALUES ('SR_405', '04/01/2023', 'Los Angeles', 'saison playoffs', 120,116, 'EQ011', 'EQ010','1/2');

--Matchs de la saison saison final NBA
INSERT INTO match(numref, dateM, lieu, Phase, scoreR, scoreD, EquipeR, EquipeD) VALUES ('SR_402', '16/01/2023', 'Los Angeles', 'saison final NBA', 120,123, 'EQ011', 'EQ013');

-- joueur
INSERT INTO joueur (CodJoueur, nomJ, prenomJ, DateNaiss, NationJ, taille, equipe,NumeroJ) VALUES ('J001', 'Jordan', 'Michael', '17/02/1963', 'USA', '1m98', 'EQ001',12);
INSERT INTO joueur (CodJoueur, nomJ, prenomJ, DateNaiss, NationJ, taille, equipe,NumeroJ) VALUES ('J002', 'Bryant', 'Kobe', '23/08/1978', 'USA', '1m98', 'EQ001',03);
INSERT INTO joueur (CodJoueur, nomJ, prenomJ, DateNaiss, NationJ, taille, equipe,NumeroJ) VALUES ('J003', 'James', 'LeBron', '30/12/1984', 'USA', '2m06', 'EQ001',06);
INSERT INTO joueur (CodJoueur, nomJ, prenomJ, DateNaiss, NationJ, taille, equipe,NumeroJ) VALUES ('J004', 'Curry', 'Stephen', '14/03/1988', 'USA', '1m91', 'EQ002',19);
INSERT INTO joueur (CodJoueur, nomJ, prenomJ, DateNaiss, NationJ, taille, equipe,NumeroJ) VALUES ('J005', 'Durant', 'Kevin', '29/09/1988', 'USA', '2m08', 'EQ002',18);
INSERT INTO joueur (CodJoueur, nomJ, prenomJ, DateNaiss, NationJ, taille, equipe,NumeroJ) VALUES ('J006', 'Green', 'Draymond', '04/03/1990', 'USA', '2m01', 'EQ002',16);
INSERT INTO joueur (CodJoueur, nomJ, prenomJ, DateNaiss, NationJ, taille, equipe,NumeroJ) VALUES ('J007', 'Jordan', 'Michael', '17/02/1963', 'USA', '1m98', 'EQ003',30);
INSERT INTO joueur (CodJoueur, nomJ, prenomJ, DateNaiss, NationJ, taille, equipe,NumeroJ) VALUES ('J008', 'Bryant', 'Kobe', '23/08/1978', 'USA', '1m98', 'EQ003',01);
INSERT INTO joueur (CodJoueur, nomJ, prenomJ, DateNaiss, NationJ, taille, equipe,NumeroJ) VALUES ('J009', 'James', 'LeBron', '30/12/1984', 'USA', '2m06', 'EQ003',06);
INSERT INTO joueur (CodJoueur, nomJ, prenomJ, DateNaiss, NationJ, taille, equipe,NumeroJ) VALUES ('J010', 'Curry', 'Stephen', '14/03/1988', 'USA', '1m91', 'EQ004',09);
INSERT INTO joueur (CodJoueur, nomJ, prenomJ, DateNaiss, NationJ, taille, equipe,NumeroJ) VALUES ('J011', 'Durant', 'Kevin', '29/09/1988', 'USA', '2m08', 'EQ004',18);
INSERT INTO joueur (CodJoueur, nomJ, prenomJ, DateNaiss, NationJ, taille, equipe,NumeroJ) VALUES ('J012', 'Kyrie', 'Irving', '23/03/1992', 'USA', '1m88', 'EQ005',12);
INSERT INTO joueur (CodJoueur, nomJ, prenomJ, DateNaiss, NationJ, taille, equipe,NumeroJ) VALUES ('J013', 'Kawhi', 'Leonard', '29/06/1991', 'USA', '2m01', 'EQ005',03);
INSERT INTO joueur (CodJoueur, nomJ, prenomJ, DateNaiss, NationJ, taille, equipe,NumeroJ) VALUES ('J014', 'Klay', 'Thompson', '08/02/1990', 'USA', '1m98', 'EQ005',09);
INSERT INTO joueur (CodJoueur, nomJ, prenomJ, DateNaiss, NationJ, taille, equipe,NumeroJ) VALUES ('J015', 'Ogugua', 'Anunoby', '17/07/1997', 'Angleterre', '2m19', 'EQ006',16);
INSERT INTO joueur (CodJoueur, nomJ, prenomJ, DateNaiss, NationJ, taille, equipe,NumeroJ) VALUES ('J016', 'James', 'Harden', '26/08/1989', 'USA', '1m96', 'EQ006',09);
INSERT INTO joueur (CodJoueur, nomJ, prenomJ, DateNaiss, NationJ, taille, equipe,NumeroJ) VALUES ('J017', 'Eric', 'Gordon', '25/12/1988', 'FR', '1m91', 'EQ006',07);1
INSERT INTO joueur (CodJoueur, nomJ, prenomJ, DateNaiss, NationJ, taille, equipe,NumeroJ) VALUES ('J018', 'Jayson', 'Christopher', '03/03/1998', 'Fr', '2m03', 'EQ006',06);
INSERT INTO joueur (CodJoueur, nomJ, prenomJ, DateNaiss, NationJ, taille, equipe,NumeroJ) VALUES ('J019', 'Jaylen', 'Marselles', '24/10/1996', 'USA', '1m98', 'EQ007',04);
INSERT INTO joueur (CodJoueur, nomJ, prenomJ, DateNaiss, NationJ, taille, equipe,NumeroJ) VALUES ('J020', 'Mikal', 'Bridges', '30/08/1990', 'USA', '1m98', 'EQ008',03);
INSERT INTO joueur (CodJoueur, nomJ, prenomJ, DateNaiss, NationJ, taille, equipe,NumeroJ) VALUES ('J021', 'Cameron', 'Bouchea', '13/10/2001', 'FR', '1m90', 'EQ008',07);
INSERT INTO joueur (CodJoueur, nomJ, prenomJ, DateNaiss, NationJ, taille, equipe,NumeroJ) VALUES ('J022', 'Zachary', 'Thomas', '10/03/1995', 'USA', '1m96', 'EQ009',08);
INSERT INTO joueur (CodJoueur, nomJ, prenomJ, DateNaiss, NationJ, taille, equipe,NumeroJ) VALUES ('J023', 'DeMar', 'DeRozan', '07/08/1989', 'USA', '1m98', 'EQ013',05);
INSERT INTO joueur (CodJoueur, nomJ, prenomJ, DateNaiss, NationJ, taille, equipe,NumeroJ) VALUES ('J024', 'Kevin', 'Love', '04/03/1988', 'USA', '2m03', 'EQ013',37);
INSERT INTO joueur (CodJoueur, nomJ, prenomJ, DateNaiss, NationJ, taille, equipe,NumeroJ) VALUES ('J025', 'LeBron', 'Raymone', '30/12/1984', 'USA', '1m98', 'EQ013',07);
INSERT INTO joueur (CodJoueur, nomJ, prenomJ, DateNaiss, NationJ, taille, equipe,NumeroJ) VALUES ('J026', 'Rayford', 'Young', '19/09/1998', 'USA', '1m85', 'EQ011',06);
INSERT INTO joueur (CodJoueur, nomJ, prenomJ, DateNaiss, NationJ, taille, equipe,NumeroJ) VALUES ('J027', 'Dejounte', 'Murray', '19/12/1996', 'USA', '1m96', 'EQ011',03);
INSERT INTO joueur (CodJoueur, nomJ, prenomJ, DateNaiss, NationJ, taille, equipe,NumeroJ) VALUES ('J028', 'LaMelo', 'LaFrance', '30/12/1984', 'USA', '2m01', 'EQ012',04);
INSERT INTO joueur (CodJoueur, nomJ, prenomJ, DateNaiss, NationJ, taille, equipe,NumeroJ) VALUES ('J029', 'Terry', 'Terry', '17/03/1997', 'USA', '1m85', 'EQ012',01);
INSERT INTO joueur (CodJoueur, nomJ, prenomJ, DateNaiss, NationJ, taille, equipe,NumeroJ) VALUES ('J030', 'Temetrius', 'Jamel', '10/08/1990', 'USA', '1m88', 'EQ013',03);
INSERT INTO joueur (CodJoueur, nomJ, prenomJ, DateNaiss, NationJ, taille, equipe,NumeroJ) VALUES ('J031', 'Dillon', 'Brooks', '22/01/1996', 'canada', '1m98', 'EQ013',09);

---statistique
--SR_041
INSERT INTO inscrit (joueur, Match, tempsdejeu, Nbrpointmarque, Nbrdereponds, Nbrdinterception, Nbrdecontres, porcentage2points, porcentage3points, porcentagedereussite) VALUES ('J023', 'SR_041', 30, 10, 5, 2, 1, 66.7, 50, 70);
INSERT INTO inscrit (joueur, Match, tempsdejeu, Nbrpointmarque, Nbrdereponds, Nbrdinterception, Nbrdecontres, porcentage2points, porcentage3points, porcentagedereussite) VALUES ('J024', 'SR_041', 20, 5, 2, 1, 0, 50, 0, 50);
INSERT INTO inscrit (joueur, Match, tempsdejeu, Nbrpointmarque, Nbrdereponds, Nbrdinterception, Nbrdecontres, porcentage2points, porcentage3points, porcentagedereussite) VALUES ('J025', 'SR_041', 25, 8, 3, 0, 2, 75, 33.3, 60);

--SR_043    
INSERT INTO inscrit (joueur, Match, tempsdejeu, Nbrpointmarque, Nbrdereponds, Nbrdinterception, Nbrdecontres, porcentage2points, porcentage3points, porcentagedereussite) VALUES ('J023', 'SR_043', 35, 15, 8, 3, 1, 50, 45.9, 70);
INSERT INTO inscrit (joueur, Match, tempsdejeu, Nbrpointmarque, Nbrdereponds, Nbrdinterception, Nbrdecontres, porcentage2points, porcentage3points, porcentagedereussite) VALUES ('J024', 'SR_043', 20, 10, 6, 2, 0, 40, 20, 60);
INSERT INTO inscrit (joueur, Match, tempsdejeu, Nbrpointmarque, Nbrdereponds, Nbrdinterception, Nbrdecontres, porcentage2points, porcentage3points, porcentagedereussite) VALUES ('J025', 'SR_043', 30, 5, 4, 1, 1, 50, 0, 44.4);

--SR_044    
INSERT INTO inscrit (joueur, Match, tempsdejeu, Nbrpointmarque, Nbrdereponds, Nbrdinterception, Nbrdecontres, porcentage2points, porcentage3points, porcentagedereussite) VALUES ('J023', 'SR_044', 35, 8, 6, 2, 1, 57.1, 25.0, 66.7);
INSERT INTO inscrit (joueur, Match, tempsdejeu, Nbrpointmarque, Nbrdereponds, Nbrdinterception, Nbrdecontres, porcentage2points, porcentage3points, porcentagedereussite) VALUES ('J024', 'SR_044', 28, 6, 4, 3, 0, 50.0, 33.3, 60.0);
INSERT INTO inscrit (joueur, Match, tempsdejeu, Nbrpointmarque, Nbrdereponds, Nbrdinterception, Nbrdecontres, porcentage2points, porcentage3points, porcentagedereussite) VALUES ('J025', 'SR_044', 25, 4, 3, 1, 2, 66.7, 0.0, 57.1);

--SR_322    
INSERT INTO inscrit (joueur, Match, tempsdejeu, Nbrpointmarque, Nbrdereponds, Nbrdinterception, Nbrdecontres, porcentage2points, porcentage3points, porcentagedereussite) VALUES ('J023', 'SR_322', 25, 10, 5, 2, 1, 50.0, 33.3, 71.4);
INSERT INTO inscrit (joueur, Match, tempsdejeu, Nbrpointmarque, Nbrdereponds, Nbrdinterception, Nbrdecontres, porcentage2points, porcentage3points, porcentagedereussite) VALUES ('J024', 'SR_322', 20, 8, 2, 1, 0, 60.0, 50.0, 100.0);
INSERT INTO inscrit (joueur, Match, tempsdejeu, Nbrpointmarque, Nbrdereponds, Nbrdinterception, Nbrdecontres, porcentage2points, porcentage3points, porcentagedereussite) VALUES ('J025', 'SR_322', 15, 5, 3, 0, 2, 50.0, 0.0, 57.1);
INSERT INTO inscrit (joueur, Match, tempsdejeu, Nbrpointmarque, Nbrdereponds, Nbrdinterception, Nbrdecontres, porcentage2points, porcentage3points, porcentagedereussite) VALUES ('J016', 'SR_322', 22, 12, 4, 1, 2, 66.7, 25.0, 85.7);
INSERT INTO inscrit (joueur, Match, tempsdejeu, Nbrpointmarque, Nbrdereponds, Nbrdinterception, Nbrdecontres, porcentage2points, porcentage3points, porcentagedereussite) VALUES ('J017', 'SR_322', 18, 6, 3, 2, 0, 50.0, 0.0, 60.0);
INSERT INTO inscrit (joueur, Match, tempsdejeu, Nbrpointmarque, Nbrdereponds, Nbrdinterception, Nbrdecontres, porcentage2points, porcentage3points, porcentagedereussite) VALUES ('J018', 'SR_322', 20, 8, 9, 2, 0, 39.9, 10.3, 30.9);

---classement
insert into Classement( id_classement, conference, equipe, points, pointsBonus, victoires, defaites , dateNba) values ('CL_001','c1','EQ001',0,0,05,01,'2022-2023');
insert into Classement( id_classement, conference, equipe, points, pointsBonus, victoires, defaites , dateNba) values ('CL_002','c1','EQ002',0,0,02,02,'2022-2023');
insert into Classement( id_classement, conference, equipe, points, pointsBonus, victoires, defaites , dateNba) values ('CL_003','c1','EQ003',0,0,01,05,'2022-2023');
insert into Classement( id_classement, conference, equipe, points, pointsBonus, victoires, defaites , dateNba) values ('CL_004','c1','EQ004',0,0,01,01,'2022-2023');
insert into Classement( id_classement, conference, equipe, points, pointsBonus, victoires, defaites , dateNba) values ('CL_005','c1','EQ005',0,0,02,01,'2022-2023');
insert into Classement( id_classement, conference, equipe, points, pointsBonus, victoires, defaites , dateNba) values ('CL_006','c1','EQ006',0,0,0,01,'2022-2023');
insert into Classement( id_classement, conference, equipe, points, pointsBonus, victoires, defaites , dateNba) values ('CL_007','c1','EQ013',0,0,3,01,'2022-2023');
insert into Classement( id_classement, conference, equipe, points, pointsBonus, victoires, defaites , dateNba) values ('CL_008','c1','EQ014',0,0,1,02,'2022-2023');
insert into Classement( id_classement, conference, equipe, points, pointsBonus, victoires, defaites , dateNba) values ('CL_009','c1','EQ015',0,0,1,01,'2022-2023');

update Classement set points=(victoires*2)+defaites+pointsBonus;

---affichage
set linesize 200;
set pagesize 1000;



---Feuille de match du match ayant pour numero SR_322 :
SELECT e.nomequipe, j.NumeroJ, j.nomj, i.tempsdejeu, i.nbrpointmarque
FROM equipe e, joueur j, inscrit i, match m
WHERE m.numref = 'SR_322' 
AND m.numref = i.Match 
AND j.codjoueur = i.joueur 
and e.codEquipe=j.equipe
ORDER BY e.nomequipe,j.NumeroJ;
---Nom, division et conference des equipes qui n'ont pas gagne de match e l'exterieur :
SELECT e.nomequipe, d.nomdiv, c.nomc,codEquipe
FROM equipe e, division d, conference c
WHERE e.division = d.coddiv 
	AND d.conference = c.codconf
	And e.codequipe  IN (SELECT DISTINCT EquipeD FROM match WHERE scoreR > scoreD);
---Liste des equipes composant la conference Ouest :
SELECT nomequipe 
FROM equipe e ,division d 
where conference = 'c1' 
	and e.division= d.codDiv ;

SELECT nomequipe 
FROM equipe 
WHERE division IN (SELECT coddiv FROM division WHERE conference = 'c1');

---Pour chaque joueur des Grizzlies de Memphis, le nombre de matchs joues, le nombre total de points marques, le nombre moyen de rebonds, le nombre moyen d'interceptions et le nombre moyen de contres durant les matchs de la saison reguliere :
SELECT i.joueur, j.nomJ, j.prenomJ, COUNT(DISTINCT i.match) as "nb de match", 
SUM(i.nbrpointmarque) as "total de points marques", 
AVG(i.Nbrdereponds) as " moy rebonds", 
AVG(i.nbrdinterception) as "moy d'interceptions", 
AVG(i.nbrdecontres) as "moy. de contres"
FROM joueur j, equipe e, match m, inscrit i
WHERE j.equipe = e.codequipe 
	AND e.nomequipe = 'Grizzlies de Memphis' 
	AND m.Phase = 'saison reguliere' 
	AND  m.numref = i.Match 
	and i.joueur=j.CodJoueur
GROUP BY (i.joueur , j.nomJ,j.prenomJ);

----Liste des matchs qui ont eu lieu entre le 20/12/22 et le 31/12/22 :
SELECT m.datem, m.lieu, eq1.nomequipe, m.scoreR, eq2.nomequipe, m.scoreD
FROM match m, equipe eq1, equipe eq2
WHERE m.equipeD = eq1.codequipe 
AND m.equiper = eq2.codEquipe 
and m.datem BETWEEN '20/12/2022' AND '31/12/2022'  ;

--- les gagnants  des playoffs des tours de l'annee 2022-2023
SELECT tour,
    CASE 
        WHEN scoreR > scoreD THEN EquipeR 
        ELSE EquipeD 
    END AS "Gagnante"
FROM match 
WHERE  datem BETWEEN '01/12/2022' AND '01/02/2023'
	and Phase='saison playoffs';
----  trouver les 8 premieres equipe du conference Ouest de l'annee 2022-2023
select *
from  
( SELECT *
FROM classement
WHERE dateNba = '2022-2023'
ORDER BY points DESC) 
where ROWNUM <= 8;
--- le gagant de chaque conference de playoffs de l'annee 2022-2023
SELECT  nomc,
    CASE 
        WHEN scoreR > scoreD THEN EquipeR 
        ELSE EquipeD 
    END AS "Gagnante"
FROM match m,equipe e ,division d ,conference c
WHERE  datem BETWEEN '01/12/2022' AND '02/02/2023'
	and Phase='saison playoffs'
	and tour='1/2'
	and e.codEquipe=(CASE WHEN m.scoreR > m.scoreD THEN m.EquipeR ELSE m.EquipeD END)
	and d.codDiv=e.division
	and d.conference=c.codConf;
--Donner le nom d'equipe ayant le plus gros budget.
select nomequipe
from equipe 
where budgetEquipe =(select max(budgetEquipe)
from equipe);
-- Donner le nom et le prenom des joueurs qui ont joués dans le plus de match
select j.nomJ, j.prenomJ 
from joueur j, inscrit i
where j.CodJoueur = i.joueur
group by nomJ, prenomJ, joueur
having count(i.joueur) = ( select max(count (i.joueur))
                        from inscrit i 
                        group by  i.joueur
                        );

--pour inserer la derniere annee ou une equipe a gagnant Nba
update conference set dateanneeC='2022-2023' where codConf='c1';
update conference set dateanneeC='2019-2020' where codConf='c2';
--pour afficher la derniere annee ou une equipe a gagnant Nba pour chaque conference 
select nomc,dateanneeC
from conference;
----pour inserer dans la table gangant nba a partir de donnees de table match
 insert into GagnantNBA(id_gagnant_nba,dateG,equipe) 
 SELECT 'G1','2022-2023',
     CASE
        WHEN scoreR > scoreD THEN EquipeR
        ELSE EquipeD
    END as Gagnat
FROM match m
WHERE  datem BETWEEN '01/12/2022' AND '01/03/2023'
	and Phase='saison final NBA';

--afficher l'equipe gagnant de NBA de l'annee 2022-2023
select nomequipe
from GagnantNBA g , equipe e
where g.equipe=e.codEquipe
    and dateG='2022-2023';
---donner les noms des equipes qui ont que des joueurs amiricaine


select distinct nomequipe
from equipe
where codequipe not in (select distinct equipe
                from joueur
                minus
                select  distinct equipe
                from joueur
                where NationJ !='USA');