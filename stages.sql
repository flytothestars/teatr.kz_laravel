-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: mysql
-- Generation Time: Dec 10, 2020 at 03:46 PM
-- Server version: 8.0.12
-- PHP Version: 7.2.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `stages`
--

-- --------------------------------------------------------

--
-- Table structure for table `activity_log`
--

CREATE TABLE `activity_log` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `log_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subject_id` bigint(20) UNSIGNED DEFAULT NULL,
  `causer_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `causer_id` bigint(20) UNSIGNED DEFAULT NULL,
  `properties` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` json DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `title`, `active`, `created_at`, `updated_at`) VALUES
(1, '{\"kz\": \"Театр\", \"ru\": \"Театр\"}', 1, '2020-11-26 09:52:02', '2020-11-26 09:52:02');

-- --------------------------------------------------------

--
-- Table structure for table `cities`
--

CREATE TABLE `cities` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` json DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cities`
--

INSERT INTO `cities` (`id`, `title`, `active`) VALUES
(1, '{\"kz\": \"Алматы\", \"ru\": \"Алматы\"}', 1);

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `api_id` bigint(20) UNSIGNED DEFAULT NULL,
  `api` enum('lermontov','gatob','sats') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` json DEFAULT NULL,
  `description` json DEFAULT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `ticket_design_id` bigint(20) UNSIGNED NOT NULL,
  `organizator_id` bigint(20) UNSIGNED DEFAULT NULL,
  `min_price` mediumint(8) UNSIGNED DEFAULT NULL,
  `max_price` mediumint(8) UNSIGNED DEFAULT NULL,
  `duration` smallint(5) UNSIGNED DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `events`
--

INSERT INTO `events` (`id`, `api_id`, `api`, `title`, `description`, `category_id`, `ticket_design_id`, `organizator_id`, `min_price`, `max_price`, `duration`, `active`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, NULL, NULL, '{\"kz\": null, \"ru\": \"Зовите меня Джордж\"}', '{\"kz\": \"<p><em>вввв</em></p>\", \"ru\": \"<p>фывафыва</p>\"}', 1, 1, NULL, NULL, NULL, NULL, 1, '2020-11-26 10:41:55', '2020-11-30 10:56:01', NULL),
(2, NULL, NULL, '{\"kz\": \"Счастливые поют\", \"ru\": \"Счастливые поют\"}', '{\"kz\": null}', 1, 1, NULL, NULL, NULL, NULL, 1, '2020-12-09 15:09:36', '2020-12-09 15:09:36', NULL),
(3, 4010, 'lermontov', '{\"ru\": \"МОЙ ПАПА - ПИТЕР ПЭН\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:38', '2020-12-10 10:48:21', NULL),
(4, 3990, 'lermontov', '{\"ru\": \"ЖИЛИ -БЫЛИ\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:38', '2020-12-10 10:48:21', NULL),
(5, 3998, 'lermontov', '{\"ru\": \"ОСЕННЯЯ СОНАТА\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:38', '2020-12-10 10:48:21', NULL),
(6, 3999, 'lermontov', '{\"ru\": \"ТРАНСФЕР\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:38', '2020-12-10 10:48:21', NULL),
(7, 4011, 'lermontov', '{\"ru\": \"ВИЗИТЫ К МИСТЕРУ ГРИНУ\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:38', '2020-12-10 10:48:21', NULL),
(8, 4000, 'lermontov', '{\"ru\": \"АЛЕНЬКИЙ ЦВЕТОЧЕК\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:38', '2020-12-10 10:48:21', NULL),
(9, 4001, 'lermontov', '{\"ru\": \"ВОЛКИ И ОВЦЫ\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:38', '2020-12-10 10:48:21', NULL),
(10, 4002, 'lermontov', '{\"ru\": \"ЖИЛИ -БЫЛИ\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:38', '2020-12-10 10:48:21', NULL),
(11, 4003, 'lermontov', '{\"ru\": \"ИНТИМНАЯ КОМЕДИЯ\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:38', '2020-12-10 10:48:21', NULL),
(12, 4012, 'lermontov', '{\"ru\": \"УРОКИ ФРАНЦУЗСКОГО (Месье Амедей)\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:38', '2020-12-10 10:48:21', NULL),
(13, 4013, 'lermontov', '{\"ru\": \"ДЖУТ\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:38', '2020-12-10 10:48:21', NULL),
(14, 4004, 'lermontov', '{\"ru\": \"ЖИЖИ (СТРАСТИ НА ЛАЗУРНОМ БЕРЕГУ)\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:38', '2020-12-10 10:48:21', NULL),
(15, 4005, 'lermontov', '{\"ru\": \"ПИЖАМА НА ШЕСТЕРЫХ\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:38', '2020-12-10 10:48:21', NULL),
(16, 4014, 'lermontov', '{\"ru\": \"МАЛЫЕ СУПРУЖЕСКИЕ ЗЛОДЕЯНИЯ\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:38', '2020-12-10 10:48:21', NULL),
(17, 4015, 'lermontov', '{\"ru\": \"ЧТО ХОЧЕТ ЖЕНЩИНА...\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:38', '2020-12-10 10:48:21', NULL),
(18, 4006, 'lermontov', '{\"ru\": \"ТРАМВАЙ \\\"ЖЕЛАНИЕ\\\"\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:38', '2020-12-10 10:48:21', NULL),
(19, 4007, 'lermontov', '{\"ru\": \"ОСЕННЯЯ СОНАТА\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:38', '2020-12-10 10:48:21', NULL),
(20, 4017, 'lermontov', '{\"ru\": \"\\\"РОЖДЕСТВЕНСКИЙ ДЖАЗ\\\" ИРЭНА АРАВИНА И BIG BAND\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:38', '2020-12-10 10:48:21', NULL),
(21, 4018, 'lermontov', '{\"ru\": \"\\\"РОЖДЕСТВЕНСКИЙ ДЖАЗ\\\" ИРЭНА АРАВИНА И BIG BAND\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:38', '2020-12-10 10:48:21', NULL),
(22, 3975, 'lermontov', '{\"ru\": \"БЕСЦЕННЫЙ ДАР\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:38', '2020-12-10 10:48:21', NULL),
(23, 3976, 'lermontov', '{\"ru\": \"БЕСЦЕННЫЙ ДАР\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:38', '2020-12-10 10:48:21', NULL),
(24, 3977, 'lermontov', '{\"ru\": \"БЕСЦЕННЫЙ ДАР\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:38', '2020-12-10 10:48:21', NULL),
(25, 3978, 'lermontov', '{\"ru\": \"БЕСЦЕННЫЙ ДАР\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:38', '2020-12-10 10:48:22', NULL),
(26, 3980, 'lermontov', '{\"ru\": \"БЕСЦЕННЫЙ ДАР\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:38', '2020-12-10 10:48:22', NULL),
(27, 3981, 'lermontov', '{\"ru\": \"БЕСЦЕННЫЙ ДАР\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:38', '2020-12-10 10:48:22', NULL),
(28, 3982, 'lermontov', '{\"ru\": \"БЕСЦЕННЫЙ ДАР\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:38', '2020-12-10 10:48:22', NULL),
(29, 3983, 'lermontov', '{\"ru\": \"БЕСЦЕННЫЙ ДАР\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:38', '2020-12-10 10:48:22', NULL),
(30, 3984, 'lermontov', '{\"ru\": \"БЕСЦЕННЫЙ ДАР\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:38', '2020-12-10 10:48:22', NULL),
(31, 3985, 'lermontov', '{\"ru\": \"БЕСЦЕННЫЙ ДАР\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:38', '2020-12-10 10:48:22', NULL),
(32, 3986, 'lermontov', '{\"ru\": \"БЕСЦЕННЫЙ ДАР\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:38', '2020-12-10 10:48:22', NULL),
(33, 3987, 'lermontov', '{\"ru\": \"БЕСЦЕННЫЙ ДАР\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:38', '2020-12-10 10:48:22', NULL),
(34, 3988, 'lermontov', '{\"ru\": \"БЕСЦЕННЫЙ ДАР\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:38', '2020-12-10 10:48:22', NULL),
(35, 4019, 'lermontov', '{\"ru\": \"БЕСЦЕННЫЙ ДАР\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:38', '2020-12-10 10:48:22', NULL),
(36, 4020, 'lermontov', '{\"ru\": \"БЕСЦЕННЫЙ ДАР\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:38', '2020-12-10 10:48:22', NULL),
(37, 4021, 'lermontov', '{\"ru\": \"БЕСЦЕННЫЙ ДАР\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:38', '2020-12-10 10:48:22', NULL),
(38, 4024, 'lermontov', '{\"ru\": \"БЕСЦЕННЫЙ ДАР\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:38', '2020-12-10 10:48:22', NULL),
(39, 4025, 'lermontov', '{\"ru\": \"БЕСЦЕННЫЙ ДАР\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:38', '2020-12-10 10:48:22', NULL),
(40, 4026, 'lermontov', '{\"ru\": \"БЕСЦЕННЫЙ ДАР\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:38', '2020-12-10 10:48:22', NULL),
(41, 4027, 'lermontov', '{\"ru\": \"БЕСЦЕННЫЙ ДАР\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:38', '2020-12-10 10:48:22', NULL),
(42, 4028, 'lermontov', '{\"ru\": \"БЕСЦЕННЫЙ ДАР\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:38', '2020-12-10 10:48:22', NULL),
(43, 4029, 'lermontov', '{\"ru\": \"БЕСЦЕННЫЙ ДАР\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:38', '2020-12-10 10:48:22', NULL),
(44, 4030, 'lermontov', '{\"ru\": \"ОСЕННЯЯ СОНАТА\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:38', '2020-12-10 10:48:22', NULL),
(45, 4051, 'lermontov', '{\"ru\": \"ВИЗИТЫ К МИСТЕРУ ГРИНУ\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:38', '2020-12-10 10:48:22', NULL),
(46, 4052, 'lermontov', '{\"ru\": \"УРОКИ ФРАНЦУЗСКОГО (Месье Амедей)\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:38', '2020-12-10 10:48:22', NULL),
(47, 4031, 'lermontov', '{\"ru\": \"ИНТИМНАЯ КОМЕДИЯ\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:38', '2020-12-10 10:48:22', NULL),
(48, 4032, 'lermontov', '{\"ru\": \"ПРИМАДОННЫ\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:38', '2020-12-10 10:48:22', NULL),
(49, 4053, 'lermontov', '{\"ru\": \"МОЙ ПАПА - ПИТЕР ПЭН\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:38', '2020-12-10 10:48:22', NULL),
(50, 4033, 'lermontov', '{\"ru\": \"ВЕРНАЯ ЖЕНА\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:38', '2020-12-10 10:48:22', NULL),
(51, 4034, 'lermontov', '{\"ru\": \"ЖИЖИ (СТРАСТИ НА ЛАЗУРНОМ БЕРЕГУ)\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:38', '2020-12-10 10:48:22', NULL),
(52, 4035, 'lermontov', '{\"ru\": \"ПИЖАМА НА ШЕСТЕРЫХ\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:38', '2020-12-10 10:48:22', NULL),
(53, 4054, 'lermontov', '{\"ru\": \"ЧТО ХОЧЕТ ЖЕНЩИНА...\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:38', '2020-12-10 10:48:22', NULL),
(54, 4036, 'lermontov', '{\"ru\": \"ВОЛКИ И ОВЦЫ\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:38', '2020-12-10 10:48:22', NULL),
(55, 4037, 'lermontov', '{\"ru\": \"ЖИЛИ -БЫЛИ\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:38', '2020-12-10 10:48:22', NULL),
(56, 4038, 'lermontov', '{\"ru\": \"ОДНАЖДЫ В ГЛОСТЕРЕ\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:38', '2020-12-10 10:48:22', NULL),
(57, 4055, 'lermontov', '{\"ru\": \"УРОКИ ФРАНЦУЗСКОГО (Месье Амедей)\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:38', '2020-12-10 10:48:22', NULL),
(58, 4056, 'lermontov', '{\"ru\": \"МОЙ ПАПА - ПИТЕР ПЭН\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:38', '2020-12-10 10:48:22', NULL),
(59, 4039, 'lermontov', '{\"ru\": \"ВДОВИЙ ПАРОХОД\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:38', '2020-12-10 10:48:22', NULL),
(60, 4040, 'lermontov', '{\"ru\": \"РЕВИЗОР\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:38', '2020-12-10 10:48:22', NULL),
(61, 4041, 'lermontov', '{\"ru\": \"О МЫШАХ И ЛЮДЯХ\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:39', '2020-12-10 10:48:22', NULL),
(62, 4042, 'lermontov', '{\"ru\": \"ЖИЖИ (СТРАСТИ НА ЛАЗУРНОМ БЕРЕГУ)\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:39', '2020-12-10 10:48:22', NULL),
(63, 4057, 'lermontov', '{\"ru\": \"ДЖУТ\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:39', '2020-12-10 10:48:22', NULL),
(64, 4058, 'lermontov', '{\"ru\": \"МАЛЫЕ СУПРУЖЕСКИЕ ЗЛОДЕЯНИЯ\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:39', '2020-12-10 10:48:22', NULL),
(65, 4043, 'lermontov', '{\"ru\": \"УЖИН С ДУРАКОМ\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:39', '2020-12-10 10:48:22', NULL),
(66, 4044, 'lermontov', '{\"ru\": \"ОСЕННЯЯ СОНАТА\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:39', '2020-12-10 10:48:23', NULL),
(67, 4059, 'lermontov', '{\"ru\": \"ВИЗИТЫ К МИСТЕРУ ГРИНУ\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:39', '2020-12-10 10:48:23', NULL),
(68, 4045, 'lermontov', '{\"ru\": \"ТРАНСФЕР\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:39', '2020-12-10 10:48:23', NULL),
(69, 4046, 'lermontov', '{\"ru\": \"МНОГО ШУМА ИЗ НИЧЕГО\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:39', '2020-12-10 10:48:23', NULL),
(70, 4047, 'lermontov', '{\"ru\": \"ФИЛУМЕНА\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:39', '2020-12-10 10:48:23', NULL),
(71, 4048, 'lermontov', '{\"ru\": \"АНДАЛУЗСКОЕ ПРОКЛЯТИЕ\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:39', '2020-12-10 10:48:23', NULL),
(72, 4049, 'lermontov', '{\"ru\": \"СНЕГУРОЧКА. НЕ СКАЗКА\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:39', '2020-12-10 10:48:23', NULL),
(73, 4050, 'lermontov', '{\"ru\": \"ВОЛКИ И ОВЦЫ\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:39', '2020-12-10 10:48:23', NULL),
(74, 4061, 'lermontov', '{\"ru\": \"ЧТО ХОЧЕТ ЖЕНЩИНА...\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:39', '2020-12-10 10:48:23', NULL),
(75, 4062, 'lermontov', '{\"ru\": \"L.O.V.E.JAZZ\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:39', '2020-12-10 10:48:23', NULL),
(76, 4063, 'lermontov', '{\"ru\": \"L.O.V.E.JAZZ\"}', '{}', 1, 1, NULL, 0, 0, NULL, 1, '2020-12-10 10:38:39', '2020-12-10 10:48:23', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(85, '2014_10_12_000000_create_users_table', 1),
(86, '2014_10_12_100000_create_password_resets_table', 1),
(87, '2019_08_19_000000_create_failed_jobs_table', 1),
(88, '2020_11_25_122200_create_permission_tables', 1),
(89, '2020_11_25_122443_create_activity_log_table', 1),
(90, '2020_11_25_123000_create_cities_table', 1),
(91, '2020_11_25_124000_create_spacemedia_table', 1),
(92, '2020_11_25_125000_create_venues_table', 1),
(93, '2020_11_25_130000_create_sections_table', 1),
(94, '2020_11_25_131000_create_categories_table', 1),
(95, '2020_11_25_132000_create_ticket_designs_table', 1),
(96, '2020_11_25_133000_create_events_table', 1),
(97, '2020_11_25_134000_create_venue_schemes_table', 1),
(98, '2020_11_25_135000_create_timetables_table', 1),
(99, '2020_11_25_140000_create_pricegroups_table', 1),
(100, '2020_11_25_141000_create_tickets_table', 1),
(101, '2020_11_25_142000_create_orders_table', 1),
(102, '2020_11_25_143000_create_order_items_table', 1),
(103, '2020_11_25_144000_create_settings_table', 1),
(104, '2014_10_12_200000_add_two_factor_columns_to_users_table', 2),
(105, '2019_12_14_000001_create_personal_access_tokens_table', 2),
(106, '2020_11_26_040724_create_sessions_table', 2),
(107, '2020_11_26_144000_create_seats_table', 3);

-- --------------------------------------------------------

--
-- Table structure for table `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'App\\Models\\General\\User', 1);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `timetable_id` bigint(20) UNSIGNED NOT NULL,
  `api` enum('lermontov','gatob','sats') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `comment` text COLLATE utf8mb4_unicode_ci,
  `price` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `pay_id` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pay_sum` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `pay_date` datetime DEFAULT NULL,
  `pay_system` enum('cash','card') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pay_url` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hash` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ip` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `paid` tinyint(1) NOT NULL DEFAULT '0',
  `sent` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=COMPACT;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `timetable_id`, `api`, `user_id`, `name`, `email`, `phone`, `comment`, `price`, `pay_id`, `pay_sum`, `pay_date`, `pay_system`, `pay_url`, `hash`, `ip`, `paid`, `sent`, `created_at`, `updated_at`, `deleted_at`) VALUES
(2, 1, NULL, NULL, NULL, NULL, NULL, NULL, 10000, NULL, 0, NULL, NULL, NULL, '0796bf95bf770d2f5086f43fd80da7e0', '172.20.0.1', 0, 0, '2020-11-28 18:08:35', '2020-12-02 22:55:05', '2020-12-02 22:55:05'),
(3, 1, NULL, NULL, NULL, NULL, NULL, NULL, 10000, NULL, 0, NULL, NULL, NULL, '9104a86948e64744619812d73c4cebd6', '172.20.0.1', 0, 0, '2020-11-28 18:11:22', '2020-12-02 10:33:58', '2020-12-02 10:33:58'),
(4, 1, NULL, NULL, 'asdfsd', 'timofey.khmelev@gmail.com', '123123', NULL, 13000, NULL, 0, NULL, 'card', NULL, 'e55f9fcd85a91e40232a5f8d4296304f', '172.20.0.1', 1, 1, '2020-11-28 18:12:14', '2020-12-08 13:54:40', '2020-12-08 13:54:40'),
(5, 1, NULL, NULL, 'adsf', 'adsf@as.as', 'asdfsdf', NULL, 8000, NULL, 0, NULL, 'card', NULL, '470abad3aa005f070451ac16e1ce0ba0', '172.20.0.1', 1, 1, '2020-11-30 12:05:20', '2020-12-02 10:52:47', '2020-12-02 10:52:47'),
(6, 1, NULL, NULL, 'asdfasdf', 'ere@ll.ll', '234234234', NULL, 5000, NULL, 0, NULL, 'card', NULL, 'a8a0c507db62b8408a67c2dbb15fbf4b', '172.20.0.1', 0, 0, '2020-11-30 18:07:18', '2020-12-08 12:43:18', '2020-12-08 12:43:18'),
(7, 1, NULL, NULL, NULL, NULL, NULL, NULL, 8000, NULL, 0, NULL, NULL, NULL, '15b23b9ad7f9e3920939bc15f65064c1', '172.20.0.1', 0, 0, '2020-12-02 19:57:37', '2020-12-02 22:55:02', '2020-12-02 22:55:02'),
(8, 1, NULL, NULL, NULL, NULL, NULL, NULL, 8000, NULL, 0, NULL, NULL, NULL, '13dd040c7acdfa338a079bdd62f3de88', '172.20.0.1', 0, 0, '2020-12-02 20:00:25', '2020-12-02 22:54:57', '2020-12-02 22:54:57'),
(9, 1, NULL, NULL, 'sadfasdf', 'hmelev_t@asd.asd', '123123123', NULL, 8000, NULL, 0, NULL, 'card', NULL, '9161018e15845c4205c0559e7427f44f', '172.20.0.1', 0, 0, '2020-12-02 20:01:07', '2020-12-08 12:43:08', '2020-12-08 12:43:08'),
(10, 1, NULL, NULL, NULL, NULL, NULL, NULL, 24000, NULL, 0, NULL, NULL, NULL, '16fdc6bd1a91c251e142ab938fcc6d27', '172.20.0.1', 0, 0, '2020-12-02 20:19:03', '2020-12-02 22:54:54', '2020-12-02 22:54:54'),
(11, 1, NULL, NULL, NULL, NULL, NULL, NULL, 13000, NULL, 0, NULL, NULL, NULL, 'fbf9e8d22c1392066046b32396b3ecfa', '172.20.0.1', 0, 0, '2020-12-02 20:20:02', '2020-12-02 22:54:51', '2020-12-02 22:54:51'),
(12, 1, NULL, NULL, NULL, NULL, NULL, NULL, 10000, NULL, 0, NULL, NULL, NULL, '5ba299d4a8936962fea65b2019e8ceb2', '172.20.0.1', 0, 0, '2020-12-07 16:56:36', '2020-12-07 22:13:16', '2020-12-07 22:13:16'),
(13, 1, NULL, NULL, NULL, NULL, NULL, NULL, 5000, NULL, 0, NULL, NULL, NULL, '1f1681e9a717d63a8d0b4d5330c2820d', '172.20.0.1', 0, 0, '2020-12-07 22:24:28', '2020-12-07 22:24:32', '2020-12-07 22:24:32'),
(14, 1, NULL, NULL, NULL, NULL, NULL, NULL, 8000, NULL, 0, NULL, NULL, NULL, '1f5bb2d06dbf832ecf99669197e5835c', '172.20.0.1', 0, 0, '2020-12-08 11:03:21', '2020-12-08 11:04:24', '2020-12-08 11:04:24'),
(15, 1, NULL, NULL, NULL, NULL, NULL, NULL, 8000, NULL, 0, NULL, NULL, NULL, 'bb9af85513009ff726f43b9b151f69dd', '172.20.0.1', 0, 0, '2020-12-08 11:17:41', '2020-12-08 11:17:44', '2020-12-08 11:17:44'),
(16, 1, NULL, NULL, NULL, NULL, NULL, NULL, 8000, NULL, 0, NULL, NULL, NULL, '52384f126ff0ad923fba5ab04b41ccc4', '172.20.0.1', 0, 0, '2020-12-08 11:18:24', '2020-12-08 11:18:29', '2020-12-08 11:18:29'),
(17, 2, NULL, NULL, NULL, NULL, NULL, NULL, 1000, NULL, 0, NULL, NULL, NULL, '2bfc3903e72736783f7a6f8c8cb64404', '172.20.0.1', 0, 0, '2020-12-08 11:33:25', '2020-12-08 11:33:33', '2020-12-08 11:33:33'),
(18, 2, NULL, NULL, NULL, NULL, NULL, NULL, 2000, NULL, 0, NULL, NULL, NULL, '5da2983703a988465a29b8a986ea6f9a', '172.20.0.1', 0, 0, '2020-12-08 11:35:40', '2020-12-08 12:43:06', '2020-12-08 12:43:06'),
(19, 1, NULL, NULL, NULL, NULL, NULL, NULL, 8000, NULL, 0, NULL, NULL, NULL, 'f941d3a32d2b8211973be6bf591e75f9', '172.20.0.1', 0, 0, '2020-12-08 12:19:30', '2020-12-08 12:19:32', '2020-12-08 12:19:32'),
(20, 2, NULL, NULL, NULL, NULL, NULL, NULL, 7000, NULL, 0, NULL, NULL, NULL, 'a257cd2583a51253f952781fdda5f7d6', '172.20.0.1', 0, 0, '2020-12-08 12:20:22', '2020-12-08 12:26:37', '2020-12-08 12:26:37'),
(21, 1, NULL, NULL, NULL, NULL, NULL, NULL, 5000, NULL, 0, NULL, NULL, NULL, '042863cad9ed95b5d14e0c1d609a19e2', '172.20.0.1', 0, 0, '2020-12-08 12:44:02', '2020-12-08 12:44:04', '2020-12-08 12:44:04'),
(22, 1, NULL, NULL, NULL, NULL, NULL, NULL, 13000, NULL, 0, NULL, NULL, NULL, '5963ee1ccd694f0f1aa05b28e02e8b4d', '172.20.0.1', 0, 0, '2020-12-08 12:46:26', '2020-12-08 12:46:29', '2020-12-08 12:46:29'),
(23, 1, NULL, NULL, NULL, NULL, NULL, NULL, 13000, NULL, 0, NULL, NULL, NULL, 'ff33f6110122e1805bd1ed01e7ea2c3a', '172.20.0.1', 0, 0, '2020-12-08 12:47:19', '2020-12-08 12:47:20', '2020-12-08 12:47:20'),
(24, 1, NULL, NULL, 'Timo', 'timofey.khmelev@gmail.com', '123123123', NULL, 13000, NULL, 13000, '2020-12-08 13:41:33', 'card', NULL, '45d47df8419d7916684a734d636926ba', '172.20.0.1', 0, 1, '2020-12-08 12:51:40', '2020-12-08 13:54:37', '2020-12-08 13:54:37'),
(25, 1, NULL, NULL, NULL, NULL, NULL, NULL, 23800, NULL, 0, NULL, NULL, NULL, 'e810e0b441390358dced917951a6936b', '172.20.0.1', 0, 0, '2020-12-08 14:02:18', '2020-12-08 14:04:18', '2020-12-08 14:04:18'),
(26, 1, NULL, NULL, NULL, NULL, NULL, NULL, 16000, NULL, 0, NULL, NULL, NULL, 'af8fc59725a0a9cb65d0265329aefc57', '172.20.0.1', 0, 0, '2020-12-08 14:07:38', '2020-12-08 14:08:26', '2020-12-08 14:08:26'),
(27, 1, NULL, NULL, NULL, NULL, NULL, NULL, 13000, NULL, 0, NULL, NULL, NULL, 'c58a379ad8504114470a2bdf840e8a39', '172.20.0.1', 0, 0, '2020-12-08 14:08:31', '2020-12-08 14:10:04', '2020-12-08 14:10:04'),
(28, 1, NULL, NULL, NULL, NULL, NULL, NULL, 20000, NULL, 0, NULL, NULL, NULL, '3e77027fe8cf936feabf36b3c330b515', '172.20.0.1', 0, 0, '2020-12-08 14:10:11', '2020-12-08 14:10:14', '2020-12-08 14:10:14'),
(29, 1, NULL, NULL, NULL, NULL, NULL, NULL, 13000, NULL, 0, NULL, NULL, NULL, '798fb9c889a9283453f3f4075484481b', '172.20.0.1', 0, 0, '2020-12-08 14:12:59', '2020-12-08 14:13:05', '2020-12-08 14:13:05'),
(30, 1, NULL, NULL, NULL, NULL, NULL, NULL, 14000, NULL, 0, NULL, NULL, NULL, 'bc8d6730717eb9a9fba963f4a640a90a', '172.20.0.1', 0, 0, '2020-12-08 14:37:14', '2020-12-08 14:37:20', '2020-12-08 14:37:20'),
(31, 1, NULL, NULL, NULL, NULL, NULL, NULL, 8000, NULL, 0, NULL, NULL, NULL, '7903ef2d7b5c118d495cdde4900b28cf', '172.20.0.1', 0, 0, '2020-12-08 14:38:09', '2020-12-08 14:38:20', '2020-12-08 14:38:20'),
(32, 1, NULL, NULL, NULL, NULL, NULL, NULL, 16800, NULL, 0, NULL, NULL, NULL, 'b36c8ec1b6d2f553b5fb34f750b3be26', '172.20.0.1', 0, 0, '2020-12-08 14:43:21', '2020-12-08 14:44:12', '2020-12-08 14:44:12'),
(33, 1, NULL, NULL, NULL, NULL, NULL, NULL, 8000, NULL, 0, NULL, NULL, NULL, '76370fe326da554b0e7b8a0ff30e3ebb', '172.20.0.1', 0, 0, '2020-12-08 14:44:20', '2020-12-08 14:44:47', '2020-12-08 14:44:47'),
(34, 1, NULL, NULL, NULL, NULL, NULL, NULL, 8000, NULL, 0, NULL, NULL, NULL, 'f88c0086288186c262a2b4147abe79e6', '172.20.0.1', 0, 0, '2020-12-08 14:44:56', '2020-12-08 14:58:22', '2020-12-08 14:58:22'),
(35, 1, NULL, NULL, NULL, NULL, NULL, NULL, 8000, NULL, 0, NULL, NULL, NULL, '6cf9fdf39b4445cfd7d1871375c3818b', '172.20.0.1', 0, 0, '2020-12-08 14:58:31', '2020-12-08 15:00:30', '2020-12-08 15:00:30'),
(36, 1, NULL, NULL, NULL, NULL, NULL, NULL, 13000, NULL, 0, NULL, NULL, NULL, '7d565f928041d2b86055a57cffee9542', '172.20.0.1', 0, 0, '2020-12-08 15:00:52', '2020-12-08 15:01:12', '2020-12-08 15:01:12'),
(37, 1, NULL, NULL, NULL, NULL, NULL, NULL, 16000, NULL, 0, NULL, NULL, NULL, '01eae01454704918ee806101da0c8c64', '172.20.0.1', 0, 0, '2020-12-08 15:01:19', '2020-12-08 15:01:52', '2020-12-08 15:01:52'),
(38, 1, NULL, NULL, NULL, NULL, NULL, NULL, 8000, NULL, 0, NULL, NULL, NULL, 'e223f3a5806d0bbb17c010523fbb765f', '172.20.0.1', 0, 0, '2020-12-08 15:02:14', '2020-12-08 15:02:58', '2020-12-08 15:02:58'),
(39, 1, NULL, NULL, NULL, NULL, NULL, NULL, 16000, NULL, 0, NULL, NULL, NULL, 'eae3701d3d7cef7309a9ffd51a107f06', '172.20.0.1', 0, 0, '2020-12-08 15:03:03', '2020-12-08 15:03:59', '2020-12-08 15:03:59'),
(40, 1, NULL, NULL, NULL, NULL, NULL, NULL, 16000, NULL, 0, NULL, NULL, NULL, 'e6724b1bdceed8802a20e714508141bb', '172.20.0.1', 0, 0, '2020-12-08 15:04:03', '2020-12-08 15:04:38', '2020-12-08 15:04:38'),
(41, 1, NULL, NULL, NULL, NULL, NULL, NULL, 16000, NULL, 0, NULL, NULL, NULL, 'ad2f5c741d7b752f6ce21e175b395ba5', '172.20.0.1', 0, 0, '2020-12-08 15:04:45', '2020-12-08 15:04:47', '2020-12-08 15:04:47'),
(42, 1, NULL, NULL, 'admin1', 'hello@spaceduck.kz', '123123123', NULL, 16000, NULL, 16000, '2020-12-08 15:05:17', 'card', NULL, '0591bad704dcf3f2a34edc529d92a277', '172.20.0.1', 1, 1, '2020-12-08 15:05:10', '2020-12-08 16:16:39', NULL),
(43, 1, NULL, NULL, NULL, NULL, NULL, NULL, 16000, NULL, 0, NULL, NULL, NULL, '20444c33694775690ebce6ccf70680b0', '172.20.0.1', 0, 0, '2020-12-08 15:24:54', '2020-12-08 15:24:54', NULL),
(44, 1, NULL, NULL, NULL, NULL, NULL, NULL, 8000, NULL, 0, NULL, NULL, NULL, '9f8e18ac519440fa10393fd550549fa2', '172.20.0.1', 0, 0, '2020-12-08 15:26:57', '2020-12-08 16:11:18', '2020-12-08 16:11:18'),
(45, 1, NULL, NULL, NULL, NULL, NULL, NULL, 8000, NULL, 0, NULL, NULL, NULL, '6b1b9fd80459b05b1bb7df84086b8b89', '172.20.0.1', 0, 0, '2020-12-08 16:11:22', '2020-12-08 16:12:11', '2020-12-08 16:12:11'),
(46, 1, NULL, NULL, 'admin', 'hello@spaceduck.kz', '123123', NULL, 400, NULL, 400, '2020-12-08 17:06:22', 'card', NULL, '3f1d23325e0e2e1285f3ea5cfabf76aa', '172.20.0.1', 1, 1, '2020-12-08 17:06:19', '2020-12-08 17:06:24', NULL),
(47, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, NULL, '172.20.0.1', 0, 0, '2020-12-08 17:22:59', '2020-12-08 17:25:14', '2020-12-08 17:25:14'),
(48, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, NULL, '172.20.0.1', 0, 0, '2020-12-08 17:23:53', '2020-12-08 17:25:12', '2020-12-08 17:25:12'),
(49, 1, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0, NULL, NULL, NULL, NULL, '172.20.0.1', 0, 0, '2020-12-08 17:24:39', '2020-12-08 17:25:10', '2020-12-08 17:25:10'),
(50, 1, NULL, NULL, NULL, NULL, NULL, NULL, 800, NULL, 0, NULL, NULL, NULL, '60b62572b913a2674209add8b224426b', '172.20.0.1', 0, 0, '2020-12-08 17:25:19', '2020-12-08 17:26:17', '2020-12-08 17:26:17'),
(51, 1, NULL, NULL, NULL, NULL, NULL, NULL, 800, NULL, 0, NULL, NULL, NULL, 'a5a64cbde36e6815a9fedf9f9bab26d6', '172.20.0.1', 0, 0, '2020-12-08 17:26:27', '2020-12-08 17:26:44', '2020-12-08 17:26:44'),
(52, 1, NULL, NULL, 'admin', 'hello@spaceduck.kz', '56565', NULL, 800, NULL, 800, '2020-12-08 17:27:51', 'card', NULL, '65854ef3c126d07ec30732961bc11c24', '172.20.0.1', 1, 0, '2020-12-08 17:26:48', '2020-12-08 17:27:51', NULL),
(53, 1, NULL, NULL, 'admin', 'hello@spaceduck.kz', '45345345', NULL, 15000, NULL, 15000, '2020-12-08 17:28:50', 'card', NULL, 'fba1a6204a90d36a6fce00869b8223cc', '172.20.0.1', 1, 0, '2020-12-08 17:27:58', '2020-12-08 17:28:50', NULL),
(54, 1, NULL, NULL, NULL, NULL, NULL, NULL, 400, NULL, 0, NULL, NULL, NULL, '45fae4e43e35ab8ad481ea3ec5dae0f4', '172.20.0.1', 0, 0, '2020-12-08 17:28:54', '2020-12-08 17:28:56', '2020-12-08 17:28:56'),
(55, 1, NULL, NULL, 'admin', 'hello@spaceduck.kz', '656565', NULL, 8400, NULL, 8400, '2020-12-08 17:29:30', 'card', NULL, '1d0dcf8dc9c82163f433460e52abeab1', '172.20.0.1', 1, 0, '2020-12-08 17:29:27', '2020-12-08 17:29:30', NULL),
(56, 2, NULL, NULL, 'admin', 'hello@spaceduck.kz', '656565', NULL, 6000, NULL, 6000, '2020-12-08 17:29:54', 'card', NULL, 'eb61d0a15f4e09a8d5d998d24603828c', '172.20.0.1', 1, 0, '2020-12-08 17:29:53', '2020-12-08 17:29:54', NULL),
(57, 3, NULL, NULL, NULL, NULL, NULL, NULL, 10000, NULL, 0, NULL, NULL, NULL, 'b2454ef97284afc5be5b8583e25ffa6d', '172.20.0.1', 0, 0, '2020-12-09 17:02:45', '2020-12-09 17:02:48', '2020-12-09 17:02:48'),
(58, 3, NULL, NULL, NULL, NULL, NULL, NULL, 10000, NULL, 0, NULL, NULL, NULL, '73026cc8ad3af83c2c1cb5892209e1cb', '172.20.0.1', 0, 0, '2020-12-09 17:18:43', '2020-12-09 17:18:45', '2020-12-09 17:18:45'),
(59, 3, NULL, NULL, NULL, NULL, NULL, NULL, 10000, NULL, 0, NULL, NULL, NULL, '2b011a2daa4766eb60d0a7d6de2fc77d', '172.20.0.1', 0, 0, '2020-12-09 17:58:44', '2020-12-09 18:06:58', '2020-12-09 18:06:58'),
(60, 3, NULL, NULL, NULL, NULL, NULL, NULL, 10000, NULL, 0, NULL, NULL, NULL, '3fa9a127309253ffcc367491cccc6522', '172.20.0.1', 0, 0, '2020-12-09 18:07:54', '2020-12-09 18:08:00', '2020-12-09 18:08:00'),
(10000000, 1, NULL, NULL, NULL, NULL, NULL, NULL, 7000, NULL, 0, NULL, NULL, NULL, 'aff072fbfdc9fe35626f2d5a0424d939', '172.20.0.1', 0, 0, '2020-12-10 14:07:58', '2020-12-10 14:08:03', '2020-12-10 14:08:03'),
(10000001, 2, NULL, NULL, 'admin', 'hello@spaceduck.kz', '656565', NULL, 6000, NULL, 6000, '2020-12-10 14:10:45', 'card', NULL, '18789d0d36b3844ca7b10535d2cc1bff', '172.20.0.1', 1, 0, '2020-12-10 14:10:43', '2020-12-10 14:10:45', NULL),
(10000002, 1, NULL, NULL, 'admin', 'hello@spaceduck.kz', '656565', NULL, 12000, NULL, 12000, '2020-12-10 14:11:00', 'card', NULL, 'fcc5ec32669137800484f2ee3baae165', '172.20.0.1', 1, 0, '2020-12-10 14:10:57', '2020-12-10 14:11:00', NULL),
(10000003, 282, 'lermontov', NULL, NULL, NULL, NULL, NULL, 500, NULL, 0, NULL, NULL, NULL, 'd965eb15f4c3975d510ee1485333cc78', '172.20.0.1', 0, 0, '2020-12-10 14:11:37', '2020-12-10 14:12:00', '2020-12-10 14:12:00'),
(10000004, 282, 'lermontov', NULL, NULL, NULL, NULL, NULL, 500, NULL, 0, NULL, NULL, NULL, 'f92f2a3edba974b9429a4a94336613f8', '172.20.0.1', 0, 0, '2020-12-10 14:14:25', '2020-12-10 14:14:35', '2020-12-10 14:14:35'),
(10000005, 282, 'lermontov', NULL, 'admin', 'hello@spaceduck.kz', '656565', NULL, 500, NULL, 500, '2020-12-10 14:16:24', 'card', NULL, '40ecd0f4c5860abf1dbeb442937c1cf5', '172.20.0.1', 1, 0, '2020-12-10 14:16:16', '2020-12-10 14:18:01', '2020-12-10 14:18:01'),
(10000006, 1, NULL, NULL, NULL, NULL, NULL, NULL, 8000, NULL, 0, NULL, NULL, NULL, '95995603d6c0b1101de8673acb7e4b81', '172.20.0.1', 0, 0, '2020-12-10 16:23:04', '2020-12-10 16:23:09', '2020-12-10 16:23:09'),
(10000007, 1, NULL, NULL, 'admin', 'hello@spaceduck.kz', '656565', NULL, 8000, NULL, 0, NULL, 'card', NULL, '763d6f09eea415e8cc7f166eec410394', '172.20.0.1', 0, 0, '2020-12-10 16:28:40', '2020-12-10 16:30:33', '2020-12-10 16:30:33'),
(10000008, 1, NULL, NULL, 'admin', 'hello@spaceduck.kz', '656565', NULL, 8000, NULL, 0, NULL, 'card', NULL, '2720e45bc4f4a637477d1fd11e4e2692', '172.20.0.1', 0, 0, '2020-12-10 16:30:37', '2020-12-10 16:31:56', '2020-12-10 16:31:56'),
(10000009, 1, NULL, NULL, 'admin', 'hello@spaceduck.kz', '656565', NULL, 8000, '28200d33-f098-777f-9b76-2b090cc1afce', 0, NULL, 'card', NULL, '651d6d6d02d127875aa7c39f9b1266bf', '172.20.0.1', 0, 0, '2020-12-10 16:37:43', '2020-12-10 16:37:45', NULL),
(10000010, 1, NULL, NULL, 'admin', 'hello@spaceduck.kz', '656565', NULL, 8000, '13d8b907-933a-7f52-b703-37fd0cc1afce', 0, NULL, 'card', NULL, 'c5c21e90714d9dea8b8ceb069609efef', '172.20.0.1', 0, 0, '2020-12-10 16:39:27', '2020-12-10 16:52:52', '2020-12-10 16:52:52'),
(10000011, 1, NULL, NULL, 'admin', 'hello@spaceduck.kz', '656565', NULL, 8000, '91d6584a-f806-7feb-b9ea-b2f00cc1afce', 0, NULL, 'card', 'https://securepayments.sberbank.kz/payment/merchants/rbs/payment_ru.html?mdOrder=91d6584a-f806-7feb-b9ea-b2f00cc1afce', '945c86e9e0a85a7ee3343dc36b7a4a0f', '172.20.0.1', 0, 0, '2020-12-10 16:52:58', '2020-12-10 16:53:00', NULL),
(10000012, 1, NULL, NULL, 'admin', 'hello@spaceduck.kz', '656565', NULL, 500, '2285fb93-1f39-757d-90f6-35d10cc1afce', 5, '2020-12-10 17:17:57', 'card', 'https://securepayments.sberbank.kz/payment/merchants/rbs/payment_ru.html?mdOrder=2285fb93-1f39-757d-90f6-35d10cc1afce', '152b5641593a30449b62372f46c5b00a', '172.20.0.1', 1, 0, '2020-12-10 17:16:57', '2020-12-10 17:17:57', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `timetable_id` bigint(20) UNSIGNED NOT NULL,
  `section_id` bigint(20) UNSIGNED DEFAULT NULL,
  `pricegroup_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ticket_id` bigint(20) UNSIGNED DEFAULT NULL,
  `row` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `seat` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `barcode` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `timetable_id`, `section_id`, `pricegroup_id`, `ticket_id`, `row`, `seat`, `price`, `barcode`) VALUES
(1, 2, 1, 10, NULL, 126, '3', '6', 5000, NULL),
(2, 2, 1, 10, NULL, 125, '3', '5', 5000, NULL),
(3, 3, 1, 10, NULL, 115, '2', '4', 5000, NULL),
(4, 3, 1, 10, NULL, 114, '2', '3', 5000, NULL),
(5, 4, 1, 10, NULL, 116, '2', '5', 5000, '123123'),
(6, 4, 1, 10, NULL, 135, '4', '6', 8000, 'asdfasdf'),
(7, 5, 1, 10, NULL, 133, '4', '4', 8000, NULL),
(8, 6, 1, 10, NULL, 117, '2', '6', 5000, NULL),
(9, 7, 1, 10, NULL, NULL, '1', '10', 8000, NULL),
(10, 8, 1, 10, NULL, 145, '1', '8', 8000, NULL),
(11, 9, 1, 10, NULL, NULL, '1', '9', 8000, NULL),
(12, 10, 1, 10, NULL, 144, '1', '6', 8000, NULL),
(13, 10, 1, 10, NULL, 143, '1', '5', 8000, NULL),
(14, 10, 1, 10, NULL, 136, '4', '7', 8000, NULL),
(15, 11, 1, 10, NULL, 134, '4', '5', 8000, NULL),
(16, 11, 1, 10, NULL, 127, '3', '7', 5000, NULL),
(17, 12, 1, 9, NULL, 231, '2', '9', 10000, NULL),
(18, 13, 1, 10, NULL, 128, '3', '8', 5000, NULL),
(19, 14, 1, 10, NULL, 139, '1', '1', 8000, NULL),
(20, 15, 1, 10, NULL, NULL, '4', '9', 8000, NULL),
(21, 16, 1, 10, NULL, 140, '1', '2', 8000, NULL),
(22, 17, 2, NULL, 3, NULL, NULL, NULL, 1000, NULL),
(23, 18, 2, NULL, 3, NULL, NULL, NULL, 1000, NULL),
(24, 18, 2, NULL, 3, NULL, NULL, NULL, 1000, NULL),
(25, 19, 1, 10, NULL, NULL, '4', '10', 8000, NULL),
(26, 20, 2, NULL, 3, NULL, NULL, NULL, 1000, NULL),
(27, 20, 2, NULL, 3, NULL, NULL, NULL, 1000, NULL),
(28, 20, 2, NULL, 5, NULL, NULL, NULL, 5000, NULL),
(29, 21, 1, 10, NULL, 113, '2', '2', 5000, NULL),
(30, 22, 1, 10, NULL, 131, '4', '2', 8000, NULL),
(31, 22, 1, 10, NULL, 122, '3', '2', 5000, NULL),
(32, 23, 1, 10, NULL, 121, '3', '1', 5000, NULL),
(33, 23, 1, 10, NULL, 130, '4', '1', 8000, NULL),
(34, 24, 1, 10, NULL, 122, '3', '2', 5000, NULL),
(35, 24, 1, 10, NULL, 131, '4', '2', 8000, NULL),
(36, 25, 1, 21, NULL, NULL, NULL, NULL, 400, '000000361641'),
(37, 25, 1, 21, NULL, NULL, NULL, NULL, 400, '000000372552'),
(38, 25, 1, 10, NULL, 135, '4', '6', 7000, '000000386463'),
(39, 25, 1, 10, NULL, 144, '1', '6', 8000, '000000398222'),
(40, 25, 1, 10, NULL, 143, '1', '5', 8000, '000000404290'),
(41, 26, 1, 10, NULL, 131, '4', '2', 8000, '000000419434'),
(42, 26, 1, 10, NULL, 140, '1', '2', 8000, '000000427510'),
(43, 27, 1, 10, NULL, 130, '4', '1', 8000, '000000432067'),
(44, 27, 1, 10, NULL, 121, '3', '1', 5000, '000000445635'),
(45, 28, 1, 9, NULL, 226, '2', '4', 10000, '000000451465'),
(46, 28, 1, 9, NULL, 227, '2', '5', 10000, '000000469339'),
(47, 29, 1, 10, NULL, 131, '4', '2', 8000, '000000477248'),
(48, 29, 1, 10, NULL, 122, '3', '2', 5000, '000000483338'),
(49, 30, 1, 10, NULL, 125, '3', '5', 7000, '000000493612'),
(50, 30, 1, 10, NULL, 134, '4', '5', 7000, '000000508974'),
(51, 31, 1, 10, NULL, 143, '1', '5', 8000, '000000514881'),
(52, 32, 1, 10, NULL, 143, '1', '5', 8000, '000000525780'),
(53, 32, 1, 10, NULL, 144, '1', '6', 8000, '000000537288'),
(54, 32, 1, 21, NULL, NULL, NULL, NULL, 400, '000000541543'),
(55, 32, 1, 21, NULL, NULL, NULL, NULL, 400, '000000557610'),
(56, 33, 1, 10, NULL, 139, '1', '1', 8000, '000000569643'),
(57, 34, 1, 10, NULL, 139, '1', '1', 8000, '000000571656'),
(58, 35, 1, 10, NULL, 140, '1', '2', 8000, '000000583561'),
(59, 36, 1, 10, NULL, 122, '3', '2', 5000, '000000595625'),
(60, 36, 1, 10, NULL, 131, '4', '2', 8000, '000000602283'),
(61, 37, 1, 10, NULL, 140, '1', '2', 8000, '000000614887'),
(62, 37, 1, 10, NULL, 131, '4', '2', 8000, '000000622922'),
(63, 38, 1, 10, NULL, 140, '1', '2', 8000, '000000632013'),
(64, 39, 1, 10, NULL, 140, '1', '2', 8000, '000000645433'),
(65, 39, 1, 10, NULL, 131, '4', '2', 8000, '000000652185'),
(66, 40, 1, 10, NULL, 140, '1', '2', 8000, '000000668250'),
(67, 40, 1, 10, NULL, 131, '4', '2', 8000, '000000674598'),
(68, 41, 1, 10, NULL, 131, '4', '2', 8000, '000000684483'),
(69, 41, 1, 10, NULL, 140, '1', '2', 8000, '000000695889'),
(70, 42, 1, 10, NULL, 131, '4', '2', 8000, '000000707544'),
(71, 42, 1, 10, NULL, 140, '1', '2', 8000, '000000712908'),
(72, 43, 1, 10, NULL, 145, '1', '8', 8000, '000000725929'),
(73, 43, 1, 10, NULL, 144, '1', '6', 8000, '000000733858'),
(74, 44, 1, 10, NULL, 139, '1', '1', 8000, '000000741446'),
(75, 45, 1, 10, NULL, 143, '1', '5', 8000, '000000757248'),
(76, 46, 1, 21, NULL, NULL, NULL, NULL, 400, '000000763352'),
(77, 50, 1, 21, NULL, NULL, NULL, NULL, 400, '000000776875'),
(78, 50, 1, 21, NULL, NULL, NULL, NULL, 400, '000000781985'),
(79, 51, 1, 21, NULL, 92, NULL, NULL, 400, '000000792825'),
(80, 51, 1, 21, NULL, 93, NULL, NULL, 400, '000000808696'),
(81, 52, 1, 21, NULL, 92, NULL, NULL, 400, '000000815308'),
(82, 52, 1, 21, NULL, 93, NULL, NULL, 400, '000000824408'),
(83, 53, 1, 10, NULL, 134, '4', '5', 7000, '000000838798'),
(84, 53, 1, 10, NULL, 143, '1', '5', 8000, '000000849287'),
(85, 54, 1, 21, NULL, 94, NULL, NULL, 400, '000000855329'),
(86, 55, 1, 10, NULL, 133, '4', '4', 8000, '000000867024'),
(87, 55, 1, 21, NULL, 94, NULL, NULL, 400, '000000871689'),
(88, 56, 2, NULL, 3, 153, NULL, NULL, 1000, '000000885373'),
(89, 56, 2, NULL, 5, 203, NULL, NULL, 5000, '000000898236'),
(90, 57, 3, 26, NULL, 259, '14', '2', 5000, '000000904959'),
(91, 57, 3, 26, NULL, 257, '13', '3', 5000, '000000919982'),
(92, 58, 3, 26, NULL, 259, '14', '2', 5000, '000000927338'),
(93, 58, 3, 26, NULL, 257, '13', '3', 5000, '000000938610'),
(94, 59, 3, 26, NULL, 255, '13', '2', 5000, '000000945906'),
(95, 59, 3, 26, NULL, 258, '14', '1', 5000, '000000951037'),
(96, 60, 3, 26, NULL, 255, '13', '2', 5000, '000000965801'),
(97, 60, 3, 26, NULL, 258, '14', '1', 5000, '000000971415'),
(98, 10000000, 1, 10, NULL, 135, '4', '6', 7000, '000000984002'),
(99, 10000001, 2, NULL, 3, 154, NULL, NULL, 1000, '000000994237'),
(100, 10000001, 2, NULL, 5, 204, NULL, NULL, 5000, '000001008927'),
(101, 10000002, 1, 10, NULL, 135, '4', '6', 7000, '000001011341'),
(102, 10000002, 1, 10, NULL, 120, '2', '10', 5000, '000001024240'),
(103, 10000003, 282, 30, NULL, NULL, '11', '2', 500, NULL),
(104, 10000004, 282, 30, NULL, NULL, '11', '2', 500, NULL),
(105, 10000005, 282, 30, NULL, NULL, '11', '2', 500, 'f7133e749c78454e8bcb79884876c475'),
(106, 10000006, 1, 10, NULL, 139, '1', '1', 8000, '000001066417'),
(107, 10000007, 1, 10, NULL, 260, '1', '3', 8000, '000001075217'),
(108, 10000008, 1, 10, NULL, 260, '1', '3', 8000, '000001083420'),
(109, 10000009, 1, 10, NULL, 139, '1', '1', 8000, '000001098966'),
(110, 10000010, 1, 10, NULL, 260, '1', '3', 8000, '000001107375'),
(111, 10000011, 1, 10, NULL, 260, '1', '3', 8000, '000001114522'),
(112, 10000012, 1, 10, NULL, 264, '1', '10', 500, '000001124255');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'admin_panel', 'web', '2020-11-26 03:43:37', '2020-11-26 03:43:37');

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pricegroups`
--

CREATE TABLE `pricegroups` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` json DEFAULT NULL,
  `api_id` bigint(20) UNSIGNED DEFAULT NULL,
  `timetable_id` bigint(20) UNSIGNED NOT NULL,
  `price` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `sort_order` int(11) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pricegroups`
--

INSERT INTO `pricegroups` (`id`, `title`, `api_id`, `timetable_id`, `price`, `sort_order`, `created_at`, `updated_at`) VALUES
(3, '{\"ru\": \"Стандарт\"}', NULL, 2, 1000, 1, '2020-11-27 17:30:01', '2020-11-27 17:30:23'),
(5, '{\"kz\": null, \"ru\": \"VIP\"}', NULL, 2, 5000, 1, '2020-11-28 08:35:05', '2020-11-28 08:35:05');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'web', '2020-11-26 03:43:37', '2020-11-26 03:43:37'),
(2, 'user', 'web', '2020-11-26 03:43:37', '2020-11-26 03:43:37');

-- --------------------------------------------------------

--
-- Table structure for table `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_has_permissions`
--

INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `seats`
--

CREATE TABLE `seats` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `section_id` bigint(20) UNSIGNED DEFAULT NULL,
  `x` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `y` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `row` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `seat` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `seats`
--

INSERT INTO `seats` (`id`, `section_id`, `x`, `y`, `row`, `seat`) VALUES
(183, 9, 80, 40, '1', '1'),
(184, 9, 120, 40, '1', '2'),
(185, 9, 160, 40, '1', '3'),
(186, 9, 200, 40, '1', '4'),
(187, 9, 240, 40, '1', '5'),
(188, 9, 280, 40, '1', '6'),
(189, 9, 320, 40, '1', '7'),
(190, 9, 360, 40, '1', '8'),
(191, 9, 400, 40, '1', '9'),
(192, 9, 440, 40, '1', '10'),
(193, 9, 80, 80, '2', '1'),
(194, 9, 120, 80, '2', '2'),
(195, 9, 160, 80, '2', '3'),
(196, 9, 200, 80, '2', '4'),
(197, 9, 240, 80, '2', '5'),
(198, 9, 280, 80, '2', '6'),
(199, 9, 320, 80, '2', '7'),
(200, 9, 360, 80, '2', '8'),
(201, 9, 400, 80, '2', '9'),
(202, 9, 440, 80, '2', '10'),
(203, 9, 80, 120, '3', '1'),
(204, 9, 120, 120, '3', '2'),
(205, 9, 160, 120, '3', '3'),
(206, 9, 200, 120, '3', '4'),
(207, 9, 240, 120, '3', '5'),
(208, 9, 280, 120, '3', '6'),
(209, 9, 320, 120, '3', '7'),
(210, 9, 360, 120, '3', '8'),
(211, 9, 400, 120, '3', '9'),
(212, 9, 440, 120, '3', '10'),
(214, 10, 80, 200, '1', '1'),
(215, 10, 120, 200, '1', '2'),
(216, 10, 160, 200, '1', '3'),
(217, 10, 200, 200, '1', '4'),
(218, 10, 240, 200, '1', '5'),
(219, 10, 280, 200, '1', '6'),
(221, 10, 360, 200, '1', '8'),
(222, 10, 400, 200, '1', '9'),
(223, 10, 440, 200, '1', '10'),
(224, 10, 80, 80, '2', '1'),
(225, 10, 120, 80, '2', '2'),
(226, 10, 160, 80, '2', '3'),
(227, 10, 200, 80, '2', '4'),
(228, 10, 240, 80, '2', '5'),
(229, 10, 280, 80, '2', '6'),
(230, 10, 320, 80, '2', '7'),
(232, 10, 400, 80, '2', '9'),
(233, 10, 440, 80, '2', '10'),
(234, 10, 80, 120, '3', '1'),
(235, 10, 120, 120, '3', '2'),
(236, 10, 160, 120, '3', '3'),
(237, 10, 200, 120, '3', '4'),
(238, 10, 240, 120, '3', '5'),
(239, 10, 280, 120, '3', '6'),
(240, 10, 320, 120, '3', '7'),
(241, 10, 360, 120, '3', '8'),
(243, 10, 440, 120, '3', '10'),
(244, 10, 80, 160, '4', '1'),
(245, 10, 120, 160, '4', '2'),
(246, 10, 160, 160, '4', '3'),
(247, 10, 200, 160, '4', '4'),
(248, 10, 240, 160, '4', '5'),
(249, 10, 280, 160, '4', '6'),
(250, 10, 320, 160, '4', '7'),
(252, 10, 400, 160, '4', '9'),
(253, 10, 440, 160, '4', '10'),
(399, 25, 256, 36, '1', '1'),
(400, 25, 292, 36, '1', '2'),
(401, 25, 328, 36, '1', '3'),
(402, 25, 364, 36, '1', '4'),
(403, 25, 400, 36, '1', '5'),
(404, 25, 436, 36, '1', '6'),
(405, 25, 472, 36, '1', '7'),
(406, 25, 508, 36, '1', '8'),
(407, 25, 544, 36, '1', '9'),
(408, 25, 580, 36, '1', '10'),
(409, 25, 616, 36, '1', '11'),
(410, 25, 652, 36, '1', '12'),
(411, 25, 688, 36, '1', '13'),
(412, 25, 724, 36, '1', '14'),
(413, 25, 760, 36, '1', '15'),
(414, 25, 868, 36, '1', '16'),
(415, 25, 904, 36, '1', '17'),
(416, 25, 940, 36, '1', '18'),
(417, 25, 976, 36, '1', '19'),
(418, 25, 1012, 36, '1', '20'),
(419, 25, 1048, 36, '1', '21'),
(420, 25, 1084, 36, '1', '22'),
(421, 25, 1120, 36, '1', '23'),
(422, 25, 1156, 36, '1', '24'),
(423, 25, 1192, 36, '1', '25'),
(424, 25, 1228, 36, '1', '26'),
(425, 25, 1264, 36, '1', '27'),
(426, 25, 1300, 36, '1', '28'),
(427, 25, 1336, 36, '1', '29'),
(428, 25, 1372, 36, '1', '30'),
(429, 25, 220, 72, '2', '1'),
(430, 25, 256, 72, '2', '2'),
(431, 25, 292, 72, '2', '3'),
(432, 25, 328, 72, '2', '4'),
(433, 25, 364, 72, '2', '5'),
(434, 25, 400, 72, '2', '6'),
(435, 25, 436, 72, '2', '7'),
(436, 25, 472, 72, '2', '8'),
(437, 25, 508, 72, '2', '9'),
(438, 25, 544, 72, '2', '10'),
(439, 25, 580, 72, '2', '11'),
(440, 25, 616, 72, '2', '12'),
(441, 25, 652, 72, '2', '13'),
(442, 25, 688, 72, '2', '14'),
(443, 25, 724, 72, '2', '15'),
(444, 25, 760, 72, '2', '16'),
(445, 25, 868, 72, '2', '17'),
(446, 25, 904, 72, '2', '18'),
(447, 25, 940, 72, '2', '19'),
(448, 25, 976, 72, '2', '20'),
(449, 25, 1012, 72, '2', '21'),
(450, 25, 1048, 72, '2', '22'),
(451, 25, 1084, 72, '2', '23'),
(452, 25, 1120, 72, '2', '24'),
(453, 25, 1156, 72, '2', '25'),
(454, 25, 1192, 72, '2', '26'),
(455, 25, 1228, 72, '2', '27'),
(456, 25, 1264, 72, '2', '28'),
(457, 25, 1300, 72, '2', '29'),
(458, 25, 1336, 72, '2', '30'),
(459, 25, 1372, 72, '2', '31'),
(460, 25, 1408, 72, '2', '32'),
(461, 25, 184, 108, '3', '1'),
(462, 25, 220, 108, '3', '2'),
(463, 25, 256, 108, '3', '3'),
(464, 25, 292, 108, '3', '4'),
(465, 25, 328, 108, '3', '5'),
(466, 25, 364, 108, '3', '6'),
(467, 25, 400, 108, '3', '7'),
(468, 25, 436, 108, '3', '8'),
(469, 25, 472, 108, '3', '9'),
(470, 25, 508, 108, '3', '10'),
(471, 25, 544, 108, '3', '11'),
(472, 25, 580, 108, '3', '12'),
(473, 25, 616, 108, '3', '13'),
(474, 25, 652, 108, '3', '14'),
(475, 25, 688, 108, '3', '15'),
(476, 25, 724, 108, '3', '16'),
(477, 25, 760, 108, '3', '17'),
(478, 25, 868, 108, '3', '18'),
(479, 25, 904, 108, '3', '19'),
(480, 25, 940, 108, '3', '20'),
(481, 25, 976, 108, '3', '21'),
(482, 25, 1012, 108, '3', '22'),
(483, 25, 1048, 108, '3', '23'),
(484, 25, 1084, 108, '3', '24'),
(485, 25, 1120, 108, '3', '25'),
(486, 25, 1156, 108, '3', '26'),
(487, 25, 1192, 108, '3', '27'),
(488, 25, 1228, 108, '3', '28'),
(489, 25, 1264, 108, '3', '29'),
(490, 25, 1300, 108, '3', '30'),
(491, 25, 1336, 108, '3', '31'),
(492, 25, 1372, 108, '3', '32'),
(493, 25, 1408, 108, '3', '33'),
(494, 25, 1444, 108, '3', '34'),
(495, 25, 184, 144, '4', '1'),
(496, 25, 220, 144, '4', '2'),
(497, 25, 256, 144, '4', '3'),
(498, 25, 292, 144, '4', '4'),
(499, 25, 328, 144, '4', '5'),
(500, 25, 364, 144, '4', '6'),
(501, 25, 400, 144, '4', '7'),
(502, 25, 436, 144, '4', '8'),
(503, 25, 472, 144, '4', '9'),
(504, 25, 508, 144, '4', '10'),
(505, 25, 544, 144, '4', '11'),
(506, 25, 580, 144, '4', '12'),
(507, 25, 616, 144, '4', '13'),
(508, 25, 652, 144, '4', '14'),
(509, 25, 688, 144, '4', '15'),
(510, 25, 724, 144, '4', '16'),
(511, 25, 760, 144, '4', '17'),
(512, 25, 868, 144, '4', '18'),
(513, 25, 904, 144, '4', '19'),
(514, 25, 940, 144, '4', '20'),
(515, 25, 976, 144, '4', '21'),
(516, 25, 1012, 144, '4', '22'),
(517, 25, 1048, 144, '4', '23'),
(518, 25, 1084, 144, '4', '24'),
(519, 25, 1120, 144, '4', '25'),
(520, 25, 1156, 144, '4', '26'),
(521, 25, 1192, 144, '4', '27'),
(522, 25, 1228, 144, '4', '28'),
(523, 25, 1264, 144, '4', '29'),
(524, 25, 1300, 144, '4', '30'),
(525, 25, 1336, 144, '4', '31'),
(526, 25, 1372, 144, '4', '32'),
(527, 25, 1408, 144, '4', '33'),
(528, 25, 1444, 144, '4', '34'),
(529, 25, 184, 180, '5', '1'),
(530, 25, 220, 180, '5', '2'),
(531, 25, 256, 180, '5', '3'),
(532, 25, 292, 180, '5', '4'),
(533, 25, 328, 180, '5', '5'),
(534, 25, 364, 180, '5', '6'),
(535, 25, 400, 180, '5', '7'),
(536, 25, 436, 180, '5', '8'),
(537, 25, 472, 180, '5', '9'),
(538, 25, 508, 180, '5', '10'),
(539, 25, 544, 180, '5', '11'),
(540, 25, 580, 180, '5', '12'),
(541, 25, 616, 180, '5', '13'),
(542, 25, 652, 180, '5', '14'),
(543, 25, 688, 180, '5', '15'),
(544, 25, 724, 180, '5', '16'),
(545, 25, 760, 180, '5', '17'),
(546, 25, 868, 180, '5', '18'),
(547, 25, 904, 180, '5', '19'),
(548, 25, 940, 180, '5', '20'),
(549, 25, 976, 180, '5', '21'),
(550, 25, 1012, 180, '5', '22'),
(551, 25, 1048, 180, '5', '23'),
(552, 25, 1084, 180, '5', '24'),
(553, 25, 1120, 180, '5', '25'),
(554, 25, 1156, 180, '5', '26'),
(555, 25, 1192, 180, '5', '27'),
(556, 25, 1228, 180, '5', '28'),
(557, 25, 1264, 180, '5', '29'),
(558, 25, 1300, 180, '5', '30'),
(559, 25, 1336, 180, '5', '31'),
(560, 25, 1372, 180, '5', '32'),
(561, 25, 1408, 180, '5', '33'),
(562, 25, 1444, 180, '5', '34'),
(563, 25, 184, 216, '6', '1'),
(564, 25, 220, 216, '6', '2'),
(565, 25, 256, 216, '6', '3'),
(566, 25, 292, 216, '6', '4'),
(567, 25, 328, 216, '6', '5'),
(568, 25, 364, 216, '6', '6'),
(569, 25, 400, 216, '6', '7'),
(570, 25, 436, 216, '6', '8'),
(571, 25, 472, 216, '6', '9'),
(572, 25, 508, 216, '6', '10'),
(573, 25, 544, 216, '6', '11'),
(574, 25, 580, 216, '6', '12'),
(575, 25, 616, 216, '6', '13'),
(576, 25, 652, 216, '6', '14'),
(577, 25, 688, 216, '6', '15'),
(578, 25, 724, 216, '6', '16'),
(579, 25, 760, 216, '6', '17'),
(580, 25, 868, 216, '6', '18'),
(581, 25, 904, 216, '6', '19'),
(582, 25, 940, 216, '6', '20'),
(583, 25, 976, 216, '6', '21'),
(584, 25, 1012, 216, '6', '22'),
(585, 25, 1048, 216, '6', '23'),
(586, 25, 1084, 216, '6', '24'),
(587, 25, 1120, 216, '6', '25'),
(588, 25, 1156, 216, '6', '26'),
(589, 25, 1192, 216, '6', '27'),
(590, 25, 1228, 216, '6', '28'),
(591, 25, 1264, 216, '6', '29'),
(592, 25, 1300, 216, '6', '30'),
(593, 25, 1336, 216, '6', '31'),
(594, 25, 1372, 216, '6', '32'),
(595, 25, 1408, 216, '6', '33'),
(596, 25, 1444, 216, '6', '34'),
(597, 25, 148, 252, '7', '1'),
(598, 25, 184, 252, '7', '2'),
(599, 25, 220, 252, '7', '3'),
(600, 25, 256, 252, '7', '4'),
(601, 25, 292, 252, '7', '5'),
(602, 25, 328, 252, '7', '6'),
(603, 25, 364, 252, '7', '7'),
(604, 25, 400, 252, '7', '8'),
(605, 25, 436, 252, '7', '9'),
(606, 25, 472, 252, '7', '10'),
(607, 25, 508, 252, '7', '11'),
(608, 25, 544, 252, '7', '12'),
(609, 25, 580, 252, '7', '13'),
(610, 25, 616, 252, '7', '14'),
(611, 25, 652, 252, '7', '15'),
(612, 25, 688, 252, '7', '16'),
(613, 25, 724, 252, '7', '17'),
(614, 25, 760, 252, '7', '18'),
(615, 25, 868, 252, '7', '19'),
(616, 25, 904, 252, '7', '20'),
(617, 25, 940, 252, '7', '21'),
(618, 25, 976, 252, '7', '22'),
(619, 25, 1012, 252, '7', '23'),
(620, 25, 1048, 252, '7', '24'),
(621, 25, 1084, 252, '7', '25'),
(622, 25, 1120, 252, '7', '26'),
(623, 25, 1156, 252, '7', '27'),
(624, 25, 1192, 252, '7', '28'),
(625, 25, 1228, 252, '7', '29'),
(626, 25, 1264, 252, '7', '30'),
(627, 25, 1300, 252, '7', '31'),
(628, 25, 1336, 252, '7', '32'),
(629, 25, 1372, 252, '7', '33'),
(630, 25, 1408, 252, '7', '34'),
(631, 25, 1444, 252, '7', '35'),
(632, 25, 1480, 252, '7', '36'),
(633, 25, 112, 288, '8', '1'),
(634, 25, 148, 288, '8', '2'),
(635, 25, 184, 288, '8', '3'),
(636, 25, 220, 288, '8', '4'),
(637, 25, 256, 288, '8', '5'),
(638, 25, 292, 288, '8', '6'),
(639, 25, 328, 288, '8', '7'),
(640, 25, 364, 288, '8', '8'),
(641, 25, 400, 288, '8', '9'),
(642, 25, 436, 288, '8', '10'),
(643, 25, 472, 288, '8', '11'),
(644, 25, 508, 288, '8', '12'),
(645, 25, 544, 288, '8', '13'),
(646, 25, 580, 288, '8', '14'),
(647, 25, 616, 288, '8', '15'),
(648, 25, 652, 288, '8', '16'),
(649, 25, 688, 288, '8', '17'),
(650, 25, 724, 288, '8', '18'),
(651, 25, 760, 288, '8', '19'),
(652, 25, 868, 288, '8', '20'),
(653, 25, 904, 288, '8', '21'),
(654, 25, 940, 288, '8', '22'),
(655, 25, 976, 288, '8', '23'),
(656, 25, 1012, 288, '8', '24'),
(657, 25, 1048, 288, '8', '25'),
(658, 25, 1084, 288, '8', '26'),
(659, 25, 1120, 288, '8', '27'),
(660, 25, 1156, 288, '8', '28'),
(661, 25, 1192, 288, '8', '29'),
(662, 25, 1228, 288, '8', '30'),
(663, 25, 1264, 288, '8', '31'),
(664, 25, 1300, 288, '8', '32'),
(665, 25, 1336, 288, '8', '33'),
(666, 25, 1372, 288, '8', '34'),
(667, 25, 1408, 288, '8', '35'),
(668, 25, 1444, 288, '8', '36'),
(669, 25, 1480, 288, '8', '37'),
(670, 25, 1516, 288, '8', '38'),
(671, 25, 76, 324, '9', '1'),
(672, 25, 112, 324, '9', '2'),
(673, 25, 148, 324, '9', '3'),
(674, 25, 184, 324, '9', '4'),
(675, 25, 220, 324, '9', '5'),
(676, 25, 256, 324, '9', '6'),
(677, 25, 292, 324, '9', '7'),
(678, 25, 328, 324, '9', '8'),
(679, 25, 364, 324, '9', '9'),
(680, 25, 400, 324, '9', '10'),
(681, 25, 436, 324, '9', '11'),
(682, 25, 472, 324, '9', '12'),
(683, 25, 508, 324, '9', '13'),
(684, 25, 544, 324, '9', '14'),
(685, 25, 580, 324, '9', '15'),
(686, 25, 616, 324, '9', '16'),
(687, 25, 652, 324, '9', '17'),
(688, 25, 688, 324, '9', '18'),
(689, 25, 724, 324, '9', '19'),
(690, 25, 760, 324, '9', '20'),
(691, 25, 868, 324, '9', '21'),
(692, 25, 904, 324, '9', '22'),
(693, 25, 940, 324, '9', '23'),
(694, 25, 976, 324, '9', '24'),
(695, 25, 1012, 324, '9', '25'),
(696, 25, 1048, 324, '9', '26'),
(697, 25, 1084, 324, '9', '27'),
(698, 25, 1120, 324, '9', '28'),
(699, 25, 1156, 324, '9', '29'),
(700, 25, 1192, 324, '9', '30'),
(701, 25, 1228, 324, '9', '31'),
(702, 25, 1264, 324, '9', '32'),
(703, 25, 1300, 324, '9', '33'),
(704, 25, 1336, 324, '9', '34'),
(705, 25, 1372, 324, '9', '35'),
(706, 25, 1408, 324, '9', '36'),
(707, 25, 1444, 324, '9', '37'),
(708, 25, 1480, 324, '9', '38'),
(709, 25, 1516, 324, '9', '39'),
(710, 25, 1552, 324, '9', '40'),
(711, 26, 76, 41, '10', '1'),
(712, 26, 112, 41, '10', '2'),
(713, 26, 148, 41, '10', '3'),
(714, 26, 184, 41, '10', '4'),
(715, 26, 220, 41, '10', '5'),
(716, 26, 256, 41, '10', '6'),
(717, 26, 292, 41, '10', '7'),
(718, 26, 328, 41, '10', '8'),
(719, 26, 364, 41, '10', '9'),
(720, 26, 400, 41, '10', '10'),
(721, 26, 544, 41, '10', '11'),
(722, 26, 580, 41, '10', '12'),
(723, 26, 616, 41, '10', '13'),
(724, 26, 652, 41, '10', '14'),
(725, 26, 688, 41, '10', '15'),
(726, 26, 724, 41, '10', '16'),
(727, 26, 760, 41, '10', '17'),
(728, 26, 796, 41, '10', '18'),
(729, 26, 832, 41, '10', '19'),
(730, 26, 868, 41, '10', '20'),
(731, 26, 904, 41, '10', '21'),
(732, 26, 940, 41, '10', '22'),
(733, 26, 976, 41, '10', '23'),
(734, 26, 1012, 41, '10', '24'),
(735, 26, 1048, 41, '10', '25'),
(736, 26, 1084, 41, '10', '26'),
(737, 26, 1120, 41, '10', '27'),
(738, 26, 1156, 41, '10', '28'),
(739, 26, 1192, 41, '10', '29'),
(740, 26, 1228, 41, '10', '30'),
(741, 26, 1264, 41, '10', '31'),
(742, 26, 1300, 41, '10', '32'),
(743, 26, 1480, 41, '10', '33'),
(744, 26, 1516, 41, '10', '34'),
(745, 26, 1552, 41, '10', '35'),
(746, 26, 1588, 41, '10', '36'),
(747, 26, 1624, 41, '10', '37'),
(748, 26, 1660, 41, '10', '38'),
(749, 26, 1696, 41, '10', '39'),
(750, 26, 1732, 41, '10', '40'),
(751, 26, 1768, 41, '10', '41'),
(752, 26, 1804, 41, '10', '42'),
(753, 26, 76, 77, '11', '1'),
(754, 26, 112, 77, '11', '2'),
(755, 26, 148, 77, '11', '3'),
(756, 26, 184, 77, '11', '4'),
(757, 26, 220, 77, '11', '5'),
(758, 26, 256, 77, '11', '6'),
(759, 26, 292, 77, '11', '7'),
(760, 26, 328, 77, '11', '8'),
(761, 26, 364, 77, '11', '9'),
(762, 26, 400, 77, '11', '10'),
(763, 26, 544, 77, '11', '11'),
(764, 26, 580, 77, '11', '12'),
(765, 26, 616, 77, '11', '13'),
(766, 26, 652, 77, '11', '14'),
(767, 26, 688, 77, '11', '15'),
(768, 26, 724, 77, '11', '16'),
(769, 26, 760, 77, '11', '17'),
(770, 26, 796, 77, '11', '18'),
(771, 26, 832, 77, '11', '19'),
(772, 26, 868, 77, '11', '20'),
(773, 26, 904, 77, '11', '21'),
(774, 26, 940, 77, '11', '22'),
(775, 26, 976, 77, '11', '23'),
(776, 26, 1012, 77, '11', '24'),
(777, 26, 1048, 77, '11', '25'),
(778, 26, 1084, 77, '11', '26'),
(779, 26, 1120, 77, '11', '27'),
(780, 26, 1156, 77, '11', '28'),
(781, 26, 1192, 77, '11', '29'),
(782, 26, 1228, 77, '11', '30'),
(783, 26, 1264, 77, '11', '31'),
(784, 26, 1300, 77, '11', '32'),
(785, 26, 1336, 77, '11', '33'),
(786, 26, 1480, 77, '11', '34'),
(787, 26, 1516, 77, '11', '35'),
(788, 26, 1552, 77, '11', '36'),
(789, 26, 1588, 77, '11', '37'),
(790, 26, 1624, 77, '11', '38'),
(791, 26, 1660, 77, '11', '39'),
(792, 26, 1696, 77, '11', '40'),
(793, 26, 1732, 77, '11', '41'),
(794, 26, 1768, 77, '11', '42'),
(795, 26, 1804, 77, '11', '43'),
(796, 26, 76, 113, '12', '1'),
(797, 26, 112, 113, '12', '2'),
(798, 26, 148, 113, '12', '3'),
(799, 26, 184, 113, '12', '4'),
(800, 26, 220, 113, '12', '5'),
(801, 26, 256, 113, '12', '6'),
(802, 26, 292, 113, '12', '7'),
(803, 26, 328, 113, '12', '8'),
(804, 26, 364, 113, '12', '9'),
(805, 26, 400, 113, '12', '10'),
(806, 26, 508, 113, '12', '11'),
(807, 26, 544, 113, '12', '12'),
(808, 26, 580, 113, '12', '13'),
(809, 26, 616, 113, '12', '14'),
(810, 26, 652, 113, '12', '15'),
(811, 26, 688, 113, '12', '16'),
(812, 26, 724, 113, '12', '17'),
(813, 26, 760, 113, '12', '18'),
(814, 26, 796, 113, '12', '19'),
(815, 26, 832, 113, '12', '20'),
(816, 26, 868, 113, '12', '21'),
(817, 26, 904, 113, '12', '22'),
(818, 26, 940, 113, '12', '23'),
(819, 26, 976, 113, '12', '24'),
(820, 26, 1012, 113, '12', '25'),
(821, 26, 1048, 113, '12', '26'),
(822, 26, 1084, 113, '12', '27'),
(823, 26, 1120, 113, '12', '28'),
(824, 26, 1156, 113, '12', '29'),
(825, 26, 1192, 113, '12', '30'),
(826, 26, 1228, 113, '12', '31'),
(827, 26, 1264, 113, '12', '32'),
(828, 26, 1300, 113, '12', '33'),
(829, 26, 1336, 113, '12', '34'),
(830, 26, 1480, 113, '12', '35'),
(831, 26, 1516, 113, '12', '36'),
(832, 26, 1552, 113, '12', '37'),
(833, 26, 1588, 113, '12', '38'),
(834, 26, 1624, 113, '12', '39'),
(835, 26, 1660, 113, '12', '40'),
(836, 26, 1696, 113, '12', '41'),
(837, 26, 1732, 113, '12', '42'),
(838, 26, 1768, 113, '12', '43'),
(839, 26, 1804, 113, '12', '44'),
(840, 26, 112, 149, '13', '1'),
(841, 26, 148, 149, '13', '2'),
(842, 26, 184, 149, '13', '3'),
(843, 26, 220, 149, '13', '4'),
(844, 26, 256, 149, '13', '5'),
(845, 26, 292, 149, '13', '6'),
(846, 26, 328, 149, '13', '7'),
(847, 26, 364, 149, '13', '8'),
(848, 26, 400, 149, '13', '9'),
(849, 26, 508, 149, '13', '10'),
(850, 26, 544, 149, '13', '11'),
(851, 26, 580, 149, '13', '12'),
(852, 26, 616, 149, '13', '13'),
(853, 26, 652, 149, '13', '14'),
(854, 26, 688, 149, '13', '15'),
(855, 26, 724, 149, '13', '16'),
(856, 26, 760, 149, '13', '17'),
(857, 26, 796, 149, '13', '18'),
(858, 26, 832, 149, '13', '19'),
(859, 26, 868, 149, '13', '20'),
(860, 26, 904, 149, '13', '21'),
(861, 26, 940, 149, '13', '22'),
(862, 26, 976, 149, '13', '23'),
(863, 26, 1012, 149, '13', '24'),
(864, 26, 1048, 149, '13', '25'),
(865, 26, 1084, 149, '13', '26'),
(866, 26, 1120, 149, '13', '27'),
(867, 26, 1156, 149, '13', '28'),
(868, 26, 1192, 149, '13', '29'),
(869, 26, 1228, 149, '13', '30'),
(870, 26, 1264, 149, '13', '31'),
(871, 26, 1300, 149, '13', '32'),
(872, 26, 1336, 149, '13', '33'),
(873, 26, 1480, 149, '13', '34'),
(874, 26, 1516, 149, '13', '35'),
(875, 26, 1552, 149, '13', '36'),
(876, 26, 1588, 149, '13', '37'),
(877, 26, 1624, 149, '13', '38'),
(878, 26, 1660, 149, '13', '39'),
(879, 26, 1696, 149, '13', '40'),
(880, 26, 1732, 149, '13', '41'),
(881, 26, 1768, 149, '13', '42'),
(882, 26, 148, 185, '14', '1'),
(883, 26, 184, 185, '14', '2'),
(884, 26, 220, 185, '14', '3'),
(885, 26, 256, 185, '14', '4'),
(886, 26, 292, 185, '14', '5'),
(887, 26, 328, 185, '14', '6'),
(888, 26, 364, 185, '14', '7'),
(889, 26, 400, 185, '14', '8'),
(890, 26, 508, 185, '14', '9'),
(891, 26, 544, 185, '14', '10'),
(892, 26, 580, 185, '14', '11'),
(893, 26, 616, 185, '14', '12'),
(894, 26, 652, 185, '14', '13'),
(895, 26, 688, 185, '14', '14'),
(896, 26, 724, 185, '14', '15'),
(897, 26, 760, 185, '14', '16'),
(898, 26, 796, 185, '14', '17'),
(899, 26, 832, 185, '14', '18'),
(900, 26, 868, 185, '14', '19'),
(901, 26, 904, 185, '14', '20'),
(902, 26, 940, 185, '14', '21'),
(903, 26, 976, 185, '14', '22'),
(904, 26, 1012, 185, '14', '23'),
(905, 26, 1048, 185, '14', '24'),
(906, 26, 1084, 185, '14', '25'),
(907, 26, 1120, 185, '14', '26'),
(908, 26, 1156, 185, '14', '27'),
(909, 26, 1192, 185, '14', '28'),
(910, 26, 1228, 185, '14', '29'),
(911, 26, 1264, 185, '14', '30'),
(912, 26, 1300, 185, '14', '31'),
(913, 26, 1336, 185, '14', '32'),
(914, 26, 1372, 185, '14', '33'),
(915, 26, 1480, 185, '14', '34'),
(916, 26, 1516, 185, '14', '35'),
(917, 26, 1552, 185, '14', '36'),
(918, 26, 1588, 185, '14', '37'),
(919, 26, 1624, 185, '14', '38'),
(920, 26, 1660, 185, '14', '39'),
(921, 26, 1696, 185, '14', '40'),
(922, 26, 1732, 185, '14', '41'),
(923, 26, 148, 221, '15', '1'),
(924, 26, 184, 221, '15', '2'),
(925, 26, 220, 221, '15', '3'),
(926, 26, 256, 221, '15', '4'),
(927, 26, 292, 221, '15', '5'),
(928, 26, 328, 221, '15', '6'),
(929, 26, 364, 221, '15', '7'),
(930, 26, 400, 221, '15', '8'),
(931, 26, 508, 221, '15', '9'),
(932, 26, 544, 221, '15', '10'),
(933, 26, 580, 221, '15', '11'),
(934, 26, 616, 221, '15', '12'),
(935, 26, 652, 221, '15', '13'),
(936, 26, 688, 221, '15', '14'),
(937, 26, 724, 221, '15', '15'),
(938, 26, 760, 221, '15', '16'),
(939, 26, 796, 221, '15', '17'),
(940, 26, 832, 221, '15', '18'),
(941, 26, 868, 221, '15', '19'),
(942, 26, 904, 221, '15', '20'),
(943, 26, 940, 221, '15', '21'),
(944, 26, 976, 221, '15', '22'),
(945, 26, 1012, 221, '15', '23'),
(946, 26, 1048, 221, '15', '24'),
(947, 26, 1084, 221, '15', '25'),
(948, 26, 1120, 221, '15', '26'),
(949, 26, 1156, 221, '15', '27'),
(950, 26, 1192, 221, '15', '28'),
(951, 26, 1228, 221, '15', '29'),
(952, 26, 1264, 221, '15', '30'),
(953, 26, 1300, 221, '15', '31'),
(954, 26, 1336, 221, '15', '32'),
(955, 26, 1372, 221, '15', '33'),
(956, 26, 1480, 221, '15', '34'),
(957, 26, 1516, 221, '15', '35'),
(958, 26, 1552, 221, '15', '36'),
(959, 26, 1588, 221, '15', '37'),
(960, 26, 1624, 221, '15', '38'),
(961, 26, 1660, 221, '15', '39'),
(962, 26, 1696, 221, '15', '40'),
(963, 26, 220, 257, '16', '1'),
(964, 26, 256, 257, '16', '2'),
(965, 26, 292, 257, '16', '3'),
(966, 26, 328, 257, '16', '4'),
(967, 26, 364, 257, '16', '5'),
(968, 26, 400, 257, '16', '6'),
(969, 26, 508, 257, '16', '7'),
(970, 26, 544, 257, '16', '8'),
(971, 26, 580, 257, '16', '9'),
(972, 26, 616, 257, '16', '10'),
(973, 26, 652, 257, '16', '11'),
(974, 26, 688, 257, '16', '12'),
(975, 26, 724, 257, '16', '13'),
(976, 26, 760, 257, '16', '14'),
(977, 26, 796, 257, '16', '15'),
(978, 26, 832, 257, '16', '16'),
(979, 26, 1084, 257, '16', '17'),
(980, 26, 1120, 257, '16', '18'),
(981, 26, 1156, 257, '16', '19'),
(982, 26, 1192, 257, '16', '20'),
(983, 26, 1228, 257, '16', '21'),
(984, 26, 1264, 257, '16', '22'),
(985, 26, 1300, 257, '16', '23'),
(986, 26, 1336, 257, '16', '24'),
(987, 26, 1372, 257, '16', '25'),
(988, 26, 1408, 257, '16', '26'),
(989, 26, 1480, 257, '16', '27'),
(990, 26, 1516, 257, '16', '28'),
(991, 26, 1552, 257, '16', '29'),
(992, 26, 1588, 257, '16', '30'),
(993, 26, 1624, 257, '16', '31'),
(994, 26, 1660, 257, '16', '32'),
(995, 26, 328, 293, '17', '1'),
(996, 26, 364, 293, '17', '2'),
(997, 26, 400, 293, '17', '3'),
(998, 26, 472, 293, '17', '4'),
(999, 26, 508, 293, '17', '5'),
(1000, 26, 544, 293, '17', '6'),
(1001, 26, 580, 293, '17', '7'),
(1002, 26, 616, 293, '17', '8'),
(1003, 26, 652, 293, '17', '9'),
(1004, 26, 688, 293, '17', '10'),
(1005, 26, 724, 293, '17', '11'),
(1006, 26, 760, 293, '17', '12'),
(1007, 26, 796, 293, '17', '13'),
(1008, 26, 1084, 293, '17', '14'),
(1009, 26, 1120, 293, '17', '15'),
(1010, 26, 1156, 293, '17', '16'),
(1011, 26, 1192, 293, '17', '17'),
(1012, 26, 1228, 293, '17', '18'),
(1013, 26, 1264, 293, '17', '19'),
(1014, 26, 1300, 293, '17', '20'),
(1015, 26, 1336, 293, '17', '21'),
(1016, 26, 1372, 293, '17', '22'),
(1017, 26, 1408, 293, '17', '23'),
(1018, 26, 1480, 293, '17', '24'),
(1019, 26, 1516, 293, '17', '25'),
(1020, 26, 1552, 293, '17', '26'),
(1021, 26, 1588, 293, '17', '27'),
(1022, 26, 472, 329, '18', '1'),
(1023, 26, 508, 329, '18', '2'),
(1024, 26, 544, 329, '18', '3'),
(1025, 26, 580, 329, '18', '4'),
(1026, 26, 616, 329, '18', '5'),
(1027, 26, 652, 329, '18', '6'),
(1028, 26, 688, 329, '18', '7'),
(1029, 26, 724, 329, '18', '8'),
(1030, 26, 760, 329, '18', '9'),
(1031, 26, 796, 329, '18', '10'),
(1032, 26, 1084, 329, '18', '11'),
(1033, 26, 1120, 329, '18', '12'),
(1034, 26, 1156, 329, '18', '13'),
(1035, 26, 1192, 329, '18', '14'),
(1036, 26, 1228, 329, '18', '15'),
(1037, 26, 1264, 329, '18', '16'),
(1038, 26, 1300, 329, '18', '17'),
(1039, 26, 1336, 329, '18', '18'),
(1040, 26, 1372, 329, '18', '19'),
(1041, 26, 1408, 329, '18', '20'),
(1052, 27, 120, 36, '1', '11'),
(1053, 27, 156, 36, '1', '12'),
(1054, 27, 192, 36, '1', '13'),
(1055, 27, 228, 36, '1', '14'),
(1056, 27, 264, 36, '1', '15'),
(1057, 27, 300, 36, '1', '16'),
(1058, 27, 336, 36, '1', '17'),
(1059, 27, 372, 36, '1', '18'),
(1060, 27, 408, 36, '1', '19'),
(1061, 27, 444, 36, '1', '20'),
(1062, 27, 480, 36, '1', '21'),
(1063, 27, 516, 36, '1', '22'),
(1064, 27, 552, 36, '1', '23'),
(1065, 27, 588, 36, '1', '24'),
(1066, 27, 624, 36, '1', '25'),
(1067, 27, 660, 36, '1', '26'),
(1068, 27, 696, 36, '1', '27'),
(1069, 27, 732, 36, '1', '28'),
(1070, 27, 768, 36, '1', '29'),
(1071, 27, 804, 36, '1', '30'),
(1072, 27, 840, 36, '1', '31'),
(1073, 27, 876, 36, '1', '32'),
(1074, 27, 912, 36, '1', '33'),
(1075, 27, 948, 36, '1', '34'),
(1076, 27, 984, 36, '1', '35'),
(1088, 27, 120, 72, '2', '12'),
(1089, 27, 156, 72, '2', '13'),
(1090, 27, 192, 72, '2', '14'),
(1091, 27, 228, 72, '2', '15'),
(1092, 27, 264, 72, '2', '16'),
(1093, 27, 300, 72, '2', '17'),
(1094, 27, 336, 72, '2', '18'),
(1095, 27, 372, 72, '2', '19'),
(1096, 27, 408, 72, '2', '20'),
(1097, 27, 444, 72, '2', '21'),
(1098, 27, 480, 72, '2', '22'),
(1099, 27, 516, 72, '2', '23'),
(1100, 27, 552, 72, '2', '24'),
(1101, 27, 588, 72, '2', '25'),
(1102, 27, 624, 72, '2', '26'),
(1103, 27, 660, 72, '2', '27'),
(1104, 27, 696, 72, '2', '28'),
(1105, 27, 732, 72, '2', '29'),
(1106, 27, 768, 72, '2', '30'),
(1107, 27, 804, 72, '2', '31'),
(1108, 27, 840, 72, '2', '32'),
(1109, 27, 876, 72, '2', '33'),
(1110, 27, 912, 72, '2', '34'),
(1111, 27, 948, 72, '2', '35'),
(1112, 27, 984, 72, '2', '36'),
(1113, 27, 1020, 72, '2', '37'),
(1114, 27, 1056, 72, '2', '38'),
(1123, 27, 84, 108, '3', '9'),
(1124, 27, 120, 108, '3', '10'),
(1125, 27, 156, 108, '3', '11'),
(1126, 27, 192, 108, '3', '12'),
(1127, 27, 228, 108, '3', '13'),
(1128, 27, 264, 108, '3', '14'),
(1129, 27, 300, 108, '3', '15'),
(1130, 27, 336, 108, '3', '16'),
(1131, 27, 372, 108, '3', '17'),
(1132, 27, 408, 108, '3', '18'),
(1133, 27, 444, 108, '3', '19'),
(1134, 27, 480, 108, '3', '20'),
(1135, 27, 516, 108, '3', '21'),
(1136, 27, 552, 108, '3', '22'),
(1137, 27, 588, 108, '3', '23'),
(1138, 27, 624, 108, '3', '24'),
(1139, 27, 660, 108, '3', '25'),
(1140, 27, 696, 108, '3', '26'),
(1141, 27, 732, 108, '3', '27'),
(1142, 27, 768, 108, '3', '28'),
(1143, 27, 804, 108, '3', '29'),
(1144, 27, 840, 108, '3', '30'),
(1145, 27, 876, 108, '3', '31'),
(1146, 27, 912, 108, '3', '32'),
(1147, 27, 948, 108, '3', '33'),
(1148, 27, 984, 108, '3', '34'),
(1149, 27, 1020, 108, '3', '35'),
(1150, 27, 1056, 108, '3', '36'),
(1158, 27, 48, 144, '4', '8'),
(1159, 27, 84, 144, '4', '9'),
(1160, 27, 120, 144, '4', '10'),
(1161, 27, 156, 144, '4', '11'),
(1162, 27, 192, 144, '4', '12'),
(1163, 27, 228, 144, '4', '13'),
(1164, 27, 264, 144, '4', '14'),
(1165, 27, 300, 144, '4', '15'),
(1166, 27, 336, 144, '4', '16'),
(1167, 27, 372, 144, '4', '17'),
(1168, 27, 408, 144, '4', '18'),
(1169, 27, 444, 144, '4', '19'),
(1170, 27, 480, 144, '4', '20'),
(1171, 27, 516, 144, '4', '21'),
(1172, 27, 552, 144, '4', '22'),
(1173, 27, 588, 144, '4', '23'),
(1174, 27, 624, 144, '4', '24'),
(1175, 27, 660, 144, '4', '25'),
(1176, 27, 696, 144, '4', '26'),
(1177, 27, 732, 144, '4', '27'),
(1178, 27, 768, 144, '4', '28'),
(1179, 27, 804, 144, '4', '29'),
(1180, 27, 840, 144, '4', '30'),
(1181, 27, 876, 144, '4', '31'),
(1182, 27, 912, 144, '4', '32'),
(1183, 27, 948, 144, '4', '33'),
(1184, 27, 984, 144, '4', '34'),
(1185, 27, 1020, 144, '4', '35'),
(1186, 27, 1056, 144, '4', '36'),
(1194, 27, 48, 180, '5', '8'),
(1195, 27, 84, 180, '5', '9'),
(1196, 27, 120, 180, '5', '10'),
(1197, 27, 156, 180, '5', '11'),
(1198, 27, 192, 180, '5', '12'),
(1199, 27, 228, 180, '5', '13'),
(1200, 27, 264, 180, '5', '14'),
(1201, 27, 300, 180, '5', '15'),
(1202, 27, 336, 180, '5', '16'),
(1203, 27, 372, 180, '5', '17'),
(1204, 27, 408, 180, '5', '18'),
(1205, 27, 444, 180, '5', '19'),
(1206, 27, 480, 180, '5', '20'),
(1207, 27, 516, 180, '5', '21'),
(1208, 27, 552, 180, '5', '22'),
(1209, 27, 588, 180, '5', '23'),
(1210, 27, 624, 180, '5', '24'),
(1211, 27, 660, 180, '5', '25'),
(1212, 27, 696, 180, '5', '26'),
(1213, 27, 732, 180, '5', '27'),
(1214, 27, 768, 180, '5', '28'),
(1215, 27, 804, 180, '5', '29'),
(1216, 27, 840, 180, '5', '30'),
(1217, 27, 876, 180, '5', '31'),
(1218, 27, 912, 180, '5', '32'),
(1219, 27, 948, 180, '5', '33'),
(1220, 27, 984, 180, '5', '34'),
(1221, 27, 1020, 180, '5', '35'),
(1222, 27, 1056, 180, '5', '36'),
(1223, 28, 76, 36, '1', '1'),
(1224, 28, 112, 36, '1', '2'),
(1225, 28, 148, 36, '1', '3'),
(1226, 28, 184, 36, '1', '4'),
(1227, 28, 220, 36, '1', '5'),
(1228, 28, 256, 36, '1', '6'),
(1229, 28, 292, 36, '1', '7'),
(1230, 28, 328, 36, '1', '8'),
(1231, 28, 76, 72, '2', '1'),
(1232, 28, 112, 72, '2', '2'),
(1233, 28, 148, 72, '2', '3'),
(1234, 28, 184, 72, '2', '4'),
(1235, 28, 220, 72, '2', '5'),
(1236, 28, 256, 72, '2', '6'),
(1237, 28, 292, 72, '2', '7'),
(1238, 28, 328, 72, '2', '8'),
(1239, 28, 112, 108, '3', '1'),
(1240, 28, 148, 108, '3', '2'),
(1241, 28, 184, 108, '3', '3'),
(1242, 28, 220, 108, '3', '4'),
(1243, 28, 256, 108, '3', '5'),
(1244, 28, 292, 108, '3', '6'),
(1245, 28, 328, 108, '3', '7'),
(1246, 28, 112, 144, '4', '1'),
(1247, 28, 148, 144, '4', '2'),
(1248, 28, 184, 144, '4', '3'),
(1249, 28, 220, 144, '4', '4'),
(1250, 28, 256, 144, '4', '5'),
(1251, 28, 292, 144, '4', '6'),
(1252, 28, 328, 144, '4', '7'),
(1253, 28, 112, 180, '5', '1'),
(1254, 28, 148, 180, '5', '2'),
(1255, 28, 184, 180, '5', '3'),
(1256, 28, 220, 180, '5', '4'),
(1257, 28, 256, 180, '5', '5'),
(1258, 28, 292, 180, '5', '6'),
(1259, 28, 328, 180, '5', '7'),
(1260, 28, 112, 216, '6', '1'),
(1261, 28, 148, 216, '6', '2'),
(1262, 28, 184, 216, '6', '3'),
(1263, 28, 220, 216, '6', '4'),
(1264, 28, 256, 216, '6', '5'),
(1265, 28, 292, 216, '6', '6'),
(1266, 28, 328, 216, '6', '7'),
(1267, 28, 76, 252, '7', '1'),
(1268, 28, 112, 252, '7', '2'),
(1269, 28, 148, 252, '7', '3'),
(1270, 28, 184, 252, '7', '4'),
(1271, 28, 220, 252, '7', '5'),
(1272, 28, 256, 252, '7', '6'),
(1273, 28, 292, 252, '7', '7'),
(1274, 28, 328, 252, '7', '8'),
(1275, 29, 94, 36, '1', '1'),
(1276, 29, 130, 36, '1', '2'),
(1277, 29, 166, 36, '1', '3'),
(1278, 29, 202, 36, '1', '4'),
(1279, 29, 238, 36, '1', '5'),
(1280, 29, 274, 36, '1', '6'),
(1281, 29, 310, 36, '1', '7'),
(1282, 29, 346, 36, '1', '8'),
(1283, 29, 382, 36, '1', '9'),
(1284, 29, 418, 36, '1', '10'),
(1285, 29, 454, 36, '1', '11'),
(1286, 29, 490, 36, '1', '12'),
(1287, 29, 526, 36, '1', '13'),
(1288, 29, 562, 36, '1', '14'),
(1289, 29, 598, 36, '1', '15'),
(1290, 29, 634, 36, '1', '16'),
(1291, 29, 670, 36, '1', '17'),
(1292, 29, 706, 36, '1', '18'),
(1293, 29, 742, 36, '1', '19'),
(1294, 29, 94, 72, '2', '1'),
(1295, 29, 130, 72, '2', '2'),
(1296, 29, 166, 72, '2', '3'),
(1297, 29, 202, 72, '2', '4'),
(1298, 29, 238, 72, '2', '5'),
(1299, 29, 274, 72, '2', '6'),
(1300, 29, 310, 72, '2', '7'),
(1301, 29, 346, 72, '2', '8'),
(1302, 29, 382, 72, '2', '9'),
(1303, 29, 418, 72, '2', '10'),
(1304, 29, 454, 72, '2', '11'),
(1305, 29, 490, 72, '2', '12'),
(1306, 29, 526, 72, '2', '13'),
(1307, 29, 562, 72, '2', '14'),
(1308, 29, 598, 72, '2', '15'),
(1309, 29, 634, 72, '2', '16'),
(1310, 29, 670, 72, '2', '17'),
(1311, 29, 706, 72, '2', '18'),
(1312, 29, 742, 72, '2', '19'),
(1313, 29, 76, 108, '3', '1'),
(1314, 29, 112, 108, '3', '2'),
(1315, 29, 148, 108, '3', '3'),
(1316, 29, 184, 108, '3', '4'),
(1317, 29, 220, 108, '3', '5'),
(1318, 29, 256, 108, '3', '6'),
(1319, 29, 292, 108, '3', '7'),
(1320, 29, 328, 108, '3', '8'),
(1321, 29, 364, 108, '3', '9'),
(1322, 29, 400, 108, '3', '10'),
(1323, 29, 436, 108, '3', '11'),
(1324, 29, 472, 108, '3', '12'),
(1325, 29, 508, 108, '3', '13'),
(1326, 29, 544, 108, '3', '14'),
(1327, 29, 580, 108, '3', '15'),
(1328, 29, 616, 108, '3', '16'),
(1329, 29, 652, 108, '3', '17'),
(1330, 29, 688, 108, '3', '18'),
(1331, 29, 724, 108, '3', '19'),
(1332, 29, 760, 108, '3', '20'),
(1333, 29, 94, 144, '4', '1'),
(1334, 29, 130, 144, '4', '2'),
(1335, 29, 166, 144, '4', '3'),
(1336, 29, 202, 144, '4', '4'),
(1337, 29, 238, 144, '4', '5'),
(1338, 29, 274, 144, '4', '6'),
(1339, 29, 310, 144, '4', '7'),
(1340, 29, 346, 144, '4', '8'),
(1341, 29, 382, 144, '4', '9'),
(1342, 29, 418, 144, '4', '10'),
(1343, 29, 454, 144, '4', '11'),
(1344, 29, 490, 144, '4', '12'),
(1345, 29, 526, 144, '4', '13'),
(1346, 29, 562, 144, '4', '14'),
(1347, 29, 598, 144, '4', '15'),
(1348, 29, 634, 144, '4', '16'),
(1349, 29, 670, 144, '4', '17'),
(1350, 29, 706, 144, '4', '18'),
(1351, 29, 742, 144, '4', '19'),
(1352, 29, 112, 180, '5', '1'),
(1353, 29, 148, 180, '5', '2'),
(1354, 29, 184, 180, '5', '3'),
(1355, 29, 220, 180, '5', '4'),
(1356, 29, 256, 180, '5', '5'),
(1357, 29, 292, 180, '5', '6'),
(1358, 29, 328, 180, '5', '7'),
(1359, 29, 364, 180, '5', '8'),
(1360, 29, 400, 180, '5', '9'),
(1361, 29, 436, 180, '5', '10'),
(1362, 29, 472, 180, '5', '11'),
(1363, 29, 508, 180, '5', '12'),
(1364, 29, 544, 180, '5', '13'),
(1365, 29, 580, 180, '5', '14'),
(1366, 29, 616, 180, '5', '15'),
(1367, 29, 652, 180, '5', '16'),
(1368, 29, 688, 180, '5', '17'),
(1369, 29, 724, 180, '5', '18'),
(1370, 29, 130, 216, '6', '1'),
(1371, 29, 166, 216, '6', '2'),
(1372, 29, 202, 216, '6', '3'),
(1373, 29, 238, 216, '6', '4'),
(1374, 29, 274, 216, '6', '5'),
(1375, 29, 310, 216, '6', '6'),
(1376, 29, 346, 216, '6', '7'),
(1377, 29, 382, 216, '6', '8'),
(1378, 29, 418, 216, '6', '9'),
(1379, 29, 454, 216, '6', '10'),
(1380, 29, 490, 216, '6', '11'),
(1381, 29, 526, 216, '6', '12'),
(1382, 29, 562, 216, '6', '13'),
(1383, 29, 598, 216, '6', '14'),
(1384, 29, 634, 216, '6', '15'),
(1385, 29, 670, 216, '6', '16'),
(1386, 29, 706, 216, '6', '17'),
(1387, 29, 202, 252, '7', '1'),
(1388, 29, 238, 252, '7', '2'),
(1389, 29, 274, 252, '7', '3'),
(1390, 29, 310, 252, '7', '4'),
(1391, 29, 346, 252, '7', '5'),
(1392, 29, 382, 252, '7', '6'),
(1393, 29, 418, 252, '7', '7'),
(1394, 29, 454, 252, '7', '8'),
(1395, 29, 490, 252, '7', '9'),
(1396, 29, 526, 252, '7', '10'),
(1397, 29, 562, 252, '7', '11'),
(1398, 29, 598, 252, '7', '12'),
(1399, 29, 634, 252, '7', '13'),
(1400, 29, 670, 252, '7', '14'),
(1401, 29, 382, 288, '8', '1'),
(1402, 29, 418, 288, '8', '2'),
(1403, 29, 454, 288, '8', '3'),
(1404, 29, 490, 288, '8', '4'),
(1405, 29, 526, 288, '8', '5'),
(1406, 29, 562, 288, '8', '6'),
(1407, 30, 472, 36, '1', '1'),
(1408, 30, 508, 36, '1', '2'),
(1409, 30, 544, 36, '1', '3'),
(1410, 30, 580, 36, '1', '4'),
(1411, 30, 616, 36, '1', '5'),
(1412, 30, 652, 36, '1', '6'),
(1413, 30, 688, 36, '1', '7'),
(1414, 30, 724, 36, '1', '8'),
(1415, 30, 760, 36, '1', '9'),
(1416, 30, 796, 36, '1', '10'),
(1417, 30, 832, 36, '1', '11'),
(1418, 30, 904, 36, '1', '12'),
(1419, 30, 940, 36, '1', '13'),
(1420, 30, 976, 36, '1', '14'),
(1421, 30, 1012, 36, '1', '15'),
(1422, 30, 1048, 36, '1', '16'),
(1423, 30, 1084, 36, '1', '17'),
(1424, 30, 1120, 36, '1', '18'),
(1425, 30, 1156, 36, '1', '19'),
(1426, 30, 1192, 36, '1', '20'),
(1427, 30, 1228, 36, '1', '21'),
(1428, 30, 1264, 36, '1', '22'),
(1429, 30, 1300, 36, '1', '23'),
(1430, 30, 1372, 36, '1', '24'),
(1431, 30, 1408, 36, '1', '25'),
(1432, 30, 1444, 36, '1', '26'),
(1433, 30, 1480, 36, '1', '27'),
(1434, 30, 1516, 36, '1', '28'),
(1435, 30, 1552, 36, '1', '29'),
(1436, 30, 1588, 36, '1', '30'),
(1437, 30, 1624, 36, '1', '31'),
(1438, 30, 1660, 36, '1', '32'),
(1439, 30, 1696, 36, '1', '33'),
(1440, 30, 1732, 36, '1', '34'),
(1441, 30, 436, 72, '2', '1'),
(1442, 30, 472, 72, '2', '2'),
(1443, 30, 508, 72, '2', '3'),
(1444, 30, 544, 72, '2', '4'),
(1445, 30, 580, 72, '2', '5'),
(1446, 30, 616, 72, '2', '6'),
(1447, 30, 652, 72, '2', '7'),
(1448, 30, 688, 72, '2', '8'),
(1449, 30, 724, 72, '2', '9'),
(1450, 30, 760, 72, '2', '10'),
(1451, 30, 796, 72, '2', '11'),
(1452, 30, 868, 72, '2', '12'),
(1453, 30, 904, 72, '2', '13'),
(1454, 30, 940, 72, '2', '14'),
(1455, 30, 976, 72, '2', '15'),
(1456, 30, 1012, 72, '2', '16'),
(1457, 30, 1048, 72, '2', '17'),
(1458, 30, 1084, 72, '2', '18'),
(1459, 30, 1120, 72, '2', '19'),
(1460, 30, 1156, 72, '2', '20'),
(1461, 30, 1192, 72, '2', '21'),
(1462, 30, 1228, 72, '2', '22'),
(1463, 30, 1264, 72, '2', '23'),
(1464, 30, 1300, 72, '2', '24'),
(1465, 30, 1372, 72, '2', '25'),
(1466, 30, 1408, 72, '2', '26'),
(1467, 30, 1444, 72, '2', '27'),
(1468, 30, 1480, 72, '2', '28'),
(1469, 30, 1516, 72, '2', '29'),
(1470, 30, 1552, 72, '2', '30'),
(1471, 30, 1588, 72, '2', '31'),
(1472, 30, 1624, 72, '2', '32'),
(1473, 30, 1660, 72, '2', '33'),
(1474, 30, 1696, 72, '2', '34'),
(1475, 30, 1732, 72, '2', '35'),
(1476, 30, 400, 108, '3', '1'),
(1477, 30, 436, 108, '3', '2'),
(1478, 30, 472, 108, '3', '3'),
(1479, 30, 508, 108, '3', '4'),
(1480, 30, 544, 108, '3', '5'),
(1481, 30, 580, 108, '3', '6'),
(1482, 30, 616, 108, '3', '7'),
(1483, 30, 652, 108, '3', '8'),
(1484, 30, 688, 108, '3', '9'),
(1485, 30, 724, 108, '3', '10'),
(1486, 30, 760, 108, '3', '11'),
(1487, 30, 832, 108, '3', '12'),
(1488, 30, 868, 108, '3', '13'),
(1489, 30, 904, 108, '3', '14'),
(1490, 30, 940, 108, '3', '15'),
(1491, 30, 976, 108, '3', '16'),
(1492, 30, 1012, 108, '3', '17'),
(1493, 30, 1048, 108, '3', '18'),
(1494, 30, 1084, 108, '3', '19'),
(1495, 30, 1120, 108, '3', '20'),
(1496, 30, 1156, 108, '3', '21'),
(1497, 30, 1192, 108, '3', '22'),
(1498, 30, 1228, 108, '3', '23'),
(1499, 30, 1264, 108, '3', '24'),
(1500, 30, 1300, 108, '3', '25'),
(1501, 30, 1336, 108, '3', '26'),
(1502, 30, 1408, 108, '3', '27'),
(1503, 30, 1444, 108, '3', '28'),
(1504, 30, 1480, 108, '3', '29'),
(1505, 30, 1516, 108, '3', '30'),
(1506, 30, 1552, 108, '3', '31'),
(1507, 30, 1588, 108, '3', '32'),
(1508, 30, 1624, 108, '3', '33'),
(1509, 30, 1660, 108, '3', '34'),
(1510, 30, 1696, 108, '3', '35'),
(1511, 30, 1732, 108, '3', '36'),
(1512, 30, 1768, 108, '3', '37'),
(1513, 30, 364, 144, '4', '1'),
(1514, 30, 400, 144, '4', '2'),
(1515, 30, 436, 144, '4', '3'),
(1516, 30, 472, 144, '4', '4'),
(1517, 30, 508, 144, '4', '5'),
(1518, 30, 544, 144, '4', '6'),
(1519, 30, 580, 144, '4', '7'),
(1520, 30, 616, 144, '4', '8'),
(1521, 30, 652, 144, '4', '9'),
(1522, 30, 688, 144, '4', '10'),
(1523, 30, 724, 144, '4', '11'),
(1524, 30, 796, 144, '4', '12'),
(1525, 30, 832, 144, '4', '13'),
(1526, 30, 868, 144, '4', '14'),
(1527, 30, 904, 144, '4', '15'),
(1528, 30, 940, 144, '4', '16'),
(1529, 30, 976, 144, '4', '17'),
(1530, 30, 1012, 144, '4', '18'),
(1531, 30, 1048, 144, '4', '19'),
(1532, 30, 1084, 144, '4', '20'),
(1533, 30, 1120, 144, '4', '21'),
(1534, 30, 1156, 144, '4', '22'),
(1535, 30, 1192, 144, '4', '23'),
(1536, 30, 1228, 144, '4', '24'),
(1537, 30, 1264, 144, '4', '25'),
(1538, 30, 1300, 144, '4', '26'),
(1539, 30, 1336, 144, '4', '27'),
(1540, 30, 1408, 144, '4', '28'),
(1541, 30, 1444, 144, '4', '29'),
(1542, 30, 1480, 144, '4', '30'),
(1543, 30, 1516, 144, '4', '31'),
(1544, 30, 1552, 144, '4', '32'),
(1545, 30, 1588, 144, '4', '33'),
(1546, 30, 1624, 144, '4', '34'),
(1547, 30, 1660, 144, '4', '35'),
(1548, 30, 1696, 144, '4', '36'),
(1549, 30, 1732, 144, '4', '37'),
(1550, 30, 1768, 144, '4', '38'),
(1551, 30, 328, 180, '5', '1'),
(1552, 30, 364, 180, '5', '2'),
(1553, 30, 400, 180, '5', '3'),
(1554, 30, 436, 180, '5', '4'),
(1555, 30, 472, 180, '5', '5'),
(1556, 30, 508, 180, '5', '6'),
(1557, 30, 544, 180, '5', '7'),
(1558, 30, 580, 180, '5', '8'),
(1559, 30, 616, 180, '5', '9'),
(1560, 30, 652, 180, '5', '10'),
(1561, 30, 688, 180, '5', '11'),
(1562, 30, 760, 180, '5', '12'),
(1563, 30, 796, 180, '5', '13'),
(1564, 30, 832, 180, '5', '14'),
(1565, 30, 868, 180, '5', '15'),
(1566, 30, 904, 180, '5', '16'),
(1567, 30, 940, 180, '5', '17'),
(1568, 30, 976, 180, '5', '18'),
(1569, 30, 1012, 180, '5', '19'),
(1570, 30, 1048, 180, '5', '20'),
(1571, 30, 1084, 180, '5', '21'),
(1572, 30, 1120, 180, '5', '22'),
(1573, 30, 1156, 180, '5', '23'),
(1574, 30, 1192, 180, '5', '24'),
(1575, 30, 1228, 180, '5', '25'),
(1576, 30, 1264, 180, '5', '26'),
(1577, 30, 1300, 180, '5', '27'),
(1578, 30, 1336, 180, '5', '28'),
(1579, 30, 1372, 180, '5', '29'),
(1580, 30, 1444, 180, '5', '30'),
(1581, 30, 1480, 180, '5', '31'),
(1582, 30, 1516, 180, '5', '32'),
(1583, 30, 1552, 180, '5', '33'),
(1584, 30, 1588, 180, '5', '34'),
(1585, 30, 1624, 180, '5', '35'),
(1586, 30, 1660, 180, '5', '36'),
(1587, 30, 1696, 180, '5', '37'),
(1588, 30, 1732, 180, '5', '38'),
(1589, 30, 1768, 180, '5', '39'),
(1590, 30, 1804, 180, '5', '40'),
(1591, 30, 256, 216, '6', '1'),
(1592, 30, 292, 216, '6', '2'),
(1593, 30, 328, 216, '6', '3'),
(1594, 30, 364, 216, '6', '4'),
(1595, 30, 400, 216, '6', '5'),
(1596, 30, 436, 216, '6', '6'),
(1597, 30, 472, 216, '6', '7'),
(1598, 30, 508, 216, '6', '8'),
(1599, 30, 544, 216, '6', '9'),
(1600, 30, 580, 216, '6', '10'),
(1601, 30, 616, 216, '6', '11'),
(1602, 30, 652, 216, '6', '12'),
(1603, 30, 724, 216, '6', '13'),
(1604, 30, 760, 216, '6', '14'),
(1605, 30, 796, 216, '6', '15'),
(1606, 30, 832, 216, '6', '16'),
(1607, 30, 868, 216, '6', '17'),
(1608, 30, 904, 216, '6', '18'),
(1609, 30, 940, 216, '6', '19'),
(1610, 30, 976, 216, '6', '20'),
(1611, 30, 1012, 216, '6', '21'),
(1612, 30, 1048, 216, '6', '22'),
(1613, 30, 1084, 216, '6', '23'),
(1614, 30, 1120, 216, '6', '24'),
(1615, 30, 1156, 216, '6', '25'),
(1616, 30, 1192, 216, '6', '26'),
(1617, 30, 1228, 216, '6', '27'),
(1618, 30, 1264, 216, '6', '28'),
(1619, 30, 1300, 216, '6', '29'),
(1620, 30, 1336, 216, '6', '30'),
(1621, 30, 1372, 216, '6', '31'),
(1622, 30, 1444, 216, '6', '32'),
(1623, 30, 1480, 216, '6', '33'),
(1624, 30, 1516, 216, '6', '34'),
(1625, 30, 1552, 216, '6', '35'),
(1626, 30, 1588, 216, '6', '36'),
(1627, 30, 1624, 216, '6', '37'),
(1628, 30, 1660, 216, '6', '38'),
(1629, 30, 1696, 216, '6', '39'),
(1630, 30, 1732, 216, '6', '40'),
(1631, 30, 1768, 216, '6', '41'),
(1632, 30, 1804, 216, '6', '42'),
(1633, 30, 1840, 216, '6', '43'),
(1634, 30, 220, 252, '7', '1'),
(1635, 30, 256, 252, '7', '2'),
(1636, 30, 292, 252, '7', '3'),
(1637, 30, 328, 252, '7', '4'),
(1638, 30, 364, 252, '7', '5'),
(1639, 30, 400, 252, '7', '6'),
(1640, 30, 436, 252, '7', '7'),
(1641, 30, 472, 252, '7', '8'),
(1642, 30, 508, 252, '7', '9'),
(1643, 30, 544, 252, '7', '10'),
(1644, 30, 580, 252, '7', '11'),
(1645, 30, 616, 252, '7', '12'),
(1646, 30, 688, 252, '7', '13'),
(1647, 30, 724, 252, '7', '14'),
(1648, 30, 760, 252, '7', '15'),
(1649, 30, 796, 252, '7', '16'),
(1650, 30, 832, 252, '7', '17'),
(1651, 30, 868, 252, '7', '18'),
(1652, 30, 904, 252, '7', '19'),
(1653, 30, 940, 252, '7', '20'),
(1654, 30, 976, 252, '7', '21'),
(1655, 30, 1012, 252, '7', '22'),
(1656, 30, 1048, 252, '7', '23'),
(1657, 30, 1084, 252, '7', '24'),
(1658, 30, 1120, 252, '7', '25'),
(1659, 30, 1156, 252, '7', '26'),
(1660, 30, 1192, 252, '7', '27'),
(1661, 30, 1228, 252, '7', '28'),
(1662, 30, 1264, 252, '7', '29'),
(1663, 30, 1300, 252, '7', '30'),
(1664, 30, 1336, 252, '7', '31'),
(1665, 30, 1372, 252, '7', '32'),
(1666, 30, 1408, 252, '7', '33'),
(1667, 30, 1480, 252, '7', '34'),
(1668, 30, 1516, 252, '7', '35'),
(1669, 30, 1552, 252, '7', '36'),
(1670, 30, 1588, 252, '7', '37'),
(1671, 30, 1624, 252, '7', '38'),
(1672, 30, 1660, 252, '7', '39'),
(1673, 30, 1696, 252, '7', '40'),
(1674, 30, 1732, 252, '7', '41'),
(1675, 30, 1768, 252, '7', '42'),
(1676, 30, 1804, 252, '7', '43'),
(1677, 30, 1840, 252, '7', '44'),
(1678, 30, 1876, 252, '7', '45'),
(1679, 30, 184, 288, '8', '1'),
(1680, 30, 220, 288, '8', '2'),
(1681, 30, 256, 288, '8', '3'),
(1682, 30, 292, 288, '8', '4'),
(1683, 30, 328, 288, '8', '5'),
(1684, 30, 364, 288, '8', '6'),
(1685, 30, 400, 288, '8', '7'),
(1686, 30, 436, 288, '8', '8'),
(1687, 30, 472, 288, '8', '9'),
(1688, 30, 508, 288, '8', '10'),
(1689, 30, 544, 288, '8', '11'),
(1690, 30, 580, 288, '8', '12'),
(1691, 30, 652, 288, '8', '13'),
(1692, 30, 688, 288, '8', '14'),
(1693, 30, 724, 288, '8', '15'),
(1694, 30, 760, 288, '8', '16'),
(1695, 30, 796, 288, '8', '17'),
(1696, 30, 832, 288, '8', '18'),
(1697, 30, 868, 288, '8', '19'),
(1698, 30, 904, 288, '8', '20'),
(1699, 30, 940, 288, '8', '21'),
(1700, 30, 976, 288, '8', '22'),
(1701, 30, 1012, 288, '8', '23'),
(1702, 30, 1048, 288, '8', '24'),
(1703, 30, 1084, 288, '8', '25'),
(1704, 30, 1120, 288, '8', '26'),
(1705, 30, 1156, 288, '8', '27'),
(1706, 30, 1192, 288, '8', '28'),
(1707, 30, 1228, 288, '8', '29'),
(1708, 30, 1264, 288, '8', '30'),
(1709, 30, 1300, 288, '8', '31'),
(1710, 30, 1336, 288, '8', '32'),
(1711, 30, 1372, 288, '8', '33'),
(1712, 30, 1408, 288, '8', '34'),
(1713, 30, 1480, 288, '8', '35'),
(1714, 30, 1516, 288, '8', '36'),
(1715, 30, 1552, 288, '8', '37'),
(1716, 30, 1588, 288, '8', '38'),
(1717, 30, 1624, 288, '8', '39'),
(1718, 30, 1660, 288, '8', '40'),
(1719, 30, 1696, 288, '8', '41'),
(1720, 30, 1732, 288, '8', '42'),
(1721, 30, 1768, 288, '8', '43'),
(1722, 30, 1804, 288, '8', '44'),
(1723, 30, 1840, 288, '8', '45'),
(1724, 30, 1876, 288, '8', '46'),
(1725, 30, 148, 324, '9', '1'),
(1726, 30, 184, 324, '9', '2'),
(1727, 30, 220, 324, '9', '3'),
(1728, 30, 256, 324, '9', '4'),
(1729, 30, 292, 324, '9', '5'),
(1730, 30, 328, 324, '9', '6'),
(1731, 30, 364, 324, '9', '7'),
(1732, 30, 400, 324, '9', '8'),
(1733, 30, 436, 324, '9', '9'),
(1734, 30, 472, 324, '9', '10'),
(1735, 30, 508, 324, '9', '11'),
(1736, 30, 544, 324, '9', '12'),
(1737, 30, 616, 324, '9', '13'),
(1738, 30, 652, 324, '9', '14'),
(1739, 30, 688, 324, '9', '15'),
(1740, 30, 724, 324, '9', '16'),
(1741, 30, 760, 324, '9', '17'),
(1742, 30, 796, 324, '9', '18'),
(1743, 30, 832, 324, '9', '19'),
(1744, 30, 868, 324, '9', '20'),
(1745, 30, 904, 324, '9', '21'),
(1746, 30, 940, 324, '9', '22'),
(1747, 30, 976, 324, '9', '23'),
(1748, 30, 1012, 324, '9', '24'),
(1749, 30, 1048, 324, '9', '25'),
(1750, 30, 1084, 324, '9', '26'),
(1751, 30, 1120, 324, '9', '27'),
(1752, 30, 1156, 324, '9', '28'),
(1753, 30, 1192, 324, '9', '29'),
(1754, 30, 1228, 324, '9', '30'),
(1755, 30, 1264, 324, '9', '31'),
(1756, 30, 1300, 324, '9', '32'),
(1757, 30, 1336, 324, '9', '33'),
(1758, 30, 1372, 324, '9', '34'),
(1759, 30, 1408, 324, '9', '35'),
(1760, 30, 1444, 324, '9', '36'),
(1761, 30, 1516, 324, '9', '37'),
(1762, 30, 1552, 324, '9', '38'),
(1763, 30, 1588, 324, '9', '39'),
(1764, 30, 1624, 324, '9', '40'),
(1765, 30, 1660, 324, '9', '41'),
(1766, 30, 1696, 324, '9', '42'),
(1767, 30, 1732, 324, '9', '43'),
(1768, 30, 1768, 324, '9', '44'),
(1769, 30, 1804, 324, '9', '45'),
(1770, 30, 1840, 324, '9', '46'),
(1771, 30, 1876, 324, '9', '47'),
(1772, 30, 1912, 324, '9', '48'),
(1773, 30, 112, 360, '10', '1'),
(1774, 30, 148, 360, '10', '2'),
(1775, 30, 184, 360, '10', '3'),
(1776, 30, 220, 360, '10', '4'),
(1777, 30, 256, 360, '10', '5'),
(1778, 30, 292, 360, '10', '6'),
(1779, 30, 328, 360, '10', '7'),
(1780, 30, 364, 360, '10', '8'),
(1781, 30, 400, 360, '10', '9'),
(1782, 30, 436, 360, '10', '10'),
(1783, 30, 472, 360, '10', '11'),
(1784, 30, 508, 360, '10', '12'),
(1785, 30, 580, 360, '10', '13'),
(1786, 30, 616, 360, '10', '14'),
(1787, 30, 652, 360, '10', '15'),
(1788, 30, 688, 360, '10', '16'),
(1789, 30, 724, 360, '10', '17'),
(1790, 30, 760, 360, '10', '18'),
(1791, 30, 796, 360, '10', '19'),
(1792, 30, 832, 360, '10', '20'),
(1793, 30, 868, 360, '10', '21'),
(1794, 30, 904, 360, '10', '22'),
(1795, 30, 940, 360, '10', '23'),
(1796, 30, 976, 360, '10', '24'),
(1797, 30, 1012, 360, '10', '25'),
(1798, 30, 1048, 360, '10', '26'),
(1799, 30, 1084, 360, '10', '27'),
(1800, 30, 1120, 360, '10', '28'),
(1801, 30, 1156, 360, '10', '29'),
(1802, 30, 1192, 360, '10', '30'),
(1803, 30, 1228, 360, '10', '31'),
(1804, 30, 1264, 360, '10', '32'),
(1805, 30, 1300, 360, '10', '33'),
(1806, 30, 1336, 360, '10', '34'),
(1807, 30, 1372, 360, '10', '35'),
(1808, 30, 1408, 360, '10', '36'),
(1809, 30, 1444, 360, '10', '37'),
(1810, 30, 1516, 360, '10', '38'),
(1811, 30, 1552, 360, '10', '39'),
(1812, 30, 1588, 360, '10', '40'),
(1813, 30, 1624, 360, '10', '41'),
(1814, 30, 1660, 360, '10', '42'),
(1815, 30, 1696, 360, '10', '43'),
(1816, 30, 1732, 360, '10', '44'),
(1817, 30, 1768, 360, '10', '45'),
(1818, 30, 1804, 360, '10', '46'),
(1819, 30, 1840, 360, '10', '47'),
(1820, 30, 1876, 360, '10', '48'),
(1821, 30, 1912, 360, '10', '49'),
(1822, 30, 76, 396, '11', '1'),
(1823, 30, 112, 396, '11', '2'),
(1824, 30, 148, 396, '11', '3'),
(1825, 30, 184, 396, '11', '4'),
(1826, 30, 220, 396, '11', '5'),
(1827, 30, 256, 396, '11', '6'),
(1828, 30, 292, 396, '11', '7'),
(1829, 30, 328, 396, '11', '8'),
(1830, 30, 364, 396, '11', '9'),
(1831, 30, 400, 396, '11', '10'),
(1832, 30, 436, 396, '11', '11'),
(1833, 30, 472, 396, '11', '12'),
(1834, 30, 544, 396, '11', '13'),
(1835, 30, 580, 396, '11', '14'),
(1836, 30, 616, 396, '11', '15'),
(1837, 30, 652, 396, '11', '16'),
(1838, 30, 688, 396, '11', '17'),
(1839, 30, 724, 396, '11', '18'),
(1840, 30, 760, 396, '11', '19'),
(1841, 30, 796, 396, '11', '20'),
(1842, 30, 832, 396, '11', '21'),
(1843, 30, 868, 396, '11', '22'),
(1844, 30, 904, 396, '11', '23'),
(1845, 30, 940, 396, '11', '24'),
(1846, 30, 976, 396, '11', '25'),
(1847, 30, 1012, 396, '11', '26'),
(1848, 30, 1048, 396, '11', '27'),
(1849, 30, 1084, 396, '11', '28'),
(1850, 30, 1120, 396, '11', '29'),
(1851, 30, 1156, 396, '11', '30'),
(1852, 30, 1192, 396, '11', '31'),
(1853, 30, 1228, 396, '11', '32'),
(1854, 30, 1264, 396, '11', '33'),
(1855, 30, 1300, 396, '11', '34'),
(1856, 30, 1336, 396, '11', '35'),
(1857, 30, 1372, 396, '11', '36'),
(1858, 30, 1408, 396, '11', '37'),
(1859, 30, 1444, 396, '11', '38'),
(1860, 30, 1480, 396, '11', '39'),
(1861, 30, 1552, 396, '11', '40'),
(1862, 30, 1588, 396, '11', '41'),
(1863, 30, 1624, 396, '11', '42'),
(1864, 30, 1660, 396, '11', '43'),
(1865, 30, 1696, 396, '11', '44'),
(1866, 30, 1732, 396, '11', '45'),
(1867, 30, 1768, 396, '11', '46'),
(1868, 30, 1804, 396, '11', '47'),
(1869, 30, 1840, 396, '11', '48'),
(1870, 30, 1876, 396, '11', '49'),
(1871, 30, 1912, 396, '11', '50'),
(1872, 30, 1948, 396, '11', '51'),
(1873, 33, 76, 36, '1', '1'),
(1874, 33, 112, 36, '1', '2'),
(1875, 33, 148, 36, '1', '3'),
(1876, 33, 184, 36, '1', '4'),
(1877, 33, 220, 36, '1', '5'),
(1878, 33, 256, 36, '1', '6'),
(1879, 33, 292, 36, '1', '7'),
(1880, 33, 328, 36, '1', '8'),
(1881, 33, 364, 36, '1', '9'),
(1882, 33, 400, 36, '1', '10'),
(1883, 33, 436, 36, '1', '11'),
(1884, 33, 472, 36, '1', '12'),
(1885, 33, 508, 36, '1', '13'),
(1886, 33, 544, 36, '1', '14'),
(1887, 33, 76, 72, '2', '1'),
(1888, 33, 112, 72, '2', '2'),
(1889, 33, 148, 72, '2', '3'),
(1890, 33, 184, 72, '2', '4'),
(1891, 33, 220, 72, '2', '5'),
(1892, 33, 256, 72, '2', '6'),
(1893, 33, 292, 72, '2', '7'),
(1894, 33, 328, 72, '2', '8'),
(1895, 33, 364, 72, '2', '9'),
(1896, 33, 400, 72, '2', '10'),
(1897, 33, 436, 72, '2', '11'),
(1898, 33, 472, 72, '2', '12'),
(1899, 33, 508, 72, '2', '13'),
(1900, 33, 544, 72, '2', '14'),
(1901, 33, 76, 108, '3', '1'),
(1902, 33, 112, 108, '3', '2'),
(1903, 33, 148, 108, '3', '3'),
(1904, 33, 184, 108, '3', '4'),
(1905, 33, 220, 108, '3', '5'),
(1906, 33, 256, 108, '3', '6'),
(1907, 33, 292, 108, '3', '7'),
(1908, 33, 328, 108, '3', '8'),
(1909, 33, 364, 108, '3', '9'),
(1910, 33, 400, 108, '3', '10'),
(1911, 33, 436, 108, '3', '11'),
(1912, 33, 472, 108, '3', '12'),
(1913, 33, 508, 108, '3', '13'),
(1914, 33, 544, 108, '3', '14'),
(1915, 33, 76, 144, '4', '1'),
(1916, 33, 112, 144, '4', '2'),
(1917, 33, 148, 144, '4', '3'),
(1918, 33, 184, 144, '4', '4'),
(1919, 33, 220, 144, '4', '5'),
(1920, 33, 256, 144, '4', '6'),
(1921, 33, 292, 144, '4', '7'),
(1922, 33, 328, 144, '4', '8'),
(1923, 33, 364, 144, '4', '9'),
(1924, 33, 400, 144, '4', '10'),
(1925, 33, 436, 144, '4', '11'),
(1926, 33, 472, 144, '4', '12'),
(1927, 33, 508, 144, '4', '13'),
(1928, 33, 544, 144, '4', '14'),
(1929, 33, 76, 180, '5', '1'),
(1930, 33, 112, 180, '5', '2'),
(1931, 33, 148, 180, '5', '3'),
(1932, 33, 184, 180, '5', '4'),
(1933, 33, 220, 180, '5', '5'),
(1934, 33, 256, 180, '5', '6'),
(1935, 33, 292, 180, '5', '7'),
(1936, 33, 328, 180, '5', '8'),
(1937, 33, 364, 180, '5', '9'),
(1938, 33, 400, 180, '5', '10'),
(1939, 33, 436, 180, '5', '11'),
(1940, 33, 472, 180, '5', '12'),
(1941, 33, 508, 180, '5', '13'),
(1942, 33, 544, 180, '5', '14'),
(1943, 33, 76, 216, '6', '1'),
(1944, 33, 112, 216, '6', '2'),
(1945, 33, 148, 216, '6', '3'),
(1946, 33, 184, 216, '6', '4'),
(1947, 33, 220, 216, '6', '5'),
(1948, 33, 256, 216, '6', '6'),
(1949, 33, 292, 216, '6', '7'),
(1950, 33, 328, 216, '6', '8'),
(1951, 33, 364, 216, '6', '9'),
(1952, 33, 400, 216, '6', '10'),
(1953, 33, 436, 216, '6', '11'),
(1954, 33, 472, 216, '6', '12'),
(1955, 33, 508, 216, '6', '13'),
(1956, 33, 544, 216, '6', '14'),
(1957, 33, 76, 252, '7', '1'),
(1958, 33, 112, 252, '7', '2'),
(1959, 33, 148, 252, '7', '3'),
(1960, 33, 184, 252, '7', '4'),
(1961, 33, 220, 252, '7', '5'),
(1962, 33, 256, 252, '7', '6'),
(1963, 33, 292, 252, '7', '7'),
(1964, 33, 328, 252, '7', '8'),
(1965, 33, 364, 252, '7', '9'),
(1966, 33, 400, 252, '7', '10'),
(1967, 33, 436, 252, '7', '11'),
(1968, 33, 472, 252, '7', '12'),
(1969, 33, 508, 252, '7', '13'),
(1970, 33, 544, 252, '7', '14'),
(1971, 35, 76, 36, '1', '1'),
(1972, 35, 112, 36, '1', '2'),
(1973, 35, 148, 36, '1', '3'),
(1974, 35, 184, 36, '1', '4'),
(1975, 35, 220, 36, '1', '5'),
(1976, 35, 256, 36, '1', '6'),
(1977, 35, 292, 36, '1', '7'),
(1978, 35, 328, 36, '1', '8'),
(1979, 35, 364, 36, '1', '9'),
(1980, 35, 400, 36, '1', '10'),
(1981, 35, 436, 36, '1', '11'),
(1982, 35, 472, 36, '1', '12'),
(1983, 35, 508, 36, '1', '13'),
(1984, 35, 544, 36, '1', '14'),
(1985, 35, 76, 72, '2', '1'),
(1986, 35, 112, 72, '2', '2'),
(1987, 35, 148, 72, '2', '3'),
(1988, 35, 184, 72, '2', '4'),
(1989, 35, 220, 72, '2', '5'),
(1990, 35, 256, 72, '2', '6'),
(1991, 35, 292, 72, '2', '7'),
(1992, 35, 328, 72, '2', '8'),
(1993, 35, 364, 72, '2', '9'),
(1994, 35, 400, 72, '2', '10'),
(1995, 35, 436, 72, '2', '11'),
(1996, 35, 472, 72, '2', '12'),
(1997, 35, 508, 72, '2', '13'),
(1998, 35, 544, 72, '2', '14'),
(1999, 35, 76, 108, '3', '1'),
(2000, 35, 112, 108, '3', '2'),
(2001, 35, 148, 108, '3', '3'),
(2002, 35, 184, 108, '3', '4'),
(2003, 35, 220, 108, '3', '5'),
(2004, 35, 256, 108, '3', '6'),
(2005, 35, 292, 108, '3', '7'),
(2006, 35, 328, 108, '3', '8'),
(2007, 35, 364, 108, '3', '9'),
(2008, 35, 400, 108, '3', '10');
INSERT INTO `seats` (`id`, `section_id`, `x`, `y`, `row`, `seat`) VALUES
(2009, 35, 436, 108, '3', '11'),
(2010, 35, 472, 108, '3', '12'),
(2011, 35, 508, 108, '3', '13'),
(2012, 35, 544, 108, '3', '14'),
(2013, 35, 76, 144, '4', '1'),
(2014, 35, 112, 144, '4', '2'),
(2015, 35, 148, 144, '4', '3'),
(2016, 35, 184, 144, '4', '4'),
(2017, 35, 220, 144, '4', '5'),
(2018, 35, 256, 144, '4', '6'),
(2019, 35, 292, 144, '4', '7'),
(2020, 35, 328, 144, '4', '8'),
(2021, 35, 364, 144, '4', '9'),
(2022, 35, 400, 144, '4', '10'),
(2023, 35, 436, 144, '4', '11'),
(2024, 35, 472, 144, '4', '12'),
(2025, 35, 508, 144, '4', '13'),
(2026, 35, 544, 144, '4', '14'),
(2027, 36, 76, 36, '1', '1'),
(2028, 36, 112, 36, '1', '2'),
(2029, 36, 148, 36, '1', '3'),
(2030, 36, 184, 36, '1', '4'),
(2031, 36, 220, 36, '1', '5'),
(2032, 36, 256, 36, '1', '6'),
(2033, 36, 292, 36, '1', '7'),
(2034, 36, 328, 36, '1', '8'),
(2035, 36, 364, 36, '1', '9'),
(2036, 36, 400, 36, '1', '10'),
(2037, 36, 436, 36, '1', '11'),
(2038, 36, 472, 36, '1', '12'),
(2039, 36, 508, 36, '1', '13'),
(2040, 36, 544, 36, '1', '14'),
(2041, 36, 76, 72, '2', '1'),
(2042, 36, 112, 72, '2', '2'),
(2043, 36, 148, 72, '2', '3'),
(2044, 36, 184, 72, '2', '4'),
(2045, 36, 220, 72, '2', '5'),
(2046, 36, 256, 72, '2', '6'),
(2047, 36, 292, 72, '2', '7'),
(2048, 36, 328, 72, '2', '8'),
(2049, 36, 364, 72, '2', '9'),
(2050, 36, 400, 72, '2', '10'),
(2051, 36, 436, 72, '2', '11'),
(2052, 36, 472, 72, '2', '12'),
(2053, 36, 508, 72, '2', '13'),
(2054, 36, 544, 72, '2', '14'),
(2055, 36, 76, 108, '3', '1'),
(2056, 36, 112, 108, '3', '2'),
(2057, 36, 148, 108, '3', '3'),
(2058, 36, 184, 108, '3', '4'),
(2059, 36, 220, 108, '3', '5'),
(2060, 36, 256, 108, '3', '6'),
(2061, 36, 292, 108, '3', '7'),
(2062, 36, 328, 108, '3', '8'),
(2063, 36, 364, 108, '3', '9'),
(2064, 36, 400, 108, '3', '10'),
(2065, 36, 436, 108, '3', '11'),
(2066, 36, 472, 108, '3', '12'),
(2067, 36, 508, 108, '3', '13'),
(2068, 36, 544, 108, '3', '14'),
(2069, 36, 76, 144, '4', '1'),
(2070, 36, 112, 144, '4', '2'),
(2071, 36, 148, 144, '4', '3'),
(2072, 36, 184, 144, '4', '4'),
(2073, 36, 220, 144, '4', '5'),
(2074, 36, 256, 144, '4', '6'),
(2075, 36, 292, 144, '4', '7'),
(2076, 36, 328, 144, '4', '8'),
(2077, 36, 364, 144, '4', '9'),
(2078, 36, 400, 144, '4', '10'),
(2079, 36, 436, 144, '4', '11'),
(2080, 36, 472, 144, '4', '12'),
(2081, 36, 508, 144, '4', '13'),
(2082, 36, 544, 144, '4', '14');

-- --------------------------------------------------------

--
-- Table structure for table `sections`
--

CREATE TABLE `sections` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` json DEFAULT NULL,
  `for_sale` tinyint(1) NOT NULL DEFAULT '1',
  `venue_scheme_id` bigint(20) UNSIGNED DEFAULT NULL,
  `svg` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sections`
--

INSERT INTO `sections` (`id`, `title`, `for_sale`, `venue_scheme_id`, `svg`, `created_at`, `updated_at`) VALUES
(1, '{\"kz\": \"Сектор 1\", \"ru\": \"Сектор 1\"}', 1, 1, NULL, '2020-11-26 09:39:25', '2020-12-10 11:58:09'),
(4, '{\"kz\": \"Сектор 2\", \"ru\": \"Сектор 2\"}', 1, 1, NULL, '2020-11-26 11:54:35', '2020-12-10 11:58:09'),
(9, '{\"kz\": \"1\", \"ru\": \"VIP\"}', 1, 2, '{\"text\": [\"0\", \"158\"], \"color\": \"#25a76b\", \"points\": [[\"-60\", \"100\"], [100, 0], [0, 100], [-100, 0], [50, 50]]}', '2020-11-26 14:04:45', '2020-12-07 15:33:31'),
(10, '{\"kz\": \"1\", \"ru\": \"1\"}', 1, 2, '{\"text\": [\"128\", \"460\"], \"color\": \"#25a76b\", \"points\": [[\"20\", \"400\"], [\"300\", \"20\"], [0, 100], [\"-200\", 0]]}', '2020-11-26 14:10:56', '2020-12-07 15:33:31'),
(21, '{\"kz\": \"1\", \"ru\": \"Фан зона\"}', 1, 2, '{\"text\": [\"500\", \"200\"], \"color\": \"#f4500d\", \"points\": [[\"400\", \"100\"], [\"200\", 0], [0, \"200\"], [\"-200\", 0]]}', '2020-11-27 12:05:18', '2020-12-07 15:33:31'),
(25, '{\"kz\": \"1\", \"ru\": \"Партер\"}', 1, 3, '{\"text\": [\"300\", \"30\"], \"color\": \"#25a76b\", \"points\": [[\"100\", \"40\"], [\"400\", 0], [\"50\", \"170\"], [\"-225\", \"0\"], [\"0\", \"-170\"], [\"-50\", \"0\"], [\"0\", \"170\"], [\"-225\", \"0\"]]}', '2020-12-08 17:51:29', '2020-12-09 18:26:55'),
(26, '{\"kz\": \"1\", \"ru\": \"Амфитеатр\"}', 1, 3, '{\"text\": [\"300\", \"240\"], \"color\": \"#25a76b\", \"points\": [[\"0\", \"250\"], [\"600\", 0], [\"-70\", \"150\"], [\"-50\", 0], [\"0\", \"-150\"], [\"-80\", \"0\"], [50, \"150\"], [\"-110\", \"0\"], [\"0\", \"-40\"], [\"-80\", \"0\"], [\"0\", \"40\"], [\"-120\", \"0\"], [50, \"-150\"], [\"-70\", \"0\"], [\"0\", \"150\"], [\"-50\", \"0\"]]}', '2020-12-09 14:24:47', '2020-12-09 18:26:55'),
(27, '{\"kz\": \"1\", \"ru\": \"Балкон\"}', 1, 3, '{\"text\": [\"300\", \"430\"], \"color\": \"#25a76b\", \"points\": [[\"140\", \"440\"], [\"310\", 0], [0, \"100\"], [\"-310\", 0]]}', '2020-12-09 14:39:50', '2020-12-09 18:26:55'),
(28, '{\"kz\": \"1\", \"ru\": \"Камерная сцена\"}', 1, 5, '{\"text\": [\"300\", \"80\"], \"color\": \"#ED1566\", \"points\": [[\"200\", \"100\"], [\"200\", 0], [0, \"300\"], [\"-200\", 0]]}', '2020-12-09 14:46:03', '2020-12-09 14:46:03'),
(29, '{\"kz\": \"1\", \"ru\": \"Партер\"}', 1, 1, '{\"text\": [\"300\", \"190\"], \"color\": \"#25a76b\", \"points\": [[\"150\", \"110\"], [\"300\", 0], [0, \"150\"], [\"-300\", 0]]}', '2020-12-10 10:50:55', '2020-12-10 11:58:09'),
(30, '{\"kz\": \"1\", \"ru\": \"Амфитеатр\"}', 1, 1, '{\"text\": [\"300\", \"360\"], \"color\": \"#25a76b\", \"points\": [[\"100\", \"290\"], [\"420\", 0], [\"80\", \"130\"], [\"-130\", 0], [\"-80\", \"-130\"], [\"-50\", \"0\"], [\"80\", \"130\"], [\"-240\", \"0\"], [\"80\", \"-130\"], [\"-50\", \"0\"], [\"-80\", \"130\"], [\"-130\", \"0\"]]}', '2020-12-10 10:51:28', '2020-12-10 11:58:09'),
(31, '{\"kz\": \"1\", \"ru\": \"Сцена\"}', 0, 1, '{\"text\": [\"300\", \"54\"], \"color\": \"#b7b7b7\", \"points\": [[\"150\", \"20\"], [\"300\", 0], [0, \"60\"], [\"-300\", 0]]}', '2020-12-10 11:01:41', '2020-12-10 11:58:09'),
(32, '{\"kz\": \"1\", \"ru\": \"Сцена\"}', 0, 6, '{\"text\": [\"300\", \"240\"], \"color\": \"#b7b7b7\", \"points\": [[\"225\", \"160\"], [\"150\", 0], [0, \"150\"], [\"-150\", 0]]}', '2020-12-10 11:32:35', '2020-12-10 11:57:59'),
(33, '{\"kz\": \"1\", \"ru\": \"Малый зал сектор А\"}', 1, 6, '{\"text\": [\"300\", \"385\"], \"color\": \"#25a76b\", \"points\": [[\"175\", \"350\"], [\"250\", 0], [0, \"60\"], [\"-250\", 0]]}', '2020-12-10 11:33:49', '2020-12-10 11:58:00'),
(34, '{\"kz\": \"1\", \"ru\": \"Малый зал сектор D\"}', 1, 6, '{\"text\": [\"300\", \"104\"], \"color\": \"#25a76b\", \"points\": [[\"175\", \"70\"], [\"250\", 0], [0, \"60\"], [\"-250\", 0]]}', '2020-12-10 11:38:05', '2020-12-10 11:58:00'),
(35, '{\"kz\": \"1\", \"ru\": \"Малый зал сектор B\"}', 1, 6, '{\"text\": [\"368\", \"112\", \"-90\"], \"color\": \"#25a76b\", \"points\": [[\"80\", \"110\"], [\"60\", 0], [0, \"250\"], [\"-60\", 0]]}', '2020-12-10 11:39:09', '2020-12-10 11:58:00'),
(36, '{\"kz\": \"1\", \"ru\": \"Малый зал сектор C\"}', 1, 6, '{\"text\": [\"239\", \"113\", \"90\"], \"color\": \"#25a76b\", \"points\": [[\"460\", \"110\"], [\"60\", 0], [0, \"250\"], [\"-60\", 0]]}', '2020-12-10 11:39:46', '2020-12-10 11:58:00');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('04VFKDb9Z7sKG3XDXLIN7OAld8InrfwMw6Dow9Vd', 1, '172.20.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 11_0_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiUTU4dVlxT3JCcmpxUnJqWndKSW9iZHlOSUthbDQyVm1JczZZOFlPUyI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJuZXciO2E6MDp7fXM6Mzoib2xkIjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjM6Imh0dHA6Ly9zdGFnZXMubG9jL2FkbWluIjt9czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTt9', 1607597032),
('NbTWhYJPlXUYaUE65TdReeqrUfJzzuzleQsWcXZv', NULL, '172.20.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 11_0_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiek56b0MzSmtBaXNpT1JJbUoyRmpleTVHQzk0SVEzNHpuR1BhMWlLayI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHA6Ly9zYXRzLmxvYy93aWRnZXQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1607595637),
('tN8c3eT1FbMz7xlibAqTQ8w9wYRubIcCtgVzPpb4', 1, '172.20.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 11_0_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiYlV0SDU5MVRaelRuWnNUaXZSVFlMTzFraklYM3NsbDlmSm9tSXFhbyI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjI6Imh0dHA6Ly9zYXRzLmxvYy93aWRnZXQiO31zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO30=', 1607614809);

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `body` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `code`, `description`, `body`, `created_at`, `updated_at`) VALUES
(1, 'phone', 'Телефон', '{\"kz\": \"adf\", \"ru\": \"+7701123123\"}', '2020-12-02 09:48:27', '2020-12-02 09:48:27'),
(2, 'email', 'asdf', '{\"kz\": \"help@satstheatre.org.kz\", \"ru\": \"help@satstheatre.org.kz\"}', '2020-12-02 21:45:54', '2020-12-02 21:47:30');

-- --------------------------------------------------------

--
-- Table structure for table `spacemedia`
--

CREATE TABLE `spacemedia` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL,
  `collection_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mime_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `folder` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sort_order` int(11) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `spacemedia`
--

INSERT INTO `spacemedia` (`id`, `model_type`, `model_id`, `collection_name`, `file_name`, `mime_type`, `folder`, `sort_order`, `created_at`, `updated_at`) VALUES
(2, 'App\\Models\\Specific\\Event', 1, 'default', '1.jpg', 'image/jpeg', 'events', 1, '2020-11-26 11:13:07', '2020-11-26 11:13:07');

-- --------------------------------------------------------

--
-- Table structure for table `tickets`
--

CREATE TABLE `tickets` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `api_id` bigint(20) UNSIGNED DEFAULT NULL,
  `pricegroup_id` bigint(20) UNSIGNED DEFAULT NULL,
  `timetable_id` bigint(20) UNSIGNED NOT NULL,
  `section_id` bigint(20) UNSIGNED DEFAULT NULL,
  `row` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `seat` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `seat_id` bigint(20) UNSIGNED DEFAULT NULL,
  `price` mediumint(8) UNSIGNED NOT NULL DEFAULT '0',
  `blocked` tinyint(1) NOT NULL DEFAULT '0',
  `sold` tinyint(1) NOT NULL DEFAULT '0',
  `barcode` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tickets`
--

INSERT INTO `tickets` (`id`, `api_id`, `pricegroup_id`, `timetable_id`, `section_id`, `row`, `seat`, `seat_id`, `price`, `blocked`, `sold`, `barcode`, `created_at`, `updated_at`) VALUES
(90, NULL, NULL, 1, 21, NULL, NULL, NULL, 400, 1, 0, NULL, '2020-11-27 15:59:19', '2020-12-08 17:25:20'),
(91, NULL, NULL, 1, 21, NULL, NULL, NULL, 400, 1, 0, NULL, '2020-11-27 15:59:19', '2020-12-08 17:25:20'),
(92, NULL, NULL, 1, 21, NULL, NULL, NULL, 400, 1, 1, NULL, '2020-11-27 15:59:19', '2020-12-08 17:27:51'),
(93, NULL, NULL, 1, 21, NULL, NULL, NULL, 400, 1, 1, NULL, '2020-11-27 15:59:19', '2020-12-08 17:27:51'),
(94, NULL, NULL, 1, 21, NULL, NULL, NULL, 400, 1, 1, NULL, '2020-11-27 15:59:19', '2020-12-08 17:29:30'),
(95, NULL, NULL, 1, 21, NULL, NULL, NULL, 400, 0, 0, NULL, '2020-11-27 15:59:19', '2020-12-07 16:48:50'),
(96, NULL, NULL, 1, 21, NULL, NULL, NULL, 400, 0, 0, NULL, '2020-11-27 15:59:19', '2020-12-07 16:48:50'),
(97, NULL, NULL, 1, 21, NULL, NULL, NULL, 400, 0, 0, NULL, '2020-11-27 15:59:19', '2020-12-07 16:48:50'),
(98, NULL, NULL, 1, 21, NULL, NULL, NULL, 400, 0, 0, NULL, '2020-11-27 15:59:19', '2020-12-07 16:48:50'),
(99, NULL, NULL, 1, 21, NULL, NULL, NULL, 400, 0, 0, NULL, '2020-11-27 15:59:19', '2020-12-07 16:48:50'),
(112, NULL, NULL, 1, 10, '2', '1', 224, 5000, 0, 0, NULL, '2020-11-27 16:23:37', '2020-11-27 16:23:37'),
(113, NULL, NULL, 1, 10, '2', '2', 225, 5000, 0, 0, NULL, '2020-11-27 16:23:37', '2020-12-08 12:44:03'),
(114, NULL, NULL, 1, 10, '2', '3', 226, 5000, 0, 0, NULL, '2020-11-27 16:23:37', '2020-11-28 18:11:22'),
(115, NULL, NULL, 1, 10, '2', '4', 227, 7000, 0, 0, NULL, '2020-11-27 16:23:37', '2020-12-08 09:56:13'),
(116, NULL, NULL, 1, 10, '2', '5', 228, 7000, 0, 0, NULL, '2020-11-27 16:23:37', '2020-12-08 13:54:40'),
(117, NULL, NULL, 1, 10, '2', '6', 229, 5000, 0, 0, NULL, '2020-11-27 16:23:37', '2020-11-30 18:07:18'),
(118, NULL, NULL, 1, 10, '2', '7', 230, 5000, 0, 0, NULL, '2020-11-27 16:23:37', '2020-11-27 16:23:37'),
(119, NULL, NULL, 1, 10, '2', '9', 232, 5000, 0, 0, NULL, '2020-11-27 16:23:37', '2020-11-27 16:23:37'),
(120, NULL, NULL, 1, 10, '2', '10', 233, 5000, 1, 1, NULL, '2020-11-27 16:23:37', '2020-12-10 14:11:00'),
(121, NULL, NULL, 1, 10, '3', '1', 234, 5000, 0, 0, NULL, '2020-11-27 16:23:37', '2020-12-08 14:10:04'),
(122, NULL, NULL, 1, 10, '3', '2', 235, 5000, 0, 0, NULL, '2020-11-27 16:23:37', '2020-12-08 15:01:12'),
(125, NULL, NULL, 1, 10, '3', '5', 238, 7000, 0, 0, NULL, '2020-11-27 16:23:37', '2020-12-08 14:37:20'),
(126, NULL, NULL, 1, 10, '3', '6', 239, 7000, 0, 0, NULL, '2020-11-27 16:23:37', '2020-12-08 09:56:13'),
(127, NULL, NULL, 1, 10, '3', '7', 240, 7000, 0, 0, NULL, '2020-11-27 16:23:37', '2020-12-08 09:56:13'),
(128, NULL, NULL, 1, 10, '3', '8', 241, 5000, 0, 0, NULL, '2020-11-27 16:23:37', '2020-12-07 22:24:28'),
(129, NULL, NULL, 1, 10, '3', '10', 243, 5000, 0, 0, NULL, '2020-11-27 16:23:37', '2020-11-27 16:23:37'),
(130, NULL, NULL, 1, 10, '4', '1', 244, 8000, 0, 0, NULL, '2020-11-27 16:23:44', '2020-12-08 14:10:04'),
(131, NULL, NULL, 1, 10, '4', '2', 245, 8000, 1, 1, NULL, '2020-11-27 16:23:44', '2020-12-08 15:05:17'),
(133, NULL, NULL, 1, 10, '4', '4', 247, 8000, 1, 1, NULL, '2020-11-27 16:23:44', '2020-12-08 17:29:30'),
(134, NULL, NULL, 1, 10, '4', '5', 248, 7000, 1, 1, NULL, '2020-11-27 16:23:44', '2020-12-08 17:28:50'),
(135, NULL, NULL, 1, 10, '4', '6', 249, 7000, 1, 1, NULL, '2020-11-27 16:23:44', '2020-12-10 14:11:00'),
(136, NULL, NULL, 1, 10, '4', '7', 250, 7000, 0, 0, NULL, '2020-11-27 16:23:44', '2020-12-08 09:56:13'),
(139, NULL, NULL, 1, 10, '1', '1', 214, 8000, 1, 0, NULL, '2020-11-27 16:23:44', '2020-12-10 16:37:43'),
(140, NULL, NULL, 1, 10, '1', '2', 215, 8000, 1, 1, NULL, '2020-11-27 16:23:44', '2020-12-08 15:05:17'),
(143, NULL, NULL, 1, 10, '1', '5', 218, 8000, 1, 1, NULL, '2020-11-27 16:23:44', '2020-12-08 17:28:50'),
(144, NULL, NULL, 1, 10, '1', '6', 219, 8000, 1, 0, NULL, '2020-11-27 16:23:44', '2020-12-08 15:24:54'),
(145, NULL, NULL, 1, 10, '1', '8', 221, 8000, 1, 0, NULL, '2020-11-27 16:23:44', '2020-12-08 15:24:54'),
(153, NULL, 3, 2, NULL, NULL, NULL, NULL, 1000, 1, 1, NULL, '2020-11-27 17:30:02', '2020-12-08 17:29:54'),
(154, NULL, 3, 2, NULL, NULL, NULL, NULL, 1000, 1, 1, NULL, '2020-11-27 17:30:02', '2020-12-10 14:10:45'),
(155, NULL, 3, 2, NULL, NULL, NULL, NULL, 1000, 0, 0, NULL, '2020-11-27 17:30:02', '2020-11-27 17:30:53'),
(156, NULL, 3, 2, NULL, NULL, NULL, NULL, 1000, 0, 0, NULL, '2020-11-27 17:30:02', '2020-11-27 17:30:53'),
(157, NULL, 3, 2, NULL, NULL, NULL, NULL, 1000, 0, 0, NULL, '2020-11-27 17:30:02', '2020-11-27 17:30:53'),
(158, NULL, 3, 2, NULL, NULL, NULL, NULL, 1000, 0, 0, NULL, '2020-11-27 17:30:02', '2020-11-27 17:30:53'),
(159, NULL, 3, 2, NULL, NULL, NULL, NULL, 1000, 0, 0, NULL, '2020-11-27 17:30:02', '2020-11-27 17:30:53'),
(160, NULL, 3, 2, NULL, NULL, NULL, NULL, 1000, 0, 0, NULL, '2020-11-27 17:30:02', '2020-11-27 17:30:53'),
(161, NULL, 3, 2, NULL, NULL, NULL, NULL, 1000, 0, 0, NULL, '2020-11-27 17:30:02', '2020-11-27 17:30:53'),
(162, NULL, 3, 2, NULL, NULL, NULL, NULL, 1000, 0, 0, NULL, '2020-11-27 17:30:02', '2020-11-27 17:30:53'),
(183, NULL, 3, 2, NULL, NULL, NULL, NULL, 1000, 0, 0, NULL, '2020-11-27 17:30:53', '2020-11-27 17:30:53'),
(184, NULL, 3, 2, NULL, NULL, NULL, NULL, 1000, 0, 0, NULL, '2020-11-27 17:30:53', '2020-11-27 17:30:53'),
(185, NULL, 3, 2, NULL, NULL, NULL, NULL, 1000, 0, 0, NULL, '2020-11-27 17:30:53', '2020-11-27 17:30:53'),
(186, NULL, 3, 2, NULL, NULL, NULL, NULL, 1000, 0, 0, NULL, '2020-11-27 17:30:53', '2020-11-27 17:30:53'),
(187, NULL, 3, 2, NULL, NULL, NULL, NULL, 1000, 0, 0, NULL, '2020-11-27 17:30:53', '2020-11-27 17:30:53'),
(188, NULL, 3, 2, NULL, NULL, NULL, NULL, 1000, 0, 0, NULL, '2020-11-27 17:30:53', '2020-11-27 17:30:53'),
(189, NULL, 3, 2, NULL, NULL, NULL, NULL, 1000, 0, 0, NULL, '2020-11-27 17:30:53', '2020-11-27 17:30:53'),
(190, NULL, 3, 2, NULL, NULL, NULL, NULL, 1000, 0, 0, NULL, '2020-11-27 17:30:53', '2020-11-27 17:30:53'),
(191, NULL, 3, 2, NULL, NULL, NULL, NULL, 1000, 0, 0, NULL, '2020-11-27 17:30:53', '2020-11-27 17:30:53'),
(192, NULL, 3, 2, NULL, NULL, NULL, NULL, 1000, 0, 0, NULL, '2020-11-27 17:30:53', '2020-11-27 17:30:53'),
(193, NULL, 3, 2, NULL, NULL, NULL, NULL, 1000, 0, 0, NULL, '2020-11-27 17:30:53', '2020-11-27 17:30:53'),
(194, NULL, 3, 2, NULL, NULL, NULL, NULL, 1000, 0, 0, NULL, '2020-11-27 17:30:53', '2020-11-27 17:30:53'),
(195, NULL, 3, 2, NULL, NULL, NULL, NULL, 1000, 0, 0, NULL, '2020-11-27 17:30:53', '2020-11-27 17:30:53'),
(196, NULL, 3, 2, NULL, NULL, NULL, NULL, 1000, 0, 0, NULL, '2020-11-27 17:30:53', '2020-11-27 17:30:53'),
(197, NULL, 3, 2, NULL, NULL, NULL, NULL, 1000, 0, 0, NULL, '2020-11-27 17:30:53', '2020-11-27 17:30:53'),
(198, NULL, 3, 2, NULL, NULL, NULL, NULL, 1000, 0, 0, NULL, '2020-11-27 17:30:53', '2020-11-27 17:30:53'),
(199, NULL, 3, 2, NULL, NULL, NULL, NULL, 1000, 0, 0, NULL, '2020-11-27 17:30:53', '2020-11-27 17:30:53'),
(200, NULL, 3, 2, NULL, NULL, NULL, NULL, 1000, 0, 0, NULL, '2020-11-27 17:30:53', '2020-11-27 17:30:53'),
(201, NULL, 3, 2, NULL, NULL, NULL, NULL, 1000, 0, 0, NULL, '2020-11-27 17:30:53', '2020-11-27 17:30:53'),
(202, NULL, 3, 2, NULL, NULL, NULL, NULL, 1000, 0, 0, NULL, '2020-11-27 17:30:53', '2020-11-27 17:30:53'),
(203, NULL, 5, 2, NULL, NULL, NULL, NULL, 5000, 1, 1, NULL, '2020-11-28 08:35:05', '2020-12-08 17:29:54'),
(204, NULL, 5, 2, NULL, NULL, NULL, NULL, 5000, 1, 1, NULL, '2020-11-28 08:35:05', '2020-12-10 14:10:45'),
(205, NULL, 5, 2, NULL, NULL, NULL, NULL, 5000, 0, 0, NULL, '2020-11-28 08:35:05', '2020-11-28 08:35:05'),
(206, NULL, 5, 2, NULL, NULL, NULL, NULL, 5000, 0, 0, NULL, '2020-11-28 08:35:05', '2020-11-28 08:35:05'),
(207, NULL, 5, 2, NULL, NULL, NULL, NULL, 5000, 0, 0, NULL, '2020-11-28 08:35:05', '2020-11-28 08:35:05'),
(208, NULL, 5, 2, NULL, NULL, NULL, NULL, 5000, 0, 0, NULL, '2020-11-28 08:35:05', '2020-11-28 08:35:05'),
(209, NULL, 5, 2, NULL, NULL, NULL, NULL, 5000, 0, 0, NULL, '2020-11-28 08:35:05', '2020-11-28 08:35:05'),
(210, NULL, 5, 2, NULL, NULL, NULL, NULL, 5000, 0, 0, NULL, '2020-11-28 08:35:05', '2020-11-28 08:35:05'),
(211, NULL, 5, 2, NULL, NULL, NULL, NULL, 5000, 0, 0, NULL, '2020-11-28 08:35:05', '2020-11-28 08:35:05'),
(212, NULL, 5, 2, NULL, NULL, NULL, NULL, 5000, 0, 0, NULL, '2020-11-28 08:35:05', '2020-11-28 08:35:05'),
(213, NULL, NULL, 1, 9, '1', '1', 183, 10000, 0, 0, NULL, '2020-11-28 12:08:34', '2020-11-28 12:08:34'),
(214, NULL, NULL, 1, 9, '1', '2', 184, 10000, 0, 0, NULL, '2020-11-28 12:08:35', '2020-11-28 12:08:35'),
(215, NULL, NULL, 1, 9, '1', '3', 185, 10000, 0, 0, NULL, '2020-11-28 12:08:35', '2020-11-28 12:08:35'),
(216, NULL, NULL, 1, 9, '1', '4', 186, 10000, 0, 0, NULL, '2020-11-28 12:08:35', '2020-11-28 12:08:35'),
(217, NULL, NULL, 1, 9, '1', '5', 187, 10000, 0, 0, NULL, '2020-11-28 12:08:35', '2020-11-28 12:08:35'),
(218, NULL, NULL, 1, 9, '1', '6', 188, 10000, 0, 0, NULL, '2020-11-28 12:08:35', '2020-11-28 12:08:35'),
(219, NULL, NULL, 1, 9, '1', '7', 189, 10000, 0, 0, NULL, '2020-11-28 12:08:35', '2020-11-28 12:08:35'),
(220, NULL, NULL, 1, 9, '1', '8', 190, 10000, 0, 0, NULL, '2020-11-28 12:08:35', '2020-11-28 12:08:35'),
(221, NULL, NULL, 1, 9, '1', '9', 191, 10000, 0, 0, NULL, '2020-11-28 12:08:35', '2020-11-28 12:08:35'),
(222, NULL, NULL, 1, 9, '1', '10', 192, 10000, 0, 0, NULL, '2020-11-28 12:08:35', '2020-11-28 12:08:35'),
(223, NULL, NULL, 1, 9, '2', '1', 193, 10000, 0, 0, NULL, '2020-11-28 12:08:35', '2020-11-28 12:08:35'),
(224, NULL, NULL, 1, 9, '2', '2', 194, 10000, 0, 0, NULL, '2020-11-28 12:08:35', '2020-11-28 12:08:35'),
(225, NULL, NULL, 1, 9, '2', '3', 195, 10000, 0, 0, NULL, '2020-11-28 12:08:35', '2020-11-28 12:08:35'),
(226, NULL, NULL, 1, 9, '2', '4', 196, 10000, 0, 0, NULL, '2020-11-28 12:08:35', '2020-12-08 14:10:14'),
(227, NULL, NULL, 1, 9, '2', '5', 197, 10000, 0, 0, NULL, '2020-11-28 12:08:35', '2020-12-08 14:10:14'),
(228, NULL, NULL, 1, 9, '2', '6', 198, 10000, 0, 0, NULL, '2020-11-28 12:08:35', '2020-11-28 12:08:35'),
(229, NULL, NULL, 1, 9, '2', '7', 199, 10000, 0, 0, NULL, '2020-11-28 12:08:35', '2020-11-28 12:08:35'),
(230, NULL, NULL, 1, 9, '2', '8', 200, 10000, 0, 0, NULL, '2020-11-28 12:08:35', '2020-11-28 12:08:35'),
(231, NULL, NULL, 1, 9, '2', '9', 201, 10000, 0, 0, NULL, '2020-11-28 12:08:35', '2020-12-07 16:56:36'),
(232, NULL, NULL, 1, 9, '2', '10', 202, 10000, 0, 0, NULL, '2020-11-28 12:08:35', '2020-11-28 12:08:35'),
(233, NULL, NULL, 1, 9, '3', '1', 203, 10000, 0, 0, NULL, '2020-11-28 12:08:35', '2020-11-28 12:08:35'),
(234, NULL, NULL, 1, 9, '3', '2', 204, 10000, 0, 0, NULL, '2020-11-28 12:08:35', '2020-11-28 12:08:35'),
(235, NULL, NULL, 1, 9, '3', '3', 205, 10000, 0, 0, NULL, '2020-11-28 12:08:35', '2020-11-28 12:08:35'),
(236, NULL, NULL, 1, 9, '3', '4', 206, 10000, 0, 0, NULL, '2020-11-28 12:08:35', '2020-11-28 12:08:35'),
(237, NULL, NULL, 1, 9, '3', '5', 207, 10000, 0, 0, NULL, '2020-11-28 12:08:35', '2020-11-28 12:08:35'),
(238, NULL, NULL, 1, 9, '3', '6', 208, 10000, 0, 0, NULL, '2020-11-28 12:08:35', '2020-11-28 12:08:35'),
(239, NULL, NULL, 1, 9, '3', '7', 209, 10000, 0, 0, NULL, '2020-11-28 12:08:35', '2020-11-28 12:08:35'),
(240, NULL, NULL, 1, 9, '3', '8', 210, 10000, 0, 0, NULL, '2020-11-28 12:08:35', '2020-11-28 12:08:35'),
(241, NULL, NULL, 1, 9, '3', '9', 211, 10000, 0, 0, NULL, '2020-11-28 12:08:35', '2020-11-28 12:08:35'),
(242, NULL, NULL, 1, 9, '3', '10', 212, 10000, 0, 0, NULL, '2020-11-28 12:08:35', '2020-11-28 12:08:35'),
(244, NULL, NULL, 1, 21, NULL, NULL, NULL, 400, 0, 0, NULL, '2020-12-07 16:48:50', '2020-12-07 16:48:50'),
(245, NULL, NULL, 1, 21, NULL, NULL, NULL, 400, 0, 0, NULL, '2020-12-07 16:48:50', '2020-12-07 16:48:50'),
(246, NULL, NULL, 1, 21, NULL, NULL, NULL, 400, 0, 0, NULL, '2020-12-07 16:48:50', '2020-12-07 16:48:50'),
(247, NULL, NULL, 1, 21, NULL, NULL, NULL, 400, 0, 0, NULL, '2020-12-07 16:48:50', '2020-12-07 16:48:50'),
(248, NULL, NULL, 1, 21, NULL, NULL, NULL, 400, 0, 0, NULL, '2020-12-07 16:48:50', '2020-12-07 16:48:50'),
(249, NULL, NULL, 1, 21, NULL, NULL, NULL, 400, 0, 0, NULL, '2020-12-07 16:48:50', '2020-12-07 16:48:50'),
(250, NULL, NULL, 1, 21, NULL, NULL, NULL, 400, 0, 0, NULL, '2020-12-07 16:48:50', '2020-12-07 16:48:50'),
(251, NULL, NULL, 1, 21, NULL, NULL, NULL, 400, 0, 0, NULL, '2020-12-07 16:48:50', '2020-12-07 16:48:50'),
(252, NULL, NULL, 1, 21, NULL, NULL, NULL, 400, 0, 0, NULL, '2020-12-07 16:48:50', '2020-12-07 16:48:50'),
(253, NULL, NULL, 1, 21, NULL, NULL, NULL, 400, 0, 0, NULL, '2020-12-07 16:48:50', '2020-12-07 16:48:50'),
(254, NULL, NULL, 3, 26, '12', '3', 798, 5000, 0, 0, NULL, '2020-12-09 15:50:31', '2020-12-09 15:50:31'),
(255, NULL, NULL, 3, 26, '13', '2', 841, 5000, 0, 0, NULL, '2020-12-09 15:50:31', '2020-12-09 18:08:00'),
(256, NULL, NULL, 3, 26, '12', '4', 799, 5000, 0, 0, NULL, '2020-12-09 15:50:31', '2020-12-09 15:50:31'),
(257, NULL, NULL, 3, 26, '13', '3', 842, 5000, 0, 0, NULL, '2020-12-09 15:50:31', '2020-12-09 17:18:45'),
(258, NULL, NULL, 3, 26, '14', '1', 882, 5000, 0, 0, NULL, '2020-12-09 15:50:31', '2020-12-09 18:08:00'),
(259, NULL, NULL, 3, 26, '14', '2', 883, 5000, 0, 0, NULL, '2020-12-09 15:50:31', '2020-12-09 17:18:45'),
(260, NULL, NULL, 1, 10, '1', '3', 216, 8000, 1, 0, NULL, '2020-12-10 13:04:03', '2020-12-10 16:52:58'),
(261, NULL, NULL, 1, 10, '3', '3', 236, 7000, 0, 0, NULL, '2020-12-10 13:04:11', '2020-12-10 13:04:11'),
(262, NULL, NULL, 1, 10, '3', '4', 237, 5000, 0, 0, NULL, '2020-12-10 13:04:17', '2020-12-10 13:04:17'),
(263, NULL, NULL, 1, 10, '1', '9', 222, 500, 0, 0, NULL, '2020-12-10 17:16:23', '2020-12-10 17:16:23'),
(264, NULL, NULL, 1, 10, '1', '10', 223, 500, 1, 1, NULL, '2020-12-10 17:16:23', '2020-12-10 17:17:57'),
(265, NULL, NULL, 1, 10, '4', '10', 253, 500, 0, 0, NULL, '2020-12-10 17:16:23', '2020-12-10 17:16:23'),
(266, NULL, NULL, 1, 10, '4', '9', 252, 500, 0, 0, NULL, '2020-12-10 17:16:23', '2020-12-10 17:16:23');

-- --------------------------------------------------------

--
-- Table structure for table `ticket_designs`
--

CREATE TABLE `ticket_designs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title_exists` tinyint(1) NOT NULL DEFAULT '1',
  `title_l` smallint(6) NOT NULL DEFAULT '0',
  `title_r` smallint(6) NOT NULL DEFAULT '0',
  `title_t` smallint(6) NOT NULL DEFAULT '0',
  `date_exists` tinyint(1) NOT NULL DEFAULT '1',
  `date_l` smallint(6) NOT NULL DEFAULT '0',
  `date_r` smallint(6) NOT NULL DEFAULT '0',
  `date_t` smallint(6) NOT NULL DEFAULT '0',
  `section_exists` tinyint(1) NOT NULL DEFAULT '1',
  `section_l` smallint(6) NOT NULL DEFAULT '0',
  `section_r` smallint(6) NOT NULL DEFAULT '0',
  `section_t` smallint(6) NOT NULL DEFAULT '0',
  `row_exists` tinyint(1) NOT NULL DEFAULT '1',
  `row_l` smallint(6) NOT NULL DEFAULT '0',
  `row_r` smallint(6) NOT NULL DEFAULT '0',
  `row_t` smallint(6) NOT NULL DEFAULT '0',
  `seat_exists` tinyint(1) NOT NULL DEFAULT '1',
  `seat_l` smallint(6) NOT NULL DEFAULT '0',
  `seat_r` smallint(6) NOT NULL DEFAULT '0',
  `seat_t` smallint(6) NOT NULL DEFAULT '0',
  `barcode_exists` tinyint(1) NOT NULL DEFAULT '1',
  `barcode_l` smallint(6) NOT NULL DEFAULT '0',
  `barcode_r` smallint(6) NOT NULL DEFAULT '0',
  `barcode_t` smallint(6) NOT NULL DEFAULT '0',
  `qr_exists` tinyint(1) NOT NULL DEFAULT '1',
  `qr_l` smallint(6) NOT NULL DEFAULT '0',
  `qr_r` smallint(6) NOT NULL DEFAULT '0',
  `qr_t` smallint(6) NOT NULL DEFAULT '0',
  `ticketn_exists` tinyint(1) NOT NULL DEFAULT '1',
  `ticketn_l` smallint(6) NOT NULL DEFAULT '0',
  `ticketn_r` smallint(6) NOT NULL DEFAULT '0',
  `ticketn_t` smallint(6) NOT NULL DEFAULT '0',
  `price_exists` tinyint(1) NOT NULL DEFAULT '1',
  `price_l` smallint(6) NOT NULL DEFAULT '0',
  `price_r` smallint(6) NOT NULL DEFAULT '0',
  `price_t` smallint(6) NOT NULL DEFAULT '0',
  `order_exists` tinyint(1) NOT NULL DEFAULT '1',
  `order_l` smallint(6) NOT NULL DEFAULT '0',
  `order_r` smallint(6) NOT NULL DEFAULT '0',
  `order_t` smallint(6) NOT NULL DEFAULT '0',
  `user_exists` tinyint(1) NOT NULL DEFAULT '1',
  `user_l` smallint(6) NOT NULL DEFAULT '0',
  `user_r` smallint(6) NOT NULL DEFAULT '0',
  `user_t` smallint(6) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ticket_designs`
--

INSERT INTO `ticket_designs` (`id`, `title`, `title_exists`, `title_l`, `title_r`, `title_t`, `date_exists`, `date_l`, `date_r`, `date_t`, `section_exists`, `section_l`, `section_r`, `section_t`, `row_exists`, `row_l`, `row_r`, `row_t`, `seat_exists`, `seat_l`, `seat_r`, `seat_t`, `barcode_exists`, `barcode_l`, `barcode_r`, `barcode_t`, `qr_exists`, `qr_l`, `qr_r`, `qr_t`, `ticketn_exists`, `ticketn_l`, `ticketn_r`, `ticketn_t`, `price_exists`, `price_l`, `price_r`, `price_t`, `order_exists`, `order_l`, `order_r`, `order_t`, `user_exists`, `user_l`, `user_r`, `user_t`) VALUES
(1, 'Стандартный', 1, 119, 0, 200, 1, 119, 0, 270, 1, 119, 0, 300, 1, 119, 0, 330, 1, 119, 0, 360, 1, 724, 0, 1430, 1, 0, 118, 218, 1, 0, 118, 122, 1, 119, 0, 390, 1, 119, 0, 420, 1, 119, 0, 450);

-- --------------------------------------------------------

--
-- Table structure for table `timetables`
--

CREATE TABLE `timetables` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `api_id` bigint(20) UNSIGNED DEFAULT NULL,
  `api` enum('lermontov','gatob','sats') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `event_id` bigint(20) UNSIGNED NOT NULL,
  `venue_id` bigint(20) UNSIGNED NOT NULL,
  `venue_scheme_id` bigint(20) UNSIGNED DEFAULT NULL,
  `datetime` datetime DEFAULT NULL,
  `type` enum('sections','pricegroups') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'sections',
  `note` json DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `timetables`
--

INSERT INTO `timetables` (`id`, `api_id`, `api`, `event_id`, `venue_id`, `venue_scheme_id`, `datetime`, `type`, `note`, `active`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, NULL, NULL, 1, 2, 2, '2021-01-16 14:50:00', 'sections', '{\"kz\": null}', 1, '2020-11-26 10:51:22', '2020-12-07 16:41:50', NULL),
(2, NULL, NULL, 1, 1, 1, '2020-12-27 22:30:00', 'pricegroups', '{\"kz\": \"<p>asdf</p>\", \"ru\": \"<p>asdafds</p>\"}', 1, '2020-11-27 16:25:01', '2020-12-07 16:41:44', NULL),
(3, NULL, NULL, 2, 3, 3, '2020-12-24 19:00:00', 'sections', '{\"kz\": null}', 1, '2020-12-09 15:10:03', '2020-12-09 15:10:08', NULL),
(226, 4010, 'lermontov', 3, 1, 6, '2020-12-10 19:00:00', 'sections', '{}', 1, '2020-12-10 10:48:21', '2020-12-10 10:48:21', NULL),
(227, 3990, 'lermontov', 4, 1, 1, '2020-12-10 19:00:00', 'sections', '{}', 1, '2020-12-10 10:48:21', '2020-12-10 10:48:21', NULL),
(228, 3998, 'lermontov', 5, 1, 1, '2020-12-11 19:00:00', 'sections', '{}', 1, '2020-12-10 10:48:21', '2020-12-10 10:48:21', NULL),
(229, 3999, 'lermontov', 6, 1, 1, '2020-12-12 18:00:00', 'sections', '{}', 1, '2020-12-10 10:48:21', '2020-12-10 10:48:21', NULL),
(230, 4011, 'lermontov', 7, 1, 6, '2020-12-12 18:00:00', 'sections', '{}', 1, '2020-12-10 10:48:21', '2020-12-10 10:48:21', NULL),
(231, 4000, 'lermontov', 8, 1, 1, '2020-12-13 11:00:00', 'sections', '{}', 1, '2020-12-10 10:48:21', '2020-12-10 10:48:21', NULL),
(232, 4001, 'lermontov', 9, 1, 1, '2020-12-13 18:00:00', 'sections', '{}', 1, '2020-12-10 10:48:21', '2020-12-10 10:48:21', NULL),
(233, 4002, 'lermontov', 10, 1, 1, '2020-12-15 19:00:00', 'sections', '{}', 1, '2020-12-10 10:48:21', '2020-12-10 10:48:21', NULL),
(234, 4003, 'lermontov', 11, 1, 1, '2020-12-16 19:00:00', 'sections', '{}', 1, '2020-12-10 10:48:21', '2020-12-10 10:48:21', NULL),
(235, 4012, 'lermontov', 12, 1, 6, '2020-12-16 19:00:00', 'sections', '{}', 1, '2020-12-10 10:48:21', '2020-12-10 10:48:21', NULL),
(236, 4013, 'lermontov', 13, 1, 6, '2020-12-17 19:00:00', 'sections', '{}', 1, '2020-12-10 10:48:21', '2020-12-10 10:48:21', NULL),
(237, 4004, 'lermontov', 14, 1, 1, '2020-12-17 19:00:00', 'sections', '{}', 1, '2020-12-10 10:48:21', '2020-12-10 10:48:21', NULL),
(238, 4005, 'lermontov', 15, 1, 1, '2020-12-18 19:00:00', 'sections', '{}', 1, '2020-12-10 10:48:21', '2020-12-10 10:48:21', NULL),
(239, 4014, 'lermontov', 16, 1, 6, '2020-12-18 19:00:00', 'sections', '{}', 1, '2020-12-10 10:48:21', '2020-12-10 10:48:21', NULL),
(240, 4015, 'lermontov', 17, 1, 6, '2020-12-19 18:00:00', 'sections', '{}', 1, '2020-12-10 10:48:21', '2020-12-10 10:48:21', NULL),
(241, 4006, 'lermontov', 18, 1, 1, '2020-12-19 18:00:00', 'sections', '{}', 1, '2020-12-10 10:48:21', '2020-12-10 10:48:21', NULL),
(242, 4007, 'lermontov', 19, 1, 1, '2020-12-20 18:00:00', 'sections', '{}', 1, '2020-12-10 10:48:21', '2020-12-10 10:48:21', NULL),
(243, 4017, 'lermontov', 20, 1, 1, '2020-12-21 17:30:00', 'sections', '{}', 1, '2020-12-10 10:48:21', '2020-12-10 10:48:21', NULL),
(244, 4018, 'lermontov', 21, 1, 1, '2020-12-21 20:30:00', 'sections', '{}', 1, '2020-12-10 10:48:21', '2020-12-10 10:48:21', NULL),
(245, 3975, 'lermontov', 22, 1, 1, '2020-12-24 11:00:00', 'sections', '{}', 1, '2020-12-10 10:48:21', '2020-12-10 10:48:21', NULL),
(246, 3976, 'lermontov', 23, 1, 1, '2020-12-24 13:30:00', 'sections', '{}', 1, '2020-12-10 10:48:21', '2020-12-10 10:48:21', NULL),
(247, 3977, 'lermontov', 24, 1, 1, '2020-12-25 11:00:00', 'sections', '{}', 1, '2020-12-10 10:48:21', '2020-12-10 10:48:21', NULL),
(248, 3978, 'lermontov', 25, 1, 1, '2020-12-25 13:30:00', 'sections', '{}', 1, '2020-12-10 10:48:22', '2020-12-10 10:48:22', NULL),
(249, 3980, 'lermontov', 26, 1, 1, '2020-12-26 13:30:00', 'sections', '{}', 1, '2020-12-10 10:48:22', '2020-12-10 10:48:22', NULL),
(250, 3981, 'lermontov', 27, 1, 1, '2020-12-27 11:00:00', 'sections', '{}', 1, '2020-12-10 10:48:22', '2020-12-10 10:48:22', NULL),
(251, 3982, 'lermontov', 28, 1, 1, '2020-12-27 13:30:00', 'sections', '{}', 1, '2020-12-10 10:48:22', '2020-12-10 10:48:22', NULL),
(252, 3983, 'lermontov', 29, 1, 1, '2020-12-28 11:00:00', 'sections', '{}', 1, '2020-12-10 10:48:22', '2020-12-10 10:48:22', NULL),
(253, 3984, 'lermontov', 30, 1, 1, '2020-12-28 13:30:00', 'sections', '{}', 1, '2020-12-10 10:48:22', '2020-12-10 10:48:22', NULL),
(254, 3985, 'lermontov', 31, 1, 1, '2020-12-29 11:00:00', 'sections', '{}', 1, '2020-12-10 10:48:22', '2020-12-10 10:48:22', NULL),
(255, 3986, 'lermontov', 32, 1, 1, '2020-12-29 13:30:00', 'sections', '{}', 1, '2020-12-10 10:48:22', '2020-12-10 10:48:22', NULL),
(256, 3987, 'lermontov', 33, 1, 1, '2020-12-30 11:00:00', 'sections', '{}', 1, '2020-12-10 10:48:22', '2020-12-10 10:48:22', NULL),
(257, 3988, 'lermontov', 34, 1, 1, '2020-12-30 13:30:00', 'sections', '{}', 1, '2020-12-10 10:48:22', '2020-12-10 10:48:22', NULL),
(258, 4019, 'lermontov', 35, 1, 1, '2021-01-02 13:30:00', 'sections', '{}', 1, '2020-12-10 10:48:22', '2020-12-10 10:48:22', NULL),
(259, 4020, 'lermontov', 36, 1, 1, '2021-01-03 11:00:00', 'sections', '{}', 1, '2020-12-10 10:48:22', '2020-12-10 10:48:22', NULL),
(260, 4021, 'lermontov', 37, 1, 1, '2021-01-03 13:30:00', 'sections', '{}', 1, '2020-12-10 10:48:22', '2020-12-10 10:48:22', NULL),
(261, 4024, 'lermontov', 38, 1, 1, '2021-01-05 11:00:00', 'sections', '{}', 1, '2020-12-10 10:48:22', '2020-12-10 10:48:22', NULL),
(262, 4025, 'lermontov', 39, 1, 1, '2021-01-05 13:30:00', 'sections', '{}', 1, '2020-12-10 10:48:22', '2020-12-10 10:48:22', NULL),
(263, 4026, 'lermontov', 40, 1, 1, '2021-01-06 11:00:00', 'sections', '{}', 1, '2020-12-10 10:48:22', '2020-12-10 10:48:22', NULL),
(264, 4027, 'lermontov', 41, 1, 1, '2021-01-06 13:30:00', 'sections', '{}', 1, '2020-12-10 10:48:22', '2020-12-10 10:48:22', NULL),
(265, 4028, 'lermontov', 42, 1, 1, '2021-01-07 11:00:00', 'sections', '{}', 1, '2020-12-10 10:48:22', '2020-12-10 10:48:22', NULL),
(266, 4029, 'lermontov', 43, 1, 1, '2021-01-07 13:30:00', 'sections', '{}', 1, '2020-12-10 10:48:22', '2020-12-10 10:48:22', NULL),
(267, 4030, 'lermontov', 44, 1, 1, '2021-01-08 19:00:00', 'sections', '{}', 1, '2020-12-10 10:48:22', '2020-12-10 10:48:22', NULL),
(268, 4051, 'lermontov', 45, 1, 6, '2021-01-08 19:00:00', 'sections', '{}', 1, '2020-12-10 10:48:22', '2020-12-10 10:48:22', NULL),
(269, 4052, 'lermontov', 46, 1, 6, '2021-01-09 18:00:00', 'sections', '{}', 1, '2020-12-10 10:48:22', '2020-12-10 10:48:22', NULL),
(270, 4031, 'lermontov', 47, 1, 1, '2021-01-09 18:00:00', 'sections', '{}', 1, '2020-12-10 10:48:22', '2020-12-10 10:48:22', NULL),
(271, 4032, 'lermontov', 48, 1, 1, '2021-01-10 18:00:00', 'sections', '{}', 1, '2020-12-10 10:48:22', '2020-12-10 10:48:22', NULL),
(272, 4053, 'lermontov', 49, 1, 6, '2021-01-10 18:00:00', 'sections', '{}', 1, '2020-12-10 10:48:22', '2020-12-10 10:48:22', NULL),
(273, 4033, 'lermontov', 50, 1, 1, '2021-01-12 19:00:00', 'sections', '{}', 1, '2020-12-10 10:48:22', '2020-12-10 10:48:22', NULL),
(274, 4034, 'lermontov', 51, 1, 1, '2021-01-13 19:00:00', 'sections', '{}', 1, '2020-12-10 10:48:22', '2020-12-10 10:48:22', NULL),
(275, 4035, 'lermontov', 52, 1, 1, '2021-01-14 19:00:00', 'sections', '{}', 1, '2020-12-10 10:48:22', '2020-12-10 10:48:22', NULL),
(276, 4054, 'lermontov', 53, 1, 6, '2021-01-14 19:00:00', 'sections', '{}', 1, '2020-12-10 10:48:22', '2020-12-10 10:48:22', NULL),
(277, 4036, 'lermontov', 54, 1, 1, '2021-01-15 19:00:00', 'sections', '{}', 1, '2020-12-10 10:48:22', '2020-12-10 10:48:22', NULL),
(278, 4037, 'lermontov', 55, 1, 1, '2021-01-16 18:00:00', 'sections', '{}', 1, '2020-12-10 10:48:22', '2020-12-10 10:48:22', NULL),
(279, 4038, 'lermontov', 56, 1, 1, '2021-01-17 18:00:00', 'sections', '{}', 1, '2020-12-10 10:48:22', '2020-12-10 10:48:22', NULL),
(280, 4055, 'lermontov', 57, 1, 6, '2021-01-17 18:00:00', 'sections', '{}', 1, '2020-12-10 10:48:22', '2020-12-10 10:48:22', NULL),
(281, 4056, 'lermontov', 58, 1, 6, '2021-01-19 19:00:00', 'sections', '{}', 1, '2020-12-10 10:48:22', '2020-12-10 10:48:22', NULL),
(282, 4039, 'lermontov', 59, 1, 1, '2021-01-19 19:00:00', 'sections', '{}', 1, '2020-12-10 10:48:22', '2020-12-10 10:48:22', NULL),
(283, 4040, 'lermontov', 60, 1, 1, '2021-01-20 19:00:00', 'sections', '{}', 1, '2020-12-10 10:48:22', '2020-12-10 10:48:22', NULL),
(284, 4041, 'lermontov', 61, 1, 1, '2021-01-21 19:00:00', 'sections', '{}', 1, '2020-12-10 10:48:22', '2020-12-10 10:48:22', NULL),
(285, 4042, 'lermontov', 62, 1, 1, '2021-01-22 19:00:00', 'sections', '{}', 1, '2020-12-10 10:48:22', '2020-12-10 10:48:22', NULL),
(286, 4057, 'lermontov', 63, 1, 6, '2021-01-22 19:00:00', 'sections', '{}', 1, '2020-12-10 10:48:22', '2020-12-10 10:48:22', NULL),
(287, 4058, 'lermontov', 64, 1, 6, '2021-01-23 18:00:00', 'sections', '{}', 1, '2020-12-10 10:48:22', '2020-12-10 10:48:22', NULL),
(288, 4043, 'lermontov', 65, 1, 1, '2021-01-23 18:00:00', 'sections', '{}', 1, '2020-12-10 10:48:23', '2020-12-10 10:48:23', NULL),
(289, 4044, 'lermontov', 66, 1, 1, '2021-01-24 18:00:00', 'sections', '{}', 1, '2020-12-10 10:48:23', '2020-12-10 10:48:23', NULL),
(290, 4059, 'lermontov', 67, 1, 6, '2021-01-24 18:00:00', 'sections', '{}', 1, '2020-12-10 10:48:23', '2020-12-10 10:48:23', NULL),
(291, 4045, 'lermontov', 68, 1, 1, '2021-01-26 19:00:00', 'sections', '{}', 1, '2020-12-10 10:48:23', '2020-12-10 10:48:23', NULL),
(292, 4046, 'lermontov', 69, 1, 1, '2021-01-27 19:00:00', 'sections', '{}', 1, '2020-12-10 10:48:23', '2020-12-10 10:48:23', NULL),
(293, 4047, 'lermontov', 70, 1, 1, '2021-01-28 19:00:00', 'sections', '{}', 1, '2020-12-10 10:48:23', '2020-12-10 10:48:23', NULL),
(294, 4048, 'lermontov', 71, 1, 1, '2021-01-29 19:00:00', 'sections', '{}', 1, '2020-12-10 10:48:23', '2020-12-10 10:48:23', NULL),
(295, 4049, 'lermontov', 72, 1, 1, '2021-01-30 18:00:00', 'sections', '{}', 1, '2020-12-10 10:48:23', '2020-12-10 10:48:23', NULL),
(296, 4050, 'lermontov', 73, 1, 1, '2021-01-31 18:00:00', 'sections', '{}', 1, '2020-12-10 10:48:23', '2020-12-10 10:48:23', NULL),
(297, 4061, 'lermontov', 74, 1, 6, '2021-01-31 18:00:00', 'sections', '{}', 1, '2020-12-10 10:48:23', '2020-12-10 10:48:23', NULL),
(298, 4062, 'lermontov', 75, 1, 1, '2021-02-15 17:30:00', 'sections', '{}', 1, '2020-12-10 10:48:23', '2020-12-10 10:48:23', NULL),
(299, 4063, 'lermontov', 76, 1, 1, '2021-02-15 20:30:00', 'sections', '{}', 1, '2020-12-10 10:48:23', '2020-12-10 10:48:23', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `two_factor_secret` text COLLATE utf8mb4_unicode_ci,
  `two_factor_recovery_codes` text COLLATE utf8mb4_unicode_ci,
  `api_token` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `phone`, `email`, `email_verified_at`, `password`, `two_factor_secret`, `two_factor_recovery_codes`, `api_token`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'admin', '656565', 'hello@spaceduck.kz', NULL, '$2y$10$k1k2h3hUiU0R.vi3YWYCf.NjtcT71rHoRKh8IOjIRvIv/8BFP0Qva', NULL, NULL, 'VWrHSLAvuXr5hysNH2oWc6GA26FsgAYmHS5crNFkrqbvbZCuhj3tHu1lkt70xXbJ', NULL, '2020-11-26 03:43:37', '2020-12-08 17:29:30');

-- --------------------------------------------------------

--
-- Table structure for table `venues`
--

CREATE TABLE `venues` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` json DEFAULT NULL,
  `city_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `venues`
--

INSERT INTO `venues` (`id`, `title`, `city_id`, `created_at`, `updated_at`) VALUES
(1, '{\"kz\": \"Театр Лермонтова\", \"ru\": \"Театр Лермонтова\"}', 1, '2020-11-26 09:36:09', '2020-11-26 09:38:50'),
(2, '{\"kz\": null, \"ru\": \"Дворец Республики\"}', 1, '2020-11-26 09:39:40', '2020-11-26 09:39:40'),
(3, '{\"kz\": \"Государственный академический русский театр для детей и юношества им. Наталии Сац\", \"ru\": \"Государственный академический русский театр для детей и юношества им. Наталии Сац\"}', 1, '2020-12-07 14:49:30', '2020-12-07 14:49:30');

-- --------------------------------------------------------

--
-- Table structure for table `venue_schemes`
--

CREATE TABLE `venue_schemes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` json DEFAULT NULL,
  `venue_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `venue_schemes`
--

INSERT INTO `venue_schemes` (`id`, `title`, `venue_id`) VALUES
(1, '{\"kz\": \"Основной\", \"ru\": \"Основной\"}', 1),
(2, '{\"kz\": \"Основной\", \"ru\": \"Основной\"}', 2),
(3, '{\"kz\": \"Основной\", \"ru\": \"Основной\"}', 3),
(5, '{\"kz\": \"Камерный\", \"ru\": \"Камерный\"}', 3),
(6, '{\"kz\": \"Малый зал\", \"ru\": \"Малый зал\"}', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activity_log`
--
ALTER TABLE `activity_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `subject` (`subject_type`,`subject_id`),
  ADD KEY `causer` (`causer_type`,`causer_id`),
  ADD KEY `activity_log_log_name_index` (`log_name`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `categories_active_index` (`active`);

--
-- Indexes for table `cities`
--
ALTER TABLE `cities`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`id`),
  ADD KEY `events_category_id_foreign` (`category_id`),
  ADD KEY `events_ticket_design_id_foreign` (`ticket_design_id`),
  ADD KEY `events_organizator_id_foreign` (`organizator_id`),
  ADD KEY `events_api_id_index` (`api_id`),
  ADD KEY `events_api_index` (`api`),
  ADD KEY `events_active_index` (`active`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `orders_timetable_id_foreign` (`timetable_id`),
  ADD KEY `orders_user_id_foreign` (`user_id`),
  ADD KEY `orders_hash_index` (`hash`),
  ADD KEY `orders_paid_index` (`paid`),
  ADD KEY `orders_sent_index` (`sent`),
  ADD KEY `api` (`api`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_items_order_id_foreign` (`order_id`),
  ADD KEY `order_items_timetable_id_foreign` (`timetable_id`),
  ADD KEY `order_items_section_id_foreign` (`section_id`),
  ADD KEY `order_items_pricegroup_id_foreign` (`pricegroup_id`),
  ADD KEY `order_items_row_index` (`row`),
  ADD KEY `order_items_seat_index` (`seat`),
  ADD KEY `order_items_barcode_index` (`barcode`),
  ADD KEY `order_items_ticket_id_foreign` (`ticket_id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `pricegroups`
--
ALTER TABLE `pricegroups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pricegroups_timetable_id_foreign` (`timetable_id`),
  ADD KEY `pricegroups_api_id_index` (`api_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indexes for table `seats`
--
ALTER TABLE `seats`
  ADD PRIMARY KEY (`id`),
  ADD KEY `seats_section_id_foreign` (`section_id`);

--
-- Indexes for table `sections`
--
ALTER TABLE `sections`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sections_venue_id_foreign` (`venue_scheme_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `settings_code_index` (`code`);

--
-- Indexes for table `spacemedia`
--
ALTER TABLE `spacemedia`
  ADD PRIMARY KEY (`id`),
  ADD KEY `spacemedia_model_type_model_id_index` (`model_type`,`model_id`);

--
-- Indexes for table `tickets`
--
ALTER TABLE `tickets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tickets_pricegroup_id_foreign` (`pricegroup_id`),
  ADD KEY `tickets_timetable_id_foreign` (`timetable_id`),
  ADD KEY `tickets_section_id_foreign` (`section_id`),
  ADD KEY `tickets_api_id_index` (`api_id`),
  ADD KEY `tickets_row_index` (`row`),
  ADD KEY `tickets_seat_index` (`seat`),
  ADD KEY `tickets_blocked_index` (`blocked`),
  ADD KEY `tickets_sold_index` (`sold`),
  ADD KEY `tickets_barcode_index` (`barcode`),
  ADD KEY `seat_id` (`seat_id`);

--
-- Indexes for table `ticket_designs`
--
ALTER TABLE `ticket_designs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `timetables`
--
ALTER TABLE `timetables`
  ADD PRIMARY KEY (`id`),
  ADD KEY `timetables_event_id_foreign` (`event_id`),
  ADD KEY `timetables_venue_id_foreign` (`venue_id`),
  ADD KEY `timetables_venue_scheme_id_foreign` (`venue_scheme_id`),
  ADD KEY `timetables_api_id_index` (`api_id`),
  ADD KEY `timetables_datetime_index` (`datetime`),
  ADD KEY `timetables_active_index` (`active`),
  ADD KEY `api` (`api`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD UNIQUE KEY `api_token` (`api_token`);

--
-- Indexes for table `venues`
--
ALTER TABLE `venues`
  ADD PRIMARY KEY (`id`),
  ADD KEY `venues_city_id_foreign` (`city_id`);

--
-- Indexes for table `venue_schemes`
--
ALTER TABLE `venue_schemes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `venue_id` (`venue_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activity_log`
--
ALTER TABLE `activity_log`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1437;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `cities`
--
ALTER TABLE `cities`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=77;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=108;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10000013;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=113;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pricegroups`
--
ALTER TABLE `pricegroups`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `seats`
--
ALTER TABLE `seats`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2083;

--
-- AUTO_INCREMENT for table `sections`
--
ALTER TABLE `sections`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `spacemedia`
--
ALTER TABLE `spacemedia`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tickets`
--
ALTER TABLE `tickets`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=267;

--
-- AUTO_INCREMENT for table `ticket_designs`
--
ALTER TABLE `ticket_designs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `timetables`
--
ALTER TABLE `timetables`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=300;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `venues`
--
ALTER TABLE `venues`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `venue_schemes`
--
ALTER TABLE `venue_schemes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `events`
--
ALTER TABLE `events`
  ADD CONSTRAINT `events_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `events_organizator_id_foreign` FOREIGN KEY (`organizator_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `events_ticket_design_id_foreign` FOREIGN KEY (`ticket_design_id`) REFERENCES `ticket_designs` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_timetable_id_foreign` FOREIGN KEY (`timetable_id`) REFERENCES `timetables` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `orders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `order_items_pricegroup_id_foreign` FOREIGN KEY (`pricegroup_id`) REFERENCES `pricegroups` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `order_items_section_id_foreign` FOREIGN KEY (`section_id`) REFERENCES `sections` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `order_items_ticket_id_foreign` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `order_items_timetable_id_foreign` FOREIGN KEY (`timetable_id`) REFERENCES `timetables` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `pricegroups`
--
ALTER TABLE `pricegroups`
  ADD CONSTRAINT `pricegroups_timetable_id_foreign` FOREIGN KEY (`timetable_id`) REFERENCES `timetables` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `seats`
--
ALTER TABLE `seats`
  ADD CONSTRAINT `seats_section_id_foreign` FOREIGN KEY (`section_id`) REFERENCES `sections` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `sections`
--
ALTER TABLE `sections`
  ADD CONSTRAINT `sections_venue_id_foreign` FOREIGN KEY (`venue_scheme_id`) REFERENCES `venue_schemes` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `tickets`
--
ALTER TABLE `tickets`
  ADD CONSTRAINT `tickets_ibfk_1` FOREIGN KEY (`seat_id`) REFERENCES `seats` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `tickets_pricegroup_id_foreign` FOREIGN KEY (`pricegroup_id`) REFERENCES `pricegroups` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `tickets_section_id_foreign` FOREIGN KEY (`section_id`) REFERENCES `sections` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `tickets_timetable_id_foreign` FOREIGN KEY (`timetable_id`) REFERENCES `timetables` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `timetables`
--
ALTER TABLE `timetables`
  ADD CONSTRAINT `timetables_event_id_foreign` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `timetables_venue_id_foreign` FOREIGN KEY (`venue_id`) REFERENCES `venues` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `timetables_venue_scheme_id_foreign` FOREIGN KEY (`venue_scheme_id`) REFERENCES `venue_schemes` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `venues`
--
ALTER TABLE `venues`
  ADD CONSTRAINT `venues_city_id_foreign` FOREIGN KEY (`city_id`) REFERENCES `cities` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `venue_schemes`
--
ALTER TABLE `venue_schemes`
  ADD CONSTRAINT `venue_schemes_ibfk_1` FOREIGN KEY (`venue_id`) REFERENCES `venues` (`id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
