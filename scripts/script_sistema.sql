-- MySQL Script generated by MySQL Workbench
-- Sex 16 Jun 2017 11:47:38 BRT
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Usuario` (
  `idUsuario` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `login` VARCHAR(12) NOT NULL,
  `senha` VARCHAR(10) NOT NULL,
  `nome` VARCHAR(50) NOT NULL,
  `cpf` CHAR(11) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `telefone` CHAR(11) NULL,
  `modalidade` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`idUsuario`),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Instituicao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Instituicao` (
  `idInstituicao` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `cnpj` CHAR(14) NOT NULL,
  `telefone` CHAR(8) NOT NULL,
  PRIMARY KEY (`idInstituicao`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Usuario_Instituicao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Usuario_Instituicao` (
  `Usuario_idUsuario` INT UNSIGNED NOT NULL,
  `Instituicao_idInstituicao` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`Usuario_idUsuario`, `Instituicao_idInstituicao`),
  INDEX `fk_Usuario_has_Instituicao_Instituicao1_idx` (`Instituicao_idInstituicao` ASC),
  INDEX `fk_Usuario_has_Instituicao_Usuario_idx` (`Usuario_idUsuario` ASC),
  CONSTRAINT `fk_Usuario_has_Instituicao_Usuario`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `mydb`.`Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuario_has_Instituicao_Instituicao1`
    FOREIGN KEY (`Instituicao_idInstituicao`)
    REFERENCES `mydb`.`Instituicao` (`idInstituicao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Projeto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Projeto` (
  `idProjeto` INT NOT NULL AUTO_INCREMENT,
  `data` DATE NOT NULL,
  `evento` VARCHAR(45) NOT NULL,
  `norma` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idProjeto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Usuario_Projeto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Usuario_Projeto` (
  `Usuario_idUsuario` INT UNSIGNED NOT NULL,
  `Projeto_idProjeto` INT NOT NULL,
  PRIMARY KEY (`Usuario_idUsuario`, `Projeto_idProjeto`),
  INDEX `fk_Usuario_has_Projeto_Projeto1_idx` (`Projeto_idProjeto` ASC),
  INDEX `fk_Usuario_has_Projeto_Usuario1_idx` (`Usuario_idUsuario` ASC),
  CONSTRAINT `fk_Usuario_has_Projeto_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `mydb`.`Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuario_has_Projeto_Projeto1`
    FOREIGN KEY (`Projeto_idProjeto`)
    REFERENCES `mydb`.`Projeto` (`idProjeto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Avaliacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Avaliacao` (
  `idAvaliacao` INT NOT NULL AUTO_INCREMENT,
  `data` VARCHAR(45) NOT NULL,
  `Usuario_idUsuario` INT UNSIGNED NOT NULL,
  `Projeto_idProjeto` INT NOT NULL,
  PRIMARY KEY (`idAvaliacao`, `Usuario_idUsuario`, `Projeto_idProjeto`),
  INDEX `fk_Avaliacao_Usuario1_idx` (`Usuario_idUsuario` ASC),
  INDEX `fk_Avaliacao_Projeto1_idx` (`Projeto_idProjeto` ASC),
  CONSTRAINT `fk_Avaliacao_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `mydb`.`Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Avaliacao_Projeto1`
    FOREIGN KEY (`Projeto_idProjeto`)
    REFERENCES `mydb`.`Projeto` (`idProjeto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Criterio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Criterio` (
  `idCriterio` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `Avaliacao_idAvaliacao` INT NOT NULL,
  `Avaliacao_Usuario_idUsuario` INT UNSIGNED NOT NULL,
  `Avaliacao_Projeto_idProjeto` INT NOT NULL,
  PRIMARY KEY (`idCriterio`, `Avaliacao_idAvaliacao`, `Avaliacao_Usuario_idUsuario`, `Avaliacao_Projeto_idProjeto`),
  INDEX `fk_Criterio_Avaliacao1_idx` (`Avaliacao_idAvaliacao` ASC, `Avaliacao_Usuario_idUsuario` ASC, `Avaliacao_Projeto_idProjeto` ASC),
  CONSTRAINT `fk_Criterio_Avaliacao1`
    FOREIGN KEY (`Avaliacao_idAvaliacao` , `Avaliacao_Usuario_idUsuario` , `Avaliacao_Projeto_idProjeto`)
    REFERENCES `mydb`.`Avaliacao` (`idAvaliacao` , `Usuario_idUsuario` , `Projeto_idProjeto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`subcriterio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`subcriterio` (
  `idsubcriterio` INT NOT NULL AUTO_INCREMENT,
  `nota` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `descricao` VARCHAR(45) NOT NULL,
  `Criterio_idCriterio` INT NOT NULL,
  `Criterio_Avaliacao_idAvaliacao` INT NOT NULL,
  `Criterio_Avaliacao_Usuario_idUsuario` INT UNSIGNED NOT NULL,
  `Criterio_Avaliacao_Projeto_idProjeto` INT NOT NULL,
  PRIMARY KEY (`idsubcriterio`, `Criterio_idCriterio`, `Criterio_Avaliacao_idAvaliacao`, `Criterio_Avaliacao_Usuario_idUsuario`, `Criterio_Avaliacao_Projeto_idProjeto`),
  INDEX `fk_subcriterio_Criterio1_idx` (`Criterio_idCriterio` ASC, `Criterio_Avaliacao_idAvaliacao` ASC, `Criterio_Avaliacao_Usuario_idUsuario` ASC, `Criterio_Avaliacao_Projeto_idProjeto` ASC),
  CONSTRAINT `fk_subcriterio_Criterio1`
    FOREIGN KEY (`Criterio_idCriterio` , `Criterio_Avaliacao_idAvaliacao` , `Criterio_Avaliacao_Usuario_idUsuario` , `Criterio_Avaliacao_Projeto_idProjeto`)
    REFERENCES `mydb`.`Criterio` (`idCriterio` , `Avaliacao_idAvaliacao` , `Avaliacao_Usuario_idUsuario` , `Avaliacao_Projeto_idProjeto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Endereco` (
  `rua/av` VARCHAR(50) NOT NULL,
  `numero` INT NOT NULL,
  `bairro` VARCHAR(45) NOT NULL,
  `cidade` VARCHAR(45) NOT NULL,
  `complemento` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`rua/av`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
