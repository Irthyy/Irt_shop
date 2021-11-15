CREATE TABLE IF NOT EXISTS `items` (
  `name` varchar(50) NOT NULL,
  `label` varchar(50) NOT NULL,
  `limit` int(11) NOT NULL DEFAULT '-1',
  `rare` int(11) NOT NULL DEFAULT '0',
  `can_remove` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
('bread', 'Pain', 5, 0, 1),
('hamburger', 'Hamburger', 3, 0, 1),
('pizza', 'Pizza', 3, 0, 1),
('water', 'Eau', 5, 0, 1),
('coca', 'Coca', 5, 0, 1),
('icetea', 'Ice-Tea', 5, 0, 1),
('phone', 'Téléphone', 5, 0, 1);
COMMIT;
