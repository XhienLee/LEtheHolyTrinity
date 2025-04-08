-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 08, 2025 at 08:43 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cybersense`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `adminId` varchar(12) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`adminId`, `full_name`, `email`, `password`, `created_at`, `updated_at`) VALUES
('ADM001', 'Admin User', 'admin@usep.edu.ph', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('ADM002', 'System Admin', 'sysadmin@usep.edu.ph', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '2025-04-08 18:42:48', '2025-04-08 18:42:48');

-- --------------------------------------------------------

--
-- Table structure for table `analytics_reports`
--

CREATE TABLE `analytics_reports` (
  `reportId` varchar(20) NOT NULL,
  `report_type` enum('student_performance','module_effectiveness','quiz_statistics','system_usage') NOT NULL,
  `report_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`report_data`)),
  `generated_by` varchar(12) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `analytics_reports`
--

INSERT INTO `analytics_reports` (`reportId`, `report_type`, `report_data`, `generated_by`, `created_at`) VALUES
('RPT001', 'student_performance', '{\"average_score\": 82.5, \"completion_rate\": 87.3, \"student_count\": 5, \"period\": \"Feb-Mar 2025\"}', 'ADM001', '2025-04-08 18:42:48'),
('RPT002', 'module_effectiveness', '{\"module_id\": \"MOD001\", \"average_completion_time\": 4.2, \"average_quiz_score\": 80.0, \"student_feedback_rating\": 4.5}', 'INS001', '2025-04-08 18:42:48'),
('RPT003', 'quiz_statistics', '{\"quiz_id\": \"QZ001\", \"average_score\": 78.0, \"highest_score\": 90.0, \"lowest_score\": 60.0, \"attempt_count\": 5}', 'INS001', '2025-04-08 18:42:48'),
('RPT004', 'system_usage', '{\"active_users\": 15, \"average_session_duration\": 45.2, \"most_accessed_module\": \"MOD001\", \"peak_usage_time\": \"10:00-12:00\"}', 'ADM002', '2025-04-08 18:42:48'),
('RPT005', 'student_performance', '{\"student_id\": \"STU003\", \"modules_completed\": 3, \"average_score\": 87.2, \"login_frequency\": \"daily\"}', 'INS002', '2025-04-08 18:42:48');

-- --------------------------------------------------------

--
-- Table structure for table `answer_options`
--

CREATE TABLE `answer_options` (
  `optionId` varchar(12) NOT NULL,
  `questionId` varchar(12) NOT NULL,
  `option_text` text NOT NULL,
  `is_correct` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `answer_options`
--

INSERT INTO `answer_options` (`optionId`, `questionId`, `option_text`, `is_correct`, `created_at`, `updated_at`) VALUES
('OPT001', 'QST001', 'Confidentiality', 1, '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('OPT002', 'QST001', 'Certification', 0, '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('OPT003', 'QST001', 'Compliance', 0, '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('OPT004', 'QST001', 'Control', 0, '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('OPT005', 'QST003', 'To eliminate all risks', 0, '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('OPT006', 'QST003', 'To identify, assess, and prioritize risks', 1, '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('OPT007', 'QST003', 'To avoid all cybersecurity incidents', 0, '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('OPT008', 'QST003', 'To increase security budgets', 0, '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('OPT009', 'QST004', 'password123', 0, '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('OPT010', 'QST004', 'P@$$w0rd!2023', 1, '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('OPT011', 'QST004', 'qwerty', 0, '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('OPT012', 'QST004', 'MyName1990', 0, '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('OPT013', 'QST006', 'Breaking into computer systems', 0, '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('OPT014', 'QST006', 'An attempt to obtain sensitive information by disguising as a trustworthy entity', 1, '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('OPT015', 'QST006', 'A method to hack Wi-Fi networks', 0, '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('OPT016', 'QST006', 'A type of computer virus', 0, '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('OPT017', 'QST008', 'To accelerate internet speed', 0, '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('OPT018', 'QST008', 'To monitor and control incoming and outgoing network traffic', 1, '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('OPT019', 'QST008', 'To encrypt all network communications', 0, '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('OPT020', 'QST008', 'To detect hardware failures', 0, '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('OPT021', 'QST009', 'Global Data Privacy Regulation', 0, '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('OPT022', 'QST009', 'General Data Protection Regulation', 1, '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('OPT023', 'QST009', 'Government Data Processing Rules', 0, '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('OPT024', 'QST009', 'General Digital Privacy Rights', 0, '2025-04-08 18:42:48', '2025-04-08 18:42:48');

-- --------------------------------------------------------

--
-- Table structure for table `authentication_logs`
--

CREATE TABLE `authentication_logs` (
  `logId` varchar(20) NOT NULL,
  `user_type` enum('student','instructor','admin') NOT NULL,
  `user_id` varchar(12) NOT NULL,
  `action` enum('login','logout','failed_attempt','password_reset') NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `user_agent` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `authentication_logs`
--

INSERT INTO `authentication_logs` (`logId`, `user_type`, `user_id`, `action`, `ip_address`, `user_agent`, `created_at`) VALUES
('LOG001', 'admin', 'ADM001', 'login', '192.168.1.100', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36', '2025-04-08 18:42:48'),
('LOG002', 'instructor', 'INS001', 'login', '192.168.1.101', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7)', '2025-04-08 18:42:48'),
('LOG003', 'student', 'STU001', 'login', '192.168.1.102', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/94.0.4606.81', '2025-04-08 18:42:48'),
('LOG004', 'student', 'STU002', 'login', '192.168.1.103', 'Mozilla/5.0 (iPhone; CPU iPhone OS 15_0 like Mac OS X)', '2025-04-08 18:42:48'),
('LOG005', 'student', 'STU003', 'login', '192.168.1.104', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) Firefox/93.0', '2025-04-08 18:42:48'),
('LOG006', 'student', 'STU001', 'logout', '192.168.1.102', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/94.0.4606.81', '2025-04-08 18:42:48'),
('LOG007', 'student', 'STU004', 'failed_attempt', '192.168.1.105', 'Mozilla/5.0 (Android 12; Mobile)', '2025-04-08 18:42:48'),
('LOG008', 'student', 'STU004', 'login', '192.168.1.105', 'Mozilla/5.0 (Android 12; Mobile)', '2025-04-08 18:42:48'),
('LOG009', 'instructor', 'INS002', 'login', '192.168.1.106', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) Edge/95.0.1020.40', '2025-04-08 18:42:48'),
('LOG010', 'admin', 'ADM002', 'login', '192.168.1.107', 'Mozilla/5.0 (iPad; CPU OS 15_0 like Mac OS X)', '2025-04-08 18:42:48');

-- --------------------------------------------------------

--
-- Table structure for table `data_privacy_consent`
--

CREATE TABLE `data_privacy_consent` (
  `consentId` varchar(20) NOT NULL,
  `user_type` enum('student','instructor','admin') NOT NULL,
  `user_id` varchar(12) NOT NULL,
  `has_consented` tinyint(1) NOT NULL DEFAULT 0,
  `consent_date` timestamp NULL DEFAULT NULL,
  `consent_version` varchar(10) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `data_privacy_consent`
--

INSERT INTO `data_privacy_consent` (`consentId`, `user_type`, `user_id`, `has_consented`, `consent_date`, `consent_version`, `created_at`, `updated_at`) VALUES
('CNS001', 'student', 'STU001', 1, '2025-01-15 00:30:00', 'v1.2', '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('CNS002', 'student', 'STU002', 1, '2025-01-15 01:45:00', 'v1.2', '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('CNS003', 'student', 'STU003', 1, '2025-01-16 02:15:00', 'v1.2', '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('CNS004', 'student', 'STU004', 1, '2025-01-16 03:30:00', 'v1.2', '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('CNS005', 'student', 'STU005', 1, '2025-01-17 05:45:00', 'v1.2', '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('CNS006', 'instructor', 'INS001', 1, '2024-12-20 06:00:00', 'v1.1', '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('CNS007', 'instructor', 'INS002', 1, '2024-12-21 07:15:00', 'v1.1', '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('CNS008', 'instructor', 'INS003', 1, '2025-01-10 01:30:00', 'v1.2', '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('CNS009', 'admin', 'ADM001', 1, '2024-12-15 02:45:00', 'v1.1', '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('CNS010', 'admin', 'ADM002', 1, '2024-12-16 03:00:00', 'v1.1', '2025-04-08 18:42:48', '2025-04-08 18:42:48');

-- --------------------------------------------------------

--
-- Table structure for table `instructors`
--

CREATE TABLE `instructors` (
  `instructorId` varchar(12) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_by` varchar(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `instructors`
--

INSERT INTO `instructors` (`instructorId`, `full_name`, `email`, `password`, `created_at`, `updated_at`, `created_by`) VALUES
('INS001', 'Dr. James Wilson', 'jwilson@usep.edu.ph', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '2025-04-08 18:42:48', '2025-04-08 18:42:48', 'ADM001'),
('INS002', 'Prof. Maria Santos', 'msantos@usep.edu.ph', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '2025-04-08 18:42:48', '2025-04-08 18:42:48', 'ADM001'),
('INS003', 'Engr. Robert Cruz', 'rcruz@usep.edu.ph', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '2025-04-08 18:42:48', '2025-04-08 18:42:48', 'ADM002');

-- --------------------------------------------------------

--
-- Table structure for table `learning_modules`
--

CREATE TABLE `learning_modules` (
  `moduleId` varchar(12) NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `content_text` text DEFAULT NULL,
  `content_video_url` varchar(255) DEFAULT NULL,
  `content_pdf_path` varchar(255) DEFAULT NULL,
  `instructorId` varchar(12) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `learning_modules`
--

INSERT INTO `learning_modules` (`moduleId`, `title`, `description`, `content_text`, `content_video_url`, `content_pdf_path`, `instructorId`, `created_at`, `updated_at`) VALUES
('MOD001', 'Introduction to Cybersecurity', 'Basic concepts and principles of cybersecurity', 'This module covers the fundamental concepts of cybersecurity including CIA triad, threats, vulnerabilities, and risk management.', 'https://videos.usep.edu.ph/cyber/intro.mp4', '/pdfs/intro_cybersec.pdf', 'INS001', '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('MOD002', 'Password Security', 'Best practices for secure passwords', 'Learn how to create strong passwords, use password managers, and implement multi-factor authentication.', 'https://videos.usep.edu.ph/cyber/passwords.mp4', '/pdfs/password_security.pdf', 'INS001', '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('MOD003', 'Social Engineering Attacks', 'Understanding and preventing social engineering', 'This module explains various social engineering techniques and how to defend against them.', 'https://videos.usep.edu.ph/cyber/social.mp4', '/pdfs/social_engineering.pdf', 'INS002', '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('MOD004', 'Network Security Basics', 'Fundamentals of network security', 'Learn about network protocols, firewalls, IDS/IPS, and basic network defense techniques.', 'https://videos.usep.edu.ph/cyber/network.mp4', '/pdfs/network_security.pdf', 'INS003', '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('MOD005', 'Data Privacy Regulations', 'Overview of data privacy laws', 'This module covers relevant data privacy regulations including GDPR, Data Privacy Act, and compliance requirements.', 'https://videos.usep.edu.ph/cyber/privacy.mp4', '/pdfs/data_privacy.pdf', 'INS002', '2025-04-08 18:42:48', '2025-04-08 18:42:48');

-- --------------------------------------------------------

--
-- Table structure for table `module_enrollments`
--

CREATE TABLE `module_enrollments` (
  `enrollmentId` varchar(20) NOT NULL,
  `moduleId` varchar(12) NOT NULL,
  `studentId` varchar(12) NOT NULL,
  `enrollment_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` enum('active','completed','dropped','pending') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `module_enrollments`
--

INSERT INTO `module_enrollments` (`enrollmentId`, `moduleId`, `studentId`, `enrollment_date`, `status`, `created_at`, `updated_at`) VALUES
('ENR001', 'MOD001', 'STU001', '2025-02-01 00:30:00', 'completed', '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('ENR002', 'MOD002', 'STU001', '2025-02-10 01:15:00', 'active', '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('ENR003', 'MOD001', 'STU002', '2025-02-01 02:00:00', 'completed', '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('ENR004', 'MOD002', 'STU002', '2025-02-10 03:30:00', 'completed', '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('ENR005', 'MOD003', 'STU002', '2025-03-01 05:45:00', 'active', '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('ENR006', 'MOD001', 'STU003', '2025-02-01 01:00:00', 'completed', '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('ENR007', 'MOD002', 'STU003', '2025-02-10 02:15:00', 'completed', '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('ENR008', 'MOD003', 'STU003', '2025-03-01 06:30:00', 'completed', '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('ENR009', 'MOD004', 'STU003', '2025-03-15 07:45:00', 'active', '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('ENR010', 'MOD001', 'STU004', '2025-02-01 00:45:00', 'active', '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('ENR011', 'MOD005', 'STU005', '2025-03-20 08:00:00', 'pending', '2025-04-08 18:42:48', '2025-04-08 18:42:48');

-- --------------------------------------------------------

--
-- Table structure for table `progress_tracking`
--

CREATE TABLE `progress_tracking` (
  `progressId` varchar(20) NOT NULL,
  `studentId` varchar(12) NOT NULL,
  `moduleId` varchar(12) NOT NULL,
  `percentage_completed` decimal(5,2) NOT NULL DEFAULT 0.00,
  `last_accessed` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `progress_tracking`
--

INSERT INTO `progress_tracking` (`progressId`, `studentId`, `moduleId`, `percentage_completed`, `last_accessed`, `created_at`, `updated_at`) VALUES
('PRG001', 'STU001', 'MOD001', 100.00, '2025-02-09 06:30:00', '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('PRG002', 'STU001', 'MOD002', 75.00, '2025-04-01 01:15:00', '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('PRG003', 'STU002', 'MOD001', 100.00, '2025-02-09 07:45:00', '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('PRG004', 'STU002', 'MOD002', 100.00, '2025-02-18 03:00:00', '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('PRG005', 'STU002', 'MOD003', 85.00, '2025-04-02 05:30:00', '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('PRG006', 'STU003', 'MOD001', 100.00, '2025-02-10 01:30:00', '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('PRG007', 'STU003', 'MOD002', 100.00, '2025-02-20 05:30:00', '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('PRG008', 'STU003', 'MOD003', 100.00, '2025-03-08 02:00:00', '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('PRG009', 'STU003', 'MOD004', 40.00, '2025-04-03 06:45:00', '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('PRG010', 'STU004', 'MOD001', 85.00, '2025-04-01 02:00:00', '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('PRG011', 'STU005', 'MOD005', 0.00, '2025-03-20 08:00:00', '2025-04-08 18:42:48', '2025-04-08 18:42:48');

-- --------------------------------------------------------

--
-- Table structure for table `questions`
--

CREATE TABLE `questions` (
  `questionId` varchar(12) NOT NULL,
  `quizId` varchar(12) NOT NULL,
  `question_text` text NOT NULL,
  `question_type` enum('multiple_choice','true_false','short_answer') NOT NULL,
  `correct_answer` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `questions`
--

INSERT INTO `questions` (`questionId`, `quizId`, `question_text`, `question_type`, `correct_answer`, `created_at`, `updated_at`) VALUES
('QST001', 'QZ001', 'What does the \"C\" in CIA triad stand for?', 'multiple_choice', 'Confidentiality', '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('QST002', 'QZ001', 'A vulnerability is a weakness that can be exploited by threats.', 'true_false', 'true', '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('QST003', 'QZ001', 'What is the main goal of risk management?', 'multiple_choice', 'To identify, assess, and prioritize risks', '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('QST004', 'QZ002', 'Which of the following passwords is the strongest?', 'multiple_choice', 'P@$$w0rd!2023', '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('QST005', 'QZ002', 'Two-factor authentication uses two different passwords.', 'true_false', 'false', '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('QST006', 'QZ003', 'What is phishing?', 'multiple_choice', 'An attempt to obtain sensitive information by disguising as a trustworthy entity', '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('QST007', 'QZ003', 'Tailgating is a physical security attack.', 'true_false', 'true', '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('QST008', 'QZ004', 'What is the purpose of a firewall?', 'multiple_choice', 'To monitor and control incoming and outgoing network traffic', '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('QST009', 'QZ005', 'What does GDPR stand for?', 'multiple_choice', 'General Data Protection Regulation', '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('QST010', 'QZ005', 'The Data Privacy Act of 2012 is a Philippine law.', 'true_false', 'true', '2025-04-08 18:42:48', '2025-04-08 18:42:48');

-- --------------------------------------------------------

--
-- Table structure for table `quizzes`
--

CREATE TABLE `quizzes` (
  `quizId` varchar(12) NOT NULL,
  `moduleId` varchar(12) NOT NULL,
  `title` varchar(100) NOT NULL,
  `total_questions` int(11) NOT NULL DEFAULT 0,
  `passing_score` int(11) NOT NULL DEFAULT 70,
  `duration_minutes` int(11) DEFAULT 60,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `quizzes`
--

INSERT INTO `quizzes` (`quizId`, `moduleId`, `title`, `total_questions`, `passing_score`, `duration_minutes`, `created_at`, `updated_at`) VALUES
('QZ001', 'MOD001', 'Cybersecurity Fundamentals Quiz', 10, 70, 30, '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('QZ002', 'MOD002', 'Password Security Assessment', 8, 75, 20, '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('QZ003', 'MOD003', 'Social Engineering Test', 12, 80, 40, '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('QZ004', 'MOD004', 'Network Security Basics Quiz', 15, 70, 45, '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('QZ005', 'MOD005', 'Data Privacy Compliance Test', 10, 80, 30, '2025-04-08 18:42:48', '2025-04-08 18:42:48');

-- --------------------------------------------------------

--
-- Table structure for table `quiz_attempts`
--

CREATE TABLE `quiz_attempts` (
  `attemptId` varchar(20) NOT NULL,
  `quizId` varchar(12) NOT NULL,
  `studentId` varchar(12) NOT NULL,
  `score` decimal(5,2) NOT NULL DEFAULT 0.00,
  `attempt_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `completion_status` enum('in_progress','completed','abandoned') DEFAULT 'in_progress',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `quiz_attempts`
--

INSERT INTO `quiz_attempts` (`attemptId`, `quizId`, `studentId`, `score`, `attempt_date`, `completion_status`, `created_at`, `updated_at`) VALUES
('ATT001', 'QZ001', 'STU001', 90.00, '2025-02-09 06:30:00', 'completed', '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('ATT002', 'QZ001', 'STU002', 80.00, '2025-02-09 07:45:00', 'completed', '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('ATT003', 'QZ001', 'STU003', 70.00, '2025-02-10 01:30:00', 'completed', '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('ATT004', 'QZ002', 'STU001', 75.00, '2025-02-15 02:15:00', 'completed', '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('ATT005', 'QZ002', 'STU002', 87.50, '2025-02-18 03:00:00', 'completed', '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('ATT006', 'QZ002', 'STU003', 100.00, '2025-02-20 05:30:00', 'completed', '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('ATT007', 'QZ003', 'STU002', 66.67, '2025-03-05 06:45:00', 'completed', '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('ATT008', 'QZ003', 'STU003', 91.67, '2025-03-08 02:00:00', 'completed', '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('ATT009', 'QZ004', 'STU003', 0.00, '2025-03-20 03:15:00', 'in_progress', '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('ATT010', 'QZ001', 'STU004', 60.00, '2025-02-15 01:00:00', 'completed', '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('ATT011', 'QZ001', 'STU004', 80.00, '2025-02-18 02:30:00', 'completed', '2025-04-08 18:42:48', '2025-04-08 18:42:48');

-- --------------------------------------------------------

--
-- Table structure for table `quiz_attempt_answers`
--

CREATE TABLE `quiz_attempt_answers` (
  `answerRecordId` varchar(20) NOT NULL,
  `attemptId` varchar(20) NOT NULL,
  `questionId` varchar(12) NOT NULL,
  `student_answer` text DEFAULT NULL,
  `is_correct` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `quiz_attempt_answers`
--

INSERT INTO `quiz_attempt_answers` (`answerRecordId`, `attemptId`, `questionId`, `student_answer`, `is_correct`, `created_at`) VALUES
('ANS001', 'ATT001', 'QST001', 'Confidentiality', 1, '2025-04-08 18:42:48'),
('ANS002', 'ATT001', 'QST002', 'true', 1, '2025-04-08 18:42:48'),
('ANS003', 'ATT001', 'QST003', 'To identify, assess, and prioritize risks', 1, '2025-04-08 18:42:48'),
('ANS004', 'ATT002', 'QST001', 'Confidentiality', 1, '2025-04-08 18:42:48'),
('ANS005', 'ATT002', 'QST002', 'true', 1, '2025-04-08 18:42:48'),
('ANS006', 'ATT002', 'QST003', 'To eliminate all risks', 0, '2025-04-08 18:42:48'),
('ANS007', 'ATT003', 'QST001', 'Compliance', 0, '2025-04-08 18:42:48'),
('ANS008', 'ATT003', 'QST002', 'true', 1, '2025-04-08 18:42:48'),
('ANS009', 'ATT003', 'QST003', 'To identify, assess, and prioritize risks', 1, '2025-04-08 18:42:48'),
('ANS010', 'ATT004', 'QST004', 'P@$$w0rd!2023', 1, '2025-04-08 18:42:48'),
('ANS011', 'ATT004', 'QST005', 'true', 0, '2025-04-08 18:42:48'),
('ANS012', 'ATT005', 'QST004', 'P@$$w0rd!2023', 1, '2025-04-08 18:42:48'),
('ANS013', 'ATT005', 'QST005', 'false', 1, '2025-04-08 18:42:48');

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `studentId` varchar(12) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `enrollment_status` enum('active','inactive','suspended') DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_by` varchar(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`studentId`, `full_name`, `email`, `password`, `enrollment_status`, `created_at`, `updated_at`, `created_by`) VALUES
('STU001', 'Juan Dela Cruz', 'jdelacruz@usep.edu.ph', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'active', '2025-04-08 18:42:48', '2025-04-08 18:42:48', 'ADM001'),
('STU002', 'Maria Garcia', 'mgarcia@usep.edu.ph', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'active', '2025-04-08 18:42:48', '2025-04-08 18:42:48', 'ADM001'),
('STU003', 'Pedro Reyes', 'preyes@usep.edu.ph', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'active', '2025-04-08 18:42:48', '2025-04-08 18:42:48', 'ADM002'),
('STU004', 'Ana Macapagal', 'amacapagal@usep.edu.ph', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'active', '2025-04-08 18:42:48', '2025-04-08 18:42:48', 'ADM002'),
('STU005', 'Luis Bautista', 'lbautista@usep.edu.ph', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'inactive', '2025-04-08 18:42:48', '2025-04-08 18:42:48', 'ADM001');

-- --------------------------------------------------------

--
-- Table structure for table `user_activity_logs`
--

CREATE TABLE `user_activity_logs` (
  `activityLogId` varchar(20) NOT NULL,
  `user_type` enum('student','instructor','admin') NOT NULL,
  `user_id` varchar(12) NOT NULL,
  `activity_type` varchar(50) NOT NULL,
  `activity_details` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_activity_logs`
--

INSERT INTO `user_activity_logs` (`activityLogId`, `user_type`, `user_id`, `activity_type`, `activity_details`, `created_at`) VALUES
('ACT001', 'admin', 'ADM001', 'create_user', 'Created new instructor: INS003', '2025-04-08 18:42:48'),
('ACT002', 'instructor', 'INS001', 'create_module', 'Created new module: Introduction to Cybersecurity', '2025-04-08 18:42:48'),
('ACT003', 'instructor', 'INS001', 'create_quiz', 'Created new quiz: Cybersecurity Fundamentals Quiz', '2025-04-08 18:42:48'),
('ACT004', 'student', 'STU001', 'view_module', 'Viewed module: Introduction to Cybersecurity', '2025-04-08 18:42:48'),
('ACT005', 'student', 'STU001', 'complete_quiz', 'Completed quiz: Cybersecurity Fundamentals Quiz with score: 90', '2025-04-08 18:42:48'),
('ACT006', 'instructor', 'INS002', 'update_module', 'Updated module: Social Engineering Attacks', '2025-04-08 18:42:48'),
('ACT007', 'admin', 'ADM002', 'generate_report', 'Generated student performance report', '2025-04-08 18:42:48'),
('ACT008', 'student', 'STU003', 'download_material', 'Downloaded PDF: network_security.pdf', '2025-04-08 18:42:48'),
('ACT009', 'instructor', 'INS003', 'grade_quiz', 'Graded quiz attempt: ATT008', '2025-04-08 18:42:48'),
('ACT010', 'student', 'STU002', 'start_quiz', 'Started quiz: Social Engineering Test', '2025-04-08 18:42:48');

-- --------------------------------------------------------

--
-- Table structure for table `uve_integration`
--

CREATE TABLE `uve_integration` (
  `integrationId` varchar(20) NOT NULL,
  `studentId` varchar(12) NOT NULL,
  `uve_user_id` varchar(50) NOT NULL,
  `last_sync_date` timestamp NULL DEFAULT NULL,
  `grades_synced` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `uve_integration`
--

INSERT INTO `uve_integration` (`integrationId`, `studentId`, `uve_user_id`, `last_sync_date`, `grades_synced`, `created_at`, `updated_at`) VALUES
('UVE001', 'STU001', 'UVE_123456', '2025-03-01 01:00:00', 1, '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('UVE002', 'STU002', 'UVE_234567', '2025-03-01 01:15:00', 1, '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('UVE003', 'STU003', 'UVE_345678', '2025-03-01 01:30:00', 1, '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('UVE004', 'STU004', 'UVE_456789', '2025-03-01 01:45:00', 0, '2025-04-08 18:42:48', '2025-04-08 18:42:48'),
('UVE005', 'STU005', 'UVE_567890', '2025-03-01 02:00:00', 0, '2025-04-08 18:42:48', '2025-04-08 18:42:48');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`adminId`),
  ADD UNIQUE KEY `admin_email_unique` (`email`);

--
-- Indexes for table `analytics_reports`
--
ALTER TABLE `analytics_reports`
  ADD PRIMARY KEY (`reportId`),
  ADD KEY `report_generated_by_index` (`generated_by`);

--
-- Indexes for table `answer_options`
--
ALTER TABLE `answer_options`
  ADD PRIMARY KEY (`optionId`),
  ADD KEY `option_question_foreign` (`questionId`);

--
-- Indexes for table `authentication_logs`
--
ALTER TABLE `authentication_logs`
  ADD PRIMARY KEY (`logId`),
  ADD KEY `auth_user_id_index` (`user_id`);

--
-- Indexes for table `data_privacy_consent`
--
ALTER TABLE `data_privacy_consent`
  ADD PRIMARY KEY (`consentId`),
  ADD UNIQUE KEY `unique_user_consent` (`user_type`,`user_id`),
  ADD KEY `consent_user_id_index` (`user_id`);

--
-- Indexes for table `instructors`
--
ALTER TABLE `instructors`
  ADD PRIMARY KEY (`instructorId`),
  ADD UNIQUE KEY `instructor_email_unique` (`email`),
  ADD KEY `instructor_created_by_foreign` (`created_by`);

--
-- Indexes for table `learning_modules`
--
ALTER TABLE `learning_modules`
  ADD PRIMARY KEY (`moduleId`),
  ADD KEY `module_instructor_foreign` (`instructorId`);

--
-- Indexes for table `module_enrollments`
--
ALTER TABLE `module_enrollments`
  ADD PRIMARY KEY (`enrollmentId`),
  ADD UNIQUE KEY `unique_enrollment` (`moduleId`,`studentId`),
  ADD KEY `enrollment_module_foreign` (`moduleId`),
  ADD KEY `enrollment_student_foreign` (`studentId`);

--
-- Indexes for table `progress_tracking`
--
ALTER TABLE `progress_tracking`
  ADD PRIMARY KEY (`progressId`),
  ADD UNIQUE KEY `unique_progress` (`studentId`,`moduleId`),
  ADD KEY `progress_student_foreign` (`studentId`),
  ADD KEY `progress_module_foreign` (`moduleId`);

--
-- Indexes for table `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`questionId`),
  ADD KEY `question_quiz_foreign` (`quizId`);

--
-- Indexes for table `quizzes`
--
ALTER TABLE `quizzes`
  ADD PRIMARY KEY (`quizId`),
  ADD KEY `quiz_module_foreign` (`moduleId`);

--
-- Indexes for table `quiz_attempts`
--
ALTER TABLE `quiz_attempts`
  ADD PRIMARY KEY (`attemptId`),
  ADD KEY `attempt_quiz_foreign` (`quizId`),
  ADD KEY `attempt_student_foreign` (`studentId`);

--
-- Indexes for table `quiz_attempt_answers`
--
ALTER TABLE `quiz_attempt_answers`
  ADD PRIMARY KEY (`answerRecordId`),
  ADD KEY `answer_attempt_foreign` (`attemptId`),
  ADD KEY `answer_question_foreign` (`questionId`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`studentId`),
  ADD UNIQUE KEY `student_email_unique` (`email`),
  ADD KEY `student_created_by_foreign` (`created_by`);

--
-- Indexes for table `user_activity_logs`
--
ALTER TABLE `user_activity_logs`
  ADD PRIMARY KEY (`activityLogId`),
  ADD KEY `activity_user_id_index` (`user_id`);

--
-- Indexes for table `uve_integration`
--
ALTER TABLE `uve_integration`
  ADD PRIMARY KEY (`integrationId`),
  ADD UNIQUE KEY `unique_student_uve` (`studentId`,`uve_user_id`),
  ADD KEY `uve_student_foreign` (`studentId`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `answer_options`
--
ALTER TABLE `answer_options`
  ADD CONSTRAINT `option_question_foreign` FOREIGN KEY (`questionId`) REFERENCES `questions` (`questionId`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `instructors`
--
ALTER TABLE `instructors`
  ADD CONSTRAINT `instructor_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `admins` (`adminId`) ON UPDATE CASCADE;

--
-- Constraints for table `learning_modules`
--
ALTER TABLE `learning_modules`
  ADD CONSTRAINT `module_instructor_foreign` FOREIGN KEY (`instructorId`) REFERENCES `instructors` (`instructorId`) ON UPDATE CASCADE;

--
-- Constraints for table `module_enrollments`
--
ALTER TABLE `module_enrollments`
  ADD CONSTRAINT `enrollment_module_foreign` FOREIGN KEY (`moduleId`) REFERENCES `learning_modules` (`moduleId`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `enrollment_student_foreign` FOREIGN KEY (`studentId`) REFERENCES `students` (`studentId`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `progress_tracking`
--
ALTER TABLE `progress_tracking`
  ADD CONSTRAINT `progress_module_foreign` FOREIGN KEY (`moduleId`) REFERENCES `learning_modules` (`moduleId`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `progress_student_foreign` FOREIGN KEY (`studentId`) REFERENCES `students` (`studentId`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `questions`
--
ALTER TABLE `questions`
  ADD CONSTRAINT `question_quiz_foreign` FOREIGN KEY (`quizId`) REFERENCES `quizzes` (`quizId`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `quizzes`
--
ALTER TABLE `quizzes`
  ADD CONSTRAINT `quiz_module_foreign` FOREIGN KEY (`moduleId`) REFERENCES `learning_modules` (`moduleId`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `quiz_attempts`
--
ALTER TABLE `quiz_attempts`
  ADD CONSTRAINT `attempt_quiz_foreign` FOREIGN KEY (`quizId`) REFERENCES `quizzes` (`quizId`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `attempt_student_foreign` FOREIGN KEY (`studentId`) REFERENCES `students` (`studentId`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `quiz_attempt_answers`
--
ALTER TABLE `quiz_attempt_answers`
  ADD CONSTRAINT `answer_attempt_foreign` FOREIGN KEY (`attemptId`) REFERENCES `quiz_attempts` (`attemptId`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `answer_question_foreign` FOREIGN KEY (`questionId`) REFERENCES `questions` (`questionId`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `students`
--
ALTER TABLE `students`
  ADD CONSTRAINT `student_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `admins` (`adminId`) ON UPDATE CASCADE;

--
-- Constraints for table `uve_integration`
--
ALTER TABLE `uve_integration`
  ADD CONSTRAINT `uve_student_foreign` FOREIGN KEY (`studentId`) REFERENCES `students` (`studentId`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
