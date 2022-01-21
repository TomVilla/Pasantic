SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema pasantic
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pasantic
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pasantic` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `pasantic` ;

-- -----------------------------------------------------
-- Table `pasantic`.`empresa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pasantic`.`empresa` (
  `idempresa` INT NOT NULL AUTO_INCREMENT,
  `empresa` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idempresa`)
)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pasantic`.`estudiante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pasantic`.`estudiante` (
  `idEstudiante` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `celular` VARCHAR(45) NOT NULL,
  `universidad` VARCHAR(45) NOT NULL,
  `carrera` VARCHAR(45) NOT NULL,
  `correo` VARCHAR(45) NOT NULL,
  `contra` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`idEstudiante`)
)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pasantic`.`pasantia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pasantic`.`pasantia` (
  `idpasantia` INT NOT NULL AUTO_INCREMENT,
  `trabajo` VARCHAR(45) NOT NULL,
  `idempresa` INT NOT NULL,
  `disponibilidad` INT NOT NULL,
  `fechapub` DATETIME NOT NULL,
  `descripcion` VARCHAR(400) NOT NULL,
  `requisitos` VARCHAR(400) NOT NULL,
  PRIMARY KEY (`idpasantia`),
  CONSTRAINT `idempresa`
    FOREIGN KEY (`idempresa`)
    REFERENCES `pasantic`.`empresa` (`idempresa`)
)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pasantic`.`favorito`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pasantic`.`favorito` (
  `idfavorito` INT NOT NULL AUTO_INCREMENT,
  `idpasantia` INT NOT NULL,
  `idestudiante` INT NOT NULL,
  PRIMARY KEY (`idfavorito`),
  INDEX `idpasantiafav_idx` (`idpasantia` ASC) VISIBLE,
  INDEX `idestudiantefav` (`idestudiante` ASC) VISIBLE,
  CONSTRAINT `idestudiantefav`
    FOREIGN KEY (`idestudiante`)
    REFERENCES `pasantic`.`estudiante` (`idEstudiante`),
  CONSTRAINT `idpasantiafav`
    FOREIGN KEY (`idpasantia`)
    REFERENCES `pasantic`.`pasantia` (`idpasantia`)
)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `pasantic`.`postulacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pasantic`.`postulacion` (
  `idpostulacion` INT NOT NULL AUTO_INCREMENT,
  `idestudiante` INT NOT NULL,
  `idpasantia` INT NOT NULL,
  `estado` VARCHAR(45) NOT NULL,
  `comentarios` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idpostulacion`),
  INDEX `idestudiante_idx` (`idestudiante` ASC) VISIBLE,
  INDEX `idpasantia_idx` (`idpasantia` ASC) VISIBLE,
  CONSTRAINT `idestudiante`
    FOREIGN KEY (`idestudiante`)
    REFERENCES `pasantic`.`estudiante` (`idEstudiante`),
  CONSTRAINT `idpasantia`
    FOREIGN KEY (`idpasantia`)
    REFERENCES `pasantic`.`pasantia` (`idpasantia`)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

INSERT INTO `pasantic`.`empresa` (`empresa`, `direccion`, `telefono`, `email`) VALUES ('espol', 'gye', '09', 'espol@com');
INSERT INTO `pasantic`.`empresa` (`empresa`, `direccion`, `telefono`, `email`) VALUES ('espol1', 'gye', '09', 'espol1@com');
INSERT INTO `pasantic`.`empresa` (`empresa`, `direccion`, `telefono`, `email`) VALUES ('espol2', 'gye', '09', 'espol2@com');
INSERT INTO `pasantic`.`empresa` (`empresa`, `direccion`, `telefono`, `email`) VALUES ('espol4', 'gye', '09', 'espol4@com');
INSERT INTO `pasantic`.`empresa` (`empresa`, `direccion`, `telefono`, `email`) VALUES ('espol5', 'gye', '09', 'espol5@com');

INSERT INTO `pasantic`.`pasantia` (`trabajo`, `idempresa`, `disponibilidad`, `fechapub`, `descripcion`, `requisitos`) VALUES ('Mantenimiento de software', '1', 32, '2022-01-10', 'Diseñar, producir o mantener (programar, adaptar e integrar) componentes o subconjuntos de software (clases, módulos, pantallas, rutinas, subsistemas, programas en general) conforme a especificaciones y requerimientos de la empresa (funcionales y técnicas) para ser integrados en aplicaciones.', 'ninguno');
INSERT INTO `pasantic`.`pasantia` (`trabajo`, `idempresa`, `disponibilidad`, `fechapub`, `descripcion`, `requisitos`) VALUES ('Desarrolador de Software', '2', 42, '2022-02-11', 'Documentar los programas de acuerdo a estándares. Tanto con documentos funcionales y de arquitectura, como con comentarios en el propio código.', 'ninguno');
INSERT INTO `pasantic`.`pasantia` (`trabajo`, `idempresa`, `disponibilidad`, `fechapub`, `descripcion`, `requisitos`) VALUES ('Pasante que desarrolle Software', '3', 52, '2022-03-12', 'Somos Oktana, software house que brinda servicios para desarrollo de aplicaciones, especializada en diseño, implementación, optimización e integración de Salesforce.', 'ninguno');
INSERT INTO `pasantic`.`pasantia` (`trabajo`, `idempresa`, `disponibilidad`, `fechapub`, `descripcion`, `requisitos`) VALUES ('Desarrolador de Software', '4', 62, '2022-04-13', 'Empresa de desarrollo e innovación de tecnologías de información con soluciones integradas en software y hardware empresarial.', 'ninguno');
INSERT INTO `pasantic`.`pasantia` (`trabajo`, `idempresa`, `disponibilidad`, `fechapub`, `descripcion`, `requisitos`) VALUES ('Pasante para desarrolador de Software', '5', 72, '2022-05-14', 'Serás el responsable de atender requerimientos en el sistema ISA, Ignition y desarrollar APP para el grupo empresarial.', 'ninguno');