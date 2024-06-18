-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 27, 2024 at 08:26 PM
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
-- Database: `flightmanagementsystem`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `CheckUserEmailExists` (IN `userEmail` VARCHAR(100), OUT `emailExists` BOOLEAN)   BEGIN
    DECLARE emailCount INT;
    -- Count the number of records with the given email
    SELECT COUNT(*)
    INTO emailCount
    FROM users
    WHERE email = userEmail;
    -- Set the emailExists output parameter based on the count
    IF emailCount > 0 THEN
        SET emailExists = TRUE;
    ELSE
        SET emailExists = FALSE;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertUser` (IN `p_first_name` VARCHAR(50), IN `p_last_name` VARCHAR(50), IN `p_email` VARCHAR(100), IN `p_password` VARCHAR(100))   BEGIN
    INSERT INTO users (first_name, last_name, username, email, password)
    VALUES (p_first_name, p_last_name, p_username, p_email, p_password);
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `TotalPassengersForFlight` (`p_FlightID` INT) RETURNS INT(11)  BEGIN
    DECLARE total_passengers INT;
    SELECT SUM(adultsNo + childrenNo) INTO total_passengers
    FROM Bookings
    WHERE FlightID = p_FlightID;
    
    RETURN total_passengers;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `airlines`
--

CREATE TABLE `airlines` (
  `AirlineID` int(11) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Code` char(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `airlines`
--

INSERT INTO `airlines` (`AirlineID`, `Name`, `Code`) VALUES
(5551, 'Turkish Airlines', 'TK'),
(5552, 'British Airways', 'BA'),
(5553, 'American Airlines', 'AA'),
(5554, 'Japan Airlines', 'JL'),
(5555, 'Emirates', 'EK');

-- --------------------------------------------------------

--
-- Table structure for table `airports`
--

CREATE TABLE `airports` (
  `AirportID` int(11) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Code` char(3) NOT NULL,
  `City` varchar(100) NOT NULL,
  `Country` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `airports`
--

INSERT INTO `airports` (`AirportID`, `Name`, `Code`, `City`, `Country`) VALUES
(823, 'Istanbul Airport', 'IST', 'Istanbul', 'Turkey'),
(824, 'Heathrow Airport', 'LHR', 'London', 'UK'),
(825, 'John F. Kennedy International Airport', 'JFK', 'New York', 'USA'),
(826, 'Tokyo Haneda Airport', 'HND', 'Tokyo', 'Japan'),
(827, 'Dubai International Airport', 'DXB', 'Dubai', 'UAE');

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `BookingID` int(11) NOT NULL,
  `PassengerID` int(11) DEFAULT NULL,
  `employeeID` int(11) DEFAULT NULL,
  `FlightID` int(11) DEFAULT NULL,
  `BookingDate` datetime NOT NULL,
  `SeatNumber` varchar(5) DEFAULT NULL,
  `adultsNo` int(11) DEFAULT NULL,
  `childrenNo` int(11) DEFAULT NULL,
  `CabinClass` enum('Economy','Business') NOT NULL,
  `price` int(11) NOT NULL,
  `meal` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`BookingID`, `PassengerID`, `employeeID`, `FlightID`, `BookingDate`, `SeatNumber`, `adultsNo`, `childrenNo`, `CabinClass`, `price`, `meal`) VALUES
(8881, 2221, 1112, 3331, '2024-05-20 12:00:00', '12A', 1, 0, 'Economy', 300, 'Vegetarian'),
(8882, 2222, 1113, 3332, '2024-05-21 15:00:00', '14B', 2, 1, 'Business', 900, 'Non-Vegetarian'),
(8883, 2223, 1114, 3333, '2024-05-22 10:00:00', '15C', 1, 2, 'Economy', 600, 'Vegetarian'),
(8884, 2224, 1115, 3334, '2024-05-23 11:00:00', '16D', 2, 0, 'Business', 1200, 'Non-Vegetarian'),
(8885, 2225, 1116, 3335, '2024-05-24 16:00:00', '17E', 1, 1, 'Economy', 700, 'Vegetarian'),
(8886, 2226, 1117, 3331, '2024-05-25 17:00:00', NULL, 0, 2, 'Business', 1100, 'Non-Vegetarian'),
(8887, 2227, 1118, 3332, '2024-05-26 18:00:00', '18F', 1, 0, 'Economy', 400, 'Vegetarian'),
(8888, 2228, 1119, 3333, '2024-05-27 19:00:00', '19G', 2, 1, 'Business', 1300, 'Non-Vegetarian'),
(8889, 2229, 1120, 3334, '2024-05-28 20:00:00', '20H', 0, 0, 'Economy', 500, 'Vegetarian'),
(8890, 2230, 1121, 3335, '2024-05-29 21:00:00', NULL, 2, 2, 'Business', 1400, 'Non-Vegetarian');

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `employeeID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `salary` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`employeeID`, `userID`, `salary`) VALUES
(1112, 11, 50000),
(1113, 12, 60000),
(1114, 13, 55000),
(1115, 14, 65000),
(1116, 15, 70000),
(1117, 16, 45000),
(1118, 17, 48000),
(1119, 18, 52000),
(1120, 19, 47000),
(1121, 20, 51000);

-- --------------------------------------------------------

--
-- Stand-in structure for view `employeedetails`
-- (See below for the actual view)
--
CREATE TABLE `employeedetails` (
`employeeID` int(11)
,`userID` int(11)
,`salary` int(11)
,`first_name` varchar(50)
,`last_name` varchar(50)
,`email` varchar(100)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `flightdetails`
-- (See below for the actual view)
--
CREATE TABLE `flightdetails` (
`FlightID` int(11)
,`FlightNumber` varchar(10)
,`AirlineName` varchar(100)
,`DepartureAirportName` varchar(100)
,`ArrivalAirportName` varchar(100)
,`DepartureTime` datetime
,`ArrivalTime` datetime
);

-- --------------------------------------------------------

--
-- Table structure for table `flights`
--

CREATE TABLE `flights` (
  `FlightID` int(11) NOT NULL,
  `FlightNumber` varchar(10) NOT NULL,
  `AirlineID` int(11) DEFAULT NULL,
  `DepartureAirportID` int(11) DEFAULT NULL,
  `ArrivalAirportID` int(11) DEFAULT NULL,
  `DepartureTime` datetime NOT NULL,
  `ArrivalTime` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `flights`
--

INSERT INTO `flights` (`FlightID`, `FlightNumber`, `AirlineID`, `DepartureAirportID`, `ArrivalAirportID`, `DepartureTime`, `ArrivalTime`) VALUES
(3331, 'TK100', 5551, 824, 823, '2024-06-01 10:00:00', '2024-06-01 14:00:00'),
(3332, 'BA200', 5552, 823, 824, '2024-06-02 08:00:00', '2024-06-02 10:00:00'),
(3333, 'AA300', 5553, 825, 823, '2024-06-03 12:00:00', '2024-06-03 16:00:00'),
(3334, 'JL400', 5554, 826, 823, '2024-06-04 14:00:00', '2024-06-04 20:00:00'),
(3335, 'EK500', 5555, 827, 823, '2024-06-05 18:00:00', '2024-06-05 22:00:00');

--
-- Triggers `flights`
--
DELIMITER $$
CREATE TRIGGER `trg_update_arrival_time` BEFORE UPDATE ON `flights` FOR EACH ROW BEGIN
    SET NEW.ArrivalTime = NEW.DepartureTime + (OLD.ArrivalTime - OLD.DepartureTime);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `passengerdetails`
-- (See below for the actual view)
--
CREATE TABLE `passengerdetails` (
`PassengerID` int(11)
,`userID` int(11)
,`PassportNo` varchar(20)
,`first_name` varchar(50)
,`last_name` varchar(50)
,`email` varchar(100)
);

-- --------------------------------------------------------

--
-- Table structure for table `passengers`
--

CREATE TABLE `passengers` (
  `PassengerID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `PassportNo` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `passengers`
--

INSERT INTO `passengers` (`PassengerID`, `userID`, `PassportNo`) VALUES
(2221, 1, 'A12345678'),
(2222, 2, 'B12345678'),
(2223, 3, 'C12345678'),
(2224, 4, 'D12345678'),
(2225, 5, 'E12345678'),
(2226, 6, 'F12345678'),
(2227, 7, 'G12345678'),
(2228, 8, 'H12345678'),
(2229, 9, 'I12345678'),
(2230, 10, 'J12345678');

--
-- Triggers `passengers`
--
DELIMITER $$
CREATE TRIGGER `trg_prevent_passenger_deletion` BEFORE DELETE ON `passengers` FOR EACH ROW BEGIN
    DECLARE count_bookings INT;
    SELECT COUNT(*) INTO count_bookings
    FROM Bookings
    WHERE PassengerID = OLD.PassengerID;

    IF count_bookings > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete passenger with linked bookings';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `userID` int(11) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`userID`, `first_name`, `last_name`, `email`, `password`) VALUES
(1, 'John', 'Doe', 'john.doe@example.com', 'password1'),
(2, 'Jane', 'Doe', 'jane.doe@example.com', 'password2'),
(3, 'Alice', 'Smith', 'alice.smith@example.com', 'password3'),
(4, 'Bob', 'Brown', 'bob.brown@example.com', 'password4'),
(5, 'Charlie', 'Davis', 'charlie.davis@example.com', 'password5'),
(6, 'David', 'Evans', 'david.evans@example.com', 'password6'),
(7, 'Eve', 'Foster', 'eve.foster@example.com', 'password7'),
(8, 'Frank', 'Green', 'frank.green@example.com', 'password8'),
(9, 'Grace', 'Harris', 'grace.harris@example.com', 'password9'),
(10, 'Henry', 'Ivy', 'henry.ivy@example.com', 'password10'),
(11, 'Ivy', 'Jones', 'ivy.jones@example.com', 'password11'),
(12, 'Jack', 'King', 'jack.king@example.com', 'password12'),
(13, 'Karen', 'Lee', 'karen.lee@example.com', 'password13'),
(14, 'Leo', 'Morris', 'leo.morris@example.com', 'password14'),
(15, 'Mona', 'Nelson', 'mona.nelson@example.com', 'password15'),
(16, 'Nick', 'Owen', 'nick.owen@example.com', 'password16'),
(17, 'Olivia', 'Perez', 'olivia.perez@example.com', 'password17'),
(18, 'Paul', 'Quinn', 'paul.quinn@example.com', 'password18'),
(19, 'Quinn', 'Reed', 'quinn.reed@example.com', 'password19'),
(20, 'Rachel', 'Smith', 'rachel.smith@example.com', 'password20');

-- --------------------------------------------------------

--
-- Structure for view `employeedetails`
--
DROP TABLE IF EXISTS `employeedetails`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `employeedetails`  AS SELECT `e`.`employeeID` AS `employeeID`, `e`.`userID` AS `userID`, `e`.`salary` AS `salary`, `u`.`first_name` AS `first_name`, `u`.`last_name` AS `last_name`, `u`.`email` AS `email` FROM (`employee` `e` join `users` `u` on(`e`.`userID` = `u`.`userID`)) ;

-- --------------------------------------------------------

--
-- Structure for view `flightdetails`
--
DROP TABLE IF EXISTS `flightdetails`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `flightdetails`  AS SELECT `f`.`FlightID` AS `FlightID`, `f`.`FlightNumber` AS `FlightNumber`, `a`.`Name` AS `AirlineName`, `dep`.`Name` AS `DepartureAirportName`, `arr`.`Name` AS `ArrivalAirportName`, `f`.`DepartureTime` AS `DepartureTime`, `f`.`ArrivalTime` AS `ArrivalTime` FROM (((`flights` `f` join `airlines` `a` on(`f`.`AirlineID` = `a`.`AirlineID`)) join `airports` `dep` on(`f`.`DepartureAirportID` = `dep`.`AirportID`)) join `airports` `arr` on(`f`.`ArrivalAirportID` = `arr`.`AirportID`)) ;

-- --------------------------------------------------------

--
-- Structure for view `passengerdetails`
--
DROP TABLE IF EXISTS `passengerdetails`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `passengerdetails`  AS SELECT `p`.`PassengerID` AS `PassengerID`, `p`.`userID` AS `userID`, `p`.`PassportNo` AS `PassportNo`, `u`.`first_name` AS `first_name`, `u`.`last_name` AS `last_name`, `u`.`email` AS `email` FROM (`passengers` `p` join `users` `u` on(`p`.`userID` = `u`.`userID`)) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `airlines`
--
ALTER TABLE `airlines`
  ADD PRIMARY KEY (`AirlineID`),
  ADD UNIQUE KEY `Code` (`Code`);

--
-- Indexes for table `airports`
--
ALTER TABLE `airports`
  ADD PRIMARY KEY (`AirportID`),
  ADD UNIQUE KEY `Code` (`Code`);

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`BookingID`),
  ADD KEY `employeeID` (`employeeID`),
  ADD KEY `PassengerID` (`PassengerID`),
  ADD KEY `FlightID` (`FlightID`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`employeeID`),
  ADD KEY `userID` (`userID`);

--
-- Indexes for table `flights`
--
ALTER TABLE `flights`
  ADD PRIMARY KEY (`FlightID`),
  ADD KEY `AirlineID` (`AirlineID`),
  ADD KEY `DepartureAirportID` (`DepartureAirportID`),
  ADD KEY `ArrivalAirportID` (`ArrivalAirportID`);

--
-- Indexes for table `passengers`
--
ALTER TABLE `passengers`
  ADD PRIMARY KEY (`PassengerID`),
  ADD UNIQUE KEY `PassportNo` (`PassportNo`),
  ADD KEY `userID` (`userID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`userID`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`employeeID`) REFERENCES `employee` (`employeeID`),
  ADD CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`PassengerID`) REFERENCES `passengers` (`PassengerID`),
  ADD CONSTRAINT `bookings_ibfk_3` FOREIGN KEY (`FlightID`) REFERENCES `flights` (`FlightID`);

--
-- Constraints for table `employee`
--
ALTER TABLE `employee`
  ADD CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`);

--
-- Constraints for table `flights`
--
ALTER TABLE `flights`
  ADD CONSTRAINT `flights_ibfk_1` FOREIGN KEY (`AirlineID`) REFERENCES `airlines` (`AirlineID`),
  ADD CONSTRAINT `flights_ibfk_2` FOREIGN KEY (`DepartureAirportID`) REFERENCES `airports` (`AirportID`),
  ADD CONSTRAINT `flights_ibfk_3` FOREIGN KEY (`ArrivalAirportID`) REFERENCES `airports` (`AirportID`);

--
-- Constraints for table `passengers`
--
ALTER TABLE `passengers`
  ADD CONSTRAINT `passengers_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
