-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 30-01-2025 a las 15:42:54
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `reactivos`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ims_brand`
--

CREATE TABLE `ims_brand` (
  `id` int(11) NOT NULL,
  `categoryid` int(11) NOT NULL,
  `bname` varchar(250) NOT NULL,
  `status` enum('active','inactive') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `ims_brand`
--

INSERT INTO `ims_brand` (`id`, `categoryid`, `bname`, `status`) VALUES
(1, 1, 'Sigma-Aldrich', 'active'),
(2, 2, 'Merck', 'active'),
(3, 3, 'Thermo Scientific', 'active'),
(4, 4, 'VWR International', 'active'),
(5, 5, 'Avantor', 'active'),
(7, 0, 'mofito', 'active');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ims_category`
--

CREATE TABLE `ims_category` (
  `categoryid` int(11) NOT NULL,
  `name` varchar(250) NOT NULL,
  `status` enum('active','inactive') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `ims_category`
--

INSERT INTO `ims_category` (`categoryid`, `name`, `status`) VALUES
(1, 'Ácido', 'active'),
(2, 'Corrosivo', 'active'),
(3, 'Reactivo Blando', 'active'),
(4, 'Solvente', 'active'),
(5, 'Compuesto Orgánicos', 'active');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ims_customer`
--

CREATE TABLE `ims_customer` (
  `id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `address` text NOT NULL,
  `mobile` int(255) NOT NULL,
  `balance` double(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `ims_customer`
--

INSERT INTO `ims_customer` (`id`, `name`, `address`, `mobile`, `balance`) VALUES
(1, 'Dr. Elena Rodriguez', 'Director de Investigación', 2147483647, 5000000.00),
(2, 'Ing. Carlos Mendoza', 'Jefe de Laboratorio', 2147483647, 3750000.00),
(3, 'Dra. Mariana Sánchez', 'Química Analítica Principal', 2147483647, 4250000.00),
(4, 'Dr. Juan Pérez', 'Investigador Senior', 2147483647, 3200000.00),
(5, 'Lic. Ana Martínez', 'Coordinadora de Química', 2147483647, 2800000.00),
(6, 'Dr. Luis García', 'Científico Asociado', 2147483647, 4500000.00),
(7, 'Ing. Sofía Torres', 'Supervisora de Desarrollo', 2147483647, 3600000.00),
(8, 'Dr. Ricardo Núñez', 'Químico Forense', 2147483647, 4100000.00),
(9, 'Dra. Laura Jiménez', 'Investigadora de Materiales', 2147483647, 3900000.00),
(10, 'Ing. David Ramírez', 'Técnico de Laboratorio Senior', 2147483647, 2600000.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ims_order`
--

CREATE TABLE `ims_order` (
  `order_id` int(11) NOT NULL,
  `product_id` varchar(255) NOT NULL,
  `total_shipped` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `order_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `ims_order`
--

INSERT INTO `ims_order` (`order_id`, `product_id`, `total_shipped`, `customer_id`, `order_date`) VALUES
(1, '1', 7, 2, '2024-09-27 01:10:07'),
(2, '2', 14, 6, '2024-09-27 01:10:07'),
(3, '3', 10, 5, '2024-12-29 01:10:07'),
(4, '4', 19, 5, '2024-11-01 01:10:07'),
(5, '5', 14, 3, '2024-11-24 01:10:07'),
(6, '6', 12, 1, '2024-10-07 01:10:07'),
(7, '7', 12, 2, '2024-12-05 01:10:07'),
(8, '8', 11, 1, '2024-10-07 01:10:07'),
(9, '9', 13, 6, '2024-08-16 01:10:07'),
(10, '10', 11, 2, '2025-01-03 01:10:07'),
(11, '11', 19, 4, '2024-07-23 01:10:07'),
(12, '12', 17, 4, '2024-12-25 01:10:07'),
(13, '13', 12, 5, '2024-10-12 01:10:07'),
(14, '14', 6, 9, '2024-10-23 01:10:07'),
(15, '15', 15, 2, '2024-10-05 01:10:07'),
(16, '16', 8, 3, '2024-12-01 01:10:07'),
(17, '17', 8, 1, '2024-11-04 01:10:07'),
(18, '18', 14, 2, '2024-07-29 01:10:07'),
(19, '19', 2, 7, '2024-12-17 01:10:07'),
(20, '20', 15, 1, '2024-12-13 01:10:07'),
(21, '21', 15, 10, '2024-08-21 01:10:07'),
(22, '22', 2, 1, '2024-07-29 01:10:07'),
(23, '23', 12, 10, '2024-12-19 01:10:07'),
(24, '24', 17, 7, '2025-01-13 01:10:07'),
(25, '25', 19, 7, '2024-11-03 01:10:07'),
(26, '26', 2, 2, '2024-09-18 01:10:07'),
(27, '27', 15, 8, '2024-09-16 01:10:07'),
(28, '28', 20, 9, '2024-10-25 01:10:07'),
(29, '29', 13, 7, '2024-09-19 01:10:07'),
(30, '30', 4, 9, '2024-08-26 01:10:07'),
(31, '31', 8, 5, '2025-01-04 01:10:07'),
(32, '32', 20, 9, '2024-12-17 01:10:07'),
(33, '33', 6, 9, '2024-09-21 01:10:07'),
(34, '34', 11, 7, '2024-09-23 01:10:07'),
(35, '35', 5, 3, '2024-09-08 01:10:07'),
(36, '36', 15, 5, '2024-07-23 01:10:07'),
(37, '37', 12, 1, '2024-11-22 01:10:07'),
(38, '38', 9, 3, '2024-12-27 01:10:07'),
(39, '39', 14, 10, '2024-07-23 01:10:07'),
(40, '40', 18, 6, '2024-08-06 01:10:07'),
(41, '41', 19, 10, '2024-12-30 01:10:07'),
(42, '42', 10, 2, '2024-11-11 01:10:07'),
(43, '43', 6, 4, '2024-08-13 01:10:07'),
(44, '44', 5, 7, '2024-09-12 01:10:07'),
(45, '45', 8, 9, '2024-07-26 01:10:07'),
(46, '46', 7, 8, '2024-08-22 01:10:07'),
(47, '47', 15, 4, '2024-10-27 01:10:07'),
(48, '48', 4, 6, '2024-12-20 01:10:07'),
(49, '49', 3, 2, '2024-11-10 01:10:07'),
(50, '50', 8, 8, '2024-09-04 01:10:07'),
(51, '51', 8, 6, '2024-08-07 01:10:07'),
(52, '52', 13, 6, '2024-07-22 01:10:07'),
(53, '53', 3, 8, '2024-12-11 01:10:07'),
(54, '54', 16, 5, '2024-09-05 01:10:07'),
(55, '55', 8, 7, '2024-12-30 01:10:07'),
(56, '56', 10, 3, '2024-09-16 01:10:07'),
(57, '57', 13, 2, '2024-08-22 01:10:07'),
(58, '58', 13, 7, '2024-11-12 01:10:07'),
(59, '59', 17, 1, '2024-08-01 01:10:07'),
(60, '60', 8, 1, '2025-01-06 01:10:07'),
(61, '61', 4, 7, '2024-09-14 01:10:07'),
(62, '62', 10, 5, '2024-08-30 01:10:07'),
(63, '63', 9, 10, '2024-11-15 01:10:07'),
(64, '64', 18, 4, '2025-01-01 01:10:07'),
(65, '65', 7, 6, '2024-10-17 01:10:07'),
(66, '66', 19, 3, '2024-10-20 01:10:07'),
(67, '67', 12, 6, '2024-07-26 01:10:07'),
(68, '68', 3, 7, '2024-12-21 01:10:07'),
(69, '69', 12, 5, '2024-09-18 01:10:07'),
(70, '70', 18, 3, '2024-08-03 01:10:07'),
(71, '71', 14, 6, '2024-08-18 01:10:07'),
(72, '72', 9, 8, '2024-10-15 01:10:07'),
(73, '73', 5, 5, '2024-08-06 01:10:07'),
(74, '74', 20, 2, '2024-09-16 01:10:07'),
(75, '75', 20, 10, '2024-07-20 01:10:07'),
(76, '76', 20, 9, '2024-12-07 01:10:07'),
(77, '77', 12, 4, '2024-07-24 01:10:07'),
(78, '78', 16, 10, '2024-11-21 01:10:07'),
(79, '79', 15, 8, '2024-08-30 01:10:07'),
(80, '80', 9, 9, '2024-08-29 01:10:07'),
(81, '81', 9, 8, '2024-10-08 01:10:07'),
(82, '82', 10, 7, '2024-07-29 01:10:07'),
(83, '83', 14, 7, '2024-12-23 01:10:07'),
(84, '84', 14, 1, '2024-11-22 01:10:07'),
(85, '85', 5, 4, '2025-01-09 01:10:07'),
(86, '86', 2, 3, '2025-01-08 01:10:07'),
(87, '87', 9, 1, '2024-08-07 01:10:07'),
(88, '88', 7, 1, '2025-01-04 01:10:07'),
(89, '89', 5, 10, '2024-12-14 01:10:07'),
(90, '90', 19, 3, '2024-11-30 01:10:07'),
(91, '91', 12, 2, '2024-07-18 01:10:07'),
(92, '92', 11, 8, '2024-12-19 01:10:07'),
(93, '93', 9, 8, '2024-10-31 01:10:07'),
(94, '94', 17, 10, '2024-11-21 01:10:07'),
(95, '95', 12, 1, '2024-10-13 01:10:07'),
(96, '96', 8, 5, '2024-08-01 01:10:07'),
(97, '97', 7, 10, '2024-09-14 01:10:07'),
(98, '98', 12, 8, '2024-12-28 01:10:07'),
(99, '99', 4, 8, '2024-07-19 01:10:07'),
(100, '100', 17, 1, '2024-08-23 01:10:07'),
(101, '101', 18, 10, '2025-01-07 01:10:07'),
(102, '102', 9, 10, '2024-10-11 01:10:07'),
(103, '103', 16, 3, '2025-01-08 01:10:07'),
(104, '104', 8, 8, '2024-10-27 01:10:07'),
(105, '105', 2, 1, '2024-12-14 01:10:07'),
(106, '106', 13, 5, '2024-09-11 01:10:07'),
(107, '107', 20, 8, '2024-09-16 01:10:07'),
(108, '108', 5, 1, '2024-09-16 01:10:07'),
(109, '109', 3, 7, '2024-08-01 01:10:07'),
(110, '110', 13, 4, '2024-09-12 01:10:07'),
(111, '111', 11, 6, '2024-11-30 01:10:07'),
(112, '112', 11, 10, '2024-12-21 01:10:07'),
(113, '113', 17, 7, '2024-07-23 01:10:07'),
(114, '114', 17, 2, '2024-12-22 01:10:07'),
(115, '115', 6, 2, '2024-09-12 01:10:07'),
(116, '116', 2, 4, '2024-09-09 01:10:07'),
(117, '117', 7, 6, '2024-09-29 01:10:07'),
(118, '118', 9, 4, '2024-11-27 01:10:07'),
(119, '119', 9, 4, '2024-11-08 01:10:07'),
(120, '120', 18, 3, '2024-10-13 01:10:07'),
(121, '121', 19, 10, '2024-12-11 01:10:07'),
(122, '122', 20, 4, '2024-07-31 01:10:07'),
(123, '123', 10, 7, '2025-01-13 01:10:07'),
(124, '124', 19, 6, '2024-12-17 01:10:07'),
(125, '125', 1, 7, '2025-01-10 01:10:07'),
(126, '126', 6, 3, '2024-11-17 01:10:07'),
(127, '127', 20, 8, '2024-12-24 01:10:07'),
(128, '128', 4, 7, '2024-10-12 01:10:07'),
(129, '129', 15, 2, '2024-09-20 01:10:07'),
(130, '130', 14, 5, '2024-11-23 01:10:07'),
(131, '131', 1, 4, '2024-09-14 01:10:07'),
(132, '132', 6, 5, '2024-11-06 01:10:07'),
(133, '133', 11, 6, '2024-12-10 01:10:07'),
(134, '134', 6, 8, '2024-08-07 01:10:07'),
(135, '135', 5, 6, '2024-08-04 01:10:07'),
(136, '136', 19, 1, '2024-11-14 01:10:07'),
(137, '137', 12, 9, '2024-10-21 01:10:07'),
(138, '138', 17, 9, '2024-10-05 01:10:07'),
(139, '139', 7, 10, '2024-07-19 01:10:07'),
(140, '140', 20, 8, '2024-12-20 01:10:07'),
(141, '141', 6, 10, '2025-01-08 01:10:07'),
(142, '142', 5, 2, '2024-07-19 01:10:07'),
(143, '143', 11, 6, '2024-11-15 01:10:07'),
(144, '144', 19, 7, '2024-09-24 01:10:07'),
(145, '145', 1, 4, '2024-08-31 01:10:07'),
(146, '146', 13, 9, '2024-11-29 01:10:07'),
(147, '147', 17, 3, '2024-08-06 01:10:07'),
(148, '148', 14, 7, '2024-10-28 01:10:07'),
(149, '149', 2, 2, '2024-11-24 01:10:07'),
(258, '101', 11, 4, '2025-01-14 13:42:03');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ims_product`
--

CREATE TABLE `ims_product` (
  `pid` int(11) NOT NULL,
  `categoryid` int(11) NOT NULL,
  `brandid` int(11) NOT NULL,
  `pname` varchar(300) NOT NULL,
  `model` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `quantity` int(11) NOT NULL,
  `unit` varchar(150) NOT NULL,
  `base_price` double(10,2) NOT NULL,
  `tax` decimal(4,2) NOT NULL,
  `minimum_order` double(10,2) NOT NULL,
  `supplier` int(11) NOT NULL,
  `status` enum('active','inactive') NOT NULL,
  `date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `ims_product`
--

INSERT INTO `ims_product` (`pid`, `categoryid`, `brandid`, `pname`, `model`, `description`, `quantity`, `unit`, `base_price`, `tax`, `minimum_order`, `supplier`, `status`, `date`) VALUES
(1, 5, 2, 'Compuesto Químico 1', 'CC-6771', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O3N5', 24, 'Gramos', 300940.88, 12.00, 1.00, 4, 'active', '2025-01-16'),
(2, 4, 4, 'Compuesto Químico 2', 'CC-1765', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H6C7C5F3N9', 2, 'Mililitros', 318501.32, 12.00, 1.00, 5, 'active', '2025-03-22'),
(3, 4, 3, 'Compuesto Químico 3', 'CC-7413', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H7O10', 1, 'Paquetes', 291367.02, 12.00, 1.00, 1, 'active', '2025-04-16'),
(4, 2, 5, 'Compuesto Químico 4', 'CC-9082', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: S5N10O1H6', 30, 'Kilogramos', 290488.47, 12.00, 1.00, 1, 'active', '2025-03-29'),
(5, 3, 2, 'Compuesto Químico 5', 'CC-9081', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F5P3C8O9C6', 27, 'Litros', 197742.71, 12.00, 1.00, 5, 'active', '2025-03-24'),
(6, 1, 5, 'Compuesto Químico 6', 'CC-7772', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P7F6', 21, 'Paquetes', 409418.85, 12.00, 1.00, 4, 'active', '2025-04-03'),
(7, 1, 3, 'Compuesto Químico 7', 'CC-6347', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N3S3H7N3', 22, 'Kilogramos', 97282.14, 12.00, 1.00, 1, 'active', '2025-04-08'),
(8, 1, 4, 'Compuesto Químico 8', 'CC-6480', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F6F2P3', 42, 'Kilogramos', 394396.65, 12.00, 1.00, 1, 'active', '2025-03-02'),
(9, 1, 2, 'Compuesto Químico 9', 'CC-124', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P1C5S10F1', 18, 'Mililitros', 423615.95, 12.00, 1.00, 5, 'active', '2025-04-19'),
(10, 4, 3, 'Compuesto Químico 10', 'CC-2602', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P6N7F10', 50, 'Litros', 414815.71, 12.00, 1.00, 4, 'active', '2025-04-26'),
(11, 3, 5, 'Compuesto Químico 11', 'CC-3140', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: C6H5N5', 41, 'Litros', 113479.53, 12.00, 1.00, 4, 'active', '2025-05-08'),
(12, 2, 5, 'Compuesto Químico 12', 'CC-9783', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N4C8O4F7', 24, 'Gramos', 401219.37, 12.00, 1.00, 4, 'active', '2025-05-07'),
(13, 4, 4, 'Compuesto Químico 13', 'CC-2979', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: C8P7F9N8O6', 26, 'Mililitros', 427398.91, 12.00, 1.00, 2, 'active', '2025-03-25'),
(14, 5, 4, 'Compuesto Químico 14', 'CC-5773', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F4F9N7', 44, 'Mililitros', 235780.21, 12.00, 1.00, 3, 'active', '2025-01-27'),
(15, 1, 1, 'Compuesto Químico 15', 'CC-5335', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H1H10', 32, 'Gramos', 484438.83, 12.00, 1.00, 1, 'active', '2025-04-05'),
(16, 4, 3, 'Compuesto Químico 16', 'CC-2789', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N9C1', 48, 'Paquetes', 289606.50, 12.00, 1.00, 2, 'active', '2025-03-14'),
(17, 5, 2, 'Compuesto Químico 17', 'CC-6688', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N1P10C7F9S4', 31, 'Litros', 271997.18, 12.00, 1.00, 3, 'active', '2025-04-15'),
(18, 3, 4, 'Compuesto Químico 18', 'CC-4616', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F4C2S5', 5, 'Litros', 212777.83, 12.00, 1.00, 4, 'active', '2025-01-26'),
(19, 4, 1, 'Compuesto Químico 19', 'CC-3448', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N10F9S9H7', 30, 'Paquetes', 84372.74, 12.00, 1.00, 5, 'active', '2025-04-11'),
(20, 3, 1, 'Compuesto Químico 20', 'CC-402', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: S10N6', 36, 'Gramos', 43360.41, 12.00, 1.00, 1, 'active', '2025-02-08'),
(21, 2, 1, 'Compuesto Químico 21', 'CC-1329', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N4P1F7O7O7', 10, 'Mililitros', 253252.30, 12.00, 1.00, 4, 'active', '2025-04-15'),
(22, 4, 1, 'Compuesto Químico 22', 'CC-4263', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O8S3O10S2P9', 38, 'Gramos', 57663.21, 12.00, 1.00, 1, 'active', '2025-03-05'),
(23, 1, 4, 'Compuesto Químico 23', 'CC-6269', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H2C8P4O9', 45, 'Gramos', 53418.63, 12.00, 1.00, 5, 'active', '2025-01-17'),
(24, 3, 1, 'Compuesto Químico 24', 'CC-8085', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F10S7C4P6', 39, 'Gramos', 450970.09, 12.00, 1.00, 1, 'active', '2025-02-01'),
(25, 2, 2, 'Compuesto Químico 25', 'CC-4240', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: C6N9P4', 22, 'Paquetes', 195705.70, 12.00, 1.00, 1, 'active', '2025-03-06'),
(26, 1, 4, 'Compuesto Químico 26', 'CC-4590', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F3N10F6H6C9', 3, 'Paquetes', 321367.45, 12.00, 1.00, 2, 'active', '2025-03-23'),
(27, 3, 4, 'Compuesto Químico 27', 'CC-5109', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O8S9', 9, 'Gramos', 242594.23, 12.00, 1.00, 1, 'active', '2025-03-15'),
(28, 3, 5, 'Compuesto Químico 28', 'CC-8534', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N6O2', 39, 'Kilogramos', 93193.49, 12.00, 1.00, 1, 'active', '2025-03-23'),
(29, 2, 5, 'Compuesto Químico 29', 'CC-1675', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N3O2S6P7S5', 42, 'Mililitros', 5402.08, 12.00, 1.00, 5, 'active', '2025-03-28'),
(30, 2, 2, 'Compuesto Químico 30', 'CC-4405', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P1F4F9', 12, 'Paquetes', 463290.28, 12.00, 1.00, 5, 'active', '2025-02-21'),
(31, 4, 1, 'Compuesto Químico 31', 'CC-6593', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: C10N5', 44, 'Gramos', 260291.24, 12.00, 1.00, 2, 'active', '2025-05-06'),
(32, 5, 3, 'Compuesto Químico 32', 'CC-4195', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O4N8F7O10N9', 15, 'Kilogramos', 192184.61, 12.00, 1.00, 1, 'active', '2025-03-21'),
(33, 2, 1, 'Compuesto Químico 33', 'CC-3263', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O8O8O10', 19, 'Paquetes', 199742.49, 12.00, 1.00, 2, 'active', '2025-02-04'),
(34, 4, 5, 'Compuesto Químico 34', 'CC-9146', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H3F10', 7, 'Litros', 305534.66, 12.00, 1.00, 1, 'active', '2025-02-10'),
(35, 5, 1, 'Compuesto Químico 35', 'CC-3679', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H5S10', 18, 'Mililitros', 239479.87, 12.00, 1.00, 2, 'active', '2025-04-21'),
(36, 4, 4, 'Compuesto Químico 36', 'CC-6019', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N10S6S3', 37, 'Paquetes', 75408.60, 12.00, 1.00, 1, 'active', '2025-02-10'),
(37, 5, 5, 'Compuesto Químico 37', 'CC-2294', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O2F3O3P5F4', 31, 'Kilogramos', 67506.90, 12.00, 1.00, 3, 'active', '2025-01-13'),
(38, 1, 4, 'Compuesto Químico 38', 'CC-8454', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F2F9P2O5', 46, 'Litros', 224711.02, 12.00, 1.00, 1, 'active', '2025-02-17'),
(39, 5, 4, 'Compuesto Químico 39', 'CC-6753', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P3F2', 26, 'Gramos', 134197.91, 12.00, 1.00, 4, 'active', '2025-03-05'),
(40, 4, 2, 'Compuesto Químico 40', 'CC-3750', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F7P9', 45, 'Kilogramos', 15363.80, 12.00, 1.00, 1, 'active', '2025-03-18'),
(41, 1, 3, 'Compuesto Químico 41', 'CC-3198', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: C2S1C3', 5, 'Mililitros', 368808.93, 12.00, 1.00, 5, 'active', '2025-05-09'),
(42, 5, 5, 'Compuesto Químico 42', 'CC-9025', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F6C5C3', 34, 'Mililitros', 109722.19, 12.00, 1.00, 1, 'active', '2025-01-27'),
(43, 2, 3, 'Compuesto Químico 43', 'CC-7716', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N2F5', 4, 'Litros', 259651.04, 12.00, 1.00, 1, 'active', '2025-01-13'),
(44, 1, 3, 'Compuesto Químico 44', 'CC-8534', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N5S3F8H8', 45, 'Paquetes', 436278.49, 12.00, 1.00, 4, 'active', '2025-03-16'),
(45, 3, 1, 'Compuesto Químico 45', 'CC-9247', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H8H1O7C7C7', 10, 'Kilogramos', 364069.05, 12.00, 1.00, 5, 'active', '2025-05-06'),
(46, 4, 5, 'Compuesto Químico 46', 'CC-4866', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N10F1H9', 35, 'Litros', 107984.08, 12.00, 1.00, 5, 'active', '2025-04-12'),
(47, 4, 4, 'Compuesto Químico 47', 'CC-5940', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O8O4', 33, 'Gramos', 357904.44, 12.00, 1.00, 5, 'active', '2025-03-26'),
(48, 3, 3, 'Compuesto Químico 48', 'CC-2288', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H7S1', 18, 'Litros', 373096.42, 12.00, 1.00, 2, 'active', '2025-04-21'),
(49, 2, 1, 'Compuesto Químico 49', 'CC-761', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: C9H1C8S4', 11, 'Paquetes', 477454.47, 12.00, 1.00, 5, 'active', '2025-01-18'),
(50, 1, 4, 'Compuesto Químico 50', 'CC-7249', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N6H5O9', 12, 'Litros', 278552.96, 12.00, 1.00, 4, 'active', '2025-02-24'),
(51, 3, 3, 'Compuesto Químico 51', 'CC-8531', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F5N2H8C1F5', 36, 'Litros', 10806.19, 12.00, 1.00, 1, 'active', '2025-05-04'),
(52, 3, 4, 'Compuesto Químico 52', 'CC-8428', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: S2F10H10C6', 16, 'Litros', 251340.69, 12.00, 1.00, 2, 'active', '2025-03-28'),
(53, 1, 1, 'Compuesto Químico 53', 'CC-4177', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O7C4N6', 28, 'Gramos', 443345.61, 12.00, 1.00, 5, 'active', '2025-04-27'),
(54, 5, 2, 'Compuesto Químico 54', 'CC-5339', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: S3N4S1H9', 25, 'Paquetes', 67473.84, 12.00, 1.00, 5, 'active', '2025-01-12'),
(55, 4, 4, 'Compuesto Químico 55', 'CC-8227', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F3S4P8', 47, 'Litros', 56484.57, 12.00, 1.00, 1, 'active', '2025-04-15'),
(56, 3, 2, 'Compuesto Químico 56', 'CC-7759', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P5P9S7N7P8', 5, 'Litros', 314548.76, 12.00, 1.00, 3, 'active', '2025-01-14'),
(57, 2, 2, 'Compuesto Químico 57', 'CC-7814', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P10C8O7', 48, 'Gramos', 131939.08, 12.00, 1.00, 1, 'active', '2025-03-04'),
(58, 5, 3, 'Compuesto Químico 58', 'CC-131', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P9P2', 30, 'Paquetes', 372113.31, 12.00, 1.00, 1, 'active', '2025-04-23'),
(59, 3, 2, 'Compuesto Químico 59', 'CC-2841', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O4N6', 25, 'Mililitros', 365362.86, 12.00, 1.00, 4, 'active', '2025-02-27'),
(60, 1, 4, 'Compuesto Químico 60', 'CC-7065', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P5C2O1S6H4', 33, 'Litros', 337980.34, 12.00, 1.00, 1, 'active', '2025-01-12'),
(61, 1, 3, 'Compuesto Químico 61', 'CC-1480', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F10P10O10N10C5', 5, 'Litros', 112784.96, 12.00, 1.00, 4, 'active', '2025-02-15'),
(62, 5, 3, 'Compuesto Químico 62', 'CC-1738', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O8P7', 5, 'Litros', 399531.25, 12.00, 1.00, 5, 'active', '2025-02-04'),
(63, 5, 5, 'Compuesto Químico 63', 'CC-1789', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N2F2', 2, 'Mililitros', 252946.72, 12.00, 1.00, 2, 'active', '2025-01-26'),
(64, 3, 5, 'Compuesto Químico 64', 'CC-7994', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P2O6S4P10', 14, 'Litros', 106579.14, 12.00, 1.00, 1, 'active', '2025-03-14'),
(65, 5, 5, 'Compuesto Químico 65', 'CC-4068', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P7S4F8', 2, 'Litros', 23850.07, 12.00, 1.00, 1, 'active', '2025-03-05'),
(66, 3, 3, 'Compuesto Químico 66', 'CC-5804', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P8C5C8N5P4', 34, 'Gramos', 497596.15, 12.00, 1.00, 1, 'active', '2025-04-29'),
(67, 2, 1, 'Compuesto Químico 67', 'CC-9119', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: C4S1S8P7F7', 27, 'Paquetes', 169850.66, 12.00, 1.00, 4, 'active', '2025-03-17'),
(68, 2, 2, 'Compuesto Químico 68', 'CC-797', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H2C1H8C9', 34, 'Litros', 307934.96, 12.00, 1.00, 4, 'active', '2025-03-30'),
(69, 5, 3, 'Compuesto Químico 69', 'CC-5601', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: S10S4', 22, 'Gramos', 151146.73, 12.00, 1.00, 5, 'active', '2025-04-14'),
(70, 4, 3, 'Compuesto Químico 70', 'CC-1802', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F8S9', 35, 'Paquetes', 303167.01, 12.00, 1.00, 2, 'active', '2025-02-11'),
(71, 3, 4, 'Compuesto Químico 71', 'CC-3938', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N3P6C7F9', 35, 'Kilogramos', 271425.20, 12.00, 1.00, 4, 'active', '2025-05-11'),
(72, 5, 5, 'Compuesto Químico 72', 'CC-3264', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F6F9N8O5C1', 3, 'Kilogramos', 223192.78, 12.00, 1.00, 2, 'active', '2025-05-03'),
(73, 1, 4, 'Compuesto Químico 73', 'CC-6927', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: S8S9O3O9N5', 9, 'Paquetes', 441108.17, 12.00, 1.00, 4, 'active', '2025-01-13'),
(74, 3, 2, 'Compuesto Químico 74', 'CC-4177', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O1C3F9O4F3', 18, 'Gramos', 318813.60, 12.00, 1.00, 3, 'active', '2025-04-27'),
(75, 1, 1, 'Compuesto Químico 75', 'CC-4132', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: C9H5F9N10', 24, 'Litros', 106716.82, 12.00, 1.00, 4, 'active', '2025-04-17'),
(76, 1, 4, 'Compuesto Químico 76', 'CC-6217', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H3S4P9C7H2', 43, 'Gramos', 309957.57, 12.00, 1.00, 4, 'active', '2025-01-15'),
(77, 4, 5, 'Compuesto Químico 77', 'CC-2625', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F3S4P7F5F9', 36, 'Paquetes', 447945.19, 12.00, 1.00, 1, 'active', '2025-03-18'),
(78, 2, 1, 'Compuesto Químico 78', 'CC-9516', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H7N6C6F9', 9, 'Litros', 495342.37, 12.00, 1.00, 4, 'active', '2025-01-21'),
(79, 5, 5, 'Compuesto Químico 79', 'CC-1126', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N2C7C4N3', 30, 'Mililitros', 167898.69, 12.00, 1.00, 5, 'active', '2025-01-18'),
(80, 1, 3, 'Compuesto Químico 80', 'CC-8570', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F4S4S6O7P2', 45, 'Paquetes', 379003.96, 12.00, 1.00, 1, 'active', '2025-02-26'),
(81, 3, 4, 'Compuesto Químico 81', 'CC-781', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O4S10C8C6', 13, 'Litros', 241417.78, 12.00, 1.00, 2, 'active', '2025-04-25'),
(82, 4, 1, 'Compuesto Químico 82', 'CC-7685', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: C5H10F9S4', 38, 'Gramos', 478638.10, 12.00, 1.00, 3, 'active', '2025-03-06'),
(83, 1, 1, 'Compuesto Químico 83', 'CC-510', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P7S7C6S4P2', 4, 'Kilogramos', 56230.22, 12.00, 1.00, 4, 'active', '2025-02-25'),
(84, 5, 3, 'Compuesto Químico 84', 'CC-3369', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F1N10O1H7', 24, 'Gramos', 298925.76, 12.00, 1.00, 4, 'active', '2025-01-12'),
(85, 5, 4, 'Compuesto Químico 85', 'CC-5587', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: S1H2C10O10', 39, 'Kilogramos', 360570.53, 12.00, 1.00, 5, 'active', '2025-04-06'),
(86, 5, 4, 'Compuesto Químico 86', 'CC-8628', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F8F4H7P9', 16, 'Litros', 32666.81, 12.00, 1.00, 2, 'active', '2025-02-25'),
(87, 4, 2, 'Compuesto Químico 87', 'CC-6784', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N9S9O3F10C2', 9, 'Paquetes', 48712.65, 12.00, 1.00, 4, 'active', '2025-01-24'),
(88, 2, 5, 'Compuesto Químico 88', 'CC-6911', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: C10N5F10', 27, 'Gramos', 181099.85, 12.00, 1.00, 1, 'active', '2025-01-22'),
(89, 2, 4, 'Compuesto Químico 89', 'CC-1249', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O7N2H1', 36, 'Kilogramos', 27351.59, 12.00, 1.00, 3, 'active', '2025-03-15'),
(90, 5, 3, 'Compuesto Químico 90', 'CC-1933', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N3P3', 15, 'Paquetes', 484098.15, 12.00, 1.00, 5, 'active', '2025-03-23'),
(91, 5, 2, 'Compuesto Químico 91', 'CC-7037', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O4S2', 26, 'Gramos', 449310.14, 12.00, 1.00, 1, 'active', '2025-02-27'),
(92, 3, 1, 'Compuesto Químico 92', 'CC-6995', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H8F4P10N5F3', 11, 'Litros', 214697.87, 12.00, 1.00, 1, 'active', '2025-01-29'),
(93, 3, 4, 'Compuesto Químico 93', 'CC-77', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F1N2N3', 50, 'Paquetes', 261408.64, 12.00, 1.00, 5, 'active', '2025-01-21'),
(94, 5, 5, 'Compuesto Químico 94', 'CC-4983', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P4H9P5P7', 41, 'Gramos', 261122.84, 12.00, 1.00, 5, 'active', '2025-03-20'),
(95, 5, 5, 'Compuesto Químico 95', 'CC-8983', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F8P7C3', 36, 'Paquetes', 155903.90, 12.00, 1.00, 5, 'active', '2025-03-08'),
(96, 5, 3, 'Compuesto Químico 96', 'CC-9063', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: C2S1C10P1', 44, 'Mililitros', 390407.18, 12.00, 1.00, 5, 'active', '2025-05-01'),
(97, 2, 3, 'Compuesto Químico 97', 'CC-324', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H3O1H3H7N6', 25, 'Gramos', 344357.58, 12.00, 1.00, 1, 'active', '2025-03-14'),
(98, 3, 1, 'Compuesto Químico 98', 'CC-5563', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N2C2', 36, 'Paquetes', 246734.86, 12.00, 1.00, 4, 'active', '2025-04-29'),
(99, 3, 3, 'Compuesto Químico 99', 'CC-2598', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: S7H4F9', 40, 'Litros', 183133.12, 12.00, 1.00, 2, 'active', '2025-04-29'),
(100, 1, 2, 'Compuesto Químico 100', 'CC-7967', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P9F10H2', 12, 'Paquetes', 225302.29, 12.00, 1.00, 4, 'active', '2025-02-23'),
(101, 4, 3, 'Compuesto Químico 101', 'CC-2901', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: S6P2N1S4', 39, 'Litros', 274578.03, 12.00, 1.00, 3, 'active', '2025-03-09'),
(102, 1, 4, 'Compuesto Químico 102', 'CC-7338', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: C1C1', 37, 'Gramos', 77082.32, 12.00, 1.00, 2, 'active', '2025-02-19'),
(103, 2, 2, 'Compuesto Químico 103', 'CC-2761', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: S7N3P5P6', 26, 'Mililitros', 144702.78, 12.00, 1.00, 1, 'active', '2025-04-20'),
(104, 3, 2, 'Compuesto Químico 104', 'CC-9346', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: C10F6F3O2', 37, 'Paquetes', 492561.29, 12.00, 1.00, 3, 'active', '2025-02-01'),
(105, 2, 1, 'Compuesto Químico 105', 'CC-193', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O2O8S7O1', 28, 'Mililitros', 451619.16, 12.00, 1.00, 2, 'active', '2025-02-01'),
(106, 3, 2, 'Compuesto Químico 106', 'CC-4083', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H7N10H3O4', 48, 'Gramos', 318430.42, 12.00, 1.00, 4, 'active', '2025-03-25'),
(107, 2, 3, 'Compuesto Químico 107', 'CC-8623', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P2S4H7P8P4', 34, 'Mililitros', 437146.93, 12.00, 1.00, 1, 'active', '2025-03-19'),
(108, 1, 2, 'Compuesto Químico 108', 'CC-725', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: S3C1P6N2', 21, 'Paquetes', 110188.98, 12.00, 1.00, 3, 'active', '2025-02-26'),
(109, 4, 4, 'Compuesto Químico 109', 'CC-673', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H1P8H1S7', 17, 'Gramos', 262378.43, 12.00, 1.00, 1, 'active', '2025-04-28'),
(110, 2, 3, 'Compuesto Químico 110', 'CC-1317', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H3P2', 15, 'Litros', 402661.60, 12.00, 1.00, 3, 'active', '2025-03-16'),
(111, 3, 3, 'Compuesto Químico 111', 'CC-1203', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P3P5S8F5O3', 4, 'Litros', 69409.93, 12.00, 1.00, 3, 'active', '2025-04-23'),
(112, 2, 3, 'Compuesto Químico 112', 'CC-1977', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P2P1C2S5N4', 34, 'Paquetes', 16014.29, 12.00, 1.00, 4, 'active', '2025-03-09'),
(113, 5, 5, 'Compuesto Químico 113', 'CC-2275', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: S9F4', 31, 'Kilogramos', 39355.09, 12.00, 1.00, 2, 'active', '2025-05-09'),
(114, 2, 2, 'Compuesto Químico 114', 'CC-4438', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P8C1', 20, 'Mililitros', 82972.87, 12.00, 1.00, 5, 'active', '2025-03-18'),
(115, 2, 4, 'Compuesto Químico 115', 'CC-2566', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P3F8C1', 48, 'Paquetes', 47851.05, 12.00, 1.00, 3, 'active', '2025-02-10'),
(116, 5, 1, 'Compuesto Químico 116', 'CC-9094', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F3N7P2C3', 0, 'Kilogramos', 236348.72, 12.00, 1.00, 3, 'active', '2025-05-04'),
(117, 3, 2, 'Compuesto Químico 117', 'CC-5012', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N8H6O2', 44, 'Paquetes', 427393.33, 12.00, 1.00, 3, 'active', '2025-02-18'),
(118, 1, 1, 'Compuesto Químico 118', 'CC-1553', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O10F6H3P3S4', 32, 'Mililitros', 310058.53, 12.00, 1.00, 5, 'active', '2025-01-21'),
(119, 4, 3, 'Compuesto Químico 119', 'CC-9345', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P1N7P6', 47, 'Paquetes', 337825.37, 12.00, 1.00, 4, 'active', '2025-02-25'),
(120, 2, 3, 'Compuesto Químico 120', 'CC-6045', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F5H8H9S9O1', 21, 'Kilogramos', 25749.21, 12.00, 1.00, 3, 'active', '2025-02-10'),
(121, 4, 2, 'Compuesto Químico 121', 'CC-9895', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H9O3O1F7H6', 9, 'Paquetes', 165720.95, 12.00, 1.00, 4, 'active', '2025-03-23'),
(122, 4, 5, 'Compuesto Químico 122', 'CC-1993', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H7P10C10N7F3', 17, 'Litros', 328827.52, 12.00, 1.00, 5, 'active', '2025-02-24'),
(123, 4, 2, 'Compuesto Químico 123', 'CC-3806', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: C6S3', 8, 'Mililitros', 77414.49, 12.00, 1.00, 3, 'active', '2025-02-24'),
(124, 1, 5, 'Compuesto Químico 124', 'CC-7961', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N10N3', 22, 'Paquetes', 444596.01, 12.00, 1.00, 5, 'active', '2025-04-26'),
(125, 3, 3, 'Compuesto Químico 125', 'CC-5220', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: S10C4S2S9', 46, 'Litros', 137029.63, 12.00, 1.00, 2, 'active', '2025-05-09'),
(126, 1, 5, 'Compuesto Químico 126', 'CC-5708', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H6C5O1N2O3', 44, 'Mililitros', 246761.71, 12.00, 1.00, 4, 'active', '2025-03-22'),
(127, 3, 2, 'Compuesto Químico 127', 'CC-764', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: S9H7', 30, 'Mililitros', 402412.21, 12.00, 1.00, 5, 'active', '2025-05-11'),
(128, 4, 5, 'Compuesto Químico 128', 'CC-9006', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: S2C8S2', 26, 'Paquetes', 353343.75, 12.00, 1.00, 5, 'active', '2025-04-22'),
(129, 4, 3, 'Compuesto Químico 129', 'CC-3386', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N2H7', 10, 'Paquetes', 149386.22, 12.00, 1.00, 3, 'active', '2025-04-28'),
(130, 3, 3, 'Compuesto Químico 130', 'CC-4591', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: C4S8P8N4F9', 33, 'Paquetes', 293397.91, 12.00, 1.00, 1, 'active', '2025-02-08'),
(131, 5, 2, 'Compuesto Químico 131', 'CC-5867', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: C7F1C5C9', 4, 'Mililitros', 465817.77, 12.00, 1.00, 4, 'active', '2025-05-11'),
(132, 2, 4, 'Compuesto Químico 132', 'CC-982', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N3F9H10P2', 12, 'Paquetes', 36431.06, 12.00, 1.00, 3, 'active', '2025-01-25'),
(133, 1, 2, 'Compuesto Químico 133', 'CC-30', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N2H3', 19, 'Paquetes', 157955.67, 12.00, 1.00, 5, 'active', '2025-03-22'),
(134, 2, 2, 'Compuesto Químico 134', 'CC-2070', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H5P6', 10, 'Gramos', 197207.07, 12.00, 1.00, 4, 'active', '2025-03-31'),
(135, 5, 5, 'Compuesto Químico 135', 'CC-1151', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P4O6N3N9P3', 30, 'Mililitros', 244300.79, 12.00, 1.00, 3, 'active', '2025-04-27'),
(136, 4, 5, 'Compuesto Químico 136', 'CC-1007', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H4C3P6H6C6', 49, 'Gramos', 346015.08, 12.00, 1.00, 5, 'active', '2025-03-09'),
(137, 2, 1, 'Compuesto Químico 137', 'CC-3360', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P1S5C1F9', 24, 'Gramos', 286242.19, 12.00, 1.00, 4, 'active', '2025-03-17'),
(138, 1, 5, 'Compuesto Químico 138', 'CC-2785', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: C10N9S10S4', 41, 'Kilogramos', 376330.30, 12.00, 1.00, 1, 'active', '2025-05-07'),
(139, 3, 3, 'Compuesto Químico 139', 'CC-2393', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N8C9O5P6', 35, 'Mililitros', 387652.12, 12.00, 1.00, 3, 'active', '2025-03-06'),
(140, 1, 3, 'Compuesto Químico 140', 'CC-5820', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N7C2P4N4', 9, 'Litros', 81131.63, 12.00, 1.00, 2, 'active', '2025-03-11'),
(141, 3, 3, 'Compuesto Químico 141', 'CC-1553', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F5F10C4', 10, 'Gramos', 5863.01, 12.00, 1.00, 3, 'active', '2025-03-06'),
(142, 4, 2, 'Compuesto Químico 142', 'CC-8502', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O7C6N2P9', 29, 'Kilogramos', 14692.74, 12.00, 1.00, 1, 'active', '2025-02-20'),
(143, 5, 4, 'Compuesto Químico 143', 'CC-5916', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F8S1N3', 49, 'Litros', 266999.11, 12.00, 1.00, 2, 'active', '2025-02-27'),
(144, 3, 3, 'Compuesto Químico 144', 'CC-2716', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N6H2O4O2', 7, 'Paquetes', 124606.82, 12.00, 1.00, 3, 'active', '2025-02-26'),
(145, 1, 3, 'Compuesto Químico 145', 'CC-7202', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F7N9O7H8', 18, 'Mililitros', 151337.95, 12.00, 1.00, 3, 'active', '2025-03-05'),
(146, 1, 3, 'Compuesto Químico 146', 'CC-1932', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N4H1N4H3O1', 22, 'Mililitros', 405694.22, 12.00, 1.00, 1, 'active', '2025-03-06'),
(147, 2, 1, 'Compuesto Químico 147', 'CC-8619', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: C7S3O1H10', 0, 'Gramos', 245743.14, 12.00, 1.00, 5, 'active', '2025-01-31'),
(148, 4, 5, 'Compuesto Químico 148', 'CC-5467', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P6N7', 42, 'Gramos', 43911.77, 12.00, 1.00, 5, 'active', '2025-02-03'),
(149, 4, 5, 'Compuesto Químico 149', 'CC-7405', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P10S3C1', 12, 'Litros', 172385.65, 12.00, 1.00, 4, 'active', '2025-02-19'),
(150, 1, 5, 'Compuesto Químico 150', 'CC-3337', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F2P2P5S3', 43, 'Litros', 498462.39, 12.00, 1.00, 4, 'active', '2025-03-22'),
(151, 1, 5, 'Compuesto Químico 151', 'CC-8951', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F7N7O3F10', 41, 'Gramos', 308486.07, 12.00, 1.00, 5, 'active', '2025-02-21'),
(152, 1, 3, 'Compuesto Químico 152', 'CC-4237', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F1O7', 27, 'Kilogramos', 156212.57, 12.00, 1.00, 3, 'active', '2025-01-31'),
(153, 3, 4, 'Compuesto Químico 153', 'CC-8052', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H8P9C6O6', 6, 'Kilogramos', 467955.29, 12.00, 1.00, 5, 'active', '2025-03-18'),
(154, 5, 2, 'Compuesto Químico 154', 'CC-255', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: C7O6', 26, 'Gramos', 20686.51, 12.00, 1.00, 4, 'active', '2025-01-25'),
(155, 2, 1, 'Compuesto Químico 155', 'CC-198', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P10S10H2H4', 33, 'Litros', 7954.22, 12.00, 1.00, 3, 'active', '2025-03-06'),
(156, 5, 2, 'Compuesto Químico 156', 'CC-7397', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O6N3S3H8', 41, 'Paquetes', 485436.49, 12.00, 1.00, 1, 'active', '2025-01-18'),
(157, 5, 1, 'Compuesto Químico 157', 'CC-9475', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O6N3N9S6', 11, 'Kilogramos', 399837.13, 12.00, 1.00, 1, 'active', '2025-01-29'),
(158, 4, 1, 'Compuesto Químico 158', 'CC-236', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N5N5N10', 28, 'Mililitros', 53548.31, 12.00, 1.00, 2, 'active', '2025-05-04'),
(159, 2, 1, 'Compuesto Químico 159', 'CC-7156', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P4O10O10S2F5', 11, 'Litros', 171385.46, 12.00, 1.00, 4, 'active', '2025-03-05'),
(160, 4, 1, 'Compuesto Químico 160', 'CC-2962', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H7P8', 13, 'Gramos', 128090.03, 12.00, 1.00, 1, 'active', '2025-03-17'),
(161, 4, 3, 'Compuesto Químico 161', 'CC-1675', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F9P5P7', 29, 'Kilogramos', 24958.42, 12.00, 1.00, 1, 'active', '2025-04-19'),
(162, 3, 4, 'Compuesto Químico 162', 'CC-3794', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F3H8C10', 27, 'Gramos', 19439.20, 12.00, 1.00, 4, 'active', '2025-05-04'),
(163, 4, 4, 'Compuesto Químico 163', 'CC-4004', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N10C8N10S2F4', 41, 'Paquetes', 46142.84, 12.00, 1.00, 4, 'active', '2025-02-22'),
(164, 4, 5, 'Compuesto Químico 164', 'CC-5094', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P4H1N2N9', 43, 'Mililitros', 51710.73, 12.00, 1.00, 2, 'active', '2025-02-16'),
(165, 1, 3, 'Compuesto Químico 165', 'CC-3077', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: S10S3N7S7', 50, 'Litros', 117054.41, 12.00, 1.00, 1, 'active', '2025-03-14'),
(166, 2, 2, 'Compuesto Químico 166', 'CC-3790', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N6H6P4', 13, 'Litros', 55001.08, 12.00, 1.00, 1, 'active', '2025-04-08'),
(167, 4, 3, 'Compuesto Químico 167', 'CC-1650', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: S7H3N8N9', 15, 'Paquetes', 639.22, 12.00, 1.00, 1, 'active', '2025-02-25'),
(168, 4, 2, 'Compuesto Químico 168', 'CC-8595', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: C7S7C4N7', 9, 'Kilogramos', 134137.49, 12.00, 1.00, 2, 'active', '2025-02-28'),
(169, 2, 4, 'Compuesto Químico 169', 'CC-9652', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: C7C5C9', 26, 'Mililitros', 32135.90, 12.00, 1.00, 1, 'active', '2025-03-12'),
(170, 3, 3, 'Compuesto Químico 170', 'CC-76', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F3N1', 24, 'Kilogramos', 261258.79, 12.00, 1.00, 3, 'active', '2025-03-22'),
(171, 2, 4, 'Compuesto Químico 171', 'CC-5220', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H5N10O9H6', 29, 'Kilogramos', 380408.15, 12.00, 1.00, 5, 'active', '2025-02-17'),
(172, 3, 4, 'Compuesto Químico 172', 'CC-5115', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F4C1F8P7C4', 34, 'Paquetes', 201583.83, 12.00, 1.00, 2, 'active', '2025-03-12'),
(173, 4, 5, 'Compuesto Químico 173', 'CC-910', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P4O9O2', 1, 'Paquetes', 135746.40, 12.00, 1.00, 4, 'active', '2025-04-29'),
(174, 4, 5, 'Compuesto Químico 174', 'CC-6212', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: S3N8H9', 12, 'Kilogramos', 466723.70, 12.00, 1.00, 4, 'active', '2025-03-23'),
(175, 1, 3, 'Compuesto Químico 175', 'CC-8637', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P1F3P9C10O9', 43, 'Mililitros', 318518.88, 12.00, 1.00, 2, 'active', '2025-03-12'),
(176, 3, 2, 'Compuesto Químico 176', 'CC-9866', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P7C7P3F7', 9, 'Paquetes', 79437.54, 12.00, 1.00, 5, 'active', '2025-02-28'),
(177, 1, 4, 'Compuesto Químico 177', 'CC-3080', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H6N5', 26, 'Mililitros', 474089.70, 12.00, 1.00, 4, 'active', '2025-02-14'),
(178, 5, 3, 'Compuesto Químico 178', 'CC-7847', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P6H7O1H7', 20, 'Mililitros', 34009.36, 12.00, 1.00, 2, 'active', '2025-04-03'),
(179, 5, 3, 'Compuesto Químico 179', 'CC-3320', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H5N3S6', 46, 'Mililitros', 135944.04, 12.00, 1.00, 3, 'active', '2025-04-27'),
(180, 5, 5, 'Compuesto Químico 180', 'CC-9473', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H1N1C1C2S8', 3, 'Gramos', 160120.19, 12.00, 1.00, 1, 'active', '2025-03-08'),
(181, 5, 4, 'Compuesto Químico 181', 'CC-5894', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P1S2', 6, 'Paquetes', 53702.48, 12.00, 1.00, 5, 'active', '2025-04-22'),
(182, 4, 3, 'Compuesto Químico 182', 'CC-5836', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F4H10F1H1', 9, 'Litros', 122177.48, 12.00, 1.00, 4, 'active', '2025-01-12'),
(183, 5, 1, 'Compuesto Químico 183', 'CC-468', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F3S4F6C6N9', 33, 'Litros', 321397.89, 12.00, 1.00, 5, 'active', '2025-02-22'),
(184, 4, 2, 'Compuesto Químico 184', 'CC-3790', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P4O6', 43, 'Litros', 433759.88, 12.00, 1.00, 1, 'active', '2025-04-29'),
(185, 4, 4, 'Compuesto Químico 185', 'CC-4775', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H3F10', 13, 'Paquetes', 330728.37, 12.00, 1.00, 4, 'active', '2025-02-03'),
(186, 1, 2, 'Compuesto Químico 186', 'CC-5686', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N8F4', 37, 'Litros', 421718.19, 12.00, 1.00, 1, 'active', '2025-02-20'),
(187, 1, 4, 'Compuesto Químico 187', 'CC-2354', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: S8C9', 9, 'Kilogramos', 233778.13, 12.00, 1.00, 4, 'active', '2025-02-10'),
(188, 3, 5, 'Compuesto Químico 188', 'CC-599', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N4H3', 24, 'Litros', 259600.46, 12.00, 1.00, 1, 'active', '2025-03-25'),
(189, 5, 2, 'Compuesto Químico 189', 'CC-2886', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P2N8O5H7N9', 21, 'Kilogramos', 29075.29, 12.00, 1.00, 3, 'active', '2025-02-12'),
(190, 4, 1, 'Compuesto Químico 190', 'CC-9826', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N10H1N8C4O6', 41, 'Litros', 171979.07, 12.00, 1.00, 2, 'active', '2025-01-28'),
(191, 4, 1, 'Compuesto Químico 191', 'CC-2388', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N7N8H8C9O4', 6, 'Paquetes', 88552.97, 12.00, 1.00, 1, 'active', '2025-02-09'),
(192, 4, 4, 'Compuesto Químico 192', 'CC-4168', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F3P8S8F5', 5, 'Kilogramos', 492439.58, 12.00, 1.00, 1, 'active', '2025-04-17'),
(193, 1, 2, 'Compuesto Químico 193', 'CC-5793', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O9O1N10O1', 39, 'Litros', 122652.88, 12.00, 1.00, 5, 'active', '2025-04-09'),
(194, 3, 3, 'Compuesto Químico 194', 'CC-6012', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: S7F7P8O7H9', 30, 'Kilogramos', 152717.82, 12.00, 1.00, 5, 'active', '2025-02-23'),
(195, 3, 2, 'Compuesto Químico 195', 'CC-9788', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F2P9', 46, 'Gramos', 85567.28, 12.00, 1.00, 1, 'active', '2025-01-27'),
(196, 3, 1, 'Compuesto Químico 196', 'CC-2639', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F9O4P8', 44, 'Mililitros', 208597.19, 12.00, 1.00, 2, 'active', '2025-05-11'),
(197, 3, 2, 'Compuesto Químico 197', 'CC-2424', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H5N5', 4, 'Mililitros', 168355.50, 12.00, 1.00, 3, 'active', '2025-03-23'),
(198, 2, 3, 'Compuesto Químico 198', 'CC-3306', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H8H10P4', 16, 'Mililitros', 48345.67, 12.00, 1.00, 4, 'active', '2025-05-06'),
(199, 1, 1, 'Compuesto Químico 199', 'CC-3513', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H6C7C6H8C9', 15, 'Gramos', 220060.49, 12.00, 1.00, 4, 'active', '2025-03-27'),
(200, 5, 3, 'Compuesto Químico 200', 'CC-4341', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P7C1O4P9', 23, 'Paquetes', 267468.84, 12.00, 1.00, 4, 'active', '2025-01-18'),
(201, 2, 2, 'Compuesto Químico 201', 'CC-5763', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H8O6', 44, 'Mililitros', 293942.48, 12.00, 1.00, 1, 'active', '2025-02-17'),
(202, 2, 5, 'Compuesto Químico 202', 'CC-1451', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N8S9O1', 43, 'Paquetes', 369429.20, 12.00, 1.00, 1, 'active', '2025-02-16'),
(203, 5, 4, 'Compuesto Químico 203', 'CC-2752', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: C7H9', 0, 'Kilogramos', 110269.20, 12.00, 1.00, 2, 'active', '2025-01-17'),
(204, 2, 4, 'Compuesto Químico 204', 'CC-4058', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F10F1', 45, 'Kilogramos', 368054.07, 12.00, 1.00, 5, 'active', '2025-04-27'),
(205, 5, 4, 'Compuesto Químico 205', 'CC-7103', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: C4N5C6P2N9', 31, 'Paquetes', 50052.98, 12.00, 1.00, 3, 'active', '2025-02-14'),
(206, 3, 1, 'Compuesto Químico 206', 'CC-6607', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O2S2S6F1S7', 39, 'Paquetes', 462097.23, 12.00, 1.00, 1, 'active', '2025-04-02'),
(207, 1, 1, 'Compuesto Químico 207', 'CC-6322', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N1P7', 38, 'Paquetes', 490256.34, 12.00, 1.00, 2, 'active', '2025-04-29'),
(208, 1, 2, 'Compuesto Químico 208', 'CC-6775', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H8H9S6', 17, 'Mililitros', 233968.88, 12.00, 1.00, 2, 'active', '2025-04-14'),
(209, 1, 3, 'Compuesto Químico 209', 'CC-7641', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O6P9', 7, 'Gramos', 325364.83, 12.00, 1.00, 1, 'active', '2025-01-22'),
(210, 4, 3, 'Compuesto Químico 210', 'CC-4070', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P1N3F7', 26, 'Gramos', 236922.72, 12.00, 1.00, 1, 'active', '2025-02-12'),
(211, 4, 2, 'Compuesto Químico 211', 'CC-55', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P2N1P6O4S2', 16, 'Gramos', 473165.09, 12.00, 1.00, 5, 'active', '2025-01-24'),
(212, 3, 1, 'Compuesto Químico 212', 'CC-6482', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N7C1O7F9', 4, 'Gramos', 126236.30, 12.00, 1.00, 4, 'active', '2025-05-10'),
(213, 2, 4, 'Compuesto Químico 213', 'CC-1675', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N5P8C1H1', 47, 'Litros', 16096.81, 12.00, 1.00, 4, 'active', '2025-02-05'),
(214, 3, 4, 'Compuesto Químico 214', 'CC-4833', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: S1O5', 6, 'Litros', 286289.47, 12.00, 1.00, 2, 'active', '2025-04-08'),
(215, 1, 3, 'Compuesto Químico 215', 'CC-6931', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: S8F6C6O5F2', 5, 'Gramos', 491341.37, 12.00, 1.00, 3, 'active', '2025-04-05'),
(216, 5, 2, 'Compuesto Químico 216', 'CC-8391', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O4O10P10O9H8', 13, 'Paquetes', 149792.28, 12.00, 1.00, 1, 'active', '2025-02-15'),
(217, 5, 5, 'Compuesto Químico 217', 'CC-764', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: S6S4F8', 33, 'Litros', 108949.05, 12.00, 1.00, 5, 'active', '2025-02-12'),
(218, 4, 3, 'Compuesto Químico 218', 'CC-6698', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: C2N2C10', 35, 'Gramos', 109583.92, 12.00, 1.00, 4, 'active', '2025-05-02'),
(219, 3, 5, 'Compuesto Químico 219', 'CC-9076', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N1P1P6', 45, 'Mililitros', 425709.88, 12.00, 1.00, 1, 'active', '2025-02-06'),
(220, 2, 5, 'Compuesto Químico 220', 'CC-6326', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O2S7N6C10', 18, 'Paquetes', 216905.55, 12.00, 1.00, 3, 'active', '2025-01-12'),
(221, 5, 3, 'Compuesto Químico 221', 'CC-2217', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: C7C4O10S6', 20, 'Kilogramos', 326110.77, 12.00, 1.00, 1, 'active', '2025-04-08'),
(222, 2, 2, 'Compuesto Químico 222', 'CC-206', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P4S9', 24, 'Kilogramos', 112468.26, 12.00, 1.00, 1, 'active', '2025-05-07'),
(223, 3, 4, 'Compuesto Químico 223', 'CC-9874', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O2F4S6', 49, 'Paquetes', 232930.29, 12.00, 1.00, 4, 'active', '2025-01-29'),
(224, 2, 4, 'Compuesto Químico 224', 'CC-3743', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: S2C9C6N10', 45, 'Kilogramos', 47369.32, 12.00, 1.00, 3, 'active', '2025-04-10'),
(225, 3, 3, 'Compuesto Químico 225', 'CC-6375', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H4H10C3', 50, 'Litros', 57418.16, 12.00, 1.00, 3, 'active', '2025-02-18'),
(226, 4, 3, 'Compuesto Químico 226', 'CC-4332', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F8P8O9C9F2', 25, 'Kilogramos', 323195.77, 12.00, 1.00, 3, 'active', '2025-04-08'),
(227, 5, 1, 'Compuesto Químico 227', 'CC-7613', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F5S8', 30, 'Mililitros', 309790.76, 12.00, 1.00, 1, 'active', '2025-03-05'),
(228, 4, 1, 'Compuesto Químico 228', 'CC-6036', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P7H9', 25, 'Mililitros', 56794.33, 12.00, 1.00, 2, 'active', '2025-03-23'),
(229, 5, 3, 'Compuesto Químico 229', 'CC-5453', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H6C8S10P1P7', 24, 'Mililitros', 171363.84, 12.00, 1.00, 3, 'active', '2025-02-05'),
(230, 4, 1, 'Compuesto Químico 230', 'CC-7495', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P2H5S3F2', 12, 'Paquetes', 469668.39, 12.00, 1.00, 5, 'active', '2025-04-09'),
(231, 2, 2, 'Compuesto Químico 231', 'CC-4690', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O1O6P2N8N2', 20, 'Mililitros', 476494.91, 12.00, 1.00, 5, 'active', '2025-03-04'),
(232, 5, 2, 'Compuesto Químico 232', 'CC-1845', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: S2H6F4P6', 47, 'Litros', 317707.94, 12.00, 1.00, 5, 'active', '2025-04-09'),
(233, 1, 5, 'Compuesto Químico 233', 'CC-1402', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: C8P6H8H4N4', 44, 'Paquetes', 492401.39, 12.00, 1.00, 1, 'active', '2025-04-30'),
(234, 2, 4, 'Compuesto Químico 234', 'CC-9433', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H5H7P8O9F3', 22, 'Kilogramos', 253416.36, 12.00, 1.00, 3, 'active', '2025-04-03'),
(235, 4, 3, 'Compuesto Químico 235', 'CC-7046', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O6N9', 14, 'Kilogramos', 369564.42, 12.00, 1.00, 4, 'active', '2025-03-08'),
(236, 1, 5, 'Compuesto Químico 236', 'CC-3687', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: C4N1', 10, 'Paquetes', 395137.27, 12.00, 1.00, 2, 'active', '2025-02-10'),
(237, 5, 2, 'Compuesto Químico 237', 'CC-56', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: S2F5O2', 43, 'Kilogramos', 288208.40, 12.00, 1.00, 2, 'active', '2025-02-19'),
(238, 4, 2, 'Compuesto Químico 238', 'CC-7354', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P4H10H10N3C6', 37, 'Gramos', 155462.04, 12.00, 1.00, 1, 'active', '2025-02-07'),
(239, 3, 1, 'Compuesto Químico 239', 'CC-841', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O1C10', 46, 'Kilogramos', 295644.44, 12.00, 1.00, 1, 'active', '2025-01-25'),
(240, 2, 2, 'Compuesto Químico 240', 'CC-7276', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P1S1', 35, 'Kilogramos', 280305.94, 12.00, 1.00, 5, 'active', '2025-02-19'),
(241, 1, 1, 'Compuesto Químico 241', 'CC-8152', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: C7F10', 27, 'Kilogramos', 273264.44, 12.00, 1.00, 1, 'active', '2025-03-21'),
(242, 3, 1, 'Compuesto Químico 242', 'CC-6913', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P2C2O4P8', 21, 'Litros', 485943.30, 12.00, 1.00, 4, 'active', '2025-03-30'),
(243, 3, 3, 'Compuesto Químico 243', 'CC-590', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N2N9', 29, 'Mililitros', 22504.31, 12.00, 1.00, 5, 'active', '2025-03-20'),
(244, 2, 2, 'Compuesto Químico 244', 'CC-4834', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O7O7', 35, 'Litros', 129497.85, 12.00, 1.00, 1, 'active', '2025-03-22'),
(245, 5, 5, 'Compuesto Químico 245', 'CC-1854', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: S1O6F8C1', 22, 'Mililitros', 8049.33, 12.00, 1.00, 1, 'active', '2025-02-16'),
(246, 5, 3, 'Compuesto Químico 246', 'CC-4885', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N7F8P5', 2, 'Mililitros', 393104.33, 12.00, 1.00, 3, 'active', '2025-03-10'),
(247, 4, 5, 'Compuesto Químico 247', 'CC-7097', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: C4O6F10P3', 31, 'Paquetes', 425268.18, 12.00, 1.00, 3, 'active', '2025-03-29'),
(248, 5, 1, 'Compuesto Químico 248', 'CC-6992', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N8N10N8F8P5', 17, 'Mililitros', 59385.35, 12.00, 1.00, 4, 'active', '2025-01-29'),
(249, 1, 2, 'Compuesto Químico 249', 'CC-9624', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: S6S6P2O5', 1, 'Kilogramos', 122866.14, 12.00, 1.00, 3, 'active', '2025-02-27'),
(250, 5, 3, 'Compuesto Químico 250', 'CC-8972', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H10H10H10O1', 46, 'Paquetes', 254702.81, 12.00, 1.00, 1, 'active', '2025-03-14');
INSERT INTO `ims_product` (`pid`, `categoryid`, `brandid`, `pname`, `model`, `description`, `quantity`, `unit`, `base_price`, `tax`, `minimum_order`, `supplier`, `status`, `date`) VALUES
(251, 2, 1, 'Compuesto Químico 251', 'CC-348', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: C10N4N7P8', 35, 'Kilogramos', 380965.87, 12.00, 1.00, 4, 'active', '2025-02-07'),
(252, 5, 3, 'Compuesto Químico 252', 'CC-3159', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O10N5', 12, 'Kilogramos', 408716.22, 12.00, 1.00, 1, 'active', '2025-02-11'),
(253, 3, 1, 'Compuesto Químico 253', 'CC-9930', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N2C7O8P4S1', 38, 'Mililitros', 255672.80, 12.00, 1.00, 2, 'active', '2025-01-12'),
(254, 1, 4, 'Compuesto Químico 254', 'CC-265', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N1F4', 0, 'Paquetes', 373223.96, 12.00, 1.00, 5, 'active', '2025-01-26'),
(255, 1, 1, 'Compuesto Químico 255', 'CC-803', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: S2P6H5P5F4', 15, 'Kilogramos', 146333.56, 12.00, 1.00, 4, 'active', '2025-04-30'),
(256, 3, 3, 'Compuesto Químico 256', 'CC-119', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N9N2', 36, 'Gramos', 324214.49, 12.00, 1.00, 3, 'active', '2025-04-23'),
(257, 3, 3, 'Compuesto Químico 257', 'CC-4834', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H5S1O4F3', 38, 'Kilogramos', 91423.94, 12.00, 1.00, 1, 'active', '2025-04-12'),
(258, 4, 5, 'Compuesto Químico 258', 'CC-2016', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: S4F7N7S1', 29, 'Kilogramos', 444608.00, 12.00, 1.00, 3, 'active', '2025-03-26'),
(259, 1, 3, 'Compuesto Químico 259', 'CC-2824', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: S1O8S2P3', 48, 'Paquetes', 240344.57, 12.00, 1.00, 5, 'active', '2025-03-31'),
(260, 3, 3, 'Compuesto Químico 260', 'CC-6812', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H4O8P7S3S3', 10, 'Paquetes', 133501.71, 12.00, 1.00, 3, 'active', '2025-02-09'),
(261, 3, 2, 'Compuesto Químico 261', 'CC-5042', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: C7C4N5F10C4', 20, 'Gramos', 113623.96, 12.00, 1.00, 4, 'active', '2025-04-08'),
(262, 5, 4, 'Compuesto Químico 262', 'CC-4557', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: S6F1N6F2', 45, 'Litros', 432361.46, 12.00, 1.00, 5, 'active', '2025-02-25'),
(263, 5, 4, 'Compuesto Químico 263', 'CC-5771', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H7N7S5H5P9', 50, 'Kilogramos', 140560.17, 12.00, 1.00, 4, 'active', '2025-02-25'),
(264, 5, 2, 'Compuesto Químico 264', 'CC-6375', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N5F7C5O10F8', 20, 'Litros', 129415.59, 12.00, 1.00, 1, 'active', '2025-02-18'),
(265, 4, 3, 'Compuesto Químico 265', 'CC-3940', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N3N7P3', 31, 'Paquetes', 269802.62, 12.00, 1.00, 1, 'active', '2025-04-12'),
(266, 1, 1, 'Compuesto Químico 266', 'CC-1249', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O5P9C5H6', 14, 'Litros', 251159.57, 12.00, 1.00, 2, 'active', '2025-05-04'),
(267, 2, 2, 'Compuesto Químico 267', 'CC-7973', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H9O4P6N2H4', 50, 'Gramos', 486401.44, 12.00, 1.00, 1, 'active', '2025-03-14'),
(268, 2, 3, 'Compuesto Químico 268', 'CC-7681', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F9N7P9', 18, 'Gramos', 154169.13, 12.00, 1.00, 1, 'active', '2025-03-31'),
(269, 5, 1, 'Compuesto Químico 269', 'CC-2557', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: S6P2N1S10F10', 6, 'Paquetes', 477266.89, 12.00, 1.00, 1, 'active', '2025-05-11'),
(270, 2, 4, 'Compuesto Químico 270', 'CC-7753', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O2P8H6', 37, 'Kilogramos', 198587.05, 12.00, 1.00, 1, 'active', '2025-05-10'),
(271, 2, 2, 'Compuesto Químico 271', 'CC-5494', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H7O2P3P3P2', 41, 'Gramos', 407621.86, 12.00, 1.00, 4, 'active', '2025-01-24'),
(272, 3, 5, 'Compuesto Químico 272', 'CC-4648', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: S10P2N8', 22, 'Mililitros', 336431.40, 12.00, 1.00, 5, 'active', '2025-04-22'),
(273, 4, 5, 'Compuesto Químico 273', 'CC-1746', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F6C1S1', 23, 'Mililitros', 175612.69, 12.00, 1.00, 3, 'active', '2025-03-24'),
(274, 5, 3, 'Compuesto Químico 274', 'CC-8169', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: C6H3F8', 24, 'Paquetes', 181727.36, 12.00, 1.00, 5, 'active', '2025-03-20'),
(275, 1, 3, 'Compuesto Químico 275', 'CC-5515', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O10P7', 1, 'Gramos', 184665.25, 12.00, 1.00, 2, 'active', '2025-04-12'),
(276, 4, 2, 'Compuesto Químico 276', 'CC-8821', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: C1O4F6F2', 41, 'Kilogramos', 241238.45, 12.00, 1.00, 2, 'active', '2025-05-02'),
(277, 3, 4, 'Compuesto Químico 277', 'CC-9509', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: C4O6S9F6P2', 43, 'Gramos', 236217.71, 12.00, 1.00, 1, 'active', '2025-02-18'),
(278, 2, 1, 'Compuesto Químico 278', 'CC-2826', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: S10P10', 8, 'Litros', 295830.50, 12.00, 1.00, 5, 'active', '2025-04-02'),
(279, 1, 1, 'Compuesto Químico 279', 'CC-4746', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N4H2C9F5', 49, 'Gramos', 80204.27, 12.00, 1.00, 3, 'active', '2025-02-22'),
(280, 2, 1, 'Compuesto Químico 280', 'CC-608', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: C3C8', 40, 'Paquetes', 360996.41, 12.00, 1.00, 1, 'active', '2025-03-13'),
(281, 2, 2, 'Compuesto Químico 281', 'CC-7853', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: C10P10', 4, 'Litros', 154176.98, 12.00, 1.00, 1, 'active', '2025-01-12'),
(282, 4, 4, 'Compuesto Químico 282', 'CC-6336', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O2P6O2', 3, 'Gramos', 470577.08, 12.00, 1.00, 3, 'active', '2025-02-15'),
(283, 4, 4, 'Compuesto Químico 283', 'CC-9917', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: C7H1', 48, 'Mililitros', 459725.40, 12.00, 1.00, 2, 'active', '2025-05-07'),
(284, 1, 2, 'Compuesto Químico 284', 'CC-8005', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: C7N3S8P9S6', 45, 'Litros', 397692.20, 12.00, 1.00, 4, 'active', '2025-01-13'),
(285, 2, 1, 'Compuesto Químico 285', 'CC-501', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: C2P6', 10, 'Paquetes', 351710.29, 12.00, 1.00, 5, 'active', '2025-03-18'),
(286, 4, 2, 'Compuesto Químico 286', 'CC-7238', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F1N2H9S3P8', 21, 'Paquetes', 260179.05, 12.00, 1.00, 4, 'active', '2025-01-18'),
(287, 5, 2, 'Compuesto Químico 287', 'CC-607', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H1S10', 18, 'Mililitros', 54908.84, 12.00, 1.00, 4, 'active', '2025-04-18'),
(288, 4, 3, 'Compuesto Químico 288', 'CC-6107', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O2S8', 18, 'Paquetes', 323678.81, 12.00, 1.00, 3, 'active', '2025-01-24'),
(289, 2, 5, 'Compuesto Químico 289', 'CC-8800', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H10O1F4', 36, 'Paquetes', 224917.55, 12.00, 1.00, 3, 'active', '2025-01-29'),
(290, 1, 5, 'Compuesto Químico 290', 'CC-3881', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: S9F4', 15, 'Kilogramos', 422270.83, 12.00, 1.00, 1, 'active', '2025-02-19'),
(291, 3, 3, 'Compuesto Químico 291', 'CC-8972', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N1F5', 44, 'Mililitros', 407954.65, 12.00, 1.00, 1, 'active', '2025-03-27'),
(292, 1, 1, 'Compuesto Químico 292', 'CC-9988', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O8P3', 34, 'Kilogramos', 355296.93, 12.00, 1.00, 3, 'active', '2025-03-11'),
(293, 1, 3, 'Compuesto Químico 293', 'CC-9954', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F10C4N5C6S6', 36, 'Gramos', 369930.49, 12.00, 1.00, 5, 'active', '2025-03-30'),
(294, 4, 4, 'Compuesto Químico 294', 'CC-1750', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: S2F5O4', 41, 'Gramos', 90736.00, 12.00, 1.00, 2, 'active', '2025-01-31'),
(295, 1, 3, 'Compuesto Químico 295', 'CC-149', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N10O2N9P4N3', 38, 'Mililitros', 127530.67, 12.00, 1.00, 1, 'active', '2025-01-24'),
(296, 2, 2, 'Compuesto Químico 296', 'CC-2544', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: S5H6', 7, 'Paquetes', 269712.59, 12.00, 1.00, 4, 'active', '2025-04-27'),
(297, 4, 4, 'Compuesto Químico 297', 'CC-7863', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P2H5P9', 34, 'Litros', 147560.92, 12.00, 1.00, 2, 'active', '2025-03-05'),
(298, 3, 4, 'Compuesto Químico 298', 'CC-3104', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: S9H9O1', 36, 'Mililitros', 99809.73, 12.00, 1.00, 5, 'active', '2025-02-17'),
(299, 4, 3, 'Compuesto Químico 299', 'CC-8655', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: C4N7N8C5', 4, 'Paquetes', 448984.62, 12.00, 1.00, 5, 'active', '2025-02-15'),
(300, 3, 4, 'Compuesto Químico 300', 'CC-2335', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N9C7H3', 46, 'Paquetes', 263841.98, 12.00, 1.00, 1, 'active', '2025-04-21'),
(301, 4, 5, 'Compuesto Químico 301', 'CC-918', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: C6O5C1P1P6', 46, 'Kilogramos', 251250.86, 12.00, 1.00, 4, 'active', '2025-03-02'),
(302, 3, 3, 'Compuesto Químico 302', 'CC-7370', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O7C5H5F1', 15, 'Kilogramos', 337555.89, 12.00, 1.00, 3, 'active', '2025-01-20'),
(303, 1, 5, 'Compuesto Químico 303', 'CC-9263', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O3N5', 8, 'Litros', 365962.24, 12.00, 1.00, 3, 'active', '2025-03-03'),
(304, 2, 4, 'Compuesto Químico 304', 'CC-4548', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N6N10H4F9', 20, 'Mililitros', 6469.29, 12.00, 1.00, 1, 'active', '2025-03-28'),
(305, 2, 4, 'Compuesto Químico 305', 'CC-6410', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F2C10S4S6N2', 9, 'Paquetes', 149003.65, 12.00, 1.00, 3, 'active', '2025-01-19'),
(306, 1, 2, 'Compuesto Químico 306', 'CC-5402', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N8N3S7C3', 1, 'Gramos', 298133.31, 12.00, 1.00, 2, 'active', '2025-01-17'),
(307, 4, 2, 'Compuesto Químico 307', 'CC-7114', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N9F4', 27, 'Gramos', 138706.19, 12.00, 1.00, 4, 'active', '2025-02-26'),
(308, 2, 5, 'Compuesto Químico 308', 'CC-8854', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P10H5O9C7O5', 33, 'Mililitros', 90156.07, 12.00, 1.00, 1, 'active', '2025-03-14'),
(309, 4, 5, 'Compuesto Químico 309', 'CC-7937', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: C8S7S5F6', 1, 'Mililitros', 386669.00, 12.00, 1.00, 3, 'active', '2025-03-02'),
(310, 5, 2, 'Compuesto Químico 310', 'CC-7581', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F4C2N9', 38, 'Gramos', 182195.25, 12.00, 1.00, 2, 'active', '2025-01-21'),
(311, 4, 5, 'Compuesto Químico 311', 'CC-3929', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H9P2S8S10', 10, 'Paquetes', 403044.26, 12.00, 1.00, 2, 'active', '2025-02-28'),
(312, 4, 5, 'Compuesto Químico 312', 'CC-3577', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H5O9F5H9P1', 48, 'Mililitros', 299270.94, 12.00, 1.00, 5, 'active', '2025-04-17'),
(313, 5, 4, 'Compuesto Químico 313', 'CC-9991', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P10S4', 30, 'Litros', 126253.62, 12.00, 1.00, 2, 'active', '2025-02-26'),
(314, 3, 1, 'Compuesto Químico 314', 'CC-6638', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F3C10', 40, 'Paquetes', 224917.60, 12.00, 1.00, 2, 'active', '2025-03-04'),
(315, 4, 5, 'Compuesto Químico 315', 'CC-5614', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: C1F5', 3, 'Mililitros', 115633.42, 12.00, 1.00, 1, 'active', '2025-04-08'),
(316, 5, 2, 'Compuesto Químico 316', 'CC-1142', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N8C1C3', 46, 'Kilogramos', 258302.42, 12.00, 1.00, 5, 'active', '2025-03-17'),
(317, 5, 1, 'Compuesto Químico 317', 'CC-4596', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: S3S2', 11, 'Mililitros', 75303.04, 12.00, 1.00, 3, 'active', '2025-04-17'),
(318, 1, 1, 'Compuesto Químico 318', 'CC-9650', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P1F6P3F8', 38, 'Paquetes', 78002.20, 12.00, 1.00, 1, 'active', '2025-01-31'),
(319, 5, 2, 'Compuesto Químico 319', 'CC-3336', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: S10P2H5', 50, 'Paquetes', 333450.89, 12.00, 1.00, 3, 'active', '2025-04-18'),
(320, 1, 3, 'Compuesto Químico 320', 'CC-8402', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O6S5O5', 42, 'Mililitros', 269742.44, 12.00, 1.00, 5, 'active', '2025-04-21'),
(321, 4, 2, 'Compuesto Químico 321', 'CC-3001', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F10C8S5', 28, 'Paquetes', 297346.20, 12.00, 1.00, 3, 'active', '2025-02-23'),
(322, 5, 3, 'Compuesto Químico 322', 'CC-4581', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O2S2S8', 45, 'Litros', 274586.49, 12.00, 1.00, 4, 'active', '2025-03-11'),
(323, 5, 5, 'Compuesto Químico 323', 'CC-446', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O1H9N3N9', 16, 'Gramos', 200339.26, 12.00, 1.00, 3, 'active', '2025-04-08'),
(324, 4, 5, 'Compuesto Químico 324', 'CC-6654', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: C9H2H7S3C1', 47, 'Mililitros', 146776.31, 12.00, 1.00, 4, 'active', '2025-02-14'),
(325, 1, 3, 'Compuesto Químico 325', 'CC-226', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P2N10H6P3', 41, 'Litros', 345491.66, 12.00, 1.00, 2, 'active', '2025-04-12'),
(326, 3, 4, 'Compuesto Químico 326', 'CC-6973', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: C5P8H8H6', 30, 'Paquetes', 415322.76, 12.00, 1.00, 2, 'active', '2025-02-22'),
(327, 1, 5, 'Compuesto Químico 327', 'CC-4352', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: C6N9P5P5', 20, 'Mililitros', 140799.32, 12.00, 1.00, 2, 'active', '2025-04-11'),
(328, 1, 5, 'Compuesto Químico 328', 'CC-7244', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: S9N6S5C5F10', 7, 'Gramos', 250379.57, 12.00, 1.00, 4, 'active', '2025-01-28'),
(329, 3, 3, 'Compuesto Químico 329', 'CC-5952', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: C10N10F2P4', 36, 'Paquetes', 6863.80, 12.00, 1.00, 3, 'active', '2025-04-10'),
(330, 4, 4, 'Compuesto Químico 330', 'CC-5066', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F6P7', 14, 'Paquetes', 427116.50, 12.00, 1.00, 3, 'active', '2025-03-23'),
(331, 3, 3, 'Compuesto Químico 331', 'CC-3434', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N7P8O7H9', 25, 'Gramos', 427345.20, 12.00, 1.00, 5, 'active', '2025-04-10'),
(332, 3, 4, 'Compuesto Químico 332', 'CC-2475', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O3C10', 46, 'Paquetes', 169460.38, 12.00, 1.00, 2, 'active', '2025-02-09'),
(333, 2, 1, 'Compuesto Químico 333', 'CC-76', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N10H4H3', 0, 'Litros', 95586.20, 12.00, 1.00, 5, 'active', '2025-03-13'),
(334, 4, 3, 'Compuesto Químico 334', 'CC-261', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F4P1', 44, 'Kilogramos', 433182.55, 12.00, 1.00, 3, 'active', '2025-03-22'),
(335, 2, 4, 'Compuesto Químico 335', 'CC-950', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H6P4O5N2', 8, 'Gramos', 131356.34, 12.00, 1.00, 4, 'active', '2025-03-10'),
(336, 2, 5, 'Compuesto Químico 336', 'CC-3890', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P7C10F7', 14, 'Kilogramos', 183594.83, 12.00, 1.00, 1, 'active', '2025-03-05'),
(337, 4, 4, 'Compuesto Químico 337', 'CC-3077', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: C6S7C6O5C3', 29, 'Paquetes', 64607.82, 12.00, 1.00, 4, 'active', '2025-02-09'),
(338, 5, 2, 'Compuesto Químico 338', 'CC-1339', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O10S6', 36, 'Litros', 372026.00, 12.00, 1.00, 1, 'active', '2025-04-05'),
(339, 4, 2, 'Compuesto Químico 339', 'CC-3309', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N6O5F2H5S7', 43, 'Kilogramos', 370544.12, 12.00, 1.00, 5, 'active', '2025-03-04'),
(340, 2, 4, 'Compuesto Químico 340', 'CC-1469', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N4H9S7', 46, 'Litros', 398330.84, 12.00, 1.00, 4, 'active', '2025-05-06'),
(341, 3, 3, 'Compuesto Químico 341', 'CC-6526', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F6P4H5H8H9', 28, 'Mililitros', 147459.72, 12.00, 1.00, 1, 'active', '2025-04-01'),
(342, 3, 4, 'Compuesto Químico 342', 'CC-9675', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F5S2S6C5H7', 37, 'Mililitros', 290721.05, 12.00, 1.00, 4, 'active', '2025-03-08'),
(343, 4, 4, 'Compuesto Químico 343', 'CC-2258', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: S7P6N1', 49, 'Litros', 403824.18, 12.00, 1.00, 4, 'active', '2025-04-02'),
(344, 2, 3, 'Compuesto Químico 344', 'CC-4202', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N2O1H1O9', 45, 'Litros', 77320.55, 12.00, 1.00, 2, 'active', '2025-05-09'),
(345, 1, 5, 'Compuesto Químico 345', 'CC-5714', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H9P6', 46, 'Paquetes', 313096.52, 12.00, 1.00, 3, 'active', '2025-03-29'),
(346, 5, 5, 'Compuesto Químico 346', 'CC-3056', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N2N10O7N3', 4, 'Gramos', 256326.82, 12.00, 1.00, 5, 'active', '2025-04-27'),
(347, 4, 1, 'Compuesto Químico 347', 'CC-4147', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H5F3N6O1O6', 32, 'Paquetes', 382296.09, 12.00, 1.00, 1, 'active', '2025-04-18'),
(348, 4, 4, 'Compuesto Químico 348', 'CC-4234', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O3P4O5N9F9', 4, 'Kilogramos', 369030.74, 12.00, 1.00, 1, 'active', '2025-02-01'),
(349, 5, 4, 'Compuesto Químico 349', 'CC-9161', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N10C6N10C7', 18, 'Litros', 62255.74, 12.00, 1.00, 3, 'active', '2025-01-29'),
(350, 2, 5, 'Compuesto Químico 350', 'CC-4233', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: S8S3', 21, 'Paquetes', 390418.73, 12.00, 1.00, 3, 'active', '2025-01-24'),
(351, 5, 5, 'Compuesto Químico 351', 'CC-2008', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F4F6', 2, 'Mililitros', 104479.33, 12.00, 1.00, 1, 'active', '2025-03-09'),
(352, 1, 1, 'Compuesto Químico 352', 'CC-8435', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: C5P1P5', 9, 'Kilogramos', 180156.91, 12.00, 1.00, 4, 'active', '2025-02-05'),
(353, 3, 1, 'Compuesto Químico 353', 'CC-8911', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: S1H1', 19, 'Kilogramos', 472425.03, 12.00, 1.00, 1, 'active', '2025-03-19'),
(354, 5, 5, 'Compuesto Químico 354', 'CC-8756', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F4P7F8C3', 28, 'Litros', 490403.88, 12.00, 1.00, 3, 'active', '2025-04-03'),
(355, 5, 3, 'Compuesto Químico 355', 'CC-3204', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: C9H5S10P3S9', 12, 'Kilogramos', 217255.42, 12.00, 1.00, 3, 'active', '2025-01-25'),
(356, 2, 3, 'Compuesto Químico 356', 'CC-9038', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H8F7', 43, 'Gramos', 127244.25, 12.00, 1.00, 3, 'active', '2025-01-28'),
(357, 3, 1, 'Compuesto Químico 357', 'CC-7085', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O10N9S9O10P2', 18, 'Mililitros', 280977.69, 12.00, 1.00, 4, 'active', '2025-02-20'),
(358, 3, 5, 'Compuesto Químico 358', 'CC-2348', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H3P2N3S5C4', 38, 'Litros', 70177.38, 12.00, 1.00, 3, 'active', '2025-04-24'),
(359, 4, 3, 'Compuesto Químico 359', 'CC-3891', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F8H9N10O2O6', 29, 'Mililitros', 32812.88, 12.00, 1.00, 1, 'active', '2025-05-08'),
(360, 3, 4, 'Compuesto Químico 360', 'CC-1668', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P9P3C6O6', 34, 'Paquetes', 261745.31, 12.00, 1.00, 5, 'active', '2025-04-17'),
(361, 1, 4, 'Compuesto Químico 361', 'CC-9938', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N3P10N8', 42, 'Litros', 211082.59, 12.00, 1.00, 3, 'active', '2025-03-15'),
(362, 1, 1, 'Compuesto Químico 362', 'CC-4475', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: C9P5P10C5H8', 41, 'Mililitros', 154287.95, 12.00, 1.00, 2, 'active', '2025-03-11'),
(363, 1, 3, 'Compuesto Químico 363', 'CC-6059', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N10F9O4S10', 14, 'Gramos', 37906.00, 12.00, 1.00, 4, 'active', '2025-05-02'),
(364, 4, 4, 'Compuesto Químico 364', 'CC-7451', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P8O6N3N7', 18, 'Gramos', 420223.94, 12.00, 1.00, 3, 'active', '2025-04-04'),
(365, 2, 5, 'Compuesto Químico 365', 'CC-9618', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N3S3', 43, 'Kilogramos', 129735.42, 12.00, 1.00, 2, 'active', '2025-02-15'),
(366, 4, 1, 'Compuesto Químico 366', 'CC-1115', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: C1C2P1F9C10', 49, 'Gramos', 385762.81, 12.00, 1.00, 2, 'active', '2025-04-28'),
(367, 4, 2, 'Compuesto Químico 367', 'CC-2725', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F4C2S8S2', 23, 'Gramos', 497090.86, 12.00, 1.00, 3, 'active', '2025-04-13'),
(368, 2, 5, 'Compuesto Químico 368', 'CC-9015', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: S4C6', 30, 'Kilogramos', 211288.99, 12.00, 1.00, 3, 'active', '2025-04-09'),
(369, 4, 2, 'Compuesto Químico 369', 'CC-8578', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: C3P3F7', 8, 'Kilogramos', 336149.88, 12.00, 1.00, 4, 'active', '2025-02-20'),
(370, 4, 1, 'Compuesto Químico 370', 'CC-4885', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: C9S10S6S6', 0, 'Mililitros', 23022.47, 12.00, 1.00, 2, 'active', '2025-04-08'),
(371, 4, 5, 'Compuesto Químico 371', 'CC-9339', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O1H3N7', 7, 'Paquetes', 193738.21, 12.00, 1.00, 1, 'active', '2025-05-08'),
(372, 3, 5, 'Compuesto Químico 372', 'CC-2282', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F6F2P4S2N5', 22, 'Gramos', 86056.16, 12.00, 1.00, 2, 'active', '2025-02-22'),
(373, 2, 1, 'Compuesto Químico 373', 'CC-4610', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F2F9S6P1', 8, 'Gramos', 273972.32, 12.00, 1.00, 3, 'active', '2025-05-11'),
(374, 2, 2, 'Compuesto Químico 374', 'CC-6953', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F7H10O7', 33, 'Litros', 417494.55, 12.00, 1.00, 4, 'active', '2025-01-15'),
(375, 1, 5, 'Compuesto Químico 375', 'CC-7972', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: C1O5', 1, 'Mililitros', 381768.03, 12.00, 1.00, 3, 'active', '2025-02-06'),
(376, 3, 4, 'Compuesto Químico 376', 'CC-699', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H1F7N2O6', 15, 'Kilogramos', 232135.68, 12.00, 1.00, 3, 'active', '2025-01-30'),
(377, 4, 2, 'Compuesto Químico 377', 'CC-5670', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P3P3C4', 44, 'Mililitros', 247527.48, 12.00, 1.00, 4, 'active', '2025-03-28'),
(378, 3, 4, 'Compuesto Químico 378', 'CC-2069', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N10C8O3', 39, 'Kilogramos', 455000.65, 12.00, 1.00, 5, 'active', '2025-02-20'),
(379, 4, 2, 'Compuesto Químico 379', 'CC-2206', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: C8N10', 21, 'Gramos', 457267.00, 12.00, 1.00, 2, 'active', '2025-03-25'),
(380, 4, 3, 'Compuesto Químico 380', 'CC-4580', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H5P5', 32, 'Paquetes', 181803.80, 12.00, 1.00, 2, 'active', '2025-01-22'),
(381, 4, 3, 'Compuesto Químico 381', 'CC-6197', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O6P5F1O8', 16, 'Mililitros', 375987.31, 12.00, 1.00, 3, 'active', '2025-03-01'),
(382, 3, 4, 'Compuesto Químico 382', 'CC-2648', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F3P9C5', 8, 'Litros', 427004.02, 12.00, 1.00, 1, 'active', '2025-04-01'),
(383, 4, 1, 'Compuesto Químico 383', 'CC-8044', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F9N1', 29, 'Gramos', 311527.23, 12.00, 1.00, 4, 'active', '2025-03-30'),
(384, 3, 3, 'Compuesto Químico 384', 'CC-1783', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: S1C6', 19, 'Gramos', 441358.26, 12.00, 1.00, 1, 'active', '2025-02-13'),
(385, 3, 1, 'Compuesto Químico 385', 'CC-5568', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H6H7O1F4C4', 14, 'Mililitros', 378760.07, 12.00, 1.00, 4, 'active', '2025-04-29'),
(386, 5, 2, 'Compuesto Químico 386', 'CC-267', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H1F4C5F2', 0, 'Paquetes', 357727.97, 12.00, 1.00, 4, 'active', '2025-03-18'),
(387, 3, 2, 'Compuesto Químico 387', 'CC-7566', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F2F10F1O8', 3, 'Litros', 60815.97, 12.00, 1.00, 3, 'active', '2025-04-07'),
(388, 2, 5, 'Compuesto Químico 388', 'CC-6758', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O10P9P6', 31, 'Litros', 311216.39, 12.00, 1.00, 5, 'active', '2025-02-04'),
(389, 4, 3, 'Compuesto Químico 389', 'CC-5623', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: C1F3S4S6', 18, 'Litros', 209815.69, 12.00, 1.00, 5, 'active', '2025-04-13'),
(390, 5, 1, 'Compuesto Químico 390', 'CC-4008', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: S2S7S10', 39, 'Mililitros', 86537.08, 12.00, 1.00, 4, 'active', '2025-02-11'),
(391, 2, 2, 'Compuesto Químico 391', 'CC-3926', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O7C6', 3, 'Litros', 206677.94, 12.00, 1.00, 4, 'active', '2025-02-19'),
(392, 2, 4, 'Compuesto Químico 392', 'CC-1581', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O5H7S1', 45, 'Paquetes', 26679.88, 12.00, 1.00, 3, 'active', '2025-01-20'),
(393, 3, 5, 'Compuesto Químico 393', 'CC-1426', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P10N5P9S10S5', 48, 'Kilogramos', 465306.12, 12.00, 1.00, 3, 'active', '2025-01-19'),
(394, 2, 4, 'Compuesto Químico 394', 'CC-4584', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P3P10S4P2', 21, 'Mililitros', 293064.97, 12.00, 1.00, 4, 'active', '2025-02-12'),
(395, 2, 1, 'Compuesto Químico 395', 'CC-9331', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P3C8H3H7', 31, 'Kilogramos', 315093.00, 12.00, 1.00, 2, 'active', '2025-02-28'),
(396, 1, 5, 'Compuesto Químico 396', 'CC-277', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F9S7', 22, 'Litros', 251315.28, 12.00, 1.00, 1, 'active', '2025-03-12'),
(397, 5, 1, 'Compuesto Químico 397', 'CC-6090', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P8O7H10', 37, 'Paquetes', 121469.43, 12.00, 1.00, 3, 'active', '2025-05-01'),
(398, 4, 1, 'Compuesto Químico 398', 'CC-7722', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H1S3F3N5P7', 40, 'Mililitros', 462176.72, 12.00, 1.00, 4, 'active', '2025-03-01'),
(399, 2, 5, 'Compuesto Químico 399', 'CC-4801', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O2F3', 38, 'Kilogramos', 108004.35, 12.00, 1.00, 2, 'active', '2025-02-27'),
(400, 3, 5, 'Compuesto Químico 400', 'CC-4746', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O2O8O5', 19, 'Gramos', 241921.40, 12.00, 1.00, 5, 'active', '2025-04-02'),
(401, 4, 2, 'Compuesto Químico 401', 'CC-3099', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N6O2S1H1S7', 39, 'Paquetes', 228510.52, 12.00, 1.00, 3, 'active', '2025-04-04'),
(402, 5, 1, 'Compuesto Químico 402', 'CC-7515', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F10H9', 19, 'Mililitros', 17169.56, 12.00, 1.00, 2, 'active', '2025-02-11'),
(403, 5, 3, 'Compuesto Químico 403', 'CC-2213', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N2O4P9', 25, 'Paquetes', 425662.88, 12.00, 1.00, 4, 'active', '2025-03-25'),
(404, 4, 4, 'Compuesto Químico 404', 'CC-6118', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P8O8', 0, 'Litros', 481614.24, 12.00, 1.00, 2, 'active', '2025-02-10'),
(405, 5, 2, 'Compuesto Químico 405', 'CC-6730', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F3C1P1S5', 27, 'Mililitros', 478045.05, 12.00, 1.00, 4, 'active', '2025-02-09'),
(406, 2, 4, 'Compuesto Químico 406', 'CC-7627', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F4O5H6', 33, 'Litros', 48228.04, 12.00, 1.00, 3, 'active', '2025-04-28'),
(407, 5, 3, 'Compuesto Químico 407', 'CC-5596', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F5H10', 29, 'Kilogramos', 165166.12, 12.00, 1.00, 1, 'active', '2025-01-20'),
(408, 4, 3, 'Compuesto Químico 408', 'CC-1431', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O9H8C8', 14, 'Paquetes', 490651.54, 12.00, 1.00, 1, 'active', '2025-01-28'),
(409, 5, 2, 'Compuesto Químico 409', 'CC-39', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P10S2S10F10', 5, 'Gramos', 198363.74, 12.00, 1.00, 2, 'active', '2025-03-16'),
(410, 5, 5, 'Compuesto Químico 410', 'CC-7277', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N9P1F6C7', 44, 'Litros', 33192.26, 12.00, 1.00, 5, 'active', '2025-03-12'),
(411, 2, 2, 'Compuesto Químico 411', 'CC-5652', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P2C3P6H2', 41, 'Gramos', 311563.38, 12.00, 1.00, 5, 'active', '2025-03-05'),
(412, 1, 2, 'Compuesto Químico 412', 'CC-2502', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: S5O3O8C9', 7, 'Paquetes', 247919.26, 12.00, 1.00, 3, 'active', '2025-01-22'),
(413, 2, 2, 'Compuesto Químico 413', 'CC-2093', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H7N4H9F1O9', 48, 'Litros', 466984.43, 12.00, 1.00, 1, 'active', '2025-01-26'),
(414, 1, 4, 'Compuesto Químico 414', 'CC-5081', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F6F10', 8, 'Kilogramos', 470406.19, 12.00, 1.00, 5, 'active', '2025-03-03'),
(415, 4, 1, 'Compuesto Químico 415', 'CC-8310', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N7C4S3O10', 0, 'Gramos', 464732.29, 12.00, 1.00, 5, 'active', '2025-03-12'),
(416, 4, 2, 'Compuesto Químico 416', 'CC-6824', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: C8O5N8N5O8', 12, 'Litros', 78811.30, 12.00, 1.00, 2, 'active', '2025-04-16'),
(417, 3, 5, 'Compuesto Químico 417', 'CC-783', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N2O1', 39, 'Mililitros', 470253.93, 12.00, 1.00, 4, 'active', '2025-04-26'),
(418, 2, 1, 'Compuesto Químico 418', 'CC-7873', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: C8S1', 31, 'Mililitros', 410773.55, 12.00, 1.00, 5, 'active', '2025-01-15'),
(419, 2, 4, 'Compuesto Químico 419', 'CC-3706', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H8C2S9', 50, 'Paquetes', 203218.03, 12.00, 1.00, 2, 'active', '2025-04-10'),
(420, 1, 5, 'Compuesto Químico 420', 'CC-8881', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O2N5S8P10', 45, 'Mililitros', 89831.26, 12.00, 1.00, 3, 'active', '2025-03-05'),
(421, 2, 5, 'Compuesto Químico 421', 'CC-8787', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: S2S8F5', 33, 'Mililitros', 121359.56, 12.00, 1.00, 2, 'active', '2025-04-07'),
(422, 1, 5, 'Compuesto Químico 422', 'CC-7751', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O6P1F5N1', 46, 'Kilogramos', 163932.59, 12.00, 1.00, 1, 'active', '2025-01-19'),
(423, 3, 3, 'Compuesto Químico 423', 'CC-9728', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O7H10C8', 12, 'Kilogramos', 455357.37, 12.00, 1.00, 3, 'active', '2025-01-18'),
(424, 5, 4, 'Compuesto Químico 424', 'CC-589', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P2S4H9N2', 24, 'Kilogramos', 409718.46, 12.00, 1.00, 2, 'active', '2025-02-03'),
(425, 3, 5, 'Compuesto Químico 425', 'CC-7281', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H4F6C7H9F9', 8, 'Mililitros', 360147.41, 12.00, 1.00, 4, 'active', '2025-02-04'),
(426, 1, 3, 'Compuesto Químico 426', 'CC-8081', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H3N10O8P4P7', 40, 'Gramos', 111661.94, 12.00, 1.00, 3, 'active', '2025-01-29'),
(427, 2, 1, 'Compuesto Químico 427', 'CC-595', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P9S1', 38, 'Gramos', 299365.67, 12.00, 1.00, 2, 'active', '2025-03-28'),
(428, 5, 3, 'Compuesto Químico 428', 'CC-2479', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N10C4S10', 26, 'Paquetes', 399167.63, 12.00, 1.00, 2, 'active', '2025-03-07'),
(429, 5, 1, 'Compuesto Químico 429', 'CC-4263', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N10H6', 49, 'Gramos', 496073.48, 12.00, 1.00, 2, 'active', '2025-01-24'),
(430, 2, 4, 'Compuesto Químico 430', 'CC-7370', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: C5C4O1P1P10', 23, 'Litros', 2533.93, 12.00, 1.00, 4, 'active', '2025-05-09'),
(431, 5, 2, 'Compuesto Químico 431', 'CC-9834', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: S5H2C10O10', 50, 'Litros', 59734.22, 12.00, 1.00, 3, 'active', '2025-02-19'),
(432, 3, 1, 'Compuesto Químico 432', 'CC-3800', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: C3H3', 45, 'Kilogramos', 134.86, 12.00, 1.00, 5, 'active', '2025-05-05'),
(433, 1, 5, 'Compuesto Químico 433', 'CC-9211', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F6P6C1F7O7', 50, 'Kilogramos', 47594.71, 12.00, 1.00, 5, 'active', '2025-04-23'),
(434, 4, 2, 'Compuesto Químico 434', 'CC-1325', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H7F6P7P1', 0, 'Mililitros', 131644.95, 12.00, 1.00, 2, 'active', '2025-04-29'),
(435, 4, 3, 'Compuesto Químico 435', 'CC-7490', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P2S6C9', 25, 'Kilogramos', 283443.03, 12.00, 1.00, 2, 'active', '2025-02-23'),
(436, 5, 5, 'Compuesto Químico 436', 'CC-596', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: S5P3', 19, 'Mililitros', 256703.10, 12.00, 1.00, 2, 'active', '2025-02-18'),
(437, 2, 3, 'Compuesto Químico 437', 'CC-555', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O5F8S9', 48, 'Gramos', 446734.73, 12.00, 1.00, 5, 'active', '2025-03-12'),
(438, 4, 1, 'Compuesto Químico 438', 'CC-6066', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O1H6H6C1S10', 23, 'Gramos', 40258.22, 12.00, 1.00, 5, 'active', '2025-02-24'),
(439, 2, 3, 'Compuesto Químico 439', 'CC-7497', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H9S9', 16, 'Kilogramos', 449664.08, 12.00, 1.00, 2, 'active', '2025-01-31'),
(440, 1, 2, 'Compuesto Químico 440', 'CC-2086', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: C10F5N2N7', 10, 'Kilogramos', 153680.63, 12.00, 1.00, 2, 'active', '2025-01-14'),
(441, 5, 5, 'Compuesto Químico 441', 'CC-4343', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: S7C6O5F2C1', 13, 'Litros', 167706.94, 12.00, 1.00, 3, 'active', '2025-05-09'),
(442, 4, 5, 'Compuesto Químico 442', 'CC-5450', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: S7N5', 4, 'Mililitros', 302426.22, 12.00, 1.00, 4, 'active', '2025-04-13'),
(443, 5, 3, 'Compuesto Químico 443', 'CC-7014', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: C4N3F7N5', 45, 'Kilogramos', 125476.01, 12.00, 1.00, 1, 'active', '2025-04-03'),
(444, 4, 5, 'Compuesto Químico 444', 'CC-3475', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: S9C1', 45, 'Gramos', 290066.23, 12.00, 1.00, 3, 'active', '2025-05-02'),
(445, 5, 5, 'Compuesto Químico 445', 'CC-1167', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O7O8', 38, 'Gramos', 431154.44, 12.00, 1.00, 1, 'active', '2025-03-23'),
(446, 3, 3, 'Compuesto Químico 446', 'CC-3170', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O6O4S1N1F7', 42, 'Kilogramos', 306815.19, 12.00, 1.00, 2, 'active', '2025-01-29'),
(447, 2, 2, 'Compuesto Químico 447', 'CC-7278', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H5P8C3P4', 38, 'Gramos', 277246.78, 12.00, 1.00, 1, 'active', '2025-04-17'),
(448, 1, 3, 'Compuesto Químico 448', 'CC-8264', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H7P8N2H6', 20, 'Gramos', 270399.24, 12.00, 1.00, 1, 'active', '2025-03-27'),
(449, 3, 1, 'Compuesto Químico 449', 'CC-1627', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F7N4O10S5C4', 26, 'Litros', 62945.12, 12.00, 1.00, 2, 'active', '2025-04-01'),
(450, 1, 4, 'Compuesto Químico 450', 'CC-7567', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O1P1F3S5', 40, 'Mililitros', 40511.99, 12.00, 1.00, 2, 'active', '2025-03-01'),
(451, 1, 3, 'Compuesto Químico 451', 'CC-5659', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: C10F4', 3, 'Mililitros', 25235.12, 12.00, 1.00, 2, 'active', '2025-02-20'),
(452, 4, 4, 'Compuesto Químico 452', 'CC-6697', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P8H1S10P3P3', 6, 'Mililitros', 466018.11, 12.00, 1.00, 4, 'active', '2025-03-11'),
(453, 5, 1, 'Compuesto Químico 453', 'CC-6507', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F2H4H2', 3, 'Kilogramos', 386893.99, 12.00, 1.00, 4, 'active', '2025-01-20'),
(454, 1, 2, 'Compuesto Químico 454', 'CC-872', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N3P1H6', 23, 'Litros', 372765.21, 12.00, 1.00, 4, 'active', '2025-01-18'),
(455, 2, 2, 'Compuesto Químico 455', 'CC-4292', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H6P6H2', 12, 'Paquetes', 32938.47, 12.00, 1.00, 3, 'active', '2025-05-11'),
(456, 4, 4, 'Compuesto Químico 456', 'CC-9058', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O10S1O1P8', 14, 'Mililitros', 232196.64, 12.00, 1.00, 2, 'active', '2025-02-22'),
(457, 2, 3, 'Compuesto Químico 457', 'CC-7194', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O1F6F8C2', 44, 'Kilogramos', 246170.61, 12.00, 1.00, 4, 'active', '2025-03-08'),
(458, 3, 2, 'Compuesto Químico 458', 'CC-7270', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O2S9C1C9H5', 46, 'Kilogramos', 18244.09, 12.00, 1.00, 1, 'active', '2025-03-17'),
(459, 1, 2, 'Compuesto Químico 459', 'CC-6438', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P4C2F10', 7, 'Paquetes', 391250.84, 12.00, 1.00, 2, 'active', '2025-03-08'),
(460, 5, 4, 'Compuesto Químico 460', 'CC-7141', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: S9H3', 25, 'Gramos', 247792.94, 12.00, 1.00, 2, 'active', '2025-04-21'),
(461, 2, 1, 'Compuesto Químico 461', 'CC-5802', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O6P3F6', 23, 'Gramos', 166689.24, 12.00, 1.00, 1, 'active', '2025-02-08'),
(462, 2, 3, 'Compuesto Químico 462', 'CC-8726', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O7O9', 42, 'Gramos', 89881.07, 12.00, 1.00, 2, 'active', '2025-05-04'),
(463, 4, 3, 'Compuesto Químico 463', 'CC-2863', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H10S8P5C1F3', 5, 'Mililitros', 139068.70, 12.00, 1.00, 2, 'active', '2025-02-08'),
(464, 2, 4, 'Compuesto Químico 464', 'CC-7262', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F10C6H10P9', 25, 'Kilogramos', 3812.67, 12.00, 1.00, 1, 'active', '2025-04-04'),
(465, 2, 1, 'Compuesto Químico 465', 'CC-3048', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F8P8N2O1H8', 25, 'Gramos', 194078.82, 12.00, 1.00, 2, 'active', '2025-04-28'),
(466, 4, 1, 'Compuesto Químico 466', 'CC-4041', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N7H7F7S2S7', 43, 'Litros', 449180.76, 12.00, 1.00, 2, 'active', '2025-02-18'),
(467, 1, 1, 'Compuesto Químico 467', 'CC-2571', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P4O6F7P7F6', 42, 'Kilogramos', 202750.66, 12.00, 1.00, 5, 'active', '2025-02-09'),
(468, 1, 4, 'Compuesto Químico 468', 'CC-2081', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P5P8C5', 4, 'Paquetes', 451263.18, 12.00, 1.00, 1, 'active', '2025-02-19'),
(469, 5, 1, 'Compuesto Químico 469', 'CC-4929', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F1H3H6H6', 13, 'Paquetes', 299471.39, 12.00, 1.00, 2, 'active', '2025-05-03'),
(470, 2, 1, 'Compuesto Químico 470', 'CC-2262', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H4H1O10O3', 31, 'Gramos', 171543.77, 12.00, 1.00, 2, 'active', '2025-04-29'),
(471, 3, 5, 'Compuesto Químico 471', 'CC-6508', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F10S8N2', 42, 'Litros', 229917.00, 12.00, 1.00, 4, 'active', '2025-02-14'),
(472, 5, 2, 'Compuesto Químico 472', 'CC-7880', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H5P5', 49, 'Gramos', 289782.04, 12.00, 1.00, 2, 'active', '2025-02-11'),
(473, 2, 3, 'Compuesto Químico 473', 'CC-5399', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: S1H3', 20, 'Kilogramos', 325040.49, 12.00, 1.00, 1, 'active', '2025-04-14'),
(474, 3, 4, 'Compuesto Químico 474', 'CC-9640', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P9P4O8', 30, 'Litros', 273981.20, 12.00, 1.00, 3, 'active', '2025-01-22'),
(475, 2, 3, 'Compuesto Químico 475', 'CC-5746', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: P5F2C10N10F1', 16, 'Paquetes', 338520.62, 12.00, 1.00, 3, 'active', '2025-04-27'),
(476, 4, 3, 'Compuesto Químico 476', 'CC-2480', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: S1N1F7O8', 37, 'Paquetes', 256713.45, 12.00, 1.00, 4, 'active', '2025-01-25'),
(477, 4, 3, 'Compuesto Químico 477', 'CC-7835', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N6O9O10', 13, 'Paquetes', 91556.05, 12.00, 1.00, 5, 'active', '2025-01-18'),
(478, 4, 3, 'Compuesto Químico 478', 'CC-4955', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O1N5N3', 2, 'Mililitros', 252186.06, 12.00, 1.00, 2, 'active', '2025-02-04'),
(479, 1, 4, 'Compuesto Químico 479', 'CC-6814', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H4F7S2S7S10', 30, 'Paquetes', 467691.73, 12.00, 1.00, 5, 'active', '2025-02-27'),
(480, 1, 4, 'Compuesto Químico 480', 'CC-8488', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F7H1P8', 13, 'Mililitros', 499801.65, 12.00, 1.00, 4, 'active', '2025-03-30'),
(481, 1, 4, 'Compuesto Químico 481', 'CC-3338', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O4F8', 33, 'Kilogramos', 120661.21, 12.00, 1.00, 3, 'active', '2025-04-12'),
(482, 2, 4, 'Compuesto Químico 482', 'CC-2875', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H1F3O1', 18, 'Paquetes', 391365.55, 12.00, 1.00, 5, 'active', '2025-03-20'),
(483, 2, 5, 'Compuesto Químico 483', 'CC-1464', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: S5H10C3C8S1', 42, 'Mililitros', 73378.41, 12.00, 1.00, 3, 'active', '2025-02-15'),
(484, 2, 1, 'Compuesto Químico 484', 'CC-8322', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: C1F8F5H9P2', 37, 'Litros', 277382.24, 12.00, 1.00, 2, 'active', '2025-05-09'),
(485, 4, 1, 'Compuesto Químico 485', 'CC-6938', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: S4P2C10P10O2', 45, 'Kilogramos', 61130.26, 12.00, 1.00, 3, 'active', '2025-02-21'),
(486, 2, 1, 'Compuesto Químico 486', 'CC-6917', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H1N2', 5, 'Gramos', 480791.20, 12.00, 1.00, 3, 'active', '2025-02-18'),
(487, 5, 4, 'Compuesto Químico 487', 'CC-4897', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O8C8', 3, 'Paquetes', 491815.97, 12.00, 1.00, 3, 'active', '2025-01-29'),
(488, 1, 2, 'Compuesto Químico 488', 'CC-241', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F1P6O10', 21, 'Litros', 54353.94, 12.00, 1.00, 2, 'active', '2025-02-03'),
(489, 5, 2, 'Compuesto Químico 489', 'CC-8184', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: S2S10', 15, 'Litros', 174518.39, 12.00, 1.00, 3, 'active', '2025-05-02'),
(490, 1, 2, 'Compuesto Químico 490', 'CC-1829', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O4N5P7S7C5', 47, 'Litros', 425749.64, 12.00, 1.00, 5, 'active', '2025-04-12'),
(491, 1, 3, 'Compuesto Químico 491', 'CC-5525', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: S7N3', 3, 'Mililitros', 60254.42, 12.00, 1.00, 4, 'active', '2025-04-07'),
(492, 2, 2, 'Compuesto Químico 492', 'CC-8545', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: N2N9S9N8', 8, 'Kilogramos', 406939.50, 12.00, 1.00, 2, 'active', '2025-05-09'),
(493, 4, 3, 'Compuesto Químico 493', 'CC-8353', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H2F4', 21, 'Gramos', 267988.33, 12.00, 1.00, 1, 'active', '2025-03-09'),
(494, 5, 5, 'Compuesto Químico 494', 'CC-8845', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H10O9H3', 27, 'Litros', 386037.31, 12.00, 1.00, 4, 'active', '2025-04-11'),
(495, 1, 5, 'Compuesto Químico 495', 'CC-3853', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: H3P4C5P10O7', 0, 'Paquetes', 145620.66, 12.00, 1.00, 5, 'active', '2025-03-13'),
(496, 1, 1, 'Compuesto Químico 496', 'CC-2054', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F2P3H5N9C5', 40, 'Kilogramos', 128906.78, 12.00, 1.00, 2, 'active', '2025-04-18'),
(497, 5, 3, 'Compuesto Químico 497', 'CC-4099', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: F7H4', 42, 'Paquetes', 65052.37, 12.00, 1.00, 5, 'active', '2025-05-11'),
(498, 1, 5, 'Compuesto Químico 498', 'CC-1217', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: S6S5H10', 41, 'Mililitros', 88006.36, 12.00, 1.00, 4, 'active', '2025-05-09'),
(499, 5, 4, 'Compuesto Químico 499', 'CC-4128', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: C8P6H9N1N5', 35, 'Kilogramos', 147410.20, 12.00, 1.00, 4, 'active', '2025-02-12');
INSERT INTO `ims_product` (`pid`, `categoryid`, `brandid`, `pname`, `model`, `description`, `quantity`, `unit`, `base_price`, `tax`, `minimum_order`, `supplier`, `status`, `date`) VALUES
(500, 1, 5, 'Compuesto Químico 500 z', 'CC-7052', 'Compuesto químico de alta pureza para uso en laboratorio. Fórmula Química: O7C5C1', 33, 'Litros', 0.00, 0.00, 1.00, 1, 'active', '2025-04-19');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ims_purchase`
--

CREATE TABLE `ims_purchase` (
  `purchase_id` int(11) NOT NULL,
  `supplier_id` varchar(255) NOT NULL,
  `product_id` varchar(255) NOT NULL,
  `quantity` varchar(255) NOT NULL,
  `purchase_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `ims_purchase`
--

INSERT INTO `ims_purchase` (`purchase_id`, `supplier_id`, `product_id`, `quantity`, `purchase_date`) VALUES
(1, '3', '1', '94', '2024-10-09 01:10:07'),
(2, '3', '2', '74', '2024-11-15 01:10:07'),
(3, '4', '3', '58', '2025-01-09 01:10:07'),
(4, '2', '4', '75', '2024-05-17 01:10:07'),
(5, '1', '5', '34', '2024-07-24 01:10:07'),
(6, '2', '6', '47', '2024-11-10 01:10:07'),
(7, '3', '7', '99', '2024-08-22 01:10:07'),
(8, '1', '8', '1', '2024-02-09 01:10:07'),
(9, '4', '9', '31', '2024-05-08 01:10:07'),
(10, '3', '10', '44', '2024-05-03 01:10:07'),
(11, '1', '11', '83', '2024-06-22 01:10:07'),
(12, '2', '12', '4', '2024-11-25 01:10:07'),
(13, '3', '13', '46', '2024-06-20 01:10:07'),
(14, '3', '14', '64', '2024-03-31 01:10:07'),
(15, '1', '15', '82', '2024-01-25 01:10:07'),
(16, '3', '16', '13', '2024-08-21 01:10:07'),
(17, '4', '17', '92', '2024-04-30 01:10:07'),
(18, '4', '18', '83', '2024-04-06 01:10:07'),
(19, '2', '19', '62', '2024-02-17 01:10:07'),
(20, '4', '20', '75', '2024-05-27 01:10:07'),
(21, '5', '21', '84', '2024-09-11 01:10:07'),
(22, '1', '22', '96', '2024-11-09 01:10:07'),
(23, '1', '23', '66', '2024-11-23 01:10:07'),
(24, '4', '24', '34', '2024-08-06 01:10:07'),
(25, '1', '25', '60', '2024-08-11 01:10:07'),
(26, '2', '26', '46', '2024-10-26 01:10:07'),
(27, '4', '27', '1', '2024-03-14 01:10:07'),
(28, '1', '28', '34', '2024-11-13 01:10:07'),
(29, '5', '29', '68', '2024-03-08 01:10:07'),
(30, '2', '30', '70', '2024-04-24 01:10:07'),
(31, '3', '31', '52', '2024-01-26 01:10:07'),
(32, '2', '32', '55', '2024-02-29 01:10:07'),
(33, '4', '33', '1', '2024-03-03 01:10:07'),
(34, '2', '34', '93', '2024-04-30 01:10:07'),
(35, '4', '35', '72', '2024-10-11 01:10:07'),
(36, '1', '36', '1', '2024-07-02 01:10:07'),
(37, '4', '37', '81', '2024-01-23 01:10:07'),
(38, '3', '38', '40', '2024-06-13 01:10:07'),
(39, '4', '39', '1', '2024-04-12 01:10:07'),
(40, '4', '40', '59', '2024-06-09 01:10:07'),
(41, '2', '41', '46', '2024-07-10 01:10:07'),
(42, '2', '42', '54', '2025-01-11 01:10:07'),
(43, '3', '43', '22', '2024-04-23 01:10:07'),
(44, '5', '44', '79', '2024-02-07 01:10:07'),
(45, '2', '45', '83', '2024-11-20 01:10:07'),
(46, '2', '46', '91', '2024-04-28 01:10:07'),
(47, '5', '47', '11', '2024-01-16 01:10:07'),
(48, '4', '48', '30', '2024-07-14 01:10:07'),
(49, '4', '49', '65', '2024-09-18 01:10:07'),
(50, '4', '50', '47', '2024-10-08 01:10:07'),
(51, '5', '51', '90', '2024-05-23 01:10:07'),
(52, '3', '52', '81', '2024-08-31 01:10:07'),
(53, '3', '53', '15', '2024-08-26 01:10:07'),
(54, '3', '54', '24', '2024-04-19 01:10:07'),
(55, '5', '55', '71', '2024-06-11 01:10:07'),
(56, '5', '56', '42', '2024-06-20 01:10:07'),
(57, '3', '57', '26', '2024-07-17 01:10:07'),
(58, '4', '58', '5', '2024-11-27 01:10:07'),
(59, '3', '59', '13', '2024-11-29 01:10:07'),
(60, '2', '60', '86', '2024-06-29 01:10:07'),
(61, '1', '61', '12', '2024-11-28 01:10:07'),
(62, '2', '62', '7', '2024-08-07 01:10:07'),
(63, '1', '63', '73', '2024-06-15 01:10:07'),
(64, '4', '64', '2', '2024-03-26 01:10:07'),
(65, '5', '65', '51', '2024-06-25 01:10:07'),
(66, '2', '66', '72', '2024-04-21 01:10:07'),
(67, '3', '67', '44', '2024-06-16 01:10:07'),
(68, '3', '68', '27', '2024-07-08 01:10:07'),
(69, '5', '69', '49', '2025-01-08 01:10:07'),
(70, '4', '70', '100', '2024-11-27 01:10:07'),
(71, '4', '71', '3', '2024-12-12 01:10:07'),
(72, '2', '72', '54', '2024-06-08 01:10:07'),
(73, '2', '73', '16', '2024-06-11 01:10:07'),
(74, '3', '74', '77', '2024-09-25 01:10:07'),
(75, '2', '75', '15', '2024-12-05 01:10:07'),
(76, '1', '76', '19', '2024-06-07 01:10:07'),
(77, '3', '77', '56', '2024-09-04 01:10:07'),
(78, '1', '78', '58', '2024-07-28 01:10:07'),
(79, '4', '79', '67', '2024-07-23 01:10:07'),
(80, '3', '80', '61', '2024-04-02 01:10:07'),
(81, '1', '81', '27', '2024-01-30 01:10:07'),
(82, '5', '82', '8', '2024-08-17 01:10:07'),
(83, '5', '83', '86', '2024-03-20 01:10:07'),
(84, '3', '84', '25', '2024-06-01 01:10:07'),
(85, '2', '85', '91', '2024-08-01 01:10:07'),
(86, '3', '86', '44', '2024-07-09 01:10:07'),
(87, '2', '87', '76', '2024-01-22 01:10:07'),
(88, '4', '88', '26', '2024-09-07 01:10:07'),
(89, '1', '89', '98', '2024-03-10 01:10:07'),
(90, '2', '90', '5', '2024-10-13 01:10:07'),
(91, '1', '91', '95', '2024-09-28 01:10:07'),
(92, '4', '92', '33', '2024-04-27 01:10:07'),
(93, '4', '93', '86', '2024-07-22 01:10:07'),
(94, '5', '94', '73', '2024-11-28 01:10:07'),
(95, '3', '95', '95', '2024-09-24 01:10:07'),
(96, '4', '96', '61', '2024-02-22 01:10:07'),
(97, '4', '97', '66', '2024-10-03 01:10:07'),
(98, '3', '98', '32', '2024-10-06 01:10:07'),
(99, '3', '99', '32', '2024-09-21 01:10:07'),
(100, '4', '100', '11', '2024-05-06 01:10:07'),
(101, '1', '101', '66', '2024-03-08 01:10:07'),
(102, '2', '102', '93', '2024-04-29 01:10:07'),
(103, '4', '103', '83', '2024-04-16 01:10:07'),
(104, '2', '104', '8', '2024-06-15 01:10:07'),
(105, '4', '105', '68', '2024-09-11 01:10:07'),
(106, '4', '106', '33', '2024-06-09 01:10:07'),
(107, '1', '107', '37', '2024-04-22 01:10:07'),
(108, '3', '108', '59', '2024-10-05 01:10:07'),
(109, '4', '109', '23', '2024-10-03 01:10:07'),
(110, '4', '110', '87', '2024-12-16 01:10:07'),
(111, '5', '111', '84', '2024-04-28 01:10:07'),
(112, '1', '112', '25', '2025-01-10 01:10:07'),
(113, '2', '113', '49', '2024-07-09 01:10:07'),
(114, '1', '114', '8', '2024-01-15 01:10:07'),
(115, '4', '115', '83', '2024-03-07 01:10:07'),
(116, '4', '116', '39', '2024-06-25 01:10:07'),
(117, '4', '117', '43', '2024-10-02 01:10:07'),
(118, '1', '118', '84', '2024-04-06 01:10:07'),
(119, '2', '119', '48', '2024-09-24 01:10:07'),
(120, '1', '120', '58', '2024-06-21 01:10:07'),
(121, '1', '121', '85', '2024-02-20 01:10:07'),
(122, '5', '122', '13', '2024-04-14 01:10:07'),
(123, '2', '123', '60', '2024-03-06 01:10:07'),
(124, '3', '124', '97', '2024-09-20 01:10:07'),
(125, '4', '125', '45', '2024-11-10 01:10:07'),
(126, '3', '126', '25', '2024-06-29 01:10:07'),
(127, '5', '127', '37', '2024-03-20 01:10:07'),
(128, '1', '128', '61', '2024-01-19 01:10:07'),
(129, '1', '129', '63', '2024-04-13 01:10:07'),
(130, '5', '130', '28', '2024-05-16 01:10:07'),
(131, '3', '131', '46', '2024-03-19 01:10:07'),
(132, '4', '132', '21', '2024-03-21 01:10:07'),
(133, '3', '133', '94', '2024-10-24 01:10:07'),
(134, '2', '134', '96', '2024-04-01 01:10:07'),
(135, '1', '135', '6', '2025-01-10 01:10:07'),
(136, '5', '136', '45', '2024-07-04 01:10:07'),
(137, '2', '137', '4', '2024-11-09 01:10:07'),
(138, '5', '138', '51', '2024-12-07 01:10:07'),
(139, '5', '139', '65', '2024-10-15 01:10:07'),
(140, '2', '140', '81', '2024-12-08 01:10:07'),
(141, '1', '141', '10', '2024-10-16 01:10:07'),
(142, '5', '142', '95', '2024-02-17 01:10:07'),
(143, '4', '143', '84', '2024-12-25 01:10:07'),
(144, '4', '144', '61', '2024-04-03 01:10:07'),
(145, '1', '145', '10', '2024-11-02 01:10:07'),
(146, '4', '146', '96', '2024-05-24 01:10:07'),
(147, '2', '147', '81', '2025-01-12 01:10:07'),
(148, '3', '148', '97', '2024-12-28 01:10:07'),
(149, '2', '149', '47', '2024-08-25 01:10:07'),
(150, '3', '150', '49', '2024-03-12 01:10:07'),
(151, '4', '151', '23', '2024-02-22 01:10:07'),
(152, '4', '152', '25', '2024-03-10 01:10:07'),
(153, '3', '153', '5', '2024-05-09 01:10:07'),
(154, '2', '154', '32', '2024-04-10 01:10:07'),
(155, '5', '155', '2', '2024-07-17 01:10:07'),
(156, '3', '156', '67', '2024-12-27 01:10:07'),
(157, '2', '157', '2', '2024-08-27 01:10:07'),
(158, '5', '158', '20', '2024-09-05 01:10:07'),
(159, '2', '159', '99', '2024-10-02 01:10:07'),
(160, '3', '160', '48', '2024-01-18 01:10:07'),
(161, '3', '161', '63', '2024-06-26 01:10:07'),
(162, '5', '162', '83', '2024-08-11 01:10:07'),
(163, '4', '163', '1', '2024-12-16 01:10:07'),
(164, '2', '164', '59', '2024-03-11 01:10:07'),
(165, '3', '165', '79', '2024-07-08 01:10:07'),
(166, '2', '166', '70', '2024-04-22 01:10:07'),
(167, '3', '167', '61', '2024-09-03 01:10:07'),
(168, '5', '168', '89', '2024-08-09 01:10:07'),
(169, '3', '169', '25', '2024-04-26 01:10:07'),
(170, '5', '170', '9', '2024-02-29 01:10:07'),
(171, '1', '171', '99', '2024-06-22 01:10:07'),
(172, '5', '172', '59', '2024-09-04 01:10:07'),
(173, '1', '173', '17', '2024-05-11 01:10:07'),
(174, '5', '174', '45', '2024-07-09 01:10:07'),
(175, '2', '175', '78', '2024-12-11 01:10:07'),
(176, '1', '176', '35', '2024-09-07 01:10:07'),
(177, '4', '177', '60', '2024-03-30 01:10:07'),
(178, '1', '178', '51', '2025-01-09 01:10:07'),
(179, '3', '179', '63', '2024-07-03 01:10:07'),
(180, '4', '180', '35', '2024-09-09 01:10:07'),
(181, '4', '181', '50', '2024-09-04 01:10:07'),
(182, '2', '182', '50', '2024-07-03 01:10:07'),
(183, '1', '183', '29', '2024-02-17 01:10:07'),
(184, '4', '184', '64', '2024-11-13 01:10:07'),
(185, '5', '185', '17', '2025-01-09 01:10:07'),
(186, '3', '186', '82', '2024-09-01 01:10:07'),
(187, '3', '187', '90', '2024-10-11 01:10:07'),
(188, '4', '188', '31', '2024-05-09 01:10:07'),
(189, '3', '189', '42', '2024-06-04 01:10:07'),
(190, '5', '190', '19', '2024-07-03 01:10:07'),
(191, '1', '191', '87', '2024-12-21 01:10:07'),
(192, '4', '192', '39', '2024-04-02 01:10:07'),
(193, '4', '193', '46', '2024-01-23 01:10:07'),
(194, '3', '194', '71', '2024-02-05 01:10:07'),
(195, '3', '195', '17', '2025-01-04 01:10:07'),
(196, '4', '196', '13', '2024-05-09 01:10:07'),
(197, '1', '197', '23', '2024-01-28 01:10:07'),
(198, '1', '198', '82', '2024-05-27 01:10:07'),
(199, '4', '199', '81', '2024-04-01 01:10:07'),
(200, '3', '200', '29', '2024-03-14 01:10:07');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ims_supplier`
--

CREATE TABLE `ims_supplier` (
  `supplier_id` int(11) NOT NULL,
  `supplier_name` varchar(200) NOT NULL,
  `mobile` varchar(50) NOT NULL,
  `address` text NOT NULL,
  `status` enum('active','inactive') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `ims_supplier`
--

INSERT INTO `ims_supplier` (`supplier_id`, `supplier_name`, `mobile`, `address`, `status`) VALUES
(1, 'ChemSupply Inc.', '3054567890', 'Av. Química 123', 'active'),
(2, 'Global Chemical Distributors', '3056789012', 'Calle Reactivos 456', 'active'),
(3, 'Lab Essentials', '3058901234', 'Carrera Científica 789', 'active'),
(4, 'Chemical Solutions Corp', '3051234567', 'Diagonal Molecular 234', 'active'),
(5, 'Pure Chemicals Ltd', '3059876543', 'Avenida Laboratorio 567', 'active');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ims_user`
--

CREATE TABLE `ims_user` (
  `userid` int(11) NOT NULL,
  `email` varchar(200) NOT NULL,
  `password` varchar(200) NOT NULL,
  `name` varchar(200) NOT NULL,
  `type` enum('admin','member') NOT NULL,
  `status` enum('Active','Inactive') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `ims_user`
--

INSERT INTO `ims_user` (`userid`, `email`, `password`, `name`, `type`, `status`) VALUES
(1, 'lab@levapan.com', '25f9e794323b453885f5181f1b624d0b', 'administrador', 'admin', 'Active');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `ims_brand`
--
ALTER TABLE `ims_brand`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `ims_category`
--
ALTER TABLE `ims_category`
  ADD PRIMARY KEY (`categoryid`);

--
-- Indices de la tabla `ims_customer`
--
ALTER TABLE `ims_customer`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `ims_order`
--
ALTER TABLE `ims_order`
  ADD PRIMARY KEY (`order_id`);

--
-- Indices de la tabla `ims_product`
--
ALTER TABLE `ims_product`
  ADD PRIMARY KEY (`pid`);

--
-- Indices de la tabla `ims_purchase`
--
ALTER TABLE `ims_purchase`
  ADD PRIMARY KEY (`purchase_id`);

--
-- Indices de la tabla `ims_supplier`
--
ALTER TABLE `ims_supplier`
  ADD PRIMARY KEY (`supplier_id`);

--
-- Indices de la tabla `ims_user`
--
ALTER TABLE `ims_user`
  ADD PRIMARY KEY (`userid`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `ims_brand`
--
ALTER TABLE `ims_brand`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `ims_category`
--
ALTER TABLE `ims_category`
  MODIFY `categoryid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `ims_customer`
--
ALTER TABLE `ims_customer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `ims_order`
--
ALTER TABLE `ims_order`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=259;

--
-- AUTO_INCREMENT de la tabla `ims_product`
--
ALTER TABLE `ims_product`
  MODIFY `pid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=501;

--
-- AUTO_INCREMENT de la tabla `ims_purchase`
--
ALTER TABLE `ims_purchase`
  MODIFY `purchase_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=201;

--
-- AUTO_INCREMENT de la tabla `ims_supplier`
--
ALTER TABLE `ims_supplier`
  MODIFY `supplier_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `ims_user`
--
ALTER TABLE `ims_user`
  MODIFY `userid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
