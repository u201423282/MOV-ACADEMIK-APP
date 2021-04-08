-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 15-10-2019 a las 06:30:46
-- Versión del servidor: 10.3.16-MariaDB
-- Versión de PHP: 7.1.30

CREATE DATABASE  IF NOT EXISTS `academik` /*!40100 DEFAULT CHARACTER SET utf8 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `academik`;

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `prueba`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alumno`
--

CREATE TABLE `alumno` (
  `IDESTUDIANTE` int(11) NOT NULL,
  `IDENTIFICADOR` varchar(50) NOT NULL,
  `ESTADO` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ano_escolar`
--

CREATE TABLE `ano_escolar` (
  `IDANO_ESCOLAR` int(11) NOT NULL,
  `DESCRIPCION` varchar(100) DEFAULT NULL,
  `IDENTIFICADOR` varchar(100) DEFAULT NULL,
  `YEAR` year(4) NOT NULL,
  `ESBISIESTO` char(1) NOT NULL COMMENT '0=NO ES,1=SI ES',
  `ESTADO` varchar(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `ano_escolar`
--

INSERT INTO `ano_escolar` (`IDANO_ESCOLAR`, `DESCRIPCION`, `IDENTIFICADOR`, `YEAR`, `ESBISIESTO`, `ESTADO`) VALUES
(1, '2021', 'PER-2021', 2021, '0', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ano_escolar_colegio`
--

CREATE TABLE `ano_escolar_colegio` (
  `IDANOESCOLARCOL` int(11) NOT NULL,
  `IDCOLEGIO` int(11) NOT NULL,
  `IDANO_ESCOLAR` int(11) NOT NULL,
  `IDTipPerAca` int(11) NOT NULL,
  `FECHAINICIO` date NOT NULL,
  `FECHAFIN` date NOT NULL,
  `VACACIONES` text NOT NULL,
  `ESTADO` varchar(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `apoderado`
--

CREATE TABLE `apoderado` (
  `IDAPODERADO` int(11) NOT NULL,
  `ESTADO` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aulas`
--

CREATE TABLE `aulas` (
  `idAula` int(11) NOT NULL,
  `idColegio` int(11) NOT NULL,
  `identificador` varchar(50) NOT NULL,
  `tipoAula` int(11) NOT NULL COMMENT '1=Normal / 2 = Polifuncional',
  `estado` char(1) NOT NULL,
  `capacidad` int(11) NOT NULL,
  `descripcion` varchar(50) NOT NULL,
  `fechaCreacion` date NOT NULL,
  `fechaModificacion` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria_cursos`
--

CREATE TABLE `categoria_cursos` (
  `idCategoria` int(11) NOT NULL,
  `idColegio` int(11) NOT NULL,
  `descripcion_corta` varchar(50) NOT NULL,
  `descripcion_larga` varchar(150) NOT NULL,
  `identificador` varchar(30) NOT NULL,
  `estado` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `colegio`
--

CREATE TABLE `colegio` (
  `IDCOLEGIO` int(11) NOT NULL,
  `NOMBRE` varchar(45) DEFAULT NULL,
  `IDENTIFICADOR` varchar(45) NOT NULL,
  `ESTADO` varchar(1) DEFAULT NULL,
  `DEPARTAMENTO` varchar(100) DEFAULT NULL,
  `PROVINCIA` varchar(100) DEFAULT NULL,
  `DISTRITO` varchar(100) DEFAULT NULL,
  `DIRECCION` varchar(200) DEFAULT NULL,
  `IDREPRESENTANTE` int(11) NOT NULL,
  `FECHAREGISTRO` date DEFAULT NULL,
  `FECHAACTUALIZACION` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- -------------------------------------------------------

--
-- Estructura de tabla para la tabla `ubicacion`
--

CREATE TABLE `ubicacion` (
  `idubicacion` int NOT NULL AUTO_INCREMENT,
  `idcolegio` int NOT NULL,
  `direccion` varchar(200) NOT NULL,
  `estado` char(1) DEFAULT NULL,
  `coordenada_x` varchar(50) DEFAULT NULL,
  `coordenada_y` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idubicacion`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;



-- -------------------------------------------------------

--
-- Estructura de tabla para la tabla `colegio_curso`
--

CREATE TABLE `colegio_curso` (
  `IDCOLEGIO` int(11) NOT NULL,
  `IDCURSO` int(11) NOT NULL,
  `ESTADO` varchar(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `colegio_profesor`
--

CREATE TABLE `colegio_profesor` (
  `IDCOLEGIO` int(11) NOT NULL,
  `IDPROFESOR` int(11) NOT NULL,
  `ESTADO` varchar(1) NOT NULL,
  `IDENTIFICADOR` varchar(100) NOT NULL,
  `CORREOLABORAL` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `confi_tipo_planiamiento`
--

CREATE TABLE `confi_tipo_planiamiento` (
  `idTipPla` int(11) NOT NULL,
  `descripcion` varchar(100) NOT NULL,
  `raiz` char(1) NOT NULL COMMENT '0=no es raiz, 1=si es raiz',
  `dependiente` int(11) NOT NULL,
  `estado` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `confi_tipo_planiamiento`
--

INSERT INTO `confi_tipo_planiamiento` (`idTipPla`, `descripcion`, `raiz`, `dependiente`, `estado`) VALUES
(1, 'Modulo', '1', 0, '1'),
(2, 'Unidad', '0', 1, '1'),
(3, 'Tema', '0', 2, '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cursos`
--

CREATE TABLE `cursos` (
  `IDCURSO` int(11) NOT NULL,
  `IDENTIFICADOR` varchar(45) DEFAULT NULL,
  `NOMBRE` varchar(100) DEFAULT NULL,
  `idTipPla` int(11) NOT NULL COMMENT 'Codigo Tipo Planificacion',
  `idCategoria` int(11) NOT NULL COMMENT 'Materia a la cual pertenece',
  `tipoCurso` int(11) NOT NULL COMMENT '1=Normal / 2=Taller',
  `ESTADO` varchar(1) DEFAULT NULL COMMENT '1=Habilitado / 0=Deshabilitado'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `curso_profesor`
--

CREATE TABLE `curso_profesor` (
  `IDPROFESOR` int(11) DEFAULT NULL,
  `IDCURSO` int(11) DEFAULT NULL,
  `ESTADO` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_apoderado_alumno`
--

CREATE TABLE `detalle_apoderado_alumno` (
  `IDAPODERADO` int(11) NOT NULL,
  `IDALUMNO` int(11) NOT NULL,
  `ESTADO` char(1) NOT NULL,
  `IDTIPPAR` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_aula_seccion`
--

CREATE TABLE `detalle_aula_seccion` (
  `idAula` int(11) NOT NULL,
  `idSeccion` int(11) NOT NULL,
  `dia` varchar(15) NOT NULL,
  `horaInicio` varchar(10) NOT NULL,
  `horaFin` varchar(11) NOT NULL,
  `titulo` varchar(50) NOT NULL,
  `idColegio` int(11) NOT NULL,
  `formatRegInicio` varchar(50) NOT NULL COMMENT 'Formato de fecha ISO en el cual fue registrado',
  `formatRegFin` varchar(50) NOT NULL COMMENT 'Formato de fecha ISO en el cual fue registrado'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Detalle de Asignacion de Aulas';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_colegio_alumno`
--

CREATE TABLE `detalle_colegio_alumno` (
  `IDCOLEGIO` int(11) NOT NULL,
  `IDALUMNO` int(11) NOT NULL,
  `IDUBICACION` INT(11) NULL,
  `ESTADO` char(1) NOT NULL,
  `FECHAREGISTRO` datetime NOT NULL,
  `FECHAMODIFICACION` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_contenido_curso`
--

CREATE TABLE `detalle_contenido_curso` (
  `idDetCon` int(11) NOT NULL,
  `idCurso` int(11) NOT NULL,
  `fechaCreacion` date NOT NULL,
  `fechaActualizacion` date NOT NULL,
  `jsonModulo` text NOT NULL,
  `jsonUnidad` text NOT NULL,
  `jsonTema` text NOT NULL,
  `estado` char(1) NOT NULL COMMENT '1=borrador / 2 = publicado / 3 = desactivado'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_cur_grados`
--

CREATE TABLE `detalle_cur_grados` (
  `idGrado` int(11) NOT NULL,
  `idCurso` int(11) NOT NULL,
  `estado` char(1) NOT NULL,
  `idPeriodoPlan` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_cur_sec`
--

CREATE TABLE `detalle_cur_sec` (
  `idSeccion` int(11) NOT NULL,
  `idCurso` int(11) NOT NULL,
  `estado` char(1) NOT NULL,
  `idPeriodoPlan` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_grado_seccion`
--

CREATE TABLE `detalle_grado_seccion` (
  `idGrado` int(11) NOT NULL,
  `idSeccion` int(100) NOT NULL,
  `orden` int(11) NOT NULL,
  `estado` char(1) NOT NULL,
  `idPeriodoAnoEscolar` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_plan_grados`
--

CREATE TABLE `detalle_plan_grados` (
  `idPlanEscolar` int(11) NOT NULL,
  `idGrado` int(11) NOT NULL,
  `orden` int(11) NOT NULL,
  `estado` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `direccion_persona`
--

CREATE TABLE `direccion_persona` (
  `IDDIRECCION` int(11) NOT NULL,
  `TIPODIRECCION` int(11) NOT NULL,
  `UBIGUEO` varchar(20) NOT NULL,
  `DEPARTAMENTO` varchar(10) NOT NULL,
  `PROVINCIA` varchar(10) NOT NULL,
  `DISTRITO` varchar(10) NOT NULL,
  `ESTADO` char(1) NOT NULL,
  `DIRECCION` varchar(200) NOT NULL,
  `IDPERSONA` int(11) NOT NULL,
  `REFERENCIA` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `grados_colegio`
--

CREATE TABLE `grados_colegio` (
  `idGrado` int(11) NOT NULL,
  `idColegio` int(11) NOT NULL,
  `descripcion` varchar(100) NOT NULL,
  `fecharCreacion` date NOT NULL,
  `estado` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `grupo`
--

CREATE TABLE `grupo` (
  `idGrupo` int(11) NOT NULL,
  `descripcion` varchar(100) NOT NULL,
  `estado` char(1) NOT NULL,
  `idColegio` int(11) NOT NULL,
  `fechaCreacion` datetime NOT NULL,
  `fechaModificacion` datetime DEFAULT NULL,
  `usuarioCreacion` int(11) NOT NULL,
  `usuarioModificacion` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `grupo_usuario`
--

CREATE TABLE `grupo_usuario` (
  `idUsuario` int(11) NOT NULL,
  `idGrupo` int(11) NOT NULL,
  `idColegio` int(11) NOT NULL,
  `estado` char(1) NOT NULL,
  `usuarioCreacion` int(11) NOT NULL,
  `usuarioModificacion` int(11) DEFAULT NULL,
  `fechaCreacion` datetime NOT NULL,
  `fechaModificacion` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `matricula`
--

CREATE TABLE `matricula` (
  `idMatricula` int(11) NOT NULL,
  `identificador` varchar(60) NOT NULL,
  `idColegio` int(11) NOT NULL,
  `idPerAca` int(11) NOT NULL,
  `idAlumno` int(11) NOT NULL,
  `tipoSituacion` int(11) NOT NULL,
  `grado` int(11) NOT NULL,
  `seccion` int(11) NOT NULL,
  `observacion` varchar(250) NOT NULL,
  `usuario` int(11) NOT NULL,
  `fechaRegistro` datetime NOT NULL,
  `estado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `menu`
--

CREATE TABLE `menu` (
  `idMenu` int(11) NOT NULL,
  `idTipoMenu` int(11) NOT NULL,
  `descripcion` varchar(100) NOT NULL,
  `estado` int(11) NOT NULL,
  `descripcion_larga` varchar(200) DEFAULT NULL,
  `parent` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `menu`
--

INSERT INTO `menu` (`idMenu`, `idTipoMenu`, `descripcion`, `estado`, `descripcion_larga`, `parent`) VALUES
(2, 1, 'menu-colegio', 1, 'Opción donde se configuran datos del Colegio.', NULL),
(3, 1, 'menu-aula', 1, 'Configuración de Aulas', NULL),
(4, 1, 'manu-profesor', 1, 'Gestión de Profesores', NULL),
(5, 1, 'menu-curso', 1, 'Configuración de Cursos', NULL),
(6, 1, 'menu-alumno', 1, 'Configuración de Alumnos', NULL),
(7, 1, 'menu-programacion', 1, 'Configuración de programación de Horarios de Cursos y Profesores', NULL),
(8, 1, 'menu-matricula', 1, 'Configuración de Matricula', NULL),
(9, 2, 'submenu-editar-colegio', 1, 'Editar datos principales del Colegio', 2),
(10, 2, 'submenu-periodo-academico', 1, 'Configuración del periodo Académico', 2),
(11, 2, 'submenu-plan-curricular', 1, 'Configuración de grados, secciones y cursos', 2),
(12, 2, 'submenu-agregar-colegio', 1, 'Agregar Colegio nuevo', 2),
(13, 2, 'submenu-gestionar-aula', 1, 'Gestionar Aulas', 3),
(14, 2, 'submenu-gestionar-profesor', 1, 'Configurar Datos principales de un profesor', 4),
(15, 2, 'submenu-gestionar-curso', 1, 'Configurar datos, archivos y profesores asignados', 5),
(16, 2, 'submenu-gestionar-categoria', 1, 'Configurar categorias del curso', 5),
(17, 2, 'submenu-registro-manual', 1, 'Registro Manual del alumno', 6),
(18, 2, 'submenu-lista-alumnos', 1, 'Lista de Alumnos del Colegio', 6),
(19, 2, 'submenu-baja-alumno', 1, 'Dar de baja al alumno del Colegio ', 6),
(20, 2, 'submenu-editar-grados', 1, 'Editar datos de los grados del Colegio', 7),
(21, 2, 'submenu-editar-secciones', 1, 'Editar datos de la sección y programar el horario de los cursos para la sección', 7),
(22, 2, 'submenu-programar-profesor', 1, 'Configurar la programación de los profesores', 7),
(23, 2, 'submenu-matricula-manual', 1, 'Registro Manual de Matricula', 8),
(24, 1, 'menu-seguridad', 1, 'Mantenimiento de usuarios roles y permisos para la aplicación', NULL),
(25, 2, 'submenu-configurar-usuarios', 1, 'Configuración de Usuarios', 24),
(26, 2, 'submenu-configurar-grupos', 1, 'Agregar Grupos, agregar privilegios a cada grupo', 24),
(27, 2, 'submenu-listar-matricula', 1, 'Lista de matriculas por periodos.', 8);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

CREATE TABLE `persona` (
  `IDPERSONA` int(11) NOT NULL,
  `NOMBRES` varchar(100) DEFAULT NULL,
  `APELLIDO_PAT` varchar(100) DEFAULT NULL,
  `APELLIDO_MAT` varchar(100) DEFAULT NULL,
  `ESTADO` varchar(1) DEFAULT NULL,
  `TIPODOCUMENTO` varchar(1) DEFAULT NULL,
  `NUMERODOCUMENTO` varchar(15) DEFAULT NULL,
  `FECHAREGISTRO` datetime DEFAULT NULL,
  `FECHAACTUALIZACION` datetime DEFAULT NULL,
  `CORREOPERSONAL` varchar(100) DEFAULT NULL,
  `TELEFONO` varchar(20) DEFAULT NULL,
  `SEXO` char(1) DEFAULT NULL,
  `FECHANACIMIENTO` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `plana_administrativa`
--

CREATE TABLE `plana_administrativa` (
  `idPlanaAdm` int(11) NOT NULL,
  `idColegio` int(11) NOT NULL,
  `estado` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `plan_curricular`
--

CREATE TABLE `plan_curricular` (
  `idPlanCurricular` int(11) NOT NULL,
  `idColegio` int(11) NOT NULL,
  `idAnoEscolarAca` int(11) NOT NULL,
  `estado` char(1) NOT NULL COMMENT '1=borrador / 2 = vigente',
  `tipoAsigCur` char(1) NOT NULL COMMENT 'N= Detalle Curso por Grado / S = detalle Curso por Seccion',
  `numNiveles` int(11) NOT NULL,
  `numSecNivel` int(11) NOT NULL COMMENT 'Numero maximo de secciones por Niveles'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `privilegio`
--

CREATE TABLE `privilegio` (
  `idPrivilegio` int(11) NOT NULL,
  `descripcion` varchar(100) NOT NULL,
  `idMenu` int(11) NOT NULL,
  `estado` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `privilegio`
--

INSERT INTO `privilegio` (`idPrivilegio`, `descripcion`, `idMenu`, `estado`) VALUES
(1, 'acceso-menu-seguridad', 24, '1'),
(2, 'acceso-menu-colegio', 2, '1'),
(3, 'acceso-menu-aula', 3, '1'),
(4, 'acceso-menu-profesor', 4, '1'),
(5, 'acceso-menu-curso', 5, '1'),
(6, 'acceso-menu-alumno', 6, '1'),
(7, 'acceso-menu-programacion', 7, '1'),
(8, 'acceso-menu-matricula', 8, '1'),
(9, 'acceso-submenu-editar-colegio', 9, '1'),
(10, 'acceso-submenu-periodo-academico\r\n', 10, '1'),
(11, 'acceso-submenu-plan-curricular', 11, '1'),
(12, 'acceso-submenu-agregar-colegio', 12, '1'),
(13, 'acceso-submenu-gestionar-aula', 13, '1'),
(14, 'acceso-submenu-gestionar-profesor', 14, '1'),
(15, 'acceso-submenu-gestionar-curso', 15, '1'),
(16, 'acceso-submenu-gestionar-categoria', 16, '1'),
(17, 'acceso-submenu-registro-manual', 17, '1'),
(18, 'acceso-submenu-lista-alumnos', 18, '1'),
(19, 'acceso-submenu-baja-alumno', 19, '1'),
(20, 'acceso-submenu-editar-grados', 20, '1'),
(21, 'acceso-submenu-editar-secciones', 21, '1'),
(22, 'acceso-submenu-programar-profesor', 22, '1'),
(23, 'acceso-submenu-matricula-manual', 23, '1'),
(24, 'acceso-submenu-configurar-usuarios\r\n', 25, '1'),
(25, 'acceso-submenu-configurar-grupos', 26, '1'),
(26, 'acceso-submenu-lista-matricula', 27, '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `privilegio_grupo`
--

CREATE TABLE `privilegio_grupo` (
  `idGrupo` int(11) NOT NULL,
  `idPrivilegio` int(11) NOT NULL,
  `idColegio` int(11) NOT NULL,
  `estado` char(1) NOT NULL,
  `usuarioCreacion` int(11) NOT NULL,
  `usuarioModificacion` int(11) DEFAULT NULL,
  `fechaCreacion` datetime NOT NULL,
  `fechaModificacion` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proceso_colegio`
--

CREATE TABLE `proceso_colegio` (
  `idProCol` int(11) NOT NULL,
  `idTipPro` int(11) NOT NULL,
  `estado` int(11) NOT NULL COMMENT '0=Pendiente/1=En Curso/2=Completado',
  `idColegio` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `profesor`
--

CREATE TABLE `profesor` (
  `IDPROFESOR` int(11) NOT NULL,
  `ESTADO` varchar(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `programacion_seccion_curso`
--

CREATE TABLE `programacion_seccion_curso` (
  `idProgSecCur` int(11) NOT NULL,
  `idSeccion` int(11) NOT NULL,
  `idCurso` int(11) NOT NULL,
  `dia` varchar(15) NOT NULL,
  `horaInicio` varchar(10) NOT NULL,
  `horaFin` varchar(10) NOT NULL,
  `titulo` varchar(50) NOT NULL,
  `idColegio` int(11) NOT NULL,
  `formatRegInicio` varchar(50) NOT NULL,
  `formatRegFin` varchar(50) NOT NULL,
  `idProfesor` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `representante`
--

CREATE TABLE `representante` (
  `IDPERSONA` int(11) NOT NULL,
  `ESTADO` varchar(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol_usuario_logueo`
--

CREATE TABLE `rol_usuario_logueo` (
  `usuario` varchar(50) NOT NULL,
  `rol` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `rol_usuario_logueo`
--

INSERT INTO `rol_usuario_logueo` (`usuario`, `rol`) VALUES
('jmorado', 'SITE_USER');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `secciones`
--

CREATE TABLE `secciones` (
  `idSeccion` int(11) NOT NULL,
  `idColegio` int(11) NOT NULL,
  `descripcion` varchar(100) NOT NULL,
  `fechaCreacion` date NOT NULL,
  `estado` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_contenido`
--

CREATE TABLE `tipo_contenido` (
  `idTipCon` int(11) NOT NULL,
  `descripcion` varchar(50) NOT NULL,
  `adjunto` char(1) NOT NULL,
  `orden` int(11) NOT NULL,
  `estado` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tipo_contenido`
--

INSERT INTO `tipo_contenido` (`idTipCon`, `descripcion`, `adjunto`, `orden`, `estado`) VALUES
(1, 'CARACTERISTICA_Titulo', '0', 1, '1'),
(2, 'CARACTERISTICA_Descripción', '0', 2, '1'),
(3, 'VIDEO_YOUTUBE', '0', 3, '1'),
(4, 'LINK_link1', '0', 4, '1'),
(5, 'LINK_link2', '0', 5, '1'),
(6, 'LINK_link3', '0', 6, '1'),
(7, 'LINK_link4', '0', 7, '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_direccion`
--

CREATE TABLE `tipo_direccion` (
  `IDTIPDIR` int(11) NOT NULL,
  `DESCRIPCION` varchar(30) NOT NULL,
  `ESTADO` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tipo_direccion`
--

INSERT INTO `tipo_direccion` (`IDTIPDIR`, `DESCRIPCION`, `ESTADO`) VALUES
(1, 'PARTICULAR', '1'),
(2, 'LABORAL', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_menu`
--

CREATE TABLE `tipo_menu` (
  `idTipoMenu` int(11) NOT NULL,
  `descripcion` varchar(50) NOT NULL,
  `estado` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tipo_menu`
--

INSERT INTO `tipo_menu` (`idTipoMenu`, `descripcion`, `estado`) VALUES
(1, 'menu', '1'),
(2, 'sub-menu', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_parentesco`
--

CREATE TABLE `tipo_parentesco` (
  `IDTIPPAR` int(11) NOT NULL,
  `DESCRIPCION` varchar(50) NOT NULL,
  `ESTADO` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tipo_parentesco`
--

INSERT INTO `tipo_parentesco` (`IDTIPPAR`, `DESCRIPCION`, `ESTADO`) VALUES
(1, 'Padre', '1'),
(2, 'Madre', '1'),
(3, 'Tio(a)', '1'),
(4, 'Abuelo(a)', '1'),
(5, 'Primo(a)', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_periodo_academico`
--

CREATE TABLE `tipo_periodo_academico` (
  `idTipoPeriodo` int(11) NOT NULL,
  `descripcion` varchar(30) NOT NULL,
  `vacaciones_intermedias` int(11) NOT NULL,
  `estado` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tipo_periodo_academico`
--

INSERT INTO `tipo_periodo_academico` (`idTipoPeriodo`, `descripcion`, `vacaciones_intermedias`, `estado`) VALUES
(1, 'SEMESTRE', 8, '1'),
(2, 'BIMESTRE', 8, '1'),
(3, 'TRIMESTRE', 4, '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_proceso`
--

CREATE TABLE `tipo_proceso` (
  `idTipProceso` int(11) NOT NULL,
  `descripcion` varchar(100) NOT NULL,
  `descripcionlarga` varchar(200) DEFAULT NULL,
  `estado` char(1) NOT NULL,
  `orden` int(11) NOT NULL,
  `parent` varchar(100) DEFAULT NULL,
  `link` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tipo_proceso`
--

INSERT INTO `tipo_proceso` (`idTipProceso`, `descripcion`, `descripcionlarga`, `estado`, `orden`, `parent`, `link`) VALUES
(1, 'Periodo Académico', 'Configurar las fechas de Inicio y Fin para el periodo académico. Configurar fecha de Vacaciones', '1', 1, NULL, '/configuracion/periodoacademico'),
(2, 'Gestionar Curso', 'Registrar información de los profesores', '1', 4, '8', '/administracion/curso'),
(3, 'Gestionar Profesor', 'Registrar Información de los Cursos, asignar profesores', '1', 3, NULL, '/administracion/profesor'),
(4, 'Plan Curricular', 'Configurar la cantidad de niveles y secciones que tendrá el colegio. Además los cursos que serán dictados por cada nivel.', '1', 5, '1,2,3', '/plancurricular/planCurricularBase'),
(5, 'Programación Cursos', 'Configurar horario de dictado de cursos para cada sección.', '1', 6, '4', '/seccion/verFrmListaSeccion'),
(6, 'Programación Profesores', 'Configuración de horario para profesores según el curso de una determinada Sección.', '1', 7, '5', '/programacionProfesor/verFrmProgProfesor'),
(7, 'Programación de Aula', 'Registro y Programación de Aulas para las secciones registradas', '1', 8, '4', '/aula/verFormRegistro'),
(8, 'Gestionar Categoria Curso', 'Registrar las Categorias de los Cursos del Colegio', '1', 2, NULL, '/administracion/verFrmCategoria');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_situacion_mat`
--

CREATE TABLE `tipo_situacion_mat` (
  `idTipSit` int(11) NOT NULL,
  `descripcion` varchar(50) NOT NULL,
  `estado` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tipo_situacion_mat`
--

INSERT INTO `tipo_situacion_mat` (`idTipSit`, `descripcion`, `estado`) VALUES
(1, 'NUEVO', '1'),
(2, 'REINGRESO', '1'),
(3, 'PROMOVIDO', '1'),
(4, 'REPITENTE', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tip_verificacion_acceso`
--

CREATE TABLE `tip_verificacion_acceso` (
  `idTipVer` int(11) NOT NULL,
  `descripcion` varchar(100) NOT NULL,
  `estado` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tip_verificacion_acceso`
--

INSERT INTO `tip_verificacion_acceso` (`idTipVer`, `descripcion`, `estado`) VALUES
(1, 'Creación Cuenta - Representante Legal', '1'),
(2, 'Creación Cuenta - Invitación Empleado', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ubdepartamento`
--

CREATE TABLE `ubdepartamento` (
  `id` int(5) NOT NULL DEFAULT 0,
  `descripcion` varchar(50) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ubdepartamento`
--

INSERT INTO `ubdepartamento` (`id`, `descripcion`) VALUES
(1, 'AMAZONAS'),
(2, 'ANCASH'),
(3, 'APURIMAC'),
(4, 'AREQUIPA'),
(5, 'AYACUCHO'),
(6, 'CAJAMARCA'),
(7, 'CALLAO'),
(8, 'CUSCO'),
(9, 'HUANCAVELICA'),
(10, 'HUANUCO'),
(11, 'ICA'),
(12, 'JUNIN'),
(13, 'LA LIBERTAD'),
(14, 'LAMBAYEQUE'),
(15, 'LIMA'),
(16, 'LORETO'),
(17, 'MADRE DE DIOS'),
(18, 'MOQUEGUA'),
(19, 'PASCO'),
(20, 'PIURA'),
(21, 'PUNO'),
(22, 'SAN MARTIN'),
(23, 'TACNA'),
(24, 'TUMBES'),
(25, 'UCAYALI');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ubdistrito`
--

CREATE TABLE `ubdistrito` (
  `id` int(5) NOT NULL DEFAULT 0,
  `descripcion` varchar(50) DEFAULT NULL,
  `idProv` int(5) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ubdistrito`
--

INSERT INTO `ubdistrito` (`id`, `descripcion`, `idProv`) VALUES
(1, 'CHACHAPOYAS', 1),
(2, 'ASUNCION', 1),
(3, 'BALSAS', 1),
(4, 'CHETO', 1),
(5, 'CHILIQUIN', 1),
(6, 'CHUQUIBAMBA', 1),
(7, 'GRANADA', 1),
(8, 'HUANCAS', 1),
(9, 'LA JALCA', 1),
(10, 'LEIMEBAMBA', 1),
(11, 'LEVANTO', 1),
(12, 'MAGDALENA', 1),
(13, 'MARISCAL CASTILLA', 1),
(14, 'MOLINOPAMPA', 1),
(15, 'MONTEVIDEO', 1),
(16, 'OLLEROS', 1),
(17, 'QUINJALCA', 1),
(18, 'SAN FRANCISCO DE DAGUAS', 1),
(19, 'SAN ISIDRO DE MAINO', 1),
(20, 'SOLOCO', 1),
(21, 'SONCHE', 1),
(22, 'LA PECA', 2),
(23, 'ARAMANGO', 2),
(24, 'COPALLIN', 2),
(25, 'EL PARCO', 2),
(26, 'IMAZA', 2),
(27, 'JUMBILLA', 3),
(28, 'CHISQUILLA', 3),
(29, 'CHURUJA', 3),
(30, 'COROSHA', 3),
(31, 'CUISPES', 3),
(32, 'FLORIDA', 3),
(33, 'JAZAN', 3),
(34, 'RECTA', 3),
(35, 'SAN CARLOS', 3),
(36, 'SHIPASBAMBA', 3),
(37, 'VALERA', 3),
(38, 'YAMBRASBAMBA', 3),
(39, 'NIEVA', 4),
(40, 'EL CENEPA', 4),
(41, 'RIO SANTIAGO', 4),
(42, 'LAMUD', 5),
(43, 'CAMPORREDONDO', 5),
(44, 'COCABAMBA', 5),
(45, 'COLCAMAR', 5),
(46, 'CONILA', 5),
(47, 'INGUILPATA', 5),
(48, 'LONGUITA', 5),
(49, 'LONYA CHICO', 5),
(50, 'LUYA', 5),
(51, 'LUYA VIEJO', 5),
(52, 'MARIA', 5),
(53, 'OCALLI', 5),
(54, 'OCUMAL', 5),
(55, 'PISUQUIA', 5),
(56, 'PROVIDENCIA', 5),
(57, 'SAN CRISTOBAL', 5),
(58, 'SAN FRANCISCO DEL YESO', 5),
(59, 'SAN JERONIMO', 5),
(60, 'SAN JUAN DE LOPECANCHA', 5),
(61, 'SANTA CATALINA', 5),
(62, 'SANTO TOMAS', 5),
(63, 'TINGO', 5),
(64, 'TRITA', 5),
(65, 'SAN NICOLAS', 6),
(66, 'CHIRIMOTO', 6),
(67, 'COCHAMAL', 6),
(68, 'HUAMBO', 6),
(69, 'LIMABAMBA', 6),
(70, 'LONGAR', 6),
(71, 'MARISCAL BENAVIDES', 6),
(72, 'MILPUC', 6),
(73, 'OMIA', 6),
(74, 'SANTA ROSA', 6),
(75, 'TOTORA', 6),
(76, 'VISTA ALEGRE', 6),
(77, 'BAGUA GRANDE', 7),
(78, 'CAJARURO', 7),
(79, 'CUMBA', 7),
(80, 'EL MILAGRO', 7),
(81, 'JAMALCA', 7),
(82, 'LONYA GRANDE', 7),
(83, 'YAMON', 7),
(84, 'HUARAZ', 8),
(85, 'COCHABAMBA', 8),
(86, 'COLCABAMBA', 8),
(87, 'HUANCHAY', 8),
(88, 'INDEPENDENCIA', 8),
(89, 'JANGAS', 8),
(90, 'LA LIBERTAD', 8),
(91, 'OLLEROS', 8),
(92, 'PAMPAS', 8),
(93, 'PARIACOTO', 8),
(94, 'PIRA', 8),
(95, 'TARICA', 8),
(96, 'AIJA', 9),
(97, 'CORIS', 9),
(98, 'HUACLLAN', 9),
(99, 'LA MERCED', 9),
(100, 'SUCCHA', 9),
(101, 'LLAMELLIN', 10),
(102, 'ACZO', 10),
(103, 'CHACCHO', 10),
(104, 'CHINGAS', 10),
(105, 'MIRGAS', 10),
(106, 'SAN JUAN DE RONTOY', 10),
(107, 'CHACAS', 11),
(108, 'ACOCHACA', 11),
(109, 'CHIQUIAN', 12),
(110, 'ABELARDO PARDO LEZAMETA', 12),
(111, 'ANTONIO RAYMONDI', 12),
(112, 'AQUIA', 12),
(113, 'CAJACAY', 12),
(114, 'CANIS', 12),
(115, 'COLQUIOC', 12),
(116, 'HUALLANCA', 12),
(117, 'HUASTA', 12),
(118, 'HUAYLLACAYAN', 12),
(119, 'LA PRIMAVERA', 12),
(120, 'MANGAS', 12),
(121, 'PACLLON', 12),
(122, 'SAN MIGUEL DE CORPANQUI', 12),
(123, 'TICLLOS', 12),
(124, 'CARHUAZ', 13),
(125, 'ACOPAMPA', 13),
(126, 'AMASHCA', 13),
(127, 'ANTA', 13),
(128, 'ATAQUERO', 13),
(129, 'MARCARA', 13),
(130, 'PARIAHUANCA', 13),
(131, 'SAN MIGUEL DE ACO', 13),
(132, 'SHILLA', 13),
(133, 'TINCO', 13),
(134, 'YUNGAR', 13),
(135, 'SAN LUIS', 14),
(136, 'SAN NICOLAS', 14),
(137, 'YAUYA', 14),
(138, 'CASMA', 15),
(139, 'BUENA VISTA ALTA', 15),
(140, 'COMANDANTE NOEL', 15),
(141, 'YAUTAN', 15),
(142, 'CORONGO', 16),
(143, 'ACO', 16),
(144, 'BAMBAS', 16),
(145, 'CUSCA', 16),
(146, 'LA PAMPA', 16),
(147, 'YANAC', 16),
(148, 'YUPAN', 16),
(149, 'HUARI', 17),
(150, 'ANRA', 17),
(151, 'CAJAY', 17),
(152, 'CHAVIN DE HUANTAR', 17),
(153, 'HUACACHI', 17),
(154, 'HUACCHIS', 17),
(155, 'HUACHIS', 17),
(156, 'HUANTAR', 17),
(157, 'MASIN', 17),
(158, 'PAUCAS', 17),
(159, 'PONTO', 17),
(160, 'RAHUAPAMPA', 17),
(161, 'RAPAYAN', 17),
(162, 'SAN MARCOS', 17),
(163, 'SAN PEDRO DE CHANA', 17),
(164, 'UCO', 17),
(165, 'HUARMEY', 18),
(166, 'COCHAPETI', 18),
(167, 'CULEBRAS', 18),
(168, 'HUAYAN', 18),
(169, 'MALVAS', 18),
(170, 'CARAZ', 26),
(171, 'HUALLANCA', 26),
(172, 'HUATA', 26),
(173, 'HUAYLAS', 26),
(174, 'MATO', 26),
(175, 'PAMPAROMAS', 26),
(176, 'PUEBLO LIBRE', 26),
(177, 'SANTA CRUZ', 26),
(178, 'SANTO TORIBIO', 26),
(179, 'YURACMARCA', 26),
(180, 'PISCOBAMBA', 27),
(181, 'CASCA', 27),
(182, 'ELEAZAR GUZMAN BARRON', 27),
(183, 'FIDEL OLIVAS ESCUDERO', 27),
(184, 'LLAMA', 27),
(185, 'LLUMPA', 27),
(186, 'LUCMA', 27),
(187, 'MUSGA', 27),
(188, 'OCROS', 21),
(189, 'ACAS', 21),
(190, 'CAJAMARQUILLA', 21),
(191, 'CARHUAPAMPA', 21),
(192, 'COCHAS', 21),
(193, 'CONGAS', 21),
(194, 'LLIPA', 21),
(195, 'SAN CRISTOBAL DE RAJAN', 21),
(196, 'SAN PEDRO', 21),
(197, 'SANTIAGO DE CHILCAS', 21),
(198, 'CABANA', 22),
(199, 'BOLOGNESI', 22),
(200, 'CONCHUCOS', 22),
(201, 'HUACASCHUQUE', 22),
(202, 'HUANDOVAL', 22),
(203, 'LACABAMBA', 22),
(204, 'LLAPO', 22),
(205, 'PALLASCA', 22),
(206, 'PAMPAS', 22),
(207, 'SANTA ROSA', 22),
(208, 'TAUCA', 22),
(209, 'POMABAMBA', 23),
(210, 'HUAYLLAN', 23),
(211, 'PAROBAMBA', 23),
(212, 'QUINUABAMBA', 23),
(213, 'RECUAY', 24),
(214, 'CATAC', 24),
(215, 'COTAPARACO', 24),
(216, 'HUAYLLAPAMPA', 24),
(217, 'LLACLLIN', 24),
(218, 'MARCA', 24),
(219, 'PAMPAS CHICO', 24),
(220, 'PARARIN', 24),
(221, 'TAPACOCHA', 24),
(222, 'TICAPAMPA', 24),
(223, 'CHIMBOTE', 25),
(224, 'CACERES DEL PERU', 25),
(225, 'COISHCO', 25),
(226, 'MACATE', 25),
(227, 'MORO', 25),
(228, 'NEPE&Ntilde;A', 25),
(229, 'SAMANCO', 25),
(230, 'SANTA', 25),
(231, 'NUEVO CHIMBOTE', 25),
(232, 'SIHUAS', 26),
(233, 'ACOBAMBA', 26),
(234, 'ALFONSO UGARTE', 26),
(235, 'CASHAPAMPA', 26),
(236, 'CHINGALPO', 26),
(237, 'HUAYLLABAMBA', 26),
(238, 'QUICHES', 26),
(239, 'RAGASH', 26),
(240, 'SAN JUAN', 26),
(241, 'SICSIBAMBA', 26),
(242, 'YUNGAY', 27),
(243, 'CASCAPARA', 27),
(244, 'MANCOS', 27),
(245, 'MATACOTO', 27),
(246, 'QUILLO', 27),
(247, 'RANRAHIRCA', 27),
(248, 'SHUPLUY', 27),
(249, 'YANAMA', 27),
(250, 'ABANCAY', 28),
(251, 'CHACOCHE', 28),
(252, 'CIRCA', 28),
(253, 'CURAHUASI', 28),
(254, 'HUANIPACA', 28),
(255, 'LAMBRAMA', 28),
(256, 'PICHIRHUA', 28),
(257, 'SAN PEDRO DE CACHORA', 28),
(258, 'TAMBURCO', 28),
(259, 'ANDAHUAYLAS', 29),
(260, 'ANDARAPA', 29),
(261, 'CHIARA', 29),
(262, 'HUANCARAMA', 29),
(263, 'HUANCARAY', 29),
(264, 'HUAYANA', 29),
(265, 'KISHUARA', 29),
(266, 'PACOBAMBA', 29),
(267, 'PACUCHA', 29),
(268, 'PAMPACHIRI', 29),
(269, 'POMACOCHA', 29),
(270, 'SAN ANTONIO DE CACHI', 29),
(271, 'SAN JERONIMO', 29),
(272, 'SAN MIGUEL DE CHACCRAMPA', 29),
(273, 'SANTA MARIA DE CHICMO', 29),
(274, 'TALAVERA', 29),
(275, 'TUMAY HUARACA', 29),
(276, 'TURPO', 29),
(277, 'KAQUIABAMBA', 29),
(278, 'ANTABAMBA', 30),
(279, 'EL ORO', 30),
(280, 'HUAQUIRCA', 30),
(281, 'JUAN ESPINOZA MEDRANO', 30),
(282, 'OROPESA', 30),
(283, 'PACHACONAS', 30),
(284, 'SABAINO', 30),
(285, 'CHALHUANCA', 31),
(286, 'CAPAYA', 31),
(287, 'CARAYBAMBA', 31),
(288, 'CHAPIMARCA', 31),
(289, 'COLCABAMBA', 31),
(290, 'COTARUSE', 31),
(291, 'HUAYLLO', 31),
(292, 'JUSTO APU SAHUARAURA', 31),
(293, 'LUCRE', 31),
(294, 'POCOHUANCA', 31),
(295, 'SAN JUAN DE CHAC&Ntilde;A', 31),
(296, 'SA&Ntilde;AYCA', 31),
(297, 'SORAYA', 31),
(298, 'TAPAIRIHUA', 31),
(299, 'TINTAY', 31),
(300, 'TORAYA', 31),
(301, 'YANACA', 31),
(302, 'TAMBOBAMBA', 32),
(303, 'COTABAMBAS', 32),
(304, 'COYLLURQUI', 32),
(305, 'HAQUIRA', 32),
(306, 'MARA', 32),
(307, 'CHALLHUAHUACHO', 32),
(308, 'CHINCHEROS', 33),
(309, 'ANCO-HUALLO', 33),
(310, 'COCHARCAS', 33),
(311, 'HUACCANA', 33),
(312, 'OCOBAMBA', 33),
(313, 'ONGOY', 33),
(314, 'URANMARCA', 33),
(315, 'RANRACANCHA', 33),
(316, 'CHUQUIBAMBILLA', 34),
(317, 'CURPAHUASI', 34),
(318, 'GAMARRA', 34),
(319, 'HUAYLLATI', 34),
(320, 'MAMARA', 34),
(321, 'MICAELA BASTIDAS', 34),
(322, 'PATAYPAMPA', 34),
(323, 'PROGRESO', 34),
(324, 'SAN ANTONIO', 34),
(325, 'SANTA ROSA', 34),
(326, 'TURPAY', 34),
(327, 'VILCABAMBA', 34),
(328, 'VIRUNDO', 34),
(329, 'CURASCO', 34),
(330, 'AREQUIPA', 35),
(331, 'ALTO SELVA ALEGRE', 35),
(332, 'CAYMA', 35),
(333, 'CERRO COLORADO', 35),
(334, 'CHARACATO', 35),
(335, 'CHIGUATA', 35),
(336, 'JACOBO HUNTER', 35),
(337, 'LA JOYA', 35),
(338, 'MARIANO MELGAR', 35),
(339, 'MIRAFLORES', 35),
(340, 'MOLLEBAYA', 35),
(341, 'PAUCARPATA', 35),
(342, 'POCSI', 35),
(343, 'POLOBAYA', 35),
(344, 'QUEQUE&Ntilde;A', 35),
(345, 'SABANDIA', 35),
(346, 'SACHACA', 35),
(347, 'SAN JUAN DE SIGUAS', 35),
(348, 'SAN JUAN DE TARUCANI', 35),
(349, 'SANTA ISABEL DE SIGUAS', 35),
(350, 'SANTA RITA DE SIGUAS', 35),
(351, 'SOCABAYA', 35),
(352, 'TIABAYA', 35),
(353, 'UCHUMAYO', 35),
(354, 'VITOR', 35),
(355, 'YANAHUARA', 35),
(356, 'YARABAMBA', 35),
(357, 'YURA', 35),
(358, 'JOSE LUIS BUSTAMANTE Y RIVERO', 35),
(359, 'CAMANA', 36),
(360, 'JOSE MARIA QUIMPER', 36),
(361, 'MARIANO NICOLAS VALCARCEL', 36),
(362, 'MARISCAL CACERES', 36),
(363, 'NICOLAS DE PIEROLA', 36),
(364, 'OCO&Ntilde;A', 36),
(365, 'QUILCA', 36),
(366, 'SAMUEL PASTOR', 36),
(367, 'CARAVELI', 37),
(368, 'ACARI', 37),
(369, 'ATICO', 37),
(370, 'ATIQUIPA', 37),
(371, 'BELLA UNION', 37),
(372, 'CAHUACHO', 37),
(373, 'CHALA', 37),
(374, 'CHAPARRA', 37),
(375, 'HUANUHUANU', 37),
(376, 'JAQUI', 37),
(377, 'LOMAS', 37),
(378, 'QUICACHA', 37),
(379, 'YAUCA', 37),
(380, 'APLAO', 38),
(381, 'ANDAGUA', 38),
(382, 'AYO', 38),
(383, 'CHACHAS', 38),
(384, 'CHILCAYMARCA', 38),
(385, 'CHOCO', 38),
(386, 'HUANCARQUI', 38),
(387, 'MACHAGUAY', 38),
(388, 'ORCOPAMPA', 38),
(389, 'PAMPACOLCA', 38),
(390, 'TIPAN', 38),
(391, 'U&Ntilde;ON', 38),
(392, 'URACA', 38),
(393, 'VIRACO', 38),
(394, 'CHIVAY', 39),
(395, 'ACHOMA', 39),
(396, 'CABANACONDE', 39),
(397, 'CALLALLI', 39),
(398, 'CAYLLOMA', 39),
(399, 'COPORAQUE', 39),
(400, 'HUAMBO', 39),
(401, 'HUANCA', 39),
(402, 'ICHUPAMPA', 39),
(403, 'LARI', 39),
(404, 'LLUTA', 39),
(405, 'MACA', 39),
(406, 'MADRIGAL', 39),
(407, 'SAN ANTONIO DE CHUCA', 39),
(408, 'SIBAYO', 39),
(409, 'TAPAY', 39),
(410, 'TISCO', 39),
(411, 'TUTI', 39),
(412, 'YANQUE', 39),
(413, 'MAJES', 39),
(414, 'CHUQUIBAMBA', 40),
(415, 'ANDARAY', 40),
(416, 'CAYARANI', 40),
(417, 'CHICHAS', 40),
(418, 'IRAY', 40),
(419, 'RIO GRANDE', 40),
(420, 'SALAMANCA', 40),
(421, 'YANAQUIHUA', 40),
(422, 'MOLLENDO', 41),
(423, 'COCACHACRA', 41),
(424, 'DEAN VALDIVIA', 41),
(425, 'ISLAY', 41),
(426, 'MEJIA', 41),
(427, 'PUNTA DE BOMBON', 41),
(428, 'COTAHUASI', 42),
(429, 'ALCA', 42),
(430, 'CHARCANA', 42),
(431, 'HUAYNACOTAS', 42),
(432, 'PAMPAMARCA', 42),
(433, 'PUYCA', 42),
(434, 'QUECHUALLA', 42),
(435, 'SAYLA', 42),
(436, 'TAURIA', 42),
(437, 'TOMEPAMPA', 42),
(438, 'TORO', 42),
(439, 'AYACUCHO', 43),
(440, 'ACOCRO', 43),
(441, 'ACOS VINCHOS', 43),
(442, 'CARMEN ALTO', 43),
(443, 'CHIARA', 43),
(444, 'OCROS', 43),
(445, 'PACAYCASA', 43),
(446, 'QUINUA', 43),
(447, 'SAN JOSE DE TICLLAS', 43),
(448, 'SAN JUAN BAUTISTA', 43),
(449, 'SANTIAGO DE PISCHA', 43),
(450, 'SOCOS', 43),
(451, 'TAMBILLO', 43),
(452, 'VINCHOS', 43),
(453, 'JESUS NAZARENO', 43),
(454, 'CANGALLO', 44),
(455, 'CHUSCHI', 44),
(456, 'LOS MOROCHUCOS', 44),
(457, 'MARIA PARADO DE BELLIDO', 44),
(458, 'PARAS', 44),
(459, 'TOTOS', 44),
(460, 'SANCOS', 45),
(461, 'CARAPO', 45),
(462, 'SACSAMARCA', 45),
(463, 'SANTIAGO DE LUCANAMARCA', 45),
(464, 'HUANTA', 46),
(465, 'AYAHUANCO', 46),
(466, 'HUAMANGUILLA', 46),
(467, 'IGUAIN', 46),
(468, 'LURICOCHA', 46),
(469, 'SANTILLANA', 46),
(470, 'SIVIA', 46),
(471, 'LLOCHEGUA', 46),
(472, 'SAN MIGUEL', 47),
(473, 'ANCO', 47),
(474, 'AYNA', 47),
(475, 'CHILCAS', 47),
(476, 'CHUNGUI', 47),
(477, 'LUIS CARRANZA', 47),
(478, 'SANTA ROSA', 47),
(479, 'TAMBO', 47),
(480, 'PUQUIO', 48),
(481, 'AUCARA', 48),
(482, 'CABANA', 48),
(483, 'CARMEN SALCEDO', 48),
(484, 'CHAVI&Ntilde;A', 48),
(485, 'CHIPAO', 48),
(486, 'HUAC-HUAS', 48),
(487, 'LARAMATE', 48),
(488, 'LEONCIO PRADO', 48),
(489, 'LLAUTA', 48),
(490, 'LUCANAS', 48),
(491, 'OCA&Ntilde;A', 48),
(492, 'OTOCA', 48),
(493, 'SAISA', 48),
(494, 'SAN CRISTOBAL', 48),
(495, 'SAN JUAN', 48),
(496, 'SAN PEDRO', 48),
(497, 'SAN PEDRO DE PALCO', 48),
(498, 'SANCOS', 48),
(499, 'SANTA ANA DE HUAYCAHUACHO', 48),
(500, 'SANTA LUCIA', 48),
(501, 'CORACORA', 49),
(502, 'CHUMPI', 49),
(503, 'CORONEL CASTA&Ntilde;EDA', 49),
(504, 'PACAPAUSA', 49),
(505, 'PULLO', 49),
(506, 'PUYUSCA', 49),
(507, 'SAN FRANCISCO DE RAVACAYCO', 49),
(508, 'UPAHUACHO', 49),
(509, 'PAUSA', 50),
(510, 'COLTA', 50),
(511, 'CORCULLA', 50),
(512, 'LAMPA', 50),
(513, 'MARCABAMBA', 50),
(514, 'OYOLO', 50),
(515, 'PARARCA', 50),
(516, 'SAN JAVIER DE ALPABAMBA', 50),
(517, 'SAN JOSE DE USHUA', 50),
(518, 'SARA SARA', 50),
(519, 'QUEROBAMBA', 51),
(520, 'BELEN', 51),
(521, 'CHALCOS', 51),
(522, 'CHILCAYOC', 51),
(523, 'HUACA&Ntilde;A', 51),
(524, 'MORCOLLA', 51),
(525, 'PAICO', 51),
(526, 'SAN PEDRO DE LARCAY', 51),
(527, 'SAN SALVADOR DE QUIJE', 51),
(528, 'SANTIAGO DE PAUCARAY', 51),
(529, 'SORAS', 51),
(530, 'HUANCAPI', 52),
(531, 'ALCAMENCA', 52),
(532, 'APONGO', 52),
(533, 'ASQUIPATA', 52),
(534, 'CANARIA', 52),
(535, 'CAYARA', 52),
(536, 'COLCA', 52),
(537, 'HUAMANQUIQUIA', 52),
(538, 'HUANCARAYLLA', 52),
(539, 'HUAYA', 52),
(540, 'SARHUA', 52),
(541, 'VILCANCHOS', 52),
(542, 'VILCAS HUAMAN', 53),
(543, 'ACCOMARCA', 53),
(544, 'CARHUANCA', 53),
(545, 'CONCEPCION', 53),
(546, 'HUAMBALPA', 53),
(547, 'INDEPENDENCIA', 53),
(548, 'SAURAMA', 53),
(549, 'VISCHONGO', 53),
(550, 'CAJAMARCA', 54),
(551, 'CAJAMARCA', 54),
(552, 'ASUNCION', 54),
(553, 'CHETILLA', 54),
(554, 'COSPAN', 54),
(555, 'ENCA&Ntilde;ADA', 54),
(556, 'JESUS', 54),
(557, 'LLACANORA', 54),
(558, 'LOS BA&Ntilde;OS DEL INCA', 54),
(559, 'MAGDALENA', 54),
(560, 'MATARA', 54),
(561, 'NAMORA', 54),
(562, 'SAN JUAN', 54),
(563, 'CAJABAMBA', 55),
(564, 'CACHACHI', 55),
(565, 'CONDEBAMBA', 55),
(566, 'SITACOCHA', 55),
(567, 'CELENDIN', 56),
(568, 'CHUMUCH', 56),
(569, 'CORTEGANA', 56),
(570, 'HUASMIN', 56),
(571, 'JORGE CHAVEZ', 56),
(572, 'JOSE GALVEZ', 56),
(573, 'MIGUEL IGLESIAS', 56),
(574, 'OXAMARCA', 56),
(575, 'SOROCHUCO', 56),
(576, 'SUCRE', 56),
(577, 'UTCO', 56),
(578, 'LA LIBERTAD DE PALLAN', 56),
(579, 'CHOTA', 57),
(580, 'ANGUIA', 57),
(581, 'CHADIN', 57),
(582, 'CHIGUIRIP', 57),
(583, 'CHIMBAN', 57),
(584, 'CHOROPAMPA', 57),
(585, 'COCHABAMBA', 57),
(586, 'CONCHAN', 57),
(587, 'HUAMBOS', 57),
(588, 'LAJAS', 57),
(589, 'LLAMA', 57),
(590, 'MIRACOSTA', 57),
(591, 'PACCHA', 57),
(592, 'PION', 57),
(593, 'QUEROCOTO', 57),
(594, 'SAN JUAN DE LICUPIS', 57),
(595, 'TACABAMBA', 57),
(596, 'TOCMOCHE', 57),
(597, 'CHALAMARCA', 57),
(598, 'CONTUMAZA', 58),
(599, 'CHILETE', 58),
(600, 'CUPISNIQUE', 58),
(601, 'GUZMANGO', 58),
(602, 'SAN BENITO', 58),
(603, 'SANTA CRUZ DE TOLED', 58),
(604, 'TANTARICA', 58),
(605, 'YONAN', 58),
(606, 'CUTERVO', 59),
(607, 'CALLAYUC', 59),
(608, 'CHOROS', 59),
(609, 'CUJILLO', 59),
(610, 'LA RAMADA', 59),
(611, 'PIMPINGOS', 59),
(612, 'QUEROCOTILLO', 59),
(613, 'SAN ANDRES DE CUTERVO', 59),
(614, 'SAN JUAN DE CUTERVO', 59),
(615, 'SAN LUIS DE LUCMA', 59),
(616, 'SANTA CRUZ', 59),
(617, 'SANTO DOMINGO DE LA CAPILLA', 59),
(618, 'SANTO TOMAS', 59),
(619, 'SOCOTA', 59),
(620, 'TORIBIO CASANOVA', 59),
(621, 'BAMBAMARCA', 60),
(622, 'CHUGUR', 60),
(623, 'HUALGAYOC', 60),
(624, 'JAEN', 61),
(625, 'BELLAVISTA', 61),
(626, 'CHONTALI', 61),
(627, 'COLASAY', 61),
(628, 'HUABAL', 61),
(629, 'LAS PIRIAS', 61),
(630, 'POMAHUACA', 61),
(631, 'PUCARA', 61),
(632, 'SALLIQUE', 61),
(633, 'SAN FELIPE', 61),
(634, 'SAN JOSE DEL ALTO', 61),
(635, 'SANTA ROSA', 61),
(636, 'SAN IGNACIO', 62),
(637, 'CHIRINOS', 62),
(638, 'HUARANGO', 62),
(639, 'LA COIPA', 62),
(640, 'NAMBALLE', 62),
(641, 'SAN JOSE DE LOURDES', 62),
(642, 'TABACONAS', 62),
(643, 'PEDRO GALVEZ', 63),
(644, 'CHANCAY', 63),
(645, 'EDUARDO VILLANUEVA', 63),
(646, 'GREGORIO PITA', 63),
(647, 'ICHOCAN', 63),
(648, 'JOSE MANUEL QUIROZ', 63),
(649, 'JOSE SABOGAL', 63),
(650, 'SAN MIGUEL', 64),
(651, 'SAN MIGUEL', 64),
(652, 'BOLIVAR', 64),
(653, 'CALQUIS', 64),
(654, 'CATILLUC', 64),
(655, 'EL PRADO', 64),
(656, 'LA FLORIDA', 64),
(657, 'LLAPA', 64),
(658, 'NANCHOC', 64),
(659, 'NIEPOS', 64),
(660, 'SAN GREGORIO', 64),
(661, 'SAN SILVESTRE DE COCHAN', 64),
(662, 'TONGOD', 64),
(663, 'UNION AGUA BLANCA', 64),
(664, 'SAN PABLO', 65),
(665, 'SAN BERNARDINO', 65),
(666, 'SAN LUIS', 65),
(667, 'TUMBADEN', 65),
(668, 'SANTA CRUZ', 66),
(669, 'ANDABAMBA', 66),
(670, 'CATACHE', 66),
(671, 'CHANCAYBA&Ntilde;OS', 66),
(672, 'LA ESPERANZA', 66),
(673, 'NINABAMBA', 66),
(674, 'PULAN', 66),
(675, 'SAUCEPAMPA', 66),
(676, 'SEXI', 66),
(677, 'UTICYACU', 66),
(678, 'YAUYUCAN', 66),
(679, 'CALLAO', 67),
(680, 'BELLAVISTA', 67),
(681, 'CARMEN DE LA LEGUA REYNOSO', 67),
(682, 'LA PERLA', 67),
(683, 'LA PUNTA', 67),
(684, 'VENTANILLA', 67),
(685, 'CUSCO', 67),
(686, 'CCORCA', 67),
(687, 'POROY', 67),
(688, 'SAN JERONIMO', 67),
(689, 'SAN SEBASTIAN', 67),
(690, 'SANTIAGO', 67),
(691, 'SAYLLA', 67),
(692, 'WANCHAQ', 67),
(693, 'ACOMAYO', 68),
(694, 'ACOPIA', 68),
(695, 'ACOS', 68),
(696, 'MOSOC LLACTA', 68),
(697, 'POMACANCHI', 68),
(698, 'RONDOCAN', 68),
(699, 'SANGARARA', 68),
(700, 'ANTA', 69),
(701, 'ANCAHUASI', 69),
(702, 'CACHIMAYO', 69),
(703, 'CHINCHAYPUJIO', 69),
(704, 'HUAROCONDO', 69),
(705, 'LIMATAMBO', 69),
(706, 'MOLLEPATA', 69),
(707, 'PUCYURA', 69),
(708, 'ZURITE', 69),
(709, 'CALCA', 70),
(710, 'COYA', 70),
(711, 'LAMAY', 70),
(712, 'LARES', 70),
(713, 'PISAC', 70),
(714, 'SAN SALVADOR', 70),
(715, 'TARAY', 70),
(716, 'YANATILE', 70),
(717, 'YANAOCA', 71),
(718, 'CHECCA', 71),
(719, 'KUNTURKANKI', 71),
(720, 'LANGUI', 71),
(721, 'LAYO', 71),
(722, 'PAMPAMARCA', 71),
(723, 'QUEHUE', 71),
(724, 'TUPAC AMARU', 71),
(725, 'SICUANI', 72),
(726, 'CHECACUPE', 72),
(727, 'COMBAPATA', 72),
(728, 'MARANGANI', 72),
(729, 'PITUMARCA', 72),
(730, 'SAN PABLO', 72),
(731, 'SAN PEDRO', 72),
(732, 'TINTA', 72),
(733, 'SANTO TOMAS', 73),
(734, 'CAPACMARCA', 73),
(735, 'CHAMACA', 73),
(736, 'COLQUEMARCA', 73),
(737, 'LIVITACA', 73),
(738, 'LLUSCO', 73),
(739, 'QUI&Ntilde;OTA', 73),
(740, 'VELILLE', 73),
(741, 'ESPINAR', 74),
(742, 'CONDOROMA', 74),
(743, 'COPORAQUE', 74),
(744, 'OCORURO', 74),
(745, 'PALLPATA', 74),
(746, 'PICHIGUA', 74),
(747, 'SUYCKUTAMBO', 74),
(748, 'ALTO PICHIGUA', 74),
(749, 'SANTA ANA', 75),
(750, 'ECHARATE', 75),
(751, 'HUAYOPATA', 75),
(752, 'MARANURA', 75),
(753, 'OCOBAMBA', 75),
(754, 'QUELLOUNO', 75),
(755, 'KIMBIRI', 75),
(756, 'SANTA TERESA', 75),
(757, 'VILCABAMBA', 75),
(758, 'PICHARI', 75),
(759, 'PARURO', 76),
(760, 'ACCHA', 76),
(761, 'CCAPI', 76),
(762, 'COLCHA', 76),
(763, 'HUANOQUITE', 76),
(764, 'OMACHA', 76),
(765, 'PACCARITAMBO', 76),
(766, 'PILLPINTO', 76),
(767, 'YAURISQUE', 76),
(768, 'PAUCARTAMBO', 77),
(769, 'CAICAY', 77),
(770, 'CHALLABAMBA', 77),
(771, 'COLQUEPATA', 77),
(772, 'HUANCARANI', 77),
(773, 'KOS&Ntilde;IPATA', 77),
(774, 'URCOS', 78),
(775, 'ANDAHUAYLILLAS', 78),
(776, 'CAMANTI', 78),
(777, 'CCARHUAYO', 78),
(778, 'CCATCA', 78),
(779, 'CUSIPATA', 78),
(780, 'HUARO', 78),
(781, 'LUCRE', 78),
(782, 'MARCAPATA', 78),
(783, 'OCONGATE', 78),
(784, 'OROPESA', 78),
(785, 'QUIQUIJANA', 78),
(786, 'URUBAMBA', 79),
(787, 'CHINCHERO', 79),
(788, 'HUAYLLABAMBA', 79),
(789, 'MACHUPICCHU', 79),
(790, 'MARAS', 79),
(791, 'OLLANTAYTAMBO', 79),
(792, 'YUCAY', 79),
(793, 'HUANCAVELICA', 80),
(794, 'ACOBAMBILLA', 80),
(795, 'ACORIA', 80),
(796, 'CONAYCA', 80),
(797, 'CUENCA', 80),
(798, 'HUACHOCOLPA', 80),
(799, 'HUAYLLAHUARA', 80),
(800, 'IZCUCHACA', 80),
(801, 'LARIA', 80),
(802, 'MANTA', 80),
(803, 'MARISCAL CACERES', 80),
(804, 'MOYA', 80),
(805, 'NUEVO OCCORO', 80),
(806, 'PALCA', 80),
(807, 'PILCHACA', 80),
(808, 'VILCA', 80),
(809, 'YAULI', 80),
(810, 'ASCENSION', 80),
(811, 'HUANDO', 80),
(812, 'ACOBAMBA', 81),
(813, 'ANDABAMBA', 81),
(814, 'ANTA', 81),
(815, 'CAJA', 81),
(816, 'MARCAS', 81),
(817, 'PAUCARA', 81),
(818, 'POMACOCHA', 81),
(819, 'ROSARIO', 81),
(820, 'LIRCAY', 82),
(821, 'ANCHONGA', 82),
(822, 'CALLANMARCA', 82),
(823, 'CCOCHACCASA', 82),
(824, 'CHINCHO', 82),
(825, 'CONGALLA', 82),
(826, 'HUANCA-HUANCA', 82),
(827, 'HUAYLLAY GRANDE', 82),
(828, 'JULCAMARCA', 82),
(829, 'SAN ANTONIO DE ANTAPARCO', 82),
(830, 'SANTO TOMAS DE PATA', 82),
(831, 'SECCLLA', 82),
(832, 'CASTROVIRREYNA', 83),
(833, 'ARMA', 83),
(834, 'AURAHUA', 83),
(835, 'CAPILLAS', 83),
(836, 'CHUPAMARCA', 83),
(837, 'COCAS', 83),
(838, 'HUACHOS', 83),
(839, 'HUAMATAMBO', 83),
(840, 'MOLLEPAMPA', 83),
(841, 'SAN JUAN', 83),
(842, 'SANTA ANA', 83),
(843, 'TANTARA', 83),
(844, 'TICRAPO', 83),
(845, 'CHURCAMPA', 84),
(846, 'ANCO', 84),
(847, 'CHINCHIHUASI', 84),
(848, 'EL CARMEN', 84),
(849, 'LA MERCED', 84),
(850, 'LOCROJA', 84),
(851, 'PAUCARBAMBA', 84),
(852, 'SAN MIGUEL DE MAYOCC', 84),
(853, 'SAN PEDRO DE CORIS', 84),
(854, 'PACHAMARCA', 84),
(855, 'HUAYTARA', 85),
(856, 'AYAVI', 85),
(857, 'CORDOVA', 85),
(858, 'HUAYACUNDO ARMA', 85),
(859, 'LARAMARCA', 85),
(860, 'OCOYO', 85),
(861, 'PILPICHACA', 85),
(862, 'QUERCO', 85),
(863, 'QUITO-ARMA', 85),
(864, 'SAN ANTONIO DE CUSICANCHA', 85),
(865, 'SAN FRANCISCO DE SANGAYAICO', 85),
(866, 'SAN ISIDRO', 85),
(867, 'SANTIAGO DE CHOCORVOS', 85),
(868, 'SANTIAGO DE QUIRAHUARA', 85),
(869, 'SANTO DOMINGO DE CAPILLAS', 85),
(870, 'TAMBO', 85),
(871, 'PAMPAS', 86),
(872, 'ACOSTAMBO', 86),
(873, 'ACRAQUIA', 86),
(874, 'AHUAYCHA', 86),
(875, 'COLCABAMBA', 86),
(876, 'DANIEL HERNANDEZ', 86),
(877, 'HUACHOCOLPA', 86),
(878, 'HUARIBAMBA', 86),
(879, '&Ntilde;AHUIMPUQUIO', 86),
(880, 'PAZOS', 86),
(881, 'QUISHUAR', 86),
(882, 'SALCABAMBA', 86),
(883, 'SALCAHUASI', 86),
(884, 'SAN MARCOS DE ROCCHAC', 86),
(885, 'SURCUBAMBA', 86),
(886, 'TINTAY PUNCU', 86),
(887, 'HUANUCO', 87),
(888, 'AMARILIS', 87),
(889, 'CHINCHAO', 87),
(890, 'CHURUBAMBA', 87),
(891, 'MARGOS', 87),
(892, 'QUISQUI', 87),
(893, 'SAN FRANCISCO DE CAYRAN', 87),
(894, 'SAN PEDRO DE CHAULAN', 87),
(895, 'SANTA MARIA DEL VALLE', 87),
(896, 'YARUMAYO', 87),
(897, 'PILLCO MARCA', 87),
(898, 'AMBO', 88),
(899, 'CAYNA', 88),
(900, 'COLPAS', 88),
(901, 'CONCHAMARCA', 88),
(902, 'HUACAR', 88),
(903, 'SAN FRANCISCO', 88),
(904, 'SAN RAFAEL', 88),
(905, 'TOMAY KICHWA', 88),
(906, 'LA UNION', 89),
(907, 'CHUQUIS', 89),
(908, 'MARIAS', 89),
(909, 'PACHAS', 89),
(910, 'QUIVILLA', 89),
(911, 'RIPAN', 89),
(912, 'SHUNQUI', 89),
(913, 'SILLAPATA', 89),
(914, 'YANAS', 89),
(915, 'HUACAYBAMBA', 90),
(916, 'CANCHABAMBA', 90),
(917, 'COCHABAMBA', 90),
(918, 'PINRA', 90),
(919, 'LLATA', 91),
(920, 'ARANCAY', 91),
(921, 'CHAVIN DE PARIARCA', 91),
(922, 'JACAS GRANDE', 91),
(923, 'JIRCAN', 91),
(924, 'MIRAFLORES', 91),
(925, 'MONZON', 91),
(926, 'PUNCHAO', 91),
(927, 'PU&Ntilde;OS', 91),
(928, 'SINGA', 91),
(929, 'TANTAMAYO', 91),
(930, 'RUPA-RUPA', 92),
(931, 'DANIEL ALOMIA ROBLES', 92),
(932, 'HERMILIO VALDIZAN', 92),
(933, 'JOSE CRESPO Y CASTILLO', 92),
(934, 'LUYANDO', 92),
(935, 'MARIANO DAMASO BERAUN', 92),
(936, 'HUACRACHUCO', 93),
(937, 'CHOLON', 93),
(938, 'SAN BUENAVENTURA', 93),
(939, 'PANAO', 94),
(940, 'CHAGLLA', 94),
(941, 'MOLINO', 94),
(942, 'UMARI', 94),
(943, 'PUERTO INCA', 95),
(944, 'CODO DEL POZUZO', 95),
(945, 'HONORIA', 95),
(946, 'TOURNAVISTA', 95),
(947, 'YUYAPICHIS', 95),
(948, 'JESUS', 96),
(949, 'BA&Ntilde;OS', 96),
(950, 'JIVIA', 96),
(951, 'QUEROPALCA', 96),
(952, 'RONDOS', 96),
(953, 'SAN FRANCISCO DE ASIS', 96),
(954, 'SAN MIGUEL DE CAURI', 96),
(955, 'CHAVINILLO', 97),
(956, 'CAHUAC', 97),
(957, 'CHACABAMBA', 97),
(958, 'APARICIO POMARES', 97),
(959, 'JACAS CHICO', 97),
(960, 'OBAS', 97),
(961, 'PAMPAMARCA', 97),
(962, 'CHORAS', 97),
(963, 'ICA', 98),
(964, 'LA TINGUI&Ntilde;A', 98),
(965, 'LOS AQUIJES', 98),
(966, 'OCUCAJE', 98),
(967, 'PACHACUTEC', 98),
(968, 'PARCONA', 98),
(969, 'PUEBLO NUEVO', 98),
(970, 'SALAS', 98),
(971, 'SAN JOSE DE LOS MOLINOS', 98),
(972, 'SAN JUAN BAUTISTA', 98),
(973, 'SANTIAGO', 98),
(974, 'SUBTANJALLA', 98),
(975, 'TATE', 98),
(976, 'YAUCA DEL ROSARIO', 98),
(977, 'CHINCHA ALTA', 99),
(978, 'ALTO LARAN', 99),
(979, 'CHAVIN', 99),
(980, 'CHINCHA BAJA', 99),
(981, 'EL CARMEN', 99),
(982, 'GROCIO PRADO', 99),
(983, 'PUEBLO NUEVO', 99),
(984, 'SAN JUAN DE YANAC', 99),
(985, 'SAN PEDRO DE HUACARPANA', 99),
(986, 'SUNAMPE', 99),
(987, 'TAMBO DE MORA', 99),
(988, 'NAZCA', 100),
(989, 'CHANGUILLO', 100),
(990, 'EL INGENIO', 100),
(991, 'MARCONA', 100),
(992, 'VISTA ALEGRE', 100),
(993, 'PALPA', 101),
(994, 'LLIPATA', 101),
(995, 'RIO GRANDE', 101),
(996, 'SANTA CRUZ', 101),
(997, 'TIBILLO', 101),
(998, 'PISCO', 102),
(999, 'HUANCANO', 102),
(1000, 'HUMAY', 102),
(1001, 'INDEPENDENCIA', 102),
(1002, 'PARACAS', 102),
(1003, 'SAN ANDRES', 102),
(1004, 'SAN CLEMENTE', 102),
(1005, 'TUPAC AMARU INCA', 102),
(1006, 'HUANCAYO', 103),
(1007, 'CARHUACALLANGA', 103),
(1008, 'CHACAPAMPA', 103),
(1009, 'CHICCHE', 103),
(1010, 'CHILCA', 103),
(1011, 'CHONGOS ALTO', 103),
(1012, 'CHUPURO', 103),
(1013, 'COLCA', 103),
(1014, 'CULLHUAS', 103),
(1015, 'EL TAMBO', 103),
(1016, 'HUACRAPUQUIO', 103),
(1017, 'HUALHUAS', 103),
(1018, 'HUANCAN', 103),
(1019, 'HUASICANCHA', 103),
(1020, 'HUAYUCACHI', 103),
(1021, 'INGENIO', 103),
(1022, 'PARIAHUANCA', 103),
(1023, 'PILCOMAYO', 103),
(1024, 'PUCARA', 103),
(1025, 'QUICHUAY', 103),
(1026, 'QUILCAS', 103),
(1027, 'SAN AGUSTIN', 103),
(1028, 'SAN JERONIMO DE TUNAN', 103),
(1029, 'SA&Ntilde;O', 103),
(1030, 'SAPALLANGA', 103),
(1031, 'SICAYA', 103),
(1032, 'SANTO DOMINGO DE ACOBAMBA', 103),
(1033, 'VIQUES', 103),
(1034, 'CONCEPCION', 104),
(1035, 'ACO', 104),
(1036, 'ANDAMARCA', 104),
(1037, 'CHAMBARA', 104),
(1038, 'COCHAS', 104),
(1039, 'COMAS', 104),
(1040, 'HEROINAS TOLEDO', 104),
(1041, 'MANZANARES', 104),
(1042, 'MARISCAL CASTILLA', 104),
(1043, 'MATAHUASI', 104),
(1044, 'MITO', 104),
(1045, 'NUEVE DE JULIO', 104),
(1046, 'ORCOTUNA', 104),
(1047, 'SAN JOSE DE QUERO', 104),
(1048, 'SANTA ROSA DE OCOPA', 104),
(1049, 'CHANCHAMAYO', 105),
(1050, 'PERENE', 105),
(1051, 'PICHANAQUI', 105),
(1052, 'SAN LUIS DE SHUARO', 105),
(1053, 'SAN RAMON', 105),
(1054, 'VITOC', 105),
(1055, 'JAUJA', 106),
(1056, 'ACOLLA', 106),
(1057, 'APATA', 106),
(1058, 'ATAURA', 106),
(1059, 'CANCHAYLLO', 106),
(1060, 'CURICACA', 106),
(1061, 'EL MANTARO', 106),
(1062, 'HUAMALI', 106),
(1063, 'HUARIPAMPA', 106),
(1064, 'HUERTAS', 106),
(1065, 'JANJAILLO', 106),
(1066, 'JULCAN', 106),
(1067, 'LEONOR ORDO&Ntilde;EZ', 106),
(1068, 'LLOCLLAPAMPA', 106),
(1069, 'MARCO', 106),
(1070, 'MASMA', 106),
(1071, 'MASMA CHICCHE', 106),
(1072, 'MOLINOS', 106),
(1073, 'MONOBAMBA', 106),
(1074, 'MUQUI', 106),
(1075, 'MUQUIYAUYO', 106),
(1076, 'PACA', 106),
(1077, 'PACCHA', 106),
(1078, 'PANCAN', 106),
(1079, 'PARCO', 106),
(1080, 'POMACANCHA', 106),
(1081, 'RICRAN', 106),
(1082, 'SAN LORENZO', 106),
(1083, 'SAN PEDRO DE CHUNAN', 106),
(1084, 'SAUSA', 106),
(1085, 'SINCOS', 106),
(1086, 'TUNAN MARCA', 106),
(1087, 'YAULI', 106),
(1088, 'YAUYOS', 106),
(1089, 'JUNIN', 107),
(1090, 'CARHUAMAYO', 107),
(1091, 'ONDORES', 107),
(1092, 'ULCUMAYO', 107),
(1093, 'SATIPO', 108),
(1094, 'COVIRIALI', 108),
(1095, 'LLAYLLA', 108),
(1096, 'MAZAMARI', 108),
(1097, 'PAMPA HERMOSA', 108),
(1098, 'PANGOA', 108),
(1099, 'RIO NEGRO', 108),
(1100, 'RIO TAMBO', 108),
(1101, 'TARMA', 109),
(1102, 'ACOBAMBA', 109),
(1103, 'HUARICOLCA', 109),
(1104, 'HUASAHUASI', 109),
(1105, 'LA UNION', 109),
(1106, 'PALCA', 109),
(1107, 'PALCAMAYO', 109),
(1108, 'SAN PEDRO DE CAJAS', 109),
(1109, 'TAPO', 109),
(1110, 'LA OROYA', 110),
(1111, 'CHACAPALPA', 110),
(1112, 'HUAY-HUAY', 110),
(1113, 'MARCAPOMACOCHA', 110),
(1114, 'MOROCOCHA', 110),
(1115, 'PACCHA', 110),
(1116, 'SANTA BARBARA DE CARHUACAYAN', 110),
(1117, 'SANTA ROSA DE SACCO', 110),
(1118, 'SUITUCANCHA', 110),
(1119, 'YAULI', 110),
(1120, 'CHUPACA', 111),
(1121, 'AHUAC', 111),
(1122, 'CHONGOS BAJO', 111),
(1123, 'HUACHAC', 111),
(1124, 'HUAMANCACA CHICO', 111),
(1125, 'SAN JUAN DE ISCOS', 111),
(1126, 'SAN JUAN DE JARPA', 111),
(1127, 'TRES DE DICIEMBRE', 111),
(1128, 'YANACANCHA', 111),
(1129, 'TRUJILLO', 112),
(1130, 'EL PORVENIR', 112),
(1131, 'FLORENCIA DE MORA', 112),
(1132, 'HUANCHACO', 112),
(1133, 'LA ESPERANZA', 112),
(1134, 'LAREDO', 112),
(1135, 'MOCHE', 112),
(1136, 'POROTO', 112),
(1137, 'SALAVERRY', 112),
(1138, 'SIMBAL', 112),
(1139, 'VICTOR LARCO HERRERA', 112),
(1140, 'ASCOPE', 113),
(1141, 'CHICAMA', 113),
(1142, 'CHOCOPE', 113),
(1143, 'MAGDALENA DE CAO', 113),
(1144, 'PAIJAN', 113),
(1145, 'RAZURI', 113),
(1146, 'SANTIAGO DE CAO', 113),
(1147, 'CASA GRANDE', 113),
(1148, 'BOLIVAR', 114),
(1149, 'BAMBAMARCA', 114),
(1150, 'CONDORMARCA', 114),
(1151, 'LONGOTEA', 114),
(1152, 'UCHUMARCA', 114),
(1153, 'UCUNCHA', 114),
(1154, 'CHEPEN', 115),
(1155, 'PACANGA', 115),
(1156, 'PUEBLO NUEVO', 115),
(1157, 'JULCAN', 116),
(1158, 'CALAMARCA', 116),
(1159, 'CARABAMBA', 116),
(1160, 'HUASO', 116),
(1161, 'OTUZCO', 117),
(1162, 'AGALLPAMPA', 117),
(1163, 'CHARAT', 117),
(1164, 'HUARANCHAL', 117),
(1165, 'LA CUESTA', 117),
(1166, 'MACHE', 117),
(1167, 'PARANDAY', 117),
(1168, 'SALPO', 117),
(1169, 'SINSICAP', 117),
(1170, 'USQUIL', 117),
(1171, 'SAN PEDRO DE LLOC', 118),
(1172, 'GUADALUPE', 118),
(1173, 'JEQUETEPEQUE', 118),
(1174, 'PACASMAYO', 118),
(1175, 'SAN JOSE', 118),
(1176, 'TAYABAMBA', 119),
(1177, 'BULDIBUYO', 119),
(1178, 'CHILLIA', 119),
(1179, 'HUANCASPATA', 119),
(1180, 'HUAYLILLAS', 119),
(1181, 'HUAYO', 119),
(1182, 'ONGON', 119),
(1183, 'PARCOY', 119),
(1184, 'PATAZ', 119),
(1185, 'PIAS', 119),
(1186, 'SANTIAGO DE CHALLAS', 119),
(1187, 'TAURIJA', 119),
(1188, 'URPAY', 119),
(1189, 'HUAMACHUCO', 120),
(1190, 'CHUGAY', 120),
(1191, 'COCHORCO', 120),
(1192, 'CURGOS', 120),
(1193, 'MARCABAL', 120),
(1194, 'SANAGORAN', 120),
(1195, 'SARIN', 120),
(1196, 'SARTIMBAMBA', 120),
(1197, 'SANTIAGO DE CHUCO', 121),
(1198, 'ANGASMARCA', 121),
(1199, 'CACHICADAN', 121),
(1200, 'MOLLEBAMBA', 121),
(1201, 'MOLLEPATA', 121),
(1202, 'QUIRUVILCA', 121),
(1203, 'SANTA CRUZ DE CHUCA', 121),
(1204, 'SITABAMBA', 121),
(1205, 'GRAN CHIMU', 122),
(1206, 'CASCAS', 122),
(1207, 'LUCMA', 122),
(1208, 'MARMOT', 122),
(1209, 'SAYAPULLO', 122),
(1210, 'VIRU', 123),
(1211, 'CHAO', 123),
(1212, 'GUADALUPITO', 123),
(1213, 'CHICLAYO', 124),
(1214, 'CHONGOYAPE', 124),
(1215, 'ETEN', 124),
(1216, 'ETEN PUERTO', 124),
(1217, 'JOSE LEONARDO ORTIZ', 124),
(1218, 'LA VICTORIA', 124),
(1219, 'LAGUNAS', 124),
(1220, 'MONSEFU', 124),
(1221, 'NUEVA ARICA', 124),
(1222, 'OYOTUN', 124),
(1223, 'PICSI', 124),
(1224, 'PIMENTEL', 124),
(1225, 'REQUE', 124),
(1226, 'SANTA ROSA', 124),
(1227, 'SA&Ntilde;A', 124),
(1228, 'CAYALTI', 124),
(1229, 'PATAPO', 124),
(1230, 'POMALCA', 124),
(1231, 'PUCALA', 124),
(1232, 'TUMAN', 124),
(1233, 'FERRE&Ntilde;AFE', 125),
(1234, 'CA&Ntilde;ARIS', 125),
(1235, 'INCAHUASI', 125),
(1236, 'MANUEL ANTONIO MESONES MURO', 125),
(1237, 'PITIPO', 125),
(1238, 'PUEBLO NUEVO', 125),
(1239, 'LAMBAYEQUE', 126),
(1240, 'CHOCHOPE', 126),
(1241, 'ILLIMO', 126),
(1242, 'JAYANCA', 126),
(1243, 'MOCHUMI', 126),
(1244, 'MORROPE', 126),
(1245, 'MOTUPE', 126),
(1246, 'OLMOS', 126),
(1247, 'PACORA', 126),
(1248, 'SALAS', 126),
(1249, 'SAN JOSE', 126),
(1250, 'TUCUME', 126),
(1251, 'LIMA', 127),
(1252, 'ANCON', 127),
(1253, 'ATE', 127),
(1254, 'BARRANCO', 127),
(1255, 'BRE&Ntilde;A', 127),
(1256, 'CARABAYLLO', 127),
(1257, 'CHACLACAYO', 127),
(1258, 'CHORRILLOS', 127),
(1259, 'CIENEGUILLA', 127),
(1260, 'COMAS', 127),
(1261, 'EL AGUSTINO', 127),
(1262, 'INDEPENDENCIA', 127),
(1263, 'JESUS MARIA', 127),
(1264, 'LA MOLINA', 127),
(1265, 'LA VICTORIA', 127),
(1266, 'LINCE', 127),
(1267, 'LOS OLIVOS', 127),
(1268, 'LURIGANCHO', 127),
(1269, 'LURIN', 127),
(1270, 'MAGDALENA DEL MAR', 127),
(1271, 'MAGDALENA VIEJA', 127),
(1272, 'MIRAFLORES', 127),
(1273, 'PACHACAMAC', 127),
(1274, 'PUCUSANA', 127),
(1275, 'PUENTE PIEDRA', 127),
(1276, 'PUNTA HERMOSA', 127),
(1277, 'PUNTA NEGRA', 127),
(1278, 'RIMAC', 127),
(1279, 'SAN BARTOLO', 127),
(1280, 'SAN BORJA', 127),
(1281, 'SAN ISIDRO', 127),
(1282, 'SAN JUAN DE LURIGANCHO', 127),
(1283, 'SAN JUAN DE MIRAFLORES', 127),
(1284, 'SAN LUIS', 127),
(1285, 'SAN MARTIN DE PORRES', 127),
(1286, 'SAN MIGUEL', 127),
(1287, 'SANTA ANITA', 127),
(1288, 'SANTA MARIA DEL MAR', 127),
(1289, 'SANTA ROSA', 127),
(1290, 'SANTIAGO DE SURCO', 127),
(1291, 'SURQUILLO', 127),
(1292, 'VILLA EL SALVADOR', 127),
(1293, 'VILLA MARIA DEL TRIUNFO', 127),
(1294, 'BARRANCA', 128),
(1295, 'PARAMONGA', 128),
(1296, 'PATIVILCA', 128),
(1297, 'SUPE', 128),
(1298, 'SUPE PUERTO', 128),
(1299, 'CAJATAMBO', 129),
(1300, 'COPA', 129),
(1301, 'GORGOR', 129),
(1302, 'HUANCAPON', 129),
(1303, 'MANAS', 129),
(1304, 'CANTA', 130),
(1305, 'ARAHUAY', 130),
(1306, 'HUAMANTANGA', 130),
(1307, 'HUAROS', 130),
(1308, 'LACHAQUI', 130),
(1309, 'SAN BUENAVENTURA', 130),
(1310, 'SANTA ROSA DE QUIVES', 130),
(1311, 'SAN VICENTE DE CA&Ntilde;ETE', 131),
(1312, 'ASIA', 131),
(1313, 'CALANGO', 131),
(1314, 'CERRO AZUL', 131),
(1315, 'CHILCA', 131),
(1316, 'COAYLLO', 131),
(1317, 'IMPERIAL', 131),
(1318, 'LUNAHUANA', 131),
(1319, 'MALA', 131),
(1320, 'NUEVO IMPERIAL', 131),
(1321, 'PACARAN', 131),
(1322, 'QUILMANA', 131),
(1323, 'SAN ANTONIO', 131),
(1324, 'SAN LUIS', 131),
(1325, 'SANTA CRUZ DE FLORES', 131),
(1326, 'ZU&Ntilde;IGA', 131),
(1327, 'HUARAL', 132),
(1328, 'ATAVILLOS ALTO', 132),
(1329, 'ATAVILLOS BAJO', 132),
(1330, 'AUCALLAMA', 132),
(1331, 'CHANCAY', 132),
(1332, 'IHUARI', 132),
(1333, 'LAMPIAN', 132),
(1334, 'PACARAOS', 132),
(1335, 'SAN MIGUEL DE ACOS', 132),
(1336, 'SANTA CRUZ DE ANDAMARCA', 132),
(1337, 'SUMBILCA', 132),
(1338, 'VEINTISIETE DE NOVIEMBRE', 132),
(1339, 'MATUCANA', 133),
(1340, 'ANTIOQUIA', 133),
(1341, 'CALLAHUANCA', 133),
(1342, 'CARAMPOMA', 133),
(1343, 'CHICLA', 133),
(1344, 'CUENCA', 133),
(1345, 'HUACHUPAMPA', 133),
(1346, 'HUANZA', 133),
(1347, 'HUAROCHIRI', 133),
(1348, 'LAHUAYTAMBO', 133),
(1349, 'LANGA', 133),
(1350, 'LARAOS', 133),
(1351, 'MARIATANA', 133),
(1352, 'RICARDO PALMA', 133),
(1353, 'SAN ANDRES DE TUPICOCHA', 133),
(1354, 'SAN ANTONIO', 133),
(1355, 'SAN BARTOLOME', 133),
(1356, 'SAN DAMIAN', 133),
(1357, 'SAN JUAN DE IRIS', 133),
(1358, 'SAN JUAN DE TANTARANCHE', 133),
(1359, 'SAN LORENZO DE QUINTI', 133),
(1360, 'SAN MATEO', 133),
(1361, 'SAN MATEO DE OTAO', 133),
(1362, 'SAN PEDRO DE CASTA', 133),
(1363, 'SAN PEDRO DE HUANCAYRE', 133),
(1364, 'SANGALLAYA', 133),
(1365, 'SANTA CRUZ DE COCACHACRA', 133),
(1366, 'SANTA EULALIA', 133),
(1367, 'SANTIAGO DE ANCHUCAYA', 133),
(1368, 'SANTIAGO DE TUNA', 133),
(1369, 'SANTO DOMINGO DE LOS OLLEROS', 133),
(1370, 'SURCO', 133),
(1371, 'HUACHO', 134),
(1372, 'AMBAR', 134),
(1373, 'CALETA DE CARQUIN', 134),
(1374, 'CHECRAS', 134),
(1375, 'HUALMAY', 134),
(1376, 'HUAURA', 134),
(1377, 'LEONCIO PRADO', 134),
(1378, 'PACCHO', 134),
(1379, 'SANTA LEONOR', 134),
(1380, 'SANTA MARIA', 134),
(1381, 'SAYAN', 134),
(1382, 'VEGUETA', 134),
(1383, 'OYON', 135),
(1384, 'ANDAJES', 135),
(1385, 'CAUJUL', 135),
(1386, 'COCHAMARCA', 135),
(1387, 'NAVAN', 135),
(1388, 'PACHANGARA', 135),
(1389, 'YAUYOS', 136),
(1390, 'ALIS', 136),
(1391, 'AYAUCA', 136),
(1392, 'AYAVIRI', 136),
(1393, 'AZANGARO', 136),
(1394, 'CACRA', 136),
(1395, 'CARANIA', 136),
(1396, 'CATAHUASI', 136),
(1397, 'CHOCOS', 136),
(1398, 'COCHAS', 136),
(1399, 'COLONIA', 136),
(1400, 'HONGOS', 136),
(1401, 'HUAMPARA', 136),
(1402, 'HUANCAYA', 136),
(1403, 'HUANGASCAR', 136),
(1404, 'HUANTAN', 136),
(1405, 'HUA&Ntilde;EC', 136),
(1406, 'LARAOS', 136),
(1407, 'LINCHA', 136),
(1408, 'MADEAN', 136),
(1409, 'MIRAFLORES', 136),
(1410, 'OMAS', 136),
(1411, 'PUTINZA', 136),
(1412, 'QUINCHES', 136),
(1413, 'QUINOCAY', 136),
(1414, 'SAN JOAQUIN', 136),
(1415, 'SAN PEDRO DE PILAS', 136),
(1416, 'TANTA', 136),
(1417, 'TAURIPAMPA', 136),
(1418, 'TOMAS', 136),
(1419, 'TUPE', 136),
(1420, 'VI&Ntilde;AC', 136),
(1421, 'VITIS', 136),
(1422, 'IQUITOS', 137),
(1423, 'ALTO NANAY', 137),
(1424, 'FERNANDO LORES', 137),
(1425, 'INDIANA', 137),
(1426, 'LAS AMAZONAS', 137),
(1427, 'MAZAN', 137),
(1428, 'NAPO', 137),
(1429, 'PUNCHANA', 137),
(1430, 'PUTUMAYO', 137),
(1431, 'TORRES CAUSANA', 137),
(1432, 'BELEN', 137),
(1433, 'SAN JUAN BAUTISTA', 137),
(1434, 'YURIMAGUAS', 138),
(1435, 'BALSAPUERTO', 138),
(1436, 'BARRANCA', 138),
(1437, 'CAHUAPANAS', 138),
(1438, 'JEBEROS', 138),
(1439, 'LAGUNAS', 138),
(1440, 'MANSERICHE', 138),
(1441, 'MORONA', 138),
(1442, 'PASTAZA', 138),
(1443, 'SANTA CRUZ', 138),
(1444, 'TENIENTE CESAR LOPEZ ROJAS', 138),
(1445, 'NAUTA', 139),
(1446, 'PARINARI', 139),
(1447, 'TIGRE', 139),
(1448, 'TROMPETEROS', 139),
(1449, 'URARINAS', 139),
(1450, 'RAMON CASTILLA', 140),
(1451, 'PEBAS', 140),
(1452, 'YAVARI', 140),
(1453, 'SAN PABLO', 140),
(1454, 'REQUENA', 141),
(1455, 'ALTO TAPICHE', 141),
(1456, 'CAPELO', 141),
(1457, 'EMILIO SAN MARTIN', 141),
(1458, 'MAQUIA', 141),
(1459, 'PUINAHUA', 141),
(1460, 'SAQUENA', 141),
(1461, 'SOPLIN', 141),
(1462, 'TAPICHE', 141),
(1463, 'JENARO HERRERA', 141),
(1464, 'YAQUERANA', 141),
(1465, 'CONTAMANA', 142),
(1466, 'INAHUAYA', 142),
(1467, 'PADRE MARQUEZ', 142),
(1468, 'PAMPA HERMOSA', 142),
(1469, 'SARAYACU', 142),
(1470, 'VARGAS GUERRA', 142),
(1471, 'TAMBOPATA', 143),
(1472, 'INAMBARI', 143),
(1473, 'LAS PIEDRAS', 143),
(1474, 'LABERINTO', 143),
(1475, 'MANU', 144),
(1476, 'FITZCARRALD', 144),
(1477, 'MADRE DE DIOS', 144),
(1478, 'HUEPETUHE', 144),
(1479, 'I&Ntilde;APARI', 145),
(1480, 'IBERIA', 145),
(1481, 'TAHUAMANU', 145),
(1482, 'MOQUEGUA', 146),
(1483, 'CARUMAS', 146),
(1484, 'CUCHUMBAYA', 146),
(1485, 'SAMEGUA', 146),
(1486, 'SAN CRISTOBAL', 146),
(1487, 'TORATA', 146),
(1488, 'OMATE', 147),
(1489, 'CHOJATA', 147),
(1490, 'COALAQUE', 147),
(1491, 'ICHU&Ntilde;A', 147),
(1492, 'LA CAPILLA', 147),
(1493, 'LLOQUE', 147),
(1494, 'MATALAQUE', 147),
(1495, 'PUQUINA', 147),
(1496, 'QUINISTAQUILLAS', 147),
(1497, 'UBINAS', 147),
(1498, 'YUNGA', 147),
(1499, 'ILO', 148),
(1500, 'EL ALGARROBAL', 148),
(1501, 'PACOCHA', 148),
(1502, 'CHAUPIMARCA', 149),
(1503, 'HUACHON', 149),
(1504, 'HUARIACA', 149),
(1505, 'HUAYLLAY', 149),
(1506, 'NINACACA', 149),
(1507, 'PALLANCHACRA', 149),
(1508, 'PAUCARTAMBO', 149),
(1509, 'SAN FCO.DE ASIS DE YARUSYACAN', 149),
(1510, 'SIMON BOLIVAR', 149),
(1511, 'TICLACAYAN', 149),
(1512, 'TINYAHUARCO', 149),
(1513, 'VICCO', 149),
(1514, 'YANACANCHA', 149),
(1515, 'YANAHUANCA', 150),
(1516, 'CHACAYAN', 150),
(1517, 'GOYLLARISQUIZGA', 150),
(1518, 'PAUCAR', 150),
(1519, 'SAN PEDRO DE PILLAO', 150),
(1520, 'SANTA ANA DE TUSI', 150),
(1521, 'TAPUC', 150),
(1522, 'VILCABAMBA', 150),
(1523, 'OXAPAMPA', 151),
(1524, 'CHONTABAMBA', 151),
(1525, 'HUANCABAMBA', 151),
(1526, 'PALCAZU', 151),
(1527, 'POZUZO', 151),
(1528, 'PUERTO BERMUDEZ', 151),
(1529, 'VILLA RICA', 151),
(1530, 'PIURA', 152),
(1531, 'CASTILLA', 152),
(1532, 'CATACAOS', 152),
(1533, 'CURA MORI', 152),
(1534, 'EL TALLAN', 152),
(1535, 'LA ARENA', 152),
(1536, 'LA UNION', 152),
(1537, 'LAS LOMAS', 152),
(1538, 'TAMBO GRANDE', 152),
(1539, 'AYABACA', 153),
(1540, 'FRIAS', 153),
(1541, 'JILILI', 153),
(1542, 'LAGUNAS', 153),
(1543, 'MONTERO', 153),
(1544, 'PACAIPAMPA', 153),
(1545, 'PAIMAS', 153),
(1546, 'SAPILLICA', 153),
(1547, 'SICCHEZ', 153),
(1548, 'SUYO', 153),
(1549, 'HUANCABAMBA', 154),
(1550, 'CANCHAQUE', 154),
(1551, 'EL CARMEN DE LA FRONTERA', 154),
(1552, 'HUARMACA', 154),
(1553, 'LALAQUIZ', 154),
(1554, 'SAN MIGUEL DE EL FAIQUE', 154),
(1555, 'SONDOR', 154),
(1556, 'SONDORILLO', 154),
(1557, 'CHULUCANAS', 155),
(1558, 'BUENOS AIRES', 155),
(1559, 'CHALACO', 155),
(1560, 'LA MATANZA', 155),
(1561, 'MORROPON', 155),
(1562, 'SALITRAL', 155),
(1563, 'SAN JUAN DE BIGOTE', 155),
(1564, 'SANTA CATALINA DE MOSSA', 155),
(1565, 'SANTO DOMINGO', 155),
(1566, 'YAMANGO', 155),
(1567, 'PAITA', 156),
(1568, 'AMOTAPE', 156),
(1569, 'ARENAL', 156),
(1570, 'COLAN', 156),
(1571, 'LA HUACA', 156),
(1572, 'TAMARINDO', 156),
(1573, 'VICHAYAL', 156),
(1574, 'SULLANA', 157),
(1575, 'BELLAVISTA', 157),
(1576, 'IGNACIO ESCUDERO', 157),
(1577, 'LANCONES', 157),
(1578, 'MARCAVELICA', 157),
(1579, 'MIGUEL CHECA', 157),
(1580, 'QUERECOTILLO', 157),
(1581, 'SALITRAL', 157),
(1582, 'PARI&Ntilde;AS', 158),
(1583, 'EL ALTO', 158),
(1584, 'LA BREA', 158),
(1585, 'LOBITOS', 158),
(1586, 'LOS ORGANOS', 158),
(1587, 'MANCORA', 158),
(1588, 'SECHURA', 159),
(1589, 'BELLAVISTA DE LA UNION', 159),
(1590, 'BERNAL', 159),
(1591, 'CRISTO NOS VALGA', 159),
(1592, 'VICE', 159),
(1593, 'RINCONADA LLICUAR', 159),
(1594, 'PUNO', 160),
(1595, 'ACORA', 160),
(1596, 'AMANTANI', 160),
(1597, 'ATUNCOLLA', 160),
(1598, 'CAPACHICA', 160),
(1599, 'CHUCUITO', 160),
(1600, 'COATA', 160),
(1601, 'HUATA', 160),
(1602, 'MA&Ntilde;AZO', 160),
(1603, 'PAUCARCOLLA', 160),
(1604, 'PICHACANI', 160),
(1605, 'PLATERIA', 160),
(1606, 'SAN ANTONIO', 160),
(1607, 'TIQUILLACA', 160),
(1608, 'VILQUE', 160),
(1609, 'AZANGARO', 161),
(1610, 'ACHAYA', 161),
(1611, 'ARAPA', 161),
(1612, 'ASILLO', 161),
(1613, 'CAMINACA', 161),
(1614, 'CHUPA', 161),
(1615, 'JOSE DOMINGO CHOQUEHUANCA', 161),
(1616, 'MU&Ntilde;ANI', 161),
(1617, 'POTONI', 161),
(1618, 'SAMAN', 161),
(1619, 'SAN ANTON', 161),
(1620, 'SAN JOSE', 161),
(1621, 'SAN JUAN DE SALINAS', 161),
(1622, 'SANTIAGO DE PUPUJA', 161),
(1623, 'TIRAPATA', 161),
(1624, 'MACUSANI', 162),
(1625, 'AJOYANI', 162),
(1626, 'AYAPATA', 162),
(1627, 'COASA', 162),
(1628, 'CORANI', 162),
(1629, 'CRUCERO', 162),
(1630, 'ITUATA', 162),
(1631, 'OLLACHEA', 162),
(1632, 'SAN GABAN', 162),
(1633, 'USICAYOS', 162),
(1634, 'JULI', 163),
(1635, 'DESAGUADERO', 163),
(1636, 'HUACULLANI', 163),
(1637, 'KELLUYO', 163),
(1638, 'PISACOMA', 163),
(1639, 'POMATA', 163),
(1640, 'ZEPITA', 163),
(1641, 'ILAVE', 164),
(1642, 'CAPAZO', 164),
(1643, 'PILCUYO', 164),
(1644, 'SANTA ROSA', 164),
(1645, 'CONDURIRI', 164),
(1646, 'HUANCANE', 165),
(1647, 'COJATA', 165),
(1648, 'HUATASANI', 165),
(1649, 'INCHUPALLA', 165),
(1650, 'PUSI', 165),
(1651, 'ROSASPATA', 165),
(1652, 'TARACO', 165),
(1653, 'VILQUE CHICO', 165),
(1654, 'LAMPA', 166),
(1655, 'CABANILLA', 166),
(1656, 'CALAPUJA', 166),
(1657, 'NICASIO', 166),
(1658, 'OCUVIRI', 166),
(1659, 'PALCA', 166),
(1660, 'PARATIA', 166),
(1661, 'PUCARA', 166),
(1662, 'SANTA LUCIA', 166),
(1663, 'VILAVILA', 166),
(1664, 'AYAVIRI', 167),
(1665, 'ANTAUTA', 167),
(1666, 'CUPI', 167),
(1667, 'LLALLI', 167),
(1668, 'MACARI', 167),
(1669, 'NU&Ntilde;OA', 167),
(1670, 'ORURILLO', 167),
(1671, 'SANTA ROSA', 167),
(1672, 'UMACHIRI', 167),
(1673, 'MOHO', 168),
(1674, 'CONIMA', 168),
(1675, 'HUAYRAPATA', 168),
(1676, 'TILALI', 168),
(1677, 'PUTINA', 169),
(1678, 'ANANEA', 169),
(1679, 'PEDRO VILCA APAZA', 169),
(1680, 'QUILCAPUNCU', 169),
(1681, 'SINA', 169),
(1682, 'JULIACA', 170),
(1683, 'CABANA', 170),
(1684, 'CABANILLAS', 170),
(1685, 'CARACOTO', 170),
(1686, 'SANDIA', 171),
(1687, 'CUYOCUYO', 171),
(1688, 'LIMBANI', 171),
(1689, 'PATAMBUCO', 171),
(1690, 'PHARA', 171),
(1691, 'QUIACA', 171),
(1692, 'SAN JUAN DEL ORO', 171),
(1693, 'YANAHUAYA', 171),
(1694, 'ALTO INAMBARI', 171),
(1695, 'YUNGUYO', 172),
(1696, 'ANAPIA', 172),
(1697, 'COPANI', 172),
(1698, 'CUTURAPI', 172),
(1699, 'OLLARAYA', 172),
(1700, 'TINICACHI', 172),
(1701, 'UNICACHI', 172),
(1702, 'MOYOBAMBA', 173),
(1703, 'CALZADA', 173),
(1704, 'HABANA', 173),
(1705, 'JEPELACIO', 173),
(1706, 'SORITOR', 173),
(1707, 'YANTALO', 173),
(1708, 'BELLAVISTA', 174),
(1709, 'ALTO BIAVO', 174),
(1710, 'BAJO BIAVO', 174),
(1711, 'HUALLAGA', 174),
(1712, 'SAN PABLO', 174),
(1713, 'SAN RAFAEL', 174),
(1714, 'SAN JOSE DE SISA', 175),
(1715, 'AGUA BLANCA', 175),
(1716, 'SAN MARTIN', 175),
(1717, 'SANTA ROSA', 175),
(1718, 'SHATOJA', 175),
(1719, 'SAPOSOA', 176),
(1720, 'ALTO SAPOSOA', 176),
(1721, 'EL ESLABON', 176),
(1722, 'PISCOYACU', 176),
(1723, 'SACANCHE', 176),
(1724, 'TINGO DE SAPOSOA', 176),
(1725, 'LAMAS', 177),
(1726, 'ALONSO DE ALVARADO', 177),
(1727, 'BARRANQUITA', 177),
(1728, 'CAYNARACHI', 177),
(1729, 'CU&Ntilde;UMBUQUI', 177),
(1730, 'PINTO RECODO', 177),
(1731, 'RUMISAPA', 177),
(1732, 'SAN ROQUE DE CUMBAZA', 177),
(1733, 'SHANAO', 177),
(1734, 'TABALOSOS', 177),
(1735, 'ZAPATERO', 177),
(1736, 'JUANJUI', 178),
(1737, 'CAMPANILLA', 178),
(1738, 'HUICUNGO', 178),
(1739, 'PACHIZA', 178),
(1740, 'PAJARILLO', 178),
(1741, 'PICOTA', 179),
(1742, 'BUENOS AIRES', 179),
(1743, 'CASPISAPA', 179),
(1744, 'PILLUANA', 179),
(1745, 'PUCACACA', 179),
(1746, 'SAN CRISTOBAL', 179),
(1747, 'SAN HILARION', 179),
(1748, 'SHAMBOYACU', 179),
(1749, 'TINGO DE PONASA', 179),
(1750, 'TRES UNIDOS', 179),
(1751, 'RIOJA', 180),
(1752, 'AWAJUN', 180),
(1753, 'ELIAS SOPLIN VARGAS', 180),
(1754, 'NUEVA CAJAMARCA', 180),
(1755, 'PARDO MIGUEL', 180),
(1756, 'POSIC', 180),
(1757, 'SAN FERNANDO', 180),
(1758, 'YORONGOS', 180),
(1759, 'YURACYACU', 180),
(1760, 'TARAPOTO', 181),
(1761, 'ALBERTO LEVEAU', 181),
(1762, 'CACATACHI', 181),
(1763, 'CHAZUTA', 181),
(1764, 'CHIPURANA', 181),
(1765, 'EL PORVENIR', 181),
(1766, 'HUIMBAYOC', 181),
(1767, 'JUAN GUERRA', 181),
(1768, 'LA BANDA DE SHILCAYO', 181),
(1769, 'MORALES', 181),
(1770, 'PAPAPLAYA', 181),
(1771, 'SAN ANTONIO', 181),
(1772, 'SAUCE', 181),
(1773, 'SHAPAJA', 181),
(1774, 'TOCACHE', 182),
(1775, 'NUEVO PROGRESO', 182),
(1776, 'POLVORA', 182),
(1777, 'SHUNTE', 182),
(1778, 'UCHIZA', 182),
(1779, 'TACNA', 183),
(1780, 'ALTO DE LA ALIANZA', 183),
(1781, 'CALANA', 183),
(1782, 'CIUDAD NUEVA', 183),
(1783, 'INCLAN', 183),
(1784, 'PACHIA', 183),
(1785, 'PALCA', 183),
(1786, 'POCOLLAY', 183),
(1787, 'SAMA', 183),
(1788, 'CORONEL GREGORIO ALBARRACIN LANCHIPA', 183),
(1789, 'CANDARAVE', 184),
(1790, 'CAIRANI', 184),
(1791, 'CAMILACA', 184),
(1792, 'CURIBAYA', 184),
(1793, 'HUANUARA', 184),
(1794, 'QUILAHUANI', 184),
(1795, 'LOCUMBA', 185),
(1796, 'ILABAYA', 185),
(1797, 'ITE', 185),
(1798, 'TARATA', 186),
(1799, 'CHUCATAMANI', 186),
(1800, 'ESTIQUE', 186),
(1801, 'ESTIQUE-PAMPA', 186),
(1802, 'SITAJARA', 186),
(1803, 'SUSAPAYA', 186),
(1804, 'TARUCACHI', 186),
(1805, 'TICACO', 186),
(1806, 'TUMBES', 187),
(1807, 'CORRALES', 187),
(1808, 'LA CRUZ', 187),
(1809, 'PAMPAS DE HOSPITAL', 187),
(1810, 'SAN JACINTO', 187),
(1811, 'SAN JUAN DE LA VIRGEN', 187),
(1812, 'ZORRITOS', 188),
(1813, 'CASITAS', 188),
(1814, 'ZARUMILLA', 189),
(1815, 'AGUAS VERDES', 189),
(1816, 'MATAPALO', 189),
(1817, 'PAPAYAL', 189),
(1818, 'CALLERIA', 190),
(1819, 'CAMPOVERDE', 190),
(1820, 'IPARIA', 190),
(1821, 'MASISEA', 190),
(1822, 'YARINACOCHA', 190),
(1823, 'NUEVA REQUENA', 190),
(1824, 'RAYMONDI', 191),
(1825, 'SEPAHUA', 191),
(1826, 'TAHUANIA', 191),
(1827, 'YURUA', 191),
(1828, 'PADRE ABAD', 192),
(1829, 'IRAZOLA', 192),
(1830, 'CURIMANA', 192),
(1831, 'PURUS', 193);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ubprovincia`
--

CREATE TABLE `ubprovincia` (
  `id` int(5) NOT NULL DEFAULT 0,
  `descripcion` varchar(50) DEFAULT NULL,
  `idDepa` int(5) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ubprovincia`
--

INSERT INTO `ubprovincia` (`id`, `descripcion`, `idDepa`) VALUES
(1, 'CHACHAPOYAS ', 1),
(2, 'BAGUA', 1),
(3, 'BONGARA', 1),
(4, 'CONDORCANQUI', 1),
(5, 'LUYA', 1),
(6, 'RODRIGUEZ DE MENDOZA', 1),
(7, 'UTCUBAMBA', 1),
(8, 'HUARAZ', 2),
(9, 'AIJA', 2),
(10, 'ANTONIO RAYMONDI', 2),
(11, 'ASUNCION', 2),
(12, 'BOLOGNESI', 2),
(13, 'CARHUAZ', 2),
(14, 'CARLOS FERMIN FITZCARRALD', 2),
(15, 'CASMA', 2),
(16, 'CORONGO', 2),
(17, 'HUARI', 2),
(18, 'HUARMEY', 2),
(19, 'HUAYLAS', 2),
(20, 'MARISCAL LUZURIAGA', 2),
(21, 'OCROS', 2),
(22, 'PALLASCA', 2),
(23, 'POMABAMBA', 2),
(24, 'RECUAY', 2),
(25, 'SANTA', 2),
(26, 'SIHUAS', 2),
(27, 'YUNGAY', 2),
(28, 'ABANCAY', 3),
(29, 'ANDAHUAYLAS', 3),
(30, 'ANTABAMBA', 3),
(31, 'AYMARAES', 3),
(32, 'COTABAMBAS', 3),
(33, 'CHINCHEROS', 3),
(34, 'GRAU', 3),
(35, 'AREQUIPA', 4),
(36, 'CAMANA', 4),
(37, 'CARAVELI', 4),
(38, 'CASTILLA', 4),
(39, 'CAYLLOMA', 4),
(40, 'CONDESUYOS', 4),
(41, 'ISLAY', 4),
(42, 'LA UNION', 4),
(43, 'HUAMANGA', 5),
(44, 'CANGALLO', 5),
(45, 'HUANCA SANCOS', 5),
(46, 'HUANTA', 5),
(47, 'LA MAR', 5),
(48, 'LUCANAS', 5),
(49, 'PARINACOCHAS', 5),
(50, 'PAUCAR DEL SARA SARA', 5),
(51, 'SUCRE', 5),
(52, 'VICTOR FAJARDO', 5),
(53, 'VILCAS HUAMAN', 5),
(54, 'CAJAMARCA', 6),
(55, 'CAJABAMBA', 6),
(56, 'CELENDIN', 6),
(57, 'CHOTA ', 6),
(58, 'CONTUMAZA', 6),
(59, 'CUTERVO', 6),
(60, 'HUALGAYOC', 6),
(61, 'JAEN', 6),
(62, 'SAN IGNACIO', 6),
(63, 'SAN MARCOS', 6),
(64, 'SAN PABLO', 6),
(65, 'SANTA CRUZ', 6),
(66, 'CALLAO', 7),
(67, 'CUSCO', 8),
(68, 'ACOMAYO', 8),
(69, 'ANTA', 8),
(70, 'CALCA', 8),
(71, 'CANAS', 8),
(72, 'CANCHIS', 8),
(73, 'CHUMBIVILCAS', 8),
(74, 'ESPINAR', 8),
(75, 'LA CONVENCION', 8),
(76, 'PARURO', 8),
(77, 'PAUCARTAMBO', 8),
(78, 'QUISPICANCHI', 8),
(79, 'URUBAMBA', 8),
(80, 'HUANCAVELICA', 9),
(81, 'ACOBAMBA', 9),
(82, 'ANGARAES', 9),
(83, 'CASTROVIRREYNA', 9),
(84, 'CHURCAMPA', 9),
(85, 'HUAYTARA', 9),
(86, 'TAYACAJA', 9),
(87, 'HUANUCO', 10),
(88, 'AMBO', 10),
(89, 'DOS DE MAYO', 10),
(90, 'HUACAYBAMBA', 10),
(91, 'HUAMALIES', 10),
(92, 'LEONCIO PRADO', 10),
(93, 'MARA&Ntilde;ON', 10),
(94, 'PACHITEA', 10),
(95, 'PUERTO INCA', 10),
(96, 'LAURICOCHA', 10),
(97, 'YAROWILCA', 10),
(98, 'ICA', 11),
(99, 'CHINCHA', 11),
(100, 'NAZCA', 11),
(101, 'PALPA', 11),
(102, 'PISCO', 11),
(103, 'HUANCAYO', 12),
(104, 'CONCEPCION', 12),
(105, 'CHANCHAMAYO', 12),
(106, 'JAUJA', 12),
(107, 'JUNIN', 12),
(108, 'SATIPO', 12),
(109, 'TARMA', 12),
(110, 'YAULI', 12),
(111, 'CHUPACA', 12),
(112, 'TRUJILLO', 13),
(113, 'ASCOPE', 13),
(114, 'BOLIVAR', 13),
(115, 'CHEPEN', 13),
(116, 'JULCAN', 13),
(117, 'OTUZCO', 13),
(118, 'PACASMAYO', 13),
(119, 'PATAZ', 13),
(120, 'SANCHEZ CARRION', 13),
(121, 'SANTIAGO DE CHUCO', 13),
(122, 'GRAN CHIMU', 13),
(123, 'VIRU', 13),
(124, 'CHICLAYO', 14),
(125, 'FERRE&Ntilde;AFE', 14),
(126, 'LAMBAYEQUE', 14),
(127, 'LIMA', 15),
(128, 'BARRANCA', 15),
(129, 'CAJATAMBO', 15),
(130, 'CANTA', 15),
(131, 'CA&Ntilde;ETE', 15),
(132, 'HUARAL', 15),
(133, 'HUAROCHIRI', 15),
(134, 'HUAURA', 15),
(135, 'OYON', 15),
(136, 'YAUYOS', 15),
(137, 'MAYNAS', 16),
(138, 'ALTO AMAZONAS', 16),
(139, 'LORETO', 16),
(140, 'MARISCAL RAMON CASTILLA', 16),
(141, 'REQUENA', 16),
(142, 'UCAYALI', 16),
(143, 'TAMBOPATA', 17),
(144, 'MANU', 17),
(145, 'TAHUAMANU', 17),
(146, 'MARISCAL NIETO', 18),
(147, 'GENERAL SANCHEZ CERRO', 18),
(148, 'ILO', 18),
(149, 'PASCO', 19),
(150, 'DANIEL ALCIDES CARRION', 19),
(151, 'OXAPAMPA', 19),
(152, 'PIURA', 20),
(153, 'AYABACA', 20),
(154, 'HUANCABAMBA', 20),
(155, 'MORROPON', 20),
(156, 'PAITA', 20),
(157, 'SULLANA', 20),
(158, 'TALARA', 20),
(159, 'SECHURA', 20),
(160, 'PUNO', 21),
(161, 'AZANGARO', 21),
(162, 'CARABAYA', 21),
(163, 'CHUCUITO', 21),
(164, 'EL COLLAO', 21),
(165, 'HUANCANE', 21),
(166, 'LAMPA', 21),
(167, 'MELGAR', 21),
(168, 'MOHO', 21),
(169, 'SAN ANTONIO DE PUTINA', 21),
(170, 'SAN ROMAN', 21),
(171, 'SANDIA', 21),
(172, 'YUNGUYO', 21),
(173, 'MOYOBAMBA', 22),
(174, 'BELLAVISTA', 22),
(175, 'EL DORADO', 22),
(176, 'HUALLAGA', 22),
(177, 'LAMAS', 22),
(178, 'MARISCAL CACERES', 22),
(179, 'PICOTA', 22),
(180, 'RIOJA', 22),
(181, 'SAN MARTIN', 22),
(182, 'TOCACHE', 22),
(183, 'TACNA', 23),
(184, 'CANDARAVE', 23),
(185, 'JORGE BASADRE', 23),
(186, 'TARATA', 23),
(187, 'TUMBES', 24),
(188, 'CONTRALMIRANTE VILLAR', 24),
(189, 'ZARUMILLA', 24),
(190, 'CORONEL PORTILLO', 25),
(191, 'ATALAYA', 25),
(192, 'PADRE ABAD', 25),
(193, 'PURUS', 25);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `ID` int(11) NOT NULL,
  `USUARIO` varchar(100) NOT NULL,
  `PASSWORD` varchar(100) NOT NULL,
  `IDPERSONA` int(11) NOT NULL,
  `ESTADO` varchar(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `verificacion_persona`
--

DROP TABLE IF EXISTS `perfil`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `perfil` (
  `idperfil` int NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(45) DEFAULT NULL,
  `estado` char(1) DEFAULT NULL,
  PRIMARY KEY (`idperfil`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;


DROP TABLE IF EXISTS `detalle_usuario_perfil`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalle_usuario_perfil` (
  `idusuario` int NOT NULL,
  `idperfil` int NOT NULL,
  `estado` char(1) DEFAULT NULL,
  KEY `fk_detu_usuario_idx` (`idusuario`),
  KEY `fk_detu_perfil_idx` (`idperfil`),
  CONSTRAINT `fk_detu_perfil` FOREIGN KEY (`idperfil`) REFERENCES `perfil` (`idperfil`),
  CONSTRAINT `fk_detu_usuario` FOREIGN KEY (`idusuario`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;


CREATE TABLE `verificacion_persona` (
  `idPersona` int(11) NOT NULL,
  `idTipVer` int(11) NOT NULL,
  `estado` char(1) NOT NULL COMMENT '0=Pendiente validar/1=Validado	',
  `keyMd5` text DEFAULT NULL,
  `usuarioSol` int(11) NOT NULL,
  `fechaModificacion` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `alumno`
--
ALTER TABLE `alumno`
  ADD KEY `FK_ESTUDIANTE_PER` (`IDESTUDIANTE`);

--
-- Indices de la tabla `ano_escolar`
--
ALTER TABLE `ano_escolar`
  ADD PRIMARY KEY (`IDANO_ESCOLAR`);

--
-- Indices de la tabla `ano_escolar_colegio`
--
ALTER TABLE `ano_escolar_colegio`
  ADD PRIMARY KEY (`IDANOESCOLARCOL`);

--
-- Indices de la tabla `apoderado`
--
ALTER TABLE `apoderado`
  ADD KEY `FK_APO_PERSONA` (`IDAPODERADO`);

--
-- Indices de la tabla `aulas`
--
ALTER TABLE `aulas`
  ADD PRIMARY KEY (`idAula`),
  ADD KEY `fk_aulas_colegios` (`idColegio`);

--
-- Indices de la tabla `categoria_cursos`
--
ALTER TABLE `categoria_cursos`
  ADD PRIMARY KEY (`idCategoria`),
  ADD KEY `fk_categoria_colegio` (`idColegio`);

--
-- Indices de la tabla `colegio`
--
ALTER TABLE `colegio`
  ADD PRIMARY KEY (`IDCOLEGIO`),
  ADD KEY `fk_PERSONA_COLEGIO` (`IDREPRESENTANTE`);

--
-- Indices de la tabla `colegio_curso`
--
ALTER TABLE `colegio_curso`
  ADD UNIQUE KEY `idCURSO_UNIQUE` (`IDCURSO`);

--
-- Indices de la tabla `colegio_profesor`
--
ALTER TABLE `colegio_profesor`
  ADD PRIMARY KEY (`IDCOLEGIO`,`IDPROFESOR`,`ESTADO`);

--
-- Indices de la tabla `confi_tipo_planiamiento`
--
ALTER TABLE `confi_tipo_planiamiento`
  ADD PRIMARY KEY (`idTipPla`);

--
-- Indices de la tabla `cursos`
--
ALTER TABLE `cursos`
  ADD PRIMARY KEY (`IDCURSO`),
  ADD UNIQUE KEY `IDENTIFICADOR_UNIQUE` (`IDENTIFICADOR`),
  ADD KEY `fk_cursos_tipplan` (`idTipPla`),
  ADD KEY `fk_CURSOS_CAT` (`idCategoria`);

--
-- Indices de la tabla `detalle_apoderado_alumno`
--
ALTER TABLE `detalle_apoderado_alumno`
  ADD KEY `FK_DET_ALUMNO` (`IDALUMNO`),
  ADD KEY `FK_DET_APODERADO` (`IDAPODERADO`),
  ADD KEY `FK_DETAPO_TIPREL` (`IDTIPPAR`);

--
-- Indices de la tabla `detalle_aula_seccion`
--
ALTER TABLE `detalle_aula_seccion`
  ADD KEY `FK_detaula_aula` (`idAula`),
  ADD KEY `FK_detaula_col` (`idColegio`),
  ADD KEY `FK_detaula_seccion` (`idSeccion`);

--
-- Indices de la tabla `detalle_colegio_alumno`
--
ALTER TABLE `detalle_colegio_alumno`
  ADD KEY `FK_DETC_COL` (`IDCOLEGIO`),
  ADD KEY `FK_DETC_ALU` (`IDALUMNO`);

--
-- Indices de la tabla `detalle_contenido_curso`
--
ALTER TABLE `detalle_contenido_curso`
  ADD PRIMARY KEY (`idDetCon`),
  ADD KEY `fk_detalle_curso` (`idCurso`);

--
-- Indices de la tabla `detalle_grado_seccion`
--
ALTER TABLE `detalle_grado_seccion`
  ADD KEY `detgrado_grado` (`idGrado`),
  ADD KEY `fk_detgrado_seccion` (`idSeccion`),
  ADD KEY `fk_detgrado_plan` (`idPeriodoAnoEscolar`);

--
-- Indices de la tabla `detalle_plan_grados`
--
ALTER TABLE `detalle_plan_grados`
  ADD KEY `fk_detplan_plan` (`idPlanEscolar`),
  ADD KEY `fk_detplan_grado` (`idGrado`);

--
-- Indices de la tabla `direccion_persona`
--
ALTER TABLE `direccion_persona`
  ADD PRIMARY KEY (`IDDIRECCION`),
  ADD KEY `FK_DIR_PERSONA` (`IDPERSONA`),
  ADD KEY `FK_DIR_TIPDIR` (`TIPODIRECCION`);

--
-- Indices de la tabla `grados_colegio`
--
ALTER TABLE `grados_colegio`
  ADD PRIMARY KEY (`idGrado`);

--
-- Indices de la tabla `grupo`
--
ALTER TABLE `grupo`
  ADD PRIMARY KEY (`idGrupo`),
  ADD KEY `FK_grupo_col` (`idColegio`);

--
-- Indices de la tabla `grupo_usuario`
--
ALTER TABLE `grupo_usuario`
  ADD KEY `FK_grupo_usuario` (`idUsuario`),
  ADD KEY `FK_grupo_grupo` (`idGrupo`),
  ADD KEY `FK_grupo_colegio` (`idColegio`);

--
-- Indices de la tabla `matricula`
--
ALTER TABLE `matricula`
  ADD PRIMARY KEY (`idMatricula`),
  ADD UNIQUE KEY `identificador` (`identificador`),
  ADD KEY `FK_ano_esc_col` (`idPerAca`),
  ADD KEY `FK_mat_est` (`idAlumno`),
  ADD KEY `FK_mat_gra` (`grado`),
  ADD KEY `FK_mat_sec` (`seccion`);

--
-- Indices de la tabla `menu`
--
ALTER TABLE `menu`
  ADD PRIMARY KEY (`idMenu`),
  ADD KEY `FK_menu_tip` (`idTipoMenu`);

--
-- Indices de la tabla `persona`
--
ALTER TABLE `persona`
  ADD PRIMARY KEY (`IDPERSONA`),
  ADD UNIQUE KEY `tipo_numero_doc` (`TIPODOCUMENTO`,`NUMERODOCUMENTO`);

--
-- Indices de la tabla `plana_administrativa`
--
ALTER TABLE `plana_administrativa`
  ADD KEY `FK_plana_persona` (`idPlanaAdm`),
  ADD KEY `FK_plana_colegio` (`idColegio`);

--
-- Indices de la tabla `plan_curricular`
--
ALTER TABLE `plan_curricular`
  ADD PRIMARY KEY (`idPlanCurricular`),
  ADD KEY `fk_plan_colegio` (`idColegio`),
  ADD KEY `fk_plan_ano_aca` (`idAnoEscolarAca`);

--
-- Indices de la tabla `privilegio`
--
ALTER TABLE `privilegio`
  ADD PRIMARY KEY (`idPrivilegio`),
  ADD KEY `FK_privilegio_menu` (`idMenu`);

--
-- Indices de la tabla `privilegio_grupo`
--
ALTER TABLE `privilegio_grupo`
  ADD KEY `FK_privilegio_grupo` (`idGrupo`),
  ADD KEY `FK_priv_priv` (`idPrivilegio`),
  ADD KEY `FK_Priv_colegio` (`idColegio`);

--
-- Indices de la tabla `proceso_colegio`
--
ALTER TABLE `proceso_colegio`
  ADD PRIMARY KEY (`idProCol`);

--
-- Indices de la tabla `programacion_seccion_curso`
--
ALTER TABLE `programacion_seccion_curso`
  ADD PRIMARY KEY (`idProgSecCur`),
  ADD KEY `FK_prog_seccion` (`idSeccion`),
  ADD KEY `fk_prog_cursos` (`idCurso`);

--
-- Indices de la tabla `representante`
--
ALTER TABLE `representante`
  ADD KEY `fk_PERSONA_REP` (`IDPERSONA`);

--
-- Indices de la tabla `secciones`
--
ALTER TABLE `secciones`
  ADD PRIMARY KEY (`idSeccion`);

--
-- Indices de la tabla `tipo_contenido`
--
ALTER TABLE `tipo_contenido`
  ADD PRIMARY KEY (`idTipCon`);

--
-- Indices de la tabla `tipo_direccion`
--
ALTER TABLE `tipo_direccion`
  ADD PRIMARY KEY (`IDTIPDIR`);

--
-- Indices de la tabla `tipo_menu`
--
ALTER TABLE `tipo_menu`
  ADD PRIMARY KEY (`idTipoMenu`);

--
-- Indices de la tabla `tipo_parentesco`
--
ALTER TABLE `tipo_parentesco`
  ADD PRIMARY KEY (`IDTIPPAR`);

--
-- Indices de la tabla `tipo_periodo_academico`
--
ALTER TABLE `tipo_periodo_academico`
  ADD PRIMARY KEY (`idTipoPeriodo`);

--
-- Indices de la tabla `tipo_situacion_mat`
--
ALTER TABLE `tipo_situacion_mat`
  ADD PRIMARY KEY (`idTipSit`);

--
-- Indices de la tabla `tip_verificacion_acceso`
--
ALTER TABLE `tip_verificacion_acceso`
  ADD PRIMARY KEY (`idTipVer`);

--
-- Indices de la tabla `ubdepartamento`
--
ALTER TABLE `ubdepartamento`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `ubdistrito`
--
ALTER TABLE `ubdistrito`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `ubprovincia`
--
ALTER TABLE `ubprovincia`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `u_ID_PERSONA` (`IDPERSONA`),
  ADD UNIQUE KEY `UC_User` (`USUARIO`),
  ADD KEY `FK_USUARIO_PERSONA` (`IDPERSONA`);

--
-- Indices de la tabla `verificacion_persona`
--
ALTER TABLE `verificacion_persona`
  ADD KEY `FK_VER_PER` (`idPersona`),
  ADD KEY `FK_VER_TIPVER` (`idTipVer`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `ano_escolar`
--
ALTER TABLE `ano_escolar`
  MODIFY `IDANO_ESCOLAR` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `ano_escolar_colegio`
--
ALTER TABLE `ano_escolar_colegio`
  MODIFY `IDANOESCOLARCOL` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `aulas`
--
ALTER TABLE `aulas`
  MODIFY `idAula` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `categoria_cursos`
--
ALTER TABLE `categoria_cursos`
  MODIFY `idCategoria` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `colegio`
--
ALTER TABLE `colegio`
  MODIFY `IDCOLEGIO` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `confi_tipo_planiamiento`
--
ALTER TABLE `confi_tipo_planiamiento`
  MODIFY `idTipPla` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `cursos`
--
ALTER TABLE `cursos`
  MODIFY `IDCURSO` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `detalle_contenido_curso`
--
ALTER TABLE `detalle_contenido_curso`
  MODIFY `idDetCon` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `direccion_persona`
--
ALTER TABLE `direccion_persona`
  MODIFY `IDDIRECCION` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `grados_colegio`
--
ALTER TABLE `grados_colegio`
  MODIFY `idGrado` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `grupo`
--
ALTER TABLE `grupo`
  MODIFY `idGrupo` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `matricula`
--
ALTER TABLE `matricula`
  MODIFY `idMatricula` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `menu`
--
ALTER TABLE `menu`
  MODIFY `idMenu` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT de la tabla `persona`
--
ALTER TABLE `persona`
  MODIFY `IDPERSONA` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `plan_curricular`
--
ALTER TABLE `plan_curricular`
  MODIFY `idPlanCurricular` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `privilegio`
--
ALTER TABLE `privilegio`
  MODIFY `idPrivilegio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT de la tabla `proceso_colegio`
--
ALTER TABLE `proceso_colegio`
  MODIFY `idProCol` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `programacion_seccion_curso`
--
ALTER TABLE `programacion_seccion_curso`
  MODIFY `idProgSecCur` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `secciones`
--
ALTER TABLE `secciones`
  MODIFY `idSeccion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tipo_contenido`
--
ALTER TABLE `tipo_contenido`
  MODIFY `idTipCon` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `tipo_direccion`
--
ALTER TABLE `tipo_direccion`
  MODIFY `IDTIPDIR` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `tipo_menu`
--
ALTER TABLE `tipo_menu`
  MODIFY `idTipoMenu` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tipo_parentesco`
--
ALTER TABLE `tipo_parentesco`
  MODIFY `IDTIPPAR` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `tipo_periodo_academico`
--
ALTER TABLE `tipo_periodo_academico`
  MODIFY `idTipoPeriodo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `alumno`
--
ALTER TABLE `alumno`
  ADD CONSTRAINT `FK_ESTUDIANTE_PER` FOREIGN KEY (`IDESTUDIANTE`) REFERENCES `persona` (`IDPERSONA`);

--
-- Filtros para la tabla `apoderado`
--
ALTER TABLE `apoderado`
  ADD CONSTRAINT `FK_APO_PERSONA` FOREIGN KEY (`IDAPODERADO`) REFERENCES `persona` (`IDPERSONA`);

--
-- Filtros para la tabla `aulas`
--
ALTER TABLE `aulas`
  ADD CONSTRAINT `fk_aulas_colegios` FOREIGN KEY (`idColegio`) REFERENCES `colegio` (`IDCOLEGIO`);

--
-- Filtros para la tabla `categoria_cursos`
--
ALTER TABLE `categoria_cursos`
  ADD CONSTRAINT `fk_categoria_colegio` FOREIGN KEY (`idColegio`) REFERENCES `colegio` (`IDCOLEGIO`);

--
-- Filtros para la tabla `colegio`
--
ALTER TABLE `colegio`
  ADD CONSTRAINT `fk_PERSONA_COLEGIO` FOREIGN KEY (`IDREPRESENTANTE`) REFERENCES `persona` (`IDPERSONA`);

--
-- Filtros para la tabla `colegio_curso`
--
ALTER TABLE `colegio_curso`
  ADD CONSTRAINT `fk_colegiocurso_curso` FOREIGN KEY (`IDCURSO`) REFERENCES `cursos` (`IDCURSO`);

--
-- Filtros para la tabla `cursos`
--
ALTER TABLE `cursos`
  ADD CONSTRAINT `fk_CURSOS_CAT` FOREIGN KEY (`idCategoria`) REFERENCES `categoria_cursos` (`idCategoria`),
  ADD CONSTRAINT `fk_cursos_tipplan` FOREIGN KEY (`idTipPla`) REFERENCES `confi_tipo_planiamiento` (`idTipPla`);

--
-- Filtros para la tabla `detalle_apoderado_alumno`
--
ALTER TABLE `detalle_apoderado_alumno`
  ADD CONSTRAINT `FK_DETAPO_TIPREL` FOREIGN KEY (`IDTIPPAR`) REFERENCES `tipo_parentesco` (`IDTIPPAR`),
  ADD CONSTRAINT `FK_DET_ALUMNO` FOREIGN KEY (`IDALUMNO`) REFERENCES `alumno` (`IDESTUDIANTE`),
  ADD CONSTRAINT `FK_DET_APODERADO` FOREIGN KEY (`IDAPODERADO`) REFERENCES `apoderado` (`IDAPODERADO`);

--
-- Filtros para la tabla `detalle_aula_seccion`
--
ALTER TABLE `detalle_aula_seccion`
  ADD CONSTRAINT `FK_detaula_aula` FOREIGN KEY (`idAula`) REFERENCES `aulas` (`idAula`),
  ADD CONSTRAINT `FK_detaula_col` FOREIGN KEY (`idColegio`) REFERENCES `colegio` (`IDCOLEGIO`),
  ADD CONSTRAINT `FK_detaula_seccion` FOREIGN KEY (`idSeccion`) REFERENCES `secciones` (`idSeccion`);

--
-- Filtros para la tabla `detalle_colegio_alumno`
--
ALTER TABLE `detalle_colegio_alumno`
  ADD CONSTRAINT `FK_DETC_ALU` FOREIGN KEY (`IDALUMNO`) REFERENCES `alumno` (`IDESTUDIANTE`),
  ADD CONSTRAINT `FK_DETC_COL` FOREIGN KEY (`IDCOLEGIO`) REFERENCES `colegio` (`IDCOLEGIO`);

--
-- Filtros para la tabla `detalle_contenido_curso`
--
ALTER TABLE `detalle_contenido_curso`
  ADD CONSTRAINT `fk_detalle_curso` FOREIGN KEY (`idCurso`) REFERENCES `cursos` (`IDCURSO`);

--
-- Filtros para la tabla `detalle_grado_seccion`
--
ALTER TABLE `detalle_grado_seccion`
  ADD CONSTRAINT `detgrado_grado` FOREIGN KEY (`idGrado`) REFERENCES `grados_colegio` (`idGrado`),
  ADD CONSTRAINT `fk_detgrado_plan` FOREIGN KEY (`idPeriodoAnoEscolar`) REFERENCES `plan_curricular` (`idPlanCurricular`),
  ADD CONSTRAINT `fk_detgrado_seccion` FOREIGN KEY (`idSeccion`) REFERENCES `secciones` (`idSeccion`);

--
-- Filtros para la tabla `detalle_plan_grados`
--
ALTER TABLE `detalle_plan_grados`
  ADD CONSTRAINT `fk_detplan_grado` FOREIGN KEY (`idGrado`) REFERENCES `grados_colegio` (`idGrado`),
  ADD CONSTRAINT `fk_detplan_plan` FOREIGN KEY (`idPlanEscolar`) REFERENCES `plan_curricular` (`idPlanCurricular`);

--
-- Filtros para la tabla `direccion_persona`
--
ALTER TABLE `direccion_persona`
  ADD CONSTRAINT `FK_DIR_PERSONA` FOREIGN KEY (`IDPERSONA`) REFERENCES `persona` (`IDPERSONA`),
  ADD CONSTRAINT `FK_DIR_TIPDIR` FOREIGN KEY (`TIPODIRECCION`) REFERENCES `tipo_direccion` (`IDTIPDIR`);

--
-- Filtros para la tabla `grupo`
--
ALTER TABLE `grupo`
  ADD CONSTRAINT `FK_grupo_col` FOREIGN KEY (`idColegio`) REFERENCES `colegio` (`IDCOLEGIO`);

--
-- Filtros para la tabla `grupo_usuario`
--
ALTER TABLE `grupo_usuario`
  ADD CONSTRAINT `FK_grupo_colegio` FOREIGN KEY (`idColegio`) REFERENCES `colegio` (`IDCOLEGIO`),
  ADD CONSTRAINT `FK_grupo_grupo` FOREIGN KEY (`idGrupo`) REFERENCES `grupo` (`idGrupo`),
  ADD CONSTRAINT `FK_grupo_usuario` FOREIGN KEY (`idUsuario`) REFERENCES `usuarios` (`ID`);

--
-- Filtros para la tabla `matricula`
--
ALTER TABLE `matricula`
  ADD CONSTRAINT `FK_ano_esc_col` FOREIGN KEY (`idPerAca`) REFERENCES `ano_escolar_colegio` (`IDANOESCOLARCOL`),
  ADD CONSTRAINT `FK_mat_est` FOREIGN KEY (`idAlumno`) REFERENCES `alumno` (`IDESTUDIANTE`),
  ADD CONSTRAINT `FK_mat_gra` FOREIGN KEY (`grado`) REFERENCES `grados_colegio` (`idGrado`),
  ADD CONSTRAINT `FK_mat_sec` FOREIGN KEY (`seccion`) REFERENCES `secciones` (`idSeccion`);

--
-- Filtros para la tabla `menu`
--
ALTER TABLE `menu`
  ADD CONSTRAINT `FK_menu_tip` FOREIGN KEY (`idTipoMenu`) REFERENCES `tipo_menu` (`idTipoMenu`);

--
-- Filtros para la tabla `plana_administrativa`
--
ALTER TABLE `plana_administrativa`
  ADD CONSTRAINT `FK_plana_colegio` FOREIGN KEY (`idColegio`) REFERENCES `colegio` (`IDCOLEGIO`),
  ADD CONSTRAINT `FK_plana_persona` FOREIGN KEY (`idPlanaAdm`) REFERENCES `persona` (`IDPERSONA`);

--
-- Filtros para la tabla `plan_curricular`
--
ALTER TABLE `plan_curricular`
  ADD CONSTRAINT `fk_plan_ano_aca` FOREIGN KEY (`idAnoEscolarAca`) REFERENCES `ano_escolar_colegio` (`IDANOESCOLARCOL`),
  ADD CONSTRAINT `fk_plan_colegio` FOREIGN KEY (`idColegio`) REFERENCES `colegio` (`IDCOLEGIO`);

--
-- Filtros para la tabla `privilegio`
--
ALTER TABLE `privilegio`
  ADD CONSTRAINT `FK_privilegio_menu` FOREIGN KEY (`idMenu`) REFERENCES `menu` (`idMenu`);

--
-- Filtros para la tabla `privilegio_grupo`
--
ALTER TABLE `privilegio_grupo`
  ADD CONSTRAINT `FK_Priv_colegio` FOREIGN KEY (`idColegio`) REFERENCES `colegio` (`IDCOLEGIO`),
  ADD CONSTRAINT `FK_priv_priv` FOREIGN KEY (`idPrivilegio`) REFERENCES `privilegio` (`idPrivilegio`),
  ADD CONSTRAINT `FK_privilegio_grupo` FOREIGN KEY (`idGrupo`) REFERENCES `grupo` (`idGrupo`);

--
-- Filtros para la tabla `programacion_seccion_curso`
--
ALTER TABLE `programacion_seccion_curso`
  ADD CONSTRAINT `FK_prog_seccion` FOREIGN KEY (`idSeccion`) REFERENCES `secciones` (`idSeccion`),
  ADD CONSTRAINT `fk_prog_cursos` FOREIGN KEY (`idCurso`) REFERENCES `cursos` (`IDCURSO`);

--
-- Filtros para la tabla `representante`
--
ALTER TABLE `representante`
  ADD CONSTRAINT `fk_PERSONA_REP` FOREIGN KEY (`IDPERSONA`) REFERENCES `persona` (`IDPERSONA`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `FK_USUARIO_PERSONA` FOREIGN KEY (`IDPERSONA`) REFERENCES `persona` (`IDPERSONA`);

--
-- Filtros para la tabla `verificacion_persona`
--
ALTER TABLE `verificacion_persona`
  ADD CONSTRAINT `FK_VER_PER` FOREIGN KEY (`idPersona`) REFERENCES `persona` (`IDPERSONA`),
  ADD CONSTRAINT `FK_VER_TIPVER` FOREIGN KEY (`idTipVer`) REFERENCES `tip_verificacion_acceso` (`idTipVer`);

--
-- Filtros para la tabla `ubicacion`
--
ALTER TABLE `ubicacion`
  ADD CONSTRAINT `FK_UBI_COL` FOREIGN KEY (`idcolegio`) REFERENCES `colegio` (`IDCOLEGIO`);

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;