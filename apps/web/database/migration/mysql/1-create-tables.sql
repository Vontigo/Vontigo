-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: 179.61.199.11    Database: vontigo
-- ------------------------------------------------------
-- Server version	5.5.5-10.6.9-MariaDB

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
-- Table structure for table `actions`
--

DROP TABLE IF EXISTS `actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `actions` (
  `id` varchar(24) NOT NULL,
  `resource_id` varchar(24) DEFAULT NULL,
  `resource_type` varchar(50) NOT NULL,
  `actor_id` varchar(24) NOT NULL,
  `actor_type` varchar(50) NOT NULL,
  `event` varchar(50) NOT NULL,
  `context` text DEFAULT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actions`
--

LOCK TABLES `actions` WRITE;
/*!40000 ALTER TABLE `actions` DISABLE KEYS */;
/*!40000 ALTER TABLE `actions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `api_keys`
--

DROP TABLE IF EXISTS `api_keys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `api_keys` (
  `id` varchar(24) NOT NULL,
  `type` varchar(50) NOT NULL,
  `secret` varchar(191) NOT NULL,
  `role_id` varchar(24) DEFAULT NULL,
  `integration_id` varchar(24) DEFAULT NULL,
  `user_id` varchar(24) DEFAULT NULL,
  `last_seen_at` datetime DEFAULT NULL,
  `last_seen_version` varchar(50) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `created_by` varchar(24) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `api_keys`
--

LOCK TABLES `api_keys` WRITE;
/*!40000 ALTER TABLE `api_keys` DISABLE KEYS */;
/*!40000 ALTER TABLE `api_keys` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `benefits`
--

DROP TABLE IF EXISTS `benefits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `benefits` (
  `id` varchar(24) NOT NULL,
  `name` varchar(191) NOT NULL,
  `slug` varchar(191) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `benefits`
--

LOCK TABLES `benefits` WRITE;
/*!40000 ALTER TABLE `benefits` DISABLE KEYS */;
/*!40000 ALTER TABLE `benefits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `brute`
--

DROP TABLE IF EXISTS `brute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `brute` (
  `key` varchar(191) NOT NULL,
  `firstRequest` bigint(20) NOT NULL,
  `lastRequest` bigint(20) NOT NULL,
  `lifetime` bigint(20) NOT NULL,
  `count` int(11) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `brute`
--

LOCK TABLES `brute` WRITE;
/*!40000 ALTER TABLE `brute` DISABLE KEYS */;
/*!40000 ALTER TABLE `brute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment_likes`
--

DROP TABLE IF EXISTS `comment_likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment_likes` (
  `id` varchar(24) NOT NULL,
  `comment_id` varchar(24) NOT NULL,
  `member_id` varchar(24) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `comment_id` (`comment_id`),
  KEY `member_id` (`member_id`),
  CONSTRAINT `comment_likes_ibfk_1` FOREIGN KEY (`comment_id`) REFERENCES `comments` (`id`) ON DELETE CASCADE,
  CONSTRAINT `comment_likes_ibfk_2` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment_likes`
--

LOCK TABLES `comment_likes` WRITE;
/*!40000 ALTER TABLE `comment_likes` DISABLE KEYS */;
/*!40000 ALTER TABLE `comment_likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment_reports`
--

DROP TABLE IF EXISTS `comment_reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment_reports` (
  `id` varchar(24) NOT NULL,
  `comment_id` varchar(24) NOT NULL,
  `member_id` varchar(24) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `comment_id` (`comment_id`),
  KEY `member_id` (`member_id`),
  CONSTRAINT `comment_reports_ibfk_1` FOREIGN KEY (`comment_id`) REFERENCES `comments` (`id`) ON DELETE CASCADE,
  CONSTRAINT `comment_reports_ibfk_2` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment_reports`
--

LOCK TABLES `comment_reports` WRITE;
/*!40000 ALTER TABLE `comment_reports` DISABLE KEYS */;
/*!40000 ALTER TABLE `comment_reports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments` (
  `id` varchar(24) NOT NULL,
  `post_id` varchar(24) NOT NULL,
  `member_id` varchar(24) DEFAULT NULL,
  `parent_id` varchar(24) DEFAULT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'published',
  `html` text DEFAULT NULL,
  `edited_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `post_id` (`post_id`),
  KEY `member_id` (`member_id`),
  KEY `parent_id` (`parent_id`),
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE SET NULL,
  CONSTRAINT `comments_ibfk_3` FOREIGN KEY (`parent_id`) REFERENCES `comments` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `custom_theme_settings`
--

DROP TABLE IF EXISTS `custom_theme_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `custom_theme_settings` (
  `id` varchar(24) NOT NULL,
  `theme` varchar(191) NOT NULL,
  `key` varchar(191) NOT NULL,
  `type` varchar(50) NOT NULL,
  `value` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `custom_theme_settings`
--

LOCK TABLES `custom_theme_settings` WRITE;
/*!40000 ALTER TABLE `custom_theme_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `custom_theme_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_batches`
--

DROP TABLE IF EXISTS `email_batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_batches` (
  `id` varchar(24) NOT NULL,
  `email_id` varchar(24) NOT NULL,
  `provider_id` varchar(255) DEFAULT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'pending',
  `member_segment` text DEFAULT NULL,
  `error_status_code` int(11) DEFAULT NULL,
  `error_message` varchar(2000) DEFAULT NULL,
  `error_data` text DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `email_id` (`email_id`),
  CONSTRAINT `email_batches_ibfk_1` FOREIGN KEY (`email_id`) REFERENCES `emails` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_batches`
--

LOCK TABLES `email_batches` WRITE;
/*!40000 ALTER TABLE `email_batches` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_batches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_recipient_failures`
--

DROP TABLE IF EXISTS `email_recipient_failures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_recipient_failures` (
  `id` varchar(24) NOT NULL,
  `email_id` varchar(24) NOT NULL,
  `member_id` varchar(24) DEFAULT NULL,
  `email_recipient_id` varchar(24) NOT NULL,
  `code` int(11) NOT NULL,
  `enhanced_code` varchar(50) DEFAULT NULL,
  `message` varchar(2000) NOT NULL,
  `severity` varchar(50) NOT NULL DEFAULT 'permanent',
  `failed_at` datetime NOT NULL,
  `event_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `email_id` (`email_id`),
  KEY `email_recipient_id` (`email_recipient_id`),
  CONSTRAINT `email_recipient_failures_ibfk_1` FOREIGN KEY (`email_id`) REFERENCES `emails` (`id`),
  CONSTRAINT `email_recipient_failures_ibfk_2` FOREIGN KEY (`email_recipient_id`) REFERENCES `email_recipients` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_recipient_failures`
--

LOCK TABLES `email_recipient_failures` WRITE;
/*!40000 ALTER TABLE `email_recipient_failures` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_recipient_failures` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_recipients`
--

DROP TABLE IF EXISTS `email_recipients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_recipients` (
  `id` varchar(24) NOT NULL,
  `email_id` varchar(24) NOT NULL,
  `member_id` varchar(24) NOT NULL,
  `batch_id` varchar(24) NOT NULL,
  `processed_at` datetime DEFAULT NULL,
  `delivered_at` datetime DEFAULT NULL,
  `opened_at` datetime DEFAULT NULL,
  `failed_at` datetime DEFAULT NULL,
  `member_uuid` varchar(36) NOT NULL,
  `member_email` varchar(191) NOT NULL,
  `member_name` varchar(191) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `email_id` (`email_id`),
  KEY `batch_id` (`batch_id`),
  CONSTRAINT `email_recipients_ibfk_1` FOREIGN KEY (`email_id`) REFERENCES `emails` (`id`),
  CONSTRAINT `email_recipients_ibfk_2` FOREIGN KEY (`batch_id`) REFERENCES `email_batches` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_recipients`
--

LOCK TABLES `email_recipients` WRITE;
/*!40000 ALTER TABLE `email_recipients` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_recipients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_spam_complaint_events`
--

DROP TABLE IF EXISTS `email_spam_complaint_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_spam_complaint_events` (
  `id` varchar(24) NOT NULL,
  `member_id` varchar(24) NOT NULL,
  `email_id` varchar(24) NOT NULL,
  `email_address` varchar(191) NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `member_id` (`member_id`),
  KEY `email_id` (`email_id`),
  CONSTRAINT `email_spam_complaint_events_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE CASCADE,
  CONSTRAINT `email_spam_complaint_events_ibfk_2` FOREIGN KEY (`email_id`) REFERENCES `emails` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_spam_complaint_events`
--

LOCK TABLES `email_spam_complaint_events` WRITE;
/*!40000 ALTER TABLE `email_spam_complaint_events` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_spam_complaint_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emails`
--

DROP TABLE IF EXISTS `emails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `emails` (
  `id` varchar(24) NOT NULL,
  `post_id` varchar(24) NOT NULL,
  `uuid` varchar(36) NOT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'pending',
  `recipient_filter` text NOT NULL,
  `error` varchar(2000) DEFAULT NULL,
  `error_data` text DEFAULT NULL,
  `email_count` int(11) NOT NULL DEFAULT 0,
  `delivered_count` int(11) NOT NULL DEFAULT 0,
  `opened_count` int(11) NOT NULL DEFAULT 0,
  `failed_count` int(11) NOT NULL DEFAULT 0,
  `subject` varchar(300) DEFAULT NULL,
  `from` varchar(2000) DEFAULT NULL,
  `reply_to` varchar(2000) DEFAULT NULL,
  `html` text DEFAULT NULL,
  `plaintext` text DEFAULT NULL,
  `source` text DEFAULT NULL,
  `source_type` varchar(50) NOT NULL DEFAULT 'html',
  `track_opens` tinyint(1) NOT NULL DEFAULT 0,
  `track_clicks` tinyint(1) NOT NULL DEFAULT 0,
  `feedback_enabled` tinyint(1) NOT NULL DEFAULT 0,
  `submitted_at` datetime NOT NULL,
  `newsletter_id` varchar(24) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `created_by` varchar(24) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `newsletter_id` (`newsletter_id`),
  CONSTRAINT `emails_ibfk_1` FOREIGN KEY (`newsletter_id`) REFERENCES `newsletters` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emails`
--

LOCK TABLES `emails` WRITE;
/*!40000 ALTER TABLE `emails` DISABLE KEYS */;
/*!40000 ALTER TABLE `emails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `integrations`
--

DROP TABLE IF EXISTS `integrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `integrations` (
  `id` varchar(24) NOT NULL,
  `type` varchar(50) NOT NULL DEFAULT 'custom',
  `name` varchar(191) NOT NULL,
  `slug` varchar(191) NOT NULL,
  `icon_image` varchar(2000) DEFAULT NULL,
  `description` varchar(2000) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `created_by` varchar(24) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `integrations`
--

LOCK TABLES `integrations` WRITE;
/*!40000 ALTER TABLE `integrations` DISABLE KEYS */;
/*!40000 ALTER TABLE `integrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invites`
--

DROP TABLE IF EXISTS `invites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invites` (
  `id` varchar(24) NOT NULL,
  `role_id` varchar(24) NOT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'pending',
  `token` varchar(191) NOT NULL,
  `email` varchar(191) NOT NULL,
  `expires` bigint(20) NOT NULL,
  `created_at` datetime NOT NULL,
  `created_by` varchar(24) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invites`
--

LOCK TABLES `invites` WRITE;
/*!40000 ALTER TABLE `invites` DISABLE KEYS */;
/*!40000 ALTER TABLE `invites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobs` (
  `id` varchar(24) NOT NULL,
  `name` varchar(191) NOT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'queued',
  `started_at` datetime DEFAULT NULL,
  `finished_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `labels`
--

DROP TABLE IF EXISTS `labels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `labels` (
  `id` varchar(24) NOT NULL,
  `name` varchar(191) NOT NULL,
  `slug` varchar(191) NOT NULL,
  `created_at` datetime NOT NULL,
  `created_by` varchar(24) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `labels`
--

LOCK TABLES `labels` WRITE;
/*!40000 ALTER TABLE `labels` DISABLE KEYS */;
/*!40000 ALTER TABLE `labels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `members`
--

DROP TABLE IF EXISTS `members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `members` (
  `id` varchar(24) NOT NULL,
  `uuid` varchar(36) DEFAULT NULL,
  `email` varchar(191) NOT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'free',
  `name` varchar(191) DEFAULT NULL,
  `expertise` varchar(191) DEFAULT NULL,
  `note` varchar(2000) DEFAULT NULL,
  `geolocation` varchar(2000) DEFAULT NULL,
  `enable_comment_notifications` tinyint(1) NOT NULL DEFAULT 1,
  `email_count` int(11) NOT NULL DEFAULT 0,
  `email_opened_count` int(11) NOT NULL DEFAULT 0,
  `email_open_rate` int(11) DEFAULT NULL,
  `last_seen_at` datetime DEFAULT NULL,
  `last_commented_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `created_by` varchar(24) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `members`
--

LOCK TABLES `members` WRITE;
/*!40000 ALTER TABLE `members` DISABLE KEYS */;
/*!40000 ALTER TABLE `members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `members_cancel_events`
--

DROP TABLE IF EXISTS `members_cancel_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `members_cancel_events` (
  `id` varchar(24) NOT NULL,
  `member_id` varchar(24) NOT NULL,
  `from_plan` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `member_id` (`member_id`),
  CONSTRAINT `members_cancel_events_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `members_cancel_events`
--

LOCK TABLES `members_cancel_events` WRITE;
/*!40000 ALTER TABLE `members_cancel_events` DISABLE KEYS */;
/*!40000 ALTER TABLE `members_cancel_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `members_click_events`
--

DROP TABLE IF EXISTS `members_click_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `members_click_events` (
  `id` varchar(24) NOT NULL,
  `member_id` varchar(24) NOT NULL,
  `redirect_id` varchar(24) NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `member_id` (`member_id`),
  KEY `redirect_id` (`redirect_id`),
  CONSTRAINT `members_click_events_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE CASCADE,
  CONSTRAINT `members_click_events_ibfk_2` FOREIGN KEY (`redirect_id`) REFERENCES `redirects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `members_click_events`
--

LOCK TABLES `members_click_events` WRITE;
/*!40000 ALTER TABLE `members_click_events` DISABLE KEYS */;
/*!40000 ALTER TABLE `members_click_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `members_created_events`
--

DROP TABLE IF EXISTS `members_created_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `members_created_events` (
  `id` varchar(24) NOT NULL,
  `created_at` datetime NOT NULL,
  `member_id` varchar(24) NOT NULL,
  `attribution_id` varchar(24) DEFAULT NULL,
  `attribution_type` varchar(50) DEFAULT NULL,
  `attribution_url` varchar(2000) DEFAULT NULL,
  `referrer_source` varchar(191) DEFAULT NULL,
  `referrer_medium` varchar(191) DEFAULT NULL,
  `referrer_url` varchar(2000) DEFAULT NULL,
  `source` varchar(50) NOT NULL,
  `batch_id` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `member_id` (`member_id`),
  CONSTRAINT `members_created_events_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `members_created_events`
--

LOCK TABLES `members_created_events` WRITE;
/*!40000 ALTER TABLE `members_created_events` DISABLE KEYS */;
/*!40000 ALTER TABLE `members_created_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `members_email_change_events`
--

DROP TABLE IF EXISTS `members_email_change_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `members_email_change_events` (
  `id` varchar(24) NOT NULL,
  `member_id` varchar(24) NOT NULL,
  `to_email` varchar(191) NOT NULL,
  `from_email` varchar(191) NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `member_id` (`member_id`),
  CONSTRAINT `members_email_change_events_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `members_email_change_events`
--

LOCK TABLES `members_email_change_events` WRITE;
/*!40000 ALTER TABLE `members_email_change_events` DISABLE KEYS */;
/*!40000 ALTER TABLE `members_email_change_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `members_feedback`
--

DROP TABLE IF EXISTS `members_feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `members_feedback` (
  `id` varchar(24) NOT NULL,
  `score` int(11) NOT NULL DEFAULT 0,
  `member_id` varchar(24) NOT NULL,
  `post_id` varchar(24) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `member_id` (`member_id`),
  KEY `post_id` (`post_id`),
  CONSTRAINT `members_feedback_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE CASCADE,
  CONSTRAINT `members_feedback_ibfk_2` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `members_feedback`
--

LOCK TABLES `members_feedback` WRITE;
/*!40000 ALTER TABLE `members_feedback` DISABLE KEYS */;
/*!40000 ALTER TABLE `members_feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `members_labels`
--

DROP TABLE IF EXISTS `members_labels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `members_labels` (
  `id` varchar(24) NOT NULL,
  `member_id` varchar(24) NOT NULL,
  `label_id` varchar(24) NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `member_id` (`member_id`),
  KEY `label_id` (`label_id`),
  CONSTRAINT `members_labels_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE CASCADE,
  CONSTRAINT `members_labels_ibfk_2` FOREIGN KEY (`label_id`) REFERENCES `labels` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `members_labels`
--

LOCK TABLES `members_labels` WRITE;
/*!40000 ALTER TABLE `members_labels` DISABLE KEYS */;
/*!40000 ALTER TABLE `members_labels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `members_login_events`
--

DROP TABLE IF EXISTS `members_login_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `members_login_events` (
  `id` varchar(24) NOT NULL,
  `member_id` varchar(24) NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `member_id` (`member_id`),
  CONSTRAINT `members_login_events_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `members_login_events`
--

LOCK TABLES `members_login_events` WRITE;
/*!40000 ALTER TABLE `members_login_events` DISABLE KEYS */;
/*!40000 ALTER TABLE `members_login_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `members_newsletters`
--

DROP TABLE IF EXISTS `members_newsletters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `members_newsletters` (
  `id` varchar(24) NOT NULL,
  `member_id` varchar(24) NOT NULL,
  `newsletter_id` varchar(24) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `member_id` (`member_id`),
  KEY `newsletter_id` (`newsletter_id`),
  CONSTRAINT `members_newsletters_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE CASCADE,
  CONSTRAINT `members_newsletters_ibfk_2` FOREIGN KEY (`newsletter_id`) REFERENCES `newsletters` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `members_newsletters`
--

LOCK TABLES `members_newsletters` WRITE;
/*!40000 ALTER TABLE `members_newsletters` DISABLE KEYS */;
/*!40000 ALTER TABLE `members_newsletters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `members_paid_subscription_events`
--

DROP TABLE IF EXISTS `members_paid_subscription_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `members_paid_subscription_events` (
  `id` varchar(24) NOT NULL,
  `type` varchar(50) DEFAULT NULL,
  `member_id` varchar(24) NOT NULL,
  `subscription_id` varchar(24) DEFAULT NULL,
  `from_plan` varchar(255) DEFAULT NULL,
  `to_plan` varchar(255) DEFAULT NULL,
  `currency` varchar(191) NOT NULL,
  `source` varchar(50) NOT NULL,
  `mrr_delta` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `member_id` (`member_id`),
  CONSTRAINT `members_paid_subscription_events_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `members_paid_subscription_events`
--

LOCK TABLES `members_paid_subscription_events` WRITE;
/*!40000 ALTER TABLE `members_paid_subscription_events` DISABLE KEYS */;
/*!40000 ALTER TABLE `members_paid_subscription_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `members_payment_events`
--

DROP TABLE IF EXISTS `members_payment_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `members_payment_events` (
  `id` varchar(24) NOT NULL,
  `member_id` varchar(24) NOT NULL,
  `amount` int(11) NOT NULL,
  `currency` varchar(191) NOT NULL,
  `source` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `member_id` (`member_id`),
  CONSTRAINT `members_payment_events_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `members_payment_events`
--

LOCK TABLES `members_payment_events` WRITE;
/*!40000 ALTER TABLE `members_payment_events` DISABLE KEYS */;
/*!40000 ALTER TABLE `members_payment_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `members_product_events`
--

DROP TABLE IF EXISTS `members_product_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `members_product_events` (
  `id` varchar(24) NOT NULL,
  `member_id` varchar(24) NOT NULL,
  `product_id` varchar(24) NOT NULL,
  `action` varchar(50) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `member_id` (`member_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `members_product_events_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE CASCADE,
  CONSTRAINT `members_product_events_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `members_product_events`
--

LOCK TABLES `members_product_events` WRITE;
/*!40000 ALTER TABLE `members_product_events` DISABLE KEYS */;
/*!40000 ALTER TABLE `members_product_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `members_products`
--

DROP TABLE IF EXISTS `members_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `members_products` (
  `id` varchar(24) NOT NULL,
  `member_id` varchar(24) NOT NULL,
  `product_id` varchar(24) NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `expiry_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `member_id` (`member_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `members_products_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE CASCADE,
  CONSTRAINT `members_products_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `members_products`
--

LOCK TABLES `members_products` WRITE;
/*!40000 ALTER TABLE `members_products` DISABLE KEYS */;
/*!40000 ALTER TABLE `members_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `members_status_events`
--

DROP TABLE IF EXISTS `members_status_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `members_status_events` (
  `id` varchar(24) NOT NULL,
  `member_id` varchar(24) NOT NULL,
  `from_status` varchar(50) DEFAULT NULL,
  `to_status` varchar(50) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `member_id` (`member_id`),
  CONSTRAINT `members_status_events_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `members_status_events`
--

LOCK TABLES `members_status_events` WRITE;
/*!40000 ALTER TABLE `members_status_events` DISABLE KEYS */;
/*!40000 ALTER TABLE `members_status_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `members_stripe_customers`
--

DROP TABLE IF EXISTS `members_stripe_customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `members_stripe_customers` (
  `id` varchar(24) NOT NULL,
  `member_id` varchar(24) NOT NULL,
  `customer_id` varchar(255) NOT NULL,
  `name` varchar(191) DEFAULT NULL,
  `email` varchar(191) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `created_by` varchar(24) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `member_id` (`member_id`),
  CONSTRAINT `members_stripe_customers_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `members_stripe_customers`
--

LOCK TABLES `members_stripe_customers` WRITE;
/*!40000 ALTER TABLE `members_stripe_customers` DISABLE KEYS */;
/*!40000 ALTER TABLE `members_stripe_customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `members_subscribe_events`
--

DROP TABLE IF EXISTS `members_subscribe_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `members_subscribe_events` (
  `id` varchar(24) NOT NULL,
  `member_id` varchar(24) NOT NULL,
  `subscribed` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL,
  `source` varchar(50) DEFAULT NULL,
  `newsletter_id` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `member_id` (`member_id`),
  KEY `newsletter_id` (`newsletter_id`),
  CONSTRAINT `members_subscribe_events_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE CASCADE,
  CONSTRAINT `members_subscribe_events_ibfk_2` FOREIGN KEY (`newsletter_id`) REFERENCES `newsletters` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `members_subscribe_events`
--

LOCK TABLES `members_subscribe_events` WRITE;
/*!40000 ALTER TABLE `members_subscribe_events` DISABLE KEYS */;
/*!40000 ALTER TABLE `members_subscribe_events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mentions`
--

DROP TABLE IF EXISTS `mentions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mentions` (
  `id` varchar(24) NOT NULL,
  `source` varchar(2000) NOT NULL,
  `source_title` varchar(2000) DEFAULT NULL,
  `source_site_title` varchar(2000) DEFAULT NULL,
  `source_excerpt` varchar(2000) DEFAULT NULL,
  `source_author` varchar(2000) DEFAULT NULL,
  `source_featured_image` varchar(2000) DEFAULT NULL,
  `source_favicon` varchar(2000) DEFAULT NULL,
  `target` varchar(2000) NOT NULL,
  `resource_id` varchar(24) DEFAULT NULL,
  `resource_type` varchar(50) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `payload` text DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `verified` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mentions`
--

LOCK TABLES `mentions` WRITE;
/*!40000 ALTER TABLE `mentions` DISABLE KEYS */;
/*!40000 ALTER TABLE `mentions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations_lock`
--

DROP TABLE IF EXISTS `migrations_lock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations_lock` (
  `lock_key` varchar(191) NOT NULL,
  `locked` tinyint(1) DEFAULT 0,
  `acquired_at` datetime DEFAULT NULL,
  `released_at` datetime DEFAULT NULL,
  PRIMARY KEY (`lock_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations_lock`
--

LOCK TABLES `migrations_lock` WRITE;
/*!40000 ALTER TABLE `migrations_lock` DISABLE KEYS */;
/*!40000 ALTER TABLE `migrations_lock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `milestones`
--

DROP TABLE IF EXISTS `milestones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `milestones` (
  `id` varchar(24) NOT NULL,
  `type` varchar(24) NOT NULL,
  `value` int(11) NOT NULL,
  `currency` varchar(24) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `email_sent_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `milestones`
--

LOCK TABLES `milestones` WRITE;
/*!40000 ALTER TABLE `milestones` DISABLE KEYS */;
/*!40000 ALTER TABLE `milestones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mobiledoc_revisions`
--

DROP TABLE IF EXISTS `mobiledoc_revisions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mobiledoc_revisions` (
  `id` varchar(24) NOT NULL,
  `post_id` varchar(24) NOT NULL,
  `mobiledoc` text DEFAULT NULL,
  `created_at_ts` bigint(20) NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mobiledoc_revisions`
--

LOCK TABLES `mobiledoc_revisions` WRITE;
/*!40000 ALTER TABLE `mobiledoc_revisions` DISABLE KEYS */;
/*!40000 ALTER TABLE `mobiledoc_revisions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `newsletters`
--

DROP TABLE IF EXISTS `newsletters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `newsletters` (
  `id` varchar(24) NOT NULL,
  `uuid` varchar(36) NOT NULL,
  `name` varchar(191) NOT NULL,
  `description` varchar(2000) DEFAULT NULL,
  `feedback_enabled` tinyint(1) NOT NULL DEFAULT 0,
  `slug` varchar(191) NOT NULL,
  `sender_name` varchar(191) DEFAULT NULL,
  `sender_email` varchar(191) DEFAULT NULL,
  `sender_reply_to` varchar(191) NOT NULL DEFAULT 'newsletter',
  `status` varchar(50) NOT NULL DEFAULT 'active',
  `visibility` varchar(50) NOT NULL DEFAULT 'members',
  `subscribe_on_signup` tinyint(1) NOT NULL DEFAULT 1,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `header_image` varchar(2000) DEFAULT NULL,
  `show_header_icon` tinyint(1) NOT NULL DEFAULT 1,
  `show_header_title` tinyint(1) NOT NULL DEFAULT 1,
  `title_font_category` varchar(191) NOT NULL DEFAULT 'sans_serif',
  `title_alignment` varchar(191) NOT NULL DEFAULT 'center',
  `show_feature_image` tinyint(1) NOT NULL DEFAULT 1,
  `body_font_category` varchar(191) NOT NULL DEFAULT 'sans_serif',
  `footer_content` text DEFAULT NULL,
  `show_badge` tinyint(1) NOT NULL DEFAULT 1,
  `show_header_name` tinyint(1) NOT NULL DEFAULT 1,
  `show_post_title_section` tinyint(1) NOT NULL DEFAULT 1,
  `show_comment_cta` tinyint(1) NOT NULL DEFAULT 1,
  `show_subscription_details` tinyint(1) NOT NULL DEFAULT 0,
  `show_latest_posts` tinyint(1) NOT NULL DEFAULT 0,
  `background_color` varchar(50) NOT NULL DEFAULT 'light',
  `border_color` varchar(50) DEFAULT NULL,
  `title_color` varchar(50) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `newsletters`
--

LOCK TABLES `newsletters` WRITE;
/*!40000 ALTER TABLE `newsletters` DISABLE KEYS */;
/*!40000 ALTER TABLE `newsletters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offers`
--

DROP TABLE IF EXISTS `offers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `offers` (
  `id` varchar(24) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `name` varchar(191) NOT NULL,
  `code` varchar(191) NOT NULL,
  `product_id` varchar(24) NOT NULL,
  `stripe_coupon_id` varchar(255) DEFAULT NULL,
  `interval` varchar(50) NOT NULL,
  `currency` varchar(50) DEFAULT NULL,
  `discount_type` varchar(50) NOT NULL,
  `discount_amount` int(11) NOT NULL,
  `duration` varchar(50) NOT NULL,
  `duration_in_months` int(11) DEFAULT NULL,
  `portal_title` varchar(191) DEFAULT NULL,
  `portal_description` varchar(2000) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `offers_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offers`
--

LOCK TABLES `offers` WRITE;
/*!40000 ALTER TABLE `offers` DISABLE KEYS */;
/*!40000 ALTER TABLE `offers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permissions` (
  `id` varchar(24) NOT NULL,
  `name` varchar(50) NOT NULL,
  `object_type` varchar(50) NOT NULL,
  `action_type` varchar(50) NOT NULL,
  `object_id` varchar(24) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `created_by` varchar(24) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions_roles`
--

DROP TABLE IF EXISTS `permissions_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permissions_roles` (
  `id` varchar(24) NOT NULL,
  `role_id` varchar(24) NOT NULL,
  `permission_id` varchar(24) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions_roles`
--

LOCK TABLES `permissions_roles` WRITE;
/*!40000 ALTER TABLE `permissions_roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `permissions_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions_users`
--

DROP TABLE IF EXISTS `permissions_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permissions_users` (
  `id` varchar(24) NOT NULL,
  `user_id` varchar(24) NOT NULL,
  `permission_id` varchar(24) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions_users`
--

LOCK TABLES `permissions_users` WRITE;
/*!40000 ALTER TABLE `permissions_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `permissions_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_revisions`
--

DROP TABLE IF EXISTS `post_revisions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post_revisions` (
  `id` varchar(24) NOT NULL,
  `post_id` varchar(24) NOT NULL,
  `lexical` text DEFAULT NULL,
  `created_at_ts` bigint(20) NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_revisions`
--

LOCK TABLES `post_revisions` WRITE;
/*!40000 ALTER TABLE `post_revisions` DISABLE KEYS */;
/*!40000 ALTER TABLE `post_revisions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posts` (
  `id` varchar(24) NOT NULL,
  `uuid` varchar(36) NOT NULL,
  `title` varchar(2000) NOT NULL,
  `slug` varchar(191) NOT NULL,
  `mobiledoc` text DEFAULT NULL,
  `lexical` text DEFAULT NULL,
  `html` text DEFAULT NULL,
  `comment_id` varchar(50) DEFAULT NULL,
  `plaintext` text DEFAULT NULL,
  `feature_image` varchar(2000) DEFAULT NULL,
  `featured` tinyint(1) NOT NULL DEFAULT 0,
  `type` varchar(50) NOT NULL DEFAULT 'post',
  `status` varchar(50) NOT NULL DEFAULT 'draft',
  `locale` varchar(6) DEFAULT NULL,
  `visibility` varchar(50) NOT NULL DEFAULT 'public',
  `email_recipient_filter` text NOT NULL,
  `created_at` datetime NOT NULL,
  `created_by` varchar(24) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(24) DEFAULT NULL,
  `published_at` datetime DEFAULT NULL,
  `published_by` varchar(24) DEFAULT NULL,
  `custom_excerpt` varchar(2000) DEFAULT NULL,
  `codeinjection_head` text DEFAULT NULL,
  `codeinjection_foot` text DEFAULT NULL,
  `custom_template` varchar(100) DEFAULT NULL,
  `canonical_url` text DEFAULT NULL,
  `newsletter_id` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `newsletter_id` (`newsletter_id`),
  CONSTRAINT `posts_ibfk_1` FOREIGN KEY (`newsletter_id`) REFERENCES `newsletters` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES ('643c3269002137342cf323a7','e152566d-4077-4747-b6e4-eaf0a9bbfbd2','Coming soon','coming-soon','{\"type\":\"doc\",\"content\":[{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"This is Vontigo Demo Site, a brand-new site by a Vontigoers that\'s just getting started. Things will be up and running here shortly, but you can subscribe in the meantime if you\'d like to stay up to date and receive emails when new content is published!\"}]},{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"Or you can create another site using Vontigo CMS via https://vontigo.org.\"}]}]}',NULL,'<p>This is Vontigo Demo Site, a brand-new site by a Vontigoers that\'s just getting started. Things will be up and running here shortly, but you can subscribe in the meantime if you\'d like to stay up to date and receive emails when new content is published!</p><p>Or you can create another site using Vontigo CMS via https://vontigo.org.</p>','643c3269002137342cf323a7','This is Vontigo Demo Site, a brand-new site by a Vontigoers that\'s just getting started. Things will be up and running here shortly, but you can subscribe in the meantime if you\'d like to stay up to date and receive emails when new content is published!\n\nOr you can create another site using Vontigo CMS via https://vontigo.org.','/content/en-us/images/size/_raw/2023/05/643c3269002137342cf323a7_3d-render-futuristic-modern-network-communications-design.jpg',1,'post','published','en-us','public','all','2023-04-16 17:37:45','1','2023-04-16 17:42:16','643c3269002137342cf323a7','2023-04-16 17:37:45','1','We\'ve crammed the most important information to help you get started with Vontigo into this one post. It\'s your cheat-sheet to get started, and your shortcut to advanced features.',NULL,NULL,'',NULL,NULL),('643c326e002137342cf323a9','118e29cd-b606-4467-b668-1f8471869469','About this site !','about-us','{\"type\":\"doc\",\"content\":[{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"Hello world!\"}]}]}',NULL,'<p>Hello world!</p>','643c326e002137342cf323a9','Hello world!','https://static.ghost.org/v4.0.0/images/feature-image.jpg',0,'page','published','en-us','public','all','2023-04-16 17:37:50','1','2023-04-16 17:42:16','643c326e002137342cf323a9','2023-04-16 17:37:46','1','sadfasdfasdfas',NULL,NULL,NULL,NULL,NULL),('645cf2a06c7c7c2738978099','f7cbe440-b793-4554-a689-236b3a51442e','The next of future Content Management System Powered by AI.','the-next-of-future-content-management-system-powered-by-ai','{\"type\":\"doc\",\"content\":[{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"The new generation of CMS powered by AI is revolutionizing the way we create and manage content. With the help of artificial intelligence, CMS platforms are becoming more intelligent, intuitive, and efficient than ever before.\"}]},{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"One of the key benefits of AI-powered CMS is the ability to automate repetitive tasks, such as content creation, curation, and optimization. This frees up time for content creators to focus on more strategic tasks, such as developing new ideas and engaging with their audience.\"}]},{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"Another advantage of AI-powered CMS is the ability to personalize content for individual users. By analyzing user data, AI algorithms can deliver personalized content recommendations, tailored to each user\'s interests and preferences. This not only improves the user experience but also increases engagement and conversions.\"}]},{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"AI-powered CMS also offers advanced analytics and reporting capabilities, allowing content creators to track and analyze the performance of their content in real-time. This data can be used to optimize content for better engagement and conversions, as well as to identify new opportunities for growth and expansion.\"}]},{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"Overall, the new generation of CMS powered by AI is transforming the way we create, manage, and optimize content. By automating repetitive tasks, personalizing content, and providing advanced analytics, AI-powered CMS platforms are helping content creators to work smarter, not harder. As AI technology continues to evolve, we can expect to see even more innovative features and capabilities in the future. \"}]},{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"center\"},\"content\":[{\"type\":\"text\",\"marks\":[{\"type\":\"italic\"}],\"text\":\"\\\"The stuff shown above is solely for demonstration purposes. To receive the authentic ChatGPT content, please enter your OpenAI key in Settings > BrainiacMinds > Aim Key area!\\\" \"}]}]}',NULL,'<p>The new generation of CMS powered by AI is revolutionizing the way we create and manage content. With the help of artificial intelligence, CMS platforms are becoming more intelligent, intuitive, and efficient than ever before.</p><p>One of the key benefits of AI-powered CMS is the ability to automate repetitive tasks, such as content creation, curation, and optimization. This frees up time for content creators to focus on more strategic tasks, such as developing new ideas and engaging with their audience.</p><p>Another advantage of AI-powered CMS is the ability to personalize content for individual users. By analyzing user data, AI algorithms can deliver personalized content recommendations, tailored to each user\'s interests and preferences. This not only improves the user experience but also increases engagement and conversions.</p><p>AI-powered CMS also offers advanced analytics and reporting capabilities, allowing content creators to track and analyze the performance of their content in real-time. This data can be used to optimize content for better engagement and conversions, as well as to identify new opportunities for growth and expansion.</p><p>Overall, the new generation of CMS powered by AI is transforming the way we create, manage, and optimize content. By automating repetitive tasks, personalizing content, and providing advanced analytics, AI-powered CMS platforms are helping content creators to work smarter, not harder. As AI technology continues to evolve, we can expect to see even more innovative features and capabilities in the future. </p><p style=\"text-align: center\"><em>\"The stuff shown above is solely for demonstration purposes. To receive the authentic ChatGPT content, please enter your OpenAI key in Settings &gt; BrainiacMinds &gt; Aim Key area!\" </em></p>','645cf2a06c7c7c273897809a','The new generation of CMS powered by AI is revolutionizing the way we create and manage content. With the help of artificial intelligence, CMS platforms are becoming more intelligent, intuitive, and efficient than ever before.\n\nOne of the key benefits of AI-powered CMS is the ability to automate repetitive tasks, such as content creation, curation, and optimization. This frees up time for content creators to focus on more strategic tasks, such as developing new ideas and engaging with their audience.\n\nAnother advantage of AI-powered CMS is the ability to personalize content for individual users. By analyzing user data, AI algorithms can deliver personalized content recommendations, tailored to each user\'s interests and preferences. This not only improves the user experience but also increases engagement and conversions.\n\nAI-powered CMS also offers advanced analytics and reporting capabilities, allowing content creators to track and analyze the performance of their content in real-time. This data can be used to optimize content for better engagement and conversions, as well as to identify new opportunities for growth and expansion.\n\nOverall, the new generation of CMS powered by AI is transforming the way we create, manage, and optimize content. By automating repetitive tasks, personalizing content, and providing advanced analytics, AI-powered CMS platforms are helping content creators to work smarter, not harder. As AI technology continues to evolve, we can expect to see even more innovative features and capabilities in the future. \n\n\"The stuff shown above is solely for demonstration purposes. To receive the authentic ChatGPT content, please enter your OpenAI key in Settings > BrainiacMinds > Aim Key area!\" ','/content/en-us/images/size/_raw/2023/05/645cf2a06c7c7c2738978099_feature-image.png',1,'post','published','en-us','public','all','2023-05-11 13:50:00','1','2023-05-11 13:50:00','1','2023-05-12 13:55:00','1','The new generation of CMS powered by AI is revolutionizing the way we create and manage content. With the help of artificial intelligence, CMS platforms are becoming more intelligent, intuitive, and efficient than ever before.',NULL,NULL,NULL,NULL,NULL),('645cf4656c7c7c273897809b','04cdfef5-740a-432a-8407-f55075022443','A.I. is revolutionizing the world in various industries, including CMS','ai-is-revolutionizing-the-world-in-various-industries-including-cms-1','{\"type\":\"doc\",\"content\":[{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"Artificial Intelligence (AI) is revolutionizing the world in various industries, including content management systems (CMS). AI has the power to analyze large amounts of data and make predictions, allowing businesses to make data-driven decisions. In this article, we will explore the benefits of AI with CMS and how it can improve your content creation and management.\"}]},{\"type\":\"heading\",\"attrs\":{\"textAlign\":\"left\",\"level\":2},\"content\":[{\"type\":\"text\",\"text\":\"Personalization\"}]},{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"AI-powered CMS can personalize content to individual users. AI algorithms can analyze user data, such as browsing behavior and previous interactions, to create a personalized experience for each user. Personalization can improve engagement and increase user satisfaction, leading to higher conversion rates and sales.\"}]},{\"type\":\"heading\",\"attrs\":{\"textAlign\":\"left\",\"level\":2},\"content\":[{\"type\":\"text\",\"text\":\"Improved Search\"}]},{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"AI algorithms can improve search capabilities within CMS by analyzing user search queries and providing relevant results. This can enhance user experience and reduce bounce rates.\"}]},{\"type\":\"heading\",\"attrs\":{\"textAlign\":\"left\",\"level\":2},\"content\":[{\"type\":\"text\",\"text\":\"Content Creation\"}]},{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"AI can help in creating content by generating ideas, identifying trending topics, and even writing content. AI algorithms can analyze user behavior and content trends to generate content ideas that are more likely to engage and resonate with the target audience.\"}]},{\"type\":\"heading\",\"attrs\":{\"textAlign\":\"left\",\"level\":2},\"content\":[{\"type\":\"text\",\"text\":\"Content Optimization\"}]},{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"AI-powered CMS can analyze content and provide recommendations for optimization. This includes identifying keywords, improving readability, and enhancing the overall structure and flow of the content. AI can also analyze user behavior to determine which content performs best and provide insights for future content creation.\"}]},{\"type\":\"heading\",\"attrs\":{\"textAlign\":\"left\",\"level\":2},\"content\":[{\"type\":\"text\",\"text\":\"Predictive Analytics\"}]},{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"AI algorithms can analyze data to predict future trends and behavior. This can help businesses make data-driven decisions and improve their content strategies. Predictive analytics can also help in identifying potential issues or opportunities, allowing businesses to make proactive changes.\"}]},{\"type\":\"heading\",\"attrs\":{\"textAlign\":\"left\",\"level\":2},\"content\":[{\"type\":\"text\",\"text\":\"Chatbots\"}]},{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"AI-powered chatbots can provide a personalized and responsive customer service experience. Chatbots can answer customer queries, provide information, and even handle basic transactions, freeing up customer service representatives to handle more complex issues.\"}]},{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"In conclusion, AI with CMS can provide numerous benefits for businesses looking to improve their content creation and management. From personalization to predictive analytics, AI can help businesses make data-driven decisions and improve user engagement. As AI technology continues to evolve, businesses can expect even more advanced capabilities and benefits from AI-powered CMS.\"}]}]}',NULL,'<p>Artificial Intelligence (AI) is revolutionizing the world in various industries, including content management systems (CMS). AI has the power to analyze large amounts of data and make predictions, allowing businesses to make data-driven decisions. In this article, we will explore the benefits of AI with CMS and how it can improve your content creation and management.</p><h2>Personalization</h2><p>AI-powered CMS can personalize content to individual users. AI algorithms can analyze user data, such as browsing behavior and previous interactions, to create a personalized experience for each user. Personalization can improve engagement and increase user satisfaction, leading to higher conversion rates and sales.</p><h2>Improved Search</h2><p>AI algorithms can improve search capabilities within CMS by analyzing user search queries and providing relevant results. This can enhance user experience and reduce bounce rates.</p><h2>Content Creation</h2><p>AI can help in creating content by generating ideas, identifying trending topics, and even writing content. AI algorithms can analyze user behavior and content trends to generate content ideas that are more likely to engage and resonate with the target audience.</p><h2>Content Optimization</h2><p>AI-powered CMS can analyze content and provide recommendations for optimization. This includes identifying keywords, improving readability, and enhancing the overall structure and flow of the content. AI can also analyze user behavior to determine which content performs best and provide insights for future content creation.</p><h2>Predictive Analytics</h2><p>AI algorithms can analyze data to predict future trends and behavior. This can help businesses make data-driven decisions and improve their content strategies. Predictive analytics can also help in identifying potential issues or opportunities, allowing businesses to make proactive changes.</p><h2>Chatbots</h2><p>AI-powered chatbots can provide a personalized and responsive customer service experience. Chatbots can answer customer queries, provide information, and even handle basic transactions, freeing up customer service representatives to handle more complex issues.</p><p>In conclusion, AI with CMS can provide numerous benefits for businesses looking to improve their content creation and management. From personalization to predictive analytics, AI can help businesses make data-driven decisions and improve user engagement. As AI technology continues to evolve, businesses can expect even more advanced capabilities and benefits from AI-powered CMS.</p>','645cf4656c7c7c273897809c','Artificial Intelligence (AI) is revolutionizing the world in various industries, including content management systems (CMS). AI has the power to analyze large amounts of data and make predictions, allowing businesses to make data-driven decisions. In this article, we will explore the benefits of AI with CMS and how it can improve your content creation and management.\n\nPersonalization\n\nAI-powered CMS can personalize content to individual users. AI algorithms can analyze user data, such as browsing behavior and previous interactions, to create a personalized experience for each user. Personalization can improve engagement and increase user satisfaction, leading to higher conversion rates and sales.\n\nImproved Search\n\nAI algorithms can improve search capabilities within CMS by analyzing user search queries and providing relevant results. This can enhance user experience and reduce bounce rates.\n\nContent Creation\n\nAI can help in creating content by generating ideas, identifying trending topics, and even writing content. AI algorithms can analyze user behavior and content trends to generate content ideas that are more likely to engage and resonate with the target audience.\n\nContent Optimization\n\nAI-powered CMS can analyze content and provide recommendations for optimization. This includes identifying keywords, improving readability, and enhancing the overall structure and flow of the content. AI can also analyze user behavior to determine which content performs best and provide insights for future content creation.\n\nPredictive Analytics\n\nAI algorithms can analyze data to predict future trends and behavior. This can help businesses make data-driven decisions and improve their content strategies. Predictive analytics can also help in identifying potential issues or opportunities, allowing businesses to make proactive changes.\n\nChatbots\n\nAI-powered chatbots can provide a personalized and responsive customer service experience. Chatbots can answer customer queries, provide information, and even handle basic transactions, freeing up customer service representatives to handle more complex issues.\n\nIn conclusion, AI with CMS can provide numerous benefits for businesses looking to improve their content creation and management. From personalization to predictive analytics, AI can help businesses make data-driven decisions and improve user engagement. As AI technology continues to evolve, businesses can expect even more advanced capabilities and benefits from AI-powered CMS.','/content/en-us/images/size/_raw/2023/05/645cf4656c7c7c273897809b_cool-geometric-triangular-figure-neon-laser-light-great-backgrounds.jpg',0,'post','published','en-us','public','all','2023-05-11 13:57:00','1','2023-05-11 13:57:00','1','2023-05-11 14:02:00','1','Artificial Intelligence (AI) is revolutionizing the world in various industries, including content management systems (CMS). AI has the power to analyze large amounts of data and make predictions, allowing businesses to make data-driven decisions. In this article, we will explore the benefits of AI ',NULL,NULL,NULL,NULL,NULL),('645cf6336c7c7c273897809d','c9af9ce4-ae04-4d88-b156-6d223b1dd9ec','How AI is Transforming Content Creation with CMS','how-ai-is-transforming-content-creation-with-cms','{\"type\":\"doc\",\"content\":[{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"Artificial Intelligence (AI) has the potential to revolutionize content creation with content management systems (CMS). AI-powered CMS can improve the efficiency and effectiveness of content creation by automating certain tasks and providing data-driven insights. In this article, we will explore how AI is transforming content creation with CMS.\"}]},{\"type\":\"heading\",\"attrs\":{\"textAlign\":\"left\",\"level\":2},\"content\":[{\"type\":\"text\",\"text\":\"Automated Content Creation\"}]},{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"AI algorithms can analyze user behavior and content trends to generate content ideas and even write content. This can save time and resources for content creators while ensuring that the content is relevant and engaging.\"}]},{\"type\":\"heading\",\"attrs\":{\"textAlign\":\"left\",\"level\":2},\"content\":[{\"type\":\"text\",\"text\":\"Content Optimization\"}]},{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"AI-powered CMS can analyze content and provide recommendations for optimization. This includes identifying keywords, improving readability, and enhancing the overall structure and flow of the content. AI can also analyze user behavior to determine which content performs best and provide insights for future content creation.\"}]},{\"type\":\"heading\",\"attrs\":{\"textAlign\":\"left\",\"level\":2},\"content\":[{\"type\":\"text\",\"text\":\"Personalization\"}]},{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"AI-powered CMS can personalize content to individual users. AI algorithms can analyze user data, such as browsing behavior and previous interactions, to create a personalized experience for each user. Personalization can improve engagement and increase user satisfaction, leading to higher conversion rates and sales.\"}]},{\"type\":\"heading\",\"attrs\":{\"textAlign\":\"left\",\"level\":2},\"content\":[{\"type\":\"text\",\"text\":\"Improved Search\"}]},{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"AI algorithms can improve search capabilities within CMS by analyzing user search queries and providing relevant results. This can enhance user experience and reduce bounce rates.\"}]},{\"type\":\"heading\",\"attrs\":{\"textAlign\":\"left\",\"level\":2},\"content\":[{\"type\":\"text\",\"text\":\"Predictive Analytics\"}]},{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"AI algorithms can analyze data to predict future trends and behavior. This can help businesses make data-driven decisions and improve their content strategies. Predictive analytics can also help in identifying potential issues or opportunities, allowing businesses to make proactive changes.\"}]},{\"type\":\"heading\",\"attrs\":{\"textAlign\":\"left\",\"level\":2},\"content\":[{\"type\":\"text\",\"text\":\"Chatbots\"}]},{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"AI-powered chatbots can provide a personalized and responsive customer service experience. Chatbots can answer customer queries, provide information, and even handle basic transactions, freeing up customer service representatives to handle more complex issues.\"}]},{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"In conclusion, AI with CMS can provide numerous benefits for businesses looking to improve their content creation and management. From automated content creation to personalized experiences, AI can help businesses create content that is engaging, relevant, and optimized for success. As AI technology continues to evolve, businesses can expect even more advanced capabilities and benefits from AI-powered CMS.\"}]}]}',NULL,'<p>Artificial Intelligence (AI) has the potential to revolutionize content creation with content management systems (CMS). AI-powered CMS can improve the efficiency and effectiveness of content creation by automating certain tasks and providing data-driven insights. In this article, we will explore how AI is transforming content creation with CMS.</p><h2>Automated Content Creation</h2><p>AI algorithms can analyze user behavior and content trends to generate content ideas and even write content. This can save time and resources for content creators while ensuring that the content is relevant and engaging.</p><h2>Content Optimization</h2><p>AI-powered CMS can analyze content and provide recommendations for optimization. This includes identifying keywords, improving readability, and enhancing the overall structure and flow of the content. AI can also analyze user behavior to determine which content performs best and provide insights for future content creation.</p><h2>Personalization</h2><p>AI-powered CMS can personalize content to individual users. AI algorithms can analyze user data, such as browsing behavior and previous interactions, to create a personalized experience for each user. Personalization can improve engagement and increase user satisfaction, leading to higher conversion rates and sales.</p><h2>Improved Search</h2><p>AI algorithms can improve search capabilities within CMS by analyzing user search queries and providing relevant results. This can enhance user experience and reduce bounce rates.</p><h2>Predictive Analytics</h2><p>AI algorithms can analyze data to predict future trends and behavior. This can help businesses make data-driven decisions and improve their content strategies. Predictive analytics can also help in identifying potential issues or opportunities, allowing businesses to make proactive changes.</p><h2>Chatbots</h2><p>AI-powered chatbots can provide a personalized and responsive customer service experience. Chatbots can answer customer queries, provide information, and even handle basic transactions, freeing up customer service representatives to handle more complex issues.</p><p>In conclusion, AI with CMS can provide numerous benefits for businesses looking to improve their content creation and management. From automated content creation to personalized experiences, AI can help businesses create content that is engaging, relevant, and optimized for success. As AI technology continues to evolve, businesses can expect even more advanced capabilities and benefits from AI-powered CMS.</p>','645cf6336c7c7c273897809e','Artificial Intelligence (AI) has the potential to revolutionize content creation with content management systems (CMS). AI-powered CMS can improve the efficiency and effectiveness of content creation by automating certain tasks and providing data-driven insights. In this article, we will explore how AI is transforming content creation with CMS.\n\nAutomated Content Creation\n\nAI algorithms can analyze user behavior and content trends to generate content ideas and even write content. This can save time and resources for content creators while ensuring that the content is relevant and engaging.\n\nContent Optimization\n\nAI-powered CMS can analyze content and provide recommendations for optimization. This includes identifying keywords, improving readability, and enhancing the overall structure and flow of the content. AI can also analyze user behavior to determine which content performs best and provide insights for future content creation.\n\nPersonalization\n\nAI-powered CMS can personalize content to individual users. AI algorithms can analyze user data, such as browsing behavior and previous interactions, to create a personalized experience for each user. Personalization can improve engagement and increase user satisfaction, leading to higher conversion rates and sales.\n\nImproved Search\n\nAI algorithms can improve search capabilities within CMS by analyzing user search queries and providing relevant results. This can enhance user experience and reduce bounce rates.\n\nPredictive Analytics\n\nAI algorithms can analyze data to predict future trends and behavior. This can help businesses make data-driven decisions and improve their content strategies. Predictive analytics can also help in identifying potential issues or opportunities, allowing businesses to make proactive changes.\n\nChatbots\n\nAI-powered chatbots can provide a personalized and responsive customer service experience. Chatbots can answer customer queries, provide information, and even handle basic transactions, freeing up customer service representatives to handle more complex issues.\n\nIn conclusion, AI with CMS can provide numerous benefits for businesses looking to improve their content creation and management. From automated content creation to personalized experiences, AI can help businesses create content that is engaging, relevant, and optimized for success. As AI technology continues to evolve, businesses can expect even more advanced capabilities and benefits from AI-powered CMS.','/content/en-us/images/size/_raw/2023/05/645cf6336c7c7c273897809d_3d-abstract-background-with-futuristic-particles.jpg',1,'post','published','en-us','public','all','2023-05-11 14:05:00','1','2023-05-11 14:05:00','1','2023-05-11 14:07:00','1',NULL,NULL,NULL,NULL,NULL,NULL),('645cf6c76c7c7c273897809f','411b022a-1d87-42c6-9b3c-6e849d38bc2e','How AI is Revolutionizing Blogger Support','how-ai-is-revolutionizing-blogger-support','{\"type\":\"doc\",\"content\":[{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"Artificial Intelligence (AI) has the potential to revolutionize the way bloggers receive support. AI-powered support tools can provide faster and more accurate solutions to common problems, improving the overall experience for bloggers. In this article, we will explore how AI is revolutionizing blogger support.\"}]},{\"type\":\"heading\",\"attrs\":{\"textAlign\":\"left\",\"level\":2},\"content\":[{\"type\":\"text\",\"text\":\"Automated Support\"}]},{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"start\"},\"content\":[{\"type\":\"text\",\"text\":\"AI-powered support tools can automate certain tasks, such as providing answers to frequently asked questions or resolving common issues. This can save time and resources for support teams while ensuring that bloggers receive quick and accurate solutions to their problems.\"}]},{\"type\":\"heading\",\"attrs\":{\"textAlign\":\"left\",\"level\":2},\"content\":[{\"type\":\"text\",\"text\":\"Personalized Support\"}]},{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"start\"},\"content\":[{\"type\":\"text\",\"text\":\"AI algorithms can analyze blogger data, such as browsing behavior and previous interactions, to create a personalized support experience for each blogger. Personalization can improve engagement and increase blogger satisfaction, leading to higher retention rates.\"}]},{\"type\":\"heading\",\"attrs\":{\"textAlign\":\"left\",\"level\":2},\"content\":[{\"type\":\"text\",\"text\":\"Improved Search\"}]},{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"start\"},\"content\":[{\"type\":\"text\",\"text\":\"AI algorithms can improve search capabilities within support systems by analyzing blogger search queries and providing relevant results. This can enhance the blogger experience and reduce frustration.\"}]},{\"type\":\"heading\",\"attrs\":{\"textAlign\":\"left\",\"level\":2},\"content\":[{\"type\":\"text\",\"text\":\"Predictive Analytics\"}]},{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"start\"},\"content\":[{\"type\":\"text\",\"text\":\"AI algorithms can analyze data to predict future trends and behavior. This can help support teams proactively address potential issues before they become problems. Predictive analytics can also help in identifying opportunities for improvement in the support process.\"}]},{\"type\":\"heading\",\"attrs\":{\"textAlign\":\"left\",\"level\":2},\"content\":[{\"type\":\"text\",\"text\":\"Chatbots\"}]},{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"start\"},\"content\":[{\"type\":\"text\",\"text\":\"AI-powered chatbots can provide a personalized and responsive support experience. Chatbots can answer blogger queries, provide information, and even handle basic issues, freeing up support teams to handle more complex problems.\"}]},{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"start\"},\"content\":[{\"type\":\"text\",\"text\":\"In conclusion, AI support tools can provide numerous benefits for bloggers looking for fast and accurate solutions to their problems. From automated support to personalized experiences, AI can help bloggers get the support they need to succeed. As AI technology continues to evolve, bloggers can expect even more advanced capabilities and benefits from AI-powered support systems.\"}]}]}',NULL,'<p>Artificial Intelligence (AI) has the potential to revolutionize the way bloggers receive support. AI-powered support tools can provide faster and more accurate solutions to common problems, improving the overall experience for bloggers. In this article, we will explore how AI is revolutionizing blogger support.</p><h2>Automated Support</h2><p style=\"text-align: start\">AI-powered support tools can automate certain tasks, such as providing answers to frequently asked questions or resolving common issues. This can save time and resources for support teams while ensuring that bloggers receive quick and accurate solutions to their problems.</p><h2>Personalized Support</h2><p style=\"text-align: start\">AI algorithms can analyze blogger data, such as browsing behavior and previous interactions, to create a personalized support experience for each blogger. Personalization can improve engagement and increase blogger satisfaction, leading to higher retention rates.</p><h2>Improved Search</h2><p style=\"text-align: start\">AI algorithms can improve search capabilities within support systems by analyzing blogger search queries and providing relevant results. This can enhance the blogger experience and reduce frustration.</p><h2>Predictive Analytics</h2><p style=\"text-align: start\">AI algorithms can analyze data to predict future trends and behavior. This can help support teams proactively address potential issues before they become problems. Predictive analytics can also help in identifying opportunities for improvement in the support process.</p><h2>Chatbots</h2><p style=\"text-align: start\">AI-powered chatbots can provide a personalized and responsive support experience. Chatbots can answer blogger queries, provide information, and even handle basic issues, freeing up support teams to handle more complex problems.</p><p style=\"text-align: start\">In conclusion, AI support tools can provide numerous benefits for bloggers looking for fast and accurate solutions to their problems. From automated support to personalized experiences, AI can help bloggers get the support they need to succeed. As AI technology continues to evolve, bloggers can expect even more advanced capabilities and benefits from AI-powered support systems.</p>','645cf6c76c7c7c27389780a0','Artificial Intelligence (AI) has the potential to revolutionize the way bloggers receive support. AI-powered support tools can provide faster and more accurate solutions to common problems, improving the overall experience for bloggers. In this article, we will explore how AI is revolutionizing blogger support.\n\nAutomated Support\n\nAI-powered support tools can automate certain tasks, such as providing answers to frequently asked questions or resolving common issues. This can save time and resources for support teams while ensuring that bloggers receive quick and accurate solutions to their problems.\n\nPersonalized Support\n\nAI algorithms can analyze blogger data, such as browsing behavior and previous interactions, to create a personalized support experience for each blogger. Personalization can improve engagement and increase blogger satisfaction, leading to higher retention rates.\n\nImproved Search\n\nAI algorithms can improve search capabilities within support systems by analyzing blogger search queries and providing relevant results. This can enhance the blogger experience and reduce frustration.\n\nPredictive Analytics\n\nAI algorithms can analyze data to predict future trends and behavior. This can help support teams proactively address potential issues before they become problems. Predictive analytics can also help in identifying opportunities for improvement in the support process.\n\nChatbots\n\nAI-powered chatbots can provide a personalized and responsive support experience. Chatbots can answer blogger queries, provide information, and even handle basic issues, freeing up support teams to handle more complex problems.\n\nIn conclusion, AI support tools can provide numerous benefits for bloggers looking for fast and accurate solutions to their problems. From automated support to personalized experiences, AI can help bloggers get the support they need to succeed. As AI technology continues to evolve, bloggers can expect even more advanced capabilities and benefits from AI-powered support systems.','/content/en-us/images/size/_raw/2023/05/645cf6c76c7c7c273897809f_technology-network-background-connection-cyber-space-ai-generative.jpg',1,'post','published','en-us','public','all','2023-05-11 14:08:00','1','2023-05-11 14:08:00','1','2023-05-11 14:11:00','1','Artificial Intelligence (AI) has the potential to revolutionize the way bloggers receive support.',NULL,NULL,NULL,NULL,NULL),('645cf7e86c7c7c27389780a1','c8d67409-0e7c-46d0-98a6-36b0ec4431c9','How AI is Bringing Benefits to the Digital Content Industry','how-ai-is-bringing-benefits-to-the-digital-content-industry','{\"type\":\"doc\",\"content\":[{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"Artificial Intelligence (AI) is transforming the digital content industry by enabling content creators and marketers to create, manage, and distribute content more efficiently and effectively. AI-powered tools are making it possible to personalize content for individual users, optimize content for search engines, and even automate content creation. In this article, we will explore how AI is bringing benefits to the digital content industry.\"}]},{\"type\":\"heading\",\"attrs\":{\"textAlign\":\"left\",\"level\":2},\"content\":[{\"type\":\"text\",\"text\":\"Personalization\"}]},{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"start\"},\"content\":[{\"type\":\"text\",\"text\":\"AI algorithms can analyze user data, such as browsing behavior and past interactions, to create personalized content experiences for individual users. This can improve engagement and increase user satisfaction, leading to higher retention rates and conversions.\"}]},{\"type\":\"heading\",\"attrs\":{\"textAlign\":\"left\",\"level\":2},\"content\":[{\"type\":\"text\",\"text\":\"Optimization\"}]},{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"start\"},\"content\":[{\"type\":\"text\",\"text\":\"AI-powered tools can analyze content and provide recommendations for optimization. This includes identifying keywords, improving readability, and enhancing the overall structure and flow of the content. AI can also analyze user behavior to determine which content performs best and provide insights for future content creation.\"}]},{\"type\":\"heading\",\"attrs\":{\"textAlign\":\"left\",\"level\":2},\"content\":[{\"type\":\"text\",\"text\":\"Automated Content Creation\"}]},{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"start\"},\"content\":[{\"type\":\"text\",\"text\":\"AI algorithms can generate content ideas and even write content. This can save time and resources for content creators while ensuring that the content is relevant and engaging.\"}]},{\"type\":\"heading\",\"attrs\":{\"textAlign\":\"left\",\"level\":2},\"content\":[{\"type\":\"text\",\"text\":\"Content Distribution\"}]},{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"start\"},\"content\":[{\"type\":\"text\",\"text\":\"AI-powered tools can analyze user data to determine the best channels and times to distribute content for maximum engagement. This can improve the effectiveness of content distribution and increase reach and visibility.\"}]},{\"type\":\"heading\",\"attrs\":{\"textAlign\":\"left\",\"level\":2},\"content\":[{\"type\":\"text\",\"text\":\"Predictive Analytics\"}]},{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"start\"},\"content\":[{\"type\":\"text\",\"text\":\"AI algorithms can analyze data to predict future trends and behavior. This can help businesses make data-driven decisions and improve their content strategies. Predictive analytics can also help in identifying potential issues or opportunities, allowing businesses to make proactive changes.\"}]},{\"type\":\"heading\",\"attrs\":{\"textAlign\":\"left\",\"level\":2},\"content\":[{\"type\":\"text\",\"text\":\"Improved User Experience\"}]},{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"start\"},\"content\":[{\"type\":\"text\",\"text\":\"AI-powered tools can improve the overall user experience by providing personalized recommendations, streamlined navigation, and more relevant content. This can increase user satisfaction and loyalty, leading to higher retention rates and revenue.\"}]},{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"start\"},\"content\":[{\"type\":\"text\",\"text\":\"In conclusion, AI is bringing numerous benefits to the digital content industry. From personalized content experiences to automated content creation, AI-powered tools are making it possible for businesses to create, manage, and distribute content more efficiently and effectively. As AI technology continues to evolve, businesses can expect even more advanced capabilities and benefits from AI-powered digital content solutions.\"}]}]}',NULL,'<p>Artificial Intelligence (AI) is transforming the digital content industry by enabling content creators and marketers to create, manage, and distribute content more efficiently and effectively. AI-powered tools are making it possible to personalize content for individual users, optimize content for search engines, and even automate content creation. In this article, we will explore how AI is bringing benefits to the digital content industry.</p><h2>Personalization</h2><p style=\"text-align: start\">AI algorithms can analyze user data, such as browsing behavior and past interactions, to create personalized content experiences for individual users. This can improve engagement and increase user satisfaction, leading to higher retention rates and conversions.</p><h2>Optimization</h2><p style=\"text-align: start\">AI-powered tools can analyze content and provide recommendations for optimization. This includes identifying keywords, improving readability, and enhancing the overall structure and flow of the content. AI can also analyze user behavior to determine which content performs best and provide insights for future content creation.</p><h2>Automated Content Creation</h2><p style=\"text-align: start\">AI algorithms can generate content ideas and even write content. This can save time and resources for content creators while ensuring that the content is relevant and engaging.</p><h2>Content Distribution</h2><p style=\"text-align: start\">AI-powered tools can analyze user data to determine the best channels and times to distribute content for maximum engagement. This can improve the effectiveness of content distribution and increase reach and visibility.</p><h2>Predictive Analytics</h2><p style=\"text-align: start\">AI algorithms can analyze data to predict future trends and behavior. This can help businesses make data-driven decisions and improve their content strategies. Predictive analytics can also help in identifying potential issues or opportunities, allowing businesses to make proactive changes.</p><h2>Improved User Experience</h2><p style=\"text-align: start\">AI-powered tools can improve the overall user experience by providing personalized recommendations, streamlined navigation, and more relevant content. This can increase user satisfaction and loyalty, leading to higher retention rates and revenue.</p><p style=\"text-align: start\">In conclusion, AI is bringing numerous benefits to the digital content industry. From personalized content experiences to automated content creation, AI-powered tools are making it possible for businesses to create, manage, and distribute content more efficiently and effectively. As AI technology continues to evolve, businesses can expect even more advanced capabilities and benefits from AI-powered digital content solutions.</p>','645cf7e86c7c7c27389780a2','Artificial Intelligence (AI) is transforming the digital content industry by enabling content creators and marketers to create, manage, and distribute content more efficiently and effectively. AI-powered tools are making it possible to personalize content for individual users, optimize content for search engines, and even automate content creation. In this article, we will explore how AI is bringing benefits to the digital content industry.\n\nPersonalization\n\nAI algorithms can analyze user data, such as browsing behavior and past interactions, to create personalized content experiences for individual users. This can improve engagement and increase user satisfaction, leading to higher retention rates and conversions.\n\nOptimization\n\nAI-powered tools can analyze content and provide recommendations for optimization. This includes identifying keywords, improving readability, and enhancing the overall structure and flow of the content. AI can also analyze user behavior to determine which content performs best and provide insights for future content creation.\n\nAutomated Content Creation\n\nAI algorithms can generate content ideas and even write content. This can save time and resources for content creators while ensuring that the content is relevant and engaging.\n\nContent Distribution\n\nAI-powered tools can analyze user data to determine the best channels and times to distribute content for maximum engagement. This can improve the effectiveness of content distribution and increase reach and visibility.\n\nPredictive Analytics\n\nAI algorithms can analyze data to predict future trends and behavior. This can help businesses make data-driven decisions and improve their content strategies. Predictive analytics can also help in identifying potential issues or opportunities, allowing businesses to make proactive changes.\n\nImproved User Experience\n\nAI-powered tools can improve the overall user experience by providing personalized recommendations, streamlined navigation, and more relevant content. This can increase user satisfaction and loyalty, leading to higher retention rates and revenue.\n\nIn conclusion, AI is bringing numerous benefits to the digital content industry. From personalized content experiences to automated content creation, AI-powered tools are making it possible for businesses to create, manage, and distribute content more efficiently and effectively. As AI technology continues to evolve, businesses can expect even more advanced capabilities and benefits from AI-powered digital content solutions.','/content/en-us/images/size/_raw/2023/05/645cf7e86c7c7c27389780a1_blurred-night-lights.jpg',1,'post','published','en-us','public','all','2023-05-11 14:12:00','1','2023-05-11 14:12:00','1','2023-05-11 14:13:00','1','Artificial Intelligence (AI) is transforming the digital content industry by enabling content creators and marketers to create, manage, and distribute content more efficiently and effectively.',NULL,NULL,NULL,NULL,NULL),('645cf86e6c7c7c27389780a3','2360b917-41f4-44ca-8a0a-057a6b24fcd3','How AI Integration with CMS will Bring a Bright Future to Any System','how-ai-integration-with-cms-will-bring-a-bright-future-to-any-system','{\"type\":\"doc\",\"content\":[{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"Artificial Intelligence (AI) is transforming the way businesses operate and is becoming increasingly integrated with Content Management Systems (CMS). By combining AI with CMS, businesses can unlock new capabilities and insights that were previously impossible to achieve. In this article, we will explore how AI integration with CMS will bring a bright future to any system.\"}]},{\"type\":\"heading\",\"attrs\":{\"textAlign\":\"left\",\"level\":2},\"content\":[{\"type\":\"text\",\"text\":\"Automated Content Creation\"}]},{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"AI algorithms can generate content ideas and even write content. By integrating AI with CMS, businesses can automate the content creation process, saving time and resources while ensuring that the content is relevant and engaging. This can also free up content creators to focus on higher-level tasks, such as strategy and planning.\"}]},{\"type\":\"heading\",\"attrs\":{\"textAlign\":\"left\",\"level\":2},\"content\":[{\"type\":\"text\",\"text\":\"Personalized Content Delivery\"}]},{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"AI algorithms can analyze user data to create personalized content experiences for individual users. By integrating AI with CMS, businesses can deliver content that is tailored to each user\'s preferences, interests, and needs. This can improve engagement and increase user satisfaction, leading to higher retention rates and conversions.\"}]},{\"type\":\"heading\",\"attrs\":{\"textAlign\":\"left\",\"level\":2},\"content\":[{\"type\":\"text\",\"text\":\"Predictive Analytics\"}]},{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"AI algorithms can analyze data to predict future trends and behavior. By integrating AI with CMS, businesses can use predictive analytics to make data-driven decisions and improve their content strategies. Predictive analytics can also help in identifying potential issues or opportunities, allowing businesses to make proactive changes.\"}]},{\"type\":\"heading\",\"attrs\":{\"textAlign\":\"left\",\"level\":2},\"content\":[{\"type\":\"text\",\"text\":\"Improved Search\"}]},{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"AI algorithms can improve search capabilities within CMS by analyzing user search queries and providing relevant results. By integrating AI with CMS, businesses can enhance the user experience by providing accurate and timely search results, reducing frustration and improving engagement.\"}]},{\"type\":\"heading\",\"attrs\":{\"textAlign\":\"left\",\"level\":2},\"content\":[{\"type\":\"text\",\"text\":\"Chatbots\"}]},{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"AI-powered chatbots can provide a personalized and responsive support experience. By integrating AI with CMS, businesses can use chatbots to answer user queries, provide information, and even handle basic issues, freeing up support teams to handle more complex problems.\"}]},{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"In conclusion, integrating AI with CMS can bring numerous benefits to any system. From automated content creation to personalized content delivery, predictive analytics, improved search, and chatbots, businesses can use AI to unlock new capabilities and insights that were previously impossible to achieve. As AI technology continues to evolve, businesses can expect even more advanced capabilities and benefits from AI-powered CMS solutions.\"}]}]}',NULL,'<p>Artificial Intelligence (AI) is transforming the way businesses operate and is becoming increasingly integrated with Content Management Systems (CMS). By combining AI with CMS, businesses can unlock new capabilities and insights that were previously impossible to achieve. In this article, we will explore how AI integration with CMS will bring a bright future to any system.</p><h2>Automated Content Creation</h2><p>AI algorithms can generate content ideas and even write content. By integrating AI with CMS, businesses can automate the content creation process, saving time and resources while ensuring that the content is relevant and engaging. This can also free up content creators to focus on higher-level tasks, such as strategy and planning.</p><h2>Personalized Content Delivery</h2><p>AI algorithms can analyze user data to create personalized content experiences for individual users. By integrating AI with CMS, businesses can deliver content that is tailored to each user\'s preferences, interests, and needs. This can improve engagement and increase user satisfaction, leading to higher retention rates and conversions.</p><h2>Predictive Analytics</h2><p>AI algorithms can analyze data to predict future trends and behavior. By integrating AI with CMS, businesses can use predictive analytics to make data-driven decisions and improve their content strategies. Predictive analytics can also help in identifying potential issues or opportunities, allowing businesses to make proactive changes.</p><h2>Improved Search</h2><p>AI algorithms can improve search capabilities within CMS by analyzing user search queries and providing relevant results. By integrating AI with CMS, businesses can enhance the user experience by providing accurate and timely search results, reducing frustration and improving engagement.</p><h2>Chatbots</h2><p>AI-powered chatbots can provide a personalized and responsive support experience. By integrating AI with CMS, businesses can use chatbots to answer user queries, provide information, and even handle basic issues, freeing up support teams to handle more complex problems.</p><p>In conclusion, integrating AI with CMS can bring numerous benefits to any system. From automated content creation to personalized content delivery, predictive analytics, improved search, and chatbots, businesses can use AI to unlock new capabilities and insights that were previously impossible to achieve. As AI technology continues to evolve, businesses can expect even more advanced capabilities and benefits from AI-powered CMS solutions.</p>','645cf86e6c7c7c27389780a4','Artificial Intelligence (AI) is transforming the way businesses operate and is becoming increasingly integrated with Content Management Systems (CMS). By combining AI with CMS, businesses can unlock new capabilities and insights that were previously impossible to achieve. In this article, we will explore how AI integration with CMS will bring a bright future to any system.\n\nAutomated Content Creation\n\nAI algorithms can generate content ideas and even write content. By integrating AI with CMS, businesses can automate the content creation process, saving time and resources while ensuring that the content is relevant and engaging. This can also free up content creators to focus on higher-level tasks, such as strategy and planning.\n\nPersonalized Content Delivery\n\nAI algorithms can analyze user data to create personalized content experiences for individual users. By integrating AI with CMS, businesses can deliver content that is tailored to each user\'s preferences, interests, and needs. This can improve engagement and increase user satisfaction, leading to higher retention rates and conversions.\n\nPredictive Analytics\n\nAI algorithms can analyze data to predict future trends and behavior. By integrating AI with CMS, businesses can use predictive analytics to make data-driven decisions and improve their content strategies. Predictive analytics can also help in identifying potential issues or opportunities, allowing businesses to make proactive changes.\n\nImproved Search\n\nAI algorithms can improve search capabilities within CMS by analyzing user search queries and providing relevant results. By integrating AI with CMS, businesses can enhance the user experience by providing accurate and timely search results, reducing frustration and improving engagement.\n\nChatbots\n\nAI-powered chatbots can provide a personalized and responsive support experience. By integrating AI with CMS, businesses can use chatbots to answer user queries, provide information, and even handle basic issues, freeing up support teams to handle more complex problems.\n\nIn conclusion, integrating AI with CMS can bring numerous benefits to any system. From automated content creation to personalized content delivery, predictive analytics, improved search, and chatbots, businesses can use AI to unlock new capabilities and insights that were previously impossible to achieve. As AI technology continues to evolve, businesses can expect even more advanced capabilities and benefits from AI-powered CMS solutions.','/content/en-us/images/size/_raw/2023/05/645cf86e6c7c7c27389780a3_3d-digital-landscape-modern-technology-background.jpg',0,'post','published','en-us','public','all','2023-05-11 14:15:00','1','2023-05-11 14:15:00','1','2023-05-11 14:17:00','1','Artificial Intelligence (AI) is transforming the way businesses operate and is becoming increasingly integrated with Content Management Systems (CMS).',NULL,NULL,NULL,NULL,NULL),('645cf95c6c7c7c27389780a5','ac3b959e-71dc-449c-a818-c709faa0b075','How CMS Powered by AI will Change the World','how-cms-powered-by-ai-will-change-the-world','{\"type\":\"doc\",\"content\":[{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"Content Management Systems (CMS) are an essential part of many businesses, enabling them to create, manage, and distribute content. However, the integration of Artificial Intelligence (AI) with CMS is set to revolutionize the digital landscape. AI-powered CMS will change the way businesses operate, interact with customers, and even impact society as a whole. In this article, we will explore how CMS powered by AI will change the world.\"}]},{\"type\":\"heading\",\"attrs\":{\"textAlign\":\"left\",\"level\":2},\"content\":[{\"type\":\"text\",\"text\":\"Automated Content Creation\"}]},{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"AI-powered CMS can generate content ideas and even write content. This can save time and resources for content creators while ensuring that the content is relevant and engaging. This can also free up content creators to focus on higher-level tasks, such as strategy and planning.\"}]},{\"type\":\"heading\",\"attrs\":{\"textAlign\":\"left\",\"level\":2},\"content\":[{\"type\":\"text\",\"text\":\"Personalized Content Delivery\"}]},{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"AI-powered CMS can analyze user data to create personalized content experiences for individual users. This can improve engagement and increase user satisfaction, leading to higher retention rates and conversions. Personalized content delivery can also improve customer loyalty and drive revenue growth.\"}]},{\"type\":\"heading\",\"attrs\":{\"textAlign\":\"left\",\"level\":2},\"content\":[{\"type\":\"text\",\"text\":\"Predictive Analytics\"}]},{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"AI-powered CMS can analyze data to predict future trends and behavior. This can help businesses make data-driven decisions and improve their content strategies. Predictive analytics can also help in identifying potential issues or opportunities, allowing businesses to make proactive changes.\"}]},{\"type\":\"heading\",\"attrs\":{\"textAlign\":\"left\",\"level\":2},\"content\":[{\"type\":\"text\",\"text\":\"Improved Search\"}]},{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"AI-powered CMS can improve search capabilities by analyzing user search queries and providing relevant results. This can enhance the user experience by providing accurate and timely search results, reducing frustration and improving engagement.\"}]},{\"type\":\"heading\",\"attrs\":{\"textAlign\":\"left\",\"level\":2},\"content\":[{\"type\":\"text\",\"text\":\"Chatbots\"}]},{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"AI-powered chatbots can provide a personalized and responsive support experience. This can help businesses provide support around the clock, improving customer satisfaction and reducing support costs.\"}]},{\"type\":\"heading\",\"attrs\":{\"textAlign\":\"left\",\"level\":2},\"content\":[{\"type\":\"text\",\"text\":\"Social Media Management\"}]},{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"AI-powered CMS can analyze social media data and provide insights into customer behavior and preferences. This can help businesses optimize their social media strategies, improve engagement, and drive revenue growth.\"}]},{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"In conclusion, CMS powered by AI has the potential to revolutionize the way businesses operate and interact with customers. From automated content creation to personalized content delivery, predictive analytics, improved search, chatbots, and social media management, AI-powered CMS can unlock new capabilities and insights that were previously impossible to achieve. As AI technology continues to evolve, businesses can expect even more advanced capabilities and benefits from AI-powered CMS solutions. The future of CMS is AI, and the possibilities are limitless.\"}]}]}',NULL,'<p>Content Management Systems (CMS) are an essential part of many businesses, enabling them to create, manage, and distribute content. However, the integration of Artificial Intelligence (AI) with CMS is set to revolutionize the digital landscape. AI-powered CMS will change the way businesses operate, interact with customers, and even impact society as a whole. In this article, we will explore how CMS powered by AI will change the world.</p><h2>Automated Content Creation</h2><p>AI-powered CMS can generate content ideas and even write content. This can save time and resources for content creators while ensuring that the content is relevant and engaging. This can also free up content creators to focus on higher-level tasks, such as strategy and planning.</p><h2>Personalized Content Delivery</h2><p>AI-powered CMS can analyze user data to create personalized content experiences for individual users. This can improve engagement and increase user satisfaction, leading to higher retention rates and conversions. Personalized content delivery can also improve customer loyalty and drive revenue growth.</p><h2>Predictive Analytics</h2><p>AI-powered CMS can analyze data to predict future trends and behavior. This can help businesses make data-driven decisions and improve their content strategies. Predictive analytics can also help in identifying potential issues or opportunities, allowing businesses to make proactive changes.</p><h2>Improved Search</h2><p>AI-powered CMS can improve search capabilities by analyzing user search queries and providing relevant results. This can enhance the user experience by providing accurate and timely search results, reducing frustration and improving engagement.</p><h2>Chatbots</h2><p>AI-powered chatbots can provide a personalized and responsive support experience. This can help businesses provide support around the clock, improving customer satisfaction and reducing support costs.</p><h2>Social Media Management</h2><p>AI-powered CMS can analyze social media data and provide insights into customer behavior and preferences. This can help businesses optimize their social media strategies, improve engagement, and drive revenue growth.</p><p>In conclusion, CMS powered by AI has the potential to revolutionize the way businesses operate and interact with customers. From automated content creation to personalized content delivery, predictive analytics, improved search, chatbots, and social media management, AI-powered CMS can unlock new capabilities and insights that were previously impossible to achieve. As AI technology continues to evolve, businesses can expect even more advanced capabilities and benefits from AI-powered CMS solutions. The future of CMS is AI, and the possibilities are limitless.</p>','645cf95c6c7c7c27389780a6','Content Management Systems (CMS) are an essential part of many businesses, enabling them to create, manage, and distribute content. However, the integration of Artificial Intelligence (AI) with CMS is set to revolutionize the digital landscape. AI-powered CMS will change the way businesses operate, interact with customers, and even impact society as a whole. In this article, we will explore how CMS powered by AI will change the world.\n\nAutomated Content Creation\n\nAI-powered CMS can generate content ideas and even write content. This can save time and resources for content creators while ensuring that the content is relevant and engaging. This can also free up content creators to focus on higher-level tasks, such as strategy and planning.\n\nPersonalized Content Delivery\n\nAI-powered CMS can analyze user data to create personalized content experiences for individual users. This can improve engagement and increase user satisfaction, leading to higher retention rates and conversions. Personalized content delivery can also improve customer loyalty and drive revenue growth.\n\nPredictive Analytics\n\nAI-powered CMS can analyze data to predict future trends and behavior. This can help businesses make data-driven decisions and improve their content strategies. Predictive analytics can also help in identifying potential issues or opportunities, allowing businesses to make proactive changes.\n\nImproved Search\n\nAI-powered CMS can improve search capabilities by analyzing user search queries and providing relevant results. This can enhance the user experience by providing accurate and timely search results, reducing frustration and improving engagement.\n\nChatbots\n\nAI-powered chatbots can provide a personalized and responsive support experience. This can help businesses provide support around the clock, improving customer satisfaction and reducing support costs.\n\nSocial Media Management\n\nAI-powered CMS can analyze social media data and provide insights into customer behavior and preferences. This can help businesses optimize their social media strategies, improve engagement, and drive revenue growth.\n\nIn conclusion, CMS powered by AI has the potential to revolutionize the way businesses operate and interact with customers. From automated content creation to personalized content delivery, predictive analytics, improved search, chatbots, and social media management, AI-powered CMS can unlock new capabilities and insights that were previously impossible to achieve. As AI technology continues to evolve, businesses can expect even more advanced capabilities and benefits from AI-powered CMS solutions. The future of CMS is AI, and the possibilities are limitless.','/content/en-us/images/size/_raw/2023/05/645cf95c6c7c7c27389780a5_abstract-blue-background-with-many-small-details-generative-ai.jpg',0,'post','published','en-us','public','all','2023-05-11 14:19:00','1','2023-05-11 14:19:00','1','2023-05-11 14:21:00','1','Content Management Systems (CMS) are an essential part of many businesses, enabling them to create, manage, and distribute content. However, the integration of Artificial Intelligence (AI) with CMS is set to revolutionize the digital landscape. ',NULL,NULL,NULL,NULL,NULL),('645cfb656c7c7c27389780a9','87d96d6c-e28d-4d75-91cf-1cab2d7658e4','Vontigo is the 1st open-source CMS with AI feature out of the box!','vontigo-is-the-1st-open-source-cms-with-ai-feature-out-of-the-box','{\"type\":\"doc\",\"content\":[{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"left\"},\"content\":[{\"type\":\"text\",\"text\":\"Open-Source Vontigo CMS with AI Out of the Box Core Features will Bring a lot of Benefits for Businesses and Users Around the World\"}]},{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"start\"},\"content\":[{\"type\":\"text\",\"text\":\"Content Management Systems (CMS) have become essential for businesses of all sizes. They enable businesses to create, manage, and distribute content effectively. However, the integration of Artificial Intelligence (AI) with CMS is set to revolutionize the digital landscape. Open-source Vontigo CMS with AI out of the box core features is a game-changer. It will bring a lot of benefits for businesses and users around the world.\"}]},{\"type\":\"heading\",\"attrs\":{\"textAlign\":\"left\",\"level\":2},\"content\":[{\"type\":\"text\",\"text\":\"Automated Content Creation\"}]},{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"start\"},\"content\":[{\"type\":\"text\",\"text\":\"Open-source Vontigo CMS with AI out of the box core features can generate content ideas and even write content. This can save time and resources for content creators while ensuring that the content is relevant and engaging. This can also free up content creators to focus on higher-level tasks, such as strategy and planning.\"}]},{\"type\":\"heading\",\"attrs\":{\"textAlign\":\"left\",\"level\":2},\"content\":[{\"type\":\"text\",\"text\":\"Personalized Content Delivery\"}]},{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"start\"},\"content\":[{\"type\":\"text\",\"text\":\"Open-source Vontigo CMS with AI out of the box core features can analyze user data to create personalized content experiences for individual users. This can improve engagement and increase user satisfaction, leading to higher retention rates and conversions. Personalized content delivery can also improve customer loyalty and drive revenue growth.\"}]},{\"type\":\"heading\",\"attrs\":{\"textAlign\":\"left\",\"level\":2},\"content\":[{\"type\":\"text\",\"text\":\"Predictive Analytics\"}]},{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"start\"},\"content\":[{\"type\":\"text\",\"text\":\"Open-source Vontigo CMS with AI out of the box core features can analyze data to predict future trends and behavior. This can help businesses make data-driven decisions and improve their content strategies. Predictive analytics can also help in identifying potential issues or opportunities, allowing businesses to make proactive changes.\"}]},{\"type\":\"heading\",\"attrs\":{\"textAlign\":\"left\",\"level\":2},\"content\":[{\"type\":\"text\",\"text\":\"Improved Search\"}]},{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"start\"},\"content\":[{\"type\":\"text\",\"text\":\"Open-source Vontigo CMS with AI out of the box core features can improve search capabilities by analyzing user search queries and providing relevant results. This can enhance the user experience by providing accurate and timely search results, reducing frustration and improving engagement.\"}]},{\"type\":\"heading\",\"attrs\":{\"textAlign\":\"left\",\"level\":2},\"content\":[{\"type\":\"text\",\"text\":\"Chatbots\"}]},{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"start\"},\"content\":[{\"type\":\"text\",\"text\":\"Open-source Vontigo CMS with AI out of the box core features can provide a personalized and responsive support experience. This can help businesses provide support around the clock, improving customer satisfaction and reducing support costs.\"}]},{\"type\":\"heading\",\"attrs\":{\"textAlign\":\"left\",\"level\":2},\"content\":[{\"type\":\"text\",\"text\":\"Social Media Management\"}]},{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"start\"},\"content\":[{\"type\":\"text\",\"text\":\"Open-source Vontigo CMS with AI out of the box core features can analyze social media data and provide insights into customer behavior and preferences. This can help businesses optimize their social media strategies, improve engagement, and drive revenue growth.\"}]},{\"type\":\"heading\",\"attrs\":{\"textAlign\":\"left\",\"level\":2},\"content\":[{\"type\":\"text\",\"text\":\"Cost-Effective Solution\"}]},{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"start\"},\"content\":[{\"type\":\"text\",\"text\":\"Open-source Vontigo CMS with AI out of the box core features is a cost-effective solution for businesses of all sizes. It is an open-source platform, which means businesses do not have to pay for expensive licenses. Additionally, the AI features are built into the core of the CMS, eliminating the need for additional plugins or third-party software.\"}]},{\"type\":\"paragraph\",\"attrs\":{\"textAlign\":\"start\"},\"content\":[{\"type\":\"text\",\"text\":\"In conclusion, open-source Vontigo CMS with AI out of the box core features is a game-changer for businesses and users around the world. It offers numerous benefits, including automated content creation, personalized content delivery, predictive analytics, improved search, chatbots, social media management, and a cost-effective solution. This CMS provides businesses with the tools they need to stay ahead of the competition and provide\"}]}]}',NULL,'<p>Open-Source Vontigo CMS with AI Out of the Box Core Features will Bring a lot of Benefits for Businesses and Users Around the World</p><p style=\"text-align: start\">Content Management Systems (CMS) have become essential for businesses of all sizes. They enable businesses to create, manage, and distribute content effectively. However, the integration of Artificial Intelligence (AI) with CMS is set to revolutionize the digital landscape. Open-source Vontigo CMS with AI out of the box core features is a game-changer. It will bring a lot of benefits for businesses and users around the world.</p><h2>Automated Content Creation</h2><p style=\"text-align: start\">Open-source Vontigo CMS with AI out of the box core features can generate content ideas and even write content. This can save time and resources for content creators while ensuring that the content is relevant and engaging. This can also free up content creators to focus on higher-level tasks, such as strategy and planning.</p><h2>Personalized Content Delivery</h2><p style=\"text-align: start\">Open-source Vontigo CMS with AI out of the box core features can analyze user data to create personalized content experiences for individual users. This can improve engagement and increase user satisfaction, leading to higher retention rates and conversions. Personalized content delivery can also improve customer loyalty and drive revenue growth.</p><h2>Predictive Analytics</h2><p style=\"text-align: start\">Open-source Vontigo CMS with AI out of the box core features can analyze data to predict future trends and behavior. This can help businesses make data-driven decisions and improve their content strategies. Predictive analytics can also help in identifying potential issues or opportunities, allowing businesses to make proactive changes.</p><h2>Improved Search</h2><p style=\"text-align: start\">Open-source Vontigo CMS with AI out of the box core features can improve search capabilities by analyzing user search queries and providing relevant results. This can enhance the user experience by providing accurate and timely search results, reducing frustration and improving engagement.</p><h2>Chatbots</h2><p style=\"text-align: start\">Open-source Vontigo CMS with AI out of the box core features can provide a personalized and responsive support experience. This can help businesses provide support around the clock, improving customer satisfaction and reducing support costs.</p><h2>Social Media Management</h2><p style=\"text-align: start\">Open-source Vontigo CMS with AI out of the box core features can analyze social media data and provide insights into customer behavior and preferences. This can help businesses optimize their social media strategies, improve engagement, and drive revenue growth.</p><h2>Cost-Effective Solution</h2><p style=\"text-align: start\">Open-source Vontigo CMS with AI out of the box core features is a cost-effective solution for businesses of all sizes. It is an open-source platform, which means businesses do not have to pay for expensive licenses. Additionally, the AI features are built into the core of the CMS, eliminating the need for additional plugins or third-party software.</p><p style=\"text-align: start\">In conclusion, open-source Vontigo CMS with AI out of the box core features is a game-changer for businesses and users around the world. It offers numerous benefits, including automated content creation, personalized content delivery, predictive analytics, improved search, chatbots, social media management, and a cost-effective solution. This CMS provides businesses with the tools they need to stay ahead of the competition and provide</p>','645cfb656c7c7c27389780aa','Open-Source Vontigo CMS with AI Out of the Box Core Features will Bring a lot of Benefits for Businesses and Users Around the World\n\nContent Management Systems (CMS) have become essential for businesses of all sizes. They enable businesses to create, manage, and distribute content effectively. However, the integration of Artificial Intelligence (AI) with CMS is set to revolutionize the digital landscape. Open-source Vontigo CMS with AI out of the box core features is a game-changer. It will bring a lot of benefits for businesses and users around the world.\n\nAutomated Content Creation\n\nOpen-source Vontigo CMS with AI out of the box core features can generate content ideas and even write content. This can save time and resources for content creators while ensuring that the content is relevant and engaging. This can also free up content creators to focus on higher-level tasks, such as strategy and planning.\n\nPersonalized Content Delivery\n\nOpen-source Vontigo CMS with AI out of the box core features can analyze user data to create personalized content experiences for individual users. This can improve engagement and increase user satisfaction, leading to higher retention rates and conversions. Personalized content delivery can also improve customer loyalty and drive revenue growth.\n\nPredictive Analytics\n\nOpen-source Vontigo CMS with AI out of the box core features can analyze data to predict future trends and behavior. This can help businesses make data-driven decisions and improve their content strategies. Predictive analytics can also help in identifying potential issues or opportunities, allowing businesses to make proactive changes.\n\nImproved Search\n\nOpen-source Vontigo CMS with AI out of the box core features can improve search capabilities by analyzing user search queries and providing relevant results. This can enhance the user experience by providing accurate and timely search results, reducing frustration and improving engagement.\n\nChatbots\n\nOpen-source Vontigo CMS with AI out of the box core features can provide a personalized and responsive support experience. This can help businesses provide support around the clock, improving customer satisfaction and reducing support costs.\n\nSocial Media Management\n\nOpen-source Vontigo CMS with AI out of the box core features can analyze social media data and provide insights into customer behavior and preferences. This can help businesses optimize their social media strategies, improve engagement, and drive revenue growth.\n\nCost-Effective Solution\n\nOpen-source Vontigo CMS with AI out of the box core features is a cost-effective solution for businesses of all sizes. It is an open-source platform, which means businesses do not have to pay for expensive licenses. Additionally, the AI features are built into the core of the CMS, eliminating the need for additional plugins or third-party software.\n\nIn conclusion, open-source Vontigo CMS with AI out of the box core features is a game-changer for businesses and users around the world. It offers numerous benefits, including automated content creation, personalized content delivery, predictive analytics, improved search, chatbots, social media management, and a cost-effective solution. This CMS provides businesses with the tools they need to stay ahead of the competition and provide','/content/en-us/images/size/_raw/2023/05/645cfb656c7c7c27389780a9_glowing-blue-molecular-structure-laboratory-research-generated-by-ai.jpg',0,'post','published','en-us','public','all','2023-05-11 14:27:00','1','2023-05-11 14:27:00','1','2023-05-11 14:29:00','1','Open-source Vontigo CMS with AI out of the box core features is a game-changer. It will bring a lot of benefits for businesses and users around the world.',NULL,NULL,NULL,NULL,NULL),('645cfbf96c7c7c27389780ab','8f410b8f-2e8f-4dd1-9918-4fb70eb0a143','Your new post is here...','draft-slug-645cfbf96c7c7c27389780ab',NULL,NULL,NULL,'645cfbf96c7c7c27389780ac',NULL,NULL,0,'post','draft','en-us','public','all','2023-05-11 14:30:00','1','2023-05-11 14:30:00','1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts_authors`
--

DROP TABLE IF EXISTS `posts_authors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posts_authors` (
  `id` varchar(24) NOT NULL,
  `post_id` varchar(24) NOT NULL,
  `author_id` varchar(24) NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `post_id` (`post_id`),
  KEY `author_id` (`author_id`),
  CONSTRAINT `posts_authors_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`),
  CONSTRAINT `posts_authors_ibfk_2` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts_authors`
--

LOCK TABLES `posts_authors` WRITE;
/*!40000 ALTER TABLE `posts_authors` DISABLE KEYS */;
INSERT INTO `posts_authors` VALUES ('643c326e002137342cf323aa','643c326e002137342cf323a9','1',0),('644e4d4e97ea9a7e217d2469','643c3269002137342cf323a7','1',0),('645cf3e8c64ba87568acb096','645cf2a06c7c7c2738978099','1',0),('645cf6b59c446481ba914917','645cf6336c7c7c273897809d','1',0),('645cf77e9c446481ba914919','645cf6c76c7c7c273897809f','1',0),('645cf8209c446481ba91491b','645cf7e86c7c7c27389780a1','1',0),('645cfa09463678c1113997f7','645cf95c6c7c7c27389780a5','1',0);
/*!40000 ALTER TABLE `posts_authors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts_meta`
--

DROP TABLE IF EXISTS `posts_meta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posts_meta` (
  `id` varchar(24) NOT NULL,
  `post_id` varchar(24) NOT NULL,
  `og_image` varchar(2000) DEFAULT NULL,
  `og_title` varchar(300) DEFAULT NULL,
  `og_description` varchar(500) DEFAULT NULL,
  `twitter_image` varchar(2000) DEFAULT NULL,
  `twitter_title` varchar(300) DEFAULT NULL,
  `twitter_description` varchar(500) DEFAULT NULL,
  `meta_title` varchar(2000) DEFAULT NULL,
  `meta_description` varchar(2000) DEFAULT NULL,
  `email_subject` varchar(300) DEFAULT NULL,
  `frontmatter` text DEFAULT NULL,
  `feature_image_alt` varchar(191) DEFAULT NULL,
  `feature_image_caption` text DEFAULT NULL,
  `email_only` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `post_id` (`post_id`),
  CONSTRAINT `posts_meta_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts_meta`
--

LOCK TABLES `posts_meta` WRITE;
/*!40000 ALTER TABLE `posts_meta` DISABLE KEYS */;
/*!40000 ALTER TABLE `posts_meta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts_products`
--

DROP TABLE IF EXISTS `posts_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posts_products` (
  `id` varchar(24) NOT NULL,
  `post_id` varchar(24) NOT NULL,
  `product_id` varchar(24) NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `post_id` (`post_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `posts_products_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `posts_products_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts_products`
--

LOCK TABLES `posts_products` WRITE;
/*!40000 ALTER TABLE `posts_products` DISABLE KEYS */;
/*!40000 ALTER TABLE `posts_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` varchar(24) NOT NULL,
  `name` varchar(191) NOT NULL,
  `slug` varchar(191) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `welcome_page_url` varchar(2000) DEFAULT NULL,
  `visibility` varchar(50) NOT NULL DEFAULT 'none',
  `trial_days` int(11) NOT NULL DEFAULT 0,
  `description` varchar(191) DEFAULT NULL,
  `type` varchar(50) NOT NULL DEFAULT 'paid',
  `currency` varchar(50) DEFAULT NULL,
  `monthly_price` int(11) DEFAULT NULL,
  `yearly_price` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `monthly_price_id` varchar(24) DEFAULT NULL,
  `yearly_price_id` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products_benefits`
--

DROP TABLE IF EXISTS `products_benefits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products_benefits` (
  `id` varchar(24) NOT NULL,
  `product_id` varchar(24) NOT NULL,
  `benefit_id` varchar(24) NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  KEY `benefit_id` (`benefit_id`),
  CONSTRAINT `products_benefits_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `products_benefits_ibfk_2` FOREIGN KEY (`benefit_id`) REFERENCES `benefits` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products_benefits`
--

LOCK TABLES `products_benefits` WRITE;
/*!40000 ALTER TABLE `products_benefits` DISABLE KEYS */;
/*!40000 ALTER TABLE `products_benefits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `redirects`
--

DROP TABLE IF EXISTS `redirects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `redirects` (
  `id` varchar(24) NOT NULL,
  `from` varchar(2000) NOT NULL,
  `to` varchar(2000) NOT NULL,
  `post_id` varchar(24) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `post_id` (`post_id`),
  CONSTRAINT `redirects_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `redirects`
--

LOCK TABLES `redirects` WRITE;
/*!40000 ALTER TABLE `redirects` DISABLE KEYS */;
/*!40000 ALTER TABLE `redirects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` varchar(24) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(2000) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `created_by` varchar(24) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles_users`
--

DROP TABLE IF EXISTS `roles_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles_users` (
  `id` varchar(24) NOT NULL,
  `role_id` varchar(24) NOT NULL,
  `user_id` varchar(24) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles_users`
--

LOCK TABLES `roles_users` WRITE;
/*!40000 ALTER TABLE `roles_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `roles_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `id` varchar(24) NOT NULL,
  `session_id` varchar(32) NOT NULL,
  `user_id` varchar(24) NOT NULL,
  `session_data` varchar(2000) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `settings` (
  `id` varchar(24) NOT NULL,
  `group` varchar(50) NOT NULL DEFAULT 'core',
  `key` varchar(50) NOT NULL,
  `value` text DEFAULT NULL,
  `type` varchar(50) NOT NULL,
  `flags` varchar(50) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `created_by` varchar(24) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings`
--

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` VALUES ('643c326f002137342cf324de','core','last_mentions_report_email_timestamp',NULL,'number',NULL,'2023-04-16 17:37:51','1','2023-04-16 17:37:51','1'),('643c326f002137342cf324df','core','db_hash','f498cb9f-b0f5-48b9-ad1b-4731d7ec5853','string',NULL,'2023-04-16 17:37:51','1','2023-04-16 17:37:51','1'),('643c326f002137342cf324e0','core','routes_hash','3d180d52c663d173a6be791ef411ed01','string',NULL,'2023-04-16 17:37:51','1','2023-04-16 17:38:05','1'),('643c326f002137342cf324e1','core','next_update_check','1682088301','number',NULL,'2023-04-16 17:37:51','1','2023-04-20 14:45:01','1'),('643c326f002137342cf324e2','core','notifications','[{\"dismissible\":true,\"location\":\"bottom\",\"status\":\"alert\",\"id\":\"643c337a002137342cf32548\",\"createdAtVersion\":\"5.44.0\",\"type\":\"warn\",\"message\":\"Ghost is currently unable to send email. See https://ghost.org/docs/concepts/config/#mail for instructions.\",\"seen\":false,\"addedAt\":\"2023-04-16T17:42:18.515Z\"}]','array',NULL,'2023-04-16 17:37:51','1','2023-04-16 17:42:18','1'),('643c326f002137342cf324e3','core','version_notifications','[]','array',NULL,'2023-04-16 17:37:51','1','2023-04-16 17:37:51','1'),('643c326f002137342cf324e4','core','admin_session_secret','6d9eec27160e049a245ca071f29073b71cdeaf5873585c513fb040f1b93a28b6','string',NULL,'2023-04-16 17:37:51','1','2023-04-16 17:37:51','1'),('643c326f002137342cf324e5','core','theme_session_secret','0a12a610e02e7dab2c927ae7cdd13a302b8989e5d2a632cf37d80b972f2c120f','string',NULL,'2023-04-16 17:37:51','1','2023-04-16 17:37:51','1'),('643c326f002137342cf324e6','core','vontigo_public_key','-----BEGIN RSA PUBLIC KEY-----\nMIGJAoGBALbjvGV/wJzHg8Y5pGD8Z+F2fFYslunEbV33DKvSno1+H6y5uTA04sF+9ImEpq3U\nzgDEvSOprmCzWJErvFe+nOCC6SfIIHeSTDEvJ7wiN5pSrVlTFLyYY3X5E5VOYTvUub9giXrb\nv7c1qMXlDNPYz3yMac4dsVhbtUKlZLpkeSFFAgMBAAE=\n-----END RSA PUBLIC KEY-----\n','string',NULL,'2023-04-16 17:37:51','1','2023-04-16 17:37:51','1'),('643c326f002137342cf324e7','core','vontigo_private_key','-----BEGIN RSA PRIVATE KEY-----\nMIICXQIBAAKBgQC247xlf8Ccx4PGOaRg/GfhdnxWLJbpxG1d9wyr0p6Nfh+subkwNOLBfvSJ\nhKat1M4AxL0jqa5gs1iRK7xXvpzgguknyCB3kkwxLye8IjeaUq1ZUxS8mGN1+ROVTmE71Lm/\nYIl627+3NajF5QzT2M98jGnOHbFYW7VCpWS6ZHkhRQIDAQABAoGBAILSbm3wLzg2YyVFEDcr\n9abKWXBO3viCwHSphk/WDgJKSKAGDdjUy6r7hDJmR9AqW90i3eSHuKuFPoJBVa0yNQYRty8N\nYG+J6stibg9E6DiwMH8PHSxxgyVfD9xW6TPISvTK12jOu18X+kEPvWDntSaxlbo5BtghnKoJ\nJLmLeqVhAkEA5KHqfcvcboCnbFYwJ9fjhSl4J+PDxZIDYcDbQtsw39Ybc1ViY57wWlFK7OyC\nBUcgRaCqjMxAfElGUcQeq6JM+QJBAMzIGcwPyH2K6DjMU+2IX1hCJrWjr3P4eLvDIvGuCM7K\nSPoYcvoVs/45Tap5zEIrZd4C3ecug4U0NdSlqrBsRa0CQQCprbkXzzozEGwwrO5kQ4bphtNT\n12etsyWrYLPZNE9bb81DlTTF9mkuvnI6z3PXcufyhMDOaa/aDY+Qk1qnynYRAkATlEYzJocq\nya8uTwrvOQy0qY5962qJEgapHR0oMlWRP/H+R3wmwRB2jBAK7p5C7VdOBMQmqGHWyIklDbnm\nKFP5AkAGCJpz9TeCtuyzF/KgkmVjQAFdzA0oPCBF2e9yMC4t87J5Tiouy9idxwQxczNvo2a4\nWcCZ2trtS8GVQvVVRWmC\n-----END RSA PRIVATE KEY-----\n','string',NULL,'2023-04-16 17:37:51','1','2023-04-16 17:37:51','1'),('643c326f002137342cf324e8','core','members_public_key','-----BEGIN RSA PUBLIC KEY-----\nMIGJAoGBAMIPiSiRmxt3s8EAbttaaqSk9PDuHG3TODDLcrguqwdw/1vvl8UhmM0ElepOBT6X\nI6CAiGm+PCLrIF9/tuBO+MFRA3IYr16UjjyMGcCiEgcWteefTKGfwj4WNk0vGbaQ5H9Nmuuc\nG73HKZSFrZjkc6N6vTNAG2V8F3g4JYcVVsfrAgMBAAE=\n-----END RSA PUBLIC KEY-----\n','string',NULL,'2023-04-16 17:37:51','1','2023-04-16 17:37:51','1'),('643c326f002137342cf324e9','core','members_private_key','-----BEGIN RSA PRIVATE KEY-----\nMIICXQIBAAKBgQDCD4kokZsbd7PBAG7bWmqkpPTw7hxt0zgwy3K4LqsHcP9b75fFIZjNBJXq\nTgU+lyOggIhpvjwi6yBff7bgTvjBUQNyGK9elI48jBnAohIHFrXnn0yhn8I+FjZNLxm2kOR/\nTZrrnBu9xymUha2Y5HOjer0zQBtlfBd4OCWHFVbH6wIDAQABAoGBAIlOOLutmlNq9JJgXg9x\n//aSiIRX1WGXizBrIrZSvsw7FVLVSUs/pD+bOP9ZSLiqc5jCmMJIyX/jYTpwwNIgzjuuTKjH\nXHYwC6DaO5lnQXkkjEiTKnzaKtMveWvpYSCq+pIjhJcXCRvfb2y+iMPk8GgK7Qp1Nb2WkaMm\nBxIK8HlxAkEA4MGGtzZymF5Pqx/Cgdq+erR+4mtvncgm+d7mr3keO1DGiPtui7TkxOP6Syi3\nlQtadozhnc+xoHuXv4gjSLwubwJBAN0JpTjgYmGxoFP498LarOOoYqgrtxPmNTg1BSmHsij5\nHFztVvNRKCye0Vk9U/qjoOZ7Fcl4ZQeuJvwbt3Yn/EUCQFnUv9Vmi7LerxUEYqeoGE3O6o/w\nxPHZV8qzDpy/2hd3F4MUi4CHUpBnVljH82g823Faqap7otEz1NkWvpOJsz0CQANEpj2+C5ZY\nMv+q2bb21sGS9sp3wwA3UigfmJDxoa+7ZzD0jWmRlJ98RaolHv3At5tQzJSrBAtmBsuJeV/0\n3WUCQQDeG8RRhe8qsnAyOIC3hL7na5HbVE+fIsVLgE32Sdl5GrnOQrgK1qjBM6aSkWzm40ax\n8YBa6oIC7TSALkYbADWv\n-----END RSA PRIVATE KEY-----\n','string',NULL,'2023-04-16 17:37:51','1','2023-04-16 17:37:51','1'),('643c326f002137342cf324ea','core','members_email_auth_secret','22503539446411f2853eec5720d8e92a97972c41214dc1772f54b3fadb92b6b6274446cb51f18ab13bab3d5efce733ec8a177acc1095ec83c2e3813678a5d7d9','string',NULL,'2023-04-16 17:37:51','1','2023-04-16 17:37:51','1'),('643c326f002137342cf324eb','core','members_stripe_webhook_id',NULL,'string',NULL,'2023-04-16 17:37:51','1','2023-04-16 17:37:51','1'),('643c326f002137342cf324ec','core','members_stripe_webhook_secret',NULL,'string',NULL,'2023-04-16 17:37:51','1','2023-04-16 17:37:51','1'),('643c326f002137342cf324ed','site','title','Vontigo','string','PUBLIC','2023-04-16 17:37:51','1','2023-04-20 14:46:30','1'),('643c326f002137342cf324ee','site','description','Empower Your Content with AI: The Future-Ready Publishing Platform','string','PUBLIC','2023-04-16 17:37:51','1','2023-04-20 14:46:30','1'),('643c326f002137342cf324ef','site','logo','','string',NULL,'2023-04-16 17:37:51','1','2023-04-16 17:37:51','1'),('643c326f002137342cf324f0','site','cover_image','/content/en-us/images/size/_raw/2023/04/643c326f002137342cf324f0_main__share.jpg','string',NULL,'2023-04-16 17:37:51','1','2023-04-20 14:51:10','1'),('643c326f002137342cf324f1','site','icon','','string',NULL,'2023-04-16 17:37:51','1','2023-04-16 17:37:51','1'),('643c326f002137342cf324f2','site','accent_color','#000000','string','PUBLIC','2023-04-16 17:37:51','1','2023-04-20 14:51:10','1'),('643c326f002137342cf324f3','site','locale','en-us','string',NULL,'2023-04-16 17:37:51','1','2023-04-20 14:46:30','1'),('643c326f002137342cf324f4','site','timezone','Etc/UTC','string',NULL,'2023-04-16 17:37:51','1','2023-04-16 17:37:51','1'),('643c326f002137342cf324f5','site','codeinjection_head','','string',NULL,'2023-04-16 17:37:51','1','2023-04-16 17:37:51','1'),('643c326f002137342cf324f6','site','codeinjection_foot','','string',NULL,'2023-04-16 17:37:51','1','2023-04-16 17:37:51','1'),('643c326f002137342cf324f7','site','facebook','vontigo','string',NULL,'2023-04-16 17:37:51','1','2023-04-20 14:46:30','1'),('643c326f002137342cf324f8','site','twitter','@vontigo','string',NULL,'2023-04-16 17:37:51','1','2023-04-20 14:46:30','1'),('643c326f002137342cf324f9','site','navigation','[{\"label\":\"Home\",\"url\":\"/\"},{\"label\":\"About us\",\"url\":\"/about-us/\"},{\"label\":\"Collection\",\"url\":\"/tag/getting-started/\"},{\"label\":\"Author\",\"url\":\"/author/vontigo/\"}]','array',NULL,'2023-04-16 17:37:51','1','2023-04-20 15:00:01','1'),('643c326f002137342cf324fa','site','secondary_navigation','[\n  {\n    \"label\": \"Data & privacy\",\n    \"url\": \"/privacy/\"\n  },\n  {\n    \"label\": \"Contact\",\n    \"url\": \"/contact/\"\n  },\n  {\n    \"label\": \"Login\",\n    \"url\": \"/vontigo/\"\n  },\n  {\n    \"label\": \"Contribute →\",\n    \"url\": \"/contribute/\"\n  }\n]','array',NULL,'2023-04-16 17:37:51','1','2023-04-20 14:53:21','1'),('643c326f002137342cf324fb','site','meta_title','Vontigo','string',NULL,'2023-04-16 17:37:51','1','2023-04-20 14:46:30','1'),('643c326f002137342cf324fc','site','meta_description','Empower Your Content with AI: The Future-Ready Publishing Platform','string',NULL,'2023-04-16 17:37:51','1','2023-04-20 14:46:30','1'),('643c326f002137342cf324fd','site','og_image',NULL,'string',NULL,'2023-04-16 17:37:51','1','2023-04-16 17:37:51','1'),('643c326f002137342cf324fe','site','og_title','Vontigo','string',NULL,'2023-04-16 17:37:51','1','2023-04-20 14:46:30','1'),('643c326f002137342cf324ff','site','og_description','Empower Your Content with AI: The Future-Ready Publishing Platform','string',NULL,'2023-04-16 17:37:51','1','2023-04-20 14:46:30','1'),('643c326f002137342cf32500','site','twitter_image',NULL,'string',NULL,'2023-04-16 17:37:51','1','2023-04-16 17:37:51','1'),('643c326f002137342cf32501','site','twitter_title','Vontigo','string',NULL,'2023-04-16 17:37:51','1','2023-04-20 14:46:30','1'),('643c326f002137342cf32502','site','twitter_description','Empower Your Content with AI: The Future-Ready Publishing Platform','string',NULL,'2023-04-16 17:37:51','1','2023-04-20 14:46:30','1'),('643c326f002137342cf32503','theme','active_theme','casper','string','RO','2023-04-16 17:37:51','1','2023-04-16 17:37:51','1'),('643c326f002137342cf32504','private','is_private','false','boolean',NULL,'2023-04-16 17:37:51','1','2023-04-16 17:37:51','1'),('643c326f002137342cf32505','private','password','','string',NULL,'2023-04-16 17:37:51','1','2023-04-16 17:37:51','1'),('643c326f002137342cf32506','private','public_hash','ff61c32f8f91bc3644d5b7d04ecedf','string',NULL,'2023-04-16 17:37:51','1','2023-04-16 17:37:51','1'),('643c326f002137342cf32507','members','default_content_visibility','public','string',NULL,'2023-04-16 17:37:51','1','2023-04-16 17:37:51','1'),('643c326f002137342cf32508','members','default_content_visibility_tiers','[]','array',NULL,'2023-04-16 17:37:51','1','2023-04-16 17:37:51','1'),('643c326f002137342cf32509','members','members_signup_access','invite','string',NULL,'2023-04-16 17:37:51','1','2023-04-18 05:15:02','1'),('643c326f002137342cf3250a','members','members_support_address','noreply','string','PUBLIC,RO','2023-04-16 17:37:51','1','2023-04-16 17:37:51','1'),('643c326f002137342cf3250b','members','stripe_secret_key',NULL,'string',NULL,'2023-04-16 17:37:51','1','2023-04-16 17:37:51','1'),('643c326f002137342cf3250c','members','stripe_publishable_key',NULL,'string',NULL,'2023-04-16 17:37:51','1','2023-04-16 17:37:51','1'),('643c326f002137342cf3250d','members','stripe_plans','[]','array',NULL,'2023-04-16 17:37:51','1','2023-04-16 17:37:51','1'),('643c326f002137342cf3250e','members','stripe_connect_publishable_key',NULL,'string',NULL,'2023-04-16 17:37:51','1','2023-04-16 17:37:51','1'),('643c326f002137342cf3250f','members','stripe_connect_secret_key',NULL,'string',NULL,'2023-04-16 17:37:51','1','2023-04-16 17:37:51','1'),('643c326f002137342cf32510','members','stripe_connect_livemode',NULL,'boolean',NULL,'2023-04-16 17:37:51','1','2023-04-16 17:37:51','1'),('643c326f002137342cf32511','members','stripe_connect_display_name',NULL,'string',NULL,'2023-04-16 17:37:51','1','2023-04-16 17:37:51','1'),('643c326f002137342cf32512','members','stripe_connect_account_id',NULL,'string',NULL,'2023-04-16 17:37:51','1','2023-04-16 17:37:51','1'),('643c326f002137342cf32513','members','members_monthly_price_id',NULL,'string',NULL,'2023-04-16 17:37:51','1','2023-04-16 17:37:51','1'),('643c326f002137342cf32514','members','members_yearly_price_id',NULL,'string',NULL,'2023-04-16 17:37:51','1','2023-04-16 17:37:51','1'),('643c326f002137342cf32515','members','members_track_sources','true','boolean',NULL,'2023-04-16 17:37:51','1','2023-04-16 17:37:51','1'),('643c326f002137342cf32516','portal','portal_name','true','boolean',NULL,'2023-04-16 17:37:51','1','2023-04-16 17:37:51','1'),('643c326f002137342cf32517','portal','portal_button','true','boolean',NULL,'2023-04-16 17:37:51','1','2023-04-16 17:37:51','1'),('643c326f002137342cf32518','portal','portal_plans','[\"free\"]','array',NULL,'2023-04-16 17:37:51','1','2023-04-16 17:37:51','1'),('643c326f002137342cf32519','portal','portal_products','[]','array',NULL,'2023-04-16 17:37:51','1','2023-04-16 17:37:51','1'),('643c326f002137342cf3251a','portal','portal_button_style','icon-and-text','string',NULL,'2023-04-16 17:37:51','1','2023-04-16 17:37:51','1'),('643c326f002137342cf3251b','portal','portal_button_icon',NULL,'string',NULL,'2023-04-16 17:37:51','1','2023-04-16 17:37:51','1'),('643c326f002137342cf3251c','portal','portal_button_signup_text','Subscribe','string',NULL,'2023-04-16 17:37:51','1','2023-04-16 17:37:51','1'),('643c326f002137342cf3251d','portal','portal_signup_terms_html',NULL,'string',NULL,'2023-04-16 17:37:51','1','2023-04-16 17:37:51','1'),('643c326f002137342cf3251e','portal','portal_signup_checkbox_required','false','boolean',NULL,'2023-04-16 17:37:51','1','2023-04-16 17:37:51','1'),('643c326f002137342cf3251f','email','mailgun_domain',NULL,'string',NULL,'2023-04-16 17:37:51','1','2023-04-16 17:37:51','1'),('643c326f002137342cf32520','email','mailgun_api_key',NULL,'string',NULL,'2023-04-16 17:37:51','1','2023-04-16 17:37:51','1'),('643c326f002137342cf32521','email','mailgun_base_url',NULL,'string',NULL,'2023-04-16 17:37:51','1','2023-04-16 17:37:51','1'),('643c326f002137342cf32522','email','email_track_opens','true','boolean',NULL,'2023-04-16 17:37:51','1','2023-04-16 17:37:51','1'),('643c326f002137342cf32523','email','email_track_clicks','true','boolean',NULL,'2023-04-16 17:37:51','1','2023-04-16 17:37:51','1'),('643c326f002137342cf32524','email','email_verification_required','false','boolean','RO','2023-04-16 17:37:51','1','2023-04-16 17:37:51','1'),('643c326f002137342cf32525','amp','amp','false','boolean',NULL,'2023-04-16 17:37:51','1','2023-04-16 17:37:51','1'),('643c326f002137342cf32526','amp','amp_gtag_id',NULL,'string',NULL,'2023-04-16 17:37:51','1','2023-04-16 17:37:51','1'),('643c326f002137342cf32527','firstpromoter','firstpromoter','false','boolean',NULL,'2023-04-16 17:37:51','1','2023-04-16 17:37:51','1'),('643c326f002137342cf32528','firstpromoter','firstpromoter_id',NULL,'string',NULL,'2023-04-16 17:37:51','1','2023-04-16 17:37:51','1'),('643c326f002137342cf32529','labs','labs','{}','object',NULL,'2023-04-16 17:37:51','1','2023-04-16 17:37:51','1'),('643c326f002137342cf3252a','slack','slack_url','','string',NULL,'2023-04-16 17:37:51','1','2023-04-16 17:37:51','1'),('643c326f002137342cf3252b','slack','slack_username','Ghost','string',NULL,'2023-04-16 17:37:51','1','2023-04-16 17:37:51','1'),('643c326f002137342cf3252c','unsplash','unsplash','true','boolean',NULL,'2023-04-16 17:37:51','1','2023-04-16 17:37:51','1'),('643c326f002137342cf3252d','views','shared_views','[]','array',NULL,'2023-04-16 17:37:51','1','2023-04-16 17:37:51','1'),('643c326f002137342cf3252e','editor','editor_default_email_recipients','visibility','string',NULL,'2023-04-16 17:37:51','1','2023-04-16 17:37:51','1'),('643c326f002137342cf3252f','editor','editor_default_email_recipients_filter','all','string',NULL,'2023-04-16 17:37:51','1','2023-04-16 17:37:51','1'),('643c326f002137342cf32530','comments','comments_enabled','off','string',NULL,'2023-04-16 17:37:51','1','2023-04-16 17:37:51','1'),('643c326f002137342cf32531','analytics','outbound_link_tagging','true','boolean',NULL,'2023-04-16 17:37:51','1','2023-04-16 17:37:51','1'),('643c326f002137342cf32532','brainiacminds','aim_url','https://vontigo.services.brainiacminds.com/beta','string',NULL,'2023-05-08 17:37:51','1','2023-05-08 17:37:51','1'),('643c326f002137342cf32533','brainiacminds','aim_key','YOUR_OPENAI_KEY','string',NULL,'2023-05-08 17:37:51','1','2023-05-08 17:37:51','1'),('643c326f002137342cf32534','brainiacminds','aim_mainpoints','technology','string',NULL,'2023-05-08 17:37:51','1','2023-05-08 17:37:51','1'),('643c326f002137342cf32535','brainiacminds','aim_topics','artificial intelligence, ai','string',NULL,'2023-05-08 17:37:51','1','2023-05-08 17:37:51','1'),('643c326f002137342cf32536','brainiacminds','aim_custom_prompt','Write a high-quality article on \"{{title}}\" that is engaging and informative for readers. ','text',NULL,'2023-05-08 17:37:51','1','2023-05-08 17:37:51','1'),('643c326f002137342cf32537','brainiacminds','aim_using_custom_prompt','false','boolean',NULL,'2023-05-08 17:37:51','1','2023-05-08 17:37:51','1'),('643c326f002137342cf32538','brainiacminds','aim_temperature','0.1','number',NULL,'2023-05-08 17:37:51','1','2023-05-08 17:37:51','1'),('643c326f002137342cf32539','brainiacminds','aim_max_tokens','1000','number',NULL,'2023-05-08 17:37:51','1','2023-05-08 17:37:51','1'),('643c326f002137342cf32540','brainiacminds','aim_article_max_words','250','number',NULL,'2023-05-08 17:37:51','1','2023-05-08 17:37:51','1'),('643c326f002137342cf32541','google','iam_service_account_client_email','XXX.iam.gserviceaccount.com','string',NULL,'2023-05-08 17:37:51','1','2023-05-08 17:37:51','1'),('643c326f002137342cf32542','google','iam_service_account_private_key','-----BEGIN PRIVATE...','string',NULL,'2023-05-08 17:37:51','1','2023-05-08 17:37:51','1'),('643c326f002137342cf32543','google','analytics_measurement_id','G-1VTZ4YXXXX','string',NULL,'2023-05-08 17:37:51','1','2023-05-08 17:37:51','1'),('643c326f002137342cf32544','google','analytics_view_id','189586732','string',NULL,'2023-05-08 17:37:51','1','2023-05-08 17:37:51','1');
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `snippets`
--

DROP TABLE IF EXISTS `snippets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `snippets` (
  `id` varchar(24) NOT NULL,
  `name` varchar(191) NOT NULL,
  `mobiledoc` text NOT NULL,
  `lexical` text DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `created_by` varchar(24) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `snippets`
--

LOCK TABLES `snippets` WRITE;
/*!40000 ALTER TABLE `snippets` DISABLE KEYS */;
/*!40000 ALTER TABLE `snippets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stripe_products`
--

DROP TABLE IF EXISTS `stripe_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stripe_products` (
  `id` varchar(24) NOT NULL,
  `product_id` varchar(24) NOT NULL,
  `stripe_product_id` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `stripe_products_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stripe_products`
--

LOCK TABLES `stripe_products` WRITE;
/*!40000 ALTER TABLE `stripe_products` DISABLE KEYS */;
/*!40000 ALTER TABLE `stripe_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscriptions`
--

DROP TABLE IF EXISTS `subscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subscriptions` (
  `id` varchar(24) NOT NULL,
  `type` varchar(50) NOT NULL,
  `status` varchar(50) NOT NULL,
  `member_id` varchar(24) NOT NULL,
  `tier_id` varchar(24) NOT NULL,
  `cadence` varchar(50) DEFAULT NULL,
  `currency` varchar(50) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `payment_provider` varchar(50) DEFAULT NULL,
  `payment_subscription_url` varchar(2000) DEFAULT NULL,
  `payment_user_url` varchar(2000) DEFAULT NULL,
  `offer_id` varchar(24) DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `member_id` (`member_id`),
  KEY `tier_id` (`tier_id`),
  KEY `offer_id` (`offer_id`),
  CONSTRAINT `subscriptions_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE CASCADE,
  CONSTRAINT `subscriptions_ibfk_2` FOREIGN KEY (`tier_id`) REFERENCES `products` (`id`),
  CONSTRAINT `subscriptions_ibfk_3` FOREIGN KEY (`offer_id`) REFERENCES `offers` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscriptions`
--

LOCK TABLES `subscriptions` WRITE;
/*!40000 ALTER TABLE `subscriptions` DISABLE KEYS */;
/*!40000 ALTER TABLE `subscriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `suppressions`
--

DROP TABLE IF EXISTS `suppressions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `suppressions` (
  `id` varchar(24) NOT NULL,
  `email` varchar(191) NOT NULL,
  `email_id` varchar(24) DEFAULT NULL,
  `reason` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `email_id` (`email_id`),
  CONSTRAINT `suppressions_ibfk_1` FOREIGN KEY (`email_id`) REFERENCES `emails` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `suppressions`
--

LOCK TABLES `suppressions` WRITE;
/*!40000 ALTER TABLE `suppressions` DISABLE KEYS */;
/*!40000 ALTER TABLE `suppressions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tokens`
--

DROP TABLE IF EXISTS `tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tokens` (
  `id` varchar(24) NOT NULL,
  `token` varchar(32) NOT NULL,
  `data` varchar(2000) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `first_used_at` datetime DEFAULT NULL,
  `used_count` int(11) NOT NULL DEFAULT 0,
  `created_by` varchar(24) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tokens`
--

LOCK TABLES `tokens` WRITE;
/*!40000 ALTER TABLE `tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` varchar(24) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `profile_image` varchar(255) DEFAULT NULL,
  `cover_image` varchar(255) DEFAULT NULL,
  `bio` text DEFAULT NULL,
  `website` varchar(255) DEFAULT NULL,
  `location` text DEFAULT NULL,
  `facebook` varchar(255) DEFAULT NULL,
  `twitter` varchar(255) DEFAULT NULL,
  `accessibility` text DEFAULT NULL,
  `status` varchar(255) DEFAULT 'active',
  `locale` varchar(255) DEFAULT NULL,
  `visibility` varchar(255) DEFAULT 'public',
  `meta_title` varchar(255) DEFAULT NULL,
  `meta_description` varchar(255) DEFAULT NULL,
  `tour` text DEFAULT NULL,
  `last_seen` datetime DEFAULT NULL,
  `comment_notifications` tinyint(1) DEFAULT 1,
  `free_member_signup_notification` tinyint(1) DEFAULT 1,
  `paid_subscription_started_notification` tinyint(1) DEFAULT 1,
  `paid_subscription_canceled_notification` tinyint(1) DEFAULT 0,
  `mention_notifications` tinyint(1) DEFAULT 1,
  `milestone_notifications` tinyint(1) DEFAULT 1,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(24) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `users_FK` (`created_by`),
  KEY `users_FK_1` (`updated_by`),
  CONSTRAINT `users_FK` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `users_FK_1` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('1','Vontigo','vontigo','P@ssw0rd','contact@vontigo.org','/content/en-us/images/size/_raw/2023/05/1_Singuyen_2d_solid_logo_with_V_character_3b6024d5-96a2-4d19-9e88-ad28c9522cbf.png',NULL,'Love to smile! : V','https://vontigo.org','Ho Chi Minh City, Vietnam','',NULL,NULL,'active',NULL,'public',NULL,NULL,'Hello!','2023-04-20 14:45:00',1,1,1,0,1,1,'2023-04-16 17:37:44','1','2023-04-20 14:45:00','1');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `webhooks`
--

DROP TABLE IF EXISTS `webhooks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `webhooks` (
  `id` varchar(24) NOT NULL,
  `event` varchar(50) NOT NULL,
  `target_url` varchar(2000) NOT NULL,
  `name` varchar(191) DEFAULT NULL,
  `secret` varchar(191) DEFAULT NULL,
  `api_version` varchar(50) NOT NULL DEFAULT 'v2',
  `integration_id` varchar(24) NOT NULL,
  `last_triggered_at` datetime DEFAULT NULL,
  `last_triggered_status` varchar(50) DEFAULT NULL,
  `last_triggered_error` varchar(50) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `created_by` varchar(24) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `integration_id` (`integration_id`),
  CONSTRAINT `webhooks_ibfk_1` FOREIGN KEY (`integration_id`) REFERENCES `integrations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `webhooks`
--

LOCK TABLES `webhooks` WRITE;
/*!40000 ALTER TABLE `webhooks` DISABLE KEYS */;
/*!40000 ALTER TABLE `webhooks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'vontigo'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-05-27  1:39:53
