-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th1 31, 2024 lúc 04:58 AM
-- Phiên bản máy phục vụ: 10.4.27-MariaDB
-- Phiên bản PHP: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `studentmanagement`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `absent`
--

CREATE TABLE `absent` (
  `id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `note` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `absent`
--

INSERT INTO `absent` (`id`, `student_id`, `date`, `note`) VALUES
(22, 1, '2023-12-14', 'Việc gia đình, không phép'),
(24, 1, '2024-01-06', 'Chấn thương'),
(27, 1, '2024-01-25', 'Không phép'),
(31, 1, '2024-01-03', 'Không phép'),
(32, 1, '2024-01-04', 'Đi viện'),
(34, 1, '2024-01-02', 'Ngủ muộn'),
(35, 1, '2024-01-18', 'Không phép'),
(37, 1, '2024-01-11', 'Sốt');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `basic_skills`
--

CREATE TABLE `basic_skills` (
  `student_id` int(11) NOT NULL,
  `listening` varchar(250) DEFAULT NULL,
  `speaking` varchar(250) DEFAULT NULL,
  `reading` varchar(250) DEFAULT NULL,
  `writing` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `basic_skills`
--

INSERT INTO `basic_skills` (`student_id`, `listening`, `speaking`, `reading`, `writing`) VALUES
(1, 'Kĩ năng nghe khá', 'Nói chưa lưu loát', 'Đọc tốt', 'Viết ẩu, qua loa'),
(2, 'Tốt', 'Khá', 'Tốt', 'Khá'),
(3, NULL, NULL, NULL, NULL),
(4, NULL, NULL, NULL, NULL),
(5, NULL, NULL, NULL, NULL),
(6, NULL, NULL, NULL, NULL),
(7, NULL, NULL, NULL, NULL),
(8, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `class`
--

CREATE TABLE `class` (
  `id` int(11) NOT NULL,
  `class_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `class`
--

INSERT INTO `class` (`id`, `class_name`) VALUES
(1, '11A2'),
(2, '11C1'),
(3, '11A3'),
(4, '10A1'),
(5, '12A1'),
(6, '12C1'),
(7, '10C1'),
(10, '11A1');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `essay`
--

CREATE TABLE `essay` (
  `student_id` int(11) NOT NULL,
  `first` varchar(250) DEFAULT NULL,
  `second` varchar(250) DEFAULT NULL,
  `third` varchar(250) DEFAULT NULL,
  `fourth` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `essay`
--

INSERT INTO `essay` (`student_id`, `first`, `second`, `third`, `fourth`) VALUES
(1, 'Khá ổn', 'Ổn', 'Chưa được', 'OK'),
(2, 'chưa được', 'tạm ổn', 'khá ổn', 'tốt'),
(3, NULL, NULL, NULL, NULL),
(4, NULL, NULL, NULL, NULL),
(5, NULL, NULL, NULL, NULL),
(6, NULL, NULL, NULL, NULL),
(7, NULL, NULL, NULL, NULL),
(8, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `marks`
--

CREATE TABLE `marks` (
  `student_id` int(11) NOT NULL,
  `entrance_mark` float DEFAULT NULL,
  `semester_1_mark` float DEFAULT NULL,
  `year_mark` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `marks`
--

INSERT INTO `marks` (`student_id`, `entrance_mark`, `semester_1_mark`, `year_mark`) VALUES
(1, 5, 7, 9),
(2, 6, 7, 9),
(3, NULL, NULL, NULL),
(4, NULL, NULL, NULL),
(5, NULL, NULL, NULL),
(6, NULL, NULL, NULL),
(7, NULL, NULL, NULL),
(8, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `multiple_choice`
--

CREATE TABLE `multiple_choice` (
  `student_id` int(11) NOT NULL,
  `first` varchar(250) DEFAULT NULL,
  `second` varchar(250) DEFAULT NULL,
  `third` varchar(250) DEFAULT NULL,
  `fourth` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `multiple_choice`
--

INSERT INTO `multiple_choice` (`student_id`, `first`, `second`, `third`, `fourth`) VALUES
(1, 'Tạm ổn', 'Chưa tốt', 'Có khá hơn ', 'Tốt, amazing goodjob e! '),
(2, 'OK', 'not good', 'OK', 'OK'),
(3, NULL, NULL, NULL, NULL),
(4, NULL, NULL, NULL, NULL),
(5, NULL, NULL, NULL, NULL),
(6, NULL, NULL, NULL, NULL),
(7, NULL, NULL, NULL, NULL),
(8, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `student`
--

CREATE TABLE `student` (
  `id` int(11) NOT NULL,
  `name` varchar(250) NOT NULL,
  `class_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `student`
--

INSERT INTO `student` (`id`, `name`, `class_id`) VALUES
(1, 'Vi Lô Hùng', 2),
(2, 'Nguyễn Văn Hoan', 4),
(3, 'Lê Hoàng Việt', 7),
(4, 'Tăng Tiến Linh', 1),
(5, 'Hoàng Đăng Vinh', 2),
(6, 'Trần Quang Đạo', 6),
(7, 'Nguyễn Đức Quân', 5),
(8, 'Hồ Công Anh', 3);

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `absent`
--
ALTER TABLE `absent`
  ADD PRIMARY KEY (`id`),
  ADD KEY `student_id` (`student_id`);

--
-- Chỉ mục cho bảng `basic_skills`
--
ALTER TABLE `basic_skills`
  ADD PRIMARY KEY (`student_id`);

--
-- Chỉ mục cho bảng `class`
--
ALTER TABLE `class`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `essay`
--
ALTER TABLE `essay`
  ADD PRIMARY KEY (`student_id`);

--
-- Chỉ mục cho bảng `marks`
--
ALTER TABLE `marks`
  ADD PRIMARY KEY (`student_id`);

--
-- Chỉ mục cho bảng `multiple_choice`
--
ALTER TABLE `multiple_choice`
  ADD PRIMARY KEY (`student_id`);

--
-- Chỉ mục cho bảng `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`id`),
  ADD KEY `class_id` (`class_id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `absent`
--
ALTER TABLE `absent`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT cho bảng `class`
--
ALTER TABLE `class`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT cho bảng `student`
--
ALTER TABLE `student`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `absent`
--
ALTER TABLE `absent`
  ADD CONSTRAINT `absent_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `student` (`id`);

--
-- Các ràng buộc cho bảng `basic_skills`
--
ALTER TABLE `basic_skills`
  ADD CONSTRAINT `basic_skills_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `student` (`id`);

--
-- Các ràng buộc cho bảng `essay`
--
ALTER TABLE `essay`
  ADD CONSTRAINT `essay_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `student` (`id`);

--
-- Các ràng buộc cho bảng `marks`
--
ALTER TABLE `marks`
  ADD CONSTRAINT `marks_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `student` (`id`);

--
-- Các ràng buộc cho bảng `multiple_choice`
--
ALTER TABLE `multiple_choice`
  ADD CONSTRAINT `multiple_choice_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `student` (`id`);

--
-- Các ràng buộc cho bảng `student`
--
ALTER TABLE `student`
  ADD CONSTRAINT `student_ibfk_1` FOREIGN KEY (`class_id`) REFERENCES `class` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
