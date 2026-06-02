
-- Lucy Carli, Bryce Almond, Carolyn Xie

-- Creation of Database
CREATE DATABASE Wildfire_db;

USE Wildfire_db;

-- Wildfire Table

DROP TABLE IF EXISTS Wildfire;
CREATE TABLE Wildfire(
    WildfireID INT IDENTITY(1,1) PRIMARY KEY,
    Severity VARCHAR(1) NOT NULL,
    Acres DECIMAL(5,2) NOT NULL,
    Fire_Category VARCHAR(4) NOT NULL,
    Fire_Name VARCHAR(100) NOT NULL
);

-- Data Insert for Wildfire

INSERT INTO Wildfire(Severity,Acres,Fire_Category,Fire_Name)
VALUES 
('B',3.2,'STAT','Bass 497'),
('A',0.0,'STAT','Hay Fire'),
('B',0.75,'STAT','Slick Ear #2'),
('C',80,'STAT','Woodley'),
('A',0.1,'STAT','QUEENS BRANCH'),
('A',0.01,'STAT','Chilcoot'),
('A',0.01,'STAT','WREN'),
('A',0.01,'STAT','Ritner Creek'),
('A',0.01,'STAT','Big Tamarack'),
('A',0,'STAT','COIDC 918'),
('A',0.01,'STAT','RAYMOND ROAD'),
('A',0.01,'STAT','BLISS'),
('B',3,'STAT','North Canine'),
('A',0.01,'STAT','CAZADERO TRAIL 6'),
('A',0.1,'STAT','LONG CREEK'),
('A',0.01,'STAT','7498 Upper Applegate'),
('B',1.5,'STAT','Mehl Cr.'),
('A',0.01,'STAT','Corkey'),
('A',0.1,'STAT','I-5 MP 75'),
('A',0.25,'STAT','Boomer Hill'),
('A',0.01,'STAT','Kelly Creek'),
('A',0.1,'STAT','Pengra Car Fire'),
('A',0.01,'STAT','GP 632'),
('A',0.01,'STAT','Smith Road #1'),
('A',0.14,'STAT','FIRE WINNEY'),
('A',0.1,'STAT','Doubleday'),
('A',0.05,'STAT','Vandervert'),
('A',0.25,'STAT','CB7 AGAIN'),
('B',5,'STAT','Ritter'),
('A',0.13,'STAT','Mile Post 6 Fire');

-- Check
SELECT * FROM Wildfire

--Damage Table

DROP TABLE IF EXISTS Damage;
CREATE TABLE Damage(
    DamageID INT IDENTITY(100,1) PRIMARY KEY,
    WildfireID INT NOT NULL,
    -- add duration to this
    Property_Cost MONEY NOT NULL,
    Industrial_Restriction VARCHAR(100) NOT NULL
);

--Data Insert for Damage

INSERT INTO Damage(WildfireID,Property_Cost,Industrial_Restriction) 
VALUES 
(1,'$12,500.00','Does Not Apply - Eastern OR'),
(2,'$48,300.00',''),
(3,'$91,000.00','Does Not Apply - Eastern OR'),
(4,'$230,000.00','Does Not Apply - Eastern OR'),
(5,'$15,750.00','Lvl 3 Restricted Shutdown'),
(6,'$67,200.00','Lvl 3 Restricted Shutdown'),
(7,'$310,000.00','Lvl 1 Fire Season Only'),
(8,'$5,800.00','Lvl 3 Restricted Shutdown'),
(9,'$125,000.00','Does Not Apply - Eastern OR'),
(10,'$42,600.00','Does Not Apply - Eastern OR'),
(11,'$89,900.00','Lvl 1 Fire Season Only'),
(12,'$275,000.00','Does Not Apply - Eastern OR'),
(13,'$33,300.00','Lvl 1 Fire Season Only'),
(14,'$8,400.00','Lvl 2 Limited Shutdown'),
(15,'$510,000.00','Does Not Apply - Eastern OR'),
(16,'$420,000.00','Outside Closed Fire Season'),
(17,'$16,800.00','Lvl 3 Restricted Shutdown'),
(18,'$13,600.00','Lvl 1 Fire Season Only'),
(19,'$7,200.00','Lvl 3 Restricted Shutdown'),
(20,'$19,500.00','Lvl 3 Restricted Shutdown'),
(21,'$31,800.00','Lvl 1 Fire Season Only'),
(22,'$15,750.00','Lvl 2 Limited Shutdown'),
(23,'$42,600.00','Lvl 1 Fire Season Only'),
(24,'$190,000.00','Lvl 1 Fire Season Only'),
(25,'$6,900.00','Outside Closed Fire Season'),
(26,'$9,750.00','Lvl 1 Fire Season Only'),
(27,'$72,500.00','Does Not Apply - Eastern OR'),
(28,'$105,000.00','Does Not Apply - Eastern OR'),
(29,'$27,400.00','Outside Closed Fire Season'),
(30,'$310,500.00','Lvl 1 Fire Season Only');

--Check

SELECT * FROM Damage

--Location Table

DROP TABLE IF EXISTS [Location];
CREATE TABLE Location (
   LocationID INT IDENTITY(200,1) PRIMARY KEY,
   Latitude DECIMAL(8,5) NOT NULL,
   Longitude DECIMAL(8,5) NOT NULL,
   County VARCHAR(100) NOT NULL,
   District_Name VARCHAR(100) NOT NULL
);

-- Data insert for Location

INSERT INTO [Location](Latitude,Longitude,County,District_Name) 
VALUES 
(42.13361,-122.04083,'Klamath','Klamath-Lake'),
(43.59358,-121.49422,'Klamath','Walker Range - WRFPA'),
(44.91519,-119.28863,'Grant','Central Oregon'),
(45.08509,-118.3344,'Union','Northeast Oregon'),
(42.53671,-123.21215,'Jackson','Southwest Oregon'),
(743.45583,-122.74889,'Douglas','Douglas - DFPA'),
(44.58709,-123.42779,'Benton','West Oregon'),
(44.74026,-123.49811,'Polk','West Oregon'),
(45.63942,-117.40483,'Wallowa','Northeast Oregon'),
(43.52418,-121.95545,'Klamath','Walker Range - WRFPA'),
(46.0765,-123.70566,'Clatsop','Astoria'),
(42.3795,-121.53266,'Klamath','Klamath-Lake'),
(46.07361,-123.68083,'Clatsop','Astoria'),
(45.38833,-122.40583,'Clackamas','North Cascade'),
(42.80436,-121.20103,'Klamath','Klamath-Lake'),
(42.14361,-123.07278,'Jackson','Southwest Oregon'),
(43.56694,-123.58361,'Douglas','Douglas - DFPA'),
(45.68,-117.715,'Wallowa','Northeast Oregon'),
(42.68111,-123.385,'Josephine','Southwest Oregon'),
(42.97972,-123.41917,'Douglas','Douglas - DFPA'),
(43.40556,-123.0025,'Douglas','Douglas - DFPA'),
(43.92972,-122.80972,'Lane','South Cascade'),
(44.47194,-122.61111,'Linn','South Cascade'),
(45.89111,-122.84972,'Columbia','Forest Grove'),
(44.37694,-123.65806,'Benton','West Oregon'),
(42.48556,-122.55167,'Jackson','Southwest Oregon'),
(43.83972,-121.43278,'Deschutes','Central Oregon'),
(43.47417,-121.62028,'Klamath','Walker Range - WRFPA'),
(44.71278,-122.26806,'Linn','North Cascade'),
(45.91778,-123.82444,'Clatsop','Astoria');

--Check

SELECT * FROM [Location]

-- LocationType Table 

DROP TABLE IF EXISTS LocationType;
CREATE TABLE LocationType (
   Loc_TypeID INT IDENTITY(300,1) PRIMARY KEY,
   LocationID INT NOT NULL,
   WildfireID INT NOT NULL,
   TypeName VARCHAR(100) NOT NULL,
   Loc_Description VARCHAR(50) NOT NULL,
   OwnerShip_ VARCHAR(3) NOT NULL,
   RiskLevel VARCHAR(10) NOT NULL,
);

-- Data Insert for LocationType

INSERT INTO LocationType(LocationID,WildfireID,TypeName,Loc_Description,OwnerShip_,RiskLevel) 
VALUES 
(200, 1,'Topsy Area','Industrial','Yes','Medium'),
(201, 2, 'Hwy 31','Other Public','No','High'),
(202, 3,'11 MI SE Ritter LO','BLM','Yes','Medium'),
(203, 4,'Woodley C.G','Other Private','Yes','Low'),
(204, 5,'7 N ROGUE RIVER','BLM','Yes','High'),
(205, 6,'','BLM','Yes','High'),
(206, 7,'Kings Valley','State','No','High'),
(207, 8,'Ritner Creek Park','Industrial','Yes','High'),
(208, 9,'Tope Creek','Industrial','Yes','High'),
(209, 10,'12 W GILCHRIST','Rural Residential','Yes','High'),
(210, 11,'HWY 202, MP 12','Rural Residential','Yes','High'),
(211, 12,'BLISS RD','Other Private','Yes','High'),
(212, 13,'7N 8W sec 21','Industrial','Yes','Medium'),
(213, 14,'1/2 MI E OF BARTON PARK','State','No','High'),
(214, 15,'','Industrial','Yes','High'),
(215, 16,'13 Mi SW of Jacksonville','BLM','Yes','High'),
(216, 17,'Smith Ferry Rapids','Small Woodlands','Yes','Medium'),
(217, 18,'','Industrial','Yes','High'),
(218, 19,'4 SW of Glendale','State','No','High'),
(219, 20,'Boomer Hill','BLM','Yes','High'),
(220, 21,'','Industrial','Yes','High'),
(221, 22,'Pengra Boat Landing','Industrial','Yes','Low'),
(222, 23,'5 miles NE of Sweet Home','Industrial','Yes','High'),
(223, 24,'','County','No','High'),
(224, 25,'1 M N HWY 34/WINNEY','Industrial','Yes','High'),
(225, 26,'Gardner Butte','BLM','Yes','Medium'),
(226, 27,'3 mi S of SunRiver','Other Private','Yes','Low'),
(227, 28,'7 E GILCHRIST','State','No','Medium'),
(228, 29,'6 M SE Detroit','Industrial','Yes','High'),
(229, 30,'','Small Woodlands','Yes','Low');

--Check 
SELECT * FROM LocationType

-- History Table 

DROP TABLE IF EXISTS History;
CREATE TABLE History (
   HistoryID INT IDENTITY(400,1) PRIMARY KEY,
   WildfireID INT NOT NULL,
   Ignition_Time DATETIME2(0) NOT NULL,
   Report_Time DATETIME2(0) NOT NULL,
   Discover_Time DATETIME2(0) NOT NULL,
   Control_Time DATETIME2(0) NOT NULL,
);

-- Data Insert For History

INSERT INTO History(WildfireID,Ignition_Time,Report_Time,Discover_Time,Control_Time) 
VALUES 
(1,'09/02/2015 05:00:00 PM','09/02/2015 05:05:00 PM','09/02/2015 05:00:00 PM','09/02/2015 11:00:00 PM'),
(2,'','08/16/2022 06:56:00 PM','',''),
(3,'07/18/2000 07:00:00 PM','07/19/2000 01:20:00 PM','07/19/2000 01:15:00 PM','07/20/2000 12:50:00 AM'),
(4,'08/24/2000 05:30:00 AM','08/24/2000 01:07:00 PM','08/24/2000 01:07:00 PM','09/01/2000 09:30:00 PM'),
(5,'08/10/2001 05:40:00 PM','08/10/2001 05:47:00 PM','08/10/2001 05:45:00 PM','08/10/2001 06:30:00 PM'),
(6,'08/12/2014 06:15:00 PM','08/13/2014 04:01:00 PM','08/13/2014 04:00:00 PM','08/14/2014 06:30:00 PM'),
(7,'07/06/2002 01:01:00 PM','07/06/2002 01:04:00 PM','07/06/2002 01:02:00 PM','07/06/2002 01:07:00 PM'),
(8,'08/22/2003 04:00:00 AM','08/22/2003 05:00:00 AM','08/22/2003 05:00:00 AM','08/22/2003 09:30:00 AM'),
(9,'08/22/2003 06:00:00 PM','08/23/2003 09:24:00 AM','08/23/2003 09:24:00 AM','08/23/2003 12:40:00 PM'),
(10,'08/30/2003 02:20:00 PM','08/30/2003 02:37:00 PM','08/30/2003 02:30:00 PM','08/30/2003 02:41:00 PM'),
(11,'09/18/2005 03:00:00 PM','09/18/2005 03:20:00 PM','09/18/2005 03:05:00 PM','09/18/2005 04:30:00 PM'),
(12,'08/26/2005 11:00:00 PM','08/26/2005 11:29:00 PM','08/26/2005 11:20:00 PM','08/26/2005 11:55:00 PM'),
(13,'06/23/2007 12:00:00 AM','06/23/2007 05:47:00 PM','06/23/2007 05:45:00 PM','06/23/2007 11:00:00 PM'),
(14,'08/25/2014 01:15:00 PM','08/25/2014 01:15:00 PM','08/25/2014 01:15:00 PM','08/25/2014 01:30:00 PM'),
(15,'09/01/2007 02:00:00 AM','09/01/2007 02:25:00 PM','09/01/2007 02:25:00 PM','09/01/2007 03:00:00 PM'),
(16,'10/26/2008 11:45:00 AM','10/26/2008 12:01:00 PM','10/26/2008 12:00:00 PM','10/26/2008 12:30:00 PM'),
(17,'08/17/2008 09:00:00 PM','08/17/2008 09:15:00 PM','08/17/2008 09:10:00 PM','08/18/2008 03:00:00 PM'),
(18,'10/05/2008 06:30:00 AM','10/05/2008 12:04:00 PM','10/05/2008 11:30:00 AM','10/05/2008 01:46:00 PM'),
(19,'09/03/2009 03:30:00 PM','09/03/2009 03:40:00 PM','09/03/2009 03:40:00 PM','09/06/2009 12:55:00 PM'),
(20,'08/01/2009 07:55:00 PM','08/01/2009 07:59:00 PM','08/01/2009 07:58:00 PM','08/02/2009 09:00:00 AM'),
(21,'09/13/2009 02:00:00 AM','09/13/2009 07:28:00 AM','09/13/2009 07:28:00 AM','09/13/2009 08:30:00 AM'),
(22,'08/17/2009 11:48:00 AM','08/17/2009 11:52:00 AM','08/17/2009 11:50:00 AM','08/17/2009 12:16:00 PM'),
(23,'07/12/2009 07:00:00 PM','07/15/2009 05:30:00 AM','07/15/2009 05:30:00 AM','07/15/2009 06:15:00 AM'),
(24,'08/09/2010 06:00:00 AM','08/09/2010 06:17:00 AM','08/09/2010 06:15:00 AM','08/09/2010 06:30:00 AM'),
(25,'07/04/2010 11:00:00 PM','07/06/2010 08:50:00 PM','07/06/2010 08:45:00 PM','07/06/2010 11:30:00 PM'),
(26,'07/08/2010 04:39:00 PM','07/09/2010 11:53:00 AM','07/09/2010 11:52:00 AM','07/09/2010 01:27:00 PM'),
(27,'09/13/2010 08:00:00 PM','09/14/2010 01:56:00 PM','09/14/2010 01:53:00 PM','09/14/2010 03:45:00 PM'),
(28,'05/24/2010 10:00:00 AM','05/29/2010 02:30:00 PM','05/29/2010 02:20:00 PM','05/29/2010 04:45:00 PM'),
(29,'01/30/2011 01:30:00 PM','12/23/2011 04:30:00 PM','12/23/2011 04:30:00 PM','12/23/2011 07:15:00 PM'),
(30,'08/18/2013 03:00:00 PM','08/18/2013 03:15:00 PM','08/18/2013 03:15:00 PM','08/18/2013 03:40:00 PM');


-- Check

SELECT * FROM History

-- Specific Cause Table 

DROP TABLE IF EXISTS SpecificCause;
CREATE TABLE SpecificCause (
    Specific_CauseID INT IDENTITY(500,1) PRIMARY KEY,
    Specific_Cause VARCHAR(100) NOT NULL,
    Cause_Comments VARCHAR(100) NOT NULL
);

-- Data Insert for SpecificCause

INSERT INTO SpecificCause(Specific_Cause,Cause_Comments) 
VALUES 
('',''),
('',''),
('Lightning',''),
('Lightning',''),
('Other - Smoker Related',''),
('Lightning',''),
('Fireworks',''),
('Lightning',''),
('Lightning',''),
('Other - Burning Related',''),
('Powerlines - prior to 2017',''),
('Other - Miscellaneous Related',''),
('Fireworks',''),
('Other - Arson Related',''),
('Lightning',''),
('Hot Ashes (Dumping of)','Dumping of Woodstove ashes'),
('Lightning',''),
('Warming Fire',''),
('Carbon Sparks from Vehicle',''),
('Lightning',''),
('Lightning',''),
('Burning Vehicle or Equipment','Car fire that spread into Wildland.'),
('Lightning','Lightning strike'),
('Rubbish Disposal',''),
('Fireworks',''),
('Lightning',''),
('Lightning',''),
('Lightning',''),
('Other - Arson Related',''),
('Discarded Cigarette/Tobacco','');

-- Check
SELECT * FROM SpecificCause

-- WildfireCause table 

DROP TABLE IF EXISTS WildfireCause;
CREATE TABLE WildfireCause (
    Fire_CauseID INT IDENTITY(600,1) PRIMARY KEY,
    WildfireID INT NOT NULL,
    Specific_CauseID INT NOT NULL,
    Lightening BIT NOT NULL DEFAULT 0,
    Human BIT NOT NULL DEFAULT 0,
    Recreationalist BIT NOT NULL DEFAULT 0,
    Motorist BIT NOT NULL DEFAULT 0,
    Other BIT NOT NULL DEFAULT 0
);

-- Data Insert for WildfireCause

INSERT INTO WildfireCause(WildfireID,Specific_CauseID,lightening,Human,Recreationalist,Motorist,Other) 
VALUES 
(1,500,0,1,0,0,1),
(2,501,0,1,0,0,0),
(3,502,1,0,0,0,0),
(4,503,1,0,0,0,0),
(5,504,0,1,0,0,0),
(6,505,1,0,0,0,0),
(7,506,0,1,0,1,0),
(8,507,1,0,0,0,0),
(9,508,1,0,0,0,0),
(10,509,0,1,0,0,1),
(11,510,0,1,0,0,0),
(12,511,0,1,0,1,0),
(13,512,0,1,1,0,0),
(14,513,0,1,0,0,1),
(15,514,1,0,0,0,0),
(16,515,0,1,0,0,0),
(17,516,1,0,0,0,0),
(18,517,0,1,0,0,0),
(19,518,0,1,0,1,0),
(20,519,1,0,0,0,0),
(21,520,1,0,0,0,0),
(22,521,0,1,0,1,0),
(23,522,1,0,0,0,0),
(24,523,0,1,1,0,1),
(25,524,0,1,1,0,1),
(26,525,1,0,0,0,0),
(27,526,1,0,0,0,0),
(28,527,1,0,0,0,0),
(29,528,0,1,0,0,1),
(30,529,0,1,0,0,1);

--Check 

SELECT * FROM WildfireCause

-- Agency Unit Table

DROP TABLE IF EXISTS AgencyUnit;
CREATE TABLE AgencyUnit (
    AgencyID INT IDENTITY(700,1) PRIMARY KEY NOT NULL,
    Unit_Name VARCHAR(50) NOT NULL,
    Unit_Code INT NOT NULL
);

-- Data insert for AgencyUnit

INSERT INTO AgencyUnit(Unit_Name,Unit_Code) 
VALUES 
('Klamath',101),
('Crescent',112),
('John Day',123),
('La Grande',134),
('Grants Pass',145),
('DFPA Central',156),
('Philomath',167),
('Dallas',178),
('Wallowa',189),
('Crescent',190),
('Astoria',202),
('Klamath',213),
('Astoria',224),
('Molalla',235),
('Klamath',246),
('Medford',101),
('DFPA North',134),
('Wallowa',178),
('Grants Pass',213),
('DFPA South',246),
('DFPA Central',303),
('Eastern Lane',314),
('Sweet Home',325),
('Columbia City',336),
('Philomath',347),
('Medford',358),
('Sisters',369),
('Crescent',380),
('Santiam',391),
('Astoria',392);

--Check

SELECT * FROM AgencyUnit

-- Response Table

DROP TABLE IF EXISTS Response;
CREATE TABLE Response (
    ResponseID INT IDENTITY(800,1) PRIMARY KEY,
    WildfireID INT NOT NULL,
    AgencyID INT NOT NULL,
    RouteID INT NOT NULL,
    DetectionType VARCHAR(100) NOT NULL,
    Protected_Acres DECIMAL(5,2) NOT NULL,
);

-- Data Insert for response

INSERT INTO Response(WildfireID,AgencyID,RouteID,DetectionType,Protected_Acres) 
VALUES 
(1,700,93121,'Carbon Monoxide Detector',3.2),
(2,701,93242,'N/A',0.2),
(3,702,93363,'N/A',0.75),
(4,703,93484,'Smoke Detector',80),
(5,704,93605,'N/A',0.1),
(6,705,93726,'N/A',0.01),
(7,706,93847,'N/A',0.01),
(8,707,93968,'Smoke Detector',0.01),
(9,708,94089,'N/A',0.01),
(10,709,94210,'N/A',0),
(11,710,94331,'Smoke Detector',0.01),
(12,711,94452,'Carbon Monoxide Detector',0.01),
(13,712,94573,'N/A',3),
(14,713,94694,'N/A',0.01),
(15,714,94815,'N/A',0.1),
(16,715,94936,'N/A',0.01),
(17,716,95057,'N/A',1.5),
(18,717,95178,'N/A',0.01),
(19,718,95299,'N/A',0.1),
(20,719,95420,'N/A',0.25),
(21,720,95541,'Smoke Detector',0.01),
(22,721,95662,'N/A',0.1),
(23,722,95783,'N/A',0.01),
(24,723,95904,'N/A',0.01),
(25,724,96025,'N/A',0.14),
(26,725,96146,'N/A',0.1),
(27,726,96267,'N/A',0.05),
(28,727,96388,'N/A',0.25),
(29,728,96509,'N/A',5),
(30,729,96630,'N/A',0.13);


--Check
SELECT * FROM Response

--Victims Table 

DROP TABLE IF EXISTS Victims;
CREATE TABLE Victims (
    VictimID INT IDENTITY(900,1) PRIMARY KEY,
    ResponseID INT NOT NULL,
    InjuryType VARCHAR(50) NOT NULL,
    CasualtyNumber INT NOT NULL,
);

-- Data Insert for Victims

INSERT INTO Victims(ResponseID,InjuryType,CasualtyNumber) 
VALUES 
(800,'Sprain',0),
(801,'N/A',0),
(802,'N/A',0),
(803,'N/A',0),
(804,'Smoke Inhalation',2),
(805,'N/A',0),
(806,'N/A',0),
(807,'Smoke Inhalation',0),
(808,'N/A',0),
(809,'N/A',0),
(810,'Lacerations',0),
(811,'N/A',0),
(812,'N/A',0),
(813,'Fracture',0),
(814,'N/A',0),
(815,'N/A',0),
(816,'Smoke Inhalation',0),
(817,'N/A',0),
(818,'Sprain',0),
(819,'N/A',0),
(820,'Smoke Inhalation',4),
(821,'N/A',0),
(822,'N/A',0),
(823,'N/A',0),
(824,'N/A',0),
(825,'Head Trauma',1),
(826,'N/A',0),
(827,'N/A',0),
(828,'N/A',0),
(829,'N/A',0);

--Check
SELECT * FROM Victims

-- Firefighter Table

DROP TABLE IF EXISTS Firefighter;
CREATE TABLE Firefighter (
    FirefighterID INT IDENTITY(1000,1) PRIMARY KEY,
    WildfireID INT NOT NULL,
    AgencyID INT NOT NULL,
    Firefighter_Name VARCHAR(50) NOT NULL,
    Firefighter_Precinct VARCHAR(50) NOT NULL,
    Firefighter_Experience INT NOT NULL
);

-- Data Insert for Firefighter

INSERT INTO Firefighter(WildfireID,AgencyID,Firefighter_Name,Firefighter_Precinct,Firefighter_Experience) 
VALUES 
(1, 700, 'Olivia','Ironwood Station',2),
(2, 701, 'Liam','Northgate Fire Precinct',15),
(3, 702, 'Emma','Bayfront Firehouse',7),
(4, 703, 'Noah','Crimson Hill Fire Precinct',22),
(5, 704, 'Ava','Echo Ridge Station',1),
(6, 705, 'Elijah','Summit View Firehouse',18),
(7, 706, 'Sophia','Maple Hollow Precinct',10),
(8, 707, 'James','Thunder Creek Station',5),
(9, 708, 'Isabella','Pine Ridge Fire Precinct',3),
(10, 709, 'Benjamin','Silverbrook Firehouse',25),
(11, 710, 'Mia','Redwood Bluff Station',12),
(12, 711, 'Lucas','Falcon Ridge Precinct',8),
(13, 712, 'Charlotte','Riverstone Firehouse',30),
(14, 713, 'Henry','Stonebridge Station',4),
(15, 714, 'Amelia','Horizon Peak Fire Precinct',6),
(16, 715, 'Alexander','Cedar Springs Station',9),
(17, 716, 'Harper','Glacier Point Firehouse',14),
(18, 717, 'Ethan','Oakridge Fire Precinct',11),
(19, 718, 'Evelyn','Windy Hollow Station',20),
(20, 719, 'Jackson','Copper Canyon Firehouse',13),
(21, 720, 'Abigail','Ashgrove Precinct',17),
(22, 721, 'Sebastian','Highland Crest Station',16),
(23, 722, 'Ella','Sapphire Ridge Fire Precinct',19),
(24, 723, 'Aiden','Timber Creek Station',21),
(25, 724, 'Grace','Golden Mesa Firehouse',23),
(26, 725, 'Daniel','Misty Pines Precinct',24),
(27, 726, 'Lily','Firewatch Precinct 27',26),
(28, 727, 'Matthew','Ember Hollow Station',26),
(29, 728, 'Zoey','Lone Rock Fire Precinct',29),
(30, 729, 'Samuel','Cascade Summit Firehouse',30);

-- Check
SELECT * FROM Firefighter

---------------------------- Foreign Keys:

-- Add FKs for Damage

ALTER TABLE Damage
ADD CONSTRAINT FK_Damage_Wildfire
    FOREIGN KEY (WildfireId) REFERENCES Wildfire(WildfireId);


-- FKs for LocationType 

ALTER TABLE LocationType
ADD CONSTRAINT FK_LocationType_Location
    FOREIGN KEY (LocationId) REFERENCES [Location](LocationId),
    CONSTRAINT FK_LocationType_Wildfire
    FOREIGN KEY (WildfireId) REFERENCES Wildfire(WildfireId);

-- FKs for History

ALTER TABLE History
ADD CONSTRAINT FK_History_Wildfire
    FOREIGN KEY (WildfireId) REFERENCES Wildfire(WildfireId);

-- FKs for WildfireCause

ALTER TABLE WildfireCause
ADD CONSTRAINT FK_WildfireCause_Wildfire
    FOREIGN KEY (WildfireId) REFERENCES Wildfire(WildfireId),
    CONSTRAINT FK_WildfireCause_SpecificCause
    FOREIGN KEY (Specific_CauseId) REFERENCES SpecificCause(Specific_CauseId);

-- FKs for Response

ALTER TABLE Response
ADD CONSTRAINT FK_Response_Wildfire
    FOREIGN KEY (WildfireId) REFERENCES Wildfire(WildfireId),
    CONSTRAINT FK_Response_Agency
    FOREIGN KEY (AgencyId) REFERENCES AgencyUnit(AgencyId);

-- FK's for Victims

ALTER TABLE Victims
ADD CONSTRAINT FK_Victims_Response
    FOREIGN KEY (ResponseId) REFERENCES Response(ResponseId);

-- FK's For Firefighter

ALTER TABLE Firefighter
ADD CONSTRAINT FK_Firefighter_Wildfire
    FOREIGN KEY (WildfireId) REFERENCES Wildfire(WildfireId),
    CONSTRAINT FK_Firefighter_Agency
    FOREIGN KEY (AgencyId) REFERENCES AgencyUnit(AgencyId);

-----------------------------

-- Check Constraints:

-- Check constraint added by Lucy

ALTER TABLE Wildfire
ADD CONSTRAINT Check_Wildfire_Acres CHECK (Acres >= 0);

SELECT * FROM Wildfire


-- Check constraint added by Carolyn

ALTER TABLE Victims
ADD CONSTRAINT Check_CasualtyNumber CHECK (CasualtyNumber >= 0);

SELECT * FROM Victims

-- Check Constraint added by Bryce

ALTER TABLE Wildfire
ADD CONSTRAINT Check_WildfireSeverity
CHECK (Severity IN ('A','B','C'));

SELECT * FROM Wildfire

-- Default Constraints:

-- Default constraint added by Lucy

ALTER TABLE Response
ADD CONSTRAINT Default_Response_ProtectecAcres DEFAULT 0.0 FOR Protected_Acres;

SELECT * FROM Response;

-- Default constraint added by Carolyn

ALTER TABLE Victims
ADD CONSTRAINT Default_Victims_CasualtyNumber DEFAULT 0 FOR CasualtyNumber;

SELECT * FROM Victims;

-- Default Constraint added by Bryce

ALTER TABLE Damage
ADD CONSTRAINT Default_Damage_IndustrialRestriction
DEFAULT 'Does Not Apply - Eastern OR' FOR Industrial_Restriction;

SELECT * FROM Damage

-- Computed Columns: 

-- Computed Column added by Lucy

ALTER TABLE History 
ADD Duration AS DATEDIFF(HOUR, Ignition_Time, Control_Time);

SELECT * FROM History

-- Computed Column added by Carolyn

ALTER TABLE History
ADD Years AS YEAR(Ignition_Time);
