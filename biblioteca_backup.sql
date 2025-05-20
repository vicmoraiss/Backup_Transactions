-- MySQL dump 10.13  Distrib 8.1.0, for Win64 (x86_64)
--
-- Host: localhost    Database: biblioteca
-- ------------------------------------------------------
-- Server version	8.1.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `biblioteca`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `biblioteca` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `biblioteca`;

--
-- Table structure for table `autor`
--

DROP TABLE IF EXISTS `autor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `autor` (
  `idAutor` int NOT NULL AUTO_INCREMENT,
  `Nome` varchar(45) DEFAULT NULL,
  `Sobrenome` varchar(45) DEFAULT NULL,
  `nacionalidade` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idAutor`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autor`
--

LOCK TABLES `autor` WRITE;
/*!40000 ALTER TABLE `autor` DISABLE KEYS */;
INSERT INTO `autor` VALUES (1,'Albert','Camus','Frances/Argelia'),(2,'Jean-Paul','Sartre','Frances'),(3,'Erasmo','de Roterdam','Holandes'),(4,'Epicteto','Epicteto','Grego'),(5,'Neil','Gaiman','Ingles');
/*!40000 ALTER TABLE `autor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `editora`
--

DROP TABLE IF EXISTS `editora`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `editora` (
  `idEditora` int NOT NULL AUTO_INCREMENT,
  `razaoSocial` varchar(45) DEFAULT NULL,
  `CNPJ` varchar(13) DEFAULT NULL,
  `Endereco` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idEditora`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `editora`
--

LOCK TABLES `editora` WRITE;
/*!40000 ALTER TABLE `editora` DISABLE KEYS */;
INSERT INTO `editora` VALUES (1,'Intriseca','110022','R.Independencia'),(2,'Sextante','110033','R.15 de Novembro'),(3,'Aleph','110044','R. 7 de setembro'),(4,'Cia das Letras','110055','R.Independencia'),(5,'Arqueiro','110066','R. Bahia');
/*!40000 ALTER TABLE `editora` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emprestimo`
--

DROP TABLE IF EXISTS `emprestimo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `emprestimo` (
  `idEmprestimo` int NOT NULL AUTO_INCREMENT,
  `livro` int DEFAULT NULL,
  `locador` int DEFAULT NULL,
  `situacao` enum('Emprestimo','Devolvido') DEFAULT NULL,
  `dtEmprestimo` varchar(10) DEFAULT NULL,
  `dtDevolucao` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`idEmprestimo`),
  KEY `fk_locador` (`locador`),
  KEY `fk_livro_emp` (`livro`),
  CONSTRAINT `fk_livro_emp` FOREIGN KEY (`livro`) REFERENCES `livro` (`idLivro`),
  CONSTRAINT `fk_locador` FOREIGN KEY (`locador`) REFERENCES `locador` (`idLocador`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emprestimo`
--

LOCK TABLES `emprestimo` WRITE;
/*!40000 ALTER TABLE `emprestimo` DISABLE KEYS */;
INSERT INTO `emprestimo` VALUES (1,2,3,'Devolvido','11/11','21/11'),(2,2,4,'Devolvido','21/11','30/11'),(3,1,5,'Devolvido','01/11','21/11'),(4,4,2,'Emprestimo','01/12','00/00'),(5,5,3,'Emprestimo','01/11','00/00');
/*!40000 ALTER TABLE `emprestimo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `livro`
--

DROP TABLE IF EXISTS `livro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `livro` (
  `idLivro` int NOT NULL AUTO_INCREMENT,
  `titulo` varchar(45) DEFAULT NULL,
  `ISBN` int DEFAULT NULL,
  `Situação` enum('Indisponivel','Disponivel') DEFAULT NULL,
  `dtPublicacao` varchar(12) DEFAULT NULL,
  `codAutor` int DEFAULT NULL,
  `codEditora` int DEFAULT NULL,
  PRIMARY KEY (`idLivro`),
  KEY `fk_editora` (`codEditora`),
  KEY `fk_autor` (`codAutor`),
  KEY `idx_Livro_Situação` (`Situação`),
  KEY `idx_livro_titulo` (`titulo`),
  CONSTRAINT `fk_autor` FOREIGN KEY (`codAutor`) REFERENCES `autor` (`idAutor`),
  CONSTRAINT `fk_editora` FOREIGN KEY (`codEditora`) REFERENCES `editora` (`idEditora`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `livro`
--

LOCK TABLES `livro` WRITE;
/*!40000 ALTER TABLE `livro` DISABLE KEYS */;
INSERT INTO `livro` VALUES (1,'O mito de sisifo',0,'Disponivel','2020',1,1),(2,'O elogio da Loucura',1111,'Disponivel','2019',3,4),(3,'A arte de viver',2222,'Disponivel','2018',4,1),(4,'Mitologia Nordica',3333,'Indisponivel','2020',5,1),(5,'A peste',4444,'Indisponivel','2021',1,2);
/*!40000 ALTER TABLE `livro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locador`
--

DROP TABLE IF EXISTS `locador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `locador` (
  `idLocador` int NOT NULL AUTO_INCREMENT,
  `Nome` varchar(45) DEFAULT NULL,
  `CPF` varchar(11) DEFAULT NULL,
  `endereco` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idLocador`),
  KEY `idx_locador_nome` (`Nome`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locador`
--

LOCK TABLES `locador` WRITE;
/*!40000 ALTER TABLE `locador` DISABLE KEYS */;
INSERT INTO `locador` VALUES (1,'Caio','5656','R dos Bobos'),(2,'Vitor','4747','15 de Novembro'),(3,'Zé','8989','7 de Setembro'),(4,'Fulano','1313','R Rio de Janeiro'),(5,'Beltrano','5757','R Minas Gerais');
/*!40000 ALTER TABLE `locador` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-20 11:48:18
