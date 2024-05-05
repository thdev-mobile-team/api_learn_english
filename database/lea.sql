-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th5 05, 2024 lúc 04:42 PM
-- Phiên bản máy phục vụ: 10.4.32-MariaDB
-- Phiên bản PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `lea`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `account`
--

CREATE TABLE `account` (
  `id_account` int(11) NOT NULL,
  `username` text DEFAULT NULL,
  `password` varchar(32) DEFAULT NULL,
  `email` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `account`
--

INSERT INTO `account` (`id_account`, `username`, `password`, `email`) VALUES
(1, 'user1', '5f4dcc3b5aa765d61d8327deb882cf99', 'user1@example.com'),
(2, 'user2', '5f4dcc3b5aa765d61d8327deb882cf99', 'user2@example.com'),
(3, 'user3', '5f4dcc3b5aa765d61d8327deb882cf99', 'user3@example.com'),
(4, 'user4', '5f4dcc3b5aa765d61d8327deb882cf99', 'user4@example.com'),
(5, 'user5', '5f4dcc3b5aa765d61d8327deb882cf99', 'user5@example.com');

--
-- Bẫy `account`
--
DELIMITER $$
CREATE TRIGGER `auto_increment_id_account` BEFORE INSERT ON `account` FOR EACH ROW BEGIN
    DECLARE max_id INT;
    SELECT MAX(id_account) INTO max_id FROM account;
    IF max_id IS NULL THEN
        SET NEW.id_account = 1;
    ELSE
        SET NEW.id_account = max_id + 1;
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `hash_password` BEFORE INSERT ON `account` FOR EACH ROW BEGIN
    SET NEW.password = MD5(NEW.password);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `folders`
--

CREATE TABLE `folders` (
  `id_folder` int(11) NOT NULL,
  `id_account` int(11) DEFAULT NULL,
  `name_folders` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `folders`
--

INSERT INTO `folders` (`id_folder`, `id_account`, `name_folders`) VALUES
(1, 1, 'Folder 1 của User 1'),
(2, 2, 'Folder 1 của User 2'),
(3, 3, 'Folder 1 của User 3'),
(4, 4, 'Folder 1 của User 4'),
(5, 5, 'Folder 1 của User 5');

--
-- Bẫy `folders`
--
DELIMITER $$
CREATE TRIGGER `auto_increment_id_folders` BEFORE INSERT ON `folders` FOR EACH ROW BEGIN
    DECLARE max_id INT;
    SELECT MAX(id_folder) INTO max_id FROM folders;
    IF max_id IS NULL THEN
        SET NEW.id_folder = 1;
    ELSE
        SET NEW.id_folder = max_id + 1;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `topics`
--

CREATE TABLE `topics` (
  `id_topic` int(11) NOT NULL,
  `id_folder` int(11) DEFAULT NULL,
  `name_topics` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `topics`
--

INSERT INTO `topics` (`id_topic`, `id_folder`, `name_topics`) VALUES
(1, 1, 'Chủ đề 1 của Folder 1'),
(2, 1, 'Chủ đề 2 của Folder 1'),
(3, 1, 'Chủ đề 3 của Folder 1'),
(4, 2, 'Chủ đề 1 của Folder 2'),
(5, 2, 'Chủ đề 2 của Folder 2'),
(6, 2, 'Chủ đề 3 của Folder 2'),
(7, 3, 'Chủ đề 1 của Folder 3'),
(8, 3, 'Chủ đề 2 của Folder 3'),
(9, 3, 'Chủ đề 3 của Folder 3'),
(10, 4, 'Chủ đề 1 của Folder 4'),
(11, 4, 'Chủ đề 2 của Folder 4'),
(12, 4, 'Chủ đề 3 của Folder 4'),
(13, 5, 'Chủ đề 1 của Folder 5'),
(14, 5, 'Chủ đề 2 của Folder 5'),
(15, 5, 'Chủ đề 3 của Folder 5');

--
-- Bẫy `topics`
--
DELIMITER $$
CREATE TRIGGER `auto_increment_id_topics` BEFORE INSERT ON `topics` FOR EACH ROW BEGIN
    DECLARE max_id INT;
    SELECT MAX(id_topic) INTO max_id FROM topics;
    IF max_id IS NULL THEN
        SET NEW.id_topic = 1;
    ELSE
        SET NEW.id_topic = max_id + 1;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `vocabulary`
--

CREATE TABLE `vocabulary` (
  `id_vocabulary` int(11) NOT NULL,
  `id_topic` int(11) DEFAULT NULL,
  `eng_vocabulary` text DEFAULT NULL,
  `vn_vocabulary` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `vocabulary`
--

INSERT INTO `vocabulary` (`id_vocabulary`, `id_topic`, `eng_vocabulary`, `vn_vocabulary`) VALUES
(1, 1, 'Word 1 của Chủ đề 1', 'Từ 1 của Chủ đề 1'),
(2, 1, 'Word 2 của Chủ đề 1', 'Từ 2 của Chủ đề 1'),
(3, 1, 'Word 3 của Chủ đề 1', 'Từ 3 của Chủ đề 1'),
(4, 1, 'Word 4 của Chủ đề 1', 'Từ 4 của Chủ đề 1'),
(5, 1, 'Word 5 của Chủ đề 1', 'Từ 5 của Chủ đề 1'),
(6, 1, 'Word 6 của Chủ đề 1', 'Từ 6 của Chủ đề 1'),
(7, 2, 'Word 1 của Chủ đề 2', 'Từ 1 của Chủ đề 2'),
(8, 2, 'Word 2 của Chủ đề 2', 'Từ 2 của Chủ đề 2'),
(9, 2, 'Word 3 của Chủ đề 2', 'Từ 3 của Chủ đề 2'),
(10, 2, 'Word 4 của Chủ đề 2', 'Từ 4 của Chủ đề 2'),
(11, 2, 'Word 5 của Chủ đề 2', 'Từ 5 của Chủ đề 2'),
(12, 2, 'Word 6 của Chủ đề 2', 'Từ 6 của Chủ đề 2'),
(13, 3, 'Word 1 của Chủ đề 3', 'Từ 1 của Chủ đề 3'),
(14, 3, 'Word 2 của Chủ đề 3', 'Từ 2 của Chủ đề 3'),
(15, 3, 'Word 3 của Chủ đề 3', 'Từ 3 của Chủ đề 3'),
(16, 3, 'Word 4 của Chủ đề 3', 'Từ 4 của Chủ đề 3'),
(17, 3, 'Word 5 của Chủ đề 3', 'Từ 5 của Chủ đề 3'),
(18, 3, 'Word 6 của Chủ đề 3', 'Từ 6 của Chủ đề 3'),
(19, 4, 'Word 1 của Chủ đề 4', 'Từ 1 của Chủ đề 4'),
(20, 4, 'Word 2 của Chủ đề 4', 'Từ 2 của Chủ đề 4'),
(21, 4, 'Word 3 của Chủ đề 4', 'Từ 3 của Chủ đề 4'),
(22, 4, 'Word 4 của Chủ đề 4', 'Từ 4 của Chủ đề 4'),
(23, 4, 'Word 5 của Chủ đề 4', 'Từ 5 của Chủ đề 4'),
(24, 4, 'Word 6 của Chủ đề 4', 'Từ 6 của Chủ đề 4'),
(25, 5, 'Word 1 của Chủ đề 5', 'Từ 1 của Chủ đề 5'),
(26, 5, 'Word 2 của Chủ đề 5', 'Từ 2 của Chủ đề 5'),
(27, 5, 'Word 3 của Chủ đề 5', 'Từ 3 của Chủ đề 5'),
(28, 5, 'Word 4 của Chủ đề 5', 'Từ 4 của Chủ đề 5'),
(29, 5, 'Word 5 của Chủ đề 5', 'Từ 5 của Chủ đề 5'),
(30, 5, 'Word 6 của Chủ đề 5', 'Từ 6 của Chủ đề 5');

--
-- Bẫy `vocabulary`
--
DELIMITER $$
CREATE TRIGGER `auto_increment_id_vocabulary` BEFORE INSERT ON `vocabulary` FOR EACH ROW BEGIN
    DECLARE max_id INT;
    SELECT MAX(id_vocabulary) INTO max_id FROM vocabulary;
    IF max_id IS NULL THEN
        SET NEW.id_vocabulary = 1;
    ELSE
        SET NEW.id_vocabulary = max_id + 1;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `vocabulary_love`
--

CREATE TABLE `vocabulary_love` (
  `id_vocabulary_love` int(11) NOT NULL,
  `eng_vocabulary_love` text DEFAULT NULL,
  `vn_vocabulary_love` text DEFAULT NULL,
  `id_account` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `account`
--
ALTER TABLE `account`
  ADD PRIMARY KEY (`id_account`);

--
-- Chỉ mục cho bảng `folders`
--
ALTER TABLE `folders`
  ADD PRIMARY KEY (`id_folder`),
  ADD KEY `id_account` (`id_account`);

--
-- Chỉ mục cho bảng `topics`
--
ALTER TABLE `topics`
  ADD PRIMARY KEY (`id_topic`),
  ADD KEY `id_folder` (`id_folder`);

--
-- Chỉ mục cho bảng `vocabulary`
--
ALTER TABLE `vocabulary`
  ADD PRIMARY KEY (`id_vocabulary`),
  ADD KEY `id_topic` (`id_topic`);

--
-- Chỉ mục cho bảng `vocabulary_love`
--
ALTER TABLE `vocabulary_love`
  ADD PRIMARY KEY (`id_vocabulary_love`),
  ADD KEY `id_account` (`id_account`);

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `folders`
--
ALTER TABLE `folders`
  ADD CONSTRAINT `folders_ibfk_1` FOREIGN KEY (`id_account`) REFERENCES `account` (`id_account`);

--
-- Các ràng buộc cho bảng `topics`
--
ALTER TABLE `topics`
  ADD CONSTRAINT `topics_ibfk_1` FOREIGN KEY (`id_folder`) REFERENCES `folders` (`id_folder`);

--
-- Các ràng buộc cho bảng `vocabulary`
--
ALTER TABLE `vocabulary`
  ADD CONSTRAINT `vocabulary_ibfk_1` FOREIGN KEY (`id_topic`) REFERENCES `topics` (`id_topic`);

--
-- Các ràng buộc cho bảng `vocabulary_love`
--
ALTER TABLE `vocabulary_love`
  ADD CONSTRAINT `vocabulary_love_ibfk_1` FOREIGN KEY (`id_account`) REFERENCES `account` (`id_account`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
