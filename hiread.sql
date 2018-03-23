/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50532
Source Host           : 127.0.0.1:3306
Source Database       : hiread

Target Server Type    : MYSQL
Target Server Version : 50532
File Encoding         : 65001

Date: 2018-02-01 17:23:43
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for hi_config
-- ----------------------------
DROP TABLE IF EXISTS `hi_config`;
CREATE TABLE `hi_config` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Field` char(30) DEFAULT '' COMMENT '字段名',
  `Value` varchar(255) DEFAULT '' COMMENT '值',
  `Mark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Field` (`Field`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hi_config
-- ----------------------------
INSERT INTO `hi_config` VALUES ('1', 'SelectReadLevel', '{\"15\":1,\"22\":2,\"27\":3,\"30\":4,\"32\":5}', '水平测试');
INSERT INTO `hi_config` VALUES ('2', 'Suggest', '{\"1\":{\"80\":\"1\",\"100\":\"1_2\"},\"2\":{\"30\":\"1\",\"80\":\"1_2\",\"100\":\"2_3\"},\"3\":{\"30\":\"2\",\"80\":\"2_3\",\"100\":\"3_4\"},\"4\":{\"30\":\"3\",\"80\":\"3_4\",\"100\":\"4_5\"},\"5\":{\"30\":\"4\",\"80\":\"4_5\",\"90\":\"5_6\",\"100\":\"6_7\"}}', '推荐读物');

-- ----------------------------
-- Table structure for hi_conf_category
-- ----------------------------
DROP TABLE IF EXISTS `hi_conf_category`;
CREATE TABLE `hi_conf_category` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(20) NOT NULL DEFAULT '' COMMENT '分类名称',
  `Pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父类别',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hi_conf_category
-- ----------------------------
INSERT INTO `hi_conf_category` VALUES ('1', 'Fiction', '0');
INSERT INTO `hi_conf_category` VALUES ('2', 'Nonfiction\r\n', '1');

-- ----------------------------
-- Table structure for hi_conf_coupon
-- ----------------------------
DROP TABLE IF EXISTS `hi_conf_coupon`;
CREATE TABLE `hi_conf_coupon` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '代金券ID',
  `Name` varchar(20) NOT NULL DEFAULT '' COMMENT '代金券名称',
  `Type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '代金券类型(1:现金券)',
  `Price` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '代金券面值',
  `Expire` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '代金券有效期',
  PRIMARY KEY (`ID`),
  KEY `Type` (`Type`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='代金券';

-- ----------------------------
-- Records of hi_conf_coupon
-- ----------------------------
INSERT INTO `hi_conf_coupon` VALUES ('1', '5元代金券', '1', '5', '31536000');
INSERT INTO `hi_conf_coupon` VALUES ('2', '10元代金券', '1', '10', '31536000');
INSERT INTO `hi_conf_coupon` VALUES ('3', '20元代金券', '1', '20', '31536000');

-- ----------------------------
-- Table structure for hi_conf_course
-- ----------------------------
DROP TABLE IF EXISTS `hi_conf_course`;
CREATE TABLE `hi_conf_course` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Level` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '级别',
  `Category` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '分类',
  `ProdName` varchar(50) NOT NULL DEFAULT '' COMMENT '课程名称',
  `Name` varchar(200) NOT NULL DEFAULT '' COMMENT '书名',
  `CoverImg` varchar(200) NOT NULL DEFAULT '' COMMENT '封面图',
  `CouponID` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '可用代金券',
  `Integral` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '可用积分兑换',
  `Price` double(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '课程价格',
  `DiscountPrice` double unsigned NOT NULL DEFAULT '0' COMMENT '优惠价格',
  `Desc` blob NOT NULL COMMENT '课程描述',
  `Description` text COMMENT '学习中心描述',
  `Lexile` varchar(20) NOT NULL DEFAULT '' COMMENT '蓝斯指数',
  `Atos` varchar(20) NOT NULL DEFAULT '' COMMENT 'ATOS值',
  `MinAge` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '最小适用年龄',
  `MaxAge` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '最大适用年龄',
  `WordsCount` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '字数',
  `ImportWords` varchar(20) NOT NULL DEFAULT '' COMMENT '重点单词',
  `DetailImg` varchar(200) NOT NULL DEFAULT '' COMMENT '简介图片',
  `Expire` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '有效期',
  `Suggest` text COMMENT '推荐理由',
  `Author` varchar(200) DEFAULT NULL COMMENT '作者头像',
  `AuthorAbout` text COMMENT '关于作者',
  `Harvest` text COMMENT '课程收获',
  `CourseTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '课时数',
  `Tech` text COMMENT '关键阅读技巧',
  `UnitCount` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '单元数量',
  `SUnitCount` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '子单元数量',
  PRIMARY KEY (`ID`),
  KEY `Level` (`Level`) USING BTREE,
  KEY `Category` (`Category`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='课程表';

-- ----------------------------
-- Records of hi_conf_course
-- ----------------------------
INSERT INTO `hi_conf_course` VALUES ('1', '2', '2', '雪橇英雄Balto - 最勇敢的狗: 巴尔托的真实故事', 'The Bravest Dog Ever:The True Story of Balto', 'L2-Balto/Balto_Cover.png', '0', '0', '499.00', '399', 0x477261646520312D332D2D204120636F6D70656C6C696E67206163636F756E742C20746F6C6420696E20656173792D746F2D7265616420666F726D61742C206F6642616C746F2C206120736C656420646F672077686F206C656420686973207465616D207468726F75676820736E6F7720616E6420696365206F7665722035336D696C6573206F66206E6F72746865726E20416C61736B612077696C6465726E65737320746F2064656C6976657220736F6D65206D65646963696E652E2054686573746F7279206973206261736564206F6E20616E2061637475616C206576656E742074686174206F6363757272656420696E203139323520647572696E6720616E6F7574627265616B206F66206469707468657269612C207768656E2074686520636C6F73657374206D65646963696E652077617320383030206D696C65732061776179696E20416E63686F726167652E205768656E2074686520747261696E2062656172696E672074686520696D706F7274616E7420636172676F20626563616D6562757269656420696E2074686520736E6F77207374696C6C20373030206D696C65732066726F6D206974732064657374696E6174696F6E2C206120646F6720736C656472656C61792077617320757365642E20436F6F6B277320736F66746C7920636F6C6F72656420696C6C757374726174696F6E73206172652065787072657373697665616E6420656E68616E636520746865206472616D61206F66207468652073746F72792D2D612070726F756420616E64206865726F69632073746F72792074686174796F756E6720726561646572, 'Grade 1-3-- A compelling account, told in easy-to-read format, ofBalto, a sled dog who led his team through snow and ice over 53miles of northern Alaska wilderness to deliver some medicine. Thestory is based on an actual event that occurred in 1925 during anoutbreak of diptheria, when the closest medicine was 800 miles awayin Anchorage. When the train bearing the important cargo becameburied in the snow still 700 miles from its destination, a dog sledrelay was used. Cook\'s softly colored illustrations are expressiveand enhance the drama of the story--a proud and heroic story thatyoung reader', '510L', '2.5', '5', '12', '1224', '60', 'L2-Balto/Author_of_Balto.png', '12', '你有听过Balto的真实故事吗？知道美国纽约著名的中央公园里的那座狗狗的雕像是谁吗？对啦，它就是最勇敢的雪橇狗Balto！\n\n这本美国兰登经典分级读物，广受美国小朋友欢迎，是一本非常棒的历史题材Nonfiction非虚构书，讲述了Balto拯救整个城市的英勇事迹。让我们一起来看看它到底有多勇敢，又是如何在最糟糕的暴风雪里拯救小镇Nome居民的。\n\nIt is one of the worst storms ever--the snow has not stopped for days and it is 30 degrees below zero. But somehow Balto must get through. He is the lead dog of his sled team. And he is carrying medicine to sick children miles away in Nome, Alaska. He is their only hope. Can Balto find his way through the terrible storm? Find out in this exciting true story!\n\n左图是本书的作者Natalie Standiford在纽约中央公园Balto雕像前的合影。', '', '', '培养阅读兴趣；提高阅读水平；开拓知识面；激发思辨能力；', '28', 'The main topic 了解主旨意思；The connection within a text 上下文的联系； Understand the meaning of multiple-meaning words 理解一词多义', '8', '28');
INSERT INTO `hi_conf_course` VALUES ('2', '1', '1', '小毛人：参观消防局', 'Little Critter: Going to the Firehouse (My First I Can Read)', 'L1-Firehouse/Little_Critter-Going_to_the_Firehouse_Cover.jpeg', '0', '0', '299.00', '9.9', 0xF09F8C9FE69C80E58F97E6ACA2E8BF8EE79A84E58E9FE78988E99885E8AFBBE590AFE8929920492043616E205265616420E7B3BBE58897E4B89BE4B9A6EFBC9B0AF09F8C9FE6B7B1E585A5E4BABAE5BF83E79A84204C6974746C65204372697474657220E585A8E79083E79585E99480E4B889E58D81E5B9B4E380820A4C6974746C652043726974746572E8BF99E4B8AAE7B3BBE58897E69585E4BA8BE794B14D6572636572204D61796572E5889BE4BD9CEFBC8CE794BBE9A38EE6988EE5BFABEFBC8CE5AF8CE69C89E7949FE6B4BBE69599E882B2E6848FE591B3E38082E6AF8FE4B8AAE4B8BBE9A298E983BDE4B88EE5ADA9E5AD90E79A84E7949FE6B4BBE681AFE681AFE79BB8E585B3EFBC8CE99D9EE5B8B8E58F97E6ACA2E8BF8EE3808231393433E5B9B4E587BAE7949FE79A844D6572636572E4B88EE5A48FE5A881E5A4B7E6AA80E9A699E5B1B1E7BE8EE69CAFE9A686E69C89E79D80E4B88DE8A7A3E4B98BE7BC98EFBC8CE5B9B6E4BF9DE68C81E79D80E4B880E588BBE7BAAFE58780E79A84E7ABA5E5BF83EFBC8CE4BB96E4B88EE5A6BBE5AD9047696E61E585B1E5908CE5889BE4BD9CE4BA86E5B08FE680AAE789A9E7B3BBE58897EFBC8CE9809AE8BF87E5B08FE680AAE789A9E789B9E69C89E79A84E8A786E8A792E5928CE5ADA9E5AD90E4BBACE7A89AE5ABA9E79A84E6809DE7BBB4E6A8A1E5BC8FE8A782E5AF9FE4BD93E4BC9AE79D80E591A8E981ADE4B896E7958CE58F91E7949FE79A84E4B880E58887E38082E4B880E4B8AAE4B8AAE69585E4BA8BE8AEA9E5ADA9E5AD90E4BBACE4BAA7E7949FE5BCBAE78388E79A84E585B1E9B8A3EFBC8CE8AEA9E788B6E6AF8DE4BBACE5AFB9E5ADA9E5AD90E4BBACE79A8420E6B798E6B094E68DA3E89B8BE69C89E4BA86E4B88DE5908CE8A792E5BAA6E79A84E8AEA4E8AF86E5928CE79086E8A7A3EFBC8CE4B99FE69599E68891E4BBACE4BBA5E4B880E9A297E69BB4E4B8BAE5AEBDE5AEB9E79A84E5BF83E58EBBE79086E8A7A3E5928CE58C85E5AEB9E68890E995BFE4B8ADE79A84E5ADA9E5AD90EFBC8CE4BBA4E4BB96E4BBACE58585E58886E4BD93E9AA8CE4BAB2E68385E38081E58F8BE8B08AEFBC8CE4BF9DE79599E58FAFE8B4B5E79A84E7ABA5E5BF83E38082, 'Little Critter and his classmates are visiting the firehouse, where Little Critter tries on boots and a jacket. Now he\'s ready to help Fireman Joe. But the most important part of being a fireman is knowing how to be safe when fighting a fire. \n\n小毛人和他的同学们在参观消防局，小毛人在那儿试穿了消防靴和消防夹克。他准备好了去帮助消防员Joe。但是要成为消防员最重要的是知道在灭火的时候怎样保证安全。', '310L', '1.1', '4', '9', '263', '30', 'L1-Firehouse/About_the_book.png', '12', 'L1-Firehouse/Recommend_Words.jpeg', 'L1-Firehouse/Author_of_Firehosue_Mercer-Mayer.jpeg', 'Mercer Mayer has been writing and illustrating books for children for more than forty years. His most recognized character, the lovable and charismatic Little Critter was born in 1975 in the book Just for You. Mercer\'s Little Critter has since starred in more than two hundred books and sold over one hundred and fifty million copies. Born in Arkansas, Mercer now lives in Connecticut with his family.\n美世·梅尔已经给孩子们写童书，画插画40多年了。他的最具标志性的角色，可爱迷人的小毛人诞生于1975年。美世的小毛人在200多本书中担任小主角，迄今已经卖出了1亿5000万册。美世·梅尔出生于美国阿肯色州，现在和他的家人住在美国康乃迪克州。\n\n', '积累自然生动的语句；培养阅读兴趣；提高阅读水平；开拓知识面；', '20', 'Main topic and Key details 文章主旨和细节；The connection within a text 上下文的联系； Compare and Contrast 对比和比较', '6', '20');
INSERT INTO `hi_conf_course` VALUES ('3', '1', '1', '皮特猫系列：皮特在海滩', 'Pete the Cat: Pete at the Beach (My First I Can Read)', 'L1-Pete_at_the_Beach/Pete_at_the_Beach_Cover.jpeg', '0', '0', '299.00', '199', 0x50657465206973207370656E64696E672074686520646179206174207468652062656163682E204865206861732066756E20636F6C6C656374696E67207368656C6C7320616E64206275696C64696E6720612073616E6420636173746C652C2062757420746865206265616368206973207665727920686F742E20546865726520697320612077686F6C65206F6365616E20666F72205065746520746F20636F6F6C206F666620696E2C20627574206974206C6F6F6B732073636172792E205065746527732062726F746865722C20426F622C206F666665727320746F207465616368205065746520746F20737572662E, 'Pete is spending the day at the beach. He has fun collecting shells and building a sand castle, but the beach is very hot. There is a whole ocean for Pete to cool off in, but it looks scary. Pete\'s brother, Bob, offers to teach Pete to surf.', '280L', '1.3', '4', '9', '343', '30', 'L1-Pete_at_the_Beach/Pete_header-cat.png', '12', 'Pete at the Beach is a My First I Can Read book.It is designed to excite and engage beginning readers.Reading aloud to a child is the first step to helping a kid become a great reader.', 'L1-Pete_at_the_Beach/James_Dean_Author.jpeg', 'James Dean\'s art has sold in more than ninety galleries and shops across the United States. He has devoted his paintings to Pete the Cat for ten years and has turned his natural love for cats into his life\'s work. James published his first adult book, The Misadventures of Pete the Cat, a history of his artwork, in 2006. He illustrated his first self-published children\'s book, Pete the Cat: I Love My White Shoes, in 2008, and the follow-up book, Pete the Cat: Rocking in My School Shoes, in 2011. James lives in Atlanta, Georgia, with his wife, four cats, and one dog.', '积累自然生动的语句；培养阅读兴趣；提高阅读水平；开拓知识面；', '20', 'Main topic and Key details 文章主旨和细节；\nThe connection within a text 上下文的联系； \nMake a Prediction 做预测', '6', '20');
INSERT INTO `hi_conf_course` VALUES ('4', '2', '1', '小脏狗哈利', 'Harry the Dirty Dog', 'L2-Harry_the_Dirty_Dog/Harry_the_Dirty_Dog_Cover.jpeg', '0', '0', '499.00', '399', 0x47656E65205A696F6E20616E64204D6172676172657420426C6F792047726168616D2054686572652773206E65766572206265656E20616E6F7468657220646F672061732064656C6967687466756C2D6F722064697274792D61732048617272792E2054686973206C6F7661626C6520776869746520646F67207769746820626C61636B2073706F747320286F7220626C61636B20646F6720776974682077686974652073706F7473292068617320636861726D6564206368696C6472656E20666F722066696674792079656172732C20616E64207765206172652063656C6562726174696E67207769746820616E20616E6E69766572736172792065646974696F6E2E2054686973206368696C64686F6F64206661766F7572697465206973207065726665637420666F722072656164696E6720616C6F7564206265666F726520676F696E6720746F20626564206F722061766F6964696E67206120626174682E, 'Harry is a white dog with black spots who hates to take a bath.\n\nOne day he gets so dirty he has black fur with white spots!\n\nWhere\'s Harry?', 'AD520L', '3.1', '5', '12', '463', '60', 'L2-Harry_the_Dirty_Dog/Harry.jpeg', '12', 'Harry was a white dog with black spots who liked everything, except getting a bath.\" Taking matters into his own paws, he buries his family\'s scrubbing brush in the backyard and runs away from home before they can wrangle him into the tub. Harry gets dirty playing in the street, dirtier at the railroad, and dirtier still playing tag with the other dogs. When sliding down the coal chute, he actually changes from a white dog with black spots to a black dog with white spots! Of course, by the time he gets home he is completely unrecognizable to his family--even when he does all his clever flip-flopping tricks. In a stroke of doggy genius, he unearths the bath brush, begs for a bath, and the rest is history. Youngsters will completely relate to the urge to rebel, the thrill of getting dirty, and, finally, the reassurance of family. Gene Zion and Margaret Bloy Graham\'s Harry the Dirty Dog, first published in 1956 and now rereleased with splashes of color added by the artist herself, is one of those picture books that children never forget. \n\n--Karin Snelson ', 'L2-Harry_the_Dirty_Dog/Margaret_Bloy_Graham_and_Gene_Zion.jpeg', 'Gene Zion and two-time Caldecott Honor winner Margaret Bloy Graham have collaborated on several favorite stories about Harry: Harry by the Sea, Harry the Dirty Dog, and No Roses for Harry.', '培养阅读兴趣；提高阅读水平；开拓知识面；激发思辨能力；', '28', 'The main topic 了解主旨意思；The connection within a text 上下文的联系； Understand the meaning of multiple-meaning words 理解一词多义', '8', '28');
INSERT INTO `hi_conf_course` VALUES ('5', '3', '1', 'A to Z 神秘案件：闹鬼的旅馆', 'A to Z Mysteries: The Haunted Hotel', 'L3-The_Hunted_Hotel/The_Haunted_Hotel_Cover.jpeg', '0', '0', '799.00', '699', 0x412067686F73746C792067756573742068617320636865636B656420696E746F20746865205368616E6772692D6C6120486F74656C21204974277320616C6D6F73742048616C6C6F7765656E20616E64207265706F727473206F6620737472616E676520736F756E647320616E64206576656E20737472616E676572207369676874732061726520636F6D696E672066726F6D20477265656E204C61776E2773206F6E6C7920686F74656C2E20486F74656C2067756573747320616E64206E65696768626F727320617265206265696E672073636172656420617761792C20616E64206974277320757020746F2044696E6B2C204A6F73682C20616E64205275746820526F736520746F20666967757265206F75742077686174277320676F696E67206F6E2D2D6265666F726520477265656E204C61776E207475726E7320696E746F20612067686F737420746F776E21, 'A ghostly guest has checked into the Shangri-la Hotel! It\'s almost Halloween and reports of strange sounds and even stranger sights are coming from Green Lawn\'s only hotel. Hotel guests and neighbors are being scared away, and it\'s up to Dink, Josh, and Ruth Rose to figure out what\'s going on--before Green Lawn turns into a ghost town!', '510L', '3.4', '5', '15', '8287', '100', 'L3-The_Hunted_Hotel/The_Haunted_Hotel_Cover.jpeg', '12', 'Help Dink, Josh, and Ruth Rose solve mysteries from A to Z in this chapter book that\'s perfect for Halloween! \n“A to Z 神秘案件”系列是美国兰登书屋倾力打造的经典儿童侦探小说系列，畅销50余年，销量超过800万册，被广大读者称为“最适合孩子们阅读的书”和“最佳简易儿童文学读物”。\n在美国，这套广受欢迎的儿童侦探小说也被公认为最佳简易读本系列之一。书中的文字浅显易懂，情节紧凑，非常适合小学高年级和中学低年级的中国孩子阅读。阅读中文，小读者可以尽享阅读的乐趣，让想象力随着情节起伏而自由飞翔；阅读英文，进入英文思考模式中，对英文会话、阅读和写作相当有帮助！', 'L3-The_Hunted_Hotel/Author_The_Haunted_Hotel.png', 'RON ROY has been writing books for children since 1974. He is the author of dozens of books, including the popular A to Z Mysteries®, Calendar Mysteries, and Capital Mysteries. When not working on a new book, Ron likes to teach tricks to his dog Pal, play poker with friends, travel, and read thrilling mystery books.\n\nSTEPHEN GILPIN is the award-winning illustrator of dozens of children’s books, including the popular and very funny Pirate Mom. He brings his fresh, kid-friendly style to all the covers of the A to Z Mysteries® series.', '培养阅读兴趣；提高阅读水平；开拓知识面；激发思辨能力；', '56', 'The main topic 了解主旨意思；The connection within a text 上下文的联系； Understand the meaning of multiple-meaning words 理解一词多义', '14', '52');

-- ----------------------------
-- Table structure for hi_conf_course_catalog
-- ----------------------------
DROP TABLE IF EXISTS `hi_conf_course_catalog`;
CREATE TABLE `hi_conf_course_catalog` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `CourseId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '课程ID',
  `SUnitId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '子单元ID',
  `Name` varchar(255) NOT NULL DEFAULT '' COMMENT '目录名称',
  `Min` tinyint(10) unsigned NOT NULL DEFAULT '0' COMMENT '分',
  `Sec` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '秒',
  PRIMARY KEY (`ID`),
  KEY `cs` (`CourseId`,`SUnitId`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=58 DEFAULT CHARSET=utf8 COMMENT='课程目录表';

-- ----------------------------
-- Records of hi_conf_course_catalog
-- ----------------------------
INSERT INTO `hi_conf_course_catalog` VALUES ('1', '1', '5', 'Book Introduction 本书介绍', '0', '4');
INSERT INTO `hi_conf_course_catalog` VALUES ('2', '1', '5', 'A Statue of Balto 纽约中央公园的雕像', '1', '28');
INSERT INTO `hi_conf_course_catalog` VALUES ('3', '1', '5', 'Extended Reading 拓展 - Nome, Alaska', '5', '36');
INSERT INTO `hi_conf_course_catalog` VALUES ('4', '1', '5', 'Extended Reading 拓展 - Dog Sleds', '7', '40');
INSERT INTO `hi_conf_course_catalog` VALUES ('5', '1', '5', 'Grammar Time 语法时间', '13', '50');
INSERT INTO `hi_conf_course_catalog` VALUES ('6', '1', '5', 'Sing Time - 20 Dogs 歌曲视频', '22', '22');
INSERT INTO `hi_conf_course_catalog` VALUES ('7', '1', '9', 'Previously on Balto 上节回顾', '0', '37');
INSERT INTO `hi_conf_course_catalog` VALUES ('8', '1', '9', 'Extended Reading 拓展 - Diphtheria', '4', '22');
INSERT INTO `hi_conf_course_catalog` VALUES ('9', '1', '9', 'Extended Reading 拓展 - Math Link ', '10', '13');
INSERT INTO `hi_conf_course_catalog` VALUES ('10', '1', '9', 'Extended Reading 拓展 -Dog Relay', '13', '55');
INSERT INTO `hi_conf_course_catalog` VALUES ('11', '1', '9', 'Grammar Time 语法时间', '20', '51');
INSERT INTO `hi_conf_course_catalog` VALUES ('12', '1', '9', 'Sing Time - I Love Dogs 歌曲视频', '26', '54');
INSERT INTO `hi_conf_course_catalog` VALUES ('13', '1', '13', 'Previously on Balto 上节回顾', '0', '36');
INSERT INTO `hi_conf_course_catalog` VALUES ('14', '1', '13', 'Extended Reading 拓展 - The Race to Nome', '4', '4');
INSERT INTO `hi_conf_course_catalog` VALUES ('15', '1', '13', 'Extended Reading 拓展 - How to Read a Map?', '5', '30');
INSERT INTO `hi_conf_course_catalog` VALUES ('16', '1', '13', 'Extended Reading 拓展 - Blizzard', '10', '14');
INSERT INTO `hi_conf_course_catalog` VALUES ('17', '1', '13', 'Grammar Time 语法时间', '20', '18');
INSERT INTO `hi_conf_course_catalog` VALUES ('18', '1', '13', 'Extended Reading 拓展 - Book Report', '23', '54');
INSERT INTO `hi_conf_course_catalog` VALUES ('19', '1', '13', 'Fun Time - Arctic Dogsledding 趣味视频', '27', '30');
INSERT INTO `hi_conf_course_catalog` VALUES ('20', '1', '17', 'Previously on Balto 上节回顾', '0', '31');
INSERT INTO `hi_conf_course_catalog` VALUES ('21', '1', '17', 'Extended Reading 思维导图 - Character', '10', '34');
INSERT INTO `hi_conf_course_catalog` VALUES ('22', '1', '17', 'Extended Reading 拓展 - Events ', '17', '23');
INSERT INTO `hi_conf_course_catalog` VALUES ('23', '1', '17', 'Grammar Time 语法时间', '20', '1');
INSERT INTO `hi_conf_course_catalog` VALUES ('24', '1', '17', 'Extended Reading 拓展 - Ice Cracking', '23', '34');
INSERT INTO `hi_conf_course_catalog` VALUES ('25', '1', '17', 'Fun Time - Dog Does Maths 趣味视频', '27', '17');
INSERT INTO `hi_conf_course_catalog` VALUES ('26', '1', '21', 'Previously on Balto 上节回顾', '0', '32');
INSERT INTO `hi_conf_course_catalog` VALUES ('27', '1', '21', 'Extended Reading 拓展 - Powdery Snow', '5', '22');
INSERT INTO `hi_conf_course_catalog` VALUES ('28', '1', '21', 'Extended Reading 拓展 - What else can Powdery Snow do?', '6', '26');
INSERT INTO `hi_conf_course_catalog` VALUES ('29', '1', '21', 'Grammar Time 语法时间', '18', '59');
INSERT INTO `hi_conf_course_catalog` VALUES ('30', '1', '21', 'Sing Time - Lovely Time with Dog 歌曲视频', '23', '55');
INSERT INTO `hi_conf_course_catalog` VALUES ('31', '1', '25', 'Previously on Balto 上节回顾', '0', '39');
INSERT INTO `hi_conf_course_catalog` VALUES ('32', '1', '25', 'Extended Reading 拓展 - Math Link', '5', '30');
INSERT INTO `hi_conf_course_catalog` VALUES ('33', '1', '25', 'Extended Reading 拓展 - The Town of Nome was Saved!', '11', '22');
INSERT INTO `hi_conf_course_catalog` VALUES ('34', '1', '25', 'Extended Reading 拓展 - A Statue of Balto', '18', '58');
INSERT INTO `hi_conf_course_catalog` VALUES ('35', '1', '25', 'Grammar Time 语法时间', '21', '23');
INSERT INTO `hi_conf_course_catalog` VALUES ('36', '1', '25', 'Story Line - 梳理故事线', '23', '40');
INSERT INTO `hi_conf_course_catalog` VALUES ('37', '1', '25', 'More About Balto 更多关于Balto - 思维导图', '26', '17');
INSERT INTO `hi_conf_course_catalog` VALUES ('38', '1', '25', 'Fun Time - Balto视频', '27', '51');
INSERT INTO `hi_conf_course_catalog` VALUES ('39', '2', '33', 'Book Introduction 本书介绍', '0', '27');
INSERT INTO `hi_conf_course_catalog` VALUES ('40', '2', '33', 'Extended Reading 拓展 \n- Fireman and Fire Dog', '5', '16');
INSERT INTO `hi_conf_course_catalog` VALUES ('41', '2', '33', 'Extended Reading 拓展 \n- Fireman’s Outfit', '9', '31');
INSERT INTO `hi_conf_course_catalog` VALUES ('42', '2', '33', 'Grammar Time 语法时间', '12', '57');
INSERT INTO `hi_conf_course_catalog` VALUES ('43', '2', '33', 'Sing Time 歌曲视频\n- Little Firefighter', '16', '10');
INSERT INTO `hi_conf_course_catalog` VALUES ('44', '2', '37', 'Extended Reading 拓展 \n- Fire Pole', '2', '10');
INSERT INTO `hi_conf_course_catalog` VALUES ('45', '2', '37', 'Extended Reading 拓展 \n- Fire Truck', '4', '12');
INSERT INTO `hi_conf_course_catalog` VALUES ('46', '2', '37', 'Grammar Time 语法时间', '10', '55');
INSERT INTO `hi_conf_course_catalog` VALUES ('47', '2', '37', 'Sing Time 歌曲视频\n- Hurry Hurry Drive the Firetruck', '14', '55');
INSERT INTO `hi_conf_course_catalog` VALUES ('48', '2', '41', 'Extended Reading 拓展 \n- Fireman Ladder', '1', '11');
INSERT INTO `hi_conf_course_catalog` VALUES ('49', '2', '41', 'Extended Reading 拓展 \n- Fire Safety Tips', '11', '14');
INSERT INTO `hi_conf_course_catalog` VALUES ('50', '2', '41', 'Grammar Time 语法时间', '13', '11');
INSERT INTO `hi_conf_course_catalog` VALUES ('51', '2', '41', 'Sing Time 歌曲视频\n- Fire Truck', '16', '17');
INSERT INTO `hi_conf_course_catalog` VALUES ('52', '2', '45', 'Extended Reading 拓展 \n- I am a Little Fireman', '4', '45');
INSERT INTO `hi_conf_course_catalog` VALUES ('53', '2', '45', 'Extended Reading 拓展 \n- Emergency Phone Number', '10', '13');
INSERT INTO `hi_conf_course_catalog` VALUES ('54', '2', '45', 'Extended Reading 拓展 \n- International Firefighter Day', '10', '49');
INSERT INTO `hi_conf_course_catalog` VALUES ('55', '2', '45', 'Grammar Time 语法时间', '11', '23');
INSERT INTO `hi_conf_course_catalog` VALUES ('56', '2', '45', 'Extended Reading 拓展 \n- More About Firehouse', '14', '14');
INSERT INTO `hi_conf_course_catalog` VALUES ('57', '2', '45', 'Sing Time 歌曲视频\n- Firefighter', '15', '27');

-- ----------------------------
-- Table structure for hi_conf_course_outline
-- ----------------------------
DROP TABLE IF EXISTS `hi_conf_course_outline`;
CREATE TABLE `hi_conf_course_outline` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `CourseId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '课程ID',
  `Name` varchar(255) NOT NULL DEFAULT '' COMMENT '章节名称',
  `Desc` varchar(255) NOT NULL DEFAULT '' COMMENT '单元描述',
  PRIMARY KEY (`ID`),
  KEY `c` (`CourseId`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=66 DEFAULT CHARSET=utf8 COMMENT='课程大纲';

-- ----------------------------
-- Records of hi_conf_course_outline
-- ----------------------------
INSERT INTO `hi_conf_course_outline` VALUES ('20', '1', '课前热身 Warm up ', '课前测');
INSERT INTO `hi_conf_course_outline` VALUES ('21', '1', '第1单元 Unit 1', '引入最勇敢的雪橇犬Balto的真实故事；\n原文精读+拓展知识+在线课前、课中、课后练习。');
INSERT INTO `hi_conf_course_outline` VALUES ('22', '1', '第2单元 Unit 2', '在遥远的阿拉斯加Nome小镇，居民生病了，没有抗毒素药怎么办？\n原文精读+拓展知识+在线课前、课中、课后练习。');
INSERT INTO `hi_conf_course_outline` VALUES ('23', '1', '外教小班视频课一（可选）', '回顾、梳理第1&2单元重点知识，答疑解惑、互动讨论、提高阅读兴趣、启发辨证思考。');
INSERT INTO `hi_conf_course_outline` VALUES ('24', '1', '第3单元 Unit 3', '激动人心的狗拉雪橇运输药物接力开始啦！\n原文精读+拓展知识+在线课前、课中、课后练习。');
INSERT INTO `hi_conf_course_outline` VALUES ('25', '1', '第4单元 Unit 4', 'Balto和其它的狗狗能在暴风雪里成功把药送到Nome吗？\n原文精读+拓展知识+在线课前、课中、课后练习。');
INSERT INTO `hi_conf_course_outline` VALUES ('26', '1', '外教小班视频课二（可选）', '回顾、梳理第3&4单元重点知识，答疑解惑、互动讨论、提高阅读兴趣、启发辨证思考。');
INSERT INTO `hi_conf_course_outline` VALUES ('27', '1', '第5单元 Unit 5', '沉着冷静、聪明而又勇敢的Balto!\n原文精读+拓展知识+在线课前、课中、课后练习。');
INSERT INTO `hi_conf_course_outline` VALUES ('28', '1', '第6单元 Unit 6', '越过千难万阻，成功了！得救了！\n原文精读+拓展知识+在线课前、课中、课后练习。');
INSERT INTO `hi_conf_course_outline` VALUES ('29', '1', '外教小班视频课三（可选）', '回顾、梳理整本书的重点知识，答疑解惑、互动讨论、提高阅读兴趣、启发辨证思考。');
INSERT INTO `hi_conf_course_outline` VALUES ('30', '1', '结业测试', '完成课后测试+Free Talk, 提供完整的学习报告给到学生和家长。');
INSERT INTO `hi_conf_course_outline` VALUES ('39', '3', '课前热身 Warm up ', '课前测');
INSERT INTO `hi_conf_course_outline` VALUES ('40', '3', '第1单元 Unit 1', 'Little Critter和他的同学们来消防局参观，让我们一起来看看吧！\n原文精读+拓展知识+在线课前、课中、课后练习。');
INSERT INTO `hi_conf_course_outline` VALUES ('41', '3', '第2单元 Unit 2', 'Little Critter在消防局看到消防滑杆，红色的大消防车，还会有什么呢？\n原文精读+拓展知识+在线课前、课中、课后练习。');
INSERT INTO `hi_conf_course_outline` VALUES ('42', '3', '外教小班视频课一（可选）', '回顾、梳理第1&2单元重点知识，答疑解惑、互动讨论、提高阅读兴趣、启发辨证思考。');
INSERT INTO `hi_conf_course_outline` VALUES ('43', '3', '第3单元 Unit 3', 'Wow! 消防梯好高，火警笛好响！还可以学到实用消防安全小知识。\n原文精读+拓展知识+在线课前、课中、课后练习。');
INSERT INTO `hi_conf_course_outline` VALUES ('44', '3', '第4单元 Unit 4', 'Fireman Joe给他们准备了小惊喜，会是什么呢？\n原文精读+拓展知识+在线课前、课中、课后练习。');
INSERT INTO `hi_conf_course_outline` VALUES ('45', '3', '外教小班视频课二（可选）', '回顾、梳理第3&4单元重点知识，答疑解惑、互动讨论、提高阅读兴趣、启发辨证思考。');
INSERT INTO `hi_conf_course_outline` VALUES ('46', '3', '结业测试', '完成课后测试+Free Talk, 提供完整的学习报告给到学生和家长。');
INSERT INTO `hi_conf_course_outline` VALUES ('47', '4', '课前热身 Warm up ', '课前测');
INSERT INTO `hi_conf_course_outline` VALUES ('48', '4', '第1单元 Unit 1', '引入最勇敢的雪橇犬Balto的真实故事；\n原文精读+拓展知识+在线课前、课中、课后练习。');
INSERT INTO `hi_conf_course_outline` VALUES ('49', '4', '第2单元 Unit 2', '在遥远的阿拉斯加Nome小镇，居民生病了，没有抗毒素药怎么办？\n原文精读+拓展知识+在线课前、课中、课后练习。');
INSERT INTO `hi_conf_course_outline` VALUES ('50', '4', '外教小班视频课一（可选）', '回顾、梳理第1&2单元重点知识，答疑解惑、互动讨论、提高阅读兴趣、启发辨证思考。');
INSERT INTO `hi_conf_course_outline` VALUES ('51', '4', '第3单元 Unit 3', '激动人心的狗拉雪橇运输药物接力开始啦！\n原文精读+拓展知识+在线课前、课中、课后练习。');
INSERT INTO `hi_conf_course_outline` VALUES ('52', '4', '第4单元 Unit 4', 'Balto和其它的狗狗能在暴风雪里成功把药送到Nome吗？\n原文精读+拓展知识+在线课前、课中、课后练习。');
INSERT INTO `hi_conf_course_outline` VALUES ('53', '4', '外教小班视频课二（可选）', '回顾、梳理第3&4单元重点知识，答疑解惑、互动讨论、提高阅读兴趣、启发辨证思考。');
INSERT INTO `hi_conf_course_outline` VALUES ('54', '4', '第5单元 Unit 5', '沉着冷静、聪明而又勇敢的Balto!\n原文精读+拓展知识+在线课前、课中、课后练习。');
INSERT INTO `hi_conf_course_outline` VALUES ('55', '4', '第6单元 Unit 6', '越过千难万阻，成功了！得救了！\n原文精读+拓展知识+在线课前、课中、课后练习。');
INSERT INTO `hi_conf_course_outline` VALUES ('56', '4', '外教小班视频课三（可选）', '回顾、梳理整本书的重点知识，答疑解惑、互动讨论、提高阅读兴趣、启发辨证思考。');
INSERT INTO `hi_conf_course_outline` VALUES ('57', '4', '结业测试', '完成课后测试+Free Talk, 提供完整的学习报告给到学生和家长。');
INSERT INTO `hi_conf_course_outline` VALUES ('58', '2', '课前热身 Warm up ', '课前测');
INSERT INTO `hi_conf_course_outline` VALUES ('59', '2', '第1单元 Unit 1', 'Little Critter和他的同学们来消防局参观，让我们一起来看看吧！\n原文精读+拓展知识+在线课前、课中、课后练习。');
INSERT INTO `hi_conf_course_outline` VALUES ('60', '2', '第2单元 Unit 2', 'Little Critter在消防局看到消防滑杆，红色的大消防车，还会有什么呢？\n原文精读+拓展知识+在线课前、课中、课后练习。');
INSERT INTO `hi_conf_course_outline` VALUES ('61', '2', '外教小班视频课一（可选）', '回顾、梳理第1&2单元重点知识，答疑解惑、互动讨论、提高阅读兴趣、启发辨证思考。');
INSERT INTO `hi_conf_course_outline` VALUES ('62', '2', '第3单元 Unit 3', 'Wow! 消防梯好高，火警笛好响！还可以学到实用消防安全小知识。\n原文精读+拓展知识+在线课前、课中、课后练习。');
INSERT INTO `hi_conf_course_outline` VALUES ('63', '2', '第4单元 Unit 4', 'Fireman Joe给他们准备了小惊喜，会是什么呢？\n原文精读+拓展知识+在线课前、课中、课后练习。');
INSERT INTO `hi_conf_course_outline` VALUES ('64', '2', '外教小班视频课二（可选）', '回顾、梳理第3&4单元重点知识，答疑解惑、互动讨论、提高阅读兴趣、启发辨证思考。');
INSERT INTO `hi_conf_course_outline` VALUES ('65', '2', '结业测试', '完成课后测试+Free Talk, 提供完整的学习报告给到学生和家长。');

-- ----------------------------
-- Table structure for hi_conf_course_package
-- ----------------------------
DROP TABLE IF EXISTS `hi_conf_course_package`;
CREATE TABLE `hi_conf_course_package` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `CourseId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '课程ID',
  `FileName` varchar(50) NOT NULL DEFAULT '' COMMENT '文件名称',
  `FileSize` char(10) NOT NULL DEFAULT '' COMMENT '文件大小',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='课程包';

-- ----------------------------
-- Records of hi_conf_course_package
-- ----------------------------
INSERT INTO `hi_conf_course_package` VALUES ('1', '1', 'L2-Balto/My_Book_Report.pdf', '163 KB');
INSERT INTO `hi_conf_course_package` VALUES ('2', '2', 'L1-Firehouse/Little_Critter_Wordscramble.jpeg', '108 KB');
INSERT INTO `hi_conf_course_package` VALUES ('3', '2', 'L1-Firehouse/Do_Hellodot.pdf', '101 KB');
INSERT INTO `hi_conf_course_package` VALUES ('4', '2', 'L1-Firehouse/Coloring_Page-Happy_Halloween.pdf', '202 KB');

-- ----------------------------
-- Table structure for hi_conf_course_word
-- ----------------------------
DROP TABLE IF EXISTS `hi_conf_course_word`;
CREATE TABLE `hi_conf_course_word` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `CourseId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '课程ID',
  `SUnitId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '子单元ID',
  `Word` varchar(100) NOT NULL DEFAULT '' COMMENT '词汇',
  `Min` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '分',
  `Sec` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '秒',
  PRIMARY KEY (`ID`),
  KEY `CS` (`CourseId`,`SUnitId`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=42 DEFAULT CHARSET=utf8 COMMENT='视频词汇表';

-- ----------------------------
-- Records of hi_conf_course_word
-- ----------------------------
INSERT INTO `hi_conf_course_word` VALUES ('1', '1', '5', 'illustrated  \nv. 给…加插画', '0', '26');
INSERT INTO `hi_conf_course_word` VALUES ('2', '1', '5', 'statue \nn. 雕像；塑像', '0', '42');
INSERT INTO `hi_conf_course_word` VALUES ('3', '1', '5', 'remember \nv. 纪念', '1', '50');
INSERT INTO `hi_conf_course_word` VALUES ('4', '1', '5', 'attempt \nv. 企图；试图', '3', '33');
INSERT INTO `hi_conf_course_word` VALUES ('5', '1', '5', 'temperature \nn. 温度', '5', '55');
INSERT INTO `hi_conf_course_word` VALUES ('6', '1', '5', 'extreme \nn. 极端，最大程度', '14', '18');
INSERT INTO `hi_conf_course_word` VALUES ('7', '2', '33', 'prevent \nv. 阻止', '2', '30');
INSERT INTO `hi_conf_course_word` VALUES ('8', '2', '33', 'dalmatian\nn. 斑点狗', '5', '53');
INSERT INTO `hi_conf_course_word` VALUES ('10', '2', '33', 'hood\nn. 面罩', '10', '32');
INSERT INTO `hi_conf_course_word` VALUES ('11', '2', '33', 'protect\nv. 保护', '10', '40');
INSERT INTO `hi_conf_course_word` VALUES ('12', '2', '33', 'gloves\nn. 手套', '10', '47');
INSERT INTO `hi_conf_course_word` VALUES ('15', '2', '33', 'prompt \nadj. 敏捷的；迅速的', '16', '48');
INSERT INTO `hi_conf_course_word` VALUES ('16', '2', '33', 'mission\nn. 任务', '16', '17');
INSERT INTO `hi_conf_course_word` VALUES ('17', '2', '37', 'expression (exp.)\nn. 词组', '1', '12');
INSERT INTO `hi_conf_course_word` VALUES ('18', '2', '37', 'surface \nn. 表面', '1', '17');
INSERT INTO `hi_conf_course_word` VALUES ('19', '2', '37', 'right away\nexp. 马上', '5', '23');
INSERT INTO `hi_conf_course_word` VALUES ('20', '2', '37', 'race\nv. 全速行进', '5', '30');
INSERT INTO `hi_conf_course_word` VALUES ('21', '2', '37', 'spray\nv. 喷', '5', '55');
INSERT INTO `hi_conf_course_word` VALUES ('22', '2', '37', 'hurry\nv. 赶快', '14', '54');
INSERT INTO `hi_conf_course_word` VALUES ('23', '2', '37', 'corner\nn. 拐角处', '15', '15');
INSERT INTO `hi_conf_course_word` VALUES ('24', '2', '37', 'squirt\nv. 喷射', '15', '57');
INSERT INTO `hi_conf_course_word` VALUES ('25', '2', '37', 'slowly\nadv. 慢慢地', '16', '11');
INSERT INTO `hi_conf_course_word` VALUES ('26', '2', '41', 'protect\nv. 保护\nhide\nv. 隐藏', '5', '50');
INSERT INTO `hi_conf_course_word` VALUES ('27', '2', '41', 'gas\nn. 气体\ndust\nn. 灰尘；尘土', '7', '46');
INSERT INTO `hi_conf_course_word` VALUES ('28', '2', '41', 'dangerous\nadj. 危险的', '8', '28');
INSERT INTO `hi_conf_course_word` VALUES ('29', '2', '41', 'process\nn. 过程\nburn\nv. 燃烧', '10', '18');
INSERT INTO `hi_conf_course_word` VALUES ('30', '2', '41', 'express\nv. 表达', '13', '23');
INSERT INTO `hi_conf_course_word` VALUES ('31', '2', '45', 'finish\nv. 完成', '0', '18');
INSERT INTO `hi_conf_course_word` VALUES ('32', '2', '45', 'rest\nn. 剩余部分', '0', '28');
INSERT INTO `hi_conf_course_word` VALUES ('33', '2', '45', 'stretch\nv. 伸展', '1', '26');
INSERT INTO `hi_conf_course_word` VALUES ('34', '2', '45', 'prepare\nv. 准备', '9', '8');
INSERT INTO `hi_conf_course_word` VALUES ('35', '2', '45', 'emergency\nadj. 紧急的', '10', '20');
INSERT INTO `hi_conf_course_word` VALUES ('36', '2', '45', 'dial\nv. 给…拨打电话', '10', '29');
INSERT INTO `hi_conf_course_word` VALUES ('37', '2', '45', 'International Firefighters Day\n国际消防员日', '10', '50');
INSERT INTO `hi_conf_course_word` VALUES ('38', '2', '45', 'celebrate\nv. 庆祝', '11', '14');
INSERT INTO `hi_conf_course_word` VALUES ('39', '2', '45', 'in training\n训练中', '14', '19');
INSERT INTO `hi_conf_course_word` VALUES ('41', '2', '33', 'outfit\r\nn. 全套服装', '9', '31');

-- ----------------------------
-- Table structure for hi_conf_day_read
-- ----------------------------
DROP TABLE IF EXISTS `hi_conf_day_read`;
CREATE TABLE `hi_conf_day_read` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `UnitID` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '子单元ID',
  `Name` varchar(255) NOT NULL DEFAULT '' COMMENT '名称',
  `Chapter` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '章节',
  `Page` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '页码',
  `Segment` varchar(10) NOT NULL DEFAULT '0' COMMENT '段',
  `AudioUrl` varchar(200) NOT NULL DEFAULT '' COMMENT '音频地址',
  `Content` text COMMENT '原文内容',
  PRIMARY KEY (`ID`),
  KEY `SU` (`UnitID`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hi_conf_day_read
-- ----------------------------
INSERT INTO `hi_conf_day_read` VALUES ('1', '2', '精选原文1', '11', '56', '', 'L2-Balto/dayread/Balto_U1_1.mp3', 'This is a true story about a very brave dog.\nHis name was Balto.\nThe year was 1925.Balto lived in Nome, Alaska. Nome was a frontier town. Most of the year it was buried under ice and snow.\nIn winter there was no way to travel through all that ice and snow.\nNot on planes or trains or boats or cars.\nThe only way to travel in Alaska was by dog sled.');
INSERT INTO `hi_conf_day_read` VALUES ('2', '2', '精选原文2', '11', '78', '', 'L2-Balto/dayread/Balto_U1_2.mp3', 'Balto was a sled dog.\nHe worked for a gold-mining company not far from Nome.\nHe helped carry food and tools to the miners.\nIt was a good life for a sled dog.\nBalto\'s driver was named Gunnar. Gunnar made Balto his lead dog.');
INSERT INTO `hi_conf_day_read` VALUES ('3', '2', '精选原文3', '11', '89', '', 'L2-Balto/dayread/Balto_U1_3.mp3', 'The lead dog runs in front of the team. He follows the trail.\nAll the other dogs do whatever the lead dog does.\nSo the lead dog has to be the smartest and strongest dog of all.');
INSERT INTO `hi_conf_day_read` VALUES ('4', '3', '精选原文1', '22', '12', '', 'L2-Balto/dayread/Balto_U2_1.mp3', 'When the doctor saw the children he was very worried. The children had a terrible sickness. It was called diphtheria. The doctor did not have the medicine he needed.\nWithout the medicine the children would die.\nWithout the medicine many other people in Nome would get diphtheria and die too.');
INSERT INTO `hi_conf_day_read` VALUES ('5', '3', '精选原文2', '22', '1415', '', 'L2-Balto/dayread/Balto_U2_2.mp3', 'The hospital in Anchorage, Alaska, had the medicine. But Anchorage was 800 miles away. The doctors in Anchorage put the medicine on a train.\nBut soon the train got stuck in the deep snow. The train was still 700 miles from Nome!');
INSERT INTO `hi_conf_day_read` VALUES ('6', '3', '精选原文3', '22', '16', '', 'L2-Balto/dayread/Balto_U2_3.mp3', 'The people of Nome held a meeting. Everyone was very scared. \n\"What are we going to do?\" asked the doctor. \"We have to get that medicine.\"\nAt last someone said, \"What about a dog-sled relay? When one team of dogs gets tired, a new team will be ready to take over.\"\nThe room buzzed with excitement. That did seem like the quickest way to get the medicine.');
INSERT INTO `hi_conf_day_read` VALUES ('7', '4', '精选原文1', '33', '1921', '', 'L2-Balto/dayread/Balto_U3_1.mp3', 'Gunnar heard the mayor on the radio. Gunnar knew he had the best dog team and the best lead dog. Balto would come to the rescue. \nOn January 27, 1925, the race to Nome began. Twenty-one dog teams were in the relay. Each team waited at a different stop. ');
INSERT INTO `hi_conf_day_read` VALUES ('8', '4', '精选原文2', '33', '2325', '', 'L2-Balto/dayread/Balto_U3_2.mp3', 'But soon the wind began to blow hard. The air grew colder. A blizzard was coming!\nIt was one of the worst storms ever. Still the race went on. Somehow each dog team made it to the next stop.\nIn one team, two dogs froze to death. So the driver hitched himself to the sled. He helped the rest of his dogs pull through the storm.');
INSERT INTO `hi_conf_day_read` VALUES ('9', '4', '精选原文3', '33', '26', '', 'L2-Balto/dayread/Balto_U3_3.mp3', 'Gunnar and Balto waited at their stop in Bluff. They were going to run 31 miles from Bluff to Point Safety. That was the second-to-last part of the race.\nBut the storm had slowed things down. Gunnar had been waiting for two days. He did not sleep. He wanted to be ready to go as soon as the medicine arrived.');
INSERT INTO `hi_conf_day_read` VALUES ('10', '5', '精选原文1', '44', '2829', '', 'L2-Balto/dayread/Balto_U4_1.mp3', 'At last Gunnar heard dogs barking. The medicine was here! \nHe put it one lthe sled with a small stove and a little food. Then he hitched up his dogs. Balto stood proudly in the lead. \nGunnar cracked his whip. \"Mush!\" he cried. That meant \"go.\" The team ran out into the snowy night.');
INSERT INTO `hi_conf_day_read` VALUES ('11', '5', '精选原文2', '44', '30', '', 'L2-Balto/dayread/Balto_U4_2.mp3', 'At first the team made good time. But soon snowdrifts blocked the trail. The dogs sank up to their necks in snow.\nThey could not move. Some began to panic. But not Balto. He stayed calm. That helped the other dogs while Gunnar dug them out of the snow. At last the team was on its way again.');
INSERT INTO `hi_conf_day_read` VALUES ('12', '5', '精选原文3', '44', '35', '', 'L2-Balto/dayread/Balto_U4_3.mp3', 'The team kept going across the river. Suddenly Balto stopped short.\n\"Mush, Balto!\" shouted Gunnar. But Balto did not move. \nThen Gunnar saw why. The ice was cracking! If the team fell into the river, they would all drown.');
INSERT INTO `hi_conf_day_read` VALUES ('13', '6', '精选原文1', '55', '3637', '', 'L2-Balto/dayread/Balto_U5_1.mp3', 'Balto had stopped just in time. “Smart dog!”Gunnar told him. \nThen he saw that Balto’s feet were wet. If they froze, Balto would never walk again. Quickly Gunnar unhitched Balto from the sled. He led the dog to a patch of powdery snow.\nGunnar rubbed Balto’s paws in the powder. Soon they were dry. Balto was ready to go once more.');
INSERT INTO `hi_conf_day_read` VALUES ('14', '6', '精选原文2', '55', '3839', '', 'L2-Balto/dayread/Balto_U5_2.mp3', 'Balto led the team around the cracking ice. At last they reached solid land again.\nWere they still on the trail? Gunnar had no idea. \nThe snow blew so hard, Gunnar could not see his own hands.\nBut Balto had run this trail many times before. Now it was all up to him.');
INSERT INTO `hi_conf_day_read` VALUES ('15', '6', '精选原文3', '55', '40', '', 'L2-Balto/dayread/Balto_U5_3.mp3', 'Finally the storm died down.  Gunnar saw Point Safety just ahead. “Balto did it!”thought Gunnar. He couldn’t wait to warm his hands by a cozy fire.\nBut all the lights were out at Point Safety. Was the next driver there? Gunnar did not know.\nAnd there was no time to find out. So Gunnar and Balto did not stop. They had never been so tired. But they raced on through the night toward Nome.');
INSERT INTO `hi_conf_day_read` VALUES ('16', '7', '精选原文1', '66', '4243', '', 'L2-Balto/dayread/Balto_U6_1.mp3', 'It was just before dawn. The sky began to glow. In the town of Nome everyone was sleeping.\nGunnar and his team pulled into town. They had made it!\nBalto was too tired to bark. They had been on the trail for 20 hours straight. They had driven 53 miles!');
INSERT INTO `hi_conf_day_read` VALUES ('17', '7', '精选原文2', '66', '4446', '', 'L2-Balto/dayread/Balto_U6_2.mp3', 'The doctor was surprised. He thought it would take 15 days to get the medicine. But Gunnar delivered it after only five and a half days!\n“Thank you, Gunnar!”said the doctor.\n“You are a hero!” \n“Balto is the hero,”said Gunnar.\n“I could not have done it without him.”\nThe doctor went right to work. He gave the medicine to all the sick people. \nIn a few days they would be well. The town of Nome was saved.');
INSERT INTO `hi_conf_day_read` VALUES ('18', '7', '精选原文3', '66', '4748', '', 'L2-Balto/dayread/Balto_U6_3.mp3', 'All over America people cheered for Balto. They read about his bravery in the newspaper. Balto was the most famous dog in the world.\nA year later, the people of New York City put up a statue of Balto.\nIt still stands in Central Park. Lots of children play on the statue. \nThey remember Balto, the bravest dog ever!');
INSERT INTO `hi_conf_day_read` VALUES ('19', '17', '精选原文1', '11', '6', '', 'L1-Firehouse/dayread/Firehouse_U1_1.mp3', 'Today my class is going to the firehouse!\nI dress like a fireman.\nTime to fight a fire!');
INSERT INTO `hi_conf_day_read` VALUES ('20', '17', '精选原文2', '11', '89', '', 'L1-Firehouse/dayread/Firehouse_U1_2.mp3', 'This is Fireman Joe.\nThis is his dog, Sparky.\nSparky is a fire dog.');
INSERT INTO `hi_conf_day_read` VALUES ('21', '17', '精选原文3', '11', '10', '', 'L1-Firehouse/dayread/Firehouse_U1_3.mp3', 'Fireman Joe has boots.\nHe has a jacket.\nHe has a helmet.');
INSERT INTO `hi_conf_day_read` VALUES ('22', '17', '精选原文4', '11', '11', '', 'L1-Firehouse/dayread/Firehouse_U1_4.mp3', 'I have boots.\nI have a jacket.\nI do not have a helmet.');
INSERT INTO `hi_conf_day_read` VALUES ('23', '18', '精选原文1', '22', '1213', '', 'L1-Firehouse/dayread/Firehouse_U2_1.mp3', 'Joe slides down the pole.\nSparky howls.\nThat is what he does when there is a fire.');
INSERT INTO `hi_conf_day_read` VALUES ('24', '18', '精选原文2', '22', '1415', '', 'L1-Firehouse/dayread/Firehouse_U2_2.mp3', 'We see a fire truck.\nIt is big.\nIt is red.\nIt has hoses and a ladder.');
INSERT INTO `hi_conf_day_read` VALUES ('25', '18', '精选原文3', '22', '16', '', 'L1-Firehouse/dayread/Firehouse_U2_3.mp3', 'Joe checks the hoses.\nHe lets me help.');
INSERT INTO `hi_conf_day_read` VALUES ('26', '18', '精选原文4', '22', '17', '', 'L1-Firehouse/dayread/Firehouse_U2_4.mp3', 'Whoosh goes the water.\nThis hose is working fine.');
INSERT INTO `hi_conf_day_read` VALUES ('27', '19', '精选原文1', '33', '1819', '', 'L1-Firehouse/dayread/Firehouse_U3_1.mp3', 'Joe checks the ladder. \nHe goes up and up.\nHe is in the sky.\nHello, Fireman Joe!');
INSERT INTO `hi_conf_day_read` VALUES ('28', '19', '精选原文2', '33', '2021', '', 'L1-Firehouse/dayread/Firehouse_U3_2.mp3', 'Joe checks the siren.\nIt goes Ooo! Eee! Ooo!\nThe siren is very loud.\nI cover my ears.');
INSERT INTO `hi_conf_day_read` VALUES ('29', '19', '精选原文3', '33', '2223', '', 'L1-Firehouse/dayread/Firehouse_U3_3.mp3', 'Joe tells us about fires.\nHe tells us smoke goes up.\nWhen smoke goes up,\nwe must go down to the floor.');
INSERT INTO `hi_conf_day_read` VALUES ('30', '19', '精选原文4', '33', '2425', '', 'L1-Firehouse/dayread/Firehouse_U3_4.mp3', 'I get on the floor.\nJoe tells us what to do if we are on fire.\nStop, drop, and roll!\nI stop, drop, and roll!');
INSERT INTO `hi_conf_day_read` VALUES ('31', '20', '精选原文1', '44', '2627', '', 'L1-Firehouse/dayread/Firehouse_U4_1.mp3', 'Fireman Joe smiles.\nHe has a surprise.\nHe reaches into his truck.\nHelmets for everyone!');
INSERT INTO `hi_conf_day_read` VALUES ('32', '20', '精选原文2', '44', '2829', '', 'L1-Firehouse/dayread/Firehouse_U4_2.mp3', 'I put on my helmet.\nJoe tells me I will be a good fireman one day.');
INSERT INTO `hi_conf_day_read` VALUES ('33', '20', '精选原文3', '44', '3031', '', 'L1-Firehouse/dayread/Firehouse_U4_3.mp3', 'Ding! Ding! goes the fire alarm.\nI wave good-bye to Fireman Joe.\nI wave good-bye to Sparky.\nTime to fight a fire!');
INSERT INTO `hi_conf_day_read` VALUES ('34', '20', '精选原文4', '44', '32', '', 'L1-Firehouse/dayread/Firehouse_U4_4.mp3', 'Fireman Joe is ready to go!\nSparky is, too.');

-- ----------------------------
-- Table structure for hi_conf_level
-- ----------------------------
DROP TABLE IF EXISTS `hi_conf_level`;
CREATE TABLE `hi_conf_level` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(20) NOT NULL DEFAULT '' COMMENT '等级名称',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hi_conf_level
-- ----------------------------
INSERT INTO `hi_conf_level` VALUES ('1', 'Level 1');
INSERT INTO `hi_conf_level` VALUES ('2', 'Level 2');
INSERT INTO `hi_conf_level` VALUES ('3', 'Level 3');
INSERT INTO `hi_conf_level` VALUES ('4', 'Level 4');
INSERT INTO `hi_conf_level` VALUES ('5', 'Level 5');
INSERT INTO `hi_conf_level` VALUES ('6', 'Level 6');
INSERT INTO `hi_conf_level` VALUES ('7', 'Level 7');

-- ----------------------------
-- Table structure for hi_conf_readlevel
-- ----------------------------
DROP TABLE IF EXISTS `hi_conf_readlevel`;
CREATE TABLE `hi_conf_readlevel` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Level` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT ' 测试等级1',
  `Question` text COMMENT '问题描述',
  `Type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '题目类型(1:文字选择2:音频3:视频4:图片)',
  `Image` varchar(50) NOT NULL DEFAULT '',
  `Audio` varchar(50) NOT NULL DEFAULT '',
  `Video` varchar(50) NOT NULL DEFAULT '',
  `ChoiceA` varchar(200) NOT NULL DEFAULT '' COMMENT '选项',
  `ChoiceB` varchar(200) NOT NULL DEFAULT '',
  `ChoiceC` varchar(200) NOT NULL DEFAULT '',
  `ChoiceD` varchar(200) NOT NULL DEFAULT '',
  `Correct` char(3) NOT NULL DEFAULT '' COMMENT '正确答案',
  PRIMARY KEY (`ID`),
  KEY `Level` (`Level`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=82 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hi_conf_readlevel
-- ----------------------------
INSERT INTO `hi_conf_readlevel` VALUES ('1', '1', ' It is ___  today.', '4', '1/L1-1.jpg', '', '', 'rainy', 'snowy', 'sunny', 'happy', 'A');
INSERT INTO `hi_conf_readlevel` VALUES ('2', '1', 'There is a ___ under the table.', '4', '1/L1-2.jpg', '', '', 'lamp', 'ball', 'book', 'clock', 'B');
INSERT INTO `hi_conf_readlevel` VALUES ('3', '1', 'A ___ is a vegetable.', '4', '1/L1-3.jpg', '', '', 'apple\r\n', 'banana', 'tomato', 'carrot', 'D');
INSERT INTO `hi_conf_readlevel` VALUES ('4', '1', 'What are the birds doing?', '4', '1/L1-4.jpg', '', '', 'They fly.', 'They flying.', 'They are flying.', 'They are fly.', 'C');
INSERT INTO `hi_conf_readlevel` VALUES ('5', '1', 'Whose hat is this?', '4', '1/L1-5.jpg', '', '', 'It is Lucy´s hat.', 'Is Lucy´s hat.', 'She is Lucy\'s hat.', 'He\'s Lucy\'s hat.', 'A');
INSERT INTO `hi_conf_readlevel` VALUES ('6', '1', 'My brother __ 12 years old.', '4', '1/L1-6.jpg', '', '', 'have', 'is', 'are', 'has', 'B');
INSERT INTO `hi_conf_readlevel` VALUES ('7', '1', 'What do they do?', '4', '1/L1-7.jpg', '', '', 'Amy and Tom are they doctors.', 'They are Amy and Tom doctors.', 'It is a doctor Amy and Tom.', 'Amy and Tom are doctors.', 'D');
INSERT INTO `hi_conf_readlevel` VALUES ('8', '1', 'Can I have two ___ of juice, please?', '4', '1/L1-8.jpg', '', '', 'glasses', 'cups', 'pieces', 'bottles', 'D');
INSERT INTO `hi_conf_readlevel` VALUES ('9', '1', 'She\'s got three ___ for the movie tonight.', '4', '1/L1-9.jpg', '', '', 'cards', 'menus', 'tickets', 'passports', 'C');
INSERT INTO `hi_conf_readlevel` VALUES ('10', '1', 'April is a ___ .', '4', '1/L1-10.jpg', '', '', 'season', 'place', 'month', 'year', 'C');
INSERT INTO `hi_conf_readlevel` VALUES ('11', '1', 'Spring is a __ ', '4', '1/L1-11.jpg', '', '', 'season', 'place', 'month', 'year', 'A');
INSERT INTO `hi_conf_readlevel` VALUES ('12', '1', 'There are ___.', '4', '1/L1-12.jpg', '', '', '2 girl and 1 boy', '2 girl and 1 boys', '2 boys and 1 girl', '2 boys and 1 girls', 'C');
INSERT INTO `hi_conf_readlevel` VALUES ('13', '1', 'The rabbit was ', '4', '1/L1-13.jpg', '', '', 'sleepy', 'angry', 'hungry', 'thirsty', 'C');
INSERT INTO `hi_conf_readlevel` VALUES ('14', '1', 'The cat is ___', '4', '1/L1-14.jpg', '', '', 'large', 'tall', 'fast', 'tiny', 'D');
INSERT INTO `hi_conf_readlevel` VALUES ('15', '1', 'The bear is __ the chair', '4', '1/L1-15.png', '', '', 'on', 'in', 'under', 'inside', 'A');
INSERT INTO `hi_conf_readlevel` VALUES ('16', '2', 'There aren\'t ___ good restaurants in this town.', '4', '2/L2-1.jpg', '', '', 'any', 'the', 'some', 'a', 'A');
INSERT INTO `hi_conf_readlevel` VALUES ('17', '2', 'Are these Andy\'s glasses?', '4', '2/L2-2.jpg', '', '', 'No, they\'re for me.', 'No, they\'re my.', 'No, they\'re mine.', 'No, it is mine.', 'C');
INSERT INTO `hi_conf_readlevel` VALUES ('18', '2', 'That woman can __ very well.', '4', '2/L2-3.jpg', '', '', 'dances', 'dancing', 'is dancing', 'dance', 'D');
INSERT INTO `hi_conf_readlevel` VALUES ('19', '2', 'I __ see you tomorrow.', '4', '2/L2-4.png', '', '', 'am', 'will', 'go', 'was', 'B');
INSERT INTO `hi_conf_readlevel` VALUES ('20', '2', 'The Rainbow __', '4', '2/L2-5.jpg', '', '', 'is blue, green, yellow and red', 'is green, red and yellow', 'are blue, green, yellow and red', 'are Green, red and yellow', 'B');
INSERT INTO `hi_conf_readlevel` VALUES ('21', '2', 'She wants to __ the black hat.', '4', '2/L2-6.jpg', '', '', 'put', 'do', 'wear', 'have', 'C');
INSERT INTO `hi_conf_readlevel` VALUES ('22', '2', 'My clothes are dirty. I need to __ them.', '4', '2/L2-7.gif', '', '', 'wear', 'dirty', 'clean', 'dry', 'C');
INSERT INTO `hi_conf_readlevel` VALUES ('23', '2', 'I ___ I was taller!', '4', '2/L2-8.jpg', '', '', 'wish', 'think', 'want', 'short', 'A');
INSERT INTO `hi_conf_readlevel` VALUES ('24', '2', 'I _________ TV.', '1', '', '', '', 'am not like watching', 'doesn\'t like to watch', 'don´t like to watch', 'is not like to watch', 'C');
INSERT INTO `hi_conf_readlevel` VALUES ('25', '2', 'My birthday is ______.', '4', '2/L2-10.jpg', '', '', 'in June', 'on June', 'at June', 'with June', 'A');
INSERT INTO `hi_conf_readlevel` VALUES ('26', '2', 'The eggs are ___', '4', '2/L2-11.jpg', '', '', 'heavy', 'fat', 'warm', 'sleeping', 'C');
INSERT INTO `hi_conf_readlevel` VALUES ('27', '2', 'The children are playing ___.', '4', '2/L2-12.jpg', '', '', 'alone', '2 people', 'with', 'together', 'D');
INSERT INTO `hi_conf_readlevel` VALUES ('28', '2', 'Summer is a time of sunshine and hot weather. In Autumn, the weather gets cooler. The leaves fall off trees. Some people call Autumn by another name. They call it fall!\r\n Which season is cooler?', '1', '', '', '', 'Sunshine and hot weather', 'The leaves fall off trees', 'Summer', 'Autumn', 'A');
INSERT INTO `hi_conf_readlevel` VALUES ('29', '2', 'At Michael’s new school, his class played a game. Michael had not played the game before. He sat quietly and watched everyone else play. Soon he understood the rules.\r\nMichael _____ the game. ', '1', '', '', '', 'bought', 'learned', 'stopped', 'returned', 'B');
INSERT INTO `hi_conf_readlevel` VALUES ('30', '2', 'Everyone is watching the game at the park. But then dark clouds cover the sun. Rain starts to fall on the people. Wind blows leaves off the trees. Everyone walks to their cars.\r\nThere was a _________.', '1', '', '', '', 'train', 'picture', 'party', 'storm', 'D');
INSERT INTO `hi_conf_readlevel` VALUES ('31', '2', 'What does Harry look like?', '3', '', '', '2/L2-16-Harry_the_dirty_Dog.mp4', 'Black with white stripes', 'White with black stripes', 'Black with white spots', 'White with black spots', 'D');
INSERT INTO `hi_conf_readlevel` VALUES ('32', '2', 'What does Harry not like?', '1', '', '', '', 'Running around', 'Getting a bath', 'Eating Bones', 'Barking', 'B');
INSERT INTO `hi_conf_readlevel` VALUES ('33', '2', 'Balto is a ________.', '2', '', '2/L2-18-Balto.mp3', '', 'guide dog', 'sled dog', 'police dog', 'pet dog', 'B');
INSERT INTO `hi_conf_readlevel` VALUES ('34', '2', 'What company did Balto work for?', '1', '', '', '', 'A big oil company', 'A gold-mining company', 'A food company', 'An express company', 'B');
INSERT INTO `hi_conf_readlevel` VALUES ('35', '2', 'What did toad do to make his seeds grow?', '3', '', '', '2/L2-20-Frog_and Toad.mp4', 'Left them alone', 'Shouted at them', 'Let the sun shine on them', 'Let the rain fall on them', 'B');
INSERT INTO `hi_conf_readlevel` VALUES ('36', '3', 'If she ___________ about his financial situation, she would have helped him out.', '1', '', '', '', 'knew', 'had been knowing', 'had known', 'have known', 'C');
INSERT INTO `hi_conf_readlevel` VALUES ('37', '3', 'I\'ll ______________ their cat while they are away on holiday.', '1', '', '', '', 'be looking into', 'be looking at', 'be looking after', 'be looking over', 'C');
INSERT INTO `hi_conf_readlevel` VALUES ('38', '3', 'He made his children ______ their homework every afternoon.', '1', '', '', '', 'do', 'to do', 'studied', 'to study', 'A');
INSERT INTO `hi_conf_readlevel` VALUES ('39', '3', 'The test was ____ difficult she had problems finishing it on time.', '1', '', '', '', 'such', 'a', 'as', 'so', 'D');
INSERT INTO `hi_conf_readlevel` VALUES ('40', '3', 'By the time she arrives, we ________________ our homework.', '1', '', '', '', 'finish', 'will have finished', 'will finish', 'were finished', 'B');
INSERT INTO `hi_conf_readlevel` VALUES ('41', '3', 'The sun ______ at 9 last night.', '1', '', '', '', 'sat', 'setted', 'set', 'was setting', 'C');
INSERT INTO `hi_conf_readlevel` VALUES ('42', '3', 'When I stopped __________ to Mary, she was picking some flowers in her garden.', '1', '', '', '', 'speaking', 'speak', 'to speak', 'spoke', 'C');
INSERT INTO `hi_conf_readlevel` VALUES ('43', '3', 'Despite ______________ hard, he failed the exam.', '1', '', '', '', 'he studied', 'he has studied', 'studying', 'study', 'C');
INSERT INTO `hi_conf_readlevel` VALUES ('44', '3', 'That room _______________ for a meeting today.', '1', '', '', '', 'is used', 'is being used', 'used', 'is using', 'B');
INSERT INTO `hi_conf_readlevel` VALUES ('45', '3', 'We ____________ tennis every day when we were young.', '1', '', '', '', 'use to play\r\n', 'would play\r\n', 'were playing', 'were used to play', 'B');
INSERT INTO `hi_conf_readlevel` VALUES ('46', '3', 'If I __________ you, I would wait a while to begin investing.', '1', '', '', '', 'wasn’t\r\n', 'am\r\n', 'were', 'would be', 'C');
INSERT INTO `hi_conf_readlevel` VALUES ('47', '3', 'He\'ll give you a call as soon as he __________.\r\n\r\nBalto´s driver was named Gunnar. \r\nGunnar made Balto his lead dog.\r\nThe lead dog runs in front of the team.\r\n(from ´The True Story of Balto´ by Natalie Standford)', '1', '', '', '', 'will arrive\r\n', 'arrives', 'is arriving', 'is going to arrive', 'B');
INSERT INTO `hi_conf_readlevel` VALUES ('48', '3', 'That means _______________.\r\n\r\nToad baked some cookies. \"These cookies smell very good, \"said Toad. He ate one.\r\n\"And they taste even better,\" he said. Toad ran to Frog\'s house.\r\n\"Frog, Frog,\" cried Toad, \"taste these cookies that I have made.\"\r\n(taken from ´Frog and Toad Together\' by Arnold Lobel, 370L)', '1', '', '', '', 'Balto runs behind the other dogs.', 'The other dogs run behind Balto.\r\n', 'Gunnar is the name of the lead dog.', 'Balto is the name of the driver.', 'B');
INSERT INTO `hi_conf_readlevel` VALUES ('49', '3', 'Which is true?\r\n\r\nCasey knew he wasn’t supposed to play basketball in the living room. So he just bounced the ball once. Well, twice. He was about to go outside when the ball hit a little vase on the end table. It crashed to the floor. It broke into about a million pieces. ', '1', '', '', '', 'Frog bakes some cookies for Toad.', 'Toad goes to Frog´s house to give him cookies.', 'Frog goes to Toad´s house to give him cookies.', 'The cookies smell better than they taste.', 'B');
INSERT INTO `hi_conf_readlevel` VALUES ('50', '3', 'Which is true?\r\n\r\nHarry was a white dog with black spots who liked everything……except, getting a bath.\r\nSo one day when he heard the water running in the tub. \r\nHe took the scrubbing brush, and buried it in the back yard.\r\n(Taken from ´Harry the Dirty Dog´ by Gene Zion)', '1', '', '', '', 'Casey has permission to play basketball in the living room.', 'Casey caused damage by ignoring a rule.', 'Casey intentionally broke a vase.', 'The vase broke when Casey was outside.', 'B');
INSERT INTO `hi_conf_readlevel` VALUES ('51', '3', 'Why did Harry bury the scrubbing brush?', '1', '', '', '', 'Harry buried the scrubbing brush because he likes to have a bath.', 'Harry wanted to have a bath in the back yard.', 'Harry buried the scrubbing brush because he doesn´t like to have a bath.', 'Harry was scared by the sound of water running in the tub.', 'C');
INSERT INTO `hi_conf_readlevel` VALUES ('52', '4', 'He won\'t go into the river. He\'s __ of the water.', '1', '', '', '', 'feared', 'frightened', 'fearing', 'frightening', 'B');
INSERT INTO `hi_conf_readlevel` VALUES ('53', '4', 'you close the door, please?', '1', '', '', '', 'Do', 'Could', 'Did', 'May', 'B');
INSERT INTO `hi_conf_readlevel` VALUES ('54', '4', 'What __ next week?', '1', '', '', '', 'did you do', 'do you do', 'are you doing', 'are you do', 'C');
INSERT INTO `hi_conf_readlevel` VALUES ('55', '4', 'I made a sandwich __ .', '1', '', '', '', 'so I was hungry', 'for I was hungry', 'must I was hungry', 'because I was hungry', 'D');
INSERT INTO `hi_conf_readlevel` VALUES ('56', '4', 'My hair is very wet. Have you got a __ ?', '1', '', '', '', 'towel', 'bath', 'shirt', 'shower', 'A');
INSERT INTO `hi_conf_readlevel` VALUES ('57', '4', 'What\'s the __ of that mountain?', '1', '', '', '', 'tall', 'high', 'height', 'big', 'C');
INSERT INTO `hi_conf_readlevel` VALUES ('58', '4', 'We __ be able to go to the concert if we can get some tickets.', '1', '', '', '', 'might', 'want', 'can', 'could', 'A');
INSERT INTO `hi_conf_readlevel` VALUES ('59', '4', 'Ben has __ arrived. I can see him opening his front door.', '1', '', '', '', 'must', 'yet', 'just', 'at once', 'C');
INSERT INTO `hi_conf_readlevel` VALUES ('60', '4', 'If I had a lot of money, I __ buy a fast car.', '1', '', '', '', 'will', 'would', 'must', 'used to', 'B');
INSERT INTO `hi_conf_readlevel` VALUES ('61', '4', 'She couldn\'t find the key ____ the door to Paul\'s house.', '1', '', '', '', 'who opened', 'what opened', 'which opened', 'for open', 'C');
INSERT INTO `hi_conf_readlevel` VALUES ('62', '4', 'When they arrived home, they felt        tired, so they went to bed.', '1', '', '', '', 'a lot', 'some', 'mostly', 'quite', 'D');
INSERT INTO `hi_conf_readlevel` VALUES ('63', '4', 'Tamia can hear the train getting closer to the station. She begins to say goodbye to her aunt and uncle. The train blasts its horn twice. The station shakes as the train rolls in. Her aunt and uncle cover their ears. Tamia has to shout to be heard. “I cannot wait to visit again next summer!” She tells them. (410L)\r\nThe train is _______. ', '1', '', '', '', 'early', 'tiny', 'loud', 'empty', 'C');
INSERT INTO `hi_conf_readlevel` VALUES ('64', '4', 'The plastic bottles and toys that people throw away are causing problems. A lot of them end up in oceans. This is not good for sea animals. It is also not good for people. Some scientists have found tiny pieces of plastic mixed in with the sea salt. That is the same salt people use on food. Plastic has been found in rock salt, too.  (550L)\r\nThe plastic is ________.', '1', '', '', '', 'heavy', 'shiny', 'unwanted', 'beautiful', 'C');
INSERT INTO `hi_conf_readlevel` VALUES ('65', '4', 'Every morning, Kenji watched the birds in his yard. He noticed many different kinds of birds. He began to ask his parents questions about them. He wanted to know why their beaks were not all the same size. He asked if they knew the names of each type of bird. His parents did not know the answers to most of his questions. They promised to take him to the library to find a bird guide.\r\nKenji was ______. ', '1', '', '', '', 'silent', 'curious', 'calm', 'daring', 'B');
INSERT INTO `hi_conf_readlevel` VALUES ('66', '4', 'Carefully Mr. Fox began pushing up one of the floorboards. The board creaked most terribly and they all ducked down, waiting for something awful to happen. Nothing did. So Mr. Fox pushed up a second board. And then, very very cautiously, he poked his head up through the gap. He let out a shriek of excitement.\r\n(Taken from ´Fantastic Mr. Fox´ by Roald Dahl, 590L)\r\nWhich statement is true', '1', '', '', '', 'The floorboards moved quietly when Mr. Fox pushed them.', 'Mr. Fox is afraid of what he sees through the gap.', 'The floorboards are too heavy for Mr. Fox to push.', 'Mr. Fox is coming up from under the floorboards.', 'D');
INSERT INTO `hi_conf_readlevel` VALUES ('67', '5', 'Those painting were some of the most beautiful I ___ .', '1', '', '', '', 'was ever seeing', 'have ever been seeing', 'had ever seen', 'did ever see', 'C');
INSERT INTO `hi_conf_readlevel` VALUES ('68', '5', 'Can you help me to ___ this problem, please? I can\'t do it.', '1', '', '', '', 'deal with', 'deal by', 'deal for', 'deal of', 'A');
INSERT INTO `hi_conf_readlevel` VALUES ('69', '5', 'Remember to pick up all your ___ when you leave the train.', '1', '', '', '', 'belongings', 'belongs', 'belonged', 'belong', 'A');
INSERT INTO `hi_conf_readlevel` VALUES ('70', '5', 'If I\'d passed the entrance exam, I ___ Chemistry at Cambridge.', '1', '', '', '', 'was to study', 'would have studied', 'will have studied', 'will study', 'B');
INSERT INTO `hi_conf_readlevel` VALUES ('71', '5', 'I really didn\'t want to come last night. _______.', '1', '', '', '', 'So do I', 'Neither do I', 'Neither didn’t I', 'Neither did I', 'D');
INSERT INTO `hi_conf_readlevel` VALUES ('72', '5', 'Do you think ___________ ?', '1', '', '', '', 'does he know what he wants', 'he knows what he wants', 'he knows what does he want', 'what he wants he knows', 'B');
INSERT INTO `hi_conf_readlevel` VALUES ('73', '5', 'I think San Francisco is ____ exciting ____ New York.', '1', '', '', '', 'as ... as', 'so ... than', 'as ... than', 'so ... as', 'A');
INSERT INTO `hi_conf_readlevel` VALUES ('74', '5', 'Why are your hands so dirty? - I _______________ in the garden.', '1', '', '', '', 'was worked', ' have worked', 'worked', 'have been working', 'D');
INSERT INTO `hi_conf_readlevel` VALUES ('75', '5', 'Did you remember __________ the door?', '1', '', '', '', 'lock', 'to lock', 'locking', 'having locked', 'B');
INSERT INTO `hi_conf_readlevel` VALUES ('76', '5', 'Clara Bryant is a musician. For decades, she played the trumpet in jazz bands. She was a musical pioneer. But in 1996, Bryant developed health problems. She was told she could no longer play her instrument. So she turned to singing and recording her life story. She hopes to release it as an audio book, featuring sounds effects and music. She also continues to share her talent and experience by teaching and speaking on the subject of jazz. (660L)\r\n\r\nThat is the man __________ grandfather founded Kentucky Root Beer.', '1', '', '', '', 'who', 'that', 'which', 'whose', 'D');
INSERT INTO `hi_conf_readlevel` VALUES ('77', '5', 'Cranberries are tart red berries that are often used to make juice. They grow on vines that live in damp, sandy ground. For many years, the berries were picked by hand. This was a long, difficult process. In the 1960s, farmers began to flood their fields just before picking. They used wheeled machines to separate the berries from the vines. The berries contain air, so they floated to the top of the water. The farmers then used a pump or conveyor belt to remove the berries. (730L)\r\n\r\nBryant started new _____.', '1', '', '', '', 'recipes', 'projects', 'games', 'languages', 'B');
INSERT INTO `hi_conf_readlevel` VALUES ('78', '5', 'Wilbur was what farmers call a spring pig, which simply means that he was born in springtime. When he was five weeks old, Mr. Arable said he was now big enough to sell, and would have to be sold. Fern broke down and wept. Buther father was firm about it. Wilbur\'s appetite had increased; he was beginning to eat scraps of food in addition to milk.\r\n(taken from ´Charloette´s Web´ by E.B. White, 700L)\r\n\r\nThe berries are ____ in water. ', '1', '', '', '', 'examined', 'ripened', 'collected', 'crushed', 'C');
INSERT INTO `hi_conf_readlevel` VALUES ('79', '5', 'While working for a large company. Howard Tracy Hall invented a process for producing artificial diamonds. Hall built his own equipment and worked during his free time. But the company that employed him did not give him credit for the discovery. Hall found another job. He intended to create a second method of diamond production, but he was denied access to the necessary equipment. So he built his own device and developed another process for making diamonds. This time he owned the patent on his invention. (750L)\r\n\r\nWhich is not true?', '1', '', '', '', 'Wilbur was eating too much food.', 'Mr. Arable wants to sell Wilbur.', 'Fern changes Mr. Arable´s mind.', 'Fern cries at hearing Mr. Arable´s news.', 'C');
INSERT INTO `hi_conf_readlevel` VALUES ('80', '5', 'Mrs Phelps looked along the shelves, taking her time. She didn´t quite know what to bring out. How, she asked herself, does one choose a famous grown-up book for a four-year-old girl? Her first thought was to pick a young teenager´s romance of the kind that is written for fifteen-year-old school-girls, but for some reason she found herself instinctively walking past that particular shelf.\r\n\r\n(Taken from the novel ´Matilda´ by Roald Dahl. 990L)\r\n\r\nHall was _____.\r\n', '1', '', '', '', 'unhelpful', 'graceful', 'vicious', 'determined', 'D');
INSERT INTO `hi_conf_readlevel` VALUES ('81', '5', 'Which answer is true for the above paragraph', '1', '', '', '', 'Mrs Phelps intends to find a book suitable for a fifteen-year-old school-girl, that a four-year-old would enjoy.', 'Mrs Phelps believes that romance novels designed for fifteen-year-old girls are also suitable for grown-ups.', 'Mrs Phelps reconsiders choosing a romance novel designed for fifteen-year-old school girls.', 'Mrs Phelps instinctively believes that four-year-old girls should read books designed for grown-ups.', 'C');

-- ----------------------------
-- Table structure for hi_conf_research
-- ----------------------------
DROP TABLE IF EXISTS `hi_conf_research`;
CREATE TABLE `hi_conf_research` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(180) NOT NULL DEFAULT '' COMMENT '调查名称',
  `Type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '调查类型',
  `Choice` varchar(255) NOT NULL DEFAULT '' COMMENT '选择项',
  `Select` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '0：单选1：多选',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hi_conf_research
-- ----------------------------
INSERT INTO `hi_conf_research` VALUES ('1', '孩子所就读学校的类型？', '1', '公立学校|双语学校|民办/私立学校|国际部/国际学校', '0');
INSERT INTO `hi_conf_research` VALUES ('2', '孩子在学校学了几年英语？（非培训机构）', '2', '没开始学|1年|2年|3年|4年|5年及以上', '0');
INSERT INTO `hi_conf_research` VALUES ('3', '孩子在课外培训机构学习了几年英语？', '3', '0-1年|1-2年|2-3年|3-4年|4-5年|5年以上', '0');
INSERT INTO `hi_conf_research` VALUES ('4', '孩子在课外培训机构每周英文学习几个小时？', '4', '没学|1小时|2小时|3小时|4小时|4小时以上', '0');
INSERT INTO `hi_conf_research` VALUES ('5', '孩子课外接触较多的英文资源？（多选）', '5', '缺乏|英文儿歌／动画|英文原版书|英文新闻', '1');
INSERT INTO `hi_conf_research` VALUES ('6', '孩子课外英语阅读材料？（多选）', '6', '没有读过原版|英文绘本|英文初级章节书|英文原版小说', '1');
INSERT INTO `hi_conf_research` VALUES ('7', '孩子阅读过哪些系列的书籍？（多选）', '7', 'I can Read|Step into Reading|Oxford Reading Tree|Usborne Collection|Magic Tree House|Junie B. Jones|Harry Potter|Others', '1');
INSERT INTO `hi_conf_research` VALUES ('8', '孩子感兴趣的题材？（多选）', '8', '探险类|科技类|科普类|自然科学类|科幻故事类|校园生活类|文化类|其他', '1');
INSERT INTO `hi_conf_research` VALUES ('9', '如果孩子有自学，或者其他学习情况，可在下方填写信息告诉我们（选填）', '9', '', '0');
INSERT INTO `hi_conf_research` VALUES ('10', '填写孩子的真实信息', '10', '', '0');

-- ----------------------------
-- Table structure for hi_conf_sub_unit
-- ----------------------------
DROP TABLE IF EXISTS `hi_conf_sub_unit`;
CREATE TABLE `hi_conf_sub_unit` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `UnitId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '单元ID',
  `Type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '子单元类型[用于导入不同页面](1:习题2:FreeTalk3:课前听读4:课前单词5:英文导读视频6:课后作业7:习题8:Free Talk)',
  `Name` varchar(50) NOT NULL DEFAULT '' COMMENT '单元名称',
  `Force` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '是否强制',
  PRIMARY KEY (`ID`),
  KEY `UnitId` (`UnitId`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=49 DEFAULT CHARSET=utf8 COMMENT='课程单元表';

-- ----------------------------
-- Records of hi_conf_sub_unit
-- ----------------------------
INSERT INTO `hi_conf_sub_unit` VALUES ('1', '1', '1', '课前测', '1');
INSERT INTO `hi_conf_sub_unit` VALUES ('2', '1', '2', 'Free Talk (optional)', '0');
INSERT INTO `hi_conf_sub_unit` VALUES ('3', '2', '3', '1-1 Pre-course Listening and Reading 课前听读', '1');
INSERT INTO `hi_conf_sub_unit` VALUES ('4', '2', '4', '1-2 Vocabulary Gym 课前单词健身房', '1');
INSERT INTO `hi_conf_sub_unit` VALUES ('5', '2', '5', '1-3 Guided Reading Course 英文原版导读课', '1');
INSERT INTO `hi_conf_sub_unit` VALUES ('6', '2', '6', '1-4 Review Homework 课后复习作业', '1');
INSERT INTO `hi_conf_sub_unit` VALUES ('7', '3', '3', '2-1 Pre-course Listening and Reading 课前听读', '1');
INSERT INTO `hi_conf_sub_unit` VALUES ('8', '3', '4', '2-2 Vocabulary Gym 课前单词健身房', '1');
INSERT INTO `hi_conf_sub_unit` VALUES ('9', '3', '5', '2-3 Guided Reading Course 英文原版导读课', '1');
INSERT INTO `hi_conf_sub_unit` VALUES ('10', '3', '6', '2-4 Review Homework 课后复习作业', '1');
INSERT INTO `hi_conf_sub_unit` VALUES ('11', '4', '3', '3-1 Pre-course Listening and Reading 课前听读', '1');
INSERT INTO `hi_conf_sub_unit` VALUES ('12', '4', '4', '3-2 Vocabulary Gym 课前单词健身房', '1');
INSERT INTO `hi_conf_sub_unit` VALUES ('13', '4', '5', '3-3 Guided Reading Course 英文原版导读课', '1');
INSERT INTO `hi_conf_sub_unit` VALUES ('14', '4', '6', '3-4 Review Homework 课后复习作业', '1');
INSERT INTO `hi_conf_sub_unit` VALUES ('15', '5', '3', '4-1 Pre-course Listening and Reading 课前听读', '1');
INSERT INTO `hi_conf_sub_unit` VALUES ('16', '5', '4', '4-2 Vocabulary Gym 课前单词健身房', '1');
INSERT INTO `hi_conf_sub_unit` VALUES ('17', '5', '5', '4-3 Guided Reading Course 英文原版导读课', '1');
INSERT INTO `hi_conf_sub_unit` VALUES ('18', '5', '6', '4-4 Review Homework 课后复习作业', '1');
INSERT INTO `hi_conf_sub_unit` VALUES ('19', '6', '3', '5-1 Pre-course Listening and Reading 课前听读', '1');
INSERT INTO `hi_conf_sub_unit` VALUES ('20', '6', '4', '5-2 Vocabulary Gym 课前单词健身房', '1');
INSERT INTO `hi_conf_sub_unit` VALUES ('21', '6', '5', '5-3 Guided Reading Course 英文原版导读课', '1');
INSERT INTO `hi_conf_sub_unit` VALUES ('22', '6', '6', '5-4 Review Homework 课后复习作业', '1');
INSERT INTO `hi_conf_sub_unit` VALUES ('23', '7', '3', '6-1 Pre-course Listening and Reading 课前听读', '1');
INSERT INTO `hi_conf_sub_unit` VALUES ('24', '7', '4', '6-2 Vocabulary Gym 课前单词健身房', '1');
INSERT INTO `hi_conf_sub_unit` VALUES ('25', '7', '5', '6-3 Guided Reading Course 英文原版导读课', '1');
INSERT INTO `hi_conf_sub_unit` VALUES ('26', '7', '6', '6-4 Review Homework 课后复习作业', '1');
INSERT INTO `hi_conf_sub_unit` VALUES ('27', '8', '7', '课后测', '1');
INSERT INTO `hi_conf_sub_unit` VALUES ('28', '8', '8', 'Free Talk', '1');
INSERT INTO `hi_conf_sub_unit` VALUES ('29', '9', '1', '课前测', '1');
INSERT INTO `hi_conf_sub_unit` VALUES ('30', '9', '2', 'Free Talk (optional)', '0');
INSERT INTO `hi_conf_sub_unit` VALUES ('31', '10', '3', '1-1 Pre-course Listening and Reading 课前听读', '1');
INSERT INTO `hi_conf_sub_unit` VALUES ('32', '10', '4', '1-2 Vocabulary Gym 课前单词健身房', '1');
INSERT INTO `hi_conf_sub_unit` VALUES ('33', '10', '5', '1-3 Guided Reading Course 英文原版导读课', '1');
INSERT INTO `hi_conf_sub_unit` VALUES ('34', '10', '6', '1-4 Review Homework 课后复习作业', '1');
INSERT INTO `hi_conf_sub_unit` VALUES ('35', '11', '3', '2-1 Pre-course Listening and Reading 课前听读', '1');
INSERT INTO `hi_conf_sub_unit` VALUES ('36', '11', '4', '2-2 Vocabulary Gym 课前单词健身房', '1');
INSERT INTO `hi_conf_sub_unit` VALUES ('37', '11', '5', '2-3 Guided Reading Course 英文原版导读课', '1');
INSERT INTO `hi_conf_sub_unit` VALUES ('38', '11', '6', '2-4 Review Homework 课后复习作业', '1');
INSERT INTO `hi_conf_sub_unit` VALUES ('39', '12', '3', '3-1 Pre-course Listening and Reading 课前听读', '1');
INSERT INTO `hi_conf_sub_unit` VALUES ('40', '12', '4', '3-2 Vocabulary Gym 课前单词健身房', '1');
INSERT INTO `hi_conf_sub_unit` VALUES ('41', '12', '5', '3-3 Guided Reading Course 英文原版导读课', '1');
INSERT INTO `hi_conf_sub_unit` VALUES ('42', '12', '6', '3-4 Review Homework 课后复习作业', '1');
INSERT INTO `hi_conf_sub_unit` VALUES ('43', '13', '3', '4-1 Pre-course Listening and Reading 课前听读', '1');
INSERT INTO `hi_conf_sub_unit` VALUES ('44', '13', '4', '4-2 Vocabulary Gym 课前单词健身房', '1');
INSERT INTO `hi_conf_sub_unit` VALUES ('45', '13', '5', '4-3 Guided Reading Course 英文原版导读课', '1');
INSERT INTO `hi_conf_sub_unit` VALUES ('46', '13', '6', '4-4 Review Homework 课后复习作业', '1');
INSERT INTO `hi_conf_sub_unit` VALUES ('47', '14', '7', '课后测', '1');
INSERT INTO `hi_conf_sub_unit` VALUES ('48', '14', '8', 'Free Talk', '1');

-- ----------------------------
-- Table structure for hi_conf_sub_unit_train
-- ----------------------------
DROP TABLE IF EXISTS `hi_conf_sub_unit_train`;
CREATE TABLE `hi_conf_sub_unit_train` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `SUnitId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '子单元ID',
  `Questions` varchar(100) NOT NULL DEFAULT '0' COMMENT '跳出题目ID',
  `Min` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '分',
  `Sec` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '秒',
  PRIMARY KEY (`ID`),
  KEY `SUnitId` (`SUnitId`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=88 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hi_conf_sub_unit_train
-- ----------------------------
INSERT INTO `hi_conf_sub_unit_train` VALUES ('1', '5', '67', '1', '42');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('2', '5', '68', '1', '54');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('3', '5', '69', '2', '31');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('4', '5', '70', '3', '36');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('5', '5', '71', '5', '3');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('6', '5', '72', '6', '18');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('7', '5', '73', '6', '47');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('8', '5', '74', '9', '8');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('9', '5', '75', '9', '34');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('10', '5', '76', '10', '53');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('11', '5', '77', '11', '54');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('12', '5', '78', '13', '0');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('13', '5', '79', '13', '12');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('14', '5', '80', '14', '45');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('15', '5', '81', '16', '21');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('16', '5', '82', '16', '54');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('17', '5', '83', '18', '42');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('18', '5', '84', '20', '11');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('19', '5', '85', '21', '14');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('20', '5', '86', '22', '18');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('21', '5', '87', '23', '22');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('22', '33', '158', '0', '39');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('24', '33', '161', '1', '56');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('25', '33', '163', '3', '14');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('26', '33', '164', '3', '53');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('27', '33', '165', '4', '2');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('29', '33', '167', '4', '24');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('30', '33', '169', '4', '55');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('32', '33', '172', '5', '42');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('33', '33', '175', '8', '0');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('34', '33', '176', '8', '12');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('35', '33', '177', '8', '24');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('36', '33', '178', '9', '8');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('37', '33', '179', '9', '16');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('41', '33', '185', '14', '1');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('46', '37', '191', '1', '25');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('47', '37', '192', '1', '38');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('48', '37', '193', '2', '37');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('49', '37', '194', '3', '47');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('50', '37', '195', '3', '57');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('51', '37', '196', '4', '25');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('52', '37', '198', '4', '43');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('53', '37', '200', '8', '3');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('54', '37', '201', '8', '37');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('55', '37', '202', '9', '12');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('58', '41', '209', '0', '51');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('59', '41', '210', '1', '10');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('60', '41', '212', '1', '42');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('61', '41', '213', '4', '20');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('63', '41', '216', '6', '24');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('64', '41', '217', '6', '45');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('65', '41', '219', '8', '8');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('66', '41', '220', '8', '43');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('68', '41', '223', '9', '40');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('69', '41', '225', '11', '41');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('70', '41', '226', '13', '46');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('71', '41', '227', '14', '1');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('73', '45', '229', '1', '1');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('74', '45', '231', '2', '35');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('75', '45', '232', '3', '16');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('76', '45', '234', '4', '1');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('77', '45', '236', '5', '7');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('78', '45', '237', '8', '5');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('79', '45', '238', '8', '39');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('80', '45', '240', '10', '48');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('81', '45', '241', '11', '21');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('82', '45', '242', '11', '49');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('83', '45', '243', '12', '14');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('84', '33', '261', '16', '9');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('85', '37', '262', '14', '54');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('86', '41', '263', '16', '16');
INSERT INTO `hi_conf_sub_unit_train` VALUES ('87', '45', '264', '15', '25');

-- ----------------------------
-- Table structure for hi_conf_topic
-- ----------------------------
DROP TABLE IF EXISTS `hi_conf_topic`;
CREATE TABLE `hi_conf_topic` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `SUnitId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '子单元ID',
  `Title` varchar(255) NOT NULL DEFAULT '' COMMENT '题目名称',
  `Image` varchar(255) NOT NULL DEFAULT '' COMMENT '题目图片',
  `Audio` varchar(255) NOT NULL DEFAULT '' COMMENT '音频文件',
  `QAudio` varchar(255) NOT NULL DEFAULT '' COMMENT '问题描述音频文件',
  `Type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '题目类型(1:true/false2:单选题3:视频课4:单词卡5:填空-单词6:填空-句子7:造句8:图片记忆9:拖动对应文字图片10:开放性问题11:顺序拖动)',
  `Video` varchar(255) NOT NULL DEFAULT '' COMMENT '视频地址',
  `Poster` varchar(255) NOT NULL DEFAULT '' COMMENT '视频封面',
  `PreviewIntro` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  `SoundMark` varchar(50) NOT NULL DEFAULT '' COMMENT '音标',
  `CNMark` varchar(30) NOT NULL DEFAULT '' COMMENT '中文注释',
  `ENMark` varchar(200) NOT NULL DEFAULT '' COMMENT '英文注释',
  `Sample` varchar(100) NOT NULL DEFAULT '' COMMENT '例句',
  `SampleAudio` varchar(200) NOT NULL DEFAULT '' COMMENT '例句音频',
  `Correct` varchar(50) NOT NULL DEFAULT '' COMMENT '正确答案',
  `Analysis` text COMMENT '题目解析',
  `AAudio` varchar(255) NOT NULL DEFAULT '' COMMENT '解析音频',
  `AVideo` varchar(255) NOT NULL DEFAULT '' COMMENT '问题解析视频',
  `Translate` text COMMENT '翻译',
  `Help` varchar(255) NOT NULL DEFAULT '' COMMENT '帮助',
  `Matrix` varchar(20) NOT NULL DEFAULT '' COMMENT '矩阵大小(行数_列数)',
  `Gold` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '奖励金币数',
  `IsTrain` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否是联系题目(0:否1:是)',
  `Category` varchar(20) NOT NULL DEFAULT '' COMMENT 'CCSS细项',
  `VideoTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '视频时长',
  PRIMARY KEY (`ID`),
  KEY `SUnitId` (`SUnitId`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=265 DEFAULT CHARSET=utf8 COMMENT='题目表';

-- ----------------------------
-- Records of hi_conf_topic
-- ----------------------------
INSERT INTO `hi_conf_topic` VALUES ('1', '4', 'brave', 'L2-Balto/1-4-brave.png', 'L2-Balto/1-4-brave.mp3', '', '4', '', '', '', '/brev/', 'adj. 勇敢的', 'feeling or showing no fear', 'Brave firefighters are fighting a fire. 勇敢的消防员们正在灭火。', 'L2-Balto/1-4-Brave_firefighters_are_fighting_a_fire.mp3', '', '', '', '', '', '', '', '1', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('2', '4', 'bury', 'L2-Balto/1-4-bury.png', 'L2-Balto/1-4-bury.mp3', '', '4', '', '', '', '/\'bɛri/', 'v. 埋', 'to cover (someone or something) with something', 'The car was buried under the snow. 这辆车被埋在了大雪下面。', 'L2-Balto/1-4-The_car_was_buried_under_the_snow.mp3', '', '', '', '', '', '', '', '1', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('3', '4', 'terrible', 'L2-Balto/1-4-terrible.png', 'L2-Balto/1-4-terrible.mp3', '', '4', '', '', '', '/\'tɛrəbl/', 'adj. 糟糕的', 'very bad or unpleasant', 'I have a terrible cold. 我得了重感冒。', 'L2-Balto/1-4-I_have_a_terrible_cold.mp3', '', '', '', '', '', '', '', '1', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('4', '4', 'get sick', 'L2-Balto/1-4-get_sick.png', 'L2-Balto/1-4-get_sick.mp3', '', '4', '', '', '', '/ɡɛt/ /sɪk/', '生病', 'be ill; affected with a disease or illness', 'Will robots get sick? 机器人会生病吗？', 'L2-Balto/1-4-Will_robots_get_sick.mp3', '', '', '', '', '', '', '', '1', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('5', '4', 'Moving Tabs 拖动配对', '', 'L2-Balto/Moving_Tabs.mp3', '', '9', '', '', '', '', '', '', '', '', '', 'get sick 生病;\nbury v. 埋;\nbrave adj. 勇敢的', '', '', '', 'get sick 生病\nbury v. 埋\nbrave adj. 勇敢的', '', '4', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('6', '4', 'Making Sentences 造句', 'L2-Balto/1-4-Balto_was_a_lead_dog.jpeg', 'L2-Balto/Making_Sentences.mp3', '', '7', '', '', '', '', '', '', '', '', '4|5|6|7|8', 'Balto was a sled dog.', 'L2-Balto/1-4-Balto_was_a_sled_dog.mp3', '', 'Balto是领头狗。', 'Check Page 7', '', '4', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('7', '4', 'Fill in the Blank 填空', 'L2-Balto/1-4-terrible.png', 'L2-Balto/1-4-terrible.mp3', '', '5', '', '', '', '', '', '', '', '', '9', 'terrible adj. 糟糕的', '', '', '糟糕的', 'terrible', '', '2', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('8', '8', 'got stuck', 'L2-Balto/1-8-got_stuck.png', 'L2-Balto/1-8-got_stuck.mp3', '', '4', '', '', '', '/ɡɑt/ /stʌk/ ', '被卡在… 被困在… ', 'difficult or impossible to move from a position', 'Winnie the Pooh got stuck in a hole.', 'L2-Balto/1-8-Winnie_the_Pooh_got_stuck_in_a_hole.mp3', '', '', '', '', '', '', '', '1', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('9', '8', 'take over', 'L2-Balto/1-8-take_over.png', 'L2-Balto/1-8-take_over.mp3', '', '4', '', '', '', '/tek/ /\'ovɚ/', '接手，接管', 'to start doing (something that someone has stopped doing)', 'Do you worry about robots someday taking over the world?', 'L2-Balto/1-8-Do_you_worry_about_robots_someday_taking_over_the_world.mp3', '', '', '', '', '', '', '', '1', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('10', '8', 'choice', 'L2-Balto/1-8-choice.jpeg', 'L2-Balto/1-8-choice.mp3', '', '4', '', '', '', '/tʃɔɪs/', 'n. 选择', 'the act of picking or deciding between two or more possibilities', 'There is a choice of five different colors.', 'L2-Balto/1-8-There_is_a_choice_of_five_different_colors.mp3', '', '', '', '', '', '', '', '1', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('11', '8', 'Making Sentences 造句', 'L2-Balto/1-8-The_train_got_stuck_in_the_deep_snow.jpeg', 'L2-Balto/Making_Sentences.mp3', '', '7', '', '', '', '', '', '', '', '', '10|11|12|13|14', 'The train got stuck in the deep snow.', 'L2-Balto/1-4-The_train_got_stuck_in_the_deep_snow.mp3', '', '火车困在了深深的雪中。', 'Check Page 15', '', '4', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('12', '12', 'come to the rescue', 'L2-Balto/1-12-come_to_the_rescue.png', 'L2-Balto/1-12-come_to_the_rescue.mp3', '', '4', '', '', '', '/\'rɛskju/', '营救，援救', 'an act of saving someone or something from danger, harm, or trouble', 'Will you come to the rescue of this kitten?', 'L2-Balto/1-12-Will_you_come_to_the_rescue_of_this_kitten.mp3', '', '', '', '', '', '', '', '1', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('13', '12', 'make it', 'L2-Balto/1-12-make_it.png', 'L2-Balto/1-12-make_it.mp3', '', '4', '', '', '', '/mek/ /ɪt/', '达到预定目标；及时抵达', 'to reach a particular place, goal, etc.', 'Then you guys can make it to Japan.', 'L2-Balto/1-12-Then_you_guys_can_make_it_to_Japan.mp3', '', '', '', '', '', '', '', '1', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('14', '12', 'hitch', 'L2-Balto/1-12-hitch.png', 'L2-Balto/1-12-hitch.mp3', '', '4', '', '', '', '/hɪtʃ/', 'v. 〔用绳子、链条等〕将…拴于，套住', 'to attach, fasten, or connect (something) with a hook, knot, etc.', 'The driver should know how to hitch a dog to the sled.', 'L2-Balto/1-12-The_driver_should_know_how_to_hitch_a_dog_to_the_sled.mp3', '', '', '', '', '', '', '', '1', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('15', '12', 'slow down', 'L2-Balto/1-12-slow_down.png', 'L2-Balto/1-12-slow_down.mp3', '', '4', '', '', '', '/sloʊ/ /daʊn/', '慢下来，减速', 'to stop being very active, talking very fast, etc.', 'The bus slowed down for the next stop.', 'L2-Balto/1-12-The_bus_slowed_down_for_the_next_stop.mp3', '', '', '', '', '', '', '', '1', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('16', '12', 'Fill in the Blank 填空', 'L2-Balto/1-12-hitch.png', 'L2-Balto/1-12-hitch.mp3', '', '5', '', '', '', '', '', '', '', '', '15', 'hitch v. 〔用绳子、链条等〕将…拴于，套住', '', '', 'v. 〔用绳子、链条等〕将…拴于，套住', 'hitch', '', '2', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('17', '12', 'Fill in the Blank 填空', 'L2-Balto/1-12-Balto_would_come_to_the_rescue.jpeg', 'L2-Balto/1-12-Balto_would_come_to_the_rescue.mp3', '', '6', '', '', '', '', '', '', '', '', '17', 'rescue n. 营救', '', '', 'n. 营救', 'rescue', '', '2', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('18', '16', 'crack', 'L2-Balto/1-16-crack.jpeg', 'L2-Balto/1-16-crack.mp3', '', '4', '', '', '', '/kræk/', 'v. （使）发爆裂声', 'to cause (something) to make a sudden loud sound', 'Do you know how to crack a whip?', 'L2-Balto/1-16-Do_you_know_how_to_crack_a_whip.mp3', '', '', '', '', '', '', '', '1', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('19', '16', 'block', 'L2-Balto/1-16-block.jpeg', 'L2-Balto/1-16-block.mp3', '', '4', '', '', '', '/blɑk/', 'v. 阻挡', 'to be placed in front of (something, such as a road or path) so that people or things cannot pass through', 'Fallen trees blocked the road.', 'L2-Balto/1-16-Fallen_trees_blocked_the_road.mp3', '', '', '', '', '', '', '', '1', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('20', '16', 'sink', 'L2-Balto/1-16-sink.jpeg', 'L2-Balto/1-16-sink.mp3', '', '4', '', '', '', '/sɪŋk/', 'v. 下沉', 'o go down below the surface of water, mud, etc.', 'The Titanic sank to the bottom of the ocean in 1912.', 'L2-Balto/1-16-The_Titanic_sank_to_the_bottom_of_the_ocean_in_1912.mp3', '', '', '', '', '', '', '', '1', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('21', '16', 'dig', 'L2-Balto/1-16-dig.png', 'L2-Balto/1-16-dig.mp3', '', '4', '', '', '', '/dɪɡ/', 'v. 挖掘', 'to uncover (something that is underground) by moving earth, soil, sand, etc.', 'I dug my car out of the snow.', 'L2-Balto/1-16-I_dug_my_car_out_of_the_snow.mp3', '', '', '', '', '', '', '', '1', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('22', '16', 'slip', 'L2-Balto/1-16-slip.png', 'L2-Balto/1-16-slip.mp3', '', '4', '', '', '', '/slɪp/', 'v. 滑倒', 'to move over ice or snow smoothly and often in a way that cannot be controlled', 'Teddy bear slipped on the ice.', 'L2-Balto/1-16-Teddy_bear_slipped_on_the_ice.mp3', '', '', '', '', '', '', '', '1', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('23', '16', 'drown', 'L2-Balto/1-16-drown.png', 'L2-Balto/1-16-drown.mp3', '', '4', '', '', '', '/draʊn/', 'v. 淹死', 'to die by being underwater too long and unable to breathe', 'We should help them, or they will drown.', 'L2-Balto/1-16-We_should_help_them,_or_they_will_drown.mp3', '', '', '', '', '', '', '', '1', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('24', '16', 'Clicking Pairs', '', '', '', '8', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '2_3', '4', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('25', '16', 'Fill in the Blank 填空', 'L2-Balto/1-16-drown.png', 'L2-Balto/1-16-drown.mp3', '', '5', '', '', '', '', '', '', '', '', '22', 'drown v. 淹死', '', '', 'v. 淹死', 'drown', '', '2', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('26', '16', 'Fill in the Blank 填空', 'L2-Balto/1-16-Gunnar_cracked_his_whip.png', 'L2-Balto/1-16-Gunnar_cracked_his_whip.mp3', '', '6', '', '', '', '', '', '', '', '', '24', 'crack v. （使）发爆裂声', '', '', 'Gunnar甩了个响鞭。', 'Check Page 29', '', '2', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('27', '20', 'in time', 'L2-Balto/1-20-in_time.jpeg', 'L2-Balto/1-20-in_time.mp3', '', '4', '', '', '', '/ɪn/ /taɪm/', 'idiom. 及时', 'before something happens; early enough', 'Jimmy caught the bus just in time.', 'L2-Balto/1-20-Jimmy_caught_the_bus_just_in_time.mp3', '', '', '', '', '', '', '', '1', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('28', '20', 'reach', 'L2-Balto/1-20-reach.png', 'L2-Balto/1-20-reach.mp3', '', '4', '', '', '', '/ritʃ/', 'v. 到达', 'to arrive at (a place that you have been traveling to)', 'Our bus reached Disneyland!', 'L2-Balto/1-20-Our_bus_reached_Disneyland.mp3', '', '', '', '', '', '', '', '1', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('29', '20', 'have no idea', 'L2-Balto/1-20-have_no_idea.png', 'L2-Balto/1-20-have_no_idea.mp3', '', '4', '', '', '', '/aɪ\'diə/', 'exp. 不知道', 'didn\'t know', 'Anna had no idea where she was.', 'L2-Balto/1-20-Anna_had_no_idea_where_she_was.mp3', '', '', '', '', '', '', '', '1', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('30', '20', 'up to', 'L2-Balto/1-20-up_to.png', 'L2-Balto/1-20-up_to.mp3', '', '4', '', '', '', '/ʌp/ /tuː/', 'idiom. 决定', 'used to say who is responsible for making a choice or decision', 'Italian food or Chinese food? It is up to you!', 'L2-Balto/1-20-It_is_up_to_you.mp3', '', '', '', '', '', '', '', '1', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('31', '20', 'die down', 'L2-Balto/1-20-die_down.png', 'L2-Balto/1-20-die_down.mp3', '', '4', '', '', '', '/dai/ /daʊn/', 'exp. 减弱', 'to gradually become less strong', 'The wind will die down tomorrow morning.', 'L2-Balto/1-20-The_wind_will_die_down_tomorrow_morning.mp3', '', '', '', '', '', '', '', '1', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('32', '20', 'dawn', 'L2-Balto/1-20-dawn.png', 'L2-Balto/1-20-dawn.mp3', '', '4', '', '', '', '/dɔn/', 'n. 黎明', 'the time of day when sunlight first begins to appear', 'The farmer starts to work at dawn.', 'L2-Balto/1-20-The_farmer_starts_to_work_at_dawn.mp3', '', '', '', '', '', '', '', '1', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('33', '20', 'Clicking Pairs', '', '', '', '8', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '2_3', '4', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('34', '20', 'Fill in the Blank 填空', 'L2-Balto/1-20-Finally_the_storm_died_down.png', 'L2-Balto/1-20-Finally_the_storm_died_down.mp3', '', '6', '', '', '', '', '', '', '', '', '30|31', 'die down 减弱', '', '', '最终暴风雪减弱下来了。', 'Check Page 40', '', '2', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('35', '20', 'Fill in the Blank 填空', 'L2-Balto/1-20-Balto_had_stopped_just_in_time.png', 'L2-Balto/1-20-Balto_had_stopped_just_in_time.mp3', '', '6', '', '', '', '', '', '', '', '', '34|35', 'in time 及时', '', '', 'Balto及时停下来了。', 'Check Page 36', '', '2', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('36', '24', 'straight', 'L2-Balto/1-24-straight.jpeg', 'L2-Balto/1-24-straight.mp3', '', '4', '', '', '', '/stret/', 'adj. 连续的', 'following each other without interruption', 'Grace sat in the office for five hours straight.', 'L2-Balto/1-24-Grace_sat_in_the_office_for_five_hours_straight.mp3', '', '', '', '', '', '', '', '1', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('37', '24', 'deliver', 'L2-Balto/1-24-deliver.jpeg', 'L2-Balto/1-24-deliver.mp3', '', '4', '', '', '', '/dɪ\'lɪvɚ/', 'v. 递送，传送', 'to take (something) to a person or place', 'Kim delivered a package to my house this morning.', 'L2-Balto/1-24-Kim_delivered_a_package_to_my_house_this_morning.mp3', '', '', '', '', '', '', '', '1', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('38', '24', 'hero', 'L2-Balto/1-24-hero.jpeg', 'L2-Balto/1-24-hero.mp3', '', '4', '', '', '', '/\'hɪro/', 'n. 英雄', 'a person who is admired for great or brave acts or fine qualities', 'Do you want to be a hero?', 'L2-Balto/1-24-Do_you_want_to_be_a_hero.mp3', '', '', '', '', '', '', '', '1', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('39', '24', 'cheer', 'L2-Balto/1-24-cheer.png', 'L2-Balto/1-24-cheer.mp3', '', '4', '', '', '', '/tʃɪr/', 'v. 欢呼，喝彩', 'to shout with joy, approval, or enthusiasm', 'The crowd cheered as she crossed the finish line.', 'L2-Balto/1-24-The_crowd_cheered_as_she_crossed_the_finish_line.mp3', '', '', '', '', '', '', '', '1', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('40', '24', 'remember', 'L2-Balto/1-24-remember.jpeg', 'L2-Balto/1-24-remember.mp3', '', '4', '', '', '', '/rɪ\'mɛmbɚ/', 'v. 纪念，牢记e', 'to think of again', 'On this day, let us remember our nation\'s heros.', 'L2-Balto/1-24-let_us_remember_our_nation\'s_heros.mp3', '', '', '', '', '', '', '', '1', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('41', '24', 'Moving Tabs 拖动配对', '', 'L2-Balto/Moving_Tabs.mp3', '', '9', '', '', '', '', '', '', '', '', '', 'deliver v. 递送\nhero n. 英雄\ncheer v. 欢呼', '', '', '', 'deliver v. 递送\nhero n. 英雄\ncheer v. 欢呼', '', '4', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('42', '24', 'Fill in the Blank 填空', 'L2-Balto/1-24-They_remember_Balto,_the_bravest_dog_ever.png', 'L2-Balto/1-24-They_remember_Balto,_the_bravest_dog_ever.mp3', '', '6', '', '', '', '', '', '', '', '', '41', 'remember v. 纪念', '', '', '他们永远纪念Balto.', 'remember', '', '2', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('43', '24', 'Clicking Pairs', '', '', '', '8', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '2_3', '4', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('44', '24', 'Which word below means to think of again?', '', 'L2-Balto/1-24-Which_word_below_means_to_think_of_again.mp3', '', '2', '', '', '', '', '', '', '', '', '46', 'Remember means to think of again.', '', '', '以下哪个单词表示再次想起？', 'Remember means to think of again.', '', '2', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('45', '1', 'This book about Balto is based on a true story.', '', 'L2-Balto/1-1-This_book_about_Balto_is_based_on_a_true_story.mp3', '', '1', '', '', '', '', '', '', '', '', '50', '正确。这本书讲述的是一个真实的故事。根据原文第一段：This is a true story about a very brave dog.', '', '', '这本关于Balto的书讲述的是真实故事。', 'Check Page 5', '', '2', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('46', '1', 'When does this story take place?', '', 'L2-Balto/1-46-When_does_this_story_take_place.mp3', '', '2', '', '', '', '', '', '', '', '', '54', '故事发生在1925年。The year was 1925.', '', '', '这个故事发生在哪一年？', 'Check Page 5 & 21', '', '2', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('47', '1', 'Making Sentences 造句', '', 'L2-Balto/Making_Sentences.mp3', '', '7', '', '', '', '', '', '', '', '', '56|57|58|59|60', '正确句子为：The children had a terrible sickness', '', '', '孩子们患了重病。', 'Check Page 12', '', '4', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('48', '1', 'Which picture below is a sled?', '', 'L2-Balto/1-48-Which_picture_below_is_a_sled.mp3', '', '2', '', '', '', '', '', '', '', '', '63', 'Sled n. 雪橇', '', '', '以下哪张图是雪橇?', 'Check the picture on page 6', '', '2', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('49', '1', 'Moving Tabs 拖动配对', '', 'L2-Balto/Moving_Tabs.mp3', '', '9', '', '', '', '', '', '', '', '', '', 'doctor n. 医生；dog sled 狗拉雪橇；sickness n. 疾病', '', '', '', 'doctor n. 医生；dog sled 狗拉雪橇；sickness n. 疾病', '', '4', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('50', '6', 'Who is the author of the book Balto?', '', 'L2-Balto/1-50-Who_is_the_author_of_the_book_Balto.mp3', '', '2', '', '', '', '', '', '', '', '', '68', '本书的作者是Natalie Standiford', '', '', 'Balto这本书的作者是谁？', 'Check the cover of the book', '', '2', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('51', '6', 'Most of the year the town Nome is warm.', '', 'L2-Balto/1-51-Most_of_the_year_the_town_Nome_is_warm.mp3', '', '1', '', '', '', '', '', '', '', '', '73', '错误。Nome这个小镇非常寒冷，绝大部分都是处于冰雪天。False. Nome was a frontier town. Most of lthe year it was buried under ice and snow. Therefore, it is cold.', '', '', '小镇Nome大部分的时候气候都很温暖。', 'Check Page 5', '', '2', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('52', '6', 'In the video, how does the little girl feel about her new sled? ', '', 'L2-Balto/1-52-how_does_the_little_girl_feel_about_her_new_sled.mp3', '', '2', 'L2-Balto/1-52-Rosie_present.mp4', 'L2-Balto/1-52-Rosie_present.png', '', '', '', '', '', '', '75', '视频中，当小女孩看到她的新礼物雪橇，非常激动和开心。“I love this sled!” she said. ', '', '', '视频中，当小女孩看到新的雪橇是她感受和心情如何？', 'The little girl likes her new gift very much, and she looks very happy.', '', '2', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('53', '6', 'Open-ended Question 开放性问题：Travelling in Nome', '', 'L2-Balto/1-53-OEQ-Travelling_in_Nome.mp3', '', '10', '', '', 'In the story, it mentions that in winter it was not easy to travel through all that ice and snow in Nome. Not on planes or trains or boats or cars. Why? What do you think might be the good way to travel there in winter? (At least 3 sentences. 至少3句话）', '', '', '', '', '', '', '', '', '', '故事中提到，在冬天，飞机、船、火车、汽车都无法穿越冰雪覆盖的Nome小镇，为什么呢？你觉得冬天在Nome小镇旅行的最好方式是什么？', '', '', '4', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('54', '14', 'Timeline 时序题:  Transporting the Medicine', 'L2-Balto/1-54-Timeline-Transporting_the_Medicine.png', '', '', '11', '', '', '', '', '', '', '', '', '78|79|80|81', '', '', '', '药物运输', 'Check Page 14-26 回顾书里14-26页的故事情节和顺序', '', '0', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('55', '3', '', '', '', '', '3', 'L2-Balto/Balto_1-1.mp4', 'L2-Balto/Video_Cover.png', '', '', '', '', '', '', '', '', '', '', '', '', '', '0', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('56', '7', '', '', '', '', '3', 'L2-Balto/Balto_2-1.mp4', 'L2-Balto/Video_Cover.png', '', '', '', '', '', '', '', '', '', '', '', '', '', '0', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('57', '11', '', '', '', '', '3', 'L2-Balto/Balto_3-1.mp4', 'L2-Balto/Video_Cover.png', '', '', '', '', '', '', '', '', '', '', '', '', '', '0', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('58', '15', '', '', '', '', '3', 'L2-Balto/Balto_4-1.mp4', 'L2-Balto/Video_Cover.png', '', '', '', '', '', '', '', '', '', '', '', '', '', '0', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('59', '19', '', '', '', '', '3', 'L2-Balto/Balto_5-1.mp4', 'L2-Balto/Video_Cover.png', '', '', '', '', '', '', '', '', '', '', '', '', '', '0', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('60', '23', '', '', '', '', '3', 'L2-Balto/Balto_6-1.mp4', 'L2-Balto/Video_Cover.png', '', '', '', '', '', '', '', '', '', '', '', '', '', '0', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('61', '5', '', '', '', '', '3', 'L2-Balto/Balto_1-3.mp4', 'L2-Balto/Video_Cover.png', '', '', '', '', '', '', '', '', '', '', '', '', '', '0', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('62', '9', '', '', '', '', '3', 'L2-Balto/Balto_2-3.mp4', 'L2-Balto/Video_Cover.png', '', '', '', '', '', '', '', '', '', '', '', '', '', '0', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('63', '13', '', '', '', '', '3', 'L2-Balto/Balto_3-3.mp4', 'L2-Balto/Video_Cover.png', '', '', '', '', '', '', '', '', '', '', '', '', '', '0', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('64', '17', '', '', '', '', '3', 'L2-Balto/Balto_4-3.mp4', 'L2-Balto/Video_Cover.png', '', '', '', '', '', '', '', '', '', '', '', '', '', '0', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('65', '21', '', '', '', '', '3', 'L2-Balto/Balto_5-3.mp4', 'L2-Balto/Video_Cover.png', '', '', '', '', '', '', '', '', '', '', '', '', '', '0', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('66', '25', '', '', '', '', '3', 'L2-Balto/Balto_6-3.mp4', 'L2-Balto/Video_Cover.png', '', '', '', '', '', '', '', '', '', '', '', '', '', '0', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('67', '5', 'Who is this dog?', 'L2-Balto/1-5-balto_statue.png', 'L2-Balto/1-5-Who_is_this_dog.mp3', '', '2', '', '', '', '', '', '', '', '', '83', 'That\'s right! He is Balto.', '', '', '这只狗是谁？', 'What is the name of the book?', '', '2', '1', 'RI.1.1', '0');
INSERT INTO `hi_conf_topic` VALUES ('68', '5', 'Why is he remembered until this very day?', '', 'L2-Balto/1-5-Why_is_he_remembered_until_this_very_day.mp3', '', '2', '', '', '', '', '', '', '', '', '84', 'Your idea is that he\'s important, that\'s great!', '', '', '为什么他被人们一直纪念到现在？', 'Statues are usaully made for a good reason.', '', '2', '1', 'RI.1.1', '0');
INSERT INTO `hi_conf_topic` VALUES ('69', '5', 'How is the weather in Nome, Alaska?', '', 'L2-Balto/1-5-How_is_the_weather_in_Nome,_Alaska.mp3', '', '2', '', '', '', '', '', '', '', '', '86', 'It has snow, so it must be cold and icy.', '', '', 'Nome, Alaska的天气怎么样？', 'It\'s not warm, hot, or damp.', '', '2', '1', 'RI.1.1', '0');
INSERT INTO `hi_conf_topic` VALUES ('70', '5', 'Which of these are \"brave knights\"?', '', 'L2-Balto/1-5-Which_of_these_are_brave_knights.mp3', '', '2', '', '', '', '', '', '', '', '', '147', 'Brave knights don\'t run away, they fight dragons.', '', '', '以下哪些是“勇敢的骑士”？', 'Which picture has more than one person in it?', '', '2', '1', 'RI.1.9', '0');
INSERT INTO `hi_conf_topic` VALUES ('71', '5', 'What is buried under the white snow?', 'L2-Balto/1-5-car_buried_under_sonw.png', 'L2-Balto/1-5-What_is_buried_under_the_white_snow.mp3', '', '2', '', '', '', '', '', '', '', '', '90', 'You can see parts of the car under the snow.', '', '', '被埋在白雪下的是什么？', 'It has 4 wheels and you can drive it.', '', '2', '1', 'RI.1.1', '0');
INSERT INTO `hi_conf_topic` VALUES ('72', '5', 'What cities in China are this cold?', '', 'L2-Balto/1-5-What_cities_in_China_are_this_cold.mp3', '', '2', '', '', '', '', '', '', '', '', '94', 'Harbin is in the north of China and very, very cold!', '', '', '中国的哪个城市会这样冷？', 'Which cities are in the North of China?', '', '2', '1', 'RI.1.1', '0');
INSERT INTO `hi_conf_topic` VALUES ('73', '5', 'Why was the only way to travel by sled dog?', '', 'L2-Balto/1-5-Why_was_the_only_way_to_travel_by_sled_dog.mp3', '', '2', '', '', '', '', '', '', '', '', '98', 'If you can\'t travel by train, car, or boat, you don\'t have many options. Dog sleds are faster than walking.', '', '', '为什么坐雪橇狗是唯一的旅行方式？', 'You could not travel by train, boat, or car.', '', '2', '1', 'RI.1.1', '0');
INSERT INTO `hi_conf_topic` VALUES ('74', '5', 'How many people are on the dogsled?', 'L2-Balto/1-5-how_many_people.png', 'L2-Balto/1-5-How_many_people_are_on_the_dogsled.mp3', '', '2', '', '', '', '', '', '', '', '', '102', 'There are 3 people and some bags on the sled.', '', '', '在狗拉雪橇上有几个人？', 'There are more than 2 people.', '', '2', '1', 'RI.1.1', '0');
INSERT INTO `hi_conf_topic` VALUES ('75', '5', 'What did Balto carry to the miners?', '', 'L2-Balto/1-5-What_did_Balto_carry_to_the_miners.mp3', '', '2', '', '', '', '', '', '', '', '', '106', 'Balto carried food and tools to miners so they could work.', '', '', 'Balto拉什么给矿工呢？', 'What do people need to eat and to work?', '', '2', '1', 'RI.1.1', '0');
INSERT INTO `hi_conf_topic` VALUES ('76', '5', 'Which dog is your favorite?', '', 'L2-Balto/1-5-Which_dog_is_your_favorite.mp3', '', '13', '', '', '', '', '', '', '', '', '151|152|153|154', 'Good choice! That is a nice looking dog.', '', '', '你最喜欢的是哪只狗？', 'Choose one of the four dogs that you just learned about.', '', '2', '1', 'RI.1.1', '0');
INSERT INTO `hi_conf_topic` VALUES ('77', '5', 'What is a lead dog?', '', 'L2-Balto/1-5-What_is_a_lead_dog.mp3', '', '2', '', '', '', '', '', '', '', '', '110', 'A lead dog is a dog that leads.  That ususally means that dog is first and others follow.', '', '', '领头狗是什么？', 'Is it a dog or a person?  Is it a leader or a follower?', '', '2', '1', 'RI.1.1', '0');
INSERT INTO `hi_conf_topic` VALUES ('78', '5', 'Which is the lead dog?', 'L2-Balto/1-5-which_is_the_lead_dog.png', 'L2-Balto/1-5-Which_is_the_lead_dog.mp3', '', '2', '', '', '', '', '', '', '', '', '114', 'The lead dog is in the front of the team.', '', '', '哪只是领头狗', 'Which dog is in front?', '', '2', '1', 'RI.1.9', '0');
INSERT INTO `hi_conf_topic` VALUES ('79', '5', 'Look at the pictures, what color is Balto?', 'L2-Balto/1-5-Balto\'s_color.png', 'L2-Balto/1-5-Look_at_the_pictures,_what_color_is_Balto.mp3', '', '2', '', '', '', '', '', '', '', '', '118', 'Balto is the lead dog and Balto is black.', '', '', '图片上Balto是什么颜色的？', 'What color is the lead dog?', '', '2', '1', 'RI.1.6', '0');
INSERT INTO `hi_conf_topic` VALUES ('80', '5', 'What are the two superlative adjectives in this sentence?', '', 'L2-Balto/1-5-What_are_the_two_superlative_adjectives_in_this_sentence.mp3', '', '2', '', '', 'So the lead dog has to be the smartest and strongest dog of all.', '', '', '', '', '', '122', 'The words \"smartest\" and \"strongest\" are suplerative adjectives.', '', '', '这个句子中哪两个是最高级？', 'Which two words mean the most strong and the most smart?', '', '2', '1', 'L.1.4b', '0');
INSERT INTO `hi_conf_topic` VALUES ('81', '5', 'Move the words to make a sentence.', 'L2-Balto/1-5-giraffes_are_the_tallest_animals.png', 'L2-Balto/1-5-Move_the_words_to_make_a_sentence.mp3', '', '7', '', '', '', '', '', '', '', '', '136|137|138|139', 'The giraffe is the tallest because the other animals are all shorter.', '', '', '', 'Giraffes are the tallest animals ____  ____  ____.', '', '2', '1', 'L.1.4b', '0');
INSERT INTO `hi_conf_topic` VALUES ('82', '5', 'Move the words to make a sentence.', 'L2-Balto/1-5-Dolphins_are_the_smartest_animals.png', 'L2-Balto/1-5-Move_the_words_to_make_a_sentence.mp3', '', '7', '', '', '', '', '', '', '', '', '140|141|142|143', 'Dolphins are smarter than all other animals, so they are the smartest.', '', '', '', '_____ _____ _____ smartest animals in the world.', '', '2', '1', 'L.1.4b', '0');
INSERT INTO `hi_conf_topic` VALUES ('83', '5', 'Click on the words that match the pictures.', '', 'L2-Balto/1-5-Click_on_the_words_that_match_the_pictures.mp3', '', '8', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '2_3', '4', '1', 'L.1.4b', '0');
INSERT INTO `hi_conf_topic` VALUES ('84', '5', 'What do you think the terrible news is?', 'L2-Balto/1-5-that\'s_terrible_news.png', 'L2-Balto/1-5-What_do_you_think_the_terrible_news_is.mp3', '', '2', '', '', '', '', '', '', '', '', '126', 'The video shows lots of wind. It\'s very windy!', '', '', '你觉得这个糟糕的消息是什么呢？', 'What do you see in the video? Wind, rain, snow, or ice?', '', '2', '1', 'RI.1.9', '0');
INSERT INTO `hi_conf_topic` VALUES ('85', '5', 'Can robots get sick?', '', 'L2-Balto/1-5-Can_robots_get_sick.mp3', '', '2', '', '', '', '', '', '', '', '', '130', 'Robots are machines, and they can\'t get sick.', '', '', '机器人会生病吗？', 'Living things can get sick. Are robots living things?', '', '2', '1', 'RI.1.9', '0');
INSERT INTO `hi_conf_topic` VALUES ('86', '5', 'What can you say when someone says \"good bye\"?', 'L2-Balto/1-5-good_bye.png', 'L2-Balto/1-5-What_can_you_say_when_someone_says_good_bye.mp3', '', '2', '', '', '', '', '', '', '', '', '132', 'Great job today!  Now learn more dogs names to get more coins!', '', '', '当某人对你说\"good bye\", 你应该说什么呢？', 'It\'s not \"Hello\".', '', '2', '1', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('87', '5', 'You completed unit 1!  Would you like 4 coins?', '', 'L2-Balto/1-5-You_completed_unit_1.mp3', '', '2', '', '', '', '', '', '', '', '', '134', 'See you later for unit 2!', '', '', '你已经完成了第一单元！想要4个金币吗？', 'Just say \"yes\"!', '', '4', '1', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('88', '10', 'Why was diphtheria a problem for the two children and the whole town?', '', 'L2-Balto/1-10-Why_was_diphtheria_a_problem_for_the_two_children_and_the_whole_town.mp3', '', '2', '', '', '', '', '', '', '', '', '155', 'Diphtheria is a highly contagious (传染性的) and deadly disease, and the doctor did not have the medicine he needed.', '', '', '为什么白喉病对两个小孩和整个村子都是一个难题？', 'Review Guided Reading Course, slide B-1 or check the book, page 12.', '', '2', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('89', '14', 'If Gunnar’s trip from Bluff to Point Safety was the second-to-last part of the race, what was the last part?', '', 'L2-Balto/1-14-What_was_the_last_part.mp3', '', '2', '', '', '', '', '', '', '', '', '159', '接力的最后一部分是从Point Safety到Nome。', '', '', 'Gunnar从Bluff到Point Safety是接力的倒数第二部分，最后一个部分是从哪站到哪站呢？', 'Review Guided Reading Course, slide G-1 or check the map on the book, page 20.', '', '2', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('90', '18', 'Looking at the picture below, why didn’t brave Balto help dig the other dogs out?', 'L2-Balto/1-18-page_31.png', 'L2-Balto/1-18-Why_didn\'t_brave_Balto_help_dig_the_other_dogs_out.mp3', '', '2', '', '', '', '', '', '', '', '', '163', '从图中可以看出，Balto也陷到雪里，被困住了。', '', '', '图中勇敢的Balto为什么不帮忙把其它狗挖出来？', '仔细观察图中Balto，他的境遇怎么样？他是否能够帮助其它狗狗？', '', '2', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('91', '22', 'From the picture below, even though Balto had run this trail many times before, why wasn’t this easy for him?', 'L2-Balto/1-18-page_39.png', 'L2-Balto/1-22-Why_wasn\'t_this_easy_for_him.mp3', '', '2', '', '', '', '', '', '', '', '', '167', '图中的雪非常大，我们都看不清Balto和Gunnar，这么大的雪，对于他们来说行进非常困难。', '', '', '为什么即使Balto已经多次跑这条路线，对于它来说也不是很容易呢？', 'The blizzard was coming! There was too much snow.', '', '2', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('92', '26', 'What is NOT a reason why Gunnar and Balto were so tired when they arrived at Point Safety?', '', 'L2-Balto/1-26-What_is_NOT_a_reason.mp3', '', '2', '', '', '', '', '', '', '', '', '171', 'Gunnar和Balto并没有在Point Safety停下来休息暖暖手，这也是他们为什么这么累的原因之一。', '', '', '哪个不是Gunnar和Balto到Point Safety时很累的原因？', 'Check the book, page 40', '', '2', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('93', '27', 'Why did the first driver wrap the medicine in fur?', '', 'L2-Balto/1-27-Why_did_the_first_driver_wrap_the_medicine_in_fur.mp3', '', '2', '', '', '', '', '', '', '', '', '175', 'He wrapped it in fur to keep it from freezing.', '', '', '为什么第一个赶雪橇的人把药裹在毛皮里？', 'Check the book, page 22', '', '2', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('94', '28', 'Could you retell the story of Balto? ', '', '', '', '14', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '4', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('95', '31', '', '', '', '', '3', 'L1-Firehouse/Firehouse_1-1.mp4', 'L1-Firehouse/Pre-course_Listening_and_Reading_Cover.png', '', '', '', '', '', '', '', '', '', '', '', '', '', '1', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('96', '35', '', '', '', '', '3', 'L1-Firehouse/Firehouse_2-1.mp4', 'L1-Firehouse/Pre-course_Listening_and_Reading_Cover.png', '', '', '', '', '', '', '', '', '', '', '', '', '', '1', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('97', '39', '', '', '', '', '3', 'L1-Firehouse/Firehouse_3-1.mp4', 'L1-Firehouse/Pre-course_Listening_and_Reading_Cover.png', '', '', '', '', '', '', '', '', '', '', '', '', '', '1', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('98', '43', '', '', '', '', '3', 'L1-Firehouse/Firehouse_4-1.mp4', 'L1-Firehouse/Pre-course_Listening_and_Reading_Cover.png', '', '', '', '', '', '', '', '', '', '', '', '', '', '1', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('99', '33', '', '', '', '', '3', 'L1-Firehouse/Firehouse_1-3.mp4', 'L1-Firehouse/Guided_Reading_Course_Cover.png', '', '', '', '', '', '', '', '', '', '', '', '', '', '0', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('100', '37', '', '', '', '', '3', 'L1-Firehouse/Firehouse_2-3.mp4', 'L1-Firehouse/Guided_Reading_Course_Cover.png', '', '', '', '', '', '', '', '', '', '', '', '', '', '0', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('101', '41', '', '', '', '', '3', 'L1-Firehouse/Firehouse_3-3.mp4', 'L1-Firehouse/Guided_Reading_Course_Cover.png', '', '', '', '', '', '', '', '', '', '', '', '', '', '0', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('102', '45', '', '', '', '', '3', 'L1-Firehouse/Firehouse_4-3.mp4', 'L1-Firehouse/Guided_Reading_Course_Cover.png', '', '', '', '', '', '', '', '', '', '', '', '', '', '0', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('103', '32', 'firehouse', 'L1-Firehouse/2-4-firehouse.png', 'L1-Firehouse/2-4-firehouse.mp3', '', '4', '', '', '', '/\'faɪrˌhaʊs/', 'n. 消防站', '', 'Today my class is going to the firehouse!\n今天我们班要去消防局。', 'L1-Firehouse/2-4-Today_my_class_is_going_to_the_firehouse.mp3', '', '', '', '', '', '', '', '1', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('104', '32', 'dress', 'L1-Firehouse/2-4-dress.png', 'L1-Firehouse/2-4-dress.mp3', '', '4', '', '', '', '/drɛs/', 'vi. 打扮；穿着', '', 'We dressed like firemen.\n我们穿得像消防员。', 'L1-Firehouse/2-4-We_dressed_like_firemen.mp3', '', '', '', '', '', '', '', '1', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('105', '32', 'fireman', 'L1-Firehouse/2-4-fireman.png', 'L1-Firehouse/2-4-fireman.mp3', '', '4', '', '', '', '/\'faɪrmən/', 'n. 消防队员；救火队员', '', 'My father is a fireman.\n我的爸爸是消防员。', 'L1-Firehouse/2-4-My_father_is_a_fireman.mp3', '', '', '', '', '', '', '', '1', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('106', '32', 'fight', 'L1-Firehouse/2-4-fight.png', 'L1-Firehouse/2-4-fight.mp3', '', '4', '', '', '', '/faɪt/', 'vi. 与…斗争', 'to work hard to defeat, end or prevent something', 'Two firemen are fighting a fire.\n两个消防员正在灭火。', 'L1-Firehouse/2-4-Two_firemen_are_fighting_a_fire.mp3', '', '', '', '', '', '', '', '1', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('107', '32', 'boots', 'L1-Firehouse/2-4-boots.png', 'L1-Firehouse/2-4-boots.mp3', '', '4', '', '', '', '/bʊts/', 'n. 靴子（boot的复数）', '', 'There are two red boots.\n这里有两只红靴子。', 'L1-Firehouse/2-4-There_are_two_red_boots.mp3', '', '', '', '', '', '', '', '1', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('108', '32', 'jacket', 'L1-Firehouse/2-4-jacket.png', 'L1-Firehouse/2-4-jacket.mp3', '', '4', '', '', '', '/\'dʒækɪt/', 'n. 短上衣，夹克', 'A jacket is a short coat with long sleeves', 'I have a green jacket.\n我有一件绿色的夹克。', 'L1-Firehouse/2-4-I_have_a_green_jacket.mp3', '', '', '', '', '', '', '', '1', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('109', '32', 'helmet', 'L1-Firehouse/2-4-helmet.png', 'L1-Firehouse/2-4-helmet.mp3', '', '4', '', '', '', '/\'hɛlmɪt/', 'n. 钢盔，头盔', 'A helmet is a hat made of a strong material which you wear to protect your head.', 'Fireman Joe has a helmet.\n消防员Joe有一顶头盔。', 'L1-Firehouse/2-4-Fireman_Joe_has_a_helmet.mp3', '', '', '', '', '', '', '', '1', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('110', '32', 'Match the words with the pictures.', '', 'L1-Firehouse/Match_the_words_with_the_pictures.mp3', '', '9', '', '', '', '', '', '', '', '', '', 'firehouse n. 消防局\nfireman n. 消防员\nhelmet n. 头盔', '', '', '拖动配对', 'firehouse n. 消防局;\nfireman n. 消防员;\nhelmet n. 头盔', '', '4', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('111', '32', 'Making Sentences', 'L1-Firehouse/2-4-I_dress_like_a_fireman.png', 'L1-Firehouse/Making_Sentences.mp3', '', '7', '', '', '', '', '', '', '', '', '182|183|184', 'I dress like a fireman.\n我穿得像消防员。', 'L1-Firehouse/2-4-I_dress_like_a_fireman.mp3', '', '我穿得像消防员一样。', 'Check the book, page 6\n看看书的第6页哦～', '', '2', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('112', '32', 'Clicking Pairs', '', 'L1-Firehouse/Clicking_Pairs.mp3', '', '8', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '2_3', '6', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('113', '36', 'slide down', 'L1-Firehouse/2-8-slide_down.png', 'L1-Firehouse/2-8-slide_down.mp3', '', '4', '', '', '', '/slaɪd daʊn/', 'exp. 滑下，往下滑', 'to move smoothly along a surface', 'The little girl is sliding down a slide.\n小女孩正从滑梯滑下来。', 'L1-Firehouse/2-8-The_little_girl_is_sliding_down_a_slide.mp3', '', '', '', '', '', '', '', '1', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('114', '36', 'pole', 'L1-Firehouse/2-8-pole.png', 'L1-Firehouse/2-8-pole.mp3', '', '4', '', '', '', '/pol/', 'n. 杆', 'a long thin piece of wood or metal, used especially for supporting things', 'The fireman is sliding down the fire pole.\n消防员正从消防杆滑下来。', 'L1-Firehouse/2-8-The_fireman_is_sliding_down_the_fire_pole.mp3', '', '', '', '', '', '', '', '1', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('115', '36', 'howl', 'L1-Firehouse/2-8-howl.png', 'L1-Firehouse/2-8-howl.mp3', '', '4', '', '', '', '/haʊl/', 'vi. 嘷叫，长嚎', 'If an animal such as a wolf or a dog howls, it makes a long, loud, crying sound.', 'Why do dogs howl?\n为什么狗会狂吠？', 'L1-Firehouse/2-8-Why_do_dogs_howl.mp3', '', '', '', '', '', '', '', '1', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('116', '36', 'fire truck', 'L1-Firehouse/2-8-fire_truck.png', 'L1-Firehouse/2-8-fire_truck.mp3', '', '4', '', '', '', '/\'faɪr trʌk/', 'n. 救火车；消防车', 'A fire truck is a large vehicle which carries firefighters and equipment for putting out fires.', 'The fire truck is big.\n消防车很大。', 'L1-Firehouse/2-8-The_fire_truck_is_big.mp3', '', '', '', '', '', '', '', '1', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('117', '36', 'hose', 'L1-Firehouse/2-8-hose.png', 'L1-Firehouse/2-8-hose.mp3', '', '4', '', '', '', '/hoz/', 'n. 软管', 'A hose is a long, flexible pipe made of rubber or plastic. ', 'The fireman is holding a hose.\n消防员正拿着管子。', 'L1-Firehouse/2-8-The_fireman_is_holding_a_hose.mp3', '', '', '', '', '', '', '', '1', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('118', '36', 'ladder', 'L1-Firehouse/2-8-ladder.png', 'L1-Firehouse/2-8-ladder.mp3', '', '4', '', '', '', '/\'lædɚ/', 'n. 梯子', 'A ladder is a piece of equipment used for climbing up something or down from something', 'The fireman climbs a ladder.\n消防员正在爬楼梯。', 'L1-Firehouse/2-8-The_fireman_climbs_a_ladder.mp3', '', '', '', '', '', '', '', '1', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('119', '36', 'check', 'L1-Firehouse/2-8-check.png', 'L1-Firehouse/2-8-check.mp3', '', '4', '', '', '', '/tʃɛk/', 'vt. 检查', 'to make sure there is nothing wrong', 'The little boy checks the mailbox.\n小男孩查看邮箱。', 'L1-Firehouse/2-8-The_little_boy_checks_the_mailbox.mp3', '', '', '', '', '', '', '', '1', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('120', '36', 'Match the words with the pictures.', '', 'L1-Firehouse/Match_the_words_with_the_pictures.mp3', '', '9', '', '', '', '', '', '', '', '', '', 'howl v. 嘷叫\nfire truck n. 消防车\npole n. 杆子', '', '', '拖动配对', 'howl v. 嘷叫\nfire truck n. 消防车\npole n. 杆子', '', '4', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('121', '36', 'Making Sentences', 'L1-Firehouse/2-9-Joe_does.png', 'L1-Firehouse/Making_Sentences.mp3', '', '7', '', '', '', '', '', '', '', '', '191|192|193', 'Joe slides down the pole. \n消防员Joe从杆子上滑了下来。', 'L1-Firehouse/2-8-Joe_slides_down_the_pole.mp3', '', 'Joe从消防杆滑下来。', 'Check the book, page 13. \n可以翻翻书的第13页哦～', '', '2', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('122', '36', 'Clicking Pairs', '', 'L1-Firehouse/Clicking_Pairs.mp3', '', '8', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '2_3', '6', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('123', '40', 'siren', 'L1-Firehouse/2-12-siren.png', 'L1-Firehouse/2-12-siren.mp3', '', '4', '', '', '', '/\'saɪrən/', 'n. 汽笛；警报器', 'A siren is a warning device which makes a long, loud noise.', 'The siren is loud.\n警报器很大声。', 'L1-Firehouse/2-12-The_siren_is_loud.mp3', '', '', '', '', '', '', '', '1', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('124', '40', 'loud', 'L1-Firehouse/2-12-loud.png', 'L1-Firehouse/2-12-loud.mp3', '', '4', '', '', '', '/laʊd/', 'adj. 大声的；喧吵的', 'making or causing a lot of noise', 'The boy is loud.\n男孩很大声。', 'L1-Firehouse/2-12-The_boy_is_loud.mp3', '', '', '', '', '', '', '', '1', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('125', '40', 'cover', 'L1-Firehouse/2-12-cover.png', 'L1-Firehouse/2-12-cover.mp3', '', '4', '', '', '', '/\'kʌvɚ/', 'vt. 遮盖；盖住', 'to put something over something to protect, hide, or close it', 'The girl covers her eyes.\n女孩捂住她的眼睛。', 'L1-Firehouse/2-12-The_girl_covers_her_eyes.mp3', '', '', '', '', '', '', '', '1', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('126', '40', 'smoke', 'L1-Firehouse/2-12-smoke.png', 'L1-Firehouse/2-12-smoke.mp3', '', '4', '', '', '', '/smok/', 'n. 烟', 'the cloud of black or white gases and dust that is produced by burning something', 'It is full of black smoke.\n这里充满了黑烟。', 'L1-Firehouse/2-12-It_is_full_of_black_smoke.mp3', '', '', '', '', '', '', '', '1', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('127', '40', 'floor', 'L1-Firehouse/2-12-floor.png', 'L1-Firehouse/2-12-floor.mp3', '', '4', '', '', '', '/flɔr/', 'n. 地板', 'The floor of a room is the part of it that you walk on.', 'Why does he sleep on the floor?\n为什么他睡在地板上？', 'L1-Firehouse/2-12-Why_does_he_sleep_on_the_floor.mp3', '', '', '', '', '', '', '', '1', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('128', '40', 'on fire', 'L1-Firehouse/2-12-on_fire.png', 'L1-Firehouse/2-12-on_fire.mp3', '', '4', '', '', '', '/ɑn \'faɪr/', 'exp. 着火；起火', 'in the process of burning ', 'The house is on fire.\n房子着火了。', 'L1-Firehouse/2-12-The_house_is_on_fire.mp3', '', '', '', '', '', '', '', '1', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('129', '40', 'stop', 'L1-Firehouse/2-12-stop.png', 'L1-Firehouse/2-12-stop.mp3', '', '4', '', '', '', '/stɑp/', 'vt/vi. 停下', 'no longer move', 'You should stop first.\n你首先应该停下来。', 'L1-Firehouse/2-12-You_should_stop_first.mp3', '', '', '', '', '', '', '', '1', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('130', '40', 'drop', 'L1-Firehouse/2-12-drop.png', 'L1-Firehouse/2-12-drop.mp3', '', '4', '', '', '', '/drɑp/', 'v. 低下身子', 'move your body down', 'I stop, drop, and roll!\n我停下来，低下身子，然后翻滚！', 'L1-Firehouse/2-12-I_stop_drop_and_roll.mp3', '', '', '', '', '', '', '', '1', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('131', '40', 'roll', 'L1-Firehouse/2-12-roll.png', 'L1-Firehouse/2-12-roll.mp3', '', '4', '', '', '', '/rol/', 'v. 打滚；（使）翻身', 'to turn your body over one or more times while lying down', 'You should roll right away.\n你应该马上翻滚。', 'L1-Firehouse/2-12-You_should_roll_right_away.mp3', '', '', '', '', '', '', '', '1', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('132', '40', 'Match the words with the pictures.', '', 'L1-Firehouse/Match_the_words_with_the_pictures.mp3', '', '9', '', '', '', '', '', '', '', '', '', 'siren n. 汽笛，警报器\ncover v. 捂住，盖\nsmoke n. 浓烟', '', '', '拖动配对', 'siren n. 汽笛，警报器\ncover v. 捂住，盖\nsmoke n. 浓烟', '', '4', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('133', '40', 'Fill in the Blank', 'L1-Firehouse/2-12-Joe_checks_the_ladder.png', 'L1-Firehouse/2-12-Joe_checks_the_ladder.mp3', '', '6', '', '', '', '', '', '', '', '', '201', 'check v. 检查\n此处考虑第三人称单数，-s', '', '', 'Joe检查梯子。', 'checks v. 检查；\n可以翻翻书的第19页哦～', '', '2', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('134', '40', 'Clicking Pairs', '', 'L1-Firehouse/Clicking_Pairs.mp3', '', '8', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '2_3', '6', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('135', '44', 'smile', 'L1-Firehouse/2-16-smile.png', 'L1-Firehouse/2-16-smile.mp3', '', '4', '', '', '', '/smaɪl/', 'v. 微笑', '', 'The girl smiles.\n这个女孩笑了。', 'L1-Firehouse/2-16-The_girl_smiles.mp3', '', '', '', '', '', '', '', '1', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('136', '44', 'surprise', 'L1-Firehouse/2-16-surprise.png', 'L1-Firehouse/2-16-surprise.mp3', '', '4', '', '', '', '/sɚ\'praɪz/', 'n. 惊喜', '', 'Surprise! Happy Birthday!\n惊喜！生日快乐！', 'L1-Firehouse/2-16-Surprise_Happy_Birthday.mp3', '', '', '', '', '', '', '', '1', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('137', '44', 'reach into', 'L1-Firehouse/2-16-reach_into.png', 'L1-Firehouse/2-16-reach_into.mp3', '', '4', '', '', '', '/ritʃ ˈɪntu/', 'exp. 伸手去……拿', '', 'Emma reaches into a cookie jar.\nEmma伸手去饼干罐里拿饼干。', 'L1-Firehouse/2-16-Emma_reaches_into_a_cookie_jar.mp3', '', '', '', '', '', '', '', '1', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('138', '44', 'put on', 'L1-Firehouse/2-16-put_on.png', 'L1-Firehouse/2-16-put_on.mp3', '', '4', '', '', '', '/pʊt ɑn/', 'exp. 穿上', '', 'I can put on my pants by myself.\n我会自己穿裤子。', 'L1-Firehouse/2-16-I_can_put_on_my_pants_by_myself.mp3', '', '', '', '', '', '', '', '1', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('139', '44', 'fire alarm', 'L1-Firehouse/2-16-fire_alarm.png', 'L1-Firehouse/2-16-fire_alarm.mp3', '', '4', '', '', '', '/\'faɪr ə\'lɑrm/', 'n. 火警警报器', 'a device that makes a noise, for example, with a bell, to warn people when there is a fire', 'Fire alarm makes ding ding sound!\n火警报警器发出叮叮的声音！', 'L1-Firehouse/2-16-Fire_alarm_makes_ding_ding_sound.mp3', '', '', '', '', '', '', '', '1', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('140', '44', 'wave good-bye', 'L1-Firehouse/2-16-wave_good-bye.png', 'L1-Firehouse/2-16-wave_good-bye.mp3', '', '4', '', '', '', '/wev \'gud\'bai/', 'exp. 挥手再见', 'wave as a way of saying good-bye', 'The boys wave good-bye to their mom.\n男孩们和他们的妈妈挥手告别。', 'L1-Firehouse/2-16-The_boys_wave_good-bye_to_their_mom.mp3', '', '', '', '', '', '', '', '1', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('141', '44', 'ready', 'L1-Firehouse/2-16-ready.png', 'L1-Firehouse/2-16-ready.mp3', '', '4', '', '', '', '/\'rɛdi/', 'adj. 准备好', 'prepared to do something', 'They are ready to go!\n他们准备出发了！', 'L1-Firehouse/2-16-They_are_ready_to_go.mp3', '', '', '', '', '', '', '', '1', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('142', '44', 'Match the words with the pictures.', '', 'L1-Firehouse/Match_the_words_with_the_pictures.mp3', '', '9', '', '', '', '', '', '', '', '', '', 'smile v. 微笑\nsurprise n. 惊喜\nfire alarm n. 火警警报器', '', '', '拖动配对', 'smile v. 微笑；\nsurprise n. 惊喜；\nfire alarm n. 火警警报器', '', '4', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('143', '44', 'Fill in the Blank', 'L1-Firehouse/2-16-He_reaches_into_his_truck.png', 'L1-Firehouse/2-16-He_reaches_into_his_truck.mp3', '', '6', '', '', '', '', '', '', '', '', '210|211', 'reach into exp. 伸手去……拿\n此处考虑第三人称单数，reach要加-es', '', '', 'Joe伸手去他的消防卡车里拿东西。', 'reaches into 伸手去……拿；\n可以翻翻书的第27页哦～', '', '2', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('144', '44', 'Clicking Pairs', '', 'L1-Firehouse/Clicking_Pairs.mp3', '', '8', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '2_3', '6', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('145', '29', 'Who is this?', 'L1-Firehouse/2-1-who_is_this.png', 'L1-Firehouse/2-1-who_is_this.mp3', '', '2', '', '', '', '', '', '', '', '', '216', '这是我们可爱的小主角-Little Critter (小毛人).', '', '', '这是谁？', 'Check the book cover. \n在书的封面上找找线索哦～', '', '2', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('146', '29', 'Who are they?', 'L1-Firehouse/2-1-who_are_they.png', 'L1-Firehouse/2-1-who_are_they.mp3', '', '2', '', '', '', '', '', '', '', '', '220', '这是我们的Fireman Joe (消防员Joe) 和他的消防犬Sparky.', '', '', '他们是谁？', 'Read the book, page 8 and page 9. \n阅读书本第8页和第9页找找答案吧～', '', '2', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('147', '29', 'They are going to the firehouse.', 'L1-Firehouse/2-1-They_are_going_to_the_firehouse.png', 'L1-Firehouse/2-1-They_are_going_to_the_firehouse.mp3', '', '1', '', '', '', '', '', '', '', '', '224', 'Today my class is going to the firehouse! 今天我们班级去消防局！\n选TRUE，他们是去消防局。', 'L1-Firehouse/2-1-Today_my_class_is_going_to_the_firehouse.mp3', '', '他们去消防局。', 'Read the book, page 6 and page 7. \n阅读书本第6页和第7页找找答案吧～', '', '2', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('148', '29', 'Which is Little Critter?', '', 'L1-Firehouse/2-1-Which_is_Little_Critter.mp3', '', '2', '', '', '', '', '', '', '', '', '226', 'Little Critter穿得像个消防员。', '', '', '哪个是小毛人Little Critter呢？', 'Little Critter dresses like a fireman.\n小毛人穿得像消防员哦～', '', '2', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('149', '34', 'Which is a firehouse?', '', 'L1-Firehouse/2-6-Which_is_a_firehouse.mp3', '', '2', '', '', '', '', '', '', '', '', '230', 'Firehouse n. 消防局 图上的消防局门上写着FIRE HOUSE', '', '', '哪个是消防局呢？', 'Firehouse n. 消防局', '', '2', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('150', '34', 'Little Critter’s class is going to the police station.', '', 'L1-Firehouse/2-6-Little_Critter\'s_class_is_going_to_the_police_station.mp3', '', '1', '', '', '', '', '', '', '', '', '235', 'Today my class is going to the firehouse! 今天我们班级去消防局！\n选FLASE，他们是去消防局，不是警察局。', 'L1-Firehouse/2-1-Today_my_class_is_going_to_the_firehouse.mp3', '', '小毛人Little Critter的班级要去警察局。', 'Read the book, page 6 and page 7. \n阅读书本第6页和第7页找找答案吧～', '', '2', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('151', '38', 'Which picture shows Fireman Joe sliding down the pole?', '', 'L1-Firehouse/2-10-Which_picture_shows_Fireman_Joe_sliding_down_the_pole.mp3', '', '2', '', '', '', '', '', '', '', '', '236', 'Fireman Joe滑下的是消防杆。你找对了么？', '', '', '哪张图是消防员Joe正滑下消防杆呢？', 'Read the book, page 12 and page 13. \n阅读书本第12页和第13页找找答案吧～', '', '2', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('152', '38', 'Which picture shows Fireman Joe driving the fire truck?', '', 'L1-Firehouse/2-10-Which_picture_shows_Fireman_Joe_driving_the_fire_truck.mp3', '', '2', '', '', '', '', '', '', '', '', '243', 'Fireman Joe在开消防车。你找对了么？', '', '', '哪张图是消防员Joe正在开消防车呢？', 'Read the book, page 14 and page 15. \n阅读书本第14页和第15页找找答案吧～', '', '2', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('153', '42', 'How many green animals are in this picture?', 'L1-Firehouse/2-14-green_animals.png', 'L1-Firehouse/2-14-How_many_green_animals_are_in_this_picture.mp3', '', '2', '', '', '', '', '', '', '', '', '245', '图中有两只绿颜色的动物，小青蛙和小鳄鱼。小老虎不是绿色的，只是穿了绿色的衣服哦～', '', '', '图中有几只绿色的动物呢？', '小老虎不是绿色的动物，只是穿了绿色的衣服。', '', '2', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('154', '42', 'What does Fireman Joe tell us?', 'L1-Firehouse/2-14-Joe_tells_us.png', 'L1-Firehouse/2-14-What_does_Fireman_Joe_tell_us.mp3', '', '2', '', '', '', '', '', '', '', '', '249', 'Fireman Joe告诉我们烟往上，我们应该往下趴在地板上。', '', '', 'Fireman Joe告诉我们什么呢？', 'Read the book, page 22 and page 23. \n阅读书本第22页和第23页找找答案吧～', '', '2', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('155', '42', 'What is Little Critter doing in this picture?', 'L1-Firehouse/2-14-dropping.png', 'L1-Firehouse/2-14-What_is_Little_Critter_doing_in_this_picture.mp3', '', '2', '', '', '', '', '', '', '', '', '254', '图片上小毛人Little Critter正演练身上着火后的第二个步骤，dropping，低下身子', '', '', '图片上小毛人Little Critter在干什么呢？', 'Read the book, page 25. \n阅读书本第25页找找答案吧～', '', '2', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('156', '46', 'How do you spell this word?', 'L1-Firehouse/2-16-spell_helmet.png', 'L1-Firehouse/2-18-helmet.mp3', '', '5', '', '', '', '', '', '', '', '', '257|258|259|260|261', 'helmet n. 安全帽，头盔。图上的是安全帽。', 'L1-Firehouse/2-4-helmet.mp3', '', '怎么拼写图上物品的名称？', 'Read the book, page 27. \n阅读书本第27页找找答案吧～', '', '2', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('157', '46', 'What does Joe say Little Critter will be one day?', 'L1-Firehouse/2-16-will_be.png', 'L1-Firehouse/2-18-What_does_Joe_say_Little_Critter_will_be_one_day.mp3', '', '2', '', '', '', '', '', '', '', '', '265', '消防员Joe和小毛人Little Critter说将来有一天他会成为一个好消防员。', '', '', 'Joe和小毛人说他将来有一天会成为什么呢？', 'Read the book, page 29. \n阅读书本第29页找找答案吧～', '', '2', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('158', '33', 'Who is the author of the book?', 'L1-Firehouse/2-5-Going_to_the_Firehouse_Cover.png', 'L1-Firehouse/2-5-Who_is_the_author_of_the_book.mp3', '', '2', '', '', '', '', '', '', '', '', '267', 'We use \"By\" before the name of the writer. \r\n通常英文里，在书的作者前，会用 \"by\" 这个词。书的封面上写到 \"BY MERCER MAYER\", 即作者是Mercer Mayer.', '', '', '这本书的作者是谁？', 'Which is the name of a person?\nAuthor n. 作者，这里想想哪个选项代表的是人名呢？', '', '2', '1', 'RL.K.6', '0');
INSERT INTO `hi_conf_topic` VALUES ('159', '34', 'Who wrote the story?', 'L1-Firehouse/2-5-Going_to_the_Firehouse_Cover.png', 'L1-Firehouse/2-5-Who_wrote_the_story.mp3', '', '2', '', '', '', '', '', '', '', '', '270', 'The \"Author\" writes the story. \n作者就是写书的人。', '', '', '谁写的这个故事？', 'The author is a good writer.\r\n我们把写书的人叫做什么呢？', '', '2', '0', 'RL.K.6', '0');
INSERT INTO `hi_conf_topic` VALUES ('160', '33', 'Where will Little Critter\'s Class go today?', '', 'L1-Firehouse/2-5-Where_will_Little_Critter\'s_Class_go_today.mp3', '', '2', '', '', '', '', '', '', '', '', '277', 'You can learn the main idea of the book from the title. \n这本书名已经告诉我们了，小毛人的班级要去参观消防局。', '', '', '今天小毛人Little Critter的班级要去哪里呢？', 'What is the title of the book?\r\n看看书的标题能给你提示哦～', '', '2', '1', 'RL.K.1', '0');
INSERT INTO `hi_conf_topic` VALUES ('161', '33', 'Which is a firehouse?', '', 'L1-Firehouse/2-5-Which_is_a_firehouse.mp3', '', '2', '', '', '', '', '', '', '', '', '280', 'The firehouse is where the firemen live. \n图片上红红的房子就是消防局啦。', '', '', '哪个是消防局呢？', 'Which one looks like a red house?\n哪个看起来像是红房子呢？', '', '2', '1', 'RL.K.1', '0');
INSERT INTO `hi_conf_topic` VALUES ('162', '34', 'What are the firemen doing?', 'L1-Firehouse/2-6-what_are_the_fireman_doing.png', 'L1-Firehouse/2-5-What_are_the_firemen_doing.mp3', '', '2', '', '', '', '', '', '', '', '', '284', 'The firemen are fighting a fire.\r\n消防员在灭火。他们手里拿着水管在努力扑灭火灾。', '', '', '消防员们正在做什么？', 'The firemen are holding a hose. What are they using the water for?\r\n图中消防员拿着水管在做什么呢？', '', '2', '0', 'RL.K.4', '0');
INSERT INTO `hi_conf_topic` VALUES ('163', '33', 'What are the firemen using to fight the fire?', 'L1-Firehouse/2-5-using_to_fight_the_fire.png', 'L1-Firehouse/2-5-What_are_the_firemen_using_to_fight_the_fire.mp3', '', '2', '', '', '', '', '', '', '', '', '286', 'You can use a hose to help move a lot of water. \n可以用水来灭火。', '', '', '消防员们用什么去灭火呢？', 'What is blue and comes out of a firehose?\n看看图片，管子里喷出的是什么？', '', '2', '1', 'RL.K.4', '0');
INSERT INTO `hi_conf_topic` VALUES ('164', '33', 'Can you find Little Critter?', '', 'L1-Firehouse/2-5-Can_you_find_Little_Critter.mp3', '', '2', '', '', '', '', '', '', '', '', '293', 'Little Critter is the main character. \n发现我们的小主人公小毛人了吗？', '', '', '你可以找到小毛人Little Critter吗？', 'Which one is the main character?\n想想哪个是主角呢？', '', '2', '1', 'RL.K.6', '0');
INSERT INTO `hi_conf_topic` VALUES ('165', '33', 'Where is the class going?', 'L1-Firehouse/2-5-P6_7.png', 'L1-Firehouse/2-5-Where_is_the_class_going.mp3', '', '2', '', '', '', '', '', '', '', '', '295', 'The class is going to the red firehouse. \n小毛人的班级要去消防局。', '', '', '这个班级的人准备去哪呢？', 'What word do you see on the building?\n你在房子上看到什么单词了？', '', '2', '1', 'RL.K.3', '0');
INSERT INTO `hi_conf_topic` VALUES ('167', '33', 'Who is this in the picture?', 'L1-Firehouse/2-5-Fireman_Joe.png', 'L1-Firehouse/2-5-Who_is_this_in_the_picture.mp3', '', '2', '', '', '', '', '', '', '', '', '304', 'That\'s fireman Joe next to Sparky. \n在Sparky旁边的是消防员Joe.', '', '', '图片中的这个人是谁？', 'What is the name of the Fireman?\n这个消防员叫什么名字呢？翻翻书的第8页～', '', '2', '1', 'RL.K.3', '0');
INSERT INTO `hi_conf_topic` VALUES ('168', '34', 'Where is Fireman Joe?', 'L1-Firehouse/2-5-where_are_they.png', 'L1-Firehouse/2-5-Where_is_fireman_Joe.mp3', '', '2', '', '', '', '', '', '', '', '', '309', 'Fireman Joe and Sparky are both in the firehouse.\r\n消防员Joe和消防犬Sparky都在消防局。', '', '', 'Fireman Joe在哪里？', 'Where is Little Critter\'s Class today?\n还记得小毛人的班级今天要去哪里吗？', '', '2', '0', 'RL.K.3', '0');
INSERT INTO `hi_conf_topic` VALUES ('169', '33', 'Who is in the picture?', 'L1-Firehouse/2-5-Who_are_they.png', 'L1-Firehouse/2-5-Who_is_in_the_picture.mp3', '', '2', '', '', '', '', '', '', '', '', '313', 'There are three characters in this picture. They are Little Critter, Sparky, and Fireman Joe. \n这张图片里的可不止一个人物哦。所以选全部都是 “All of these”', '', '', '图片中有谁？', 'How many characters do you see?<br>你看到多少个角色呢？<br>图中的人物不止一个哦～', '', '2', '1', 'RL.K.3', '0');
INSERT INTO `hi_conf_topic` VALUES ('171', '33', 'What do you know about firemen?', '', 'L1-Firehouse/2-5-What_do_you_know_about_firemen.mp3', '', '2', '', '', '', '', '', '', '', '', '319', 'Firemen fight fires with hoses and water.\n消防员用水管和水来灭火。', '', '', '你知道哪些关于消防员的知识呢？', 'What can fireman do with fires?\n消防员最主要的工作是什么？', '', '2', '1', 'RL.K.2', '0');
INSERT INTO `hi_conf_topic` VALUES ('172', '33', 'What is that?', 'L1-Firehouse/2-5-It\'s_a_fire_dog.png', 'L1-Firehouse/2-5-What_is_that.mp3', '', '2', '', '', '', '', '', '', '', '', '324', 'He is more than a dog, he is a fire dog. \n这不是普通的狗狗，它是一只消防狗。', '', '', '那是什么？', 'Is he a dog or a cat?  Is he a regular dog or a fire dog? \n这是只猫？还是普通的狗狗？或者是消防狗？想想哦～\nregular adj. 通常的，普通的； ', '', '2', '1', 'RL.K.3', '0');
INSERT INTO `hi_conf_topic` VALUES ('174', '34', 'What 3 things does Fireman Joe have?', 'L1-Firehouse/2-5-three_things_Fireman_Joe_has.png', 'L1-Firehouse/2-5-What_3_things_does_Fireman_Joe_have.mp3', '', '2', '', '', '', '', '', '', '', '', '331', 'Fireman Joe has a jacket, boots, and helmet.\n消防员Joe穿了消防外套、靴子和头盔。', '', '', '消防员Joe穿了哪三件东西？', 'He has more than 1 thing here.\n记住问题中提到了消防员Joe穿戴了3件东西。', '', '2', '0', 'RL.K.2', '0');
INSERT INTO `hi_conf_topic` VALUES ('175', '33', 'Can you point to Fireman Joe\'s boots?', '', 'L1-Firehouse/2-5-Can_you_point_to_Fireman_Joe\'s_boots.mp3', '', '2', '', '', '', '', '', '', '', '', '334', 'boots n. 靴子', '', '', '你可以指出消防员Joe的靴子么？', 'Boots are close to the floor. \n靴子是穿在脚上的哦～', '', '2', '1', 'RL.K.4', '0');
INSERT INTO `hi_conf_topic` VALUES ('176', '33', 'Can you point to Fireman Joe\'s jacket?', '', 'L1-Firehouse/2-5-Can_you_point_to_Fireman_Joe\'s_jacket.mp3', '', '2', '', '', '', '', '', '', '', '', '340', 'Fireman Joe has a fireman jacket. The fireman jacket is big and yellow. \nJacket n. 外套；消防员Joe的外套是大大的黄颜色的。', '', '', '你可以指出消防员Joe的夹克么？', 'Fireman Joe\'s jacket is big and yellow.\n消防员Joe的外套是大大的黄颜色的。', '', '2', '1', 'RL.K.4', '0');
INSERT INTO `hi_conf_topic` VALUES ('177', '33', 'Can you point to Fireman Joe\'s helmet?', '', 'L1-Firehouse/2-5-Can_you_point_to_Fireman_Joe\'s_helmet.mp3', '', '2', '', '', '', '', '', '', '', '', '345', 'Fireman Joe has a fireman helmet. The helmet is on his head.\nhelmet n. 头盔', '', '', '你可以指出消防员Joe的头盔么？', 'Helmets go on your head.\n头盔是戴在头上的哦～', '', '2', '1', 'RL.K.4', '0');
INSERT INTO `hi_conf_topic` VALUES ('178', '33', 'What are these called?', 'L1-Firehouse/2-5-fireman-boots.png', 'L1-Firehouse/2-5-What_are_these_called.mp3', '', '2', '', '', '', '', '', '', '', '', '347', 'Those are fireman boots. He has fireman boots. \n这些是消防员的靴子。', '', '', '这些是什么呢？', 'They go on your feet.\n消防员穿在脚上的叫？', '', '2', '1', 'RL.K.4', '0');
INSERT INTO `hi_conf_topic` VALUES ('179', '33', 'What is this?', 'L1-Firehouse/2-5-fireman-jacket.png', 'L1-Firehouse/2-5-What_is_this.mp3', '', '2', '', '', '', '', '', '', '', '', '351', 'That is his fireman jacket.\n这是消防员的外套。', '', '', '这是什么呢？', 'It is not boots. It is not a helmet.\n仔细想想，这不是靴子，也不是头盔，那应该是？', '', '2', '1', 'RL.K.4', '0');
INSERT INTO `hi_conf_topic` VALUES ('180', '33', 'Where is Fireman Joe\'s helmet?', '', 'L1-Firehouse/2-5-Where_is_Fireman_Joe\'s_helmet.mp3', '', '2', '', '', '', '', '', '', '', '', '357', 'That is Fireman Joe\'s helmet.\nhelmet n. 头盔', '', '', '消防员Joe的消防安全帽在哪里？', 'It goes on your head.\nHelmet是戴在头上的。', '', '2', '1', 'RL.K.4', '0');
INSERT INTO `hi_conf_topic` VALUES ('181', '33', 'Where is Fireman Joe\'s jacket?', '', 'L1-Firehouse/2-5-Where_is_Fireman_Joe\'s_jacket.mp3', '', '2', '', '', '', '', '', '', '', '', '359', 'That is Fireman Joe\'s jacket.\njacket n. 外套', '', '', '消防员Joe的消防夹克在哪里？', 'It is big and yellow.\n这里Jacket是大大的黄颜色的。', '', '2', '1', 'RL.K.4', '0');
INSERT INTO `hi_conf_topic` VALUES ('182', '33', 'Where are Fireman Joe\'s boots?', '', 'L1-Firehouse/2-5-Where_are_Fireman_Joe\'s_boots.mp3', '', '2', '', '', '', '', '', '', '', '', '362', 'Those are Fireman Joe\'s boots.\nboots n. 靴子', '', '', '消防员Joe的消防靴在哪里？', 'There are two. They go on your feet.\nBoots有两只，是穿在脚上的。', '', '2', '1', 'RL.K.4', '0');
INSERT INTO `hi_conf_topic` VALUES ('184', '34', 'Why are fireman gloves important?', 'L1-Firehouse/2-5-fireman_gloves.png', 'L1-Firehouse/2-5-Why_are_fireman_gloves_important.mp3', '', '2', '', '', '', '', '', '', '', '', '372', 'The fireman gloves protects firemen\'s hands from fire.\r\n消防员的手套是用来保护消防员的手的。', '', '', '为什么消防手套很重要？', 'Where do you wear fireman gloves?\r\n什么样的情况下会带消防手套呢？', '', '2', '0', 'RL.K.4', '0');
INSERT INTO `hi_conf_topic` VALUES ('185', '33', 'Which letters in this sentence are upper case?', 'L1-Firehouse/2-5-uppercase.png', 'L1-Firehouse/2-5-Which_letters_in_this_sentence_are_upper_case.mp3', '', '2', '', '', '', '', '', '', '', '', '374', 'Uppercase letters are big letters like \"T\", \"F\", \"J\", and \"I\". Note that uppercase \"I\" and lowercase \"L\" sometimes look the same: i->I and l->L.\n这里的大写字母有\"T\", \"F\", \"J\", \"I\"', '', '', '这句话中哪些字母是大写的？', 'Which uppercase letters do you see in the sentence? \n仔细看看有哪些字母是大写的哦～', '', '2', '1', 'L.K.1a', '0');
INSERT INTO `hi_conf_topic` VALUES ('186', '33', 'Which is correct?', ' ', 'L1-Firehouse/2-5-Which_is_correct.mp3', '', '2', '', '', '', '', '', '', '', '', '381', '\"H\" is uppercase, \"h\" is lowercase.\r\nH是大写，h是小写。\r\n英文中，一句话的开头首字母需要大写。', '', '', '以下哪个是正确的？', 'Which sentence begins with an uppercase letter?\n看看哪个句子是以大写字母开头的', '', '2', '1', 'L.K.1a', '0');
INSERT INTO `hi_conf_topic` VALUES ('187', '33', 'Which is correct?', '', 'L1-Firehouse/2-5-Which_is_correct.mp3', '', '2', '', '', '', '', '', '', '', '', '384', 'Joe is a name. Fireman is a title. Fireman Joe is a title and a name. \nJoe是消防员的名字，Fireman是称呼，前面老师提到过名字和称呼的首字母在英文中需要大写。', '', '', '以下哪个是正确的？', 'Which is a name starting with an uppercase letter? \n名字的首字母都是需要大写的，看看这里哪个名字是以大写字母开头的呢？', '', '2', '1', 'L.K.1a', '0');
INSERT INTO `hi_conf_topic` VALUES ('188', '33', 'Which sentence is not correct?', '', 'L1-Firehouse/2-5-Which_sentence_is_not_correct.mp3', '', '2', '', '', '', '', '', '', '', '', '386', 'The letter \"I\" is always upper case when it is alone. \n记住英文中，我，“I”总是大写的。 ', '', '', '以下哪个句子是不正确的？', 'Which one does not have \"I\"? \n看看哪句话没有大写的 “I”?', '', '2', '1', 'L.K.1a', '0');
INSERT INTO `hi_conf_topic` VALUES ('189', '34', 'Match the uppercase and lowercase letters that are the same!', '', 'L1-Firehouse/2-5-Match_the_uppercase_and_lowercase_letters_that_are_the_same.mp3', '', '8', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '2_4', '6', '0', 'L.K.1a', '0');
INSERT INTO `hi_conf_topic` VALUES ('190', '38', 'What does Fireman Joe do?', 'L1-Firehouse/2-9-Joe_does.png', 'L1-Firehouse/2-9-What_does_Fireman_Joe_do.mp3', '', '2', '', '', '', '', '', '', '', '', '397', 'He slides down the pole.\n消防员Joe正从杆子上滑下来。', '', '', '消防员Joe在做什么？', 'Read the book, page 12 and page 13. \n阅读书本第12页和第13页找找答案吧～', '', '2', '0', 'RL.K.1', '0');
INSERT INTO `hi_conf_topic` VALUES ('191', '37', 'What are the children doing?', 'L1-Firehouse/2-9-children_do.png', 'L1-Firehouse/2-9-What_are_the_children_doing.mp3', '', '2', '', '', '', '', '', '', '', '', '398', 'The children are sliding down the pole.\n他们正从杆子上滑下来。', '', '', '孩子们在做什么？', '孩子们和Fireman Joe做的是一样的事哦～', '', '2', '1', 'RL.K.4', '0');
INSERT INTO `hi_conf_topic` VALUES ('192', '37', 'Can you find the pole?', 'L1-Firehouse/2-9-pole.png', 'L1-Firehouse/2-9-Can_you_find_the_pole.mp3', '', '2', '', '', '', '', '', '', '', '', '403', 'pole n. 杆子，中间圆圆直直的是杆子。', '', '', '你能找到杆子在哪里么？', '消防员Joe是从杆子上滑下来的，仔细找找哪个是杆子吧～', '', '2', '1', 'RL.K.4', '0');
INSERT INTO `hi_conf_topic` VALUES ('193', '37', 'Why do firefighters slide down poles?', '', 'L1-Firehouse/2-9-Why_do_firefighters_slide_down_poles.mp3', '', '2', '', '', '', '', '', '', '', '', '406', 'To get to the fire faster.\n因为从杆子上滑下来更快，这样能更迅速赶到火灾现场。', '', '', '为什么消防员从杆子上滑下来？', '想想看，从杆子上滑下来和从楼梯走哪个更快呢？', '', '2', '1', 'RL.K.2', '0');
INSERT INTO `hi_conf_topic` VALUES ('194', '37', 'Where is Fireman Joe?', 'L1-Firehouse/2-9-fire_truck_book.png', 'L1-Firehouse/2-9-Where_is_Fireman_Joe.mp3', '', '2', '', '', '', '', '', '', '', '', '412', 'He is in the fire truck.\n消防员Joe在消防车里。', '', '', 'Fireman Joe在哪里？', '消防员Joe在消防车里。', '', '2', '1', 'RL.K.3', '0');
INSERT INTO `hi_conf_topic` VALUES ('195', '37', 'What color is the fire truck?', 'L1-Firehouse/2-9-fire_truck_book.png', 'L1-Firehouse/2-9-What_color_is_the_fire_truck.mp3', '', '2', '', '', '', '', '', '', '', '', '417', 'Red，消防车是红色的。', '', '', '消防车是什么颜色的？', '消防车是红色的。', '', '2', '1', 'RL.K.1', '0');
INSERT INTO `hi_conf_topic` VALUES ('196', '37', 'Where is the ladder?', '', 'L1-Firehouse/2-9-Where_is_the_ladder.mp3', '', '2', '', '', '', '', '', '', '', '', '418', 'ladder n.  梯子 梯子正放在消防车顶上。', '', '', '梯子在哪里？', '梯子是用来爬到高处的，仔细在图中找找吧～', '', '2', '1', 'RL.K.1', '0');
INSERT INTO `hi_conf_topic` VALUES ('197', '38', 'Where is the fire dog?', '', 'L1-Firehouse/2-9-Where_is_the_fire_dog.mp3', '', '2', '', '', '', '', '', '', '', '', '425', 'fire dog n. 消防犬 消防犬正坐在消防车里。', '', '', '消防犬在哪里？', '消防犬是白色黑斑点的斑点狗，仔细在图中找找吧～', '', '2', '0', 'RL.K.1', '0');
INSERT INTO `hi_conf_topic` VALUES ('198', '37', 'Where is the hose?', '', 'L1-Firehouse/2-9-Where_is_the_hose.mp3', '', '2', '', '', '', '', '', '', '', '', '427', 'hose n. 管子，水管 水管是圆圆长长的。', '', '', '管子在哪里？', '管子是圆圆的，长长的，仔细在图中找找吧～', '', '2', '1', 'RL.K.1', '0');
INSERT INTO `hi_conf_topic` VALUES ('199', '38', 'How do firefighters use hoses to fight fires?', '', 'L1-Firehouse/2-9-How_do_firefighters_use_hoses_to_fight_fires.mp3', '', '2', '', '', '', '', '', '', '', '', '430', 'Hoses spray water.\n管子是用来喷水的。消防员用水管喷出的水去灭火。', '', '', '消防员们怎么用管子去灭火？', '管子里会流出什么呢？它能帮消防员扑灭火哦～<br>spray v. 喷洒', '', '2', '0', 'RL.K.4', '0');
INSERT INTO `hi_conf_topic` VALUES ('200', '37', 'What is this?', 'L1-Firehouse/2-9-fire_ladder.png', 'L1-Firehouse/2-9-ladder.mp3', '', '5', '', '', '', '', '', '', '', '', '434|435|436|437|438|439', 'ladder n.  梯子', '', '', '这是什么呢？（单词拼写）', 'ladder n. 梯子', '', '2', '1', 'RL.K.1', '0');
INSERT INTO `hi_conf_topic` VALUES ('201', '37', 'What else do you see in the picture?', 'L1-Firehouse/2-9-fire_truck_book.png', 'L1-Firehouse/2-9-What_else_do_you_see_in_the_picture.mp3', '', '2', '', '', '', '', '', '', '', '', '443', 'All of these, Little Critter and the Fire Dog, The ladder and the hose, Fireman Joe\n从图片中可以看到所有这些 \"All of these\"，有小毛人，消防犬，梯子，管子和消防员Joe。', '', '', '你在这张图里还看到什么？', '我还看到了小毛人Little Critter, 消防犬，你还能看到什么呢？', '', '2', '1', 'RL.K.1', '0');
INSERT INTO `hi_conf_topic` VALUES ('202', '37', 'What are they doing?', 'L1-Firehouse/2-9-check_the_hose.png', 'L1-Firehouse/2-9-What_are_they_doing.mp3', '', '2', '', '', '', '', '', '', '', '', '445', 'They are checking the hose.\n他们正在检查管子。', '', '', '他们在干什么？', '他们手里拿着的是什么呢？\nRead the book, page 16. \n阅读书本第16页找找答案吧～\"', '', '2', '1', 'RL.K.3', '0');
INSERT INTO `hi_conf_topic` VALUES ('203', '38', 'Why does the fireman check the hose?', 'L1-Firehouse/2-9-check_the_hose.png', 'L1-Firehouse/2-9-Why_does_the_fireman_check_the_hose.mp3', '', '2', '', '', '', '', '', '', '', '', '450', 'To make sure the hose works\n消防员检查水管是为了确保水管是好的', '', '', '为什么消防员检查管子？', '消防员用水管来灭火，检查管子是为了什么呢？', '', '2', '0', 'RL.K.3', '0');
INSERT INTO `hi_conf_topic` VALUES ('205', '38', 'Which of these is a period?', '', 'L1-Firehouse/2-9-Which_of_these_is_a_period.mp3', '', '2', '', '', '', '', '', '', '', '', '459', 'Period 句号 .', '', '', '这些里面哪个是句号？', '英文里的句号是怎么样的呢？', '', '2', '0', 'L.K.2', '0');
INSERT INTO `hi_conf_topic` VALUES ('206', '38', 'Which of these is a question mark?', '', 'L1-Firehouse/2-9-Which_of_these_is_a_question_mark.mp3', '', '2', '', '', '', '', '', '', '', '', '463', 'Question Mark 问号 ?', '', '', '这些里面哪个是问号？', '问号是怎么样的呢？', '', '2', '0', 'L.K.2', '0');
INSERT INTO `hi_conf_topic` VALUES ('207', '38', 'Which of these is an exclamation point?', '', 'L1-Firehouse/2-9-Which_of_these_is_an_exclamation_point.mp3', '', '2', '', '', '', '', '', '', '', '', '467', 'Exclamation Point 感叹号 !', '', '', '这些里面哪个是感叹号？', '感叹号是怎么样的呢？', '', '2', '0', 'L.K.2', '0');
INSERT INTO `hi_conf_topic` VALUES ('208', '38', 'Match the three words with the symbols.', '', 'L1-Firehouse/2-9-Match_the_three_words_with_the_symbols.mp3', '', '9', '', '', '', '', '', '', '', '', '', 'Period 句号 .\nQuestion Mark 问号 ?\nExclamation Point 感叹号 !', '', '', '将文字和符号配对', 'Period 句号<br>Question Mark 问号<br>Exclamation Point 感叹号\r\n', '', '4', '0', 'L.K.2', '0');
INSERT INTO `hi_conf_topic` VALUES ('209', '41', 'What is he doing?', 'L1-Firehouse/2-13-Joe_checks_ladder.png', 'L1-Firehouse/2-13-What_is_he_doing.mp3', '', '2', '', '', '', '', '', '', '', '', '474', 'Fireman is checking the ladder. He is in the sky.\n消防员Joe正在检查梯子。', '', '', '他在做什么呢？', 'Do you see Fireman Joe? Where is he? \n消防员Joe正在检查什么呢？', '', '2', '1', 'RL.K.4', '0');
INSERT INTO `hi_conf_topic` VALUES ('210', '41', 'What is a fireman ladder?', 'L1-Firehouse/2-13-fireman_ladder.png', 'L1-Firehouse/2-13-What_is_a_fireman_ladder.mp3', '', '2', '', '', '', '', '', '', '', '', '477', 'The Fireman is climbing up the ladder.\n消防员在爬梯子。你找对了么？', '', '', '哪个是消防梯？', 'ladder n. 梯子', '', '2', '1', 'RL.K.4', '0');
INSERT INTO `hi_conf_topic` VALUES ('211', '42', 'What is the fireman doing?', 'L1-Firehouse/2-13-use_hose.png', 'L1-Firehouse/2-13-What_is_the_fireman_doing.mp3', '', '2', '', '', '', '', '', '', '', '', '480', 'The fireman is using the hose to fight the fire.\n消防员正用水管灭火。', '', '', '消防员在做什么？', 'The fireman is fighting a fire. What does he hold in his hand?\n消防员正在灭火，他手里拿着什么呢？', '', '2', '0', 'RL.K.4', '0');
INSERT INTO `hi_conf_topic` VALUES ('212', '41', 'What is he doing?', 'L1-Firehouse/2-13-climb_the_ladder-.png', 'L1-Firehouse/2-13-What_is_he_doing.mp3', '', '2', '', '', '', '', '', '', '', '', '484', 'He is climbing up the ladder.\n他正在爬梯子。', '', '', '他在做什么？', 'Do you see the fireman ladder?\nClimbing v. 爬，消防员在爬什么？', '', '2', '1', 'RL.K.4', '0');
INSERT INTO `hi_conf_topic` VALUES ('213', '41', 'Which of these makes a lot of noise?', '', 'L1-Firehouse/2-13-Which_of_these_makes_a_lot_of_noise.mp3', '', '2', '', '', '', '', '', '', '', '', '488', 'The loudspeaker makes a lot of noise.\n扬声器喇叭会发出很吵的声音。', '', '', '这些中哪个发出很吵的声音？', 'Think about the sounds they made.\n想想他们发出的声音，哪个很吵呢？', '', '2', '1', 'RL.K.4', '0');
INSERT INTO `hi_conf_topic` VALUES ('215', '42', 'What is the little boy doing?', 'L1-Firehouse/2-13-covering_ears.png', 'L1-Firehouse/2-13-What_is_the_little_boy_doing.mp3', '', '2', '', '', '', '', '', '', '', '', '496', 'He is covering his ears.\n他捂住了他的耳朵。', '', '', '小男孩在做什么？', 'Cover  v. 捂住，遮住；ear n. 耳朵。', '', '2', '0', 'RL.K.4', '0');
INSERT INTO `hi_conf_topic` VALUES ('216', '41', 'When do you cover your ears?', '', 'L1-Firehouse/2-13-When_do_you_cover_your_ears.mp3', '', '2', '', '', '', '', '', '', '', '', '502', 'You cover your ears, when you hear a siren.\n当你听到警报声，你会捂住耳朵。因为它会发出很吵的声音。', '', '', '什么情况你会捂耳朵？', 'Think about the sounds they made.\n想想他们发出的声音，听到什么你会捂耳朵呢？', '', '2', '1', 'RL.K.1', '0');
INSERT INTO `hi_conf_topic` VALUES ('217', '41', 'Why is Little Critter covering his Ears?', 'L1-Firehouse/2-13-fireman_Joe.png', 'L1-Firehouse/2-13-Why_is_Little_Critter_Covering_his_Ears.mp3', '', '2', '', '', '', '', '', '', '', '', '506', 'Because the siren is very loud.\n小毛人捂住耳朵，因为警报器声音太大了。', '', '', '为什么小毛人捂住他的耳朵？', 'Joe checks the siren. It goes Ooo! Eee! Ooo! The siren is very loud. \nsiren n. 报警器；loud adj. 大声的', '', '2', '1', 'RL.K.1', '0');
INSERT INTO `hi_conf_topic` VALUES ('219', '41', 'What is she doing?', 'L1-Firehouse/2-13-go_down.png', 'L1-Firehouse/2-13-What_is_she_doing.mp3', '', '2', '', '', '', '', '', '', '', '', '511', 'She is running away from the smoke.\n她正在逃离烟雾。', '', '', '她在做什么？', 'What\'s the black thing? \n这团黑黑的是什么呢？危险吗？', '', '2', '1', 'RL.K.2', '0');
INSERT INTO `hi_conf_topic` VALUES ('220', '42', 'If you see smoke, what should you do?', '', 'L1-Firehouse/2-13-If_you_see_smoke,_what_should_you_do.mp3', '', '2', '', '', '', '', '', '', '', '', '515', 'Run away from the smoke.\n当你看到烟，你应该逃离那。这是正确的做法哦！', '', '', '如果你看到烟，你应该怎么做呢？', 'Smoke is as dangerous as fire. You shouldn\'t stay there.\n浓烟是非常危险的，我们应该要怎么做呢？', '', '2', '1', 'RL.K.1', '0');
INSERT INTO `hi_conf_topic` VALUES ('222', '42', 'What is he doing?', 'L1-Firehouse/2-13-boy_crawl.png', 'L1-Firehouse/2-13-What_is_he_doing.mp3', '', '2', '', '', '', '', '', '', '', '', '526', 'He is crawling on the floor.\n他正在地上爬。', '', '', '他在做什么？', 'crawling 爬', '', '2', '0', 'RL.K.1', '0');
INSERT INTO `hi_conf_topic` VALUES ('223', '41', 'Match the words with the pictures.', '', 'L1-Firehouse/Match_the_words_with_the_pictures.mp3', '', '8', '', '', '', '', '', '', '', '', '', '', '', '', '匹配图片和单词', '', '2_3', '4', '1', 'RL.K.4', '0');
INSERT INTO `hi_conf_topic` VALUES ('224', '42', 'What is happening to the house?', 'L1-Firehouse/2-13-on_fire.png', 'L1-Firehouse/2-13-What_is_happening_to_the_house.mp3', '', '2', '', '', '', '', '', '', '', '', '532', 'The house is on fire.\n房子着火了。', '', '', '这个房子发生什么事情了？', 'Is the house fine? It is full of fire and smoke. \n这个房子着火了。\n', '', '2', '0', 'RL.K.2', '0');
INSERT INTO `hi_conf_topic` VALUES ('225', '41', 'Which of these is smoke?', 'L1-Firehouse/2-13-smoke.png', 'L1-Firehouse/2-13-Which_of_these_is_smoke.mp3', '', '2', '', '', '', '', '', '', '', '', '534', 'Smoke looks like black/grey cloud.\n烟像黑色/灰色的云。', '', '', '这些中哪个是烟？', 'smoke n. 烟　', '', '2', '1', 'RL.K.4', '0');
INSERT INTO `hi_conf_topic` VALUES ('226', '41', 'Which word is the action verb?', '', 'L1-Firehouse/2-13-Which_word_is_the_action_verb.mp3', '', '2', '', '', '', '', '', '', '', '', '539', 'check v. 检查\nsiren n.  警报器', '', '', '哪个单词是行为动词？', 'action verb 行为动词;\ncheck v. 检查;\nsiren n.警报器', '', '2', '1', 'L.K.1b ', '0');
INSERT INTO `hi_conf_topic` VALUES ('227', '41', 'Which word is the action verb?', '', 'L1-Firehouse/2-13-Which_word_is_the_action_verb.mp3', '', '2', '', '', '', '', '', '', '', '', '544', 'cover v. 捂住\near n. 耳朵', '', '', '哪个单词是行为动词？', 'action verb 行为动词;\ncover v. 捂住;\near n. 耳朵', '', '2', '1', 'L.K.1b ', '0');
INSERT INTO `hi_conf_topic` VALUES ('229', '45', 'What was the surprise?', 'L1-Firehouse/2-17-surprise.png', 'L1-Firehouse/2-17-What_was_the_surprise.mp3', '', '2', '', '', '', '', '', '', '', '', '551', 'Helmets for everyone.\n惊喜是消防员Joe给每个人都带来了消防头盔。', '', '', '消防员Joe带给大家的惊喜是什么呢？', 'Fireman Joe reaches into his truck.\nHelmets for everyone! \n结合图片看看，消防员Joe給每个小朋友带来了什么？', '', '2', '1', 'RL.K.1', '0');
INSERT INTO `hi_conf_topic` VALUES ('231', '45', 'Where is the helmet?', 'L1-Firehouse/2-17-helmet.png', 'L1-Firehouse/2-17-Where_is_the_helmet.mp3', '', '2', '', '', '', '', '', '', '', '', '559', 'helmet n. 头盔\n头盔正戴在小毛人头上。', '', '', '头盔在哪里？', 'helmet n. 头盔', '', '2', '1', 'RL.K.4', '0');
INSERT INTO `hi_conf_topic` VALUES ('232', '45', 'What is the fireman putting on?', 'L1-Firehouse/2-17-put_on_jacket.png', 'L1-Firehouse/2-17-What_is_the_fireman_putting_on.mp3', '', '2', '', '', '', '', '', '', '', '', '564', 'He is putting on his jacket.\n他正在穿上夹克。', '', '', '消防员在穿什么？', 'boots n. 靴子；\nhelmet n. 头盔；\njacket n. 夹克；\nbelt n. 皮带', '', '2', '1', 'RL.K.1', '0');
INSERT INTO `hi_conf_topic` VALUES ('233', '46', 'What color is the little boy\'s coat?', 'L1-Firehouse/2-17-color_jacket.png', 'L1-Firehouse/2-17-What_color_is_the_little_boy\'s_coat.mp3', '', '2', '', '', '', '', '', '', '', '', '568', 'His coat is blue.\n他的外套是蓝色的。', '', '', '小男孩的外套是什么颜色的？', 'coat n. 外套', '', '2', '0', 'RL.K.2', '0');
INSERT INTO `hi_conf_topic` VALUES ('234', '45', 'What number is on Little Critter\'s helmet?', 'L1-Firehouse/2-17-Critter-number.png', 'L1-Firehouse/2-17-What_number_is_on_Little_Critter\'s_helmet.mp3', '', '2', '', '', '', '', '', '', '', '', '570', 'It\'s the number 1.\n是数字1。', '', '', '小毛人头盔上的是什么数字？', 'Look at the number on Little Critter\'s helmet.\nhelmet n. 头盔；\nnumber n. 数字；', '', '2', '1', 'RL.K.1', '0');
INSERT INTO `hi_conf_topic` VALUES ('235', '46', 'What is the number on Fireman Joe\'s helmet?', 'L1-Firehouse/2-17-Joe-number.png', 'L1-Firehouse/2-17-What_is_the_number_on_Fireman_Joe\'s_helmet.mp3', '', '2', '', '', '', '', '', '', '', '', '577', 'It\'s the number twenty-three.\n是数字23。', '', '', '消防员Joe头盔上的是什么数字？', 'Look at the number on Fireman Joe\'s helmet.\ntwelve 12；\ntwenty 20', '', '2', '0', 'RL.K.1', '0');
INSERT INTO `hi_conf_topic` VALUES ('236', '45', 'What is the little boy doing?', 'L1-Firehouse/2-17-hold_hose.png', 'L1-Firehouse/2-17-What_is_the_little_boy_doing.mp3', '', '2', '', '', '', '', '', '', '', '', '579', 'He is holding a fire hose.\n小男孩正拿着一根消防水管。', '', '', '小男孩在做什么？', 'hold v. 拿着；握着', '', '2', '1', 'RL.K.2', '0');
INSERT INTO `hi_conf_topic` VALUES ('237', '45', 'What is the boy on the train doing?', 'L1-Firehouse/2-17-wave-good-bye.png', 'L1-Firehouse/2-17-What_is_the_boy_on_the_train_doing.mp3', '', '2', '', '', '', '', '', '', '', '', '584', 'He is waving good-bye.\n他正在挥手道别。\nwave v. 挥动\nweave v. 编织', '', '', '火车上的男孩在做什么？', 'wave v. 挥动；\nweave v. 编织', '', '2', '1', 'RL.K.4', '0');
INSERT INTO `hi_conf_topic` VALUES ('238', '45', 'Where is Fireman Joe ready to go to?', 'L1-Firehouse/2-17-ready_to_go.png', 'L1-Firehouse/2-17-Where_is_Fireman_Joe_ready_to_go_to.mp3', '', '2', '', '', '', '', '', '', '', '', '588', 'He is ready to go fight a fire.\n他准备去灭火。', '', '', '消防员Joe正准备去哪里？', 'go home 回家；\ngo fishing 钓鱼；\ngo swimming 游泳；\nfight a fire 去灭火', '', '2', '1', 'RL.K.1', '0');
INSERT INTO `hi_conf_topic` VALUES ('239', '46', 'What is she ready to do?', 'L1-Firehouse/2-17-girl-readies-to.png', 'L1-Firehouse/2-17-What_is_she_ready_to_do.mp3', '', '2', '', '', '', '', '', '', '', '', '593', 'She is ready to go to the beach (海滩).<br>她准备出发去海滩了。', '', '', '她正准备去哪里？', 'Look at what she takes with her. \nbeach 海滩；school 学校；skiiing 滑雪；fight a fire 救火；\n仔细看看她穿的衣服和带的物品，好像是去度假的样子哦～', '', '2', '0', 'RL.K.2', '0');
INSERT INTO `hi_conf_topic` VALUES ('240', '45', 'Match the number with the correct country.', '', 'L1-Firehouse/2-17-Match_the_number_with_the_correct_country.mp3', '', '9', '', '', '', '', '', '', '', '', '', 'China 119，中国的火警电话119.\nUSA 911，美国的火警电话911.', '', '', '配对正确的国家和号码', 'China 中国 119\r\nUSA 美国 911', '', '4', '1', 'RL.K.2', '0');
INSERT INTO `hi_conf_topic` VALUES ('241', '45', 'When is International Firefighter\'s Day?', 'L1-Firehouse/2-17-firefighters_day.png', 'L1-Firehouse/2-17-When_is_International_Firefighter\'s_Day.mp3', '', '2', '', '', '', '', '', '', '', '', '599', 'May fourth 五月四号', '', '', '国际消防员日是哪天？', 'International Firefighter\'s Day\n国际消防员日', '', '2', '1', 'RL.K.4', '0');
INSERT INTO `hi_conf_topic` VALUES ('242', '45', 'How many helmets are there?', 'L1-Firehouse/2-17-how_many_helmet.png', 'L1-Firehouse/2-17-How_many_helmets_are_there.mp3', '', '2', '', '', '', '', '', '', '', '', '600', 'Only one \n只有一个头盔。', '', '', '这里有多少顶头盔？', 'helmet n. 头盔', '', '2', '1', 'RL.K.1', '0');
INSERT INTO `hi_conf_topic` VALUES ('243', '45', 'What is this?', 'L1-Firehouse/2-17-ladder.png', 'L1-Firehouse/2-17-What_is_this.mp3', '', '2', '', '', '', '', '', '', '', '', '605', 'It is a ladder.\n这是一把梯子。', '', '', '这是什么？', 'Remember the word? \n还记得这个单词是什么吗？翻翻书的第15页，看看那辆红色的消防车上除了有水管，还有什么？ ', '', '2', '1', 'RL.K.4', '0');
INSERT INTO `hi_conf_topic` VALUES ('244', '46', 'Match the words with the pictures.', '', 'L1-Firehouse/Match_the_words_with_the_pictures.mp3', '', '9', '', '', '', '', '', '', '', '', '', 'One cat 一只猫咪\r\nTwo cats 两只猫咪 （cat用复数形式cats）\r\nEight cats 八只猫咪 （cat用复数形式cats）', '', '', '配对文字和图片', '数一数有多少只猫咪哦～', '', '4', '0', 'L.K.1c', '0');
INSERT INTO `hi_conf_topic` VALUES ('245', '38', 'Why do firefighters slide down poles?', '', 'L1-Firehouse/2-9-Why_do_firefighters_slide_down_poles.mp3', '', '2', '', '', '', '', '', '', '', '', '611', 'To get to the fire faster.\n因为从杆子上滑下来更快，这样能更迅速赶到火灾现场。', '', '', '为什么消防员从杆子上滑下来？', '从杆子上滑和从楼梯走哪个快呢? 想想消防员需要很快的去干什么呢？', '', '2', '0', 'RL.K.2', '0');
INSERT INTO `hi_conf_topic` VALUES ('246', '42', 'What does smoke look like?', 'L1-Firehouse/2-13-smoke.png', 'L1-Firehouse/2-14-What_does_smoke_look_like.mp3', '', '2', '', '', '', '', '', '', '', '', '615', 'Smoke looks like black/grey cloud.\n烟像黑色/灰色的云。', '', '', '这些中哪个是烟？', 'smoke n. 烟　', '', '2', '0', 'RL.K.4', '0');
INSERT INTO `hi_conf_topic` VALUES ('247', '46', 'What was the surprise?', 'L1-Firehouse/2-17-surprise.png', 'L1-Firehouse/2-17-What_was_the_surprise.mp3', '', '2', '', '', '', '', '', '', '', '', '620', 'Helmets for everyone.\n惊喜是消防员Joe给每个人都带来了消防头盔。', '', '', '消防员Joe带给大家的惊喜是什么呢？', 'Fireman Joe reaches into his truck.\nHelmets for everyone! \n结合图片看看，消防员Joe給每个小朋友带来了什么？', '', '2', '0', 'RL.K.1', '0');
INSERT INTO `hi_conf_topic` VALUES ('248', '46', 'What is the little boy holding?', 'L1-Firehouse/2-17-hold_hose.png', 'L1-Firehouse/2-18-What_is_the_little_boy_holding.mp3', '', '2', '', '', '', '', '', '', '', '', '624', 'He is holding a fire hose.\n小男孩正拿着一根消防水管。', '', '', '小男孩正拿着什么？', 'hold v. 拿着；握着', '', '2', '0', 'RL.K.2', '0');
INSERT INTO `hi_conf_topic` VALUES ('249', '47', 'Match the words with the pictures.', '', 'L1-Firehouse/Match_the_words_with_the_pictures.mp3', '', '9', '', '', '', '', '', '', '', '', '', 'siren n. 汽笛，警报器\ncover v. 捂住，盖\nsmoke n. 浓烟', '', '', '拖动配对', 'siren n. 汽笛，警报器；\ncover v. 捂住，盖；\nsmoke n. 浓烟', '', '4', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('250', '47', 'What sound does the siren make?', 'L1-Firehouse/siren-question.png', 'L1-Firehouse/2-19-What_sound_does_the_siren_make.mp3', '', '2', '', '', '', '', '', '', '', '', '632', 'The siren goes Ooo! Eee! Ooo!\n警报器发出的是Ooo! Eee! Ooo!的声音', 'L1-Firehouse/siren-sound.mp3', '', '警报器发出的声音是怎样的？', '想想平时在路上听到消防车报警的声音是怎样的？ 或者你也可以翻翻书的第21页，找找答案哦～', '', '2', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('251', '47', 'Joe says what to do if we are on fire. We should ________', 'L1-Firehouse/stop_drop_roll.png', 'L1-Firehouse/2-19-Joe_says_what_to_do_if_we_are_on_fire_We_should.mp3', '', '2', '', '', '', '', '', '', '', '', '635', 'We should stop, drop, and roll if we are on fire.\n记住，当身上着火时，我们不要跑，要立马停住、趴下，然后在地上翻滚，这样可以灭掉身上的火。', '', 'L1-Firehouse/stop-drop-roll.mp4', '消防员Joe告诉我们如果身上着火了，我们应该________', '还记得消防员教给我们的消防安全知识吗？\n如果不记得，可以翻翻书的第25页哦～', '', '2', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('252', '47', 'Making Sentences', 'L1-Firehouse/I_put_on_my_helmet.png', 'L1-Firehouse/Making_Sentences.mp3', '', '7', '', '', '', '', '', '', '', '', '638|639|640|641', 'I put on my helmet.\n我戴上我的头盔。', 'L1-Firehouse/I_put_on_my_helmet.mp3', '', '我戴上了我的头盔', 'Check the book, page 28. \n可以翻翻书的第28页哦～', '', '2', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('253', '47', 'Who is the author of the book?', 'L1-Firehouse/Little_Critter-Going_to_the_Firehouse_Cover.png', 'L1-Firehouse/2-5-Who_is_the_author_of_the_book.mp3', '', '2', '', '', '', '', '', '', '', '', '643', 'We use \"By\" before the name of the writer. \n通常英文里，在书的作者前，会用“by”这个词B。书的封面上写到“BY MERCER MAYER”，即作者是Mercer Mayer.', '', '', '这本书的作者是谁？', 'author n. 作者，可以在书的封面上找找答案哦～', '', '2', '0', 'RL.K.6', '0');
INSERT INTO `hi_conf_topic` VALUES ('254', '47', 'Fill in the Blank', 'L1-Firehouse/2-19-Sparky_is_a_fire_dog.png', 'L1-Firehouse/2-19-Sparky_is_a_fire_dog.mp3', '', '6', '', '', '', '', '', '', '', '', '647|648', 'Sparky is a fire dog.\nSparky 是一只消防狗。', '', '', 'Sparky是一只消防狗。', 'fire dog 消防狗\n可以翻翻书的第9页哦～', '', '2', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('255', '47', 'Where is the hose?', '', 'L1-Firehouse/2-9-Where_is_the_hose.mp3', '', '2', '', '', '', '', '', '', '', '', '651', 'hose n. 管子，水管 水管是圆圆长长的。', '', '', '管子在哪里？', '管子是圆圆的，长长的，仔细在图中找找吧～', '', '2', '0', 'RL.K.1', '0');
INSERT INTO `hi_conf_topic` VALUES ('256', '47', 'Match the three words with the symbols.', '', 'L1-Firehouse/2-9-Match_the_three_words_with_the_symbols.mp3', '', '9', '', '', '', '', '', '', '', '', '', 'Period 句号 .\nQuestion Mark 问号 ?\nExclamation Point 感叹号 !', '', '', '将文字和符号配对', 'Period 句号<br>Question Mark 问号<br>Exclamation Point 感叹号\r\n', '', '4', '0', 'L.K.2', '0');
INSERT INTO `hi_conf_topic` VALUES ('257', '47', 'They are going to the firehouse.', 'L1-Firehouse/2-1-They_are_going_to_the_firehouse.png', 'L1-Firehouse/2-1-They_are_going_to_the_firehouse.mp3', '', '1', '', '', '', '', '', '', '', '', '657', 'Today my class is going to the firehouse! 今天我们班级去消防局！\n选TRUE，他们是去消防局。', 'L1-Firehouse/2-1-Today_my_class_is_going_to_the_firehouse.mp3', '', '他们去消防局。', 'Read the book, page 6 and page 7. \n阅读书本第6页和第7页找找答案吧～', '', '2', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('258', '47', 'Clicking Paires', '', 'L1-Firehouse/Clicking_Pairs.mp3', '', '8', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '3_4', '6', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('259', '29', 'How do you spell this word?', 'L1-Firehouse/2-1-firehouse.png', 'L1-Firehouse/2-1-firehouse.mp3', '', '5', '', '', '', '', '', '', '', '', '666|667|668|669|670|671|672', 'firehouse n. 消防局', '', '', '怎么拼写图片上的消防局？', 'Check the book cover. \n看看书的封面，找找答案吧～', '', '2', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('260', '47', 'How many times is the number 23 shown in the book? (book cover included)', 'L1-Firehouse/2-19-number_23.png', 'L1-Firehouse/2-19-How_many_times_is_the_number_23_shown_in_the_book.mp3', '', '2', '', '', '', '', '', '', '', '', '677', 'More than 16. (more than 多于；大于)\n数字23在书中出现了好多次，有的在Fireman Joe的消防帽上，有的在消防车上，甚至在31页，另一位消防员的消防帽上也有数字23。你一共找到多少个呢？', '', '', '数字23在书中出现了多少次呢？包括书的封面哦～<br>回到书中找一找吧！', 'Look at Fireman Joe\'s helmet and the fire truck. Do you see the number 23? Find out more!<br>看看消防员Joe的头盔和消防车上，你看到数字23了么？试试找到更多的数字23吧～<br>more than 多于', '', '2', '0', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('261', '33', 'What did you like the best?', '', 'L1-Firehouse/What_did_you_like_the_best.mp3', '', '13', '', '', '', '', '', '', '', '', '678|679|680|681', 'Good choice! 很高兴你喜欢这部分内容。\r\nWell done! 继续加油哦～', 'L1-Firehouse/yeah.mp3', '', '上完这节课，你最喜欢的是哪个部分呢？', '选出今天学习内容中，你最喜欢的部分吧～', '', '5', '1', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('262', '37', 'What did you like the best?', '', 'L1-Firehouse/What_did_you_like_the_best.mp3', '', '13', '', '', '', '', '', '', '', '', '682|683|684|685', 'Good choice! 很高兴你喜欢这部分内容。\r\nWell done! 继续加油哦～', 'L1-Firehouse/yeah.mp3', '', '上完这节课，你最喜欢的是哪个部分呢？', '选出今天学习内容中，你最喜欢的部分吧～', '', '5', '1', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('263', '41', 'What did you like the best?', '', 'L1-Firehouse/What_did_you_like_the_best.mp3', '', '13', '', '', '', '', '', '', '', '', '686|687|688|689', 'Good choice! 很高兴你喜欢这部分内容。\r\nWell done! 继续加油哦～', 'L1-Firehouse/yeah.mp3', '', '上完这节课，你最喜欢的是哪个部分呢？', '选出今天学习内容中，你最喜欢的部分吧～', '', '5', '1', '', '0');
INSERT INTO `hi_conf_topic` VALUES ('264', '45', 'What did you like the best?', '', 'L1-Firehouse/What_did_you_like_the_best.mp3', '', '13', '', '', '', '', '', '', '', '', '690|691|692|693', 'Good choice! 很高兴你喜欢这部分内容。\r\nWell done! 继续加油哦～', 'L1-Firehouse/yeah.mp3', '', '上完这节课，你最喜欢的是哪个部分呢？', '选出今天学习内容中，你最喜欢的部分吧～', '', '5', '1', '', '0');

-- ----------------------------
-- Table structure for hi_conf_topic_answer
-- ----------------------------
DROP TABLE IF EXISTS `hi_conf_topic_answer`;
CREATE TABLE `hi_conf_topic_answer` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Tid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '所属题目ID',
  `Name` varchar(255) NOT NULL DEFAULT '' COMMENT '答案描述',
  `Image` varchar(100) NOT NULL DEFAULT '' COMMENT '图片',
  `Show` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '是否显示该选项（0:不显示1:显示)',
  `Pair1Text` varchar(255) NOT NULL DEFAULT '' COMMENT '配对文字1',
  `Pair1Audio` varchar(255) NOT NULL DEFAULT '' COMMENT '配对音频1',
  `Pair1Img` varchar(255) NOT NULL DEFAULT '' COMMENT '配对图片1',
  `Pair2Text` varchar(255) NOT NULL DEFAULT '' COMMENT '配对文字2',
  `Pair2Audio` varchar(255) NOT NULL DEFAULT '' COMMENT '配对音频2',
  `Pair2Img` varchar(255) NOT NULL DEFAULT '' COMMENT '配对图片2',
  PRIMARY KEY (`ID`),
  KEY `Tid` (`Tid`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=694 DEFAULT CHARSET=utf8 COMMENT='答案表';

-- ----------------------------
-- Records of hi_conf_topic_answer
-- ----------------------------
INSERT INTO `hi_conf_topic_answer` VALUES ('1', '5', '', '', '0', '', '', 'L2-Balto/1-4-brave.png', 'brave', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('2', '5', '', '', '0', '', '', 'L2-Balto/1-4-bury.png', 'bury', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('3', '5', '', '', '0', '', '', 'L2-Balto/1-4-get_sick.png', 'get sick', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('4', '6', 'Balto', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('5', '6', 'was', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('6', '6', 'a', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('7', '6', 'sled dog', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('8', '6', '.', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('9', '7', 'terrible', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('10', '11', 'The', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('11', '11', 'train', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('12', '11', 'got stuck', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('13', '11', 'in the deep snow', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('14', '11', '.', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('15', '16', 'hitch', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('16', '17', 'Balto would come to the', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('17', '17', 'rescue', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('18', '17', '.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('19', '24', '', '', '0', '', '', 'L2-Balto/1-16-block.jpeg', 'block', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('20', '24', '', '', '0', '', '', 'L2-Balto/1-16-sink.jpeg', 'sink', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('21', '24', '', '', '0', '', '', 'L2-Balto/1-16-dig.png', 'dig', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('22', '25', 'drown', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('23', '26', 'Gunnar', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('24', '26', 'cracked', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('25', '26', 'his whip.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('26', '33', '', '', '0', '', '', 'L2-Balto/1-20-in_time.jpeg', 'in time', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('27', '33', '', '', '0', '', '', 'L2-Balto/1-20-reach.png', 'reach', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('28', '33', '', '', '0', '', '', 'L2-Balto/1-20-dawn.png', 'dawn', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('29', '34', 'Finally the storm', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('30', '34', 'died', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('31', '34', 'down', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('32', '34', '.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('33', '35', 'Balto had stopped just', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('34', '35', 'in', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('35', '35', 'time', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('36', '35', '.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('37', '41', '', '', '0', '', '', 'L2-Balto/1-24-deliver.jpeg', 'deliver', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('38', '41', '', '', '0', '', '', 'L2-Balto/1-24-hero.jpeg', 'hero', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('39', '41', '', '', '0', '', '', 'L2-Balto/1-24-cheer.png', 'cheer', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('40', '42', 'They', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('41', '42', 'remember', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('42', '42', 'Balto, the bravest dog ever!', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('43', '43', '', '', '0', '', '', 'L2-Balto/1-24-straight.jpeg', 'straight', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('44', '43', '', '', '0', '', '', 'L2-Balto/1-24-cheer.png', 'cheer', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('45', '43', '', '', '0', '', '', 'L2-Balto/1-24-remember.jpeg', 'remember', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('46', '44', 'remember', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('47', '44', 'cheer', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('48', '44', 'hero', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('49', '44', 'deliver', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('50', '45', 'TRUE', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('51', '45', 'FALSE', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('52', '46', '1952', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('53', '46', '1900', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('54', '46', '1925', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('55', '46', '1825', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('56', '47', 'The children', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('57', '47', 'had ', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('58', '47', 'a terrible', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('59', '47', 'sickness', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('60', '47', '.', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('61', '48', '', 'L2-Balto/1-48-jeep.png', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('62', '48', '', 'L2-Balto/1-48-plane.png', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('63', '48', '', 'L2-Balto/1-48-sled.jpeg', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('64', '48', '', 'L2-Balto/1-48-dog.png', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('65', '49', '', '', '0', '', '', 'L2-Balto/1-49-doctor.png', 'doctor', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('66', '49', '', '', '0', '', '', 'L2-Balto/1-49-dog_sled.jpeg', 'dog sled', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('67', '49', '', '', '0', '', '', 'L2-Balto/1-49-sickness.jpeg', 'sickness', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('68', '50', 'Natalie Standiford', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('69', '50', 'J. K Rolling', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('70', '50', 'Donald Cook', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('71', '50', 'Dr. Seuss', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('72', '51', 'TRUE', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('73', '51', 'FALSE', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('74', '52', 'sad', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('75', '52', 'excited', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('76', '52', 'worried', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('77', '52', 'scared', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('78', '54', '', '', '0', 'First', '', '', 'The train carried the medicine from Anchorage to a Nenana before it got stuck in the deep snow.', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('79', '54', '', '', '0', 'Then', '', '', 'The race to Nome began. The first driver took the medicine from the train and made his run in good time.', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('80', '54', '', '', '0', 'After that', '', '', 'A blizzard was coming! Somehow each dog team made it to the next stop.', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('81', '54', '', '', '0', 'Finally', '', '', 'Gunnar and Balto waited at their stop in Bluff and were ready to go…', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('82', '67', 'Balto', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('83', '67', 'Not Balto', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('84', '68', 'He is important.', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('85', '68', 'For no good reason.', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('86', '69', 'It is cold and icy.', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('87', '69', 'It is warm and sunny.', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('88', '69', 'It is damp and rainy. ', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('89', '69', 'It is hot and icy.', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('90', '71', 'Car', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('91', '71', 'House', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('92', '71', 'Dog', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('93', '71', 'Bike', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('94', '72', 'Harbin', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('95', '72', 'Wuhan', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('96', '72', 'Chongqing', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('97', '72', 'Nanjing', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('98', '73', 'All of these are true.', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('99', '73', 'You could not travel by train.', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('100', '73', 'You could not travel by boat.', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('101', '73', 'You could not travel by car.', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('102', '74', '3 people', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('103', '74', '2 people', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('104', '74', '1 person', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('105', '74', '7 people', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('106', '75', 'Food and tools', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('107', '75', 'Food and gold', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('108', '75', 'Gold and minterals', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('109', '75', 'Gold and diamonds', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('110', '77', 'A dog that leads', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('111', '77', 'A dog that follows', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('112', '77', 'A person that leads', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('113', '77', 'A person that follows', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('114', '78', 'A', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('115', '78', 'B', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('116', '78', 'C', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('117', '78', 'D', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('118', '79', 'Black', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('119', '79', 'Blue', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('120', '79', 'Golden', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('121', '79', 'Light Gray', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('122', '80', 'Smartest Strongest', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('123', '80', 'Smartest Dog', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('124', '80', 'Strongest Dog', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('125', '80', 'Strongest Lead', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('126', '84', 'It\'s very windy.', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('127', '84', 'It\'s very rainy.', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('128', '84', 'It\'s very snowy.', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('129', '84', 'It\'s very icy.', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('130', '85', 'No, of course not!', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('131', '85', 'Yes, of course they can!', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('132', '86', 'See you later', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('133', '86', 'Hello', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('134', '87', 'Yes', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('135', '87', 'No', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('136', '81', 'Giraffes', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('137', '81', 'are', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('138', '81', 'the tallest animals', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('139', '81', 'in the world.', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('140', '82', 'Dolphins', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('141', '82', 'are', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('142', '82', 'the smartest animals', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('143', '82', 'in the world.', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('144', '83', '', '', '0', '', '', 'L2-Balto/1-5-cutest.png', 'cutest', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('145', '83', '', '', '0', '', '', 'L2-Balto/1-5-noisiest.png', 'noisiest', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('146', '83', '', '', '0', '', '', 'L2-Balto/1-5-ugliest.png', 'ugliest', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('147', '70', '', 'L2-Balto/1-5-bravest_knights.png', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('148', '70', '', 'L2-Balto/1-5-not_knights-1.png', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('149', '70', '', 'L2-Balto/1-5-not_knights-2.png', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('150', '70', '', 'L2-Balto/1-5-not_knights-3.png', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('151', '76', '', 'L2-Balto/1-5-dog_1.png', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('152', '76', '', 'L2-Balto/1-5-dog_2.png', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('153', '76', '', 'L2-Balto/1-5-dog_3.png', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('154', '76', '', 'L2-Balto/1-5-dog_4.png', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('155', '88', 'Because it would kill the children and spread to other people in the town.', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('156', '88', 'Because it would kill the children and the people in the town would have no food.', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('157', '88', 'Because it would kill the children and the only doctor in the town.', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('158', '88', 'Because it would kill the children and Balto.', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('159', '89', 'Point Safety to Nome', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('160', '89', 'Bluff to Point Safety', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('161', '89', 'Bluff to Nome', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('162', '89', 'Nome to Point Safety', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('163', '90', 'He was stuck in the snowdrifts.', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('164', '90', 'He did not panic.', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('165', '90', 'He was pulling the sled.', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('166', '90', 'He helped dig them out.', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('167', '91', 'Because there was too much snow from the blizzard.', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('168', '91', 'Because the medicine was too heavy.', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('169', '91', 'Because Gunnar could not shout and tell him where to go.', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('170', '91', 'Because two of the other dogs died and could not pull the sled.', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('171', '92', 'They warmed their hands by the cozy fire.', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('172', '92', 'They had been running for a long time.', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('173', '92', 'They almost fell into a river.', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('174', '92', 'They ran through a blizzard.', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('175', '93', 'So that it would not freeze.', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('176', '93', 'To make it lighter for the sled dogs.', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('177', '93', 'So that he could carry it easier.', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('178', '93', 'To keep it on the sled and not fall-off.', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('179', '110', '', '', '1', '', '', 'L1-Firehouse/2-4-firehouse.png', 'firehouse', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('180', '110', '', '', '1', '', '', 'L1-Firehouse/2-4-fireman.png', 'fireman', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('181', '110', '', '', '1', '', '', 'L1-Firehouse/2-4-helmet.png', 'helmet', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('182', '111', 'I', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('183', '111', 'dress like', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('184', '111', 'a fireman.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('185', '112', '', '', '1', '', '', 'L1-Firehouse/2-4-boots.png', 'boots', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('186', '112', '', '', '1', '', '', 'L1-Firehouse/2-4-jacket.png', 'jacket', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('187', '112', '', '', '1', '', '', 'L1-Firehouse/2-4-helmet.png', 'helmet', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('188', '120', '', '', '1', '', '', 'L1-Firehouse/2-8-howl.png', 'howl', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('189', '120', '', '', '1', '', '', 'L1-Firehouse/2-8-fire_truck.png', 'fire truck', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('190', '120', '', '', '1', '', '', 'L1-Firehouse/2-8-pole.png', 'pole', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('191', '121', 'Joe', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('192', '121', 'slides down', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('193', '121', 'the pole.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('194', '122', '', '', '1', '', '', 'L1-Firehouse/2-8-slide_down.png', 'slide down', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('195', '122', '', '', '1', '', '', 'L1-Firehouse/2-8-check.png', 'check', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('196', '122', '', '', '1', '', '', 'L1-Firehouse/2-8-ladder.png', 'ladder', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('197', '132', '', '', '1', '', '', 'L1-Firehouse/2-12-siren.png', 'siren', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('198', '132', '', '', '1', '', '', 'L1-Firehouse/2-12-cover.png', 'cover', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('199', '132', '', '', '1', '', '', 'L1-Firehouse/2-12-smoke.png', 'smoke', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('200', '133', 'Joe', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('201', '133', 'checks', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('202', '133', 'the ladder.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('203', '134', '', '', '1', '', '', 'L1-Firehouse/2-12-stop.png', 'stop', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('204', '134', '', '', '1', '', '', 'L1-Firehouse/2-12-drop.png', 'drop', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('205', '134', '', '', '1', '', '', 'L1-Firehouse/2-12-roll.png', 'roll', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('206', '142', '', '', '1', '', '', 'L1-Firehouse/2-16-smile.png', 'smile', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('207', '142', '', '', '1', '', '', 'L1-Firehouse/2-16-surprise.png', 'surprise', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('208', '142', '', '', '1', '', '', 'L1-Firehouse/2-16-fire_alarm.png', 'fire alarm', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('209', '143', 'He', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('210', '143', 'reaches', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('211', '143', 'into', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('212', '143', 'his truck.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('213', '144', '', '', '1', '', '', 'L1-Firehouse/2-16-put_on.png', 'put on', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('214', '144', '', '', '1', '', '', 'L1-Firehouse/2-16-wave_good-bye.png', 'wave good-bye', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('215', '144', '', '', '1', '', '', 'L1-Firehouse/2-16-ready.png', 'ready', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('216', '145', 'Little Critter', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('217', '145', 'Pete the Cat', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('218', '145', 'Mercer Mayer', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('219', '145', 'Sparky', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('220', '146', 'Fireman Joe and Sparky', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('221', '146', 'Fireman Sam and Spotty', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('222', '146', 'Little Critter and Sparky', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('223', '146', 'Fireman Joe and Harry', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('224', '147', 'TRUE', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('225', '147', 'FALSE', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('226', '148', '', 'L1-Firehouse/2-1-critter.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('227', '148', '', 'L1-Firehouse/2-1-not_critter-1.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('228', '148', '', 'L1-Firehouse/2-1-not_critter-2.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('229', '148', '', 'L1-Firehouse/2-1-not_critter-3.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('230', '149', '', 'L1-Firehouse/2-6-firehouse.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('231', '149', '', 'L1-Firehouse/2-6-not_firehouse-1.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('232', '149', '', 'L1-Firehouse/2-6-not_firehouse-2.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('233', '149', '', 'L1-Firehouse/2-6-not_firehouse-3.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('234', '150', 'TRUE', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('235', '150', 'FALSE', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('236', '151', '', 'L1-Firehouse/2-10-sliding_down.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('237', '151', '', 'L1-Firehouse/2-10-not_sliding_down-1.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('238', '151', '', 'L1-Firehouse/2-10-not_sliding_down-2.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('239', '151', '', 'L1-Firehouse/2-10-not_sliding_down-3.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('240', '152', '', 'L1-Firehouse/2-10-sliding_down.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('241', '152', '', 'L1-Firehouse/2-10-not_sliding_down-1.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('242', '152', '', 'L1-Firehouse/2-10-not_sliding_down-2.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('243', '152', '', 'L1-Firehouse/2-10-not_sliding_down-3.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('244', '153', '1', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('245', '153', '2', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('246', '153', '3', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('247', '153', '4', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('248', '154', 'When smoke goes up, we must go up to the floor.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('249', '154', 'When smoke goes up, we must go down to the floor.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('250', '154', 'When smoke goes down, we must go up to the floor.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('251', '154', 'When smoke goes down, we must go down to the floor.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('252', '155', 'Rolling', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('253', '155', 'Stopping', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('254', '155', 'Dropping', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('255', '155', 'Eating', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('256', '156', 'h', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('257', '156', 'e', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('258', '156', 'l', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('259', '156', 'm', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('260', '156', 'e', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('261', '156', 't', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('262', '157', 'A good student', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('263', '157', 'A good singer', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('264', '157', 'A good teacher', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('265', '157', 'A good fireman', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('266', '158', 'Little Critter', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('267', '158', 'Mercer Mayer', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('268', '158', 'Fireman Joe', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('269', '158', 'Sparky the Dog', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('270', '159', 'The Author', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('271', '159', 'The Reader', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('272', '159', 'The Illustrator', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('273', '159', 'The Fireman', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('274', '160', 'To the zoo', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('275', '160', 'To the school', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('276', '160', 'To the library', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('277', '160', 'To the firehouse', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('278', '161', '', 'L1-Firehouse/2-5-not_firehouse-1.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('279', '161', '', 'L1-Firehouse/2-5-not_firehouse-2.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('280', '161', '', 'L1-Firehouse/2-5-firehouse.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('281', '161', '', 'L1-Firehouse/2-5-not_firehouse-3.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('282', '162', 'The firemen are eating lunch.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('283', '162', 'The firemen are going to the firehouse.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('284', '162', 'The firemen are fighting a fire.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('285', '162', 'The firemen are driving a truck.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('286', '163', 'They are using water.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('287', '163', 'They are using air.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('288', '163', 'They are using plants.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('289', '163', 'They are using trees.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('290', '164', '', 'L1-Firehouse/2-5-P6_7-teacher.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('291', '164', '', 'L1-Firehouse/2-5-P6_7-fireman.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('292', '164', '', 'L1-Firehouse/2-5-P6_7-tiger.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('293', '164', '', 'L1-Firehouse/2-5-P6_7-Little_Critter.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('294', '165', 'They\'re going to the park.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('295', '165', 'They\'re going to the firehouse.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('296', '165', 'They\'re going to the school.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('297', '165', 'They\'re going to the fire.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('302', '167', 'Fire dog', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('303', '167', 'Little Critter', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('304', '167', 'Fireman Joe', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('305', '167', 'Sparky', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('306', '168', 'Fireman Joe is in the forest.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('307', '168', 'Fireman Joe is in the mall.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('308', '168', 'Fireman Joe is in the fire truck.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('309', '168', 'Fireman Joe is in the firehouse.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('310', '169', 'Fireman Joe', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('311', '169', 'Sparky', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('312', '169', 'Little Critter', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('313', '169', 'All of these', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('318', '171', 'Firemen start fire.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('319', '171', 'Firemen fight fire.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('320', '171', 'Firemen eat fire.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('321', '171', 'Firemen drink fire.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('322', '172', 'He is a regular dog.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('323', '172', 'He is a regular cat.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('324', '172', 'He is a fire dog.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('325', '172', 'He is a fire cat.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('330', '174', 'He has a jacket.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('331', '174', 'He has all of these.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('332', '174', 'He has boots.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('333', '174', 'He has a helmet.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('334', '175', '', 'L1-Firehouse/2-5-pointing_at_boots.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('335', '175', '', 'L1-Firehouse/2-5-pointing_at_belt.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('336', '175', '', 'L1-Firehouse/2-5-pointing_at_jacket.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('337', '175', '', 'L1-Firehouse/2-5-pointing_at_helmet.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('338', '176', '', 'L1-Firehouse/2-5-pointing_at_boots.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('339', '176', '', 'L1-Firehouse/2-5-pointing_at_belt.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('340', '176', '', 'L1-Firehouse/2-5-pointing_at_jacket.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('341', '176', '', 'L1-Firehouse/2-5-pointing_at_helmet.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('342', '177', '', 'L1-Firehouse/2-5-pointing_at_boots.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('343', '177', '', 'L1-Firehouse/2-5-pointing_at_belt.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('344', '177', '', 'L1-Firehouse/2-5-pointing_at_jacket.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('345', '177', '', 'L1-Firehouse/2-5-pointing_at_helmet.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('346', '178', 'They are called fireman helmets.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('347', '178', 'They are called fireman boots.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('348', '178', 'They are called fireman jackets.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('349', '178', 'They are called fire dogs.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('350', '179', 'That is his fireman helmet.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('351', '179', 'That is his fireman jacket.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('352', '179', 'That is his fireman boot.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('353', '179', 'That is his fireman dog.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('354', '180', '', 'L1-Firehouse/2-5-pointing_at_boots.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('355', '180', '', 'L1-Firehouse/2-5-pointing_at_jacket.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('356', '180', '', 'L1-Firehouse/2-5-pointing_at_pole.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('357', '180', '', 'L1-Firehouse/2-5-pointing_at_helmet.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('358', '181', '', 'L1-Firehouse/2-5-pointing_at_boots.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('359', '181', '', 'L1-Firehouse/2-5-pointing_at_jacket.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('360', '181', '', 'L1-Firehouse/2-5-pointing_at_pole.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('361', '181', '', 'L1-Firehouse/2-5-pointing_at_helmet.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('362', '182', '', 'L1-Firehouse/2-5-pointing_at_boots.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('363', '182', '', 'L1-Firehouse/2-5-pointing_at_jacket.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('364', '182', '', 'L1-Firehouse/2-5-pointing_at_pole.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('365', '182', '', 'L1-Firehouse/2-5-pointing_at_helmet.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('370', '184', 'To protect firemen\'s heads from fire.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('371', '184', 'To protect firemen\'s feet from fire.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('372', '184', 'To protect firemen\'s hands from fire.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('373', '184', 'To protect firemen\'s arms from fire.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('374', '185', 'T, F, J, I', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('375', '185', 'T, f, J, I', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('376', '185', 'T, F, j, I', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('377', '185', 'T, F, J, i', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('378', '186', 'time to fight a fire.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('379', '186', 'he has a jacket.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('380', '186', 'fireman Joe has boots.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('381', '186', 'He has a helmet.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('382', '187', 'sparky', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('383', '187', 'fireman joe', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('384', '187', 'Joe', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('385', '187', 'critter', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('386', '188', 'i have a hat.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('387', '188', 'I have gloves.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('388', '188', 'What do I have?', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('389', '188', 'I have boots.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('390', '189', '', '', '1', '', '', 'L1-Firehouse/2-5-b.png', '', '', 'L1-Firehouse/2-5-B_big.png');
INSERT INTO `hi_conf_topic_answer` VALUES ('391', '189', '', '', '1', '', '', 'L1-Firehouse/2-5-m.png', '', '', 'L1-Firehouse/2-5-M_big.png');
INSERT INTO `hi_conf_topic_answer` VALUES ('392', '189', '', '', '1', '', '', 'L1-Firehouse/2-5-e.png', '', '', 'L1-Firehouse/2-5-E_big.png');
INSERT INTO `hi_conf_topic_answer` VALUES ('393', '189', '', '', '1', '', '', 'L1-Firehouse/2-5-r.png', '', '', 'L1-Firehouse/2-5-R_big.png');
INSERT INTO `hi_conf_topic_answer` VALUES ('394', '190', 'He jumps down the pole.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('395', '190', 'He climbs up the pole.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('396', '190', 'He holds up the pole.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('397', '190', 'He slides down the pole.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('398', '191', 'The children are sliding down the pole.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('399', '191', 'The children are sliding up the pole.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('400', '191', 'The children are sliding above the pole.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('401', '191', 'The children are sliding inside the pole.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('402', '192', 'A', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('403', '192', 'B', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('404', '192', 'C', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('405', '192', 'D', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('406', '193', 'To get to the fire faster.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('407', '193', 'To go home faster.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('408', '193', 'To go eat dinner faster.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('409', '193', 'To run faster.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('410', '194', 'He is in the firehouse.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('411', '194', 'He is in the forest.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('412', '194', 'He is in the fire truck.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('413', '194', 'He is in the pole.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('414', '195', 'Blue', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('415', '195', 'Black', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('416', '195', 'White', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('417', '195', 'Red', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('418', '196', '', 'L1-Firehouse/2-9-fire_truck-ladder.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('419', '196', '', 'L1-Firehouse/2-9-fire_trcuk-tyre.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('420', '196', '', 'L1-Firehouse/2-9-fire_truck-firemen.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('421', '196', '', 'L1-Firehouse/2-9-fire_truck-sirens.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('422', '197', '', 'L1-Firehouse/2-9-fire_trcuk-tyre.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('423', '197', '', 'L1-Firehouse/2-9-fire_truck-firemen.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('424', '197', '', 'L1-Firehouse/2-9-fire_truck-ladder.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('425', '197', '', 'L1-Firehouse/2-9-frie_truck-fire_dog.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('426', '198', '', 'L1-Firehouse/2-9-fire_truck-firemen.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('427', '198', '', 'L1-Firehouse/2-9-fire_truck-hose.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('428', '198', '', 'L1-Firehouse/2-9-frie_truck-fire_dog.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('429', '198', '', 'L1-Firehouse/2-9-fire_truck-sirens.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('430', '199', 'Hoses spray water.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('431', '199', 'Hoses spray air.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('432', '199', 'Hoses spray fire.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('433', '199', 'Hoses spray fuel.  ', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('434', '200', 'l', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('435', '200', 'a', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('436', '200', 'd', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('437', '200', 'd', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('438', '200', 'e', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('439', '200', 'r', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('440', '201', 'Little Critter and the Fire Dog', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('441', '201', 'The ladder and the hose', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('442', '201', 'Fireman Joe', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('443', '201', 'All of these', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('444', '202', 'They are driving the truck.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('445', '202', 'They are checking the hose.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('446', '202', 'They are walking in the firehouse.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('447', '202', 'They are sliding down the pole.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('448', '203', 'To put out the fire', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('449', '203', 'To see how long it is', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('450', '203', 'To make sure the hose works', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('451', '203', 'To slide down the pole', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('456', '205', 'We', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('457', '205', 'see a', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('458', '205', 'fire truck', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('459', '205', '.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('460', '206', 'Do you see', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('461', '206', 'a fire', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('462', '206', 'truck', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('463', '206', '?', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('464', '207', 'We see', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('465', '207', 'a big fire', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('466', '207', 'truck', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('467', '207', '!', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('468', '208', '', '', '1', '', '', 'L1-Firehouse/2-9-period-1.png', 'Period', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('469', '208', '', '', '1', '', '', 'L1-Firehouse/2-9-question_mark-1.png', 'Question Mark', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('470', '208', '', '', '1', '', '', 'L1-Firehouse/2-9-exclamation_mark-1.png', 'Exclamation Point', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('471', '209', 'Joe is using the fire hose.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('472', '209', 'Joe is driving the fire truck.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('473', '209', 'Joe is putting out a fire.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('474', '209', 'Joe is checking the ladder.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('475', '210', 'A', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('476', '210', 'B', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('477', '210', 'C', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('478', '210', 'D', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('479', '211', 'He is using the fire to fight the fire.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('480', '211', 'He is using the hose to fight the fire.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('481', '211', 'He is using the hose to fight the water.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('482', '211', 'He is using the water to fight the hose.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('483', '212', 'He is carrying the ladder.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('484', '212', 'He is climbing up the ladder.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('485', '212', 'He is fighting the ladder.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('486', '212', 'He is lifting the ladder.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('487', '213', '', 'L1-Firehouse/2-13-make_noise-1.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('488', '213', '', 'L1-Firehouse/2-13-make_noise-2.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('489', '213', '', 'L1-Firehouse/2-13-make_noise-3.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('490', '213', '', 'L1-Firehouse/2-13-make_noise-4.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('495', '215', 'He is covering his head.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('496', '215', 'He is covering his ears.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('497', '215', 'He is covering his eyes.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('498', '215', 'He is covering his mouth.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('499', '216', 'When you hear a hose.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('500', '216', 'When you hear a mouse.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('501', '216', 'When you hear a ladder.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('502', '216', 'When you hear a siren.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('503', '217', 'Because the siren is very quiet.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('504', '217', 'Because the siren is very soft.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('505', '217', 'Because the siren is very off.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('506', '217', 'Because the siren is very loud.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('511', '219', 'She is running away from the smoke.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('512', '219', 'She is running away from the water.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('513', '219', 'She is running away from the fireman.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('514', '219', 'She is running away from the ladder.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('515', '220', 'Run away from the smoke.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('516', '220', 'Run towards the smoke.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('517', '220', 'Run into the smoke.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('518', '220', 'Run to the smoke. ', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('523', '222', 'He is crawling on the house.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('524', '222', 'He is crawling on the bed.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('525', '222', 'He is crawling on the fire.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('526', '222', 'He is crawling on the floor.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('527', '223', '', '', '1', '', '', 'L1-Firehouse/2-13-stop.png', 'Stop', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('528', '223', '', '', '1', '', '', 'L1-Firehouse/2-13-drop.png', 'Drop', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('529', '223', '', '', '1', '', '', 'L1-Firehouse/2-13-roll.png', 'Roll', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('530', '224', 'The house is fine.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('531', '224', 'The house is old.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('532', '224', 'The house is on fire.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('533', '224', 'The house is on water.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('534', '225', 'A', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('535', '225', 'B', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('536', '225', 'C', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('537', '225', 'D', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('538', '226', 'Joe', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('539', '226', 'checks', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('540', '226', 'the', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('541', '226', 'siren', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('542', '227', 'ears', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('543', '227', 'my', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('544', '227', 'cover', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('545', '227', 'I', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('550', '229', 'Trucks for everyone', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('551', '229', 'Helmets for everyone', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('552', '229', 'Hats for everyone', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('553', '229', 'Jackets for everyone', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('558', '231', 'A', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('559', '231', 'B', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('560', '231', 'C', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('561', '231', 'D', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('562', '232', 'He is putting on his boots.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('563', '232', 'He is putting on his helmet.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('564', '232', 'He is putting on his jacket.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('565', '232', 'He is putting on his belt.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('566', '233', 'His coat is red.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('567', '233', 'His coat is yellow.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('568', '233', 'His coat is blue.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('569', '233', 'His coat is black.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('570', '234', 'It\'s the number 1.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('571', '234', 'It\'s the number 10.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('572', '234', 'It\'s the number 11.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('573', '234', 'It\'s the number 01.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('574', '235', 'It\'s the number twelve-three.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('575', '235', 'It\'s the number twenty.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('576', '235', 'It\'s the number twenty-two.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('577', '235', 'It\'s the number twenty-three.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('578', '236', 'He is holding a fire helmet.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('579', '236', 'He is holding a fire hose.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('580', '236', 'He is holding a fire jacket.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('581', '236', 'He is holding fire boots.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('582', '237', 'She is waving good-bye.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('583', '237', 'She is weaving good-bye.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('584', '237', 'He is waving good-bye.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('585', '237', 'He is weaving good-bye.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('586', '238', 'He is ready to go home.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('587', '238', 'He is ready to go fishing.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('588', '238', 'He is ready to fight a fire.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('589', '238', 'He is ready to go swimming.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('590', '239', 'She is ready to fight a fire.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('591', '239', 'She is ready to go to school.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('592', '239', 'She is ready to go skiing.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('593', '239', 'She is ready to go to the beach.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('594', '240', '', '', '1', '', '', 'L1-Firehouse/2-17-119.png', 'China ', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('595', '240', '', '', '1', '', '', 'L1-Firehouse/2-17-911.png', 'USA', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('596', '241', 'May fifth', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('597', '241', 'May five', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('598', '241', 'May four', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('599', '241', 'May fourth', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('600', '242', 'One ', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('601', '242', 'Two', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('602', '242', 'Many', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('603', '242', 'Few', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('604', '243', 'It is a hose.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('605', '243', 'It is a ladder.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('606', '243', 'It is a helmet.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('607', '243', 'It is a jacket.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('608', '244', '', '', '1', '', '', 'L1-Firehouse/2-17-one-cat.png', 'One cat', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('609', '244', '', '', '1', '', '', 'L1-Firehouse/2-17-two-cats.png', 'Two cats', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('610', '244', '', '', '1', '', '', 'L1-Firehouse/2-17-eight-cats.png', 'Eight cats', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('611', '245', 'To get to the fire faster.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('612', '245', 'To go home faster.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('613', '245', 'To go eat dinner faster.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('614', '245', 'To run faster.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('615', '246', 'A', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('616', '246', 'B', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('617', '246', 'C', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('618', '246', 'D', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('619', '247', 'Trucks for everyone', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('620', '247', 'Helmets for everyone', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('621', '247', 'Hats for everyone', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('622', '247', 'Jackets for everyone', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('623', '248', 'He is holding a fire helmet.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('624', '248', 'He is holding a fire hose.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('625', '248', 'He is holding a fire jacket.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('626', '248', 'He is holding fire boots.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('627', '249', '', '', '1', '', '', 'L1-Firehouse/2-12-siren.png', 'siren', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('628', '249', '', '', '1', '', '', 'L1-Firehouse/2-12-cover.png', 'cover', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('629', '249', '', '', '1', '', '', 'L1-Firehouse/2-12-smoke.png', 'smoke', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('630', '250', 'Tweet! Tweet!', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('631', '250', 'Bomp! Bomp!', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('632', '250', 'Ooo! Eee! Ooo!', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('633', '250', 'Honk Honk!', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('634', '251', 'jump, sing, and dance', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('635', '251', 'stop, drop, and roll', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('636', '251', 'stand still', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('637', '251', 'laugh', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('638', '252', 'I', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('639', '252', 'put on', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('640', '252', 'my helmet', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('641', '252', '.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('642', '253', 'Little Critter', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('643', '253', 'Mercer Mayer', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('644', '253', 'Fireman Joe', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('645', '253', 'Sparky the Dog', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('646', '254', 'Sparky is a', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('647', '254', 'fire', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('648', '254', 'dog', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('649', '254', '.', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('650', '255', '', 'L1-Firehouse/2-9-fire_truck-firemen.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('651', '255', '', 'L1-Firehouse/2-9-fire_truck-hose.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('652', '255', '', 'L1-Firehouse/2-9-frie_truck-fire_dog.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('653', '255', '', 'L1-Firehouse/2-9-fire_truck-sirens.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('654', '256', '', '', '1', '', '', 'L1-Firehouse/2-9-period-1.png', 'Period', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('655', '256', '', '', '1', '', '', 'L1-Firehouse/2-9-question_mark-1.png', 'Question Mark', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('656', '256', '', '', '1', '', '', 'L1-Firehouse/2-9-exclamation_mark-1.png', 'Exclamation Point', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('657', '257', 'TRUE', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('658', '257', 'FALSE', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('659', '258', '', '', '1', '', '', 'L1-Firehouse/2-4-boots.png', 'boots', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('660', '258', '', '', '1', '', '', 'L1-Firehouse/2-4-jacket.png', 'jacket', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('661', '258', '', '', '1', '', '', 'L1-Firehouse/2-4-helmet.png', 'helmet', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('662', '258', '', '', '1', '', '', 'L1-Firehouse/2-12-stop.png', 'stop', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('663', '258', '', '', '1', '', '', 'L1-Firehouse/2-12-drop.png', 'drop', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('664', '258', '', '', '1', '', '', 'L1-Firehouse/2-12-roll.png', 'roll', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('665', '259', 'F', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('666', '259', 'i', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('667', '259', 'r', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('668', '259', 'e', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('669', '259', 'h', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('670', '259', 'o', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('671', '259', 'u', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('672', '259', 's', '', '0', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('673', '259', 'e', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('674', '260', '3', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('675', '260', '10', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('676', '260', '15', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('677', '260', 'more than 16', '', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('678', '261', '', 'L1-Firehouse/2-5-1-3-1.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('679', '261', '', 'L1-Firehouse/2-5-1-3-2.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('680', '261', '', 'L1-Firehouse/2-5-1-3-3.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('681', '261', '', 'L1-Firehouse/2-5-1-3-4.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('682', '262', '', 'L1-Firehouse/2-9-2-3-1.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('683', '262', '', 'L1-Firehouse/2-9-2-3-2.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('684', '262', '', 'L1-Firehouse/2-9-2-3-3.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('685', '262', '', 'L1-Firehouse/2-9-2-3-4.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('686', '263', '', 'L1-Firehouse/2-13-3-3-1.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('687', '263', '', 'L1-Firehouse/2-13-3-3-2.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('688', '263', '', 'L1-Firehouse/2-13-3-3-3.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('689', '263', '', 'L1-Firehouse/2-13-3-3-4.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('690', '264', '', 'L1-Firehouse/2-17-4-3-1.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('691', '264', '', 'L1-Firehouse/2-17-4-3-2.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('692', '264', '', 'L1-Firehouse/2-17-4-3-3.png', '1', '', '', '', '', '', '');
INSERT INTO `hi_conf_topic_answer` VALUES ('693', '264', '', 'L1-Firehouse/2-17-4-3-4.png', '1', '', '', '', '', '', '');

-- ----------------------------
-- Table structure for hi_conf_unit
-- ----------------------------
DROP TABLE IF EXISTS `hi_conf_unit`;
CREATE TABLE `hi_conf_unit` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `CourseId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '课程ID',
  `Name` varchar(50) NOT NULL DEFAULT '' COMMENT '单元名称',
  `Type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '单元类型',
  PRIMARY KEY (`ID`),
  KEY `CT` (`CourseId`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='课程单元表';

-- ----------------------------
-- Records of hi_conf_unit
-- ----------------------------
INSERT INTO `hi_conf_unit` VALUES ('1', '1', '课前热身 Warm up', '0');
INSERT INTO `hi_conf_unit` VALUES ('2', '1', '第1单元 Unit 1', '0');
INSERT INTO `hi_conf_unit` VALUES ('3', '1', '第2单元 Unit 2', '0');
INSERT INTO `hi_conf_unit` VALUES ('4', '1', '第3单元 Unit 3', '0');
INSERT INTO `hi_conf_unit` VALUES ('5', '1', '第4单元 Unit 4', '0');
INSERT INTO `hi_conf_unit` VALUES ('6', '1', '第5单元 Unit 5', '0');
INSERT INTO `hi_conf_unit` VALUES ('7', '1', '第6单元 Unit 6', '0');
INSERT INTO `hi_conf_unit` VALUES ('8', '1', '结业测试', '0');
INSERT INTO `hi_conf_unit` VALUES ('9', '2', '课前热身 Warm up', '0');
INSERT INTO `hi_conf_unit` VALUES ('10', '2', '第1单元 Unit 1', '0');
INSERT INTO `hi_conf_unit` VALUES ('11', '2', '第2单元 Unit 2', '0');
INSERT INTO `hi_conf_unit` VALUES ('12', '2', '第3单元 Unit 3', '0');
INSERT INTO `hi_conf_unit` VALUES ('13', '2', '第4单元 Unit 4', '0');
INSERT INTO `hi_conf_unit` VALUES ('14', '2', '结业测试', '0');

-- ----------------------------
-- Table structure for hi_user_0
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_0`;
CREATE TABLE `hi_user_0` (
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '玩家ID',
  `UserName` varchar(50) NOT NULL DEFAULT '' COMMENT '用户名',
  `MUserName` char(32) NOT NULL DEFAULT '' COMMENT 'MD5后的用户名',
  `Password` char(32) NOT NULL DEFAULT '' COMMENT '用户密码',
  `Mobile` char(11) NOT NULL DEFAULT '' COMMENT '绑定手机号',
  `Type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '用户类型(1:普通用户2:微信用户)',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `UnionId` char(50) NOT NULL DEFAULT '' COMMENT '微信用户统一标识',
  `MUnionId` char(32) NOT NULL DEFAULT '' COMMENT 'MD5后的微信用户统一标识',
  `AccessToken` varchar(200) NOT NULL DEFAULT '' COMMENT '微信token',
  `ExpireTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '过期时间',
  `RefreshToken` varchar(200) NOT NULL DEFAULT '' COMMENT '微信刷新用token',
  `SuggesterMobile` varchar(20) NOT NULL DEFAULT '' COMMENT '推荐人手机号',
  `isMerge` tinyint(1) DEFAULT '0' COMMENT '是否合并，1：是，0：否',
  PRIMARY KEY (`Uid`),
  UNIQUE KEY `MUserName` (`MUserName`) USING BTREE,
  KEY `MUionID` (`MUnionId`) USING BTREE,
  KEY `isMerge` (`isMerge`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of hi_user_0
-- ----------------------------
INSERT INTO `hi_user_0` VALUES ('17', '18602194166', '00fd34e4428aed590b0e74f3db56c9ca', '1adbb3178591fd5bb0c248518f39bf6d', '', '1', '1514706758', '', '', '', '0', '', '', '1');
INSERT INTO `hi_user_0` VALUES ('100', 'test', '098f6bcd4621d373cade4e832627b4f6', 'e10adc3949ba59abbe56e057f20f883e', '', '1', '1515080280', '', '', '', '0', '', '', '1');

-- ----------------------------
-- Table structure for hi_user_1
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_1`;
CREATE TABLE `hi_user_1` (
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '玩家ID',
  `UserName` varchar(50) NOT NULL DEFAULT '' COMMENT '用户名',
  `MUserName` char(32) NOT NULL DEFAULT '' COMMENT 'MD5后的用户名',
  `Password` char(32) NOT NULL DEFAULT '' COMMENT '用户密码',
  `Mobile` char(11) NOT NULL DEFAULT '' COMMENT '绑定手机号',
  `Type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '用户类型(1:普通用户2:微信用户)',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `UnionId` char(50) NOT NULL DEFAULT '' COMMENT '微信用户统一标识',
  `MUnionId` char(32) NOT NULL DEFAULT '' COMMENT 'MD5后的微信用户统一标识',
  `AccessToken` varchar(200) NOT NULL DEFAULT '' COMMENT '微信token',
  `ExpireTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '过期时间',
  `RefreshToken` varchar(200) NOT NULL DEFAULT '' COMMENT '微信刷新用token',
  `SuggesterMobile` varchar(20) NOT NULL DEFAULT '' COMMENT '推荐人手机号',
  `isMerge` tinyint(1) DEFAULT '0' COMMENT '是否合并，1：是，0：否',
  PRIMARY KEY (`Uid`),
  UNIQUE KEY `MUserName` (`MUserName`) USING BTREE,
  KEY `MUionID` (`MUnionId`) USING BTREE,
  KEY `isMerge` (`isMerge`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of hi_user_1
-- ----------------------------
INSERT INTO `hi_user_1` VALUES ('33', '13911202075', '17e51f364a49a6b8903f5f58d8db6404', '350d00d9aa3a23f4049389b8216b11ea', '', '1', '1514947575', '', '', '', '0', '', '', '1');

-- ----------------------------
-- Table structure for hi_user_2
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_2`;
CREATE TABLE `hi_user_2` (
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '玩家ID',
  `UserName` varchar(50) NOT NULL DEFAULT '' COMMENT '用户名',
  `MUserName` char(32) NOT NULL DEFAULT '' COMMENT 'MD5后的用户名',
  `Password` char(32) NOT NULL DEFAULT '' COMMENT '用户密码',
  `Mobile` char(11) NOT NULL DEFAULT '' COMMENT '绑定手机号',
  `Type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '用户类型(1:普通用户2:微信用户)',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `UnionId` char(50) NOT NULL DEFAULT '' COMMENT '微信用户统一标识',
  `MUnionId` char(32) NOT NULL DEFAULT '' COMMENT 'MD5后的微信用户统一标识',
  `AccessToken` varchar(200) NOT NULL DEFAULT '' COMMENT '微信token',
  `ExpireTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '过期时间',
  `RefreshToken` varchar(200) NOT NULL DEFAULT '' COMMENT '微信刷新用token',
  `SuggesterMobile` varchar(20) NOT NULL DEFAULT '' COMMENT '推荐人手机号',
  `isMerge` tinyint(1) DEFAULT '0' COMMENT '是否合并，1：是，0：否',
  PRIMARY KEY (`Uid`),
  UNIQUE KEY `MUserName` (`MUserName`) USING BTREE,
  KEY `MUionID` (`MUnionId`) USING BTREE,
  KEY `isMerge` (`isMerge`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of hi_user_2
-- ----------------------------
INSERT INTO `hi_user_2` VALUES ('41', '13886116706', '2f79f1faf4b4f043fa3a5eecb5e02201', 'df8c82081a51b212187d9b8259e7d07e', '', '1', '1514982667', '', '', '', '0', '', '13801393374', '1');

-- ----------------------------
-- Table structure for hi_user_3
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_3`;
CREATE TABLE `hi_user_3` (
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '玩家ID',
  `UserName` varchar(50) NOT NULL DEFAULT '' COMMENT '用户名',
  `MUserName` char(32) NOT NULL DEFAULT '' COMMENT 'MD5后的用户名',
  `Password` char(32) NOT NULL DEFAULT '' COMMENT '用户密码',
  `Mobile` char(11) NOT NULL DEFAULT '' COMMENT '绑定手机号',
  `Type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '用户类型(1:普通用户2:微信用户)',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `UnionId` char(50) NOT NULL DEFAULT '' COMMENT '微信用户统一标识',
  `MUnionId` char(32) NOT NULL DEFAULT '' COMMENT 'MD5后的微信用户统一标识',
  `AccessToken` varchar(200) NOT NULL DEFAULT '' COMMENT '微信token',
  `ExpireTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '过期时间',
  `RefreshToken` varchar(200) NOT NULL DEFAULT '' COMMENT '微信刷新用token',
  `SuggesterMobile` varchar(20) NOT NULL DEFAULT '' COMMENT '推荐人手机号',
  `isMerge` tinyint(1) DEFAULT '0' COMMENT '是否合并，1：是，0：否',
  PRIMARY KEY (`Uid`),
  UNIQUE KEY `MUserName` (`MUserName`) USING BTREE,
  KEY `MUionID` (`MUnionId`) USING BTREE,
  KEY `isMerge` (`isMerge`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of hi_user_3
-- ----------------------------
INSERT INTO `hi_user_3` VALUES ('0', 'oDmjFwiQYNQrJYpj4ASun38tW4BU', '36de60a2de8f8df0f3139dd6c9a50f18', 'e10adc3949ba59abbe56e057f20f883e', '', '2', '1514785382', 'onsul0q2xt4noG-zRwwj4zm9_8VI', '660bad1861b2d2d930740697ec4fcd6f', '5_CsORM0D3FZTX8uyaiSshqAQSjKy7TivnFfQujDmq16ZFNFolj-enZA4BXvb5vC9zNzoWh6RovlQTsMJx_pggwg', '1514792582', '5_nV4poaLhKN74sUJKNl-CLVdfIihfR6uO5YhXtjxR-TpbKubIo6ztOOcNpspNUKylnV9KLBTAoanmsMkr1e7MxQ', '', '1');
INSERT INTO `hi_user_3` VALUES ('3', '18616383125', '336480b933e6fe4d13958dfdd8978b82', '4297f44b13955235245b2497399d7a93', '', '1', '1515716370', '', '', '', '0', '', '', '1');
INSERT INTO `hi_user_3` VALUES ('30', '13581726271', '384ef3e5c6be857058552c6d594815c6', '941c04b135f1789393a38eb6e7cd5014', '', '1', '1514870858', '', '', '', '0', '', '', '1');
INSERT INTO `hi_user_3` VALUES ('39', '13552478006', '3299999bad58056388cef75f5bd3e94a', 'fd5c2765d0b3d08193374b3ca66a7850', '', '1', '1514973213', '', '', '', '0', '', '', '1');

-- ----------------------------
-- Table structure for hi_user_4
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_4`;
CREATE TABLE `hi_user_4` (
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '玩家ID',
  `UserName` varchar(50) NOT NULL DEFAULT '' COMMENT '用户名',
  `MUserName` char(32) NOT NULL DEFAULT '' COMMENT 'MD5后的用户名',
  `Password` char(32) NOT NULL DEFAULT '' COMMENT '用户密码',
  `Mobile` char(11) NOT NULL DEFAULT '' COMMENT '绑定手机号',
  `Type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '用户类型(1:普通用户2:微信用户)',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `UnionId` char(50) NOT NULL DEFAULT '' COMMENT '微信用户统一标识',
  `MUnionId` char(32) NOT NULL DEFAULT '' COMMENT 'MD5后的微信用户统一标识',
  `AccessToken` varchar(200) NOT NULL DEFAULT '' COMMENT '微信token',
  `ExpireTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '过期时间',
  `RefreshToken` varchar(200) NOT NULL DEFAULT '' COMMENT '微信刷新用token',
  `SuggesterMobile` varchar(20) NOT NULL DEFAULT '' COMMENT '推荐人手机号',
  `isMerge` tinyint(1) DEFAULT '0' COMMENT '是否合并，1：是，0：否',
  PRIMARY KEY (`Uid`),
  UNIQUE KEY `MUserName` (`MUserName`) USING BTREE,
  KEY `MUionID` (`MUnionId`) USING BTREE,
  KEY `isMerge` (`isMerge`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of hi_user_4
-- ----------------------------
INSERT INTO `hi_user_4` VALUES ('27', '15800947032', '420bf164bf3d73f4e4c6ac0b6561d211', '6ecca563633b358184656b0f636de58a', '', '1', '1514795563', '', '', '', '0', '', '', '1');

-- ----------------------------
-- Table structure for hi_user_5
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_5`;
CREATE TABLE `hi_user_5` (
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '玩家ID',
  `UserName` varchar(50) NOT NULL DEFAULT '' COMMENT '用户名',
  `MUserName` char(32) NOT NULL DEFAULT '' COMMENT 'MD5后的用户名',
  `Password` char(32) NOT NULL DEFAULT '' COMMENT '用户密码',
  `Mobile` char(11) NOT NULL DEFAULT '' COMMENT '绑定手机号',
  `Type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '用户类型(1:普通用户2:微信用户)',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `UnionId` char(50) NOT NULL DEFAULT '' COMMENT '微信用户统一标识',
  `MUnionId` char(32) NOT NULL DEFAULT '' COMMENT 'MD5后的微信用户统一标识',
  `AccessToken` varchar(200) NOT NULL DEFAULT '' COMMENT '微信token',
  `ExpireTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '过期时间',
  `RefreshToken` varchar(200) NOT NULL DEFAULT '' COMMENT '微信刷新用token',
  `SuggesterMobile` varchar(20) NOT NULL DEFAULT '' COMMENT '推荐人手机号',
  `isMerge` tinyint(1) DEFAULT '0' COMMENT '是否合并，1：是，0：否',
  PRIMARY KEY (`Uid`),
  UNIQUE KEY `MUserName` (`MUserName`) USING BTREE,
  KEY `MUionID` (`MUnionId`) USING BTREE,
  KEY `isMerge` (`isMerge`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of hi_user_5
-- ----------------------------
INSERT INTO `hi_user_5` VALUES ('24', '18616303369', '51a613dc619b425bad9f9376205d535e', '1adbb3178591fd5bb0c248518f39bf6d', '', '1', '1514728067', '', '', '', '0', '', '18602194166', '1');
INSERT INTO `hi_user_5` VALUES ('32', '17610000131', '5d2ed1b3313d6a3f6f3c4266a1ae069e', '391edf2e35856301bcd8bd3549451218', '', '1', '1514906498', '', '', '', '0', '', '', '1');
INSERT INTO `hi_user_5` VALUES ('44', '13311278399', '5fa288bd2b12575e1be606a1a40629ad', 'a0fe8b1de8a08b29a99fc398061bd113', '', '1', '1514985483', '', '', '', '0', '', '13801393374', '1');

-- ----------------------------
-- Table structure for hi_user_6
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_6`;
CREATE TABLE `hi_user_6` (
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '玩家ID',
  `UserName` varchar(50) NOT NULL DEFAULT '' COMMENT '用户名',
  `MUserName` char(32) NOT NULL DEFAULT '' COMMENT 'MD5后的用户名',
  `Password` char(32) NOT NULL DEFAULT '' COMMENT '用户密码',
  `Mobile` char(11) NOT NULL DEFAULT '' COMMENT '绑定手机号',
  `Type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '用户类型(1:普通用户2:微信用户)',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `UnionId` char(50) NOT NULL DEFAULT '' COMMENT '微信用户统一标识',
  `MUnionId` char(32) NOT NULL DEFAULT '' COMMENT 'MD5后的微信用户统一标识',
  `AccessToken` varchar(200) NOT NULL DEFAULT '' COMMENT '微信token',
  `ExpireTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '过期时间',
  `RefreshToken` varchar(200) NOT NULL DEFAULT '' COMMENT '微信刷新用token',
  `SuggesterMobile` varchar(20) NOT NULL DEFAULT '' COMMENT '推荐人手机号',
  `isMerge` tinyint(1) DEFAULT '0' COMMENT '是否合并，1：是，0：否',
  PRIMARY KEY (`Uid`),
  UNIQUE KEY `MUserName` (`MUserName`) USING BTREE,
  KEY `MUionID` (`MUnionId`) USING BTREE,
  KEY `isMerge` (`isMerge`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of hi_user_6
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_7
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_7`;
CREATE TABLE `hi_user_7` (
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '玩家ID',
  `UserName` varchar(50) NOT NULL DEFAULT '' COMMENT '用户名',
  `MUserName` char(32) NOT NULL DEFAULT '' COMMENT 'MD5后的用户名',
  `Password` char(32) NOT NULL DEFAULT '' COMMENT '用户密码',
  `Mobile` char(11) NOT NULL DEFAULT '' COMMENT '绑定手机号',
  `Type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '用户类型(1:普通用户2:微信用户)',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `UnionId` char(50) NOT NULL DEFAULT '' COMMENT '微信用户统一标识',
  `MUnionId` char(32) NOT NULL DEFAULT '' COMMENT 'MD5后的微信用户统一标识',
  `AccessToken` varchar(200) NOT NULL DEFAULT '' COMMENT '微信token',
  `ExpireTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '过期时间',
  `RefreshToken` varchar(200) NOT NULL DEFAULT '' COMMENT '微信刷新用token',
  `SuggesterMobile` varchar(20) NOT NULL DEFAULT '' COMMENT '推荐人手机号',
  `isMerge` tinyint(1) DEFAULT '0' COMMENT '是否合并，1：是，0：否',
  PRIMARY KEY (`Uid`),
  UNIQUE KEY `MUserName` (`MUserName`) USING BTREE,
  KEY `MUionID` (`MUnionId`) USING BTREE,
  KEY `isMerge` (`isMerge`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of hi_user_7
-- ----------------------------
INSERT INTO `hi_user_7` VALUES ('2', '17786373562', '79eba9ab464071b0e66b56eb40a8a0e8', '68053af2923e00204c3ca7c6a3150cf7', '', '1', '1515654147', '', '', '', '0', '', '', '1');
INSERT INTO `hi_user_7` VALUES ('43', '13886116703', '799ed5500abef1a5c5e2fa5558c83dd1', '45d8d8fa2da59ac776259957ddedcd5f', '', '1', '1514982930', '', '', '', '0', '', '13886116706', '1');

-- ----------------------------
-- Table structure for hi_user_8
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_8`;
CREATE TABLE `hi_user_8` (
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '玩家ID',
  `UserName` varchar(50) NOT NULL DEFAULT '' COMMENT '用户名',
  `MUserName` char(32) NOT NULL DEFAULT '' COMMENT 'MD5后的用户名',
  `Password` char(32) NOT NULL DEFAULT '' COMMENT '用户密码',
  `Mobile` char(11) NOT NULL DEFAULT '' COMMENT '绑定手机号',
  `Type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '用户类型(1:普通用户2:微信用户)',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `UnionId` char(50) NOT NULL DEFAULT '' COMMENT '微信用户统一标识',
  `MUnionId` char(32) NOT NULL DEFAULT '' COMMENT 'MD5后的微信用户统一标识',
  `AccessToken` varchar(200) NOT NULL DEFAULT '' COMMENT '微信token',
  `ExpireTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '过期时间',
  `RefreshToken` varchar(200) NOT NULL DEFAULT '' COMMENT '微信刷新用token',
  `SuggesterMobile` varchar(20) NOT NULL DEFAULT '' COMMENT '推荐人手机号',
  `isMerge` tinyint(1) DEFAULT '0' COMMENT '是否合并，1：是，0：否',
  PRIMARY KEY (`Uid`),
  UNIQUE KEY `MUserName` (`MUserName`) USING BTREE,
  KEY `MUionID` (`MUnionId`) USING BTREE,
  KEY `isMerge` (`isMerge`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of hi_user_8
-- ----------------------------
INSERT INTO `hi_user_8` VALUES ('0', 'oDmjFwp090qfNFusDSWPVnJjOBXw', '847dd26325b423288839312b849bf17b', 'e10adc3949ba59abbe56e057f20f883e', '', '2', '1515647398', 'onsul0uObSPJfeZd19IUxjpQPhRc', '1a75bc7ff897d3c71ef93a007b897c8d', '5_xzrixvAq6W6GhX_O9-Q5-XPO9FxXXZfzq6DqsaEtqWVNcQ2CHnGq-K6DRpefnI2Gg1cUtHJBETwGPyby4N54fA', '1515654598', '5_k2J9sZat3F_jp-OeKjmn6VR9fitTdbs7mnZxPN4_kita06o-BbVonOgWcJyX6SQbS6_AfF8sf2hIYv-v-f5LjQ', '', '1');
INSERT INTO `hi_user_8` VALUES ('23', '13774231021', '85ea2ede476385d5de29d0123cb35c30', 'e2ce364185eca67ef5d01a114c5beb3c', '', '1', '1514726563', '', '', '', '0', '', '', '1');
INSERT INTO `hi_user_8` VALUES ('25', '13661518625', '8d0776a42b5de7dd83dbdb32ede657f7', '3edb5aea1cfb2bce689e144711511a23', '', '1', '1514778552', '', '', '', '0', '', '', '1');
INSERT INTO `hi_user_8` VALUES ('28', '13817160282', '8252b130ffd001e000f170404e4591b5', '6a9a628c4c75e1081afad18d7e3e399b', '', '1', '1514799796', '', '', '', '0', '', '', '1');
INSERT INTO `hi_user_8` VALUES ('29', '15021381478', '8d722b387ea5110f739c84934227ac56', '8d722b387ea5110f739c84934227ac56', '', '1', '1514808309', '', '', '', '0', '', '', '1');
INSERT INTO `hi_user_8` VALUES ('45', '13910281761', '8c813cc6d9d5ca8af61b5086d1813a02', 'cee632363e3e0b7aa82765f2f06bf57c', '', '1', '1514989163', '', '', '', '0', '', '', '1');

-- ----------------------------
-- Table structure for hi_user_9
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_9`;
CREATE TABLE `hi_user_9` (
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '玩家ID',
  `UserName` varchar(50) NOT NULL DEFAULT '' COMMENT '用户名',
  `MUserName` char(32) NOT NULL DEFAULT '' COMMENT 'MD5后的用户名',
  `Password` char(32) NOT NULL DEFAULT '' COMMENT '用户密码',
  `Mobile` char(11) NOT NULL DEFAULT '' COMMENT '绑定手机号',
  `Type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '用户类型(1:普通用户2:微信用户)',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `UnionId` char(50) NOT NULL DEFAULT '' COMMENT '微信用户统一标识',
  `MUnionId` char(32) NOT NULL DEFAULT '' COMMENT 'MD5后的微信用户统一标识',
  `AccessToken` varchar(200) NOT NULL DEFAULT '' COMMENT '微信token',
  `ExpireTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '过期时间',
  `RefreshToken` varchar(200) NOT NULL DEFAULT '' COMMENT '微信刷新用token',
  `SuggesterMobile` varchar(20) NOT NULL DEFAULT '' COMMENT '推荐人手机号',
  `isMerge` tinyint(1) DEFAULT '0' COMMENT '是否合并，1：是，0：否',
  PRIMARY KEY (`Uid`),
  UNIQUE KEY `MUserName` (`MUserName`) USING BTREE,
  KEY `MUionID` (`MUnionId`) USING BTREE,
  KEY `isMerge` (`isMerge`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of hi_user_9
-- ----------------------------
INSERT INTO `hi_user_9` VALUES ('18', '13917079163', '9d0cfe9dca2adb9b5d7da1b7ab0336de', '49a01870f4852e12be7252f6382b15af', '', '1', '1514707230', '', '', '', '0', '', '', '1');
INSERT INTO `hi_user_9` VALUES ('34', '13807191916', '9a8c2a02ea1fa6d0b9663f98cac66ac0', '4f438cd191684e745add27fa9410a440', '', '1', '1514948489', '', '', '', '0', '', '', '1');
INSERT INTO `hi_user_9` VALUES ('42', '18612615967', '936ae6400cb1728a47f4d6a2d71f340e', '01b8634f7f4cdf6c3a91ce7009e4cb13', '', '1', '1514982723', '', '', '', '0', '', '', '1');

-- ----------------------------
-- Table structure for hi_user_a
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_a`;
CREATE TABLE `hi_user_a` (
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '玩家ID',
  `UserName` varchar(50) NOT NULL DEFAULT '' COMMENT '用户名',
  `MUserName` char(32) NOT NULL DEFAULT '' COMMENT 'MD5后的用户名',
  `Password` char(32) NOT NULL DEFAULT '' COMMENT '用户密码',
  `Mobile` char(11) NOT NULL DEFAULT '' COMMENT '绑定手机号',
  `Type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '用户类型(1:普通用户2:微信用户)',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `UnionId` char(50) NOT NULL DEFAULT '' COMMENT '微信用户统一标识',
  `MUnionId` char(32) NOT NULL DEFAULT '' COMMENT 'MD5后的微信用户统一标识',
  `AccessToken` varchar(200) NOT NULL DEFAULT '' COMMENT '微信token',
  `ExpireTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '过期时间',
  `RefreshToken` varchar(200) NOT NULL DEFAULT '' COMMENT '微信刷新用token',
  `SuggesterMobile` varchar(20) NOT NULL DEFAULT '' COMMENT '推荐人手机号',
  `isMerge` tinyint(1) DEFAULT '0' COMMENT '是否合并，1：是，0：否',
  PRIMARY KEY (`Uid`),
  UNIQUE KEY `MUserName` (`MUserName`) USING BTREE,
  KEY `MUionID` (`MUnionId`) USING BTREE,
  KEY `isMerge` (`isMerge`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of hi_user_a
-- ----------------------------
INSERT INTO `hi_user_a` VALUES ('36', '18971255721', 'a491dce4e269b8b435a73d8ab65c25fe', '158d3dda16f41c1bc2b830cafdd3bd85', '', '1', '1514950129', '', '', '', '0', '', '', '1');
INSERT INTO `hi_user_a` VALUES ('37', '13911214101', 'ad932fd89e852a61c05c46b2b4cfbd2c', '44a020f1d97d46b3e1f98340820fa1dd', '', '1', '1514951396', '', '', '', '0', '', '13801393374', '1');

-- ----------------------------
-- Table structure for hi_user_address_0
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_address_0`;
CREATE TABLE `hi_user_address_0` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Name` varchar(180) NOT NULL DEFAULT '' COMMENT '收货人姓名',
  `Mobile` varchar(12) NOT NULL DEFAULT '' COMMENT '手机号码',
  `ProvinceId` int(5) unsigned NOT NULL DEFAULT '0' COMMENT '省',
  `CityId` int(5) unsigned NOT NULL DEFAULT '0' COMMENT '市',
  `AreaId` int(5) unsigned NOT NULL DEFAULT '0' COMMENT '地区',
  `Province` varchar(30) NOT NULL DEFAULT '' COMMENT '省份名称',
  `City` varchar(30) NOT NULL DEFAULT '' COMMENT '城市名称',
  `Area` varchar(30) NOT NULL DEFAULT '' COMMENT '地区名称',
  `Address` varchar(200) NOT NULL DEFAULT '' COMMENT '收货地址',
  `Default` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否是默认地址（0：不是1：是）',
  PRIMARY KEY (`ID`),
  KEY `UD` (`Uid`,`Default`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hi_user_address_0
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_address_1
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_address_1`;
CREATE TABLE `hi_user_address_1` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Name` varchar(180) NOT NULL DEFAULT '' COMMENT '收货人姓名',
  `Mobile` varchar(12) NOT NULL DEFAULT '' COMMENT '手机号码',
  `ProvinceId` int(5) unsigned NOT NULL DEFAULT '0' COMMENT '省',
  `CityId` int(5) unsigned NOT NULL DEFAULT '0' COMMENT '市',
  `AreaId` int(5) unsigned NOT NULL DEFAULT '0' COMMENT '地区',
  `Province` varchar(30) NOT NULL DEFAULT '' COMMENT '省份名称',
  `City` varchar(30) NOT NULL DEFAULT '' COMMENT '城市名称',
  `Area` varchar(30) NOT NULL DEFAULT '' COMMENT '地区名称',
  `Address` varchar(200) NOT NULL DEFAULT '' COMMENT '收货地址',
  `Default` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否是默认地址（0：不是1：是）',
  PRIMARY KEY (`ID`),
  KEY `UD` (`Uid`,`Default`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hi_user_address_1
-- ----------------------------
INSERT INTO `hi_user_address_1` VALUES ('1', '31', '朱德华', '13129912880', '420000', '420100', '420102', '湖北省', '武汉市', '江岸区', '兴业路日月星城小区1栋一单元1003', '0');
INSERT INTO `hi_user_address_1` VALUES ('2', '1', '元元', '13774231021', '310000', '310100', '310105', '上海市', '市辖区', '长宁区', '江苏路111弄', '1');

-- ----------------------------
-- Table structure for hi_user_address_2
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_address_2`;
CREATE TABLE `hi_user_address_2` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Name` varchar(180) NOT NULL DEFAULT '' COMMENT '收货人姓名',
  `Mobile` varchar(12) NOT NULL DEFAULT '' COMMENT '手机号码',
  `ProvinceId` int(5) unsigned NOT NULL DEFAULT '0' COMMENT '省',
  `CityId` int(5) unsigned NOT NULL DEFAULT '0' COMMENT '市',
  `AreaId` int(5) unsigned NOT NULL DEFAULT '0' COMMENT '地区',
  `Province` varchar(30) NOT NULL DEFAULT '' COMMENT '省份名称',
  `City` varchar(30) NOT NULL DEFAULT '' COMMENT '城市名称',
  `Area` varchar(30) NOT NULL DEFAULT '' COMMENT '地区名称',
  `Address` varchar(200) NOT NULL DEFAULT '' COMMENT '收货地址',
  `Default` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否是默认地址（0：不是1：是）',
  PRIMARY KEY (`ID`),
  KEY `UD` (`Uid`,`Default`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hi_user_address_2
-- ----------------------------
INSERT INTO `hi_user_address_2` VALUES ('1', '22', 'asdf', '13526378716', '110000', '110100', '110102', '北京市', '市辖区', '西城区', 'asdf', '0');
INSERT INTO `hi_user_address_2` VALUES ('2', '32', '西西', '17610000131', '110000', '110100', '110105', '北京市', '市辖区', '朝阳区', '西大望路28号', '0');
INSERT INTO `hi_user_address_2` VALUES ('3', '42', '李俊燕', '18612615967', '110000', '110100', '110105', '北京市', '市辖区', '朝阳区', '朝阳管庄万象新天2区220楼2单元201', '0');
INSERT INTO `hi_user_address_2` VALUES ('4', '2', '徐芳', '17786373562', '420000', '420100', '420102', '湖北省', '武汉市', '江岸区', '兴业路日月星城1-1-1003', '1');

-- ----------------------------
-- Table structure for hi_user_address_3
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_address_3`;
CREATE TABLE `hi_user_address_3` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Name` varchar(180) NOT NULL DEFAULT '' COMMENT '收货人姓名',
  `Mobile` varchar(12) NOT NULL DEFAULT '' COMMENT '手机号码',
  `ProvinceId` int(5) unsigned NOT NULL DEFAULT '0' COMMENT '省',
  `CityId` int(5) unsigned NOT NULL DEFAULT '0' COMMENT '市',
  `AreaId` int(5) unsigned NOT NULL DEFAULT '0' COMMENT '地区',
  `Province` varchar(30) NOT NULL DEFAULT '' COMMENT '省份名称',
  `City` varchar(30) NOT NULL DEFAULT '' COMMENT '城市名称',
  `Area` varchar(30) NOT NULL DEFAULT '' COMMENT '地区名称',
  `Address` varchar(200) NOT NULL DEFAULT '' COMMENT '收货地址',
  `Default` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否是默认地址（0：不是1：是）',
  PRIMARY KEY (`ID`),
  KEY `UD` (`Uid`,`Default`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hi_user_address_3
-- ----------------------------
INSERT INTO `hi_user_address_3` VALUES ('1', '23', '元元', '13774231021', '310000', '310100', '310105', '上海市', '市辖区', '长宁区', '江苏路', '1');

-- ----------------------------
-- Table structure for hi_user_address_4
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_address_4`;
CREATE TABLE `hi_user_address_4` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Name` varchar(180) NOT NULL DEFAULT '' COMMENT '收货人姓名',
  `Mobile` varchar(12) NOT NULL DEFAULT '' COMMENT '手机号码',
  `ProvinceId` int(5) unsigned NOT NULL DEFAULT '0' COMMENT '省',
  `CityId` int(5) unsigned NOT NULL DEFAULT '0' COMMENT '市',
  `AreaId` int(5) unsigned NOT NULL DEFAULT '0' COMMENT '地区',
  `Province` varchar(30) NOT NULL DEFAULT '' COMMENT '省份名称',
  `City` varchar(30) NOT NULL DEFAULT '' COMMENT '城市名称',
  `Area` varchar(30) NOT NULL DEFAULT '' COMMENT '地区名称',
  `Address` varchar(200) NOT NULL DEFAULT '' COMMENT '收货地址',
  `Default` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否是默认地址（0：不是1：是）',
  PRIMARY KEY (`ID`),
  KEY `UD` (`Uid`,`Default`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hi_user_address_4
-- ----------------------------
INSERT INTO `hi_user_address_4` VALUES ('1', '34', '沈丹', '13807191916', '420000', '420100', '420102', '湖北省', '武汉市', '江岸区', '香江花园二期四栋三单元801', '1');

-- ----------------------------
-- Table structure for hi_user_address_5
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_address_5`;
CREATE TABLE `hi_user_address_5` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Name` varchar(180) NOT NULL DEFAULT '' COMMENT '收货人姓名',
  `Mobile` varchar(12) NOT NULL DEFAULT '' COMMENT '手机号码',
  `ProvinceId` int(5) unsigned NOT NULL DEFAULT '0' COMMENT '省',
  `CityId` int(5) unsigned NOT NULL DEFAULT '0' COMMENT '市',
  `AreaId` int(5) unsigned NOT NULL DEFAULT '0' COMMENT '地区',
  `Province` varchar(30) NOT NULL DEFAULT '' COMMENT '省份名称',
  `City` varchar(30) NOT NULL DEFAULT '' COMMENT '城市名称',
  `Area` varchar(30) NOT NULL DEFAULT '' COMMENT '地区名称',
  `Address` varchar(200) NOT NULL DEFAULT '' COMMENT '收货地址',
  `Default` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否是默认地址（0：不是1：是）',
  PRIMARY KEY (`ID`),
  KEY `UD` (`Uid`,`Default`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hi_user_address_5
-- ----------------------------
INSERT INTO `hi_user_address_5` VALUES ('1', '35', '刘', '13910275079', '110000', '110100', '110105', '北京市', '市辖区', '朝阳区', '望京东园融科橄榄城2-2-1601', '0');
INSERT INTO `hi_user_address_5` VALUES ('2', '25', '张淼', '13661518625', '310000', '310100', '310114', '上海市', '市辖区', '嘉定区', '南翔镇德园路1509弄21号604室（祥和雅苑西区）', '0');
INSERT INTO `hi_user_address_5` VALUES ('3', '45', '闫喆', '13910281761', '110000', '110100', '110101', '北京市', '市辖区', '东城区', '西花市南里东区9-6-401', '1');

-- ----------------------------
-- Table structure for hi_user_address_6
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_address_6`;
CREATE TABLE `hi_user_address_6` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Name` varchar(180) NOT NULL DEFAULT '' COMMENT '收货人姓名',
  `Mobile` varchar(12) NOT NULL DEFAULT '' COMMENT '手机号码',
  `ProvinceId` int(5) unsigned NOT NULL DEFAULT '0' COMMENT '省',
  `CityId` int(5) unsigned NOT NULL DEFAULT '0' COMMENT '市',
  `AreaId` int(5) unsigned NOT NULL DEFAULT '0' COMMENT '地区',
  `Province` varchar(30) NOT NULL DEFAULT '' COMMENT '省份名称',
  `City` varchar(30) NOT NULL DEFAULT '' COMMENT '城市名称',
  `Area` varchar(30) NOT NULL DEFAULT '' COMMENT '地区名称',
  `Address` varchar(200) NOT NULL DEFAULT '' COMMENT '收货地址',
  `Default` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否是默认地址（0：不是1：是）',
  PRIMARY KEY (`ID`),
  KEY `UD` (`Uid`,`Default`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hi_user_address_6
-- ----------------------------
INSERT INTO `hi_user_address_6` VALUES ('1', '16', '元元', '13774231021', '310000', '310100', '310105', '上海市', '市辖区', '长宁区', '江苏北路111弄29号', '0');
INSERT INTO `hi_user_address_6` VALUES ('2', '26', '袁蓓', '13701684046', '310000', '310100', '310105', '上海市', '市辖区', '长宁区', '定西路432号新华名苑办公楼306室', '0');
INSERT INTO `hi_user_address_6` VALUES ('3', '36', '付婷', '18971255721', '420000', '420100', '420102', '湖北省', '武汉市', '江岸区', '胜利街六合路外滩棕榈泉7栋2703室', '1');

-- ----------------------------
-- Table structure for hi_user_address_7
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_address_7`;
CREATE TABLE `hi_user_address_7` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Name` varchar(180) NOT NULL DEFAULT '' COMMENT '收货人姓名',
  `Mobile` varchar(12) NOT NULL DEFAULT '' COMMENT '手机号码',
  `ProvinceId` int(5) unsigned NOT NULL DEFAULT '0' COMMENT '省',
  `CityId` int(5) unsigned NOT NULL DEFAULT '0' COMMENT '市',
  `AreaId` int(5) unsigned NOT NULL DEFAULT '0' COMMENT '地区',
  `Province` varchar(30) NOT NULL DEFAULT '' COMMENT '省份名称',
  `City` varchar(30) NOT NULL DEFAULT '' COMMENT '城市名称',
  `Area` varchar(30) NOT NULL DEFAULT '' COMMENT '地区名称',
  `Address` varchar(200) NOT NULL DEFAULT '' COMMENT '收货地址',
  `Default` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否是默认地址（0：不是1：是）',
  PRIMARY KEY (`ID`),
  KEY `UD` (`Uid`,`Default`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hi_user_address_7
-- ----------------------------
INSERT INTO `hi_user_address_7` VALUES ('1', '17', 'Alicia Zheng', '18602194166', '310000', '310100', '310105', '上海市', '市辖区', '长宁区', '华山路1038弄1期2号708室', '0');
INSERT INTO `hi_user_address_7` VALUES ('2', '27', '海宝', '15800947032', '310000', '310100', '310105', '上海市', '市辖区', '长宁区', '昭化东路82弄3号201室', '1');

-- ----------------------------
-- Table structure for hi_user_address_8
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_address_8`;
CREATE TABLE `hi_user_address_8` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Name` varchar(180) NOT NULL DEFAULT '' COMMENT '收货人姓名',
  `Mobile` varchar(12) NOT NULL DEFAULT '' COMMENT '手机号码',
  `ProvinceId` int(5) unsigned NOT NULL DEFAULT '0' COMMENT '省',
  `CityId` int(5) unsigned NOT NULL DEFAULT '0' COMMENT '市',
  `AreaId` int(5) unsigned NOT NULL DEFAULT '0' COMMENT '地区',
  `Province` varchar(30) NOT NULL DEFAULT '' COMMENT '省份名称',
  `City` varchar(30) NOT NULL DEFAULT '' COMMENT '城市名称',
  `Area` varchar(30) NOT NULL DEFAULT '' COMMENT '地区名称',
  `Address` varchar(200) NOT NULL DEFAULT '' COMMENT '收货地址',
  `Default` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否是默认地址（0：不是1：是）',
  PRIMARY KEY (`ID`),
  KEY `UD` (`Uid`,`Default`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hi_user_address_8
-- ----------------------------
INSERT INTO `hi_user_address_8` VALUES ('1', '18', '李雪莹', '13917079163', '310000', '310100', '310104', '上海市', '市辖区', '徐汇区', '湖南路123号', '0');
INSERT INTO `hi_user_address_8` VALUES ('2', '28', '高敏', '13817160282', '310000', '310100', '310105', '上海市', '市辖区', '长宁区', '平武路29号301室', '1');

-- ----------------------------
-- Table structure for hi_user_address_9
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_address_9`;
CREATE TABLE `hi_user_address_9` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Name` varchar(180) NOT NULL DEFAULT '' COMMENT '收货人姓名',
  `Mobile` varchar(12) NOT NULL DEFAULT '' COMMENT '手机号码',
  `ProvinceId` int(5) unsigned NOT NULL DEFAULT '0' COMMENT '省',
  `CityId` int(5) unsigned NOT NULL DEFAULT '0' COMMENT '市',
  `AreaId` int(5) unsigned NOT NULL DEFAULT '0' COMMENT '地区',
  `Province` varchar(30) NOT NULL DEFAULT '' COMMENT '省份名称',
  `City` varchar(30) NOT NULL DEFAULT '' COMMENT '城市名称',
  `Area` varchar(30) NOT NULL DEFAULT '' COMMENT '地区名称',
  `Address` varchar(200) NOT NULL DEFAULT '' COMMENT '收货地址',
  `Default` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否是默认地址（0：不是1：是）',
  PRIMARY KEY (`ID`),
  KEY `UD` (`Uid`,`Default`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hi_user_address_9
-- ----------------------------
INSERT INTO `hi_user_address_9` VALUES ('1', '19', 'sadf', '13524699164', '110000', '110100', '110102', '北京市', '市辖区', '西城区', 'asdf', '0');
INSERT INTO `hi_user_address_9` VALUES ('2', '29', '肖燮玥', '15021381478', '310000', '310100', '310105', '上海市', '市辖区', '长宁区', '定西路', '0');
INSERT INTO `hi_user_address_9` VALUES ('3', '39', '杨女士', '13810781148', '110000', '110100', '110108', '北京市', '市辖区', '海淀区', '宝盛里观景园4栋2单元502', '1');

-- ----------------------------
-- Table structure for hi_user_b
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_b`;
CREATE TABLE `hi_user_b` (
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '玩家ID',
  `UserName` varchar(50) NOT NULL DEFAULT '' COMMENT '用户名',
  `MUserName` char(32) NOT NULL DEFAULT '' COMMENT 'MD5后的用户名',
  `Password` char(32) NOT NULL DEFAULT '' COMMENT '用户密码',
  `Mobile` char(11) NOT NULL DEFAULT '' COMMENT '绑定手机号',
  `Type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '用户类型(1:普通用户2:微信用户)',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `UnionId` char(50) NOT NULL DEFAULT '' COMMENT '微信用户统一标识',
  `MUnionId` char(32) NOT NULL DEFAULT '' COMMENT 'MD5后的微信用户统一标识',
  `AccessToken` varchar(200) NOT NULL DEFAULT '' COMMENT '微信token',
  `ExpireTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '过期时间',
  `RefreshToken` varchar(200) NOT NULL DEFAULT '' COMMENT '微信刷新用token',
  `SuggesterMobile` varchar(20) NOT NULL DEFAULT '' COMMENT '推荐人手机号',
  `isMerge` tinyint(1) DEFAULT '0' COMMENT '是否合并，1：是，0：否',
  PRIMARY KEY (`Uid`),
  UNIQUE KEY `MUserName` (`MUserName`) USING BTREE,
  KEY `MUionID` (`MUnionId`) USING BTREE,
  KEY `isMerge` (`isMerge`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of hi_user_b
-- ----------------------------
INSERT INTO `hi_user_b` VALUES ('1', '18616212507', 'b5086ede6fbab56be4b246a68003c38d', 'e2ce364185eca67ef5d01a114c5beb3c', '', '1', '1515652080', '', '', '', '0', '', '', '1');
INSERT INTO `hi_user_b` VALUES ('38', '13911096955', 'bf2596ad9dc0696a1d8fe19ce9a6c592', '1e3f0c0cdbaff82aa3d207465590e846', '', '1', '1514951619', '', '', '', '0', '', '', '1');

-- ----------------------------
-- Table structure for hi_user_c
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_c`;
CREATE TABLE `hi_user_c` (
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '玩家ID',
  `UserName` varchar(50) NOT NULL DEFAULT '' COMMENT '用户名',
  `MUserName` char(32) NOT NULL DEFAULT '' COMMENT 'MD5后的用户名',
  `Password` char(32) NOT NULL DEFAULT '' COMMENT '用户密码',
  `Mobile` char(11) NOT NULL DEFAULT '' COMMENT '绑定手机号',
  `Type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '用户类型(1:普通用户2:微信用户)',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `UnionId` char(50) NOT NULL DEFAULT '' COMMENT '微信用户统一标识',
  `MUnionId` char(32) NOT NULL DEFAULT '' COMMENT 'MD5后的微信用户统一标识',
  `AccessToken` varchar(200) NOT NULL DEFAULT '' COMMENT '微信token',
  `ExpireTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '过期时间',
  `RefreshToken` varchar(200) NOT NULL DEFAULT '' COMMENT '微信刷新用token',
  `SuggesterMobile` varchar(20) NOT NULL DEFAULT '' COMMENT '推荐人手机号',
  `isMerge` tinyint(1) DEFAULT '0' COMMENT '是否合并，1：是，0：否',
  PRIMARY KEY (`Uid`),
  UNIQUE KEY `MUserName` (`MUserName`) USING BTREE,
  KEY `MUionID` (`MUnionId`) USING BTREE,
  KEY `isMerge` (`isMerge`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of hi_user_c
-- ----------------------------
INSERT INTO `hi_user_c` VALUES ('40', '15342263099', 'c22b3115d42ce321a7438b47c0c319f3', 'e4c7025cf3c912dd18a4bef6ef907975', '', '1', '1514979218', '', '', '', '0', '', '13871446599', '1');

-- ----------------------------
-- Table structure for hi_user_coupon_0
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_coupon_0`;
CREATE TABLE `hi_user_coupon_0` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Coupon` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '优惠券ID',
  `Expire` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '有效期',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '优惠券获得时间',
  PRIMARY KEY (`ID`),
  KEY `UE` (`Uid`,`Expire`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户优惠券';

-- ----------------------------
-- Records of hi_user_coupon_0
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_coupon_1
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_coupon_1`;
CREATE TABLE `hi_user_coupon_1` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Coupon` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '优惠券ID',
  `Expire` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '有效期',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '优惠券获得时间',
  PRIMARY KEY (`ID`),
  KEY `UE` (`Uid`,`Expire`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户优惠券';

-- ----------------------------
-- Records of hi_user_coupon_1
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_coupon_2
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_coupon_2`;
CREATE TABLE `hi_user_coupon_2` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Coupon` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '优惠券ID',
  `Expire` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '有效期',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '优惠券获得时间',
  PRIMARY KEY (`ID`),
  KEY `UE` (`Uid`,`Expire`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户优惠券';

-- ----------------------------
-- Records of hi_user_coupon_2
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_coupon_3
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_coupon_3`;
CREATE TABLE `hi_user_coupon_3` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Coupon` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '优惠券ID',
  `Expire` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '有效期',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '优惠券获得时间',
  PRIMARY KEY (`ID`),
  KEY `UE` (`Uid`,`Expire`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户优惠券';

-- ----------------------------
-- Records of hi_user_coupon_3
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_coupon_4
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_coupon_4`;
CREATE TABLE `hi_user_coupon_4` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Coupon` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '优惠券ID',
  `Expire` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '有效期',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '优惠券获得时间',
  PRIMARY KEY (`ID`),
  KEY `UE` (`Uid`,`Expire`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户优惠券';

-- ----------------------------
-- Records of hi_user_coupon_4
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_coupon_5
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_coupon_5`;
CREATE TABLE `hi_user_coupon_5` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Coupon` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '优惠券ID',
  `Expire` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '有效期',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '优惠券获得时间',
  PRIMARY KEY (`ID`),
  KEY `UE` (`Uid`,`Expire`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户优惠券';

-- ----------------------------
-- Records of hi_user_coupon_5
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_coupon_6
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_coupon_6`;
CREATE TABLE `hi_user_coupon_6` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Coupon` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '优惠券ID',
  `Expire` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '有效期',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '优惠券获得时间',
  PRIMARY KEY (`ID`),
  KEY `UE` (`Uid`,`Expire`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户优惠券';

-- ----------------------------
-- Records of hi_user_coupon_6
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_coupon_7
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_coupon_7`;
CREATE TABLE `hi_user_coupon_7` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Coupon` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '优惠券ID',
  `Expire` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '有效期',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '优惠券获得时间',
  PRIMARY KEY (`ID`),
  KEY `UE` (`Uid`,`Expire`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户优惠券';

-- ----------------------------
-- Records of hi_user_coupon_7
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_coupon_8
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_coupon_8`;
CREATE TABLE `hi_user_coupon_8` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Coupon` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '优惠券ID',
  `Expire` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '有效期',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '优惠券获得时间',
  PRIMARY KEY (`ID`),
  KEY `UE` (`Uid`,`Expire`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户优惠券';

-- ----------------------------
-- Records of hi_user_coupon_8
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_coupon_9
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_coupon_9`;
CREATE TABLE `hi_user_coupon_9` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Coupon` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '优惠券ID',
  `Expire` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '有效期',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '优惠券获得时间',
  PRIMARY KEY (`ID`),
  KEY `UE` (`Uid`,`Expire`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户优惠券';

-- ----------------------------
-- Records of hi_user_coupon_9
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_course_0
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_course_0`;
CREATE TABLE `hi_user_course_0` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Course` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '课程ID',
  `TopicCount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '已做题目数量',
  `CorrentCount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '答对次数',
  `ErrorCount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '答错次数',
  `State` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '课程状态(0:未开始1:学习中2:已完成学习3:试听过)',
  `StudyUnitCount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '已学单元数',
  `StudyUnits` varchar(255) NOT NULL DEFAULT '' COMMENT '已学过的单元ID(|隔开)',
  `StudyUnit` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '当前所处单元',
  `StudyTopic` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '当前题目ID',
  `CostTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '已花费时间',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '进入该题目时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UCS` (`Uid`,`Course`,`State`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='用户课程表';

-- ----------------------------
-- Records of hi_user_course_0
-- ----------------------------
INSERT INTO `hi_user_course_0` VALUES ('1', '30', '2', '0', '0', '0', '0', '0', '', '0', '0', '0', '0');
INSERT INTO `hi_user_course_0` VALUES ('2', '100', '2', '0', '0', '0', '0', '0', '', '0', '0', '0', '0');

-- ----------------------------
-- Table structure for hi_user_course_1
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_course_1`;
CREATE TABLE `hi_user_course_1` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Course` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '课程ID',
  `TopicCount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '已做题目数量',
  `CorrentCount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '答对次数',
  `ErrorCount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '答错次数',
  `State` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '课程状态(0:未开始1:学习中2:已完成学习3:试听过)',
  `StudyUnitCount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '已学单元数',
  `StudyUnits` varchar(255) NOT NULL DEFAULT '' COMMENT '已学过的单元ID(|隔开)',
  `StudyUnit` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '当前所处单元',
  `StudySUnit` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '当前所处子单元',
  `StudyTopic` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '当前题目ID',
  `CostTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '已花费时间',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '进入该题目时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UCS` (`Uid`,`Course`,`State`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='用户课程表';

-- ----------------------------
-- Records of hi_user_course_1
-- ----------------------------
INSERT INTO `hi_user_course_1` VALUES ('1', '31', '2', '0', '0', '0', '0', '0', '', '0', '0', '0', '0', '1514894191');

-- ----------------------------
-- Table structure for hi_user_course_2
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_course_2`;
CREATE TABLE `hi_user_course_2` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Course` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '课程ID',
  `TopicCount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '已做题目数量',
  `CorrentCount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '答对次数',
  `ErrorCount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '答错次数',
  `State` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '课程状态(0:未开始1:学习中2:已完成学习3:试听过)',
  `StudyUnitCount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '已学单元数',
  `StudyUnits` varchar(255) NOT NULL DEFAULT '' COMMENT '已学过的单元ID(|隔开)',
  `StudyUnit` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '当前所处单元',
  `StudySUnit` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '当前所处子单元',
  `StudyTopic` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '当前题目ID',
  `CostTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '已花费时间',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '进入该题目时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UCS` (`Uid`,`Course`,`State`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='用户课程表';

-- ----------------------------
-- Records of hi_user_course_2
-- ----------------------------
INSERT INTO `hi_user_course_2` VALUES ('1', '32', '2', '0', '0', '0', '0', '0', '', '0', '0', '0', '0', '1514952840');
INSERT INTO `hi_user_course_2` VALUES ('2', '42', '2', '0', '0', '0', '0', '0', '', '0', '0', '0', '0', '1514983045');

-- ----------------------------
-- Table structure for hi_user_course_3
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_course_3`;
CREATE TABLE `hi_user_course_3` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Course` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '课程ID',
  `TopicCount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '已做题目数量',
  `CorrentCount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '答对次数',
  `ErrorCount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '答错次数',
  `State` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '课程状态(0:未开始1:学习中2:已完成学习3:试听过)',
  `StudyUnitCount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '已学单元数',
  `StudyUnits` varchar(255) NOT NULL DEFAULT '' COMMENT '已学过的单元ID(|隔开)',
  `StudyUnit` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '当前所处单元',
  `StudySUnit` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '当前所处子单元',
  `StudyTopic` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '当前题目ID',
  `CostTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '已花费时间',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '进入该题目时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UCS` (`Uid`,`Course`,`State`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户课程表';

-- ----------------------------
-- Records of hi_user_course_3
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_course_4
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_course_4`;
CREATE TABLE `hi_user_course_4` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Course` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '课程ID',
  `TopicCount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '已做题目数量',
  `CorrentCount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '答对次数',
  `ErrorCount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '答错次数',
  `State` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '课程状态(0:未开始1:学习中2:已完成学习3:试听过)',
  `StudyUnitCount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '已学单元数',
  `StudyUnits` varchar(255) NOT NULL DEFAULT '' COMMENT '已学过的单元ID(|隔开)',
  `StudyUnit` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '当前所处单元',
  `StudySUnit` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '当前所处子单元',
  `StudyTopic` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '当前题目ID',
  `CostTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '已花费时间',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '进入该题目时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UCS` (`Uid`,`Course`,`State`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户课程表';

-- ----------------------------
-- Records of hi_user_course_4
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_course_5
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_course_5`;
CREATE TABLE `hi_user_course_5` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Course` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '课程ID',
  `TopicCount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '已做题目数量',
  `CorrentCount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '答对次数',
  `ErrorCount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '答错次数',
  `State` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '课程状态(0:未开始1:学习中2:已完成学习3:试听过)',
  `StudyUnitCount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '已学单元数',
  `StudyUnits` varchar(255) NOT NULL DEFAULT '' COMMENT '已学过的单元ID(|隔开)',
  `StudyUnit` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '当前所处单元',
  `StudySUnit` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '当前所处子单元',
  `StudyTopic` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '当前题目ID',
  `CostTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '已花费时间',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '进入该题目时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UCS` (`Uid`,`Course`,`State`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='用户课程表';

-- ----------------------------
-- Records of hi_user_course_5
-- ----------------------------
INSERT INTO `hi_user_course_5` VALUES ('1', '35', '2', '0', '0', '0', '0', '0', '', '0', '0', '0', '0', '1514948894');
INSERT INTO `hi_user_course_5` VALUES ('2', '25', '2', '0', '0', '0', '0', '0', '', '0', '0', '0', '0', '1514985029');
INSERT INTO `hi_user_course_5` VALUES ('3', '45', '2', '0', '0', '0', '0', '0', '', '0', '0', '0', '0', '1514989359');

-- ----------------------------
-- Table structure for hi_user_course_6
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_course_6`;
CREATE TABLE `hi_user_course_6` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Course` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '课程ID',
  `TopicCount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '已做题目数量',
  `CorrentCount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '答对次数',
  `ErrorCount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '答错次数',
  `State` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '课程状态(0:未开始1:学习中2:已完成学习3:试听过)',
  `StudyUnitCount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '已学单元数',
  `StudyUnits` varchar(255) NOT NULL DEFAULT '' COMMENT '已学过的单元ID(|隔开)',
  `StudyUnit` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '当前所处单元',
  `StudySUnit` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '当前所处子单元',
  `StudyTopic` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '当前题目ID',
  `CostTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '已花费时间',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '进入该题目时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UCS` (`Uid`,`Course`,`State`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='用户课程表';

-- ----------------------------
-- Records of hi_user_course_6
-- ----------------------------
INSERT INTO `hi_user_course_6` VALUES ('1', '26', '2', '0', '0', '0', '0', '0', '', '0', '0', '0', '0', '1514786411');
INSERT INTO `hi_user_course_6` VALUES ('2', '36', '2', '0', '0', '0', '0', '0', '', '0', '0', '0', '0', '1514950446');

-- ----------------------------
-- Table structure for hi_user_course_7
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_course_7`;
CREATE TABLE `hi_user_course_7` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Course` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '课程ID',
  `TopicCount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '已做题目数量',
  `CorrentCount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '答对次数',
  `ErrorCount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '答错次数',
  `State` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '课程状态(0:未开始1:学习中2:已完成学习3:试听过)',
  `StudyUnitCount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '已学单元数',
  `StudyUnits` varchar(255) NOT NULL DEFAULT '' COMMENT '已学过的单元ID(|隔开)',
  `StudyUnit` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '当前所处单元',
  `StudySUnit` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '当前所处子单元',
  `StudyTopic` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '当前题目ID',
  `CostTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '已花费时间',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '进入该题目时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UCS` (`Uid`,`Course`,`State`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='用户课程表';

-- ----------------------------
-- Records of hi_user_course_7
-- ----------------------------
INSERT INTO `hi_user_course_7` VALUES ('1', '17', '2', '0', '0', '0', '0', '0', '', '0', '0', '0', '0', '1514710021');
INSERT INTO `hi_user_course_7` VALUES ('2', '27', '2', '0', '0', '0', '0', '0', '', '0', '0', '0', '0', '1514796020');

-- ----------------------------
-- Table structure for hi_user_course_8
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_course_8`;
CREATE TABLE `hi_user_course_8` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Course` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '课程ID',
  `TopicCount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '已做题目数量',
  `CorrentCount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '答对次数',
  `ErrorCount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '答错次数',
  `State` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '课程状态(0:未开始1:学习中2:已完成学习3:试听过)',
  `StudyUnitCount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '已学单元数',
  `StudyUnits` varchar(255) NOT NULL DEFAULT '' COMMENT '已学过的单元ID(|隔开)',
  `StudyUnit` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '当前所处单元',
  `StudySUnit` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '当前所处子单元',
  `StudyTopic` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '当前题目ID',
  `CostTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '已花费时间',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '进入该题目时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UCS` (`Uid`,`Course`,`State`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='用户课程表';

-- ----------------------------
-- Records of hi_user_course_8
-- ----------------------------
INSERT INTO `hi_user_course_8` VALUES ('1', '18', '2', '0', '0', '0', '0', '0', '', '0', '0', '0', '0', '1514709500');
INSERT INTO `hi_user_course_8` VALUES ('2', '28', '2', '0', '0', '0', '0', '0', '', '0', '0', '0', '0', '1514801429');

-- ----------------------------
-- Table structure for hi_user_course_9
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_course_9`;
CREATE TABLE `hi_user_course_9` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Course` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '课程ID',
  `TopicCount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '已做题目数量',
  `CorrentCount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '答对次数',
  `ErrorCount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '答错次数',
  `State` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '课程状态(0:未开始1:学习中2:已完成学习3:试听过)',
  `StudyUnitCount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '已学单元数',
  `StudyUnits` varchar(255) NOT NULL DEFAULT '' COMMENT '已学过的单元ID(|隔开)',
  `StudyUnit` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '当前所处单元',
  `StudySUnit` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '当前所处子单元',
  `StudyTopic` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '当前题目ID',
  `CostTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '已花费时间',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '进入该题目时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UCS` (`Uid`,`Course`,`State`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='用户课程表';

-- ----------------------------
-- Records of hi_user_course_9
-- ----------------------------
INSERT INTO `hi_user_course_9` VALUES ('1', '29', '2', '0', '0', '0', '0', '0', '', '0', '0', '0', '0', '1514809024');
INSERT INTO `hi_user_course_9` VALUES ('2', '39', '2', '0', '0', '0', '0', '0', '', '0', '0', '0', '0', '1514980556');

-- ----------------------------
-- Table structure for hi_user_course_answer_0
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_course_answer_0`;
CREATE TABLE `hi_user_course_answer_0` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Course` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '课程ID',
  `Tid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '题目ID',
  `Answer` text COMMENT '题目答案',
  `Comment` text COMMENT '教师评语',
  `Teacher` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评价老师',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '进入该题目时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UCS` (`Uid`,`Course`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户课程表';

-- ----------------------------
-- Records of hi_user_course_answer_0
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_course_answer_1
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_course_answer_1`;
CREATE TABLE `hi_user_course_answer_1` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Course` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '课程ID',
  `Tid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '题目ID',
  `Answer` text COMMENT '题目答案',
  `Comment` text COMMENT '教师评语',
  `Teacher` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评价老师',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '进入该题目时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UCS` (`Uid`,`Course`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户课程表';

-- ----------------------------
-- Records of hi_user_course_answer_1
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_course_answer_2
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_course_answer_2`;
CREATE TABLE `hi_user_course_answer_2` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Course` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '课程ID',
  `Tid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '题目ID',
  `Answer` text COMMENT '题目答案',
  `Comment` text COMMENT '教师评语',
  `Teacher` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评价老师',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '进入该题目时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UCS` (`Uid`,`Course`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户课程表';

-- ----------------------------
-- Records of hi_user_course_answer_2
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_course_answer_3
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_course_answer_3`;
CREATE TABLE `hi_user_course_answer_3` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Course` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '课程ID',
  `Tid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '题目ID',
  `Answer` text COMMENT '题目答案',
  `Comment` text COMMENT '教师评语',
  `Teacher` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评价老师',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '进入该题目时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UCS` (`Uid`,`Course`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户课程表';

-- ----------------------------
-- Records of hi_user_course_answer_3
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_course_answer_4
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_course_answer_4`;
CREATE TABLE `hi_user_course_answer_4` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Course` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '课程ID',
  `Tid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '题目ID',
  `Answer` text COMMENT '题目答案',
  `Comment` text COMMENT '教师评语',
  `Teacher` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评价老师',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '进入该题目时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UCS` (`Uid`,`Course`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户课程表';

-- ----------------------------
-- Records of hi_user_course_answer_4
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_course_answer_5
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_course_answer_5`;
CREATE TABLE `hi_user_course_answer_5` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Course` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '课程ID',
  `Tid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '题目ID',
  `Answer` text COMMENT '题目答案',
  `Comment` text COMMENT '教师评语',
  `Teacher` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评价老师',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '进入该题目时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UCS` (`Uid`,`Course`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户课程表';

-- ----------------------------
-- Records of hi_user_course_answer_5
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_course_answer_6
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_course_answer_6`;
CREATE TABLE `hi_user_course_answer_6` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Course` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '课程ID',
  `Tid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '题目ID',
  `Answer` text COMMENT '题目答案',
  `Comment` text COMMENT '教师评语',
  `Teacher` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评价老师',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '进入该题目时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UCS` (`Uid`,`Course`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户课程表';

-- ----------------------------
-- Records of hi_user_course_answer_6
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_course_answer_7
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_course_answer_7`;
CREATE TABLE `hi_user_course_answer_7` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Course` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '课程ID',
  `Tid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '题目ID',
  `Answer` text COMMENT '题目答案',
  `Comment` text COMMENT '教师评语',
  `Teacher` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评价老师',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '进入该题目时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UCS` (`Uid`,`Course`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户课程表';

-- ----------------------------
-- Records of hi_user_course_answer_7
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_course_answer_8
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_course_answer_8`;
CREATE TABLE `hi_user_course_answer_8` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Course` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '课程ID',
  `Tid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '题目ID',
  `Answer` text COMMENT '题目答案',
  `Comment` text COMMENT '教师评语',
  `Teacher` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评价老师',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '进入该题目时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UCS` (`Uid`,`Course`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户课程表';

-- ----------------------------
-- Records of hi_user_course_answer_8
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_course_answer_9
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_course_answer_9`;
CREATE TABLE `hi_user_course_answer_9` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Course` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '课程ID',
  `Tid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '题目ID',
  `Answer` text COMMENT '题目答案',
  `Comment` text COMMENT '教师评语',
  `Teacher` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评价老师',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '进入该题目时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UCS` (`Uid`,`Course`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户课程表';

-- ----------------------------
-- Records of hi_user_course_answer_9
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_course_topic_0
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_course_topic_0`;
CREATE TABLE `hi_user_course_topic_0` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `CourseID` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '课程动态ID',
  `Topic` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '题目ID',
  `CorrectCount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '答对次数',
  `ErrorCount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '答错次数',
  `Enshrine` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否收藏（0：未收藏1:收藏）',
  `Translate` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否使用了翻译',
  `Help` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否使用了帮助',
  `State` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态(0:未完成1:已完成)',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '进入该题目时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UCT` (`Uid`,`CourseID`,`Topic`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=41 DEFAULT CHARSET=utf8 COMMENT='用户题目表';

-- ----------------------------
-- Records of hi_user_course_topic_0
-- ----------------------------
INSERT INTO `hi_user_course_topic_0` VALUES ('1', '30', '2', '145', '0', '1', '0', '0', '0', '1', '1514888790');
INSERT INTO `hi_user_course_topic_0` VALUES ('2', '30', '2', '146', '0', '1', '0', '0', '0', '1', '1514888859');
INSERT INTO `hi_user_course_topic_0` VALUES ('3', '30', '2', '147', '0', '1', '0', '0', '0', '1', '1514888870');
INSERT INTO `hi_user_course_topic_0` VALUES ('4', '30', '2', '148', '0', '1', '0', '0', '0', '1', '1514888885');
INSERT INTO `hi_user_course_topic_0` VALUES ('5', '30', '2', '259', '0', '1', '0', '0', '0', '1', '1514888916');
INSERT INTO `hi_user_course_topic_0` VALUES ('6', '30', '2', '95', '0', '1', '0', '0', '0', '1', '1514889100');
INSERT INTO `hi_user_course_topic_0` VALUES ('7', '30', '2', '107', '0', '1', '0', '0', '0', '1', '1514889133');
INSERT INTO `hi_user_course_topic_0` VALUES ('8', '30', '2', '103', '0', '1', '0', '0', '0', '1', '1514889154');
INSERT INTO `hi_user_course_topic_0` VALUES ('9', '30', '2', '104', '0', '1', '0', '0', '0', '1', '1514889178');
INSERT INTO `hi_user_course_topic_0` VALUES ('10', '30', '2', '105', '0', '1', '0', '0', '0', '1', '1514889204');
INSERT INTO `hi_user_course_topic_0` VALUES ('11', '30', '2', '108', '0', '1', '0', '0', '0', '1', '1514889215');
INSERT INTO `hi_user_course_topic_0` VALUES ('12', '30', '2', '106', '0', '1', '0', '0', '0', '1', '1514899735');
INSERT INTO `hi_user_course_topic_0` VALUES ('13', '30', '2', '109', '0', '1', '0', '0', '0', '1', '1514899747');
INSERT INTO `hi_user_course_topic_0` VALUES ('14', '30', '2', '110', '0', '1', '0', '0', '0', '1', '1514899783');
INSERT INTO `hi_user_course_topic_0` VALUES ('15', '30', '2', '111', '0', '1', '0', '0', '0', '1', '1514899804');
INSERT INTO `hi_user_course_topic_0` VALUES ('16', '30', '2', '112', '0', '1', '0', '0', '0', '1', '1514899898');
INSERT INTO `hi_user_course_topic_0` VALUES ('17', '30', '2', '158', '0', '1', '0', '0', '0', '1', '1514944947');
INSERT INTO `hi_user_course_topic_0` VALUES ('18', '30', '2', '161', '0', '1', '0', '0', '0', '1', '1514945042');
INSERT INTO `hi_user_course_topic_0` VALUES ('19', '30', '2', '163', '0', '1', '0', '0', '0', '1', '1514945140');
INSERT INTO `hi_user_course_topic_0` VALUES ('20', '30', '2', '164', '0', '1', '0', '0', '0', '1', '1514945191');
INSERT INTO `hi_user_course_topic_0` VALUES ('21', '30', '2', '165', '0', '1', '0', '0', '0', '1', '1514945213');
INSERT INTO `hi_user_course_topic_0` VALUES ('22', '30', '2', '167', '0', '1', '0', '0', '0', '1', '1514945250');
INSERT INTO `hi_user_course_topic_0` VALUES ('23', '30', '2', '169', '2', '0', '0', '0', '0', '1', '1514945295');
INSERT INTO `hi_user_course_topic_0` VALUES ('24', '30', '2', '172', '0', '1', '0', '0', '0', '1', '1514945367');
INSERT INTO `hi_user_course_topic_0` VALUES ('25', '30', '2', '175', '0', '1', '0', '0', '0', '1', '1514945522');
INSERT INTO `hi_user_course_topic_0` VALUES ('26', '30', '2', '176', '0', '1', '0', '0', '0', '1', '1514945539');
INSERT INTO `hi_user_course_topic_0` VALUES ('27', '30', '2', '177', '0', '1', '0', '0', '0', '1', '1514945592');
INSERT INTO `hi_user_course_topic_0` VALUES ('28', '30', '2', '178', '0', '1', '0', '0', '0', '1', '1514945663');
INSERT INTO `hi_user_course_topic_0` VALUES ('29', '30', '2', '179', '0', '1', '0', '0', '0', '1', '1514945681');
INSERT INTO `hi_user_course_topic_0` VALUES ('30', '30', '2', '185', '0', '1', '0', '0', '0', '1', '1514946288');
INSERT INTO `hi_user_course_topic_0` VALUES ('31', '30', '2', '261', '0', '1', '0', '0', '0', '1', '1514946495');
INSERT INTO `hi_user_course_topic_0` VALUES ('32', '30', '2', '99', '0', '1', '0', '0', '0', '1', '1514946587');
INSERT INTO `hi_user_course_topic_0` VALUES ('33', '30', '2', '149', '0', '1', '0', '0', '0', '1', '1514946602');
INSERT INTO `hi_user_course_topic_0` VALUES ('34', '30', '2', '150', '0', '1', '0', '0', '0', '1', '1514946614');
INSERT INTO `hi_user_course_topic_0` VALUES ('35', '30', '2', '159', '0', '1', '0', '0', '0', '1', '1514946622');
INSERT INTO `hi_user_course_topic_0` VALUES ('36', '30', '2', '162', '0', '1', '0', '0', '0', '1', '1514946636');
INSERT INTO `hi_user_course_topic_0` VALUES ('37', '30', '2', '168', '0', '1', '0', '0', '0', '1', '1514946649');
INSERT INTO `hi_user_course_topic_0` VALUES ('38', '30', '2', '174', '0', '1', '0', '0', '0', '1', '1514946659');
INSERT INTO `hi_user_course_topic_0` VALUES ('39', '30', '2', '184', '0', '1', '0', '0', '0', '1', '1514946715');
INSERT INTO `hi_user_course_topic_0` VALUES ('40', '30', '2', '189', '0', '1', '0', '0', '0', '1', '1514946748');

-- ----------------------------
-- Table structure for hi_user_course_topic_1
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_course_topic_1`;
CREATE TABLE `hi_user_course_topic_1` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `CourseID` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '课程动态ID',
  `Topic` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '题目ID',
  `CorrectCount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '答对次数',
  `ErrorCount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '答错次数',
  `Enshrine` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否收藏（0：未收藏1:收藏）',
  `Translate` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否使用了翻译',
  `Help` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否使用了帮助',
  `State` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态(0:未完成1:已完成)',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '进入该题目时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UT` (`Uid`,`Topic`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='用户题目表';

-- ----------------------------
-- Records of hi_user_course_topic_1
-- ----------------------------
INSERT INTO `hi_user_course_topic_1` VALUES ('1', '31', '2', '145', '0', '0', '0', '1', '1', '0', '1514894272');

-- ----------------------------
-- Table structure for hi_user_course_topic_2
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_course_topic_2`;
CREATE TABLE `hi_user_course_topic_2` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `CourseID` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '课程动态ID',
  `Topic` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '题目ID',
  `CorrectCount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '答对次数',
  `ErrorCount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '答错次数',
  `Enshrine` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否收藏（0：未收藏1:收藏）',
  `Translate` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否使用了翻译',
  `Help` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否使用了帮助',
  `State` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态(0:未完成1:已完成)',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '进入该题目时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UCT` (`Uid`,`CourseID`,`Topic`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户题目表';

-- ----------------------------
-- Records of hi_user_course_topic_2
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_course_topic_3
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_course_topic_3`;
CREATE TABLE `hi_user_course_topic_3` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `CourseID` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '课程动态ID',
  `Topic` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '题目ID',
  `CorrectCount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '答对次数',
  `ErrorCount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '答错次数',
  `Enshrine` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否收藏（0：未收藏1:收藏）',
  `Translate` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否使用了翻译',
  `Help` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否使用了帮助',
  `State` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态(0:未完成1:已完成)',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '进入该题目时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UCT` (`Uid`,`CourseID`,`Topic`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户题目表';

-- ----------------------------
-- Records of hi_user_course_topic_3
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_course_topic_4
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_course_topic_4`;
CREATE TABLE `hi_user_course_topic_4` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `CourseID` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '课程动态ID',
  `Topic` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '题目ID',
  `CorrectCount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '答对次数',
  `ErrorCount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '答错次数',
  `Enshrine` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否收藏（0：未收藏1:收藏）',
  `Translate` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否使用了翻译',
  `Help` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否使用了帮助',
  `State` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态(0:未完成1:已完成)',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '进入该题目时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UCT` (`Uid`,`CourseID`,`Topic`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户题目表';

-- ----------------------------
-- Records of hi_user_course_topic_4
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_course_topic_5
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_course_topic_5`;
CREATE TABLE `hi_user_course_topic_5` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `CourseID` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '课程动态ID',
  `Topic` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '题目ID',
  `CorrectCount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '答对次数',
  `ErrorCount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '答错次数',
  `Enshrine` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否收藏（0：未收藏1:收藏）',
  `Translate` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否使用了翻译',
  `Help` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否使用了帮助',
  `State` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态(0:未完成1:已完成)',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '进入该题目时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UCT` (`Uid`,`CourseID`,`Topic`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='用户题目表';

-- ----------------------------
-- Records of hi_user_course_topic_5
-- ----------------------------
INSERT INTO `hi_user_course_topic_5` VALUES ('1', '25', '2', '145', '0', '1', '0', '0', '0', '1', '1514985225');
INSERT INTO `hi_user_course_topic_5` VALUES ('2', '25', '2', '146', '0', '1', '0', '0', '0', '1', '1514985251');
INSERT INTO `hi_user_course_topic_5` VALUES ('3', '25', '2', '147', '0', '1', '0', '0', '0', '1', '1514985276');
INSERT INTO `hi_user_course_topic_5` VALUES ('4', '25', '2', '148', '0', '1', '0', '0', '0', '1', '1514985310');
INSERT INTO `hi_user_course_topic_5` VALUES ('5', '25', '2', '259', '0', '1', '0', '0', '0', '1', '1514985338');

-- ----------------------------
-- Table structure for hi_user_course_topic_6
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_course_topic_6`;
CREATE TABLE `hi_user_course_topic_6` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `CourseID` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '课程动态ID',
  `Topic` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '题目ID',
  `CorrectCount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '答对次数',
  `ErrorCount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '答错次数',
  `Enshrine` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否收藏（0：未收藏1:收藏）',
  `Translate` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否使用了翻译',
  `Help` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否使用了帮助',
  `State` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态(0:未完成1:已完成)',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '进入该题目时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UCT` (`Uid`,`CourseID`,`Topic`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=110 DEFAULT CHARSET=utf8 COMMENT='用户题目表';

-- ----------------------------
-- Records of hi_user_course_topic_6
-- ----------------------------
INSERT INTO `hi_user_course_topic_6` VALUES ('1', '26', '2', '145', '1', '1', '0', '0', '0', '1', '1514786473');
INSERT INTO `hi_user_course_topic_6` VALUES ('2', '26', '2', '146', '3', '3', '0', '0', '0', '1', '1514786482');
INSERT INTO `hi_user_course_topic_6` VALUES ('3', '26', '2', '147', '1', '1', '0', '0', '0', '1', '1514786531');
INSERT INTO `hi_user_course_topic_6` VALUES ('4', '26', '2', '148', '1', '1', '0', '0', '0', '1', '1514786543');
INSERT INTO `hi_user_course_topic_6` VALUES ('5', '26', '2', '259', '1', '1', '0', '0', '0', '1', '1514786575');
INSERT INTO `hi_user_course_topic_6` VALUES ('6', '26', '2', '95', '0', '1', '0', '0', '0', '1', '1514786711');
INSERT INTO `hi_user_course_topic_6` VALUES ('7', '26', '2', '109', '0', '1', '0', '0', '0', '1', '1514786724');
INSERT INTO `hi_user_course_topic_6` VALUES ('8', '26', '2', '108', '0', '1', '0', '0', '0', '1', '1514786735');
INSERT INTO `hi_user_course_topic_6` VALUES ('9', '26', '2', '105', '0', '1', '0', '0', '0', '1', '1514786738');
INSERT INTO `hi_user_course_topic_6` VALUES ('10', '26', '2', '104', '0', '1', '0', '0', '0', '1', '1514786742');
INSERT INTO `hi_user_course_topic_6` VALUES ('11', '26', '2', '103', '0', '1', '0', '0', '0', '1', '1514786746');
INSERT INTO `hi_user_course_topic_6` VALUES ('12', '26', '2', '106', '0', '1', '0', '0', '0', '1', '1514786751');
INSERT INTO `hi_user_course_topic_6` VALUES ('13', '26', '2', '107', '0', '1', '0', '0', '0', '1', '1514786753');
INSERT INTO `hi_user_course_topic_6` VALUES ('14', '26', '2', '110', '0', '1', '0', '0', '0', '1', '1514786784');
INSERT INTO `hi_user_course_topic_6` VALUES ('15', '26', '2', '111', '0', '1', '0', '0', '0', '1', '1514786795');
INSERT INTO `hi_user_course_topic_6` VALUES ('16', '26', '2', '112', '0', '1', '0', '0', '0', '1', '1514786827');
INSERT INTO `hi_user_course_topic_6` VALUES ('17', '26', '2', '158', '1', '0', '0', '1', '0', '1', '1514786905');
INSERT INTO `hi_user_course_topic_6` VALUES ('18', '26', '2', '161', '0', '1', '0', '0', '0', '1', '1514786999');
INSERT INTO `hi_user_course_topic_6` VALUES ('19', '26', '2', '163', '0', '1', '0', '0', '0', '1', '1514787088');
INSERT INTO `hi_user_course_topic_6` VALUES ('20', '26', '2', '164', '0', '1', '0', '0', '0', '1', '1514787136');
INSERT INTO `hi_user_course_topic_6` VALUES ('21', '26', '2', '165', '0', '1', '0', '0', '0', '1', '1514787158');
INSERT INTO `hi_user_course_topic_6` VALUES ('22', '26', '2', '167', '0', '1', '0', '0', '0', '1', '1514787191');
INSERT INTO `hi_user_course_topic_6` VALUES ('23', '26', '2', '169', '0', '1', '0', '0', '0', '1', '1514787236');
INSERT INTO `hi_user_course_topic_6` VALUES ('24', '26', '2', '172', '0', '1', '0', '0', '0', '1', '1514787296');
INSERT INTO `hi_user_course_topic_6` VALUES ('25', '26', '2', '175', '0', '1', '0', '0', '0', '1', '1514787487');
INSERT INTO `hi_user_course_topic_6` VALUES ('26', '26', '2', '176', '0', '1', '0', '0', '0', '1', '1514787509');
INSERT INTO `hi_user_course_topic_6` VALUES ('27', '26', '2', '177', '0', '1', '0', '0', '0', '1', '1514787545');
INSERT INTO `hi_user_course_topic_6` VALUES ('28', '26', '2', '178', '0', '1', '0', '0', '0', '1', '1514787599');
INSERT INTO `hi_user_course_topic_6` VALUES ('29', '26', '2', '179', '0', '1', '0', '0', '0', '1', '1514787639');
INSERT INTO `hi_user_course_topic_6` VALUES ('30', '26', '2', '185', '2', '0', '0', '0', '0', '1', '1514787939');
INSERT INTO `hi_user_course_topic_6` VALUES ('31', '26', '2', '261', '1', '0', '0', '1', '1', '1', '1514788110');
INSERT INTO `hi_user_course_topic_6` VALUES ('32', '26', '2', '99', '0', '1', '0', '0', '0', '1', '1514788233');
INSERT INTO `hi_user_course_topic_6` VALUES ('33', '26', '2', '149', '0', '1', '0', '0', '0', '1', '1514788251');
INSERT INTO `hi_user_course_topic_6` VALUES ('34', '26', '2', '150', '0', '1', '0', '0', '0', '1', '1514788265');
INSERT INTO `hi_user_course_topic_6` VALUES ('35', '26', '2', '159', '0', '1', '0', '0', '0', '1', '1514788301');
INSERT INTO `hi_user_course_topic_6` VALUES ('36', '26', '2', '162', '0', '1', '0', '0', '0', '1', '1514788316');
INSERT INTO `hi_user_course_topic_6` VALUES ('37', '26', '2', '168', '0', '1', '0', '0', '0', '1', '1514788329');
INSERT INTO `hi_user_course_topic_6` VALUES ('38', '26', '2', '174', '0', '1', '0', '0', '0', '1', '1514788347');
INSERT INTO `hi_user_course_topic_6` VALUES ('39', '26', '2', '184', '0', '1', '0', '0', '0', '1', '1514788359');
INSERT INTO `hi_user_course_topic_6` VALUES ('40', '26', '2', '189', '0', '1', '0', '0', '0', '1', '1514788399');
INSERT INTO `hi_user_course_topic_6` VALUES ('41', '26', '2', '96', '0', '1', '0', '0', '0', '1', '1514788445');
INSERT INTO `hi_user_course_topic_6` VALUES ('42', '26', '2', '116', '8', '1', '0', '0', '0', '1', '1514980003');
INSERT INTO `hi_user_course_topic_6` VALUES ('43', '26', '2', '114', '8', '1', '0', '0', '0', '1', '1514980006');
INSERT INTO `hi_user_course_topic_6` VALUES ('44', '26', '2', '118', '2', '1', '0', '0', '0', '1', '1514980031');
INSERT INTO `hi_user_course_topic_6` VALUES ('45', '26', '2', '115', '1', '1', '0', '0', '0', '1', '1514980055');
INSERT INTO `hi_user_course_topic_6` VALUES ('46', '26', '2', '119', '1', '1', '0', '0', '0', '1', '1514980067');
INSERT INTO `hi_user_course_topic_6` VALUES ('47', '26', '2', '117', '1', '1', '0', '0', '0', '1', '1514980071');
INSERT INTO `hi_user_course_topic_6` VALUES ('48', '26', '2', '113', '4', '1', '0', '0', '0', '1', '1514980075');
INSERT INTO `hi_user_course_topic_6` VALUES ('49', '26', '2', '120', '8', '1', '0', '0', '0', '1', '1514980083');
INSERT INTO `hi_user_course_topic_6` VALUES ('50', '26', '2', '121', '1', '1', '0', '0', '0', '1', '1514980125');
INSERT INTO `hi_user_course_topic_6` VALUES ('51', '26', '2', '122', '1', '1', '0', '0', '0', '1', '1514980208');
INSERT INTO `hi_user_course_topic_6` VALUES ('52', '26', '2', '191', '0', '1', '0', '0', '0', '1', '1514980409');
INSERT INTO `hi_user_course_topic_6` VALUES ('53', '26', '2', '192', '0', '1', '0', '0', '0', '1', '1514980431');
INSERT INTO `hi_user_course_topic_6` VALUES ('54', '26', '2', '193', '0', '1', '0', '0', '0', '1', '1514980501');
INSERT INTO `hi_user_course_topic_6` VALUES ('55', '26', '2', '194', '0', '1', '0', '0', '0', '1', '1514980579');
INSERT INTO `hi_user_course_topic_6` VALUES ('56', '26', '2', '195', '0', '1', '0', '0', '0', '1', '1514980599');
INSERT INTO `hi_user_course_topic_6` VALUES ('57', '26', '2', '196', '0', '1', '0', '0', '0', '1', '1514980635');
INSERT INTO `hi_user_course_topic_6` VALUES ('58', '26', '2', '198', '0', '1', '0', '0', '0', '1', '1514980676');
INSERT INTO `hi_user_course_topic_6` VALUES ('59', '26', '2', '200', '0', '1', '0', '0', '0', '1', '1514980889');
INSERT INTO `hi_user_course_topic_6` VALUES ('60', '26', '2', '201', '0', '1', '0', '0', '0', '1', '1514980933');
INSERT INTO `hi_user_course_topic_6` VALUES ('61', '26', '2', '202', '0', '1', '0', '0', '0', '1', '1514980982');
INSERT INTO `hi_user_course_topic_6` VALUES ('62', '26', '2', '262', '0', '1', '0', '0', '0', '1', '1514981333');
INSERT INTO `hi_user_course_topic_6` VALUES ('63', '26', '2', '100', '0', '1', '0', '0', '0', '1', '1514981450');
INSERT INTO `hi_user_course_topic_6` VALUES ('64', '26', '2', '151', '1', '1', '0', '0', '0', '1', '1514981471');
INSERT INTO `hi_user_course_topic_6` VALUES ('65', '26', '2', '152', '1', '1', '0', '0', '0', '1', '1514981480');
INSERT INTO `hi_user_course_topic_6` VALUES ('66', '26', '2', '190', '1', '1', '0', '0', '0', '1', '1514981487');
INSERT INTO `hi_user_course_topic_6` VALUES ('67', '26', '2', '197', '0', '1', '0', '0', '0', '1', '1514981561');
INSERT INTO `hi_user_course_topic_6` VALUES ('68', '26', '2', '199', '1', '1', '0', '0', '0', '1', '1514981573');
INSERT INTO `hi_user_course_topic_6` VALUES ('69', '26', '2', '203', '3', '0', '0', '0', '0', '1', '1514981587');
INSERT INTO `hi_user_course_topic_6` VALUES ('70', '26', '2', '205', '0', '1', '0', '0', '0', '1', '1514981622');
INSERT INTO `hi_user_course_topic_6` VALUES ('71', '26', '2', '206', '0', '1', '0', '0', '0', '1', '1514981629');
INSERT INTO `hi_user_course_topic_6` VALUES ('72', '26', '2', '207', '0', '1', '0', '0', '0', '1', '1514981650');
INSERT INTO `hi_user_course_topic_6` VALUES ('73', '26', '2', '208', '0', '1', '0', '0', '0', '1', '1514981708');
INSERT INTO `hi_user_course_topic_6` VALUES ('74', '26', '2', '245', '0', '1', '0', '0', '0', '1', '1514981724');
INSERT INTO `hi_user_course_topic_6` VALUES ('75', '26', '2', '97', '0', '1', '0', '0', '0', '1', '1514981789');
INSERT INTO `hi_user_course_topic_6` VALUES ('76', '26', '2', '128', '7', '1', '0', '0', '0', '1', '1514981801');
INSERT INTO `hi_user_course_topic_6` VALUES ('77', '26', '2', '130', '7', '1', '0', '0', '0', '1', '1514981803');
INSERT INTO `hi_user_course_topic_6` VALUES ('78', '26', '2', '124', '5', '1', '0', '0', '0', '1', '1514981824');
INSERT INTO `hi_user_course_topic_6` VALUES ('79', '26', '2', '125', '5', '1', '0', '0', '0', '1', '1514981826');
INSERT INTO `hi_user_course_topic_6` VALUES ('80', '26', '2', '123', '2', '1', '0', '0', '0', '1', '1514981842');
INSERT INTO `hi_user_course_topic_6` VALUES ('81', '26', '2', '126', '5', '1', '0', '0', '0', '1', '1514981851');
INSERT INTO `hi_user_course_topic_6` VALUES ('82', '26', '2', '131', '4', '1', '0', '0', '0', '1', '1514981852');
INSERT INTO `hi_user_course_topic_6` VALUES ('83', '26', '2', '129', '5', '1', '0', '0', '0', '1', '1514981886');
INSERT INTO `hi_user_course_topic_6` VALUES ('84', '26', '2', '127', '6', '1', '0', '0', '0', '1', '1514981888');
INSERT INTO `hi_user_course_topic_6` VALUES ('85', '26', '2', '132', '2', '1', '0', '0', '0', '1', '1514981912');
INSERT INTO `hi_user_course_topic_6` VALUES ('86', '26', '2', '133', '3', '0', '0', '0', '0', '1', '1514982012');
INSERT INTO `hi_user_course_topic_6` VALUES ('87', '26', '2', '134', '0', '1', '0', '0', '0', '1', '1514982067');
INSERT INTO `hi_user_course_topic_6` VALUES ('88', '26', '2', '209', '0', '1', '0', '0', '0', '1', '1514982139');
INSERT INTO `hi_user_course_topic_6` VALUES ('89', '26', '2', '210', '0', '1', '0', '0', '0', '1', '1514982172');
INSERT INTO `hi_user_course_topic_6` VALUES ('90', '26', '2', '212', '0', '1', '0', '0', '0', '1', '1514982211');
INSERT INTO `hi_user_course_topic_6` VALUES ('91', '26', '2', '213', '0', '1', '0', '0', '0', '1', '1514982384');
INSERT INTO `hi_user_course_topic_6` VALUES ('92', '26', '2', '216', '0', '1', '0', '0', '0', '1', '1514982517');
INSERT INTO `hi_user_course_topic_6` VALUES ('93', '26', '2', '217', '0', '1', '0', '0', '0', '1', '1514982548');
INSERT INTO `hi_user_course_topic_6` VALUES ('94', '26', '2', '219', '0', '1', '0', '0', '0', '1', '1514982640');
INSERT INTO `hi_user_course_topic_6` VALUES ('95', '26', '2', '220', '0', '1', '0', '0', '0', '1', '1514982687');
INSERT INTO `hi_user_course_topic_6` VALUES ('96', '26', '2', '223', '0', '1', '0', '0', '0', '1', '1514982756');
INSERT INTO `hi_user_course_topic_6` VALUES ('97', '26', '2', '225', '0', '1', '0', '0', '0', '1', '1514982886');
INSERT INTO `hi_user_course_topic_6` VALUES ('98', '26', '2', '226', '0', '1', '0', '0', '0', '1', '1514983022');
INSERT INTO `hi_user_course_topic_6` VALUES ('99', '26', '2', '227', '0', '1', '0', '0', '0', '1', '1514983044');
INSERT INTO `hi_user_course_topic_6` VALUES ('100', '26', '2', '263', '0', '1', '0', '0', '0', '1', '1514983188');
INSERT INTO `hi_user_course_topic_6` VALUES ('101', '26', '2', '101', '0', '1', '0', '0', '0', '1', '1514983259');
INSERT INTO `hi_user_course_topic_6` VALUES ('102', '26', '2', '153', '0', '1', '0', '0', '0', '1', '1514983297');
INSERT INTO `hi_user_course_topic_6` VALUES ('103', '26', '2', '154', '0', '1', '0', '0', '0', '1', '1514983313');
INSERT INTO `hi_user_course_topic_6` VALUES ('104', '26', '2', '155', '0', '1', '0', '0', '0', '1', '1514983321');
INSERT INTO `hi_user_course_topic_6` VALUES ('105', '26', '2', '211', '2', '0', '0', '0', '0', '1', '1514983330');
INSERT INTO `hi_user_course_topic_6` VALUES ('106', '26', '2', '215', '0', '1', '0', '0', '0', '1', '1514983344');
INSERT INTO `hi_user_course_topic_6` VALUES ('107', '26', '2', '222', '0', '1', '0', '0', '0', '1', '1514983355');
INSERT INTO `hi_user_course_topic_6` VALUES ('108', '26', '2', '224', '0', '1', '0', '0', '0', '1', '1514983362');
INSERT INTO `hi_user_course_topic_6` VALUES ('109', '26', '2', '246', '0', '1', '0', '0', '0', '1', '1514983371');

-- ----------------------------
-- Table structure for hi_user_course_topic_7
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_course_topic_7`;
CREATE TABLE `hi_user_course_topic_7` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `CourseID` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '课程动态ID',
  `Topic` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '题目ID',
  `CorrectCount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '答对次数',
  `ErrorCount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '答错次数',
  `Enshrine` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否收藏（0：未收藏1:收藏）',
  `Translate` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否使用了翻译',
  `Help` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否使用了帮助',
  `State` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态(0:未完成1:已完成)',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '进入该题目时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UCT` (`Uid`,`CourseID`,`Topic`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=201 DEFAULT CHARSET=utf8 COMMENT='用户题目表';

-- ----------------------------
-- Records of hi_user_course_topic_7
-- ----------------------------
INSERT INTO `hi_user_course_topic_7` VALUES ('1', '17', '2', '145', '3', '0', '0', '0', '0', '1', '1514738874');
INSERT INTO `hi_user_course_topic_7` VALUES ('2', '17', '2', '146', '1', '3', '0', '0', '0', '1', '1514738930');
INSERT INTO `hi_user_course_topic_7` VALUES ('3', '17', '2', '147', '1', '1', '0', '1', '1', '1', '1514738952');
INSERT INTO `hi_user_course_topic_7` VALUES ('4', '17', '2', '148', '1', '1', '0', '0', '0', '1', '1514738962');
INSERT INTO `hi_user_course_topic_7` VALUES ('5', '17', '2', '259', '1', '1', '0', '0', '0', '1', '1514738977');
INSERT INTO `hi_user_course_topic_7` VALUES ('6', '17', '2', '95', '1', '1', '0', '0', '0', '1', '1514739049');
INSERT INTO `hi_user_course_topic_7` VALUES ('7', '17', '2', '103', '1', '1', '0', '0', '0', '1', '1514739060');
INSERT INTO `hi_user_course_topic_7` VALUES ('8', '17', '2', '108', '1', '1', '0', '0', '0', '1', '1514739163');
INSERT INTO `hi_user_course_topic_7` VALUES ('9', '17', '2', '107', '1', '1', '0', '0', '0', '1', '1514739172');
INSERT INTO `hi_user_course_topic_7` VALUES ('10', '17', '2', '109', '1', '1', '0', '0', '0', '1', '1514739182');
INSERT INTO `hi_user_course_topic_7` VALUES ('11', '17', '2', '106', '1', '1', '0', '0', '0', '1', '1514739190');
INSERT INTO `hi_user_course_topic_7` VALUES ('12', '17', '2', '105', '1', '1', '0', '0', '0', '1', '1514739202');
INSERT INTO `hi_user_course_topic_7` VALUES ('13', '17', '2', '104', '2', '1', '0', '0', '0', '1', '1514739209');
INSERT INTO `hi_user_course_topic_7` VALUES ('14', '17', '2', '110', '1', '1', '0', '1', '1', '1', '1514739231');
INSERT INTO `hi_user_course_topic_7` VALUES ('15', '17', '2', '111', '1', '1', '0', '0', '0', '1', '1514739250');
INSERT INTO `hi_user_course_topic_7` VALUES ('16', '17', '2', '112', '1', '1', '0', '0', '0', '1', '1514739268');
INSERT INTO `hi_user_course_topic_7` VALUES ('17', '17', '2', '158', '1', '1', '0', '0', '0', '1', '1514739337');
INSERT INTO `hi_user_course_topic_7` VALUES ('18', '17', '2', '160', '2', '0', '0', '1', '1', '1', '1514739422');
INSERT INTO `hi_user_course_topic_7` VALUES ('19', '17', '2', '161', '1', '1', '0', '0', '0', '1', '1514739447');
INSERT INTO `hi_user_course_topic_7` VALUES ('20', '17', '2', '163', '1', '0', '0', '0', '1', '1', '1514739486');
INSERT INTO `hi_user_course_topic_7` VALUES ('21', '17', '2', '164', '1', '1', '0', '0', '0', '1', '1514739540');
INSERT INTO `hi_user_course_topic_7` VALUES ('22', '17', '2', '165', '0', '1', '0', '0', '0', '1', '1514739560');
INSERT INTO `hi_user_course_topic_7` VALUES ('23', '17', '2', '167', '0', '1', '0', '0', '0', '1', '1514739788');
INSERT INTO `hi_user_course_topic_7` VALUES ('24', '17', '2', '169', '0', '1', '0', '0', '0', '1', '1514739826');
INSERT INTO `hi_user_course_topic_7` VALUES ('25', '17', '2', '171', '1', '0', '0', '0', '1', '1', '1514739869');
INSERT INTO `hi_user_course_topic_7` VALUES ('26', '17', '2', '172', '0', '1', '0', '0', '0', '1', '1514739896');
INSERT INTO `hi_user_course_topic_7` VALUES ('27', '17', '2', '175', '0', '1', '0', '0', '0', '1', '1514739921');
INSERT INTO `hi_user_course_topic_7` VALUES ('28', '17', '2', '176', '0', '1', '0', '0', '0', '1', '1514739942');
INSERT INTO `hi_user_course_topic_7` VALUES ('29', '17', '2', '177', '0', '1', '0', '0', '0', '1', '1514739964');
INSERT INTO `hi_user_course_topic_7` VALUES ('30', '17', '2', '178', '0', '1', '0', '0', '0', '1', '1514740008');
INSERT INTO `hi_user_course_topic_7` VALUES ('31', '17', '2', '179', '0', '1', '0', '0', '0', '1', '1514740024');
INSERT INTO `hi_user_course_topic_7` VALUES ('32', '17', '2', '180', '0', '1', '0', '0', '0', '1', '1514740050');
INSERT INTO `hi_user_course_topic_7` VALUES ('33', '17', '2', '181', '0', '1', '0', '0', '0', '1', '1514740067');
INSERT INTO `hi_user_course_topic_7` VALUES ('34', '17', '2', '182', '1', '1', '0', '0', '0', '1', '1514740084');
INSERT INTO `hi_user_course_topic_7` VALUES ('35', '17', '2', '186', '2', '0', '0', '0', '1', '1', '1514740173');
INSERT INTO `hi_user_course_topic_7` VALUES ('36', '17', '2', '187', '1', '1', '0', '0', '0', '1', '1514740210');
INSERT INTO `hi_user_course_topic_7` VALUES ('37', '17', '2', '188', '2', '0', '0', '1', '0', '1', '1514740226');
INSERT INTO `hi_user_course_topic_7` VALUES ('38', '17', '2', '185', '1', '1', '0', '0', '0', '1', '1514740266');
INSERT INTO `hi_user_course_topic_7` VALUES ('39', '17', '2', '189', '0', '1', '0', '0', '0', '1', '1514740456');
INSERT INTO `hi_user_course_topic_7` VALUES ('40', '17', '2', '261', '0', '1', '0', '0', '0', '1', '1514740553');
INSERT INTO `hi_user_course_topic_7` VALUES ('41', '17', '2', '99', '1', '1', '0', '0', '0', '1', '1514740600');
INSERT INTO `hi_user_course_topic_7` VALUES ('42', '17', '2', '149', '0', '1', '0', '0', '0', '1', '1514740611');
INSERT INTO `hi_user_course_topic_7` VALUES ('43', '17', '2', '150', '0', '1', '0', '0', '0', '1', '1514740621');
INSERT INTO `hi_user_course_topic_7` VALUES ('44', '17', '2', '159', '0', '1', '0', '0', '0', '1', '1514740638');
INSERT INTO `hi_user_course_topic_7` VALUES ('45', '17', '2', '162', '0', '1', '0', '0', '0', '1', '1514740646');
INSERT INTO `hi_user_course_topic_7` VALUES ('46', '17', '2', '168', '1', '1', '0', '0', '0', '1', '1514740657');
INSERT INTO `hi_user_course_topic_7` VALUES ('47', '17', '2', '174', '0', '1', '0', '0', '0', '1', '1514740719');
INSERT INTO `hi_user_course_topic_7` VALUES ('48', '17', '2', '184', '0', '1', '0', '0', '0', '1', '1514740740');
INSERT INTO `hi_user_course_topic_7` VALUES ('49', '17', '2', '96', '0', '1', '0', '0', '0', '1', '1514740786');
INSERT INTO `hi_user_course_topic_7` VALUES ('50', '17', '2', '114', '0', '1', '0', '0', '0', '1', '1514740799');
INSERT INTO `hi_user_course_topic_7` VALUES ('51', '17', '2', '117', '0', '1', '0', '0', '0', '1', '1514740805');
INSERT INTO `hi_user_course_topic_7` VALUES ('52', '17', '2', '116', '0', '1', '0', '0', '0', '1', '1514740810');
INSERT INTO `hi_user_course_topic_7` VALUES ('53', '17', '2', '115', '0', '1', '0', '0', '0', '1', '1514740816');
INSERT INTO `hi_user_course_topic_7` VALUES ('54', '17', '2', '119', '0', '1', '0', '0', '0', '1', '1514740823');
INSERT INTO `hi_user_course_topic_7` VALUES ('55', '17', '2', '113', '0', '1', '0', '0', '0', '1', '1514740828');
INSERT INTO `hi_user_course_topic_7` VALUES ('56', '17', '2', '118', '0', '1', '0', '0', '0', '1', '1514740837');
INSERT INTO `hi_user_course_topic_7` VALUES ('57', '17', '2', '120', '0', '1', '0', '0', '0', '1', '1514740851');
INSERT INTO `hi_user_course_topic_7` VALUES ('58', '17', '2', '121', '0', '1', '0', '0', '0', '1', '1514740866');
INSERT INTO `hi_user_course_topic_7` VALUES ('59', '17', '2', '122', '0', '1', '0', '0', '0', '1', '1514740883');
INSERT INTO `hi_user_course_topic_7` VALUES ('60', '17', '2', '191', '1', '1', '0', '0', '0', '1', '1514741063');
INSERT INTO `hi_user_course_topic_7` VALUES ('61', '17', '2', '192', '0', '1', '0', '0', '0', '1', '1514741085');
INSERT INTO `hi_user_course_topic_7` VALUES ('62', '17', '2', '193', '0', '1', '0', '0', '0', '1', '1514741148');
INSERT INTO `hi_user_course_topic_7` VALUES ('63', '17', '2', '194', '0', '1', '0', '0', '0', '1', '1514741189');
INSERT INTO `hi_user_course_topic_7` VALUES ('64', '17', '2', '195', '0', '1', '0', '0', '0', '1', '1514741208');
INSERT INTO `hi_user_course_topic_7` VALUES ('65', '17', '2', '196', '0', '1', '0', '0', '0', '1', '1514741245');
INSERT INTO `hi_user_course_topic_7` VALUES ('66', '17', '2', '198', '0', '1', '0', '0', '0', '1', '1514741273');
INSERT INTO `hi_user_course_topic_7` VALUES ('67', '17', '2', '200', '2', '0', '0', '0', '1', '1', '1514741338');
INSERT INTO `hi_user_course_topic_7` VALUES ('68', '17', '2', '201', '0', '1', '0', '0', '0', '1', '1514741542');
INSERT INTO `hi_user_course_topic_7` VALUES ('69', '17', '2', '202', '0', '1', '0', '0', '0', '1', '1514741585');
INSERT INTO `hi_user_course_topic_7` VALUES ('70', '17', '2', '208', '0', '1', '0', '0', '0', '1', '1514741732');
INSERT INTO `hi_user_course_topic_7` VALUES ('71', '17', '2', '262', '0', '1', '0', '0', '0', '1', '1514741778');
INSERT INTO `hi_user_course_topic_7` VALUES ('72', '17', '2', '100', '0', '1', '0', '0', '0', '1', '1514741977');
INSERT INTO `hi_user_course_topic_7` VALUES ('73', '17', '2', '151', '0', '1', '0', '0', '0', '1', '1514741992');
INSERT INTO `hi_user_course_topic_7` VALUES ('74', '17', '2', '152', '0', '1', '0', '0', '0', '1', '1514742002');
INSERT INTO `hi_user_course_topic_7` VALUES ('75', '17', '2', '190', '0', '1', '0', '0', '0', '1', '1514742040');
INSERT INTO `hi_user_course_topic_7` VALUES ('76', '17', '2', '197', '0', '1', '0', '0', '0', '1', '1514742049');
INSERT INTO `hi_user_course_topic_7` VALUES ('77', '17', '2', '199', '1', '0', '0', '0', '1', '1', '1514742062');
INSERT INTO `hi_user_course_topic_7` VALUES ('78', '17', '2', '203', '0', '1', '0', '0', '0', '1', '1514742080');
INSERT INTO `hi_user_course_topic_7` VALUES ('79', '17', '2', '205', '0', '1', '0', '0', '0', '1', '1514742090');
INSERT INTO `hi_user_course_topic_7` VALUES ('80', '17', '2', '206', '0', '1', '0', '0', '0', '1', '1514742097');
INSERT INTO `hi_user_course_topic_7` VALUES ('81', '17', '2', '207', '0', '1', '0', '0', '0', '1', '1514742105');
INSERT INTO `hi_user_course_topic_7` VALUES ('82', '17', '2', '245', '0', '1', '0', '0', '0', '1', '1514742119');
INSERT INTO `hi_user_course_topic_7` VALUES ('83', '17', '2', '97', '0', '1', '0', '0', '0', '1', '1514742139');
INSERT INTO `hi_user_course_topic_7` VALUES ('84', '17', '2', '129', '0', '1', '0', '0', '0', '1', '1514742145');
INSERT INTO `hi_user_course_topic_7` VALUES ('85', '17', '2', '127', '0', '1', '0', '0', '0', '1', '1514742150');
INSERT INTO `hi_user_course_topic_7` VALUES ('86', '17', '2', '124', '0', '1', '0', '0', '0', '1', '1514742156');
INSERT INTO `hi_user_course_topic_7` VALUES ('87', '17', '2', '128', '0', '1', '0', '0', '0', '1', '1514742160');
INSERT INTO `hi_user_course_topic_7` VALUES ('88', '17', '2', '126', '0', '1', '0', '0', '0', '1', '1514742163');
INSERT INTO `hi_user_course_topic_7` VALUES ('89', '17', '2', '123', '0', '1', '0', '0', '0', '1', '1514742168');
INSERT INTO `hi_user_course_topic_7` VALUES ('90', '17', '2', '131', '0', '1', '0', '0', '0', '1', '1514742172');
INSERT INTO `hi_user_course_topic_7` VALUES ('91', '17', '2', '130', '0', '1', '0', '0', '0', '1', '1514742177');
INSERT INTO `hi_user_course_topic_7` VALUES ('92', '17', '2', '125', '0', '1', '0', '0', '0', '1', '1514742184');
INSERT INTO `hi_user_course_topic_7` VALUES ('93', '17', '2', '132', '0', '1', '0', '0', '0', '1', '1514742205');
INSERT INTO `hi_user_course_topic_7` VALUES ('94', '17', '2', '133', '0', '1', '0', '0', '0', '1', '1514742218');
INSERT INTO `hi_user_course_topic_7` VALUES ('95', '17', '2', '134', '1', '0', '0', '0', '1', '1', '1514742238');
INSERT INTO `hi_user_course_topic_7` VALUES ('96', '17', '2', '209', '0', '1', '0', '0', '0', '1', '1514742607');
INSERT INTO `hi_user_course_topic_7` VALUES ('97', '17', '2', '210', '0', '1', '0', '0', '0', '1', '1514742635');
INSERT INTO `hi_user_course_topic_7` VALUES ('98', '17', '2', '212', '0', '1', '0', '0', '0', '1', '1514742666');
INSERT INTO `hi_user_course_topic_7` VALUES ('99', '17', '2', '213', '0', '1', '0', '0', '0', '1', '1514742688');
INSERT INTO `hi_user_course_topic_7` VALUES ('100', '17', '2', '216', '2', '0', '0', '0', '0', '1', '1514742742');
INSERT INTO `hi_user_course_topic_7` VALUES ('101', '17', '2', '217', '1', '0', '0', '0', '1', '1', '1514742785');
INSERT INTO `hi_user_course_topic_7` VALUES ('102', '17', '2', '219', '0', '1', '0', '0', '0', '1', '1514742815');
INSERT INTO `hi_user_course_topic_7` VALUES ('103', '17', '2', '220', '0', '1', '0', '0', '0', '1', '1514742837');
INSERT INTO `hi_user_course_topic_7` VALUES ('104', '17', '2', '223', '0', '1', '0', '1', '0', '1', '1514742873');
INSERT INTO `hi_user_course_topic_7` VALUES ('105', '17', '2', '225', '0', '1', '0', '0', '0', '1', '1514742903');
INSERT INTO `hi_user_course_topic_7` VALUES ('106', '17', '2', '226', '0', '1', '0', '0', '0', '1', '1514743008');
INSERT INTO `hi_user_course_topic_7` VALUES ('107', '17', '2', '227', '0', '1', '0', '0', '0', '1', '1514743032');
INSERT INTO `hi_user_course_topic_7` VALUES ('108', '17', '2', '263', '0', '1', '0', '0', '0', '1', '1514743053');
INSERT INTO `hi_user_course_topic_7` VALUES ('109', '17', '2', '101', '1', '1', '0', '0', '0', '1', '1514743064');
INSERT INTO `hi_user_course_topic_7` VALUES ('110', '17', '2', '153', '0', '1', '0', '0', '0', '1', '1514743085');
INSERT INTO `hi_user_course_topic_7` VALUES ('111', '17', '2', '154', '0', '1', '0', '0', '0', '1', '1514743101');
INSERT INTO `hi_user_course_topic_7` VALUES ('112', '17', '2', '155', '0', '1', '0', '0', '0', '1', '1514743110');
INSERT INTO `hi_user_course_topic_7` VALUES ('113', '17', '2', '211', '2', '0', '0', '0', '0', '1', '1514743122');
INSERT INTO `hi_user_course_topic_7` VALUES ('114', '17', '2', '215', '0', '1', '0', '0', '0', '1', '1514743141');
INSERT INTO `hi_user_course_topic_7` VALUES ('115', '17', '2', '222', '0', '1', '0', '0', '0', '1', '1514743152');
INSERT INTO `hi_user_course_topic_7` VALUES ('116', '17', '2', '224', '0', '1', '0', '0', '0', '1', '1514743162');
INSERT INTO `hi_user_course_topic_7` VALUES ('117', '17', '2', '246', '0', '1', '0', '0', '0', '1', '1514743262');
INSERT INTO `hi_user_course_topic_7` VALUES ('118', '17', '2', '98', '0', '1', '0', '0', '0', '1', '1514743278');
INSERT INTO `hi_user_course_topic_7` VALUES ('119', '17', '2', '136', '0', '1', '0', '0', '0', '1', '1514743286');
INSERT INTO `hi_user_course_topic_7` VALUES ('120', '17', '2', '140', '0', '1', '0', '0', '0', '1', '1514743292');
INSERT INTO `hi_user_course_topic_7` VALUES ('121', '17', '2', '138', '0', '1', '0', '0', '0', '1', '1514743297');
INSERT INTO `hi_user_course_topic_7` VALUES ('122', '17', '2', '139', '0', '1', '0', '0', '0', '1', '1514743303');
INSERT INTO `hi_user_course_topic_7` VALUES ('123', '17', '2', '135', '0', '1', '0', '0', '0', '1', '1514743309');
INSERT INTO `hi_user_course_topic_7` VALUES ('124', '17', '2', '141', '0', '1', '0', '0', '0', '1', '1514743313');
INSERT INTO `hi_user_course_topic_7` VALUES ('125', '17', '2', '137', '0', '1', '0', '0', '0', '1', '1514743317');
INSERT INTO `hi_user_course_topic_7` VALUES ('126', '17', '2', '142', '0', '1', '0', '0', '0', '1', '1514743330');
INSERT INTO `hi_user_course_topic_7` VALUES ('127', '17', '2', '143', '0', '1', '0', '0', '0', '1', '1514743344');
INSERT INTO `hi_user_course_topic_7` VALUES ('128', '17', '2', '144', '1', '0', '0', '0', '1', '1', '1514743358');
INSERT INTO `hi_user_course_topic_7` VALUES ('129', '17', '2', '229', '0', '1', '0', '0', '0', '1', '1514743421');
INSERT INTO `hi_user_course_topic_7` VALUES ('130', '17', '2', '231', '0', '1', '0', '0', '0', '1', '1514743451');
INSERT INTO `hi_user_course_topic_7` VALUES ('131', '17', '2', '232', '0', '1', '0', '0', '0', '1', '1514743476');
INSERT INTO `hi_user_course_topic_7` VALUES ('132', '17', '2', '234', '0', '1', '0', '0', '0', '1', '1514743522');
INSERT INTO `hi_user_course_topic_7` VALUES ('133', '17', '2', '236', '0', '1', '0', '0', '0', '1', '1514743554');
INSERT INTO `hi_user_course_topic_7` VALUES ('134', '17', '2', '237', '0', '1', '0', '0', '0', '1', '1514743581');
INSERT INTO `hi_user_course_topic_7` VALUES ('135', '17', '2', '238', '0', '1', '0', '0', '0', '1', '1514743616');
INSERT INTO `hi_user_course_topic_7` VALUES ('136', '17', '2', '240', '0', '1', '0', '0', '0', '1', '1514743665');
INSERT INTO `hi_user_course_topic_7` VALUES ('137', '17', '2', '241', '1', '0', '0', '0', '1', '1', '1514743711');
INSERT INTO `hi_user_course_topic_7` VALUES ('138', '17', '2', '242', '0', '1', '0', '0', '0', '1', '1514743737');
INSERT INTO `hi_user_course_topic_7` VALUES ('139', '17', '2', '243', '0', '1', '0', '0', '0', '1', '1514743759');
INSERT INTO `hi_user_course_topic_7` VALUES ('140', '17', '2', '264', '0', '1', '0', '0', '0', '1', '1514743776');
INSERT INTO `hi_user_course_topic_7` VALUES ('141', '17', '2', '102', '1', '1', '0', '0', '0', '1', '1514743804');
INSERT INTO `hi_user_course_topic_7` VALUES ('142', '17', '2', '156', '0', '1', '0', '0', '0', '1', '1514743815');
INSERT INTO `hi_user_course_topic_7` VALUES ('143', '17', '2', '157', '0', '1', '0', '0', '0', '1', '1514743827');
INSERT INTO `hi_user_course_topic_7` VALUES ('144', '17', '2', '233', '0', '1', '0', '0', '0', '1', '1514743836');
INSERT INTO `hi_user_course_topic_7` VALUES ('145', '17', '2', '235', '0', '1', '0', '0', '0', '1', '1514743845');
INSERT INTO `hi_user_course_topic_7` VALUES ('146', '17', '2', '239', '0', '1', '0', '0', '0', '1', '1514743855');
INSERT INTO `hi_user_course_topic_7` VALUES ('147', '17', '2', '244', '0', '1', '0', '0', '0', '1', '1514743866');
INSERT INTO `hi_user_course_topic_7` VALUES ('148', '17', '2', '247', '0', '1', '0', '0', '0', '1', '1514743876');
INSERT INTO `hi_user_course_topic_7` VALUES ('149', '17', '2', '248', '0', '1', '0', '0', '0', '1', '1514743885');
INSERT INTO `hi_user_course_topic_7` VALUES ('150', '17', '2', '249', '0', '1', '0', '0', '0', '1', '1514743898');
INSERT INTO `hi_user_course_topic_7` VALUES ('151', '17', '2', '250', '0', '1', '0', '0', '0', '1', '1514743906');
INSERT INTO `hi_user_course_topic_7` VALUES ('152', '17', '2', '251', '0', '1', '0', '0', '0', '1', '1514743917');
INSERT INTO `hi_user_course_topic_7` VALUES ('153', '17', '2', '252', '2', '0', '0', '0', '0', '1', '1514743931');
INSERT INTO `hi_user_course_topic_7` VALUES ('154', '17', '2', '253', '0', '1', '0', '0', '0', '1', '1514743950');
INSERT INTO `hi_user_course_topic_7` VALUES ('155', '17', '2', '254', '0', '1', '0', '0', '0', '1', '1514743958');
INSERT INTO `hi_user_course_topic_7` VALUES ('156', '17', '2', '255', '0', '1', '0', '0', '0', '1', '1514743965');
INSERT INTO `hi_user_course_topic_7` VALUES ('157', '17', '2', '256', '0', '1', '0', '0', '0', '1', '1514743979');
INSERT INTO `hi_user_course_topic_7` VALUES ('158', '17', '2', '257', '0', '1', '0', '0', '0', '1', '1514743990');
INSERT INTO `hi_user_course_topic_7` VALUES ('159', '17', '2', '258', '0', '1', '0', '0', '0', '1', '1514744032');
INSERT INTO `hi_user_course_topic_7` VALUES ('160', '17', '2', '260', '1', '0', '0', '1', '1', '1', '1514744052');
INSERT INTO `hi_user_course_topic_7` VALUES ('161', '27', '2', '145', '0', '1', '0', '0', '0', '1', '1514796216');
INSERT INTO `hi_user_course_topic_7` VALUES ('162', '27', '2', '146', '0', '1', '0', '0', '0', '1', '1514796233');
INSERT INTO `hi_user_course_topic_7` VALUES ('163', '27', '2', '147', '0', '1', '0', '0', '0', '1', '1514796254');
INSERT INTO `hi_user_course_topic_7` VALUES ('164', '27', '2', '148', '0', '1', '0', '0', '0', '1', '1514796285');
INSERT INTO `hi_user_course_topic_7` VALUES ('165', '27', '2', '259', '0', '1', '0', '0', '0', '1', '1514796320');
INSERT INTO `hi_user_course_topic_7` VALUES ('166', '27', '2', '95', '0', '1', '0', '0', '0', '1', '1514799026');
INSERT INTO `hi_user_course_topic_7` VALUES ('167', '27', '2', '106', '0', '1', '0', '0', '0', '1', '1514799043');
INSERT INTO `hi_user_course_topic_7` VALUES ('168', '27', '2', '104', '0', '1', '0', '0', '0', '1', '1514799084');
INSERT INTO `hi_user_course_topic_7` VALUES ('169', '27', '2', '103', '0', '1', '0', '0', '0', '1', '1514799110');
INSERT INTO `hi_user_course_topic_7` VALUES ('170', '27', '2', '107', '0', '1', '0', '0', '0', '1', '1514799145');
INSERT INTO `hi_user_course_topic_7` VALUES ('171', '27', '2', '108', '0', '1', '0', '0', '0', '1', '1514799167');
INSERT INTO `hi_user_course_topic_7` VALUES ('172', '27', '2', '105', '0', '1', '0', '0', '0', '1', '1514799178');
INSERT INTO `hi_user_course_topic_7` VALUES ('173', '27', '2', '109', '0', '1', '0', '0', '0', '1', '1514799194');
INSERT INTO `hi_user_course_topic_7` VALUES ('174', '27', '2', '110', '0', '1', '0', '0', '0', '1', '1514799235');
INSERT INTO `hi_user_course_topic_7` VALUES ('175', '27', '2', '111', '0', '1', '0', '0', '0', '1', '1514799275');
INSERT INTO `hi_user_course_topic_7` VALUES ('176', '27', '2', '112', '0', '1', '0', '0', '0', '1', '1514799312');
INSERT INTO `hi_user_course_topic_7` VALUES ('177', '27', '2', '158', '2', '2', '0', '0', '0', '1', '1514799399');
INSERT INTO `hi_user_course_topic_7` VALUES ('178', '27', '2', '161', '0', '1', '0', '0', '0', '1', '1514799562');
INSERT INTO `hi_user_course_topic_7` VALUES ('179', '27', '2', '163', '0', '1', '0', '0', '0', '1', '1514799678');
INSERT INTO `hi_user_course_topic_7` VALUES ('180', '27', '2', '164', '0', '1', '0', '0', '0', '1', '1514799728');
INSERT INTO `hi_user_course_topic_7` VALUES ('181', '27', '2', '165', '0', '1', '0', '0', '0', '1', '1514799751');
INSERT INTO `hi_user_course_topic_7` VALUES ('182', '27', '2', '167', '0', '1', '0', '0', '0', '1', '1514799838');
INSERT INTO `hi_user_course_topic_7` VALUES ('183', '27', '2', '169', '2', '0', '0', '0', '0', '1', '1514799884');
INSERT INTO `hi_user_course_topic_7` VALUES ('184', '27', '2', '172', '0', '1', '0', '0', '0', '1', '1514799969');
INSERT INTO `hi_user_course_topic_7` VALUES ('185', '27', '2', '175', '0', '1', '0', '0', '0', '1', '1514800130');
INSERT INTO `hi_user_course_topic_7` VALUES ('186', '27', '2', '176', '0', '1', '0', '0', '0', '1', '1514800163');
INSERT INTO `hi_user_course_topic_7` VALUES ('187', '27', '2', '177', '0', '1', '0', '0', '0', '1', '1514800188');
INSERT INTO `hi_user_course_topic_7` VALUES ('188', '27', '2', '178', '0', '1', '0', '0', '0', '1', '1514800583');
INSERT INTO `hi_user_course_topic_7` VALUES ('189', '27', '2', '179', '0', '1', '0', '0', '0', '1', '1514800595');
INSERT INTO `hi_user_course_topic_7` VALUES ('190', '27', '2', '185', '2', '1', '0', '0', '0', '1', '1514801165');
INSERT INTO `hi_user_course_topic_7` VALUES ('191', '27', '2', '261', '0', '1', '0', '0', '0', '1', '1514801323');
INSERT INTO `hi_user_course_topic_7` VALUES ('192', '27', '2', '99', '0', '1', '0', '0', '0', '1', '1514801421');
INSERT INTO `hi_user_course_topic_7` VALUES ('193', '27', '2', '149', '0', '1', '0', '0', '0', '1', '1514801492');
INSERT INTO `hi_user_course_topic_7` VALUES ('194', '27', '2', '150', '0', '1', '0', '0', '0', '1', '1514801516');
INSERT INTO `hi_user_course_topic_7` VALUES ('195', '27', '2', '159', '0', '1', '0', '0', '0', '1', '1514801555');
INSERT INTO `hi_user_course_topic_7` VALUES ('196', '27', '2', '162', '0', '1', '0', '0', '0', '1', '1514801586');
INSERT INTO `hi_user_course_topic_7` VALUES ('197', '27', '2', '168', '0', '1', '0', '0', '0', '1', '1514801603');
INSERT INTO `hi_user_course_topic_7` VALUES ('198', '27', '2', '174', '0', '1', '0', '0', '0', '1', '1514801635');
INSERT INTO `hi_user_course_topic_7` VALUES ('199', '27', '2', '184', '0', '1', '0', '0', '0', '1', '1514801691');
INSERT INTO `hi_user_course_topic_7` VALUES ('200', '27', '2', '189', '0', '1', '0', '0', '0', '1', '1514801715');

-- ----------------------------
-- Table structure for hi_user_course_topic_8
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_course_topic_8`;
CREATE TABLE `hi_user_course_topic_8` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `CourseID` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '课程动态ID',
  `Topic` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '题目ID',
  `CorrectCount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '答对次数',
  `ErrorCount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '答错次数',
  `Enshrine` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否收藏（0：未收藏1:收藏）',
  `Translate` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否使用了翻译',
  `Help` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否使用了帮助',
  `State` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态(0:未完成1:已完成)',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '进入该题目时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UCT` (`Uid`,`CourseID`,`Topic`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=211 DEFAULT CHARSET=utf8 COMMENT='用户题目表';

-- ----------------------------
-- Records of hi_user_course_topic_8
-- ----------------------------
INSERT INTO `hi_user_course_topic_8` VALUES ('1', '18', '2', '145', '0', '1', '0', '0', '0', '1', '1514710295');
INSERT INTO `hi_user_course_topic_8` VALUES ('2', '18', '2', '146', '0', '1', '0', '0', '0', '1', '1514710305');
INSERT INTO `hi_user_course_topic_8` VALUES ('3', '18', '2', '147', '0', '1', '0', '0', '0', '1', '1514710311');
INSERT INTO `hi_user_course_topic_8` VALUES ('4', '18', '2', '148', '0', '1', '0', '0', '0', '1', '1514710322');
INSERT INTO `hi_user_course_topic_8` VALUES ('5', '18', '2', '259', '0', '1', '0', '0', '0', '1', '1514710328');
INSERT INTO `hi_user_course_topic_8` VALUES ('6', '18', '2', '95', '0', '1', '0', '0', '0', '1', '1514710339');
INSERT INTO `hi_user_course_topic_8` VALUES ('7', '18', '2', '104', '0', '1', '0', '0', '0', '1', '1514710345');
INSERT INTO `hi_user_course_topic_8` VALUES ('8', '18', '2', '107', '0', '1', '0', '0', '0', '1', '1514710348');
INSERT INTO `hi_user_course_topic_8` VALUES ('9', '18', '2', '109', '0', '1', '0', '0', '0', '1', '1514710349');
INSERT INTO `hi_user_course_topic_8` VALUES ('10', '18', '2', '103', '1', '1', '0', '0', '0', '1', '1514710350');
INSERT INTO `hi_user_course_topic_8` VALUES ('11', '18', '2', '106', '0', '1', '0', '0', '0', '1', '1514710351');
INSERT INTO `hi_user_course_topic_8` VALUES ('12', '18', '2', '108', '0', '1', '0', '0', '0', '1', '1514710352');
INSERT INTO `hi_user_course_topic_8` VALUES ('13', '18', '2', '105', '0', '1', '0', '0', '0', '1', '1514710353');
INSERT INTO `hi_user_course_topic_8` VALUES ('14', '18', '2', '110', '0', '1', '0', '0', '1', '1', '1514876038');
INSERT INTO `hi_user_course_topic_8` VALUES ('15', '18', '2', '111', '0', '1', '0', '0', '1', '1', '1514875952');
INSERT INTO `hi_user_course_topic_8` VALUES ('16', '18', '2', '112', '0', '1', '0', '0', '0', '1', '1514710384');
INSERT INTO `hi_user_course_topic_8` VALUES ('17', '18', '2', '158', '4', '1', '0', '0', '0', '1', '1514710450');
INSERT INTO `hi_user_course_topic_8` VALUES ('18', '18', '2', '160', '2', '1', '0', '0', '0', '1', '1514710532');
INSERT INTO `hi_user_course_topic_8` VALUES ('19', '18', '2', '161', '2', '1', '0', '0', '0', '1', '1514710538');
INSERT INTO `hi_user_course_topic_8` VALUES ('20', '18', '2', '163', '1', '1', '0', '0', '0', '1', '1514710545');
INSERT INTO `hi_user_course_topic_8` VALUES ('21', '18', '2', '164', '1', '1', '0', '0', '0', '1', '1514710552');
INSERT INTO `hi_user_course_topic_8` VALUES ('22', '18', '2', '165', '3', '1', '0', '0', '0', '1', '1514710560');
INSERT INTO `hi_user_course_topic_8` VALUES ('23', '18', '2', '166', '0', '1', '0', '0', '0', '1', '1514710566');
INSERT INTO `hi_user_course_topic_8` VALUES ('24', '18', '2', '167', '3', '2', '0', '0', '0', '1', '1514710797');
INSERT INTO `hi_user_course_topic_8` VALUES ('25', '18', '2', '169', '1', '1', '0', '0', '0', '1', '1514710806');
INSERT INTO `hi_user_course_topic_8` VALUES ('26', '18', '2', '171', '2', '1', '0', '0', '0', '1', '1514710816');
INSERT INTO `hi_user_course_topic_8` VALUES ('27', '18', '2', '172', '2', '1', '0', '0', '0', '1', '1514710830');
INSERT INTO `hi_user_course_topic_8` VALUES ('28', '18', '2', '175', '1', '1', '0', '0', '0', '1', '1514710849');
INSERT INTO `hi_user_course_topic_8` VALUES ('29', '18', '2', '176', '1', '1', '0', '0', '0', '1', '1514710858');
INSERT INTO `hi_user_course_topic_8` VALUES ('30', '18', '2', '177', '1', '1', '0', '0', '0', '1', '1514710867');
INSERT INTO `hi_user_course_topic_8` VALUES ('31', '18', '2', '178', '2', '1', '0', '0', '0', '1', '1514710876');
INSERT INTO `hi_user_course_topic_8` VALUES ('32', '18', '2', '179', '3', '1', '0', '0', '0', '1', '1514710887');
INSERT INTO `hi_user_course_topic_8` VALUES ('33', '18', '2', '180', '1', '1', '0', '0', '0', '1', '1514710900');
INSERT INTO `hi_user_course_topic_8` VALUES ('34', '18', '2', '181', '1', '1', '0', '0', '0', '1', '1514710905');
INSERT INTO `hi_user_course_topic_8` VALUES ('35', '18', '2', '182', '1', '1', '0', '0', '0', '1', '1514710911');
INSERT INTO `hi_user_course_topic_8` VALUES ('36', '18', '2', '185', '2', '1', '0', '0', '0', '1', '1514710929');
INSERT INTO `hi_user_course_topic_8` VALUES ('37', '18', '2', '186', '1', '1', '0', '0', '0', '1', '1514710935');
INSERT INTO `hi_user_course_topic_8` VALUES ('38', '18', '2', '187', '1', '1', '0', '0', '0', '1', '1514710950');
INSERT INTO `hi_user_course_topic_8` VALUES ('39', '18', '2', '188', '3', '0', '0', '0', '0', '1', '1514710956');
INSERT INTO `hi_user_course_topic_8` VALUES ('40', '18', '2', '189', '0', '1', '0', '0', '0', '1', '1514710977');
INSERT INTO `hi_user_course_topic_8` VALUES ('41', '18', '2', '261', '2', '1', '0', '0', '0', '1', '1514713883');
INSERT INTO `hi_user_course_topic_8` VALUES ('42', '18', '2', '99', '0', '1', '0', '0', '0', '1', '1514713896');
INSERT INTO `hi_user_course_topic_8` VALUES ('43', '18', '2', '149', '0', '1', '0', '0', '0', '1', '1514713902');
INSERT INTO `hi_user_course_topic_8` VALUES ('44', '18', '2', '150', '0', '1', '0', '0', '0', '1', '1514713905');
INSERT INTO `hi_user_course_topic_8` VALUES ('45', '18', '2', '159', '0', '1', '0', '0', '0', '1', '1514714008');
INSERT INTO `hi_user_course_topic_8` VALUES ('46', '18', '2', '162', '0', '1', '0', '0', '0', '1', '1514714019');
INSERT INTO `hi_user_course_topic_8` VALUES ('47', '18', '2', '168', '0', '1', '0', '0', '0', '1', '1514714025');
INSERT INTO `hi_user_course_topic_8` VALUES ('48', '18', '2', '170', '0', '1', '0', '0', '0', '1', '1514714028');
INSERT INTO `hi_user_course_topic_8` VALUES ('49', '18', '2', '173', '0', '1', '0', '0', '0', '1', '1514714032');
INSERT INTO `hi_user_course_topic_8` VALUES ('50', '18', '2', '174', '0', '1', '0', '0', '0', '1', '1514714037');
INSERT INTO `hi_user_course_topic_8` VALUES ('51', '18', '2', '183', '0', '1', '0', '0', '0', '1', '1514714043');
INSERT INTO `hi_user_course_topic_8` VALUES ('52', '18', '2', '184', '0', '1', '0', '0', '0', '1', '1514714047');
INSERT INTO `hi_user_course_topic_8` VALUES ('53', '18', '2', '96', '0', '1', '0', '0', '0', '1', '1514714060');
INSERT INTO `hi_user_course_topic_8` VALUES ('54', '18', '2', '113', '0', '1', '0', '0', '0', '1', '1514714065');
INSERT INTO `hi_user_course_topic_8` VALUES ('55', '18', '2', '118', '0', '1', '0', '0', '0', '1', '1514714068');
INSERT INTO `hi_user_course_topic_8` VALUES ('56', '18', '2', '117', '0', '1', '0', '0', '0', '1', '1514714069');
INSERT INTO `hi_user_course_topic_8` VALUES ('57', '18', '2', '116', '0', '1', '0', '0', '0', '1', '1514714070');
INSERT INTO `hi_user_course_topic_8` VALUES ('58', '18', '2', '115', '0', '1', '0', '0', '0', '1', '1514714071');
INSERT INTO `hi_user_course_topic_8` VALUES ('59', '18', '2', '119', '0', '1', '0', '0', '0', '1', '1514714072');
INSERT INTO `hi_user_course_topic_8` VALUES ('60', '18', '2', '114', '0', '1', '0', '0', '0', '1', '1514714073');
INSERT INTO `hi_user_course_topic_8` VALUES ('61', '18', '2', '120', '0', '1', '0', '0', '0', '1', '1514714079');
INSERT INTO `hi_user_course_topic_8` VALUES ('62', '18', '2', '121', '0', '1', '0', '0', '0', '1', '1514714087');
INSERT INTO `hi_user_course_topic_8` VALUES ('63', '18', '2', '122', '0', '1', '0', '0', '0', '1', '1514714098');
INSERT INTO `hi_user_course_topic_8` VALUES ('64', '18', '2', '191', '0', '1', '0', '0', '0', '1', '1514714114');
INSERT INTO `hi_user_course_topic_8` VALUES ('65', '18', '2', '192', '0', '1', '0', '0', '0', '1', '1514714124');
INSERT INTO `hi_user_course_topic_8` VALUES ('66', '18', '2', '193', '0', '1', '0', '0', '0', '1', '1514714143');
INSERT INTO `hi_user_course_topic_8` VALUES ('67', '18', '2', '194', '2', '0', '0', '0', '0', '1', '1514714149');
INSERT INTO `hi_user_course_topic_8` VALUES ('68', '18', '2', '195', '2', '0', '0', '0', '0', '1', '1514714162');
INSERT INTO `hi_user_course_topic_8` VALUES ('69', '18', '2', '196', '0', '1', '0', '0', '0', '1', '1514714172');
INSERT INTO `hi_user_course_topic_8` VALUES ('70', '18', '2', '198', '0', '1', '0', '0', '0', '1', '1514714182');
INSERT INTO `hi_user_course_topic_8` VALUES ('71', '18', '2', '200', '0', '1', '0', '0', '0', '1', '1514714191');
INSERT INTO `hi_user_course_topic_8` VALUES ('72', '18', '2', '201', '0', '1', '0', '0', '0', '1', '1514714198');
INSERT INTO `hi_user_course_topic_8` VALUES ('73', '18', '2', '202', '0', '1', '0', '0', '0', '1', '1514714207');
INSERT INTO `hi_user_course_topic_8` VALUES ('74', '18', '2', '204', '2', '0', '0', '0', '0', '1', '1514714234');
INSERT INTO `hi_user_course_topic_8` VALUES ('75', '18', '2', '208', '0', '1', '0', '0', '0', '1', '1514714254');
INSERT INTO `hi_user_course_topic_8` VALUES ('76', '18', '2', '262', '0', '1', '0', '0', '0', '1', '1514714268');
INSERT INTO `hi_user_course_topic_8` VALUES ('77', '18', '2', '100', '0', '1', '0', '0', '0', '1', '1514714285');
INSERT INTO `hi_user_course_topic_8` VALUES ('78', '18', '2', '151', '0', '1', '0', '0', '0', '1', '1514714293');
INSERT INTO `hi_user_course_topic_8` VALUES ('79', '18', '2', '152', '0', '1', '0', '0', '0', '1', '1514714299');
INSERT INTO `hi_user_course_topic_8` VALUES ('80', '18', '2', '190', '0', '1', '0', '0', '0', '1', '1514714304');
INSERT INTO `hi_user_course_topic_8` VALUES ('81', '18', '2', '197', '0', '1', '0', '0', '0', '1', '1514714307');
INSERT INTO `hi_user_course_topic_8` VALUES ('82', '18', '2', '199', '0', '1', '0', '0', '0', '1', '1514714311');
INSERT INTO `hi_user_course_topic_8` VALUES ('83', '18', '2', '203', '0', '1', '0', '0', '0', '1', '1514714316');
INSERT INTO `hi_user_course_topic_8` VALUES ('84', '18', '2', '205', '0', '1', '0', '0', '0', '1', '1514714319');
INSERT INTO `hi_user_course_topic_8` VALUES ('85', '18', '2', '206', '0', '1', '0', '0', '0', '1', '1514714321');
INSERT INTO `hi_user_course_topic_8` VALUES ('86', '18', '2', '207', '0', '1', '0', '0', '0', '1', '1514714323');
INSERT INTO `hi_user_course_topic_8` VALUES ('87', '18', '2', '245', '2', '0', '0', '0', '0', '1', '1514714340');
INSERT INTO `hi_user_course_topic_8` VALUES ('88', '18', '2', '97', '0', '1', '0', '0', '0', '1', '1514714355');
INSERT INTO `hi_user_course_topic_8` VALUES ('89', '18', '2', '125', '0', '1', '0', '0', '0', '1', '1514714360');
INSERT INTO `hi_user_course_topic_8` VALUES ('90', '18', '2', '131', '0', '1', '0', '0', '0', '1', '1514714361');
INSERT INTO `hi_user_course_topic_8` VALUES ('91', '18', '2', '129', '0', '1', '0', '0', '0', '1', '1514714362');
INSERT INTO `hi_user_course_topic_8` VALUES ('92', '18', '2', '127', '0', '1', '0', '0', '0', '1', '1514714363');
INSERT INTO `hi_user_course_topic_8` VALUES ('93', '18', '2', '123', '0', '1', '0', '0', '0', '1', '1514714364');
INSERT INTO `hi_user_course_topic_8` VALUES ('94', '18', '2', '128', '0', '1', '0', '0', '0', '1', '1514714366');
INSERT INTO `hi_user_course_topic_8` VALUES ('95', '18', '2', '124', '0', '1', '0', '0', '0', '1', '1514714367');
INSERT INTO `hi_user_course_topic_8` VALUES ('96', '18', '2', '126', '0', '1', '0', '0', '0', '1', '1514714368');
INSERT INTO `hi_user_course_topic_8` VALUES ('97', '18', '2', '130', '0', '1', '0', '0', '0', '1', '1514714369');
INSERT INTO `hi_user_course_topic_8` VALUES ('98', '18', '2', '132', '0', '1', '0', '0', '0', '1', '1514714373');
INSERT INTO `hi_user_course_topic_8` VALUES ('99', '18', '2', '133', '0', '1', '0', '0', '0', '1', '1514714379');
INSERT INTO `hi_user_course_topic_8` VALUES ('100', '18', '2', '134', '0', '1', '0', '0', '0', '1', '1514714389');
INSERT INTO `hi_user_course_topic_8` VALUES ('101', '18', '2', '209', '0', '1', '0', '0', '0', '1', '1514714401');
INSERT INTO `hi_user_course_topic_8` VALUES ('102', '18', '2', '210', '0', '1', '0', '0', '0', '1', '1514714412');
INSERT INTO `hi_user_course_topic_8` VALUES ('103', '18', '2', '212', '0', '1', '0', '0', '0', '1', '1514714424');
INSERT INTO `hi_user_course_topic_8` VALUES ('104', '18', '2', '213', '0', '1', '0', '0', '0', '1', '1514714432');
INSERT INTO `hi_user_course_topic_8` VALUES ('105', '18', '2', '214', '0', '1', '0', '0', '0', '1', '1514714437');
INSERT INTO `hi_user_course_topic_8` VALUES ('106', '18', '2', '216', '0', '1', '0', '0', '0', '1', '1514714444');
INSERT INTO `hi_user_course_topic_8` VALUES ('107', '18', '2', '217', '0', '1', '0', '0', '0', '1', '1514714450');
INSERT INTO `hi_user_course_topic_8` VALUES ('108', '18', '2', '219', '0', '1', '0', '0', '0', '1', '1514714456');
INSERT INTO `hi_user_course_topic_8` VALUES ('109', '18', '2', '220', '0', '1', '0', '0', '0', '1', '1514714461');
INSERT INTO `hi_user_course_topic_8` VALUES ('110', '18', '2', '221', '0', '1', '0', '0', '0', '1', '1514714474');
INSERT INTO `hi_user_course_topic_8` VALUES ('111', '18', '2', '223', '0', '1', '0', '0', '0', '1', '1514714488');
INSERT INTO `hi_user_course_topic_8` VALUES ('112', '18', '2', '225', '0', '1', '0', '0', '0', '1', '1514714494');
INSERT INTO `hi_user_course_topic_8` VALUES ('113', '18', '2', '226', '0', '1', '0', '0', '0', '1', '1514714508');
INSERT INTO `hi_user_course_topic_8` VALUES ('114', '18', '2', '227', '0', '1', '0', '0', '0', '1', '1514714518');
INSERT INTO `hi_user_course_topic_8` VALUES ('115', '18', '2', '228', '0', '1', '0', '0', '0', '1', '1514714526');
INSERT INTO `hi_user_course_topic_8` VALUES ('116', '18', '2', '263', '0', '1', '0', '0', '0', '1', '1514714547');
INSERT INTO `hi_user_course_topic_8` VALUES ('117', '18', '2', '101', '0', '1', '0', '0', '0', '1', '1514714570');
INSERT INTO `hi_user_course_topic_8` VALUES ('118', '18', '2', '153', '0', '1', '0', '0', '0', '1', '1514714595');
INSERT INTO `hi_user_course_topic_8` VALUES ('119', '18', '2', '154', '0', '1', '0', '0', '0', '1', '1514714637');
INSERT INTO `hi_user_course_topic_8` VALUES ('120', '18', '2', '155', '0', '1', '0', '0', '0', '1', '1514715168');
INSERT INTO `hi_user_course_topic_8` VALUES ('121', '18', '2', '211', '0', '1', '0', '0', '0', '1', '1514715183');
INSERT INTO `hi_user_course_topic_8` VALUES ('122', '18', '2', '215', '0', '1', '0', '0', '0', '1', '1514715188');
INSERT INTO `hi_user_course_topic_8` VALUES ('123', '18', '2', '218', '0', '1', '0', '0', '0', '1', '1514715212');
INSERT INTO `hi_user_course_topic_8` VALUES ('124', '18', '2', '222', '2', '0', '0', '0', '0', '1', '1514715217');
INSERT INTO `hi_user_course_topic_8` VALUES ('125', '18', '2', '224', '0', '1', '0', '0', '0', '1', '1514715244');
INSERT INTO `hi_user_course_topic_8` VALUES ('126', '18', '2', '246', '0', '1', '0', '0', '0', '1', '1514715247');
INSERT INTO `hi_user_course_topic_8` VALUES ('127', '18', '2', '98', '0', '1', '0', '0', '0', '1', '1514715399');
INSERT INTO `hi_user_course_topic_8` VALUES ('128', '18', '2', '140', '1', '1', '0', '0', '0', '1', '1514715405');
INSERT INTO `hi_user_course_topic_8` VALUES ('129', '18', '2', '137', '1', '1', '0', '0', '0', '1', '1514715406');
INSERT INTO `hi_user_course_topic_8` VALUES ('130', '18', '2', '141', '1', '1', '0', '0', '0', '1', '1514715408');
INSERT INTO `hi_user_course_topic_8` VALUES ('131', '18', '2', '135', '1', '1', '0', '0', '0', '1', '1514715409');
INSERT INTO `hi_user_course_topic_8` VALUES ('132', '18', '2', '136', '1', '1', '0', '0', '0', '1', '1514715410');
INSERT INTO `hi_user_course_topic_8` VALUES ('133', '18', '2', '138', '1', '1', '0', '0', '0', '1', '1514715414');
INSERT INTO `hi_user_course_topic_8` VALUES ('134', '18', '2', '139', '1', '1', '0', '0', '0', '1', '1514715415');
INSERT INTO `hi_user_course_topic_8` VALUES ('135', '18', '2', '142', '0', '1', '0', '0', '0', '1', '1514715475');
INSERT INTO `hi_user_course_topic_8` VALUES ('136', '18', '2', '143', '0', '1', '0', '0', '0', '1', '1514715485');
INSERT INTO `hi_user_course_topic_8` VALUES ('137', '18', '2', '144', '0', '1', '0', '0', '0', '1', '1514715502');
INSERT INTO `hi_user_course_topic_8` VALUES ('138', '18', '2', '229', '0', '1', '0', '0', '0', '1', '1514715514');
INSERT INTO `hi_user_course_topic_8` VALUES ('139', '18', '2', '231', '0', '1', '0', '0', '0', '1', '1514715524');
INSERT INTO `hi_user_course_topic_8` VALUES ('140', '18', '2', '232', '0', '1', '0', '0', '0', '1', '1514715532');
INSERT INTO `hi_user_course_topic_8` VALUES ('141', '18', '2', '234', '0', '1', '0', '0', '0', '1', '1514715540');
INSERT INTO `hi_user_course_topic_8` VALUES ('142', '18', '2', '236', '0', '1', '0', '0', '0', '1', '1514715547');
INSERT INTO `hi_user_course_topic_8` VALUES ('143', '18', '2', '237', '0', '1', '0', '0', '0', '1', '1514715555');
INSERT INTO `hi_user_course_topic_8` VALUES ('144', '18', '2', '238', '0', '1', '0', '0', '0', '1', '1514715567');
INSERT INTO `hi_user_course_topic_8` VALUES ('145', '18', '2', '240', '0', '1', '0', '0', '0', '1', '1514715575');
INSERT INTO `hi_user_course_topic_8` VALUES ('146', '18', '2', '241', '0', '1', '0', '0', '0', '1', '1514715602');
INSERT INTO `hi_user_course_topic_8` VALUES ('147', '18', '2', '242', '0', '1', '0', '0', '0', '1', '1514715611');
INSERT INTO `hi_user_course_topic_8` VALUES ('148', '18', '2', '243', '0', '1', '0', '0', '0', '1', '1514715618');
INSERT INTO `hi_user_course_topic_8` VALUES ('149', '18', '2', '264', '0', '1', '0', '0', '0', '1', '1514715627');
INSERT INTO `hi_user_course_topic_8` VALUES ('150', '18', '2', '102', '0', '1', '0', '0', '0', '1', '1514715650');
INSERT INTO `hi_user_course_topic_8` VALUES ('151', '18', '2', '156', '1', '2', '0', '0', '0', '1', '1514715660');
INSERT INTO `hi_user_course_topic_8` VALUES ('152', '18', '2', '157', '1', '1', '0', '0', '0', '1', '1514715966');
INSERT INTO `hi_user_course_topic_8` VALUES ('153', '18', '2', '230', '1', '1', '0', '0', '0', '1', '1514715973');
INSERT INTO `hi_user_course_topic_8` VALUES ('154', '18', '2', '233', '1', '1', '0', '0', '0', '1', '1514715981');
INSERT INTO `hi_user_course_topic_8` VALUES ('155', '18', '2', '235', '3', '0', '0', '0', '0', '1', '1514716006');
INSERT INTO `hi_user_course_topic_8` VALUES ('156', '18', '2', '239', '1', '1', '0', '0', '0', '1', '1514716017');
INSERT INTO `hi_user_course_topic_8` VALUES ('157', '18', '2', '244', '1', '1', '0', '0', '0', '1', '1514716025');
INSERT INTO `hi_user_course_topic_8` VALUES ('158', '18', '2', '247', '1', '1', '0', '0', '0', '1', '1514716032');
INSERT INTO `hi_user_course_topic_8` VALUES ('159', '18', '2', '248', '0', '1', '0', '0', '0', '1', '1514728689');
INSERT INTO `hi_user_course_topic_8` VALUES ('160', '18', '2', '249', '0', '1', '0', '0', '0', '1', '1514728702');
INSERT INTO `hi_user_course_topic_8` VALUES ('161', '18', '2', '250', '0', '1', '0', '0', '0', '1', '1514728709');
INSERT INTO `hi_user_course_topic_8` VALUES ('162', '18', '2', '251', '0', '1', '0', '0', '0', '1', '1514728721');
INSERT INTO `hi_user_course_topic_8` VALUES ('163', '18', '2', '252', '0', '1', '0', '0', '0', '1', '1514728741');
INSERT INTO `hi_user_course_topic_8` VALUES ('164', '18', '2', '253', '0', '1', '0', '0', '0', '1', '1514728753');
INSERT INTO `hi_user_course_topic_8` VALUES ('165', '18', '2', '254', '0', '1', '0', '0', '0', '1', '1514728766');
INSERT INTO `hi_user_course_topic_8` VALUES ('166', '18', '2', '255', '0', '1', '0', '0', '0', '1', '1514728772');
INSERT INTO `hi_user_course_topic_8` VALUES ('167', '18', '2', '256', '0', '1', '0', '0', '0', '1', '1514728777');
INSERT INTO `hi_user_course_topic_8` VALUES ('168', '18', '2', '257', '0', '1', '0', '0', '0', '1', '1514728781');
INSERT INTO `hi_user_course_topic_8` VALUES ('169', '18', '2', '258', '1', '0', '0', '0', '1', '1', '1514728800');
INSERT INTO `hi_user_course_topic_8` VALUES ('170', '18', '2', '260', '0', '1', '0', '1', '0', '1', '1514728861');
INSERT INTO `hi_user_course_topic_8` VALUES ('171', '28', '2', '145', '1', '1', '0', '0', '0', '1', '1514898271');
INSERT INTO `hi_user_course_topic_8` VALUES ('172', '28', '2', '146', '1', '1', '0', '0', '0', '1', '1514898303');
INSERT INTO `hi_user_course_topic_8` VALUES ('173', '28', '2', '147', '1', '1', '0', '0', '0', '1', '1514898320');
INSERT INTO `hi_user_course_topic_8` VALUES ('174', '28', '2', '148', '1', '1', '0', '0', '0', '1', '1514898343');
INSERT INTO `hi_user_course_topic_8` VALUES ('175', '28', '2', '259', '1', '1', '0', '0', '0', '1', '1514898391');
INSERT INTO `hi_user_course_topic_8` VALUES ('176', '28', '2', '95', '1', '1', '0', '0', '0', '1', '1514898518');
INSERT INTO `hi_user_course_topic_8` VALUES ('177', '28', '2', '104', '0', '1', '0', '0', '0', '1', '1514898561');
INSERT INTO `hi_user_course_topic_8` VALUES ('178', '28', '2', '109', '0', '1', '0', '0', '0', '1', '1514898587');
INSERT INTO `hi_user_course_topic_8` VALUES ('179', '28', '2', '107', '0', '1', '0', '0', '0', '1', '1514898601');
INSERT INTO `hi_user_course_topic_8` VALUES ('180', '28', '2', '103', '0', '1', '0', '0', '0', '1', '1514898631');
INSERT INTO `hi_user_course_topic_8` VALUES ('181', '28', '2', '108', '0', '1', '0', '0', '0', '1', '1514898658');
INSERT INTO `hi_user_course_topic_8` VALUES ('182', '28', '2', '105', '0', '1', '0', '0', '0', '1', '1514898673');
INSERT INTO `hi_user_course_topic_8` VALUES ('183', '28', '2', '106', '0', '1', '0', '0', '0', '1', '1514898693');
INSERT INTO `hi_user_course_topic_8` VALUES ('184', '28', '2', '110', '1', '1', '0', '0', '0', '1', '1514898739');
INSERT INTO `hi_user_course_topic_8` VALUES ('185', '28', '2', '111', '1', '1', '0', '0', '0', '1', '1514898780');
INSERT INTO `hi_user_course_topic_8` VALUES ('186', '28', '2', '112', '1', '1', '0', '0', '0', '1', '1514898833');
INSERT INTO `hi_user_course_topic_8` VALUES ('187', '28', '2', '158', '0', '1', '0', '0', '0', '1', '1514967023');
INSERT INTO `hi_user_course_topic_8` VALUES ('188', '28', '2', '161', '0', '1', '0', '0', '0', '1', '1514967151');
INSERT INTO `hi_user_course_topic_8` VALUES ('189', '28', '2', '163', '0', '1', '0', '0', '0', '1', '1514967277');
INSERT INTO `hi_user_course_topic_8` VALUES ('190', '28', '2', '164', '0', '1', '0', '0', '0', '1', '1514967334');
INSERT INTO `hi_user_course_topic_8` VALUES ('191', '28', '2', '165', '0', '1', '0', '0', '0', '1', '1514967363');
INSERT INTO `hi_user_course_topic_8` VALUES ('192', '28', '2', '167', '0', '1', '0', '0', '0', '1', '1514967423');
INSERT INTO `hi_user_course_topic_8` VALUES ('193', '28', '2', '169', '0', '1', '0', '0', '0', '1', '1514967516');
INSERT INTO `hi_user_course_topic_8` VALUES ('194', '28', '2', '172', '0', '1', '0', '0', '0', '1', '1514967582');
INSERT INTO `hi_user_course_topic_8` VALUES ('195', '28', '2', '175', '0', '1', '0', '0', '0', '1', '1514967740');
INSERT INTO `hi_user_course_topic_8` VALUES ('196', '28', '2', '176', '0', '1', '0', '0', '0', '1', '1514967778');
INSERT INTO `hi_user_course_topic_8` VALUES ('197', '28', '2', '177', '0', '1', '0', '0', '0', '1', '1514967805');
INSERT INTO `hi_user_course_topic_8` VALUES ('198', '28', '2', '178', '0', '1', '0', '0', '0', '1', '1514967873');
INSERT INTO `hi_user_course_topic_8` VALUES ('199', '28', '2', '179', '0', '1', '0', '0', '0', '1', '1514967894');
INSERT INTO `hi_user_course_topic_8` VALUES ('200', '28', '2', '185', '0', '1', '0', '0', '0', '1', '1514968226');
INSERT INTO `hi_user_course_topic_8` VALUES ('201', '28', '2', '261', '0', '1', '0', '0', '0', '1', '1514968376');
INSERT INTO `hi_user_course_topic_8` VALUES ('202', '28', '2', '99', '0', '1', '0', '0', '0', '1', '1514968472');
INSERT INTO `hi_user_course_topic_8` VALUES ('203', '28', '2', '149', '0', '1', '0', '0', '0', '1', '1514968494');
INSERT INTO `hi_user_course_topic_8` VALUES ('204', '28', '2', '150', '0', '1', '0', '0', '0', '1', '1514968523');
INSERT INTO `hi_user_course_topic_8` VALUES ('205', '28', '2', '159', '0', '1', '0', '0', '0', '1', '1514968537');
INSERT INTO `hi_user_course_topic_8` VALUES ('206', '28', '2', '162', '0', '1', '0', '0', '0', '1', '1514968557');
INSERT INTO `hi_user_course_topic_8` VALUES ('207', '28', '2', '168', '0', '1', '0', '0', '0', '1', '1514968575');
INSERT INTO `hi_user_course_topic_8` VALUES ('208', '28', '2', '174', '0', '1', '0', '0', '0', '1', '1514968591');
INSERT INTO `hi_user_course_topic_8` VALUES ('209', '28', '2', '184', '0', '1', '0', '0', '0', '1', '1514968632');
INSERT INTO `hi_user_course_topic_8` VALUES ('210', '28', '2', '189', '0', '1', '0', '0', '0', '1', '1514968705');

-- ----------------------------
-- Table structure for hi_user_course_topic_9
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_course_topic_9`;
CREATE TABLE `hi_user_course_topic_9` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `CourseID` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '课程动态ID',
  `Topic` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '题目ID',
  `CorrectCount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '答对次数',
  `ErrorCount` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '答错次数',
  `Enshrine` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否收藏（0：未收藏1:收藏）',
  `Translate` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否使用了翻译',
  `Help` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否使用了帮助',
  `State` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态(0:未完成1:已完成)',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '进入该题目时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UCT` (`Uid`,`CourseID`,`Topic`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=90 DEFAULT CHARSET=utf8 COMMENT='用户题目表';

-- ----------------------------
-- Records of hi_user_course_topic_9
-- ----------------------------
INSERT INTO `hi_user_course_topic_9` VALUES ('1', '29', '2', '145', '0', '1', '0', '0', '0', '1', '1514809175');
INSERT INTO `hi_user_course_topic_9` VALUES ('2', '29', '2', '146', '0', '1', '0', '0', '0', '1', '1514809189');
INSERT INTO `hi_user_course_topic_9` VALUES ('3', '29', '2', '147', '0', '1', '0', '0', '0', '1', '1514809199');
INSERT INTO `hi_user_course_topic_9` VALUES ('4', '29', '2', '148', '0', '1', '0', '0', '0', '1', '1514809209');
INSERT INTO `hi_user_course_topic_9` VALUES ('5', '29', '2', '259', '0', '1', '0', '0', '0', '1', '1514809250');
INSERT INTO `hi_user_course_topic_9` VALUES ('6', '29', '2', '95', '1', '1', '0', '0', '0', '1', '1514809337');
INSERT INTO `hi_user_course_topic_9` VALUES ('7', '29', '2', '103', '1', '1', '0', '0', '0', '1', '1514809375');
INSERT INTO `hi_user_course_topic_9` VALUES ('8', '29', '2', '105', '1', '1', '0', '0', '0', '1', '1514809384');
INSERT INTO `hi_user_course_topic_9` VALUES ('9', '29', '2', '108', '1', '1', '0', '0', '0', '1', '1514809391');
INSERT INTO `hi_user_course_topic_9` VALUES ('10', '29', '2', '104', '1', '1', '0', '0', '0', '1', '1514809397');
INSERT INTO `hi_user_course_topic_9` VALUES ('11', '29', '2', '109', '1', '1', '0', '0', '0', '1', '1514809403');
INSERT INTO `hi_user_course_topic_9` VALUES ('12', '29', '2', '107', '1', '1', '0', '0', '0', '1', '1514809409');
INSERT INTO `hi_user_course_topic_9` VALUES ('13', '29', '2', '106', '1', '1', '0', '0', '0', '1', '1514809415');
INSERT INTO `hi_user_course_topic_9` VALUES ('14', '29', '2', '110', '1', '1', '0', '0', '1', '1', '1514809452');
INSERT INTO `hi_user_course_topic_9` VALUES ('15', '29', '2', '111', '0', '1', '0', '0', '0', '1', '1514809594');
INSERT INTO `hi_user_course_topic_9` VALUES ('16', '29', '2', '112', '0', '1', '0', '0', '0', '1', '1514809619');
INSERT INTO `hi_user_course_topic_9` VALUES ('17', '29', '2', '158', '0', '1', '0', '0', '0', '1', '1514809696');
INSERT INTO `hi_user_course_topic_9` VALUES ('18', '29', '2', '161', '0', '1', '0', '0', '0', '1', '1514809782');
INSERT INTO `hi_user_course_topic_9` VALUES ('19', '29', '2', '163', '0', '1', '0', '0', '0', '1', '1514809879');
INSERT INTO `hi_user_course_topic_9` VALUES ('20', '29', '2', '164', '0', '1', '0', '0', '0', '1', '1514809926');
INSERT INTO `hi_user_course_topic_9` VALUES ('21', '29', '2', '165', '0', '1', '0', '0', '0', '1', '1514809942');
INSERT INTO `hi_user_course_topic_9` VALUES ('22', '29', '2', '167', '0', '1', '0', '0', '0', '1', '1514809973');
INSERT INTO `hi_user_course_topic_9` VALUES ('23', '29', '2', '169', '2', '0', '0', '0', '0', '1', '1514810020');
INSERT INTO `hi_user_course_topic_9` VALUES ('24', '29', '2', '172', '0', '1', '0', '0', '0', '1', '1514810086');
INSERT INTO `hi_user_course_topic_9` VALUES ('25', '29', '2', '175', '0', '1', '0', '0', '0', '1', '1514810234');
INSERT INTO `hi_user_course_topic_9` VALUES ('26', '29', '2', '176', '0', '1', '0', '0', '0', '1', '1514810254');
INSERT INTO `hi_user_course_topic_9` VALUES ('27', '29', '2', '177', '0', '1', '0', '0', '0', '1', '1514810272');
INSERT INTO `hi_user_course_topic_9` VALUES ('28', '29', '2', '178', '0', '1', '0', '0', '0', '1', '1514810326');
INSERT INTO `hi_user_course_topic_9` VALUES ('29', '29', '2', '179', '0', '1', '0', '0', '0', '1', '1514810339');
INSERT INTO `hi_user_course_topic_9` VALUES ('30', '29', '2', '185', '0', '1', '0', '0', '0', '1', '1514810637');
INSERT INTO `hi_user_course_topic_9` VALUES ('31', '29', '2', '261', '0', '1', '0', '0', '0', '1', '1514810779');
INSERT INTO `hi_user_course_topic_9` VALUES ('32', '29', '2', '99', '0', '1', '0', '0', '0', '1', '1514810870');
INSERT INTO `hi_user_course_topic_9` VALUES ('33', '29', '2', '149', '0', '1', '0', '0', '0', '1', '1514810887');
INSERT INTO `hi_user_course_topic_9` VALUES ('34', '29', '2', '150', '0', '1', '0', '0', '0', '1', '1514810896');
INSERT INTO `hi_user_course_topic_9` VALUES ('35', '29', '2', '159', '2', '0', '0', '0', '0', '1', '1514810999');
INSERT INTO `hi_user_course_topic_9` VALUES ('36', '29', '2', '162', '0', '1', '0', '0', '0', '1', '1514811026');
INSERT INTO `hi_user_course_topic_9` VALUES ('37', '29', '2', '168', '0', '1', '0', '0', '0', '1', '1514811034');
INSERT INTO `hi_user_course_topic_9` VALUES ('38', '29', '2', '174', '0', '1', '0', '0', '0', '1', '1514811044');
INSERT INTO `hi_user_course_topic_9` VALUES ('39', '29', '2', '184', '0', '1', '0', '0', '0', '1', '1514811055');
INSERT INTO `hi_user_course_topic_9` VALUES ('40', '29', '2', '189', '0', '1', '0', '0', '0', '1', '1514811086');
INSERT INTO `hi_user_course_topic_9` VALUES ('41', '29', '2', '96', '0', '1', '0', '0', '0', '1', '1514811133');
INSERT INTO `hi_user_course_topic_9` VALUES ('42', '29', '2', '116', '0', '1', '0', '0', '0', '1', '1514811145');
INSERT INTO `hi_user_course_topic_9` VALUES ('43', '29', '2', '117', '0', '1', '0', '0', '0', '1', '1514811154');
INSERT INTO `hi_user_course_topic_9` VALUES ('44', '29', '2', '113', '0', '1', '0', '0', '0', '1', '1514811162');
INSERT INTO `hi_user_course_topic_9` VALUES ('45', '29', '2', '114', '0', '1', '0', '0', '0', '1', '1514811169');
INSERT INTO `hi_user_course_topic_9` VALUES ('46', '29', '2', '119', '0', '1', '0', '0', '0', '1', '1514811175');
INSERT INTO `hi_user_course_topic_9` VALUES ('47', '29', '2', '115', '0', '1', '0', '0', '0', '1', '1514811185');
INSERT INTO `hi_user_course_topic_9` VALUES ('48', '29', '2', '118', '0', '1', '0', '0', '0', '1', '1514811192');
INSERT INTO `hi_user_course_topic_9` VALUES ('49', '29', '2', '120', '0', '1', '0', '0', '0', '1', '1514811203');
INSERT INTO `hi_user_course_topic_9` VALUES ('50', '29', '2', '121', '0', '1', '0', '0', '0', '1', '1514811221');
INSERT INTO `hi_user_course_topic_9` VALUES ('51', '29', '2', '122', '0', '1', '0', '0', '0', '1', '1514811236');
INSERT INTO `hi_user_course_topic_9` VALUES ('52', '29', '2', '191', '1', '1', '0', '0', '0', '1', '1514900555');
INSERT INTO `hi_user_course_topic_9` VALUES ('53', '29', '2', '192', '0', '1', '0', '0', '0', '1', '1514901088');
INSERT INTO `hi_user_course_topic_9` VALUES ('54', '29', '2', '193', '0', '1', '0', '0', '0', '1', '1514901158');
INSERT INTO `hi_user_course_topic_9` VALUES ('55', '29', '2', '194', '0', '1', '0', '0', '0', '1', '1514901235');
INSERT INTO `hi_user_course_topic_9` VALUES ('56', '29', '2', '195', '0', '1', '0', '0', '0', '1', '1514901251');
INSERT INTO `hi_user_course_topic_9` VALUES ('57', '29', '2', '196', '0', '1', '0', '0', '0', '1', '1514901286');
INSERT INTO `hi_user_course_topic_9` VALUES ('58', '29', '2', '198', '0', '1', '0', '0', '0', '1', '1514901314');
INSERT INTO `hi_user_course_topic_9` VALUES ('59', '29', '2', '200', '0', '1', '0', '0', '0', '1', '1514901562');
INSERT INTO `hi_user_course_topic_9` VALUES ('60', '29', '2', '201', '0', '1', '0', '0', '0', '1', '1514901609');
INSERT INTO `hi_user_course_topic_9` VALUES ('61', '29', '2', '202', '0', '1', '0', '0', '0', '1', '1514901658');
INSERT INTO `hi_user_course_topic_9` VALUES ('62', '29', '2', '262', '0', '1', '0', '0', '0', '1', '1514902010');
INSERT INTO `hi_user_course_topic_9` VALUES ('63', '29', '2', '100', '0', '1', '0', '0', '0', '1', '1514902113');
INSERT INTO `hi_user_course_topic_9` VALUES ('64', '29', '2', '151', '0', '1', '0', '0', '0', '1', '1514902130');
INSERT INTO `hi_user_course_topic_9` VALUES ('65', '29', '2', '152', '0', '1', '0', '0', '0', '1', '1514902137');
INSERT INTO `hi_user_course_topic_9` VALUES ('66', '29', '2', '190', '0', '1', '0', '0', '0', '1', '1514902147');
INSERT INTO `hi_user_course_topic_9` VALUES ('67', '29', '2', '197', '0', '1', '0', '0', '0', '1', '1514902152');
INSERT INTO `hi_user_course_topic_9` VALUES ('68', '29', '2', '199', '0', '1', '0', '0', '0', '1', '1514902160');
INSERT INTO `hi_user_course_topic_9` VALUES ('69', '29', '2', '203', '0', '1', '0', '0', '0', '1', '1514902168');
INSERT INTO `hi_user_course_topic_9` VALUES ('70', '29', '2', '205', '0', '1', '0', '0', '0', '1', '1514902176');
INSERT INTO `hi_user_course_topic_9` VALUES ('71', '29', '2', '206', '0', '1', '0', '0', '0', '1', '1514902182');
INSERT INTO `hi_user_course_topic_9` VALUES ('72', '29', '2', '207', '0', '1', '0', '0', '0', '1', '1514902186');
INSERT INTO `hi_user_course_topic_9` VALUES ('73', '29', '2', '208', '0', '1', '0', '0', '0', '1', '1514902196');
INSERT INTO `hi_user_course_topic_9` VALUES ('74', '29', '2', '245', '0', '1', '0', '0', '0', '1', '1514902207');
INSERT INTO `hi_user_course_topic_9` VALUES ('75', '29', '2', '97', '0', '1', '0', '0', '0', '1', '1514975924');
INSERT INTO `hi_user_course_topic_9` VALUES ('76', '29', '2', '131', '1', '1', '0', '0', '0', '1', '1514976084');
INSERT INTO `hi_user_course_topic_9` VALUES ('77', '29', '2', '128', '1', '1', '0', '0', '0', '1', '1514976088');
INSERT INTO `hi_user_course_topic_9` VALUES ('78', '29', '2', '125', '1', '1', '0', '0', '0', '1', '1514976109');
INSERT INTO `hi_user_course_topic_9` VALUES ('79', '29', '2', '124', '1', '1', '0', '0', '0', '1', '1514976186');
INSERT INTO `hi_user_course_topic_9` VALUES ('80', '29', '2', '127', '0', '1', '0', '0', '0', '1', '1514976259');
INSERT INTO `hi_user_course_topic_9` VALUES ('81', '29', '2', '123', '0', '1', '0', '0', '0', '1', '1514976264');
INSERT INTO `hi_user_course_topic_9` VALUES ('82', '29', '2', '130', '0', '1', '0', '0', '0', '1', '1514976279');
INSERT INTO `hi_user_course_topic_9` VALUES ('83', '29', '2', '126', '1', '1', '0', '0', '0', '1', '1514976287');
INSERT INTO `hi_user_course_topic_9` VALUES ('84', '29', '2', '129', '0', '1', '0', '0', '0', '1', '1514976298');
INSERT INTO `hi_user_course_topic_9` VALUES ('85', '29', '2', '132', '1', '1', '0', '0', '0', '1', '1514976310');
INSERT INTO `hi_user_course_topic_9` VALUES ('86', '29', '2', '133', '3', '0', '0', '0', '0', '1', '1514976339');
INSERT INTO `hi_user_course_topic_9` VALUES ('87', '29', '2', '134', '0', '1', '0', '0', '0', '1', '1514976396');
INSERT INTO `hi_user_course_topic_9` VALUES ('88', '29', '2', '209', '0', '1', '0', '0', '0', '1', '1514976462');
INSERT INTO `hi_user_course_topic_9` VALUES ('89', '29', '2', '210', '0', '1', '0', '0', '0', '1', '1514976490');

-- ----------------------------
-- Table structure for hi_user_course_unit_0
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_course_unit_0`;
CREATE TABLE `hi_user_course_unit_0` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `CourseID` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '课程动态ID',
  `UnitId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '题目ID',
  `SUnitId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '答对次数',
  `State` tinyint(5) unsigned NOT NULL DEFAULT '1' COMMENT '当前单元学习情况(1:学习中2:已学完)',
  `Video` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '视频是否已看过一遍（0:未看1：已看)',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '进入该题目时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UCUS` (`Uid`,`CourseID`,`UnitId`,`SUnitId`) USING BTREE,
  KEY `State` (`State`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='用户课目单元表';

-- ----------------------------
-- Records of hi_user_course_unit_0
-- ----------------------------
INSERT INTO `hi_user_course_unit_0` VALUES ('1', '30', '2', '9', '29', '2', '0', '1514888790');
INSERT INTO `hi_user_course_unit_0` VALUES ('2', '30', '2', '10', '31', '2', '0', '1514889100');
INSERT INTO `hi_user_course_unit_0` VALUES ('3', '30', '2', '10', '32', '2', '0', '1514889133');
INSERT INTO `hi_user_course_unit_0` VALUES ('4', '30', '2', '10', '33', '2', '0', '1514944947');
INSERT INTO `hi_user_course_unit_0` VALUES ('5', '30', '2', '10', '34', '2', '0', '1514946602');

-- ----------------------------
-- Table structure for hi_user_course_unit_1
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_course_unit_1`;
CREATE TABLE `hi_user_course_unit_1` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `CourseID` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '课程动态ID',
  `UnitId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '题目ID',
  `SUnitId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '答对次数',
  `State` tinyint(5) unsigned NOT NULL DEFAULT '1' COMMENT '当前单元学习情况(1:学习中2:已学完)',
  `Video` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '视频是否已看过一遍（0:未看1：已看)',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '进入该题目时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UCUS` (`Uid`,`CourseID`,`UnitId`,`SUnitId`) USING BTREE,
  KEY `State` (`State`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户课目单元表';

-- ----------------------------
-- Records of hi_user_course_unit_1
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_course_unit_2
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_course_unit_2`;
CREATE TABLE `hi_user_course_unit_2` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `CourseID` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '课程动态ID',
  `UnitId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '题目ID',
  `SUnitId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '答对次数',
  `State` tinyint(5) unsigned NOT NULL DEFAULT '1' COMMENT '当前单元学习情况(1:学习中2:已学完)',
  `Video` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '视频是否已看过一遍（0:未看1：已看)',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '进入该题目时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UCUS` (`Uid`,`CourseID`,`UnitId`,`SUnitId`) USING BTREE,
  KEY `State` (`State`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户课目单元表';

-- ----------------------------
-- Records of hi_user_course_unit_2
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_course_unit_3
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_course_unit_3`;
CREATE TABLE `hi_user_course_unit_3` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `CourseID` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '课程动态ID',
  `UnitId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '题目ID',
  `SUnitId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '答对次数',
  `State` tinyint(5) unsigned NOT NULL DEFAULT '1' COMMENT '当前单元学习情况(1:学习中2:已学完)',
  `Video` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '视频是否已看过一遍（0:未看1：已看)',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '进入该题目时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UCUS` (`Uid`,`CourseID`,`UnitId`,`SUnitId`) USING BTREE,
  KEY `State` (`State`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户课目单元表';

-- ----------------------------
-- Records of hi_user_course_unit_3
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_course_unit_4
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_course_unit_4`;
CREATE TABLE `hi_user_course_unit_4` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `CourseID` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '课程动态ID',
  `UnitId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '题目ID',
  `SUnitId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '答对次数',
  `State` tinyint(5) unsigned NOT NULL DEFAULT '1' COMMENT '当前单元学习情况(1:学习中2:已学完)',
  `Video` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '视频是否已看过一遍（0:未看1：已看)',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '进入该题目时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UCUS` (`Uid`,`CourseID`,`UnitId`,`SUnitId`) USING BTREE,
  KEY `State` (`State`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户课目单元表';

-- ----------------------------
-- Records of hi_user_course_unit_4
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_course_unit_5
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_course_unit_5`;
CREATE TABLE `hi_user_course_unit_5` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `CourseID` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '课程动态ID',
  `UnitId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '题目ID',
  `SUnitId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '答对次数',
  `State` tinyint(5) unsigned NOT NULL DEFAULT '1' COMMENT '当前单元学习情况(1:学习中2:已学完)',
  `Video` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '视频是否已看过一遍（0:未看1：已看)',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '进入该题目时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UCUS` (`Uid`,`CourseID`,`UnitId`,`SUnitId`) USING BTREE,
  KEY `State` (`State`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='用户课目单元表';

-- ----------------------------
-- Records of hi_user_course_unit_5
-- ----------------------------
INSERT INTO `hi_user_course_unit_5` VALUES ('1', '25', '2', '9', '29', '2', '0', '1514985225');

-- ----------------------------
-- Table structure for hi_user_course_unit_6
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_course_unit_6`;
CREATE TABLE `hi_user_course_unit_6` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `CourseID` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '课程动态ID',
  `UnitId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '题目ID',
  `SUnitId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '答对次数',
  `State` tinyint(5) unsigned NOT NULL DEFAULT '1' COMMENT '当前单元学习情况(1:学习中2:已学完)',
  `Video` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '视频是否已看过一遍（0:未看1：已看)',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '进入该题目时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UCUS` (`Uid`,`CourseID`,`UnitId`,`SUnitId`) USING BTREE,
  KEY `State` (`State`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='用户课目单元表';

-- ----------------------------
-- Records of hi_user_course_unit_6
-- ----------------------------
INSERT INTO `hi_user_course_unit_6` VALUES ('1', '26', '2', '9', '29', '2', '0', '1514786473');
INSERT INTO `hi_user_course_unit_6` VALUES ('2', '26', '2', '10', '31', '2', '0', '1514786711');
INSERT INTO `hi_user_course_unit_6` VALUES ('3', '26', '2', '10', '32', '2', '0', '1514786724');
INSERT INTO `hi_user_course_unit_6` VALUES ('4', '26', '2', '10', '33', '2', '0', '1514786910');
INSERT INTO `hi_user_course_unit_6` VALUES ('5', '26', '2', '10', '34', '2', '0', '1514788251');
INSERT INTO `hi_user_course_unit_6` VALUES ('6', '26', '2', '11', '35', '2', '0', '1514788445');
INSERT INTO `hi_user_course_unit_6` VALUES ('7', '26', '2', '11', '36', '2', '0', '1514980003');
INSERT INTO `hi_user_course_unit_6` VALUES ('8', '26', '2', '11', '37', '2', '0', '1514980410');
INSERT INTO `hi_user_course_unit_6` VALUES ('9', '26', '2', '11', '38', '2', '0', '1514981471');
INSERT INTO `hi_user_course_unit_6` VALUES ('10', '26', '2', '12', '39', '2', '0', '1514981789');
INSERT INTO `hi_user_course_unit_6` VALUES ('11', '26', '2', '12', '40', '2', '0', '1514981801');
INSERT INTO `hi_user_course_unit_6` VALUES ('12', '26', '2', '12', '41', '2', '0', '1514982139');
INSERT INTO `hi_user_course_unit_6` VALUES ('13', '26', '2', '12', '42', '2', '0', '1514983297');

-- ----------------------------
-- Table structure for hi_user_course_unit_7
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_course_unit_7`;
CREATE TABLE `hi_user_course_unit_7` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `CourseID` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '课程动态ID',
  `UnitId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '题目ID',
  `SUnitId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '答对次数',
  `State` tinyint(5) unsigned NOT NULL DEFAULT '1' COMMENT '当前单元学习情况(1:学习中2:已学完)',
  `Video` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '视频是否已看过一遍（0:未看1：已看)',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '进入该题目时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UCUS` (`Uid`,`CourseID`,`UnitId`,`SUnitId`) USING BTREE,
  KEY `State` (`State`)
) ENGINE=MyISAM AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COMMENT='用户课目单元表';

-- ----------------------------
-- Records of hi_user_course_unit_7
-- ----------------------------
INSERT INTO `hi_user_course_unit_7` VALUES ('1', '17', '2', '9', '29', '2', '0', '1514738874');
INSERT INTO `hi_user_course_unit_7` VALUES ('2', '17', '2', '10', '31', '2', '0', '1514739049');
INSERT INTO `hi_user_course_unit_7` VALUES ('3', '17', '2', '10', '32', '2', '0', '1514739060');
INSERT INTO `hi_user_course_unit_7` VALUES ('4', '17', '2', '10', '33', '2', '0', '1514739337');
INSERT INTO `hi_user_course_unit_7` VALUES ('5', '17', '2', '10', '34', '2', '0', '1514740611');
INSERT INTO `hi_user_course_unit_7` VALUES ('6', '17', '2', '11', '35', '2', '0', '1514740786');
INSERT INTO `hi_user_course_unit_7` VALUES ('7', '17', '2', '11', '36', '2', '0', '1514740799');
INSERT INTO `hi_user_course_unit_7` VALUES ('8', '17', '2', '11', '37', '2', '0', '1514741063');
INSERT INTO `hi_user_course_unit_7` VALUES ('9', '17', '2', '11', '38', '2', '0', '1514741992');
INSERT INTO `hi_user_course_unit_7` VALUES ('10', '17', '2', '12', '39', '2', '0', '1514742139');
INSERT INTO `hi_user_course_unit_7` VALUES ('11', '17', '2', '12', '40', '2', '0', '1514742145');
INSERT INTO `hi_user_course_unit_7` VALUES ('12', '17', '2', '12', '41', '2', '0', '1514742607');
INSERT INTO `hi_user_course_unit_7` VALUES ('13', '17', '2', '12', '42', '2', '0', '1514743085');
INSERT INTO `hi_user_course_unit_7` VALUES ('14', '17', '2', '13', '43', '2', '0', '1514743278');
INSERT INTO `hi_user_course_unit_7` VALUES ('15', '17', '2', '13', '44', '2', '0', '1514743286');
INSERT INTO `hi_user_course_unit_7` VALUES ('16', '17', '2', '13', '45', '2', '0', '1514743421');
INSERT INTO `hi_user_course_unit_7` VALUES ('17', '17', '2', '13', '46', '2', '0', '1514743815');
INSERT INTO `hi_user_course_unit_7` VALUES ('18', '17', '2', '14', '47', '2', '0', '1514743898');
INSERT INTO `hi_user_course_unit_7` VALUES ('19', '27', '2', '9', '29', '2', '0', '1514796216');
INSERT INTO `hi_user_course_unit_7` VALUES ('20', '27', '2', '10', '31', '2', '0', '1514799026');
INSERT INTO `hi_user_course_unit_7` VALUES ('21', '27', '2', '10', '32', '2', '0', '1514799043');
INSERT INTO `hi_user_course_unit_7` VALUES ('22', '27', '2', '10', '33', '2', '0', '1514799399');
INSERT INTO `hi_user_course_unit_7` VALUES ('23', '27', '2', '10', '34', '2', '0', '1514801492');

-- ----------------------------
-- Table structure for hi_user_course_unit_8
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_course_unit_8`;
CREATE TABLE `hi_user_course_unit_8` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `CourseID` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '课程动态ID',
  `UnitId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '题目ID',
  `SUnitId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '答对次数',
  `State` tinyint(5) unsigned NOT NULL DEFAULT '1' COMMENT '当前单元学习情况(1:学习中2:已学完)',
  `Video` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '视频是否已看过一遍（0:未看1：已看)',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '进入该题目时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UCUS` (`Uid`,`CourseID`,`UnitId`,`SUnitId`) USING BTREE,
  KEY `State` (`State`)
) ENGINE=MyISAM AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COMMENT='用户课目单元表';

-- ----------------------------
-- Records of hi_user_course_unit_8
-- ----------------------------
INSERT INTO `hi_user_course_unit_8` VALUES ('1', '18', '2', '9', '29', '2', '0', '1514710295');
INSERT INTO `hi_user_course_unit_8` VALUES ('2', '18', '2', '10', '31', '2', '0', '1514710339');
INSERT INTO `hi_user_course_unit_8` VALUES ('3', '18', '2', '10', '32', '2', '0', '1514710345');
INSERT INTO `hi_user_course_unit_8` VALUES ('4', '18', '2', '10', '33', '2', '0', '1514710450');
INSERT INTO `hi_user_course_unit_8` VALUES ('5', '18', '2', '10', '34', '2', '0', '1514713902');
INSERT INTO `hi_user_course_unit_8` VALUES ('6', '18', '2', '11', '35', '2', '0', '1514714060');
INSERT INTO `hi_user_course_unit_8` VALUES ('7', '18', '2', '11', '36', '2', '0', '1514714065');
INSERT INTO `hi_user_course_unit_8` VALUES ('8', '18', '2', '11', '37', '2', '0', '1514714114');
INSERT INTO `hi_user_course_unit_8` VALUES ('9', '18', '2', '11', '38', '2', '0', '1514714293');
INSERT INTO `hi_user_course_unit_8` VALUES ('10', '18', '2', '12', '39', '2', '0', '1514714355');
INSERT INTO `hi_user_course_unit_8` VALUES ('11', '18', '2', '12', '40', '2', '0', '1514714360');
INSERT INTO `hi_user_course_unit_8` VALUES ('12', '18', '2', '12', '41', '2', '0', '1514714401');
INSERT INTO `hi_user_course_unit_8` VALUES ('13', '18', '2', '12', '42', '2', '0', '1514714595');
INSERT INTO `hi_user_course_unit_8` VALUES ('14', '18', '2', '13', '43', '2', '0', '1514715399');
INSERT INTO `hi_user_course_unit_8` VALUES ('15', '18', '2', '13', '44', '2', '0', '1514715405');
INSERT INTO `hi_user_course_unit_8` VALUES ('16', '18', '2', '13', '45', '2', '0', '1514715514');
INSERT INTO `hi_user_course_unit_8` VALUES ('17', '18', '2', '13', '46', '2', '0', '1514715660');
INSERT INTO `hi_user_course_unit_8` VALUES ('18', '18', '2', '14', '47', '2', '0', '1514728702');
INSERT INTO `hi_user_course_unit_8` VALUES ('19', '28', '2', '9', '29', '2', '0', '1514898271');
INSERT INTO `hi_user_course_unit_8` VALUES ('20', '28', '2', '10', '31', '2', '0', '1514898518');
INSERT INTO `hi_user_course_unit_8` VALUES ('21', '28', '2', '10', '32', '2', '0', '1514898561');
INSERT INTO `hi_user_course_unit_8` VALUES ('22', '28', '2', '10', '33', '2', '0', '1514967023');
INSERT INTO `hi_user_course_unit_8` VALUES ('23', '28', '2', '10', '34', '2', '0', '1514968494');

-- ----------------------------
-- Table structure for hi_user_course_unit_9
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_course_unit_9`;
CREATE TABLE `hi_user_course_unit_9` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `CourseID` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '课程动态ID',
  `UnitId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '题目ID',
  `SUnitId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '答对次数',
  `State` tinyint(5) unsigned NOT NULL DEFAULT '1' COMMENT '当前单元学习情况(1:学习中2:已学完)',
  `Video` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '视频是否已看过一遍（0:未看1：已看)',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '进入该题目时间',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UCUS` (`Uid`,`CourseID`,`UnitId`,`SUnitId`) USING BTREE,
  KEY `State` (`State`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='用户课目单元表';

-- ----------------------------
-- Records of hi_user_course_unit_9
-- ----------------------------
INSERT INTO `hi_user_course_unit_9` VALUES ('1', '29', '2', '9', '29', '2', '0', '1514809175');
INSERT INTO `hi_user_course_unit_9` VALUES ('2', '29', '2', '10', '31', '2', '0', '1514809337');
INSERT INTO `hi_user_course_unit_9` VALUES ('3', '29', '2', '10', '32', '2', '0', '1514809375');
INSERT INTO `hi_user_course_unit_9` VALUES ('4', '29', '2', '10', '33', '2', '0', '1514809696');
INSERT INTO `hi_user_course_unit_9` VALUES ('5', '29', '2', '10', '34', '2', '0', '1514810887');
INSERT INTO `hi_user_course_unit_9` VALUES ('6', '29', '2', '11', '35', '2', '0', '1514811133');
INSERT INTO `hi_user_course_unit_9` VALUES ('7', '29', '2', '11', '36', '2', '0', '1514811145');
INSERT INTO `hi_user_course_unit_9` VALUES ('8', '29', '2', '11', '37', '2', '0', '1514900555');
INSERT INTO `hi_user_course_unit_9` VALUES ('9', '29', '2', '11', '38', '2', '0', '1514902130');
INSERT INTO `hi_user_course_unit_9` VALUES ('10', '29', '2', '12', '39', '2', '0', '1514975924');
INSERT INTO `hi_user_course_unit_9` VALUES ('11', '29', '2', '12', '40', '2', '0', '1514976084');
INSERT INTO `hi_user_course_unit_9` VALUES ('12', '29', '2', '12', '41', '1', '0', '1514976462');

-- ----------------------------
-- Table structure for hi_user_d
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_d`;
CREATE TABLE `hi_user_d` (
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '玩家ID',
  `UserName` varchar(50) NOT NULL DEFAULT '' COMMENT '用户名',
  `MUserName` char(32) NOT NULL DEFAULT '' COMMENT 'MD5后的用户名',
  `Password` char(32) NOT NULL DEFAULT '' COMMENT '用户密码',
  `Mobile` char(11) NOT NULL DEFAULT '' COMMENT '绑定手机号',
  `Type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '用户类型(1:普通用户2:微信用户)',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `UnionId` char(50) NOT NULL DEFAULT '' COMMENT '微信用户统一标识',
  `MUnionId` char(32) NOT NULL DEFAULT '' COMMENT 'MD5后的微信用户统一标识',
  `AccessToken` varchar(200) NOT NULL DEFAULT '' COMMENT '微信token',
  `ExpireTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '过期时间',
  `RefreshToken` varchar(200) NOT NULL DEFAULT '' COMMENT '微信刷新用token',
  `SuggesterMobile` varchar(20) NOT NULL DEFAULT '' COMMENT '推荐人手机号',
  `isMerge` tinyint(1) DEFAULT '0' COMMENT '是否合并，1：是，0：否',
  PRIMARY KEY (`Uid`),
  UNIQUE KEY `MUserName` (`MUserName`) USING BTREE,
  KEY `MUionID` (`MUnionId`) USING BTREE,
  KEY `isMerge` (`isMerge`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of hi_user_d
-- ----------------------------
INSERT INTO `hi_user_d` VALUES ('22', '13524699164', 'dd6c18f55cb3eb6d678680795dafeef7', '96e79218965eb72c92a549dd5a330112', '', '1', '1514708632', '', '', '', '0', '', '', '1');

-- ----------------------------
-- Table structure for hi_user_day_read_0
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_day_read_0`;
CREATE TABLE `hi_user_day_read_0` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Did` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '每日必读ID',
  `AudioUrl` varchar(100) NOT NULL DEFAULT '' COMMENT '上传的音频地址',
  `UnitId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '单元ID',
  `AudId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '音频ID',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '朗读时间',
  PRIMARY KEY (`ID`),
  KEY `UUA` (`Uid`,`Did`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户每日朗读表';

-- ----------------------------
-- Records of hi_user_day_read_0
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_day_read_1
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_day_read_1`;
CREATE TABLE `hi_user_day_read_1` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Did` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '每日必读ID',
  `AudioUrl` varchar(100) NOT NULL DEFAULT '' COMMENT '上传的音频地址',
  `UnitId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '单元ID',
  `AudId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '音频ID',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '朗读时间',
  PRIMARY KEY (`ID`),
  KEY `UUA` (`Uid`,`Did`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户每日朗读表';

-- ----------------------------
-- Records of hi_user_day_read_1
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_day_read_2
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_day_read_2`;
CREATE TABLE `hi_user_day_read_2` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Did` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '每日必读ID',
  `AudioUrl` varchar(100) NOT NULL DEFAULT '' COMMENT '上传的音频地址',
  `UnitId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '单元ID',
  `AudId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '音频ID',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '朗读时间',
  PRIMARY KEY (`ID`),
  KEY `UUA` (`Uid`,`Did`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户每日朗读表';

-- ----------------------------
-- Records of hi_user_day_read_2
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_day_read_3
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_day_read_3`;
CREATE TABLE `hi_user_day_read_3` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Did` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '每日必读ID',
  `AudioUrl` varchar(100) NOT NULL DEFAULT '' COMMENT '上传的音频地址',
  `UnitId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '单元ID',
  `AudId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '音频ID',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '朗读时间',
  PRIMARY KEY (`ID`),
  KEY `UUA` (`Uid`,`Did`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户每日朗读表';

-- ----------------------------
-- Records of hi_user_day_read_3
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_day_read_4
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_day_read_4`;
CREATE TABLE `hi_user_day_read_4` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Did` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '每日必读ID',
  `AudioUrl` varchar(100) NOT NULL DEFAULT '' COMMENT '上传的音频地址',
  `UnitId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '单元ID',
  `AudId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '音频ID',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '朗读时间',
  PRIMARY KEY (`ID`),
  KEY `UUA` (`Uid`,`Did`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户每日朗读表';

-- ----------------------------
-- Records of hi_user_day_read_4
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_day_read_5
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_day_read_5`;
CREATE TABLE `hi_user_day_read_5` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Did` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '每日必读ID',
  `AudioUrl` varchar(100) NOT NULL DEFAULT '' COMMENT '上传的音频地址',
  `UnitId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '单元ID',
  `AudId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '音频ID',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '朗读时间',
  PRIMARY KEY (`ID`),
  KEY `UUA` (`Uid`,`Did`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户每日朗读表';

-- ----------------------------
-- Records of hi_user_day_read_5
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_day_read_6
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_day_read_6`;
CREATE TABLE `hi_user_day_read_6` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Did` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '每日必读ID',
  `AudioUrl` varchar(100) NOT NULL DEFAULT '' COMMENT '上传的音频地址',
  `UnitId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '单元ID',
  `AudId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '音频ID',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '朗读时间',
  PRIMARY KEY (`ID`),
  KEY `UUA` (`Uid`,`Did`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户每日朗读表';

-- ----------------------------
-- Records of hi_user_day_read_6
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_day_read_7
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_day_read_7`;
CREATE TABLE `hi_user_day_read_7` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Did` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '每日必读ID',
  `AudioUrl` varchar(100) NOT NULL DEFAULT '' COMMENT '上传的音频地址',
  `UnitId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '单元ID',
  `AudId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '音频ID',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '朗读时间',
  PRIMARY KEY (`ID`),
  KEY `UUA` (`Uid`,`Did`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户每日朗读表';

-- ----------------------------
-- Records of hi_user_day_read_7
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_day_read_8
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_day_read_8`;
CREATE TABLE `hi_user_day_read_8` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Did` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '每日必读ID',
  `AudioUrl` varchar(100) NOT NULL DEFAULT '' COMMENT '上传的音频地址',
  `UnitId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '单元ID',
  `AudId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '音频ID',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '朗读时间',
  PRIMARY KEY (`ID`),
  KEY `UUA` (`Uid`,`Did`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户每日朗读表';

-- ----------------------------
-- Records of hi_user_day_read_8
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_day_read_9
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_day_read_9`;
CREATE TABLE `hi_user_day_read_9` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Did` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '每日必读ID',
  `AudioUrl` varchar(100) NOT NULL DEFAULT '' COMMENT '上传的音频地址',
  `UnitId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '单元ID',
  `AudId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '音频ID',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '朗读时间',
  PRIMARY KEY (`ID`),
  KEY `UUA` (`Uid`,`Did`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户每日朗读表';

-- ----------------------------
-- Records of hi_user_day_read_9
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_e
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_e`;
CREATE TABLE `hi_user_e` (
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '玩家ID',
  `UserName` varchar(50) NOT NULL DEFAULT '' COMMENT '用户名',
  `MUserName` char(32) NOT NULL DEFAULT '' COMMENT 'MD5后的用户名',
  `Password` char(32) NOT NULL DEFAULT '' COMMENT '用户密码',
  `Mobile` char(11) NOT NULL DEFAULT '' COMMENT '绑定手机号',
  `Type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '用户类型(1:普通用户2:微信用户)',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `UnionId` char(50) NOT NULL DEFAULT '' COMMENT '微信用户统一标识',
  `MUnionId` char(32) NOT NULL DEFAULT '' COMMENT 'MD5后的微信用户统一标识',
  `AccessToken` varchar(200) NOT NULL DEFAULT '' COMMENT '微信token',
  `ExpireTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '过期时间',
  `RefreshToken` varchar(200) NOT NULL DEFAULT '' COMMENT '微信刷新用token',
  `SuggesterMobile` varchar(20) NOT NULL DEFAULT '' COMMENT '推荐人手机号',
  `isMerge` tinyint(1) DEFAULT '0' COMMENT '是否合并，1：是，0：否',
  PRIMARY KEY (`Uid`),
  UNIQUE KEY `MUserName` (`MUserName`) USING BTREE,
  KEY `MUionID` (`MUnionId`) USING BTREE,
  KEY `isMerge` (`isMerge`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of hi_user_e
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_enshrine_0
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_enshrine_0`;
CREATE TABLE `hi_user_enshrine_0` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL COMMENT '用户ID',
  `Word` varchar(100) NOT NULL DEFAULT '' COMMENT '收藏的单词',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '收藏时间',
  PRIMARY KEY (`ID`),
  KEY `Uid` (`Uid`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hi_user_enshrine_0
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_enshrine_1
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_enshrine_1`;
CREATE TABLE `hi_user_enshrine_1` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL COMMENT '用户ID',
  `Word` varchar(100) NOT NULL DEFAULT '' COMMENT '收藏的单词',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '收藏时间',
  PRIMARY KEY (`ID`),
  KEY `Uid` (`Uid`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hi_user_enshrine_1
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_enshrine_2
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_enshrine_2`;
CREATE TABLE `hi_user_enshrine_2` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL COMMENT '用户ID',
  `Word` varchar(100) NOT NULL DEFAULT '' COMMENT '收藏的单词',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '收藏时间',
  PRIMARY KEY (`ID`),
  KEY `Uid` (`Uid`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hi_user_enshrine_2
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_enshrine_3
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_enshrine_3`;
CREATE TABLE `hi_user_enshrine_3` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL COMMENT '用户ID',
  `Word` varchar(100) NOT NULL DEFAULT '' COMMENT '收藏的单词',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '收藏时间',
  PRIMARY KEY (`ID`),
  KEY `Uid` (`Uid`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hi_user_enshrine_3
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_enshrine_4
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_enshrine_4`;
CREATE TABLE `hi_user_enshrine_4` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL COMMENT '用户ID',
  `Word` varchar(100) NOT NULL DEFAULT '' COMMENT '收藏的单词',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '收藏时间',
  PRIMARY KEY (`ID`),
  KEY `Uid` (`Uid`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hi_user_enshrine_4
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_enshrine_5
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_enshrine_5`;
CREATE TABLE `hi_user_enshrine_5` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL COMMENT '用户ID',
  `Word` varchar(100) NOT NULL DEFAULT '' COMMENT '收藏的单词',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '收藏时间',
  PRIMARY KEY (`ID`),
  KEY `Uid` (`Uid`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hi_user_enshrine_5
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_enshrine_6
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_enshrine_6`;
CREATE TABLE `hi_user_enshrine_6` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL COMMENT '用户ID',
  `Word` varchar(100) NOT NULL DEFAULT '' COMMENT '收藏的单词',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '收藏时间',
  PRIMARY KEY (`ID`),
  KEY `Uid` (`Uid`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hi_user_enshrine_6
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_enshrine_7
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_enshrine_7`;
CREATE TABLE `hi_user_enshrine_7` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL COMMENT '用户ID',
  `Word` varchar(100) NOT NULL DEFAULT '' COMMENT '收藏的单词',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '收藏时间',
  PRIMARY KEY (`ID`),
  KEY `Uid` (`Uid`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hi_user_enshrine_7
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_enshrine_8
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_enshrine_8`;
CREATE TABLE `hi_user_enshrine_8` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL COMMENT '用户ID',
  `Word` varchar(100) NOT NULL DEFAULT '' COMMENT '收藏的单词',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '收藏时间',
  PRIMARY KEY (`ID`),
  KEY `Uid` (`Uid`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hi_user_enshrine_8
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_enshrine_9
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_enshrine_9`;
CREATE TABLE `hi_user_enshrine_9` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL COMMENT '用户ID',
  `Word` varchar(100) NOT NULL DEFAULT '' COMMENT '收藏的单词',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '收藏时间',
  PRIMARY KEY (`ID`),
  KEY `Uid` (`Uid`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hi_user_enshrine_9
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_f
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_f`;
CREATE TABLE `hi_user_f` (
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '玩家ID',
  `UserName` varchar(50) NOT NULL DEFAULT '' COMMENT '用户名',
  `MUserName` char(32) NOT NULL DEFAULT '' COMMENT 'MD5后的用户名',
  `Password` char(32) NOT NULL DEFAULT '' COMMENT '用户密码',
  `Mobile` char(11) NOT NULL DEFAULT '' COMMENT '绑定手机号',
  `Type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '用户类型(1:普通用户2:微信用户)',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `UnionId` char(50) NOT NULL DEFAULT '' COMMENT '微信用户统一标识',
  `MUnionId` char(32) NOT NULL DEFAULT '' COMMENT 'MD5后的微信用户统一标识',
  `AccessToken` varchar(200) NOT NULL DEFAULT '' COMMENT '微信token',
  `ExpireTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '过期时间',
  `RefreshToken` varchar(200) NOT NULL DEFAULT '' COMMENT '微信刷新用token',
  `SuggesterMobile` varchar(20) NOT NULL DEFAULT '' COMMENT '推荐人手机号',
  `isMerge` tinyint(1) DEFAULT '0' COMMENT '是否合并，1：是，0：否',
  PRIMARY KEY (`Uid`),
  UNIQUE KEY `MUserName` (`MUserName`) USING BTREE,
  KEY `MUionID` (`MUnionId`) USING BTREE,
  KEY `isMerge` (`isMerge`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of hi_user_f
-- ----------------------------
INSERT INTO `hi_user_f` VALUES ('0', '{', 'f95b70fdc3088560732a5ac135644506', 'e10adc3949ba59abbe56e057f20f883e', '', '2', '1516700113', '{', 'f95b70fdc3088560732a5ac135644506', '{', '1516700113', '{', '', '1');
INSERT INTO `hi_user_f` VALUES ('26', '13701684046', 'f4deb70ab9bf61389b9d194eeca21f79', '005898c894f7e687625c9804c991964f', '', '1', '1514785432', '', '', '', '0', '', '', '1');
INSERT INTO `hi_user_f` VALUES ('31', '13129912880', 'fda76b1825b4d30e2ed04db6c1f077dd', 'ada34d8185d4f8ab3fce57b7947f84a9', '', '1', '1514892376', '', '', '', '0', '', '', '1');
INSERT INTO `hi_user_f` VALUES ('35', '13910275079', 'f933a2f02e4931bddc5167d0da497827', 'dba65fc39e41b37b64faeea0c4ab3888', '', '1', '1514948705', '', '', '', '0', '', '', '1');

-- ----------------------------
-- Table structure for hi_user_info_0
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_info_0`;
CREATE TABLE `hi_user_info_0` (
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `NickName` varchar(100) NOT NULL DEFAULT '' COMMENT '昵称',
  `Icon` varchar(200) NOT NULL DEFAULT '' COMMENT '头像链接',
  `Sex` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '性别(1:男2:女)',
  `EnName` varchar(20) NOT NULL DEFAULT '' COMMENT '英文名',
  `Birthday` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '孩子生日',
  `SchoolType` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '学校类型（学前：0，一年级:1)',
  `Integral` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户积分',
  `RegTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `Gold` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '金币数量',
  `RIp` varchar(15) NOT NULL DEFAULT '' COMMENT '注册IP',
  `LastLogin` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后一次登录',
  `LIp` varchar(15) NOT NULL DEFAULT '' COMMENT '最后一次登录IP',
  `SurveyScore` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '问卷调查分数',
  `SurveyTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '问卷调查时间',
  `isMerge` tinyint(1) DEFAULT '0' COMMENT '是否合并，1：是，0：否',
  PRIMARY KEY (`Uid`),
  KEY `isMerge` (`isMerge`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户信息表';

-- ----------------------------
-- Records of hi_user_info_0
-- ----------------------------
INSERT INTO `hi_user_info_0` VALUES ('0', 'peggyyuan', 'http://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83erxWiaiac950rzLOMFzN0c1ReIsibkksCqh97BZ7Qotmuy3adyhTqULMPOE8RuUyjss3TiaJzcAxjM62g/0', '2', '', '0', '0', '0', '1514785382', '0', '124.78.30.233', '1514785382', '124.78.30.233', '0', '0', '1');
INSERT INTO `hi_user_info_0` VALUES ('20', '', '', '1', '', '0', '0', '0', '1514707878', '0', '139.227.234.15', '1514707878', '139.227.234.15', '0', '0', '1');
INSERT INTO `hi_user_info_0` VALUES ('30', '', '', '1', '', '0', '0', '0', '1514870858', '82', '103.25.28.23', '1514870858', '103.25.28.23', '0', '0', '1');
INSERT INTO `hi_user_info_0` VALUES ('40', '', '', '1', '', '0', '0', '0', '1514979218', '0', '27.17.192.138', '1514979218', '27.17.192.138', '0', '0', '1');
INSERT INTO `hi_user_info_0` VALUES ('100', 'sadf', '', '1', 'asdf', '545497200', '0', '0', '1515080280', '0', '', '0', '', '0', '0', '1');

-- ----------------------------
-- Table structure for hi_user_info_1
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_info_1`;
CREATE TABLE `hi_user_info_1` (
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `NickName` varchar(100) NOT NULL DEFAULT '' COMMENT '昵称',
  `Icon` varchar(200) NOT NULL DEFAULT '' COMMENT '头像链接',
  `Sex` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '性别(1:男2:女)',
  `EnName` varchar(20) NOT NULL DEFAULT '' COMMENT '英文名',
  `Birthday` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '孩子生日',
  `SchoolType` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '学校类型（学前：0，一年级:1)',
  `Integral` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户积分',
  `RegTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `Gold` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '金币数量',
  `RIp` varchar(15) NOT NULL DEFAULT '' COMMENT '注册IP',
  `LastLogin` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后一次登录',
  `LIp` varchar(15) NOT NULL DEFAULT '' COMMENT '最后一次登录IP',
  `SurveyScore` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '问卷调查分数',
  `SurveyTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '问卷调查时间',
  `isMerge` tinyint(1) DEFAULT '0' COMMENT '是否合并，1：是，0：否',
  PRIMARY KEY (`Uid`),
  KEY `isMerge` (`isMerge`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户信息表';

-- ----------------------------
-- Records of hi_user_info_1
-- ----------------------------
INSERT INTO `hi_user_info_1` VALUES ('1', '', '', '1', '', '0', '0', '0', '1515652080', '0', '101.81.54.216', '1515652080', '101.81.54.216', '31', '0', '1');
INSERT INTO `hi_user_info_1` VALUES ('21', '', '', '1', '', '0', '0', '0', '1514708261', '0', '139.227.234.15', '1514708261', '139.227.234.15', '27', '0', '1');
INSERT INTO `hi_user_info_1` VALUES ('31', '', '', '1', '', '0', '0', '0', '1514892376', '0', '58.48.153.158', '1514892376', '58.48.153.158', '0', '0', '1');
INSERT INTO `hi_user_info_1` VALUES ('41', '', '', '1', '', '0', '0', '0', '1514982667', '0', '115.190.236.43', '1514982667', '115.190.236.43', '0', '0', '1');

-- ----------------------------
-- Table structure for hi_user_info_2
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_info_2`;
CREATE TABLE `hi_user_info_2` (
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `NickName` varchar(100) NOT NULL DEFAULT '' COMMENT '昵称',
  `Icon` varchar(200) NOT NULL DEFAULT '' COMMENT '头像链接',
  `Sex` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '性别(1:男2:女)',
  `EnName` varchar(20) NOT NULL DEFAULT '' COMMENT '英文名',
  `Birthday` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '孩子生日',
  `SchoolType` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '学校类型（学前：0，一年级:1)',
  `Integral` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户积分',
  `RegTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `Gold` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '金币数量',
  `RIp` varchar(15) NOT NULL DEFAULT '' COMMENT '注册IP',
  `LastLogin` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后一次登录',
  `LIp` varchar(15) NOT NULL DEFAULT '' COMMENT '最后一次登录IP',
  `SurveyScore` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '问卷调查分数',
  `SurveyTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '问卷调查时间',
  `isMerge` tinyint(1) DEFAULT '0' COMMENT '是否合并，1：是，0：否',
  PRIMARY KEY (`Uid`),
  KEY `isMerge` (`isMerge`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户信息表';

-- ----------------------------
-- Records of hi_user_info_2
-- ----------------------------
INSERT INTO `hi_user_info_2` VALUES ('2', '', '', '1', '', '0', '0', '0', '1515654147', '0', '59.175.210.98', '1515654147', '59.175.210.98', '0', '0', '1');
INSERT INTO `hi_user_info_2` VALUES ('22', '', '', '1', '', '0', '0', '0', '1514708632', '0', '139.227.234.15', '1514708632', '139.227.234.15', '0', '0', '1');
INSERT INTO `hi_user_info_2` VALUES ('32', '', '', '1', '', '0', '0', '0', '1514906498', '0', '223.72.57.111', '1514906498', '223.72.57.111', '0', '0', '1');
INSERT INTO `hi_user_info_2` VALUES ('42', '', '', '1', '', '0', '0', '0', '1514982723', '0', '221.218.30.180', '1514982723', '221.218.30.180', '0', '0', '1');

-- ----------------------------
-- Table structure for hi_user_info_3
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_info_3`;
CREATE TABLE `hi_user_info_3` (
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `NickName` varchar(100) NOT NULL DEFAULT '' COMMENT '昵称',
  `Icon` varchar(200) NOT NULL DEFAULT '' COMMENT '头像链接',
  `Sex` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '性别(1:男2:女)',
  `EnName` varchar(20) NOT NULL DEFAULT '' COMMENT '英文名',
  `Birthday` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '孩子生日',
  `SchoolType` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '学校类型（学前：0，一年级:1)',
  `Integral` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户积分',
  `RegTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `Gold` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '金币数量',
  `RIp` varchar(15) NOT NULL DEFAULT '' COMMENT '注册IP',
  `LastLogin` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后一次登录',
  `LIp` varchar(15) NOT NULL DEFAULT '' COMMENT '最后一次登录IP',
  `SurveyScore` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '问卷调查分数',
  `SurveyTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '问卷调查时间',
  `isMerge` tinyint(1) DEFAULT '0' COMMENT '是否合并，1：是，0：否',
  PRIMARY KEY (`Uid`),
  KEY `isMerge` (`isMerge`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户信息表';

-- ----------------------------
-- Records of hi_user_info_3
-- ----------------------------
INSERT INTO `hi_user_info_3` VALUES ('3', '', '', '1', '', '0', '0', '0', '1515716370', '0', '58.37.102.249', '1515716370', '58.37.102.249', '0', '0', '1');
INSERT INTO `hi_user_info_3` VALUES ('23', '', '', '1', '', '0', '0', '0', '1514726563', '0', '116.247.78.54', '1514726563', '116.247.78.54', '0', '0', '1');
INSERT INTO `hi_user_info_3` VALUES ('33', '', '', '1', '', '0', '0', '0', '1514947575', '0', '223.104.3.178', '1514947575', '223.104.3.178', '0', '0', '1');
INSERT INTO `hi_user_info_3` VALUES ('43', '', '', '1', '', '0', '0', '0', '1514982930', '0', '115.190.236.43', '1514982930', '115.190.236.43', '0', '0', '1');

-- ----------------------------
-- Table structure for hi_user_info_4
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_info_4`;
CREATE TABLE `hi_user_info_4` (
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `NickName` varchar(100) NOT NULL DEFAULT '' COMMENT '昵称',
  `Icon` varchar(200) NOT NULL DEFAULT '' COMMENT '头像链接',
  `Sex` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '性别(1:男2:女)',
  `EnName` varchar(20) NOT NULL DEFAULT '' COMMENT '英文名',
  `Birthday` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '孩子生日',
  `SchoolType` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '学校类型（学前：0，一年级:1)',
  `Integral` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户积分',
  `RegTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `Gold` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '金币数量',
  `RIp` varchar(15) NOT NULL DEFAULT '' COMMENT '注册IP',
  `LastLogin` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后一次登录',
  `LIp` varchar(15) NOT NULL DEFAULT '' COMMENT '最后一次登录IP',
  `SurveyScore` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '问卷调查分数',
  `SurveyTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '问卷调查时间',
  `isMerge` tinyint(1) DEFAULT '0' COMMENT '是否合并，1：是，0：否',
  PRIMARY KEY (`Uid`),
  KEY `isMerge` (`isMerge`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户信息表';

-- ----------------------------
-- Records of hi_user_info_4
-- ----------------------------
INSERT INTO `hi_user_info_4` VALUES ('24', '', '', '1', '', '0', '0', '0', '1514728067', '0', '116.247.78.54', '1514728067', '116.247.78.54', '0', '0', '1');
INSERT INTO `hi_user_info_4` VALUES ('34', '', '', '1', '', '0', '0', '0', '1514948489', '0', '27.17.113.217', '1514948489', '27.17.113.217', '0', '0', '1');
INSERT INTO `hi_user_info_4` VALUES ('44', '', '', '1', '', '0', '0', '0', '1514985483', '0', '123.114.52.11', '1514985483', '123.114.52.11', '0', '0', '1');

-- ----------------------------
-- Table structure for hi_user_info_5
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_info_5`;
CREATE TABLE `hi_user_info_5` (
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `NickName` varchar(100) NOT NULL DEFAULT '' COMMENT '昵称',
  `Icon` varchar(200) NOT NULL DEFAULT '' COMMENT '头像链接',
  `Sex` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '性别(1:男2:女)',
  `EnName` varchar(20) NOT NULL DEFAULT '' COMMENT '英文名',
  `Birthday` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '孩子生日',
  `SchoolType` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '学校类型（学前：0，一年级:1)',
  `Integral` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户积分',
  `RegTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `Gold` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '金币数量',
  `RIp` varchar(15) NOT NULL DEFAULT '' COMMENT '注册IP',
  `LastLogin` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后一次登录',
  `LIp` varchar(15) NOT NULL DEFAULT '' COMMENT '最后一次登录IP',
  `SurveyScore` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '问卷调查分数',
  `SurveyTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '问卷调查时间',
  `isMerge` tinyint(1) DEFAULT '0' COMMENT '是否合并，1：是，0：否',
  PRIMARY KEY (`Uid`),
  KEY `isMerge` (`isMerge`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户信息表';

-- ----------------------------
-- Records of hi_user_info_5
-- ----------------------------
INSERT INTO `hi_user_info_5` VALUES ('25', 'Gigi', '', '0', '肖文琪', '1203264000', '0', '0', '1514778552', '10', '61.165.146.247', '1514778552', '61.165.146.247', '0', '0', '1');
INSERT INTO `hi_user_info_5` VALUES ('35', '', '', '1', '', '0', '0', '0', '1514948705', '0', '36.110.72.50', '1514948705', '36.110.72.50', '0', '0', '1');
INSERT INTO `hi_user_info_5` VALUES ('45', '', '', '1', '', '0', '0', '0', '1514989163', '0', '1.203.117.101', '1514989163', '1.203.117.101', '0', '0', '1');

-- ----------------------------
-- Table structure for hi_user_info_6
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_info_6`;
CREATE TABLE `hi_user_info_6` (
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `NickName` varchar(100) NOT NULL DEFAULT '' COMMENT '昵称',
  `Icon` varchar(200) NOT NULL DEFAULT '' COMMENT '头像链接',
  `Sex` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '性别(1:男2:女)',
  `EnName` varchar(20) NOT NULL DEFAULT '' COMMENT '英文名',
  `Birthday` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '孩子生日',
  `SchoolType` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '学校类型（学前：0，一年级:1)',
  `Integral` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户积分',
  `RegTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `Gold` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '金币数量',
  `RIp` varchar(15) NOT NULL DEFAULT '' COMMENT '注册IP',
  `LastLogin` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后一次登录',
  `LIp` varchar(15) NOT NULL DEFAULT '' COMMENT '最后一次登录IP',
  `SurveyScore` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '问卷调查分数',
  `SurveyTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '问卷调查时间',
  `isMerge` tinyint(1) DEFAULT '0' COMMENT '是否合并，1：是，0：否',
  PRIMARY KEY (`Uid`),
  KEY `isMerge` (`isMerge`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户信息表';

-- ----------------------------
-- Records of hi_user_info_6
-- ----------------------------
INSERT INTO `hi_user_info_6` VALUES ('26', '', '', '1', '', '0', '0', '0', '1514785432', '305', '124.78.30.233', '1514785432', '124.78.30.233', '0', '0', '1');
INSERT INTO `hi_user_info_6` VALUES ('36', '', '', '1', '', '0', '0', '0', '1514950129', '0', '27.17.249.11', '1514950129', '27.17.249.11', '0', '0', '1');

-- ----------------------------
-- Table structure for hi_user_info_7
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_info_7`;
CREATE TABLE `hi_user_info_7` (
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `NickName` varchar(100) NOT NULL DEFAULT '' COMMENT '昵称',
  `Icon` varchar(200) NOT NULL DEFAULT '' COMMENT '头像链接',
  `Sex` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '性别(1:男2:女)',
  `EnName` varchar(20) NOT NULL DEFAULT '' COMMENT '英文名',
  `Birthday` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '孩子生日',
  `SchoolType` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '学校类型（学前：0，一年级:1)',
  `Integral` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户积分',
  `RegTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `Gold` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '金币数量',
  `RIp` varchar(15) NOT NULL DEFAULT '' COMMENT '注册IP',
  `LastLogin` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后一次登录',
  `LIp` varchar(15) NOT NULL DEFAULT '' COMMENT '最后一次登录IP',
  `SurveyScore` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '问卷调查分数',
  `SurveyTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '问卷调查时间',
  `isMerge` tinyint(1) DEFAULT '0' COMMENT '是否合并，1：是，0：否',
  PRIMARY KEY (`Uid`),
  KEY `isMerge` (`isMerge`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户信息表';

-- ----------------------------
-- Records of hi_user_info_7
-- ----------------------------
INSERT INTO `hi_user_info_7` VALUES ('17', '', '', '1', '', '0', '0', '0', '1514706758', '341', '116.247.78.54', '1514706758', '116.247.78.54', '0', '0', '1');
INSERT INTO `hi_user_info_7` VALUES ('27', '', '', '1', '', '0', '0', '0', '1514795563', '80', '124.78.191.54', '1514795563', '124.78.191.54', '0', '0', '1');
INSERT INTO `hi_user_info_7` VALUES ('37', '', '', '1', '', '0', '0', '0', '1514951396', '0', '124.200.180.62', '1514951396', '124.200.180.62', '0', '0', '1');

-- ----------------------------
-- Table structure for hi_user_info_8
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_info_8`;
CREATE TABLE `hi_user_info_8` (
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `NickName` varchar(100) NOT NULL DEFAULT '' COMMENT '昵称',
  `Icon` varchar(200) NOT NULL DEFAULT '' COMMENT '头像链接',
  `Sex` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '性别(1:男2:女)',
  `EnName` varchar(20) NOT NULL DEFAULT '' COMMENT '英文名',
  `Birthday` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '孩子生日',
  `SchoolType` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '学校类型（学前：0，一年级:1)',
  `Integral` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户积分',
  `RegTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `Gold` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '金币数量',
  `RIp` varchar(15) NOT NULL DEFAULT '' COMMENT '注册IP',
  `LastLogin` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后一次登录',
  `LIp` varchar(15) NOT NULL DEFAULT '' COMMENT '最后一次登录IP',
  `SurveyScore` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '问卷调查分数',
  `SurveyTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '问卷调查时间',
  `isMerge` tinyint(1) DEFAULT '0' COMMENT '是否合并，1：是，0：否',
  PRIMARY KEY (`Uid`),
  KEY `isMerge` (`isMerge`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户信息表';

-- ----------------------------
-- Records of hi_user_info_8
-- ----------------------------
INSERT INTO `hi_user_info_8` VALUES ('18', '', '', '1', '', '0', '0', '0', '1514707230', '394', '116.247.78.54', '1514707230', '116.247.78.54', '0', '0', '1');
INSERT INTO `hi_user_info_8` VALUES ('28', '', '', '1', '', '0', '0', '0', '1514799796', '92', '58.37.250.233', '1514799796', '58.37.250.233', '0', '0', '1');
INSERT INTO `hi_user_info_8` VALUES ('38', '', '', '1', '', '0', '0', '0', '1514951619', '0', '106.38.10.50', '1514951619', '106.38.10.50', '0', '0', '1');

-- ----------------------------
-- Table structure for hi_user_info_9
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_info_9`;
CREATE TABLE `hi_user_info_9` (
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `NickName` varchar(100) NOT NULL DEFAULT '' COMMENT '昵称',
  `Icon` varchar(200) NOT NULL DEFAULT '' COMMENT '头像链接',
  `Sex` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '性别(1:男2:女)',
  `EnName` varchar(20) NOT NULL DEFAULT '' COMMENT '英文名',
  `Birthday` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '孩子生日',
  `SchoolType` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '学校类型（学前：0，一年级:1)',
  `Integral` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户积分',
  `RegTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `Gold` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '金币数量',
  `RIp` varchar(15) NOT NULL DEFAULT '' COMMENT '注册IP',
  `LastLogin` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后一次登录',
  `LIp` varchar(15) NOT NULL DEFAULT '' COMMENT '最后一次登录IP',
  `SurveyScore` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '问卷调查分数',
  `SurveyTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '问卷调查时间',
  `isMerge` tinyint(1) DEFAULT '0' COMMENT '是否合并，1：是，0：否',
  PRIMARY KEY (`Uid`),
  KEY `isMerge` (`isMerge`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户信息表';

-- ----------------------------
-- Records of hi_user_info_9
-- ----------------------------
INSERT INTO `hi_user_info_9` VALUES ('19', '', '', '1', '', '0', '0', '0', '1514707520', '0', '139.227.234.15', '1514707520', '139.227.234.15', '0', '0', '1');
INSERT INTO `hi_user_info_9` VALUES ('29', '', '', '1', '', '0', '0', '0', '1514808309', '192', '211.161.244.163', '1514808309', '211.161.244.163', '0', '0', '1');
INSERT INTO `hi_user_info_9` VALUES ('39', 'Alysa', '', '0', '柯月盈', '1190649600', '1', '0', '1514973213', '0', '124.126.224.249', '1514973213', '124.126.224.249', '0', '0', '1');

-- ----------------------------
-- Table structure for hi_user_integral_0
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_integral_0`;
CREATE TABLE `hi_user_integral_0` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Integral` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '积分数',
  `Type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '积分操作类型(1:获得2:消费)',
  `Mark` varchar(500) NOT NULL DEFAULT '' COMMENT '备注',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '积分记录入库时间',
  PRIMARY KEY (`ID`),
  KEY `Uid` (`Uid`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户积分表';

-- ----------------------------
-- Records of hi_user_integral_0
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_integral_1
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_integral_1`;
CREATE TABLE `hi_user_integral_1` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Integral` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '积分数',
  `Type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '积分操作类型(1:获得2:消费)',
  `Mark` varchar(500) NOT NULL DEFAULT '' COMMENT '备注',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '积分记录入库时间',
  PRIMARY KEY (`ID`),
  KEY `Uid` (`Uid`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户积分表';

-- ----------------------------
-- Records of hi_user_integral_1
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_integral_2
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_integral_2`;
CREATE TABLE `hi_user_integral_2` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Integral` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '积分数',
  `Type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '积分操作类型(1:获得2:消费)',
  `Mark` varchar(500) NOT NULL DEFAULT '' COMMENT '备注',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '积分记录入库时间',
  PRIMARY KEY (`ID`),
  KEY `Uid` (`Uid`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户积分表';

-- ----------------------------
-- Records of hi_user_integral_2
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_integral_3
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_integral_3`;
CREATE TABLE `hi_user_integral_3` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Integral` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '积分数',
  `Type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '积分操作类型(1:获得2:消费)',
  `Mark` varchar(500) NOT NULL DEFAULT '' COMMENT '备注',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '积分记录入库时间',
  PRIMARY KEY (`ID`),
  KEY `Uid` (`Uid`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户积分表';

-- ----------------------------
-- Records of hi_user_integral_3
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_integral_4
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_integral_4`;
CREATE TABLE `hi_user_integral_4` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Integral` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '积分数',
  `Type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '积分操作类型(1:获得2:消费)',
  `Mark` varchar(500) NOT NULL DEFAULT '' COMMENT '备注',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '积分记录入库时间',
  PRIMARY KEY (`ID`),
  KEY `Uid` (`Uid`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户积分表';

-- ----------------------------
-- Records of hi_user_integral_4
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_integral_5
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_integral_5`;
CREATE TABLE `hi_user_integral_5` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Integral` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '积分数',
  `Type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '积分操作类型(1:获得2:消费)',
  `Mark` varchar(500) NOT NULL DEFAULT '' COMMENT '备注',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '积分记录入库时间',
  PRIMARY KEY (`ID`),
  KEY `Uid` (`Uid`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户积分表';

-- ----------------------------
-- Records of hi_user_integral_5
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_integral_6
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_integral_6`;
CREATE TABLE `hi_user_integral_6` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Integral` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '积分数',
  `Type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '积分操作类型(1:获得2:消费)',
  `Mark` varchar(500) NOT NULL DEFAULT '' COMMENT '备注',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '积分记录入库时间',
  PRIMARY KEY (`ID`),
  KEY `Uid` (`Uid`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户积分表';

-- ----------------------------
-- Records of hi_user_integral_6
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_integral_7
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_integral_7`;
CREATE TABLE `hi_user_integral_7` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Integral` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '积分数',
  `Type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '积分操作类型(1:获得2:消费)',
  `Mark` varchar(500) NOT NULL DEFAULT '' COMMENT '备注',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '积分记录入库时间',
  PRIMARY KEY (`ID`),
  KEY `Uid` (`Uid`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户积分表';

-- ----------------------------
-- Records of hi_user_integral_7
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_integral_8
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_integral_8`;
CREATE TABLE `hi_user_integral_8` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Integral` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '积分数',
  `Type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '积分操作类型(1:获得2:消费)',
  `Mark` varchar(500) NOT NULL DEFAULT '' COMMENT '备注',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '积分记录入库时间',
  PRIMARY KEY (`ID`),
  KEY `Uid` (`Uid`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户积分表';

-- ----------------------------
-- Records of hi_user_integral_8
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_integral_9
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_integral_9`;
CREATE TABLE `hi_user_integral_9` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Integral` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '积分数',
  `Type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '积分操作类型(1:获得2:消费)',
  `Mark` varchar(500) NOT NULL DEFAULT '' COMMENT '备注',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '积分记录入库时间',
  PRIMARY KEY (`ID`),
  KEY `Uid` (`Uid`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户积分表';

-- ----------------------------
-- Records of hi_user_integral_9
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_merge
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_merge`;
CREATE TABLE `hi_user_merge` (
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '玩家ID',
  `UserName` varchar(50) NOT NULL DEFAULT '' COMMENT '用户名',
  `Mobile` char(11) NOT NULL DEFAULT '' COMMENT '绑定手机号',
  `Type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '用户类型(1:普通用户2:微信用户)',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `EnName` varchar(20) DEFAULT NULL COMMENT '英文名',
  `UserStatus` varchar(20) DEFAULT 'regist' COMMENT '用户状态，regist：注册用户，try：试听用户，charge：付费用户',
  `Birthday` int(10) unsigned DEFAULT NULL COMMENT '生日',
  `SurveyScore` tinyint(3) DEFAULT '0' COMMENT '问卷调查分数',
  `SurveyTime` int(10) unsigned DEFAULT '0' COMMENT '问卷调查时间',
  `City` varchar(60) DEFAULT NULL COMMENT '城市名称',
  `CityId` int(10) unsigned DEFAULT '0' COMMENT '城市id',
  `ReadLevel` varchar(255) DEFAULT '0' COMMENT '水平测试等级',
  PRIMARY KEY (`Uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of hi_user_merge
-- ----------------------------
INSERT INTO `hi_user_merge` VALUES ('17', '18602194166', '', '1', '1514706758', '', 'regist', '0', '0', '0', null, '0', '1');
INSERT INTO `hi_user_merge` VALUES ('100', 'test', '', '1', '1515080280', 'asdf', 'regist', '545497200', '0', '0', null, '0', '1');
INSERT INTO `hi_user_merge` VALUES ('33', '13911202075', '', '1', '1514947575', '', 'regist', '0', '0', '0', null, '0', '1');
INSERT INTO `hi_user_merge` VALUES ('41', '13886116706', '', '1', '1514982667', '', 'regist', '0', '0', '0', null, '0', '1');
INSERT INTO `hi_user_merge` VALUES ('3', '18616383125', '', '1', '1515716370', '', 'regist', '0', '0', '0', null, '0', '1');
INSERT INTO `hi_user_merge` VALUES ('30', '13581726271', '', '1', '1514870858', '', 'regist', '0', '0', '0', null, '0', '1');
INSERT INTO `hi_user_merge` VALUES ('39', '13552478006', '', '1', '1514973213', '柯月盈', 'regist', '1190649600', '0', '0', null, '0', '1');
INSERT INTO `hi_user_merge` VALUES ('27', '15800947032', '', '1', '1514795563', '', 'regist', '0', '0', '0', null, '0', '1');
INSERT INTO `hi_user_merge` VALUES ('24', '18616303369', '', '1', '1514728067', '', 'regist', '0', '0', '0', null, '0', '1');
INSERT INTO `hi_user_merge` VALUES ('32', '17610000131', '', '1', '1514906498', '', 'regist', '0', '0', '0', null, '0', '1');
INSERT INTO `hi_user_merge` VALUES ('44', '13311278399', '', '1', '1514985483', '', 'regist', '0', '0', '0', null, '0', '1');
INSERT INTO `hi_user_merge` VALUES ('2', '17786373562', '', '1', '1515654147', '', 'regist', '0', '0', '0', null, '0', '1');
INSERT INTO `hi_user_merge` VALUES ('43', '13886116703', '', '1', '1514982930', '', 'regist', '0', '0', '0', null, '0', '1');
INSERT INTO `hi_user_merge` VALUES ('23', '13774231021', '', '1', '1514726563', '', 'regist', '0', '0', '0', null, '0', '1');
INSERT INTO `hi_user_merge` VALUES ('25', '13661518625', '', '1', '1514778552', '肖文琪', 'regist', '1203264000', '0', '0', null, '0', '1');
INSERT INTO `hi_user_merge` VALUES ('28', '13817160282', '', '1', '1514799796', '', 'regist', '0', '0', '0', null, '0', '1');
INSERT INTO `hi_user_merge` VALUES ('29', '15021381478', '', '1', '1514808309', '', 'regist', '0', '0', '0', null, '0', '1');
INSERT INTO `hi_user_merge` VALUES ('45', '13910281761', '', '1', '1514989163', '', 'regist', '0', '0', '0', null, '0', '1');
INSERT INTO `hi_user_merge` VALUES ('18', '13917079163', '', '1', '1514707230', '', 'regist', '0', '0', '0', null, '0', '1');
INSERT INTO `hi_user_merge` VALUES ('34', '13807191916', '', '1', '1514948489', '', 'regist', '0', '0', '0', null, '0', '1');
INSERT INTO `hi_user_merge` VALUES ('42', '18612615967', '', '1', '1514982723', '', 'regist', '0', '0', '0', null, '0', '1');
INSERT INTO `hi_user_merge` VALUES ('36', '18971255721', '', '1', '1514950129', '', 'regist', '0', '0', '0', null, '0', '1');
INSERT INTO `hi_user_merge` VALUES ('37', '13911214101', '', '1', '1514951396', '', 'regist', '0', '0', '0', null, '0', '1');
INSERT INTO `hi_user_merge` VALUES ('1', '18616212507', '', '1', '1515652080', '', 'regist', '0', '31', '0', null, '0', '5');
INSERT INTO `hi_user_merge` VALUES ('38', '13911096955', '', '1', '1514951619', '', 'regist', '0', '0', '0', null, '0', '1');
INSERT INTO `hi_user_merge` VALUES ('40', '15342263099', '', '1', '1514979218', '', 'regist', '0', '0', '0', null, '0', '1');
INSERT INTO `hi_user_merge` VALUES ('22', '13524699164', '', '1', '1514708632', '', 'regist', '0', '0', '0', null, '0', '1');
INSERT INTO `hi_user_merge` VALUES ('26', '13701684046', '', '1', '1514785432', '', 'regist', '0', '0', '0', null, '0', '1');
INSERT INTO `hi_user_merge` VALUES ('31', '13129912880', '', '1', '1514892376', '', 'regist', '0', '0', '0', null, '0', '1');
INSERT INTO `hi_user_merge` VALUES ('35', '13910275079', '', '1', '1514948705', '', 'regist', '0', '0', '0', null, '0', '1');
INSERT INTO `hi_user_merge` VALUES ('20', '', '', '1', '0', '', 'regist', '0', '0', '0', null, '0', '1');
INSERT INTO `hi_user_merge` VALUES ('21', '', '', '1', '0', '', 'regist', '0', '27', '0', null, '0', '3');
INSERT INTO `hi_user_merge` VALUES ('19', '', '', '1', '0', '', 'regist', '0', '0', '0', null, '0', '1');
INSERT INTO `hi_user_merge` VALUES ('0', '{', '', '1', '1516700113', '', 'regist', '0', '0', '0', '苏州', '666', '1');

-- ----------------------------
-- Table structure for hi_user_message_0
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_message_0`;
CREATE TABLE `hi_user_message_0` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Message` varchar(500) NOT NULL DEFAULT '' COMMENT '消息内容',
  `Type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '消息类型(1:优惠消息2:学习动态3:好友动态4:交易信息5:系统通知)',
  `State` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '消息状态(0:未读1:已读)',
  `Time` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `UTS` (`Uid`,`Type`,`State`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户消息表';

-- ----------------------------
-- Records of hi_user_message_0
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_message_1
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_message_1`;
CREATE TABLE `hi_user_message_1` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Message` varchar(500) NOT NULL DEFAULT '' COMMENT '消息内容',
  `Type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '消息类型(1:优惠消息2:学习动态3:好友动态4:交易信息5:系统通知)',
  `State` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '消息状态(0:未读1:已读)',
  `Time` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `UTS` (`Uid`,`Type`,`State`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户消息表';

-- ----------------------------
-- Records of hi_user_message_1
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_message_2
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_message_2`;
CREATE TABLE `hi_user_message_2` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Message` varchar(500) NOT NULL DEFAULT '' COMMENT '消息内容',
  `Type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '消息类型(1:优惠消息2:学习动态3:好友动态4:交易信息5:系统通知)',
  `State` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '消息状态(0:未读1:已读)',
  `Time` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `UTS` (`Uid`,`Type`,`State`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户消息表';

-- ----------------------------
-- Records of hi_user_message_2
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_message_3
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_message_3`;
CREATE TABLE `hi_user_message_3` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Message` varchar(500) NOT NULL DEFAULT '' COMMENT '消息内容',
  `Type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '消息类型(1:优惠消息2:学习动态3:好友动态4:交易信息5:系统通知)',
  `State` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '消息状态(0:未读1:已读)',
  `Time` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `UTS` (`Uid`,`Type`,`State`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户消息表';

-- ----------------------------
-- Records of hi_user_message_3
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_message_4
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_message_4`;
CREATE TABLE `hi_user_message_4` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Message` varchar(500) NOT NULL DEFAULT '' COMMENT '消息内容',
  `Type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '消息类型(1:优惠消息2:学习动态3:好友动态4:交易信息5:系统通知)',
  `State` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '消息状态(0:未读1:已读)',
  `Time` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `UTS` (`Uid`,`Type`,`State`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户消息表';

-- ----------------------------
-- Records of hi_user_message_4
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_message_5
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_message_5`;
CREATE TABLE `hi_user_message_5` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Message` varchar(500) NOT NULL DEFAULT '' COMMENT '消息内容',
  `Type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '消息类型(1:优惠消息2:学习动态3:好友动态4:交易信息5:系统通知)',
  `State` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '消息状态(0:未读1:已读)',
  `Time` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `UTS` (`Uid`,`Type`,`State`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户消息表';

-- ----------------------------
-- Records of hi_user_message_5
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_message_6
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_message_6`;
CREATE TABLE `hi_user_message_6` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Message` varchar(500) NOT NULL DEFAULT '' COMMENT '消息内容',
  `Type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '消息类型(1:优惠消息2:学习动态3:好友动态4:交易信息5:系统通知)',
  `State` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '消息状态(0:未读1:已读)',
  `Time` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `UTS` (`Uid`,`Type`,`State`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户消息表';

-- ----------------------------
-- Records of hi_user_message_6
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_message_7
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_message_7`;
CREATE TABLE `hi_user_message_7` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Message` varchar(500) NOT NULL DEFAULT '' COMMENT '消息内容',
  `Type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '消息类型(1:优惠消息2:学习动态3:好友动态4:交易信息5:系统通知)',
  `State` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '消息状态(0:未读1:已读)',
  `Time` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `UTS` (`Uid`,`Type`,`State`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户消息表';

-- ----------------------------
-- Records of hi_user_message_7
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_message_8
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_message_8`;
CREATE TABLE `hi_user_message_8` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Message` varchar(500) NOT NULL DEFAULT '' COMMENT '消息内容',
  `Type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '消息类型(1:优惠消息2:学习动态3:好友动态4:交易信息5:系统通知)',
  `State` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '消息状态(0:未读1:已读)',
  `Time` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `UTS` (`Uid`,`Type`,`State`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户消息表';

-- ----------------------------
-- Records of hi_user_message_8
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_message_9
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_message_9`;
CREATE TABLE `hi_user_message_9` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Message` varchar(500) NOT NULL DEFAULT '' COMMENT '消息内容',
  `Type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '消息类型(1:优惠消息2:学习动态3:好友动态4:交易信息5:系统通知)',
  `State` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '消息状态(0:未读1:已读)',
  `Time` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `UTS` (`Uid`,`Type`,`State`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户消息表';

-- ----------------------------
-- Records of hi_user_message_9
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_order_0
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_order_0`;
CREATE TABLE `hi_user_order_0` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `OrderId` varchar(50) NOT NULL DEFAULT '' COMMENT '订单ID',
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Trade` varchar(255) NOT NULL DEFAULT '' COMMENT '第三方交易单号',
  `Price` double(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '订单价格',
  `RecvId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '收货地址ID',
  `Message` text COMMENT '买家留言',
  `PayType` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '支付类型（0：未知1：微信2：支付宝）',
  `Status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '订单状态（0:未支付1：已支付2：支付失败）',
  `SendStatus` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '发货状态(0:未发货1:已发货2:已签收）',
  `PayTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '订单支付时间',
  `Time` int(10) unsigned NOT NULL COMMENT '订单生成时间',
  `PaymentInfo` text COMMENT '支付相关信息',
  `isMerge` tinyint(1) DEFAULT '0' COMMENT '是否合并，1：是，0：否',
  PRIMARY KEY (`ID`),
  KEY `UO` (`Uid`,`OrderId`) USING BTREE,
  KEY `isMerge` (`isMerge`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hi_user_order_0
-- ----------------------------
INSERT INTO `hi_user_order_0` VALUES ('1', '1', '22756', '167489', '10.00', '1', '测试啊', '1', '1', '1', '1516868782', '1516868782', '测试啊', '1');

-- ----------------------------
-- Table structure for hi_user_order_1
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_order_1`;
CREATE TABLE `hi_user_order_1` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `OrderId` varchar(50) NOT NULL DEFAULT '' COMMENT '订单ID',
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Trade` varchar(255) NOT NULL DEFAULT '' COMMENT '第三方交易单号',
  `Price` double(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '订单价格',
  `RecvId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '收货地址ID',
  `Message` text COMMENT '买家留言',
  `PayType` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '支付类型（0：未知1：微信2：支付宝）',
  `Status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '订单状态（0:未支付1：已支付2：支付失败）',
  `SendStatus` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '发货状态(0:未发货1:已发货2:已签收）',
  `PayTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '订单支付时间',
  `Time` int(10) unsigned NOT NULL COMMENT '订单生成时间',
  `PaymentInfo` text COMMENT '支付相关信息',
  `isMerge` tinyint(1) DEFAULT '0' COMMENT '是否合并，1：是，0：否',
  PRIMARY KEY (`ID`),
  KEY `UO` (`Uid`,`OrderId`) USING BTREE,
  KEY `isMerge` (`isMerge`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hi_user_order_1
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_order_2
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_order_2`;
CREATE TABLE `hi_user_order_2` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `OrderId` varchar(50) NOT NULL DEFAULT '' COMMENT '订单ID',
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Trade` varchar(255) NOT NULL DEFAULT '' COMMENT '第三方交易单号',
  `Price` double(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '订单价格',
  `RecvId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '收货地址ID',
  `Message` text COMMENT '买家留言',
  `PayType` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '支付类型（0：未知1：微信2：支付宝）',
  `Status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '订单状态（0:未支付1：已支付2：支付失败）',
  `SendStatus` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '发货状态(0:未发货1:已发货2:已签收）',
  `PayTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '订单支付时间',
  `Time` int(10) unsigned NOT NULL COMMENT '订单生成时间',
  `PaymentInfo` text COMMENT '支付相关信息',
  `isMerge` tinyint(1) DEFAULT '0' COMMENT '是否合并，1：是，0：否',
  PRIMARY KEY (`ID`),
  KEY `UO` (`Uid`,`OrderId`) USING BTREE,
  KEY `isMerge` (`isMerge`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hi_user_order_2
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_order_3
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_order_3`;
CREATE TABLE `hi_user_order_3` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `OrderId` varchar(50) NOT NULL DEFAULT '' COMMENT '订单ID',
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Trade` varchar(255) NOT NULL DEFAULT '' COMMENT '第三方交易单号',
  `Price` double(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '订单价格',
  `RecvId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '收货地址ID',
  `Message` text COMMENT '买家留言',
  `PayType` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '支付类型（0：未知1：微信2：支付宝）',
  `Status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '订单状态（0:未支付1：已支付2：支付失败）',
  `SendStatus` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '发货状态(0:未发货1:已发货2:已签收）',
  `PayTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '订单支付时间',
  `Time` int(10) unsigned NOT NULL COMMENT '订单生成时间',
  `PaymentInfo` text COMMENT '支付相关信息',
  `isMerge` tinyint(1) DEFAULT '0' COMMENT '是否合并，1：是，0：否',
  PRIMARY KEY (`ID`),
  KEY `UO` (`Uid`,`OrderId`) USING BTREE,
  KEY `isMerge` (`isMerge`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hi_user_order_3
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_order_4
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_order_4`;
CREATE TABLE `hi_user_order_4` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `OrderId` varchar(50) NOT NULL DEFAULT '' COMMENT '订单ID',
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Trade` varchar(255) NOT NULL DEFAULT '' COMMENT '第三方交易单号',
  `Price` double(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '订单价格',
  `RecvId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '收货地址ID',
  `Message` text COMMENT '买家留言',
  `PayType` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '支付类型（0：未知1：微信2：支付宝）',
  `Status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '订单状态（0:未支付1：已支付2：支付失败）',
  `SendStatus` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '发货状态(0:未发货1:已发货2:已签收）',
  `PayTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '订单支付时间',
  `Time` int(10) unsigned NOT NULL COMMENT '订单生成时间',
  `PaymentInfo` text COMMENT '支付相关信息',
  `isMerge` tinyint(1) DEFAULT '0' COMMENT '是否合并，1：是，0：否',
  PRIMARY KEY (`ID`),
  KEY `UO` (`Uid`,`OrderId`) USING BTREE,
  KEY `isMerge` (`isMerge`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hi_user_order_4
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_order_5
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_order_5`;
CREATE TABLE `hi_user_order_5` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `OrderId` varchar(50) NOT NULL DEFAULT '' COMMENT '订单ID',
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Trade` varchar(255) NOT NULL DEFAULT '' COMMENT '第三方交易单号',
  `Price` double(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '订单价格',
  `RecvId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '收货地址ID',
  `Message` text COMMENT '买家留言',
  `PayType` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '支付类型（0：未知1：微信2：支付宝）',
  `Status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '订单状态（0:未支付1：已支付2：支付失败）',
  `SendStatus` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '发货状态(0:未发货1:已发货2:已签收）',
  `PayTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '订单支付时间',
  `Time` int(10) unsigned NOT NULL COMMENT '订单生成时间',
  `PaymentInfo` text COMMENT '支付相关信息',
  `isMerge` tinyint(1) DEFAULT '0' COMMENT '是否合并，1：是，0：否',
  PRIMARY KEY (`ID`),
  KEY `UO` (`Uid`,`OrderId`) USING BTREE,
  KEY `isMerge` (`isMerge`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hi_user_order_5
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_order_6
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_order_6`;
CREATE TABLE `hi_user_order_6` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `OrderId` varchar(50) NOT NULL DEFAULT '' COMMENT '订单ID',
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Trade` varchar(255) NOT NULL DEFAULT '' COMMENT '第三方交易单号',
  `Price` double(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '订单价格',
  `RecvId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '收货地址ID',
  `Message` text COMMENT '买家留言',
  `PayType` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '支付类型（0：未知1：微信2：支付宝）',
  `Status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '订单状态（0:未支付1：已支付2：支付失败）',
  `SendStatus` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '发货状态(0:未发货1:已发货2:已签收）',
  `PayTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '订单支付时间',
  `Time` int(10) unsigned NOT NULL COMMENT '订单生成时间',
  `PaymentInfo` text COMMENT '支付相关信息',
  `isMerge` tinyint(1) DEFAULT '0' COMMENT '是否合并，1：是，0：否',
  PRIMARY KEY (`ID`),
  KEY `UO` (`Uid`,`OrderId`) USING BTREE,
  KEY `isMerge` (`isMerge`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hi_user_order_6
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_order_7
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_order_7`;
CREATE TABLE `hi_user_order_7` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `OrderId` varchar(50) NOT NULL DEFAULT '' COMMENT '订单ID',
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Trade` varchar(255) NOT NULL DEFAULT '' COMMENT '第三方交易单号',
  `Price` double(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '订单价格',
  `RecvId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '收货地址ID',
  `Message` text COMMENT '买家留言',
  `PayType` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '支付类型（0：未知1：微信2：支付宝）',
  `Status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '订单状态（0:未支付1：已支付2：支付失败）',
  `SendStatus` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '发货状态(0:未发货1:已发货2:已签收）',
  `PayTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '订单支付时间',
  `Time` int(10) unsigned NOT NULL COMMENT '订单生成时间',
  `PaymentInfo` text COMMENT '支付相关信息',
  `isMerge` tinyint(1) DEFAULT '0' COMMENT '是否合并，1：是，0：否',
  PRIMARY KEY (`ID`),
  KEY `UO` (`Uid`,`OrderId`) USING BTREE,
  KEY `isMerge` (`isMerge`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hi_user_order_7
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_order_8
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_order_8`;
CREATE TABLE `hi_user_order_8` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `OrderId` varchar(50) NOT NULL DEFAULT '' COMMENT '订单ID',
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Trade` varchar(255) NOT NULL DEFAULT '' COMMENT '第三方交易单号',
  `Price` double(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '订单价格',
  `RecvId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '收货地址ID',
  `Message` text COMMENT '买家留言',
  `PayType` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '支付类型（0：未知1：微信2：支付宝）',
  `Status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '订单状态（0:未支付1：已支付2：支付失败）',
  `SendStatus` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '发货状态(0:未发货1:已发货2:已签收）',
  `PayTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '订单支付时间',
  `Time` int(10) unsigned NOT NULL COMMENT '订单生成时间',
  `PaymentInfo` text COMMENT '支付相关信息',
  `isMerge` tinyint(1) DEFAULT '0' COMMENT '是否合并，1：是，0：否',
  PRIMARY KEY (`ID`),
  KEY `UO` (`Uid`,`OrderId`) USING BTREE,
  KEY `isMerge` (`isMerge`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hi_user_order_8
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_order_9
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_order_9`;
CREATE TABLE `hi_user_order_9` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `OrderId` varchar(50) NOT NULL DEFAULT '' COMMENT '订单ID',
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Trade` varchar(255) NOT NULL DEFAULT '' COMMENT '第三方交易单号',
  `Price` double(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '订单价格',
  `RecvId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '收货地址ID',
  `Message` text COMMENT '买家留言',
  `PayType` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '支付类型（0：未知1：微信2：支付宝）',
  `Status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '订单状态（0:未支付1：已支付2：支付失败）',
  `SendStatus` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '发货状态(0:未发货1:已发货2:已签收）',
  `PayTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '订单支付时间',
  `Time` int(10) unsigned NOT NULL COMMENT '订单生成时间',
  `PaymentInfo` text COMMENT '支付相关信息',
  `isMerge` tinyint(1) DEFAULT '0' COMMENT '是否合并，1：是，0：否',
  PRIMARY KEY (`ID`),
  KEY `UO` (`Uid`,`OrderId`) USING BTREE,
  KEY `isMerge` (`isMerge`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hi_user_order_9
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_order_detail_0
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_order_detail_0`;
CREATE TABLE `hi_user_order_detail_0` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户Id',
  `Oid` int(10) unsigned NOT NULL COMMENT '订单自增ID',
  `CourseId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '课程ID',
  `Price` double(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '购买时原价',
  `DiscountPrice` double(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '购买时折扣价',
  `Count` int(10) unsigned NOT NULL COMMENT '购买数量',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '购买时间',
  PRIMARY KEY (`ID`),
  KEY `UO` (`Uid`,`Oid`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of hi_user_order_detail_0
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_order_detail_1
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_order_detail_1`;
CREATE TABLE `hi_user_order_detail_1` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户Id',
  `Oid` int(10) unsigned NOT NULL COMMENT '订单自增ID',
  `CourseId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '课程ID',
  `Price` double(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '购买时原价',
  `DiscountPrice` double(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '购买时折扣价',
  `Count` int(10) unsigned NOT NULL COMMENT '购买数量',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '购买时间',
  PRIMARY KEY (`ID`),
  KEY `UO` (`Uid`,`Oid`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of hi_user_order_detail_1
-- ----------------------------
INSERT INTO `hi_user_order_detail_1` VALUES ('1', '1', '1', '2', '299.00', '9.90', '1', '1515652424');
INSERT INTO `hi_user_order_detail_1` VALUES ('2', '31', '2', '2', '299.00', '9.90', '1', '1516020028');

-- ----------------------------
-- Table structure for hi_user_order_detail_2
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_order_detail_2`;
CREATE TABLE `hi_user_order_detail_2` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户Id',
  `Oid` int(10) unsigned NOT NULL COMMENT '订单自增ID',
  `CourseId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '课程ID',
  `Price` double(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '购买时原价',
  `DiscountPrice` double(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '购买时折扣价',
  `Count` int(10) unsigned NOT NULL COMMENT '购买数量',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '购买时间',
  PRIMARY KEY (`ID`),
  KEY `UO` (`Uid`,`Oid`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of hi_user_order_detail_2
-- ----------------------------
INSERT INTO `hi_user_order_detail_2` VALUES ('6', '2', '6', '2', '299.00', '9.90', '1', '1515853002');
INSERT INTO `hi_user_order_detail_2` VALUES ('7', '2', '7', '2', '299.00', '9.90', '1', '1515895736');
INSERT INTO `hi_user_order_detail_2` VALUES ('8', '2', '8', '2', '299.00', '9.90', '1', '1515895942');
INSERT INTO `hi_user_order_detail_2` VALUES ('9', '2', '9', '2', '299.00', '9.90', '1', '1515896524');
INSERT INTO `hi_user_order_detail_2` VALUES ('10', '2', '10', '2', '299.00', '9.90', '1', '1515898274');
INSERT INTO `hi_user_order_detail_2` VALUES ('11', '2', '11', '2', '299.00', '9.90', '1', '1515900807');
INSERT INTO `hi_user_order_detail_2` VALUES ('12', '2', '12', '2', '299.00', '9.90', '1', '1515902045');
INSERT INTO `hi_user_order_detail_2` VALUES ('13', '2', '13', '2', '299.00', '9.90', '1', '1515925787');
INSERT INTO `hi_user_order_detail_2` VALUES ('14', '2', '14', '2', '299.00', '9.90', '1', '1515929043');
INSERT INTO `hi_user_order_detail_2` VALUES ('15', '2', '15', '2', '299.00', '9.90', '1', '1515929193');
INSERT INTO `hi_user_order_detail_2` VALUES ('16', '2', '16', '2', '299.00', '9.90', '1', '1515929380');
INSERT INTO `hi_user_order_detail_2` VALUES ('17', '2', '17', '2', '299.00', '9.90', '1', '1515929639');
INSERT INTO `hi_user_order_detail_2` VALUES ('18', '2', '18', '2', '299.00', '9.90', '1', '1515929758');
INSERT INTO `hi_user_order_detail_2` VALUES ('19', '2', '19', '2', '299.00', '9.90', '1', '1515981022');
INSERT INTO `hi_user_order_detail_2` VALUES ('20', '2', '20', '2', '299.00', '9.90', '1', '1515981104');
INSERT INTO `hi_user_order_detail_2` VALUES ('21', '2', '21', '2', '299.00', '9.90', '1', '1515981472');
INSERT INTO `hi_user_order_detail_2` VALUES ('22', '2', '22', '2', '299.00', '9.90', '1', '1515981565');
INSERT INTO `hi_user_order_detail_2` VALUES ('23', '2', '23', '2', '299.00', '9.90', '1', '1515981659');
INSERT INTO `hi_user_order_detail_2` VALUES ('24', '2', '24', '2', '299.00', '9.90', '1', '1515981849');
INSERT INTO `hi_user_order_detail_2` VALUES ('25', '2', '25', '2', '299.00', '9.90', '1', '1515982244');
INSERT INTO `hi_user_order_detail_2` VALUES ('26', '2', '26', '2', '299.00', '9.90', '1', '1515982637');
INSERT INTO `hi_user_order_detail_2` VALUES ('27', '2', '27', '2', '299.00', '9.90', '1', '1515984029');
INSERT INTO `hi_user_order_detail_2` VALUES ('28', '2', '28', '2', '299.00', '9.90', '1', '1515984205');
INSERT INTO `hi_user_order_detail_2` VALUES ('29', '2', '29', '2', '299.00', '9.90', '1', '1515984357');
INSERT INTO `hi_user_order_detail_2` VALUES ('30', '2', '30', '2', '299.00', '9.90', '1', '1515985016');
INSERT INTO `hi_user_order_detail_2` VALUES ('31', '2', '31', '2', '299.00', '9.90', '1', '1515985811');
INSERT INTO `hi_user_order_detail_2` VALUES ('32', '2', '32', '2', '299.00', '9.90', '1', '1515987213');
INSERT INTO `hi_user_order_detail_2` VALUES ('33', '2', '33', '2', '299.00', '9.90', '1', '1515987706');
INSERT INTO `hi_user_order_detail_2` VALUES ('34', '22', '34', '3', '299.00', '199.00', '1', '1516016647');
INSERT INTO `hi_user_order_detail_2` VALUES ('35', '2', '35', '2', '299.00', '9.90', '1', '1516019994');

-- ----------------------------
-- Table structure for hi_user_order_detail_3
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_order_detail_3`;
CREATE TABLE `hi_user_order_detail_3` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户Id',
  `Oid` int(10) unsigned NOT NULL COMMENT '订单自增ID',
  `CourseId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '课程ID',
  `Price` double(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '购买时原价',
  `DiscountPrice` double(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '购买时折扣价',
  `Count` int(10) unsigned NOT NULL COMMENT '购买数量',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '购买时间',
  PRIMARY KEY (`ID`),
  KEY `UO` (`Uid`,`Oid`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of hi_user_order_detail_3
-- ----------------------------
INSERT INTO `hi_user_order_detail_3` VALUES ('1', '23', '1', '2', '299.00', '9.90', '1', '1516019466');

-- ----------------------------
-- Table structure for hi_user_order_detail_4
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_order_detail_4`;
CREATE TABLE `hi_user_order_detail_4` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户Id',
  `Oid` int(10) unsigned NOT NULL COMMENT '订单自增ID',
  `CourseId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '课程ID',
  `Price` double(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '购买时原价',
  `DiscountPrice` double(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '购买时折扣价',
  `Count` int(10) unsigned NOT NULL COMMENT '购买数量',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '购买时间',
  PRIMARY KEY (`ID`),
  KEY `UO` (`Uid`,`Oid`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of hi_user_order_detail_4
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_order_detail_5
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_order_detail_5`;
CREATE TABLE `hi_user_order_detail_5` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户Id',
  `Oid` int(10) unsigned NOT NULL COMMENT '订单自增ID',
  `CourseId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '课程ID',
  `Price` double(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '购买时原价',
  `DiscountPrice` double(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '购买时折扣价',
  `Count` int(10) unsigned NOT NULL COMMENT '购买数量',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '购买时间',
  PRIMARY KEY (`ID`),
  KEY `UO` (`Uid`,`Oid`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of hi_user_order_detail_5
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_order_detail_6
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_order_detail_6`;
CREATE TABLE `hi_user_order_detail_6` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户Id',
  `Oid` int(10) unsigned NOT NULL COMMENT '订单自增ID',
  `CourseId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '课程ID',
  `Price` double(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '购买时原价',
  `DiscountPrice` double(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '购买时折扣价',
  `Count` int(10) unsigned NOT NULL COMMENT '购买数量',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '购买时间',
  PRIMARY KEY (`ID`),
  KEY `UO` (`Uid`,`Oid`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of hi_user_order_detail_6
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_order_detail_7
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_order_detail_7`;
CREATE TABLE `hi_user_order_detail_7` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户Id',
  `Oid` int(10) unsigned NOT NULL COMMENT '订单自增ID',
  `CourseId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '课程ID',
  `Price` double(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '购买时原价',
  `DiscountPrice` double(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '购买时折扣价',
  `Count` int(10) unsigned NOT NULL COMMENT '购买数量',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '购买时间',
  PRIMARY KEY (`ID`),
  KEY `UO` (`Uid`,`Oid`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of hi_user_order_detail_7
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_order_detail_8
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_order_detail_8`;
CREATE TABLE `hi_user_order_detail_8` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户Id',
  `Oid` int(10) unsigned NOT NULL COMMENT '订单自增ID',
  `CourseId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '课程ID',
  `Price` double(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '购买时原价',
  `DiscountPrice` double(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '购买时折扣价',
  `Count` int(10) unsigned NOT NULL COMMENT '购买数量',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '购买时间',
  PRIMARY KEY (`ID`),
  KEY `UO` (`Uid`,`Oid`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of hi_user_order_detail_8
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_order_detail_9
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_order_detail_9`;
CREATE TABLE `hi_user_order_detail_9` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户Id',
  `Oid` int(10) unsigned NOT NULL COMMENT '订单自增ID',
  `CourseId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '课程ID',
  `Price` double(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '购买时原价',
  `DiscountPrice` double(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '购买时折扣价',
  `Count` int(10) unsigned NOT NULL COMMENT '购买数量',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '购买时间',
  PRIMARY KEY (`ID`),
  KEY `UO` (`Uid`,`Oid`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of hi_user_order_detail_9
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_order_merge
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_order_merge`;
CREATE TABLE `hi_user_order_merge` (
  `ID` int(10) unsigned NOT NULL,
  `OrderId` varchar(50) NOT NULL DEFAULT '' COMMENT '订单ID',
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Trade` varchar(255) NOT NULL DEFAULT '' COMMENT '第三方交易单号',
  `Price` double(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '订单价格',
  `RecvId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '收货地址ID',
  `Message` text COMMENT '买家留言',
  `PayType` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '支付类型（0：未知1：微信2：支付宝）',
  `Status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '订单状态（0:未支付1：已支付2：支付失败）',
  `SendStatus` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '发货状态(0:未发货1:已发货2:已签收）',
  `PayTime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '订单支付时间',
  `Time` int(10) unsigned NOT NULL COMMENT '订单生成时间',
  `PaymentInfo` text COMMENT '支付相关信息',
  `isMerge` tinyint(1) DEFAULT '0' COMMENT '是否合并，1：是，0：否',
  PRIMARY KEY (`OrderId`,`Uid`),
  KEY `UO` (`Uid`,`OrderId`) USING BTREE,
  KEY `isMerge` (`isMerge`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hi_user_order_merge
-- ----------------------------
INSERT INTO `hi_user_order_merge` VALUES ('1', '1', '1', '167489', '10.00', '1', '测试啊', '1', '1', '1', '1516868782', '1516868782', '测试啊', '0');

-- ----------------------------
-- Table structure for hi_user_readlevel_0
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_readlevel_0`;
CREATE TABLE `hi_user_readlevel_0` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Rid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '测试ID',
  `Correct` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '正确次数',
  `Error` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '错误次数',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '测试时间',
  `isMerge` tinyint(1) DEFAULT '0' COMMENT '是否合并，1：是，0：否',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UR` (`Uid`,`Rid`) USING BTREE,
  KEY `isMerge` (`isMerge`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hi_user_readlevel_0
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_readlevel_1
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_readlevel_1`;
CREATE TABLE `hi_user_readlevel_1` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Rid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '测试ID',
  `Correct` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '正确次数',
  `Error` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '错误次数',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '测试时间',
  `isMerge` tinyint(1) DEFAULT '0' COMMENT '是否合并，1：是，0：否',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UR` (`Uid`,`Rid`) USING BTREE,
  KEY `isMerge` (`isMerge`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hi_user_readlevel_1
-- ----------------------------
INSERT INTO `hi_user_readlevel_1` VALUES ('1', '1', '1', '1', '0', '1515652189', '1');
INSERT INTO `hi_user_readlevel_1` VALUES ('2', '1', '2', '1', '0', '1515652193', '1');
INSERT INTO `hi_user_readlevel_1` VALUES ('3', '1', '3', '1', '0', '1515652197', '1');
INSERT INTO `hi_user_readlevel_1` VALUES ('4', '1', '4', '1', '0', '1515652201', '1');
INSERT INTO `hi_user_readlevel_1` VALUES ('5', '1', '5', '1', '0', '1515652207', '1');
INSERT INTO `hi_user_readlevel_1` VALUES ('6', '1', '6', '1', '0', '1515652215', '1');
INSERT INTO `hi_user_readlevel_1` VALUES ('7', '1', '7', '1', '0', '1515652227', '1');
INSERT INTO `hi_user_readlevel_1` VALUES ('8', '1', '8', '0', '1', '1515652250', '1');
INSERT INTO `hi_user_readlevel_1` VALUES ('9', '1', '9', '1', '0', '1515652254', '1');
INSERT INTO `hi_user_readlevel_1` VALUES ('10', '1', '10', '1', '0', '1515652259', '1');
INSERT INTO `hi_user_readlevel_1` VALUES ('11', '1', '11', '1', '0', '1515652262', '1');
INSERT INTO `hi_user_readlevel_1` VALUES ('12', '1', '12', '1', '0', '1515652275', '1');
INSERT INTO `hi_user_readlevel_1` VALUES ('13', '1', '13', '1', '0', '1515652281', '1');
INSERT INTO `hi_user_readlevel_1` VALUES ('14', '1', '14', '1', '0', '1515652287', '1');
INSERT INTO `hi_user_readlevel_1` VALUES ('15', '1', '15', '1', '0', '1515652293', '1');
INSERT INTO `hi_user_readlevel_1` VALUES ('16', '2', '16', '1', '0', '0', '1');

-- ----------------------------
-- Table structure for hi_user_readlevel_2
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_readlevel_2`;
CREATE TABLE `hi_user_readlevel_2` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Rid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '测试ID',
  `Correct` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '正确次数',
  `Error` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '错误次数',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '测试时间',
  `isMerge` tinyint(1) DEFAULT '0' COMMENT '是否合并，1：是，0：否',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UR` (`Uid`,`Rid`) USING BTREE,
  KEY `isMerge` (`isMerge`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hi_user_readlevel_2
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_readlevel_3
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_readlevel_3`;
CREATE TABLE `hi_user_readlevel_3` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Rid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '测试ID',
  `Correct` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '正确次数',
  `Error` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '错误次数',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '测试时间',
  `isMerge` tinyint(1) DEFAULT '0' COMMENT '是否合并，1：是，0：否',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UR` (`Uid`,`Rid`) USING BTREE,
  KEY `isMerge` (`isMerge`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hi_user_readlevel_3
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_readlevel_4
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_readlevel_4`;
CREATE TABLE `hi_user_readlevel_4` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Rid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '测试ID',
  `Correct` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '正确次数',
  `Error` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '错误次数',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '测试时间',
  `isMerge` tinyint(1) DEFAULT '0' COMMENT '是否合并，1：是，0：否',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UR` (`Uid`,`Rid`) USING BTREE,
  KEY `isMerge` (`isMerge`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hi_user_readlevel_4
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_readlevel_5
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_readlevel_5`;
CREATE TABLE `hi_user_readlevel_5` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Rid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '测试ID',
  `Correct` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '正确次数',
  `Error` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '错误次数',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '测试时间',
  `isMerge` tinyint(1) DEFAULT '0' COMMENT '是否合并，1：是，0：否',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UR` (`Uid`,`Rid`) USING BTREE,
  KEY `isMerge` (`isMerge`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hi_user_readlevel_5
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_readlevel_6
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_readlevel_6`;
CREATE TABLE `hi_user_readlevel_6` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Rid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '测试ID',
  `Correct` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '正确次数',
  `Error` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '错误次数',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '测试时间',
  `isMerge` tinyint(1) DEFAULT '0' COMMENT '是否合并，1：是，0：否',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UR` (`Uid`,`Rid`) USING BTREE,
  KEY `isMerge` (`isMerge`)
) ENGINE=MyISAM AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hi_user_readlevel_6
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_readlevel_7
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_readlevel_7`;
CREATE TABLE `hi_user_readlevel_7` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Rid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '测试ID',
  `Correct` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '正确次数',
  `Error` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '错误次数',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '测试时间',
  `isMerge` tinyint(1) DEFAULT '0' COMMENT '是否合并，1：是，0：否',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UR` (`Uid`,`Rid`) USING BTREE,
  KEY `isMerge` (`isMerge`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hi_user_readlevel_7
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_readlevel_8
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_readlevel_8`;
CREATE TABLE `hi_user_readlevel_8` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Rid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '测试ID',
  `Correct` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '正确次数',
  `Error` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '错误次数',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '测试时间',
  `isMerge` tinyint(1) DEFAULT '0' COMMENT '是否合并，1：是，0：否',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UR` (`Uid`,`Rid`) USING BTREE,
  KEY `isMerge` (`isMerge`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hi_user_readlevel_8
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_readlevel_9
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_readlevel_9`;
CREATE TABLE `hi_user_readlevel_9` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Rid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '测试ID',
  `Correct` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '正确次数',
  `Error` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '错误次数',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '测试时间',
  `isMerge` tinyint(1) DEFAULT '0' COMMENT '是否合并，1：是，0：否',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UR` (`Uid`,`Rid`) USING BTREE,
  KEY `isMerge` (`isMerge`)
) ENGINE=MyISAM AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hi_user_readlevel_9
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_shop_cart_0
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_shop_cart_0`;
CREATE TABLE `hi_user_shop_cart_0` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户Uid',
  `CourseId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '课程ID',
  `Count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '数量',
  `Type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '类型(1:课程2:套餐)',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '加入时间',
  `Checked` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否选中',
  PRIMARY KEY (`ID`),
  KEY `Uid` (`Uid`) USING BTREE,
  KEY `Checked` (`Checked`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户购物车表';

-- ----------------------------
-- Records of hi_user_shop_cart_0
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_shop_cart_1
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_shop_cart_1`;
CREATE TABLE `hi_user_shop_cart_1` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户Uid',
  `CourseId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '课程ID',
  `Count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '数量',
  `Type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '类型(1:课程2:套餐)',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '加入时间',
  `Checked` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否选中',
  PRIMARY KEY (`ID`),
  KEY `Uid` (`Uid`) USING BTREE,
  KEY `Checked` (`Checked`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='用户购物车表';

-- ----------------------------
-- Records of hi_user_shop_cart_1
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_shop_cart_2
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_shop_cart_2`;
CREATE TABLE `hi_user_shop_cart_2` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户Uid',
  `CourseId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '课程ID',
  `Count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '数量',
  `Type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '类型(1:课程2:套餐)',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '加入时间',
  `Checked` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否选中',
  PRIMARY KEY (`ID`),
  KEY `Uid` (`Uid`) USING BTREE,
  KEY `Checked` (`Checked`)
) ENGINE=MyISAM AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 COMMENT='用户购物车表';

-- ----------------------------
-- Records of hi_user_shop_cart_2
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_shop_cart_3
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_shop_cart_3`;
CREATE TABLE `hi_user_shop_cart_3` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户Uid',
  `CourseId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '课程ID',
  `Count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '数量',
  `Type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '类型(1:课程2:套餐)',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '加入时间',
  `Checked` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否选中',
  PRIMARY KEY (`ID`),
  KEY `Uid` (`Uid`) USING BTREE,
  KEY `Checked` (`Checked`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='用户购物车表';

-- ----------------------------
-- Records of hi_user_shop_cart_3
-- ----------------------------
INSERT INTO `hi_user_shop_cart_3` VALUES ('1', '3', '3', '1', '1', '1515716496', '1');

-- ----------------------------
-- Table structure for hi_user_shop_cart_4
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_shop_cart_4`;
CREATE TABLE `hi_user_shop_cart_4` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户Uid',
  `CourseId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '课程ID',
  `Count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '数量',
  `Type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '类型(1:课程2:套餐)',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '加入时间',
  `Checked` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否选中',
  PRIMARY KEY (`ID`),
  KEY `Uid` (`Uid`) USING BTREE,
  KEY `Checked` (`Checked`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户购物车表';

-- ----------------------------
-- Records of hi_user_shop_cart_4
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_shop_cart_5
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_shop_cart_5`;
CREATE TABLE `hi_user_shop_cart_5` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户Uid',
  `CourseId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '课程ID',
  `Count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '数量',
  `Type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '类型(1:课程2:套餐)',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '加入时间',
  `Checked` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否选中',
  PRIMARY KEY (`ID`),
  KEY `Uid` (`Uid`) USING BTREE,
  KEY `Checked` (`Checked`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户购物车表';

-- ----------------------------
-- Records of hi_user_shop_cart_5
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_shop_cart_6
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_shop_cart_6`;
CREATE TABLE `hi_user_shop_cart_6` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户Uid',
  `CourseId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '课程ID',
  `Count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '数量',
  `Type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '类型(1:课程2:套餐)',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '加入时间',
  `Checked` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否选中',
  PRIMARY KEY (`ID`),
  KEY `Uid` (`Uid`) USING BTREE,
  KEY `Checked` (`Checked`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='用户购物车表';

-- ----------------------------
-- Records of hi_user_shop_cart_6
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_shop_cart_7
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_shop_cart_7`;
CREATE TABLE `hi_user_shop_cart_7` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户Uid',
  `CourseId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '课程ID',
  `Count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '数量',
  `Type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '类型(1:课程2:套餐)',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '加入时间',
  `Checked` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否选中',
  PRIMARY KEY (`ID`),
  KEY `Uid` (`Uid`) USING BTREE,
  KEY `Checked` (`Checked`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='用户购物车表';

-- ----------------------------
-- Records of hi_user_shop_cart_7
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_shop_cart_8
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_shop_cart_8`;
CREATE TABLE `hi_user_shop_cart_8` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户Uid',
  `CourseId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '课程ID',
  `Count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '数量',
  `Type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '类型(1:课程2:套餐)',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '加入时间',
  `Checked` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否选中',
  PRIMARY KEY (`ID`),
  KEY `Uid` (`Uid`) USING BTREE,
  KEY `Checked` (`Checked`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='用户购物车表';

-- ----------------------------
-- Records of hi_user_shop_cart_8
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_shop_cart_9
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_shop_cart_9`;
CREATE TABLE `hi_user_shop_cart_9` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户Uid',
  `CourseId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '课程ID',
  `Count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '数量',
  `Type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '类型(1:课程2:套餐)',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '加入时间',
  `Checked` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否选中',
  PRIMARY KEY (`ID`),
  KEY `Uid` (`Uid`) USING BTREE,
  KEY `Checked` (`Checked`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='用户购物车表';

-- ----------------------------
-- Records of hi_user_shop_cart_9
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_survey_0
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_survey_0`;
CREATE TABLE `hi_user_survey_0` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Province` varchar(60) NOT NULL DEFAULT '' COMMENT '省份名称',
  `ProvinceId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '省份ID',
  `City` varchar(60) NOT NULL DEFAULT '' COMMENT '城市名称',
  `CityId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '城市ID',
  `Area` varchar(60) NOT NULL DEFAULT '' COMMENT '地区名称',
  `AreaId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '地区ID',
  `Gender` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '孩子性别(1:男2:女)',
  `EnName` varchar(30) NOT NULL DEFAULT '' COMMENT '英文名',
  `Birthday` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '生日',
  `Questions` blob COMMENT '调查问题及选项',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '时间',
  `isMerge` tinyint(1) DEFAULT '0' COMMENT '是否合并，1：是，0：否',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Uid` (`Uid`) USING BTREE,
  KEY `isMerge` (`isMerge`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='用户调查表';

-- ----------------------------
-- Records of hi_user_survey_0
-- ----------------------------
INSERT INTO `hi_user_survey_0` VALUES ('1', '0', '', '0', '苏州', '666', '', '0', '1', '', '0', null, '0', '1');

-- ----------------------------
-- Table structure for hi_user_survey_1
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_survey_1`;
CREATE TABLE `hi_user_survey_1` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Province` varchar(60) NOT NULL DEFAULT '' COMMENT '省份名称',
  `ProvinceId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '省份ID',
  `City` varchar(60) NOT NULL DEFAULT '' COMMENT '城市名称',
  `CityId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '城市ID',
  `Area` varchar(60) NOT NULL DEFAULT '' COMMENT '地区名称',
  `AreaId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '地区ID',
  `Gender` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '孩子性别(1:男2:女)',
  `EnName` varchar(30) NOT NULL DEFAULT '' COMMENT '英文名',
  `Birthday` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '生日',
  `Questions` blob COMMENT '调查问题及选项',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '时间',
  `isMerge` tinyint(1) DEFAULT '0' COMMENT '是否合并，1：是，0：否',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Uid` (`Uid`) USING BTREE,
  KEY `isMerge` (`isMerge`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户调查表';

-- ----------------------------
-- Records of hi_user_survey_1
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_survey_2
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_survey_2`;
CREATE TABLE `hi_user_survey_2` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Province` varchar(60) NOT NULL DEFAULT '' COMMENT '省份名称',
  `ProvinceId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '省份ID',
  `City` varchar(60) NOT NULL DEFAULT '' COMMENT '城市名称',
  `CityId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '城市ID',
  `Area` varchar(60) NOT NULL DEFAULT '' COMMENT '地区名称',
  `AreaId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '地区ID',
  `Gender` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '孩子性别(1:男2:女)',
  `EnName` varchar(30) NOT NULL DEFAULT '' COMMENT '英文名',
  `Birthday` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '生日',
  `Questions` blob COMMENT '调查问题及选项',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '时间',
  `isMerge` tinyint(1) DEFAULT '0' COMMENT '是否合并，1：是，0：否',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Uid` (`Uid`) USING BTREE,
  KEY `isMerge` (`isMerge`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户调查表';

-- ----------------------------
-- Records of hi_user_survey_2
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_survey_3
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_survey_3`;
CREATE TABLE `hi_user_survey_3` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Province` varchar(60) NOT NULL DEFAULT '' COMMENT '省份名称',
  `ProvinceId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '省份ID',
  `City` varchar(60) NOT NULL DEFAULT '' COMMENT '城市名称',
  `CityId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '城市ID',
  `Area` varchar(60) NOT NULL DEFAULT '' COMMENT '地区名称',
  `AreaId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '地区ID',
  `Gender` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '孩子性别(1:男2:女)',
  `EnName` varchar(30) NOT NULL DEFAULT '' COMMENT '英文名',
  `Birthday` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '生日',
  `Questions` blob COMMENT '调查问题及选项',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '时间',
  `isMerge` tinyint(1) DEFAULT '0' COMMENT '是否合并，1：是，0：否',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Uid` (`Uid`) USING BTREE,
  KEY `isMerge` (`isMerge`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户调查表';

-- ----------------------------
-- Records of hi_user_survey_3
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_survey_4
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_survey_4`;
CREATE TABLE `hi_user_survey_4` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Province` varchar(60) NOT NULL DEFAULT '' COMMENT '省份名称',
  `ProvinceId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '省份ID',
  `City` varchar(60) NOT NULL DEFAULT '' COMMENT '城市名称',
  `CityId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '城市ID',
  `Area` varchar(60) NOT NULL DEFAULT '' COMMENT '地区名称',
  `AreaId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '地区ID',
  `Gender` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '孩子性别(1:男2:女)',
  `EnName` varchar(30) NOT NULL DEFAULT '' COMMENT '英文名',
  `Birthday` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '生日',
  `Questions` blob COMMENT '调查问题及选项',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '时间',
  `isMerge` tinyint(1) DEFAULT '0' COMMENT '是否合并，1：是，0：否',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Uid` (`Uid`) USING BTREE,
  KEY `isMerge` (`isMerge`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户调查表';

-- ----------------------------
-- Records of hi_user_survey_4
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_survey_5
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_survey_5`;
CREATE TABLE `hi_user_survey_5` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Province` varchar(60) NOT NULL DEFAULT '' COMMENT '省份名称',
  `ProvinceId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '省份ID',
  `City` varchar(60) NOT NULL DEFAULT '' COMMENT '城市名称',
  `CityId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '城市ID',
  `Area` varchar(60) NOT NULL DEFAULT '' COMMENT '地区名称',
  `AreaId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '地区ID',
  `Gender` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '孩子性别(1:男2:女)',
  `EnName` varchar(30) NOT NULL DEFAULT '' COMMENT '英文名',
  `Birthday` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '生日',
  `Questions` blob COMMENT '调查问题及选项',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '时间',
  `isMerge` tinyint(1) DEFAULT '0' COMMENT '是否合并，1：是，0：否',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Uid` (`Uid`) USING BTREE,
  KEY `isMerge` (`isMerge`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户调查表';

-- ----------------------------
-- Records of hi_user_survey_5
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_survey_6
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_survey_6`;
CREATE TABLE `hi_user_survey_6` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Province` varchar(60) NOT NULL DEFAULT '' COMMENT '省份名称',
  `ProvinceId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '省份ID',
  `City` varchar(60) NOT NULL DEFAULT '' COMMENT '城市名称',
  `CityId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '城市ID',
  `Area` varchar(60) NOT NULL DEFAULT '' COMMENT '地区名称',
  `AreaId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '地区ID',
  `Gender` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '孩子性别(1:男2:女)',
  `EnName` varchar(30) NOT NULL DEFAULT '' COMMENT '英文名',
  `Birthday` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '生日',
  `Questions` blob COMMENT '调查问题及选项',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '时间',
  `isMerge` tinyint(1) DEFAULT '0' COMMENT '是否合并，1：是，0：否',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Uid` (`Uid`) USING BTREE,
  KEY `isMerge` (`isMerge`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户调查表';

-- ----------------------------
-- Records of hi_user_survey_6
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_survey_7
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_survey_7`;
CREATE TABLE `hi_user_survey_7` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Province` varchar(60) NOT NULL DEFAULT '' COMMENT '省份名称',
  `ProvinceId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '省份ID',
  `City` varchar(60) NOT NULL DEFAULT '' COMMENT '城市名称',
  `CityId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '城市ID',
  `Area` varchar(60) NOT NULL DEFAULT '' COMMENT '地区名称',
  `AreaId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '地区ID',
  `Gender` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '孩子性别(1:男2:女)',
  `EnName` varchar(30) NOT NULL DEFAULT '' COMMENT '英文名',
  `Birthday` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '生日',
  `Questions` blob COMMENT '调查问题及选项',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '时间',
  `isMerge` tinyint(1) DEFAULT '0' COMMENT '是否合并，1：是，0：否',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Uid` (`Uid`) USING BTREE,
  KEY `isMerge` (`isMerge`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户调查表';

-- ----------------------------
-- Records of hi_user_survey_7
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_survey_8
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_survey_8`;
CREATE TABLE `hi_user_survey_8` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Province` varchar(60) NOT NULL DEFAULT '' COMMENT '省份名称',
  `ProvinceId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '省份ID',
  `City` varchar(60) NOT NULL DEFAULT '' COMMENT '城市名称',
  `CityId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '城市ID',
  `Area` varchar(60) NOT NULL DEFAULT '' COMMENT '地区名称',
  `AreaId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '地区ID',
  `Gender` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '孩子性别(1:男2:女)',
  `EnName` varchar(30) NOT NULL DEFAULT '' COMMENT '英文名',
  `Birthday` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '生日',
  `Questions` blob COMMENT '调查问题及选项',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '时间',
  `isMerge` tinyint(1) DEFAULT '0' COMMENT '是否合并，1：是，0：否',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Uid` (`Uid`) USING BTREE,
  KEY `isMerge` (`isMerge`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户调查表';

-- ----------------------------
-- Records of hi_user_survey_8
-- ----------------------------

-- ----------------------------
-- Table structure for hi_user_survey_9
-- ----------------------------
DROP TABLE IF EXISTS `hi_user_survey_9`;
CREATE TABLE `hi_user_survey_9` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `Province` varchar(60) NOT NULL DEFAULT '' COMMENT '省份名称',
  `ProvinceId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '省份ID',
  `City` varchar(60) NOT NULL DEFAULT '' COMMENT '城市名称',
  `CityId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '城市ID',
  `Area` varchar(60) NOT NULL DEFAULT '' COMMENT '地区名称',
  `AreaId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '地区ID',
  `Gender` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '孩子性别(1:男2:女)',
  `EnName` varchar(30) NOT NULL DEFAULT '' COMMENT '英文名',
  `Birthday` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '生日',
  `Questions` blob COMMENT '调查问题及选项',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '时间',
  `isMerge` tinyint(1) DEFAULT '0' COMMENT '是否合并，1：是，0：否',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Uid` (`Uid`) USING BTREE,
  KEY `isMerge` (`isMerge`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户调查表';

-- ----------------------------
-- Records of hi_user_survey_9
-- ----------------------------

-- ----------------------------
-- Table structure for hi_validate_code_0
-- ----------------------------
DROP TABLE IF EXISTS `hi_validate_code_0`;
CREATE TABLE `hi_validate_code_0` (
  `Mobile` bigint(11) unsigned NOT NULL DEFAULT '0' COMMENT '手机号',
  `Code` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '验证码',
  `Type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '验证码类型(1:注册2:登录)',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '验证码生成时间',
  PRIMARY KEY (`Mobile`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户验证码表';

-- ----------------------------
-- Records of hi_validate_code_0
-- ----------------------------

-- ----------------------------
-- Table structure for hi_validate_code_1
-- ----------------------------
DROP TABLE IF EXISTS `hi_validate_code_1`;
CREATE TABLE `hi_validate_code_1` (
  `Mobile` bigint(11) unsigned NOT NULL DEFAULT '0' COMMENT '手机号',
  `Code` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '验证码',
  `Type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '验证码类型(1:注册2:登录)',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '验证码生成时间',
  PRIMARY KEY (`Mobile`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户验证码表';

-- ----------------------------
-- Records of hi_validate_code_1
-- ----------------------------
INSERT INTO `hi_validate_code_1` VALUES ('13774231021', '9142', '1', '1515681327');

-- ----------------------------
-- Table structure for hi_validate_code_2
-- ----------------------------
DROP TABLE IF EXISTS `hi_validate_code_2`;
CREATE TABLE `hi_validate_code_2` (
  `Mobile` bigint(11) unsigned NOT NULL DEFAULT '0' COMMENT '手机号',
  `Code` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '验证码',
  `Type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '验证码类型(1:注册2:登录)',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '验证码生成时间',
  PRIMARY KEY (`Mobile`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户验证码表';

-- ----------------------------
-- Records of hi_validate_code_2
-- ----------------------------

-- ----------------------------
-- Table structure for hi_validate_code_3
-- ----------------------------
DROP TABLE IF EXISTS `hi_validate_code_3`;
CREATE TABLE `hi_validate_code_3` (
  `Mobile` bigint(11) unsigned NOT NULL DEFAULT '0' COMMENT '手机号',
  `Code` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '验证码',
  `Type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '验证码类型(1:注册2:登录)',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '验证码生成时间',
  PRIMARY KEY (`Mobile`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户验证码表';

-- ----------------------------
-- Records of hi_validate_code_3
-- ----------------------------
INSERT INTO `hi_validate_code_3` VALUES ('15002758813', '3869', '1', '1515659974');

-- ----------------------------
-- Table structure for hi_validate_code_4
-- ----------------------------
DROP TABLE IF EXISTS `hi_validate_code_4`;
CREATE TABLE `hi_validate_code_4` (
  `Mobile` bigint(11) unsigned NOT NULL DEFAULT '0' COMMENT '手机号',
  `Code` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '验证码',
  `Type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '验证码类型(1:注册2:登录)',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '验证码生成时间',
  PRIMARY KEY (`Mobile`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户验证码表';

-- ----------------------------
-- Records of hi_validate_code_4
-- ----------------------------

-- ----------------------------
-- Table structure for hi_validate_code_5
-- ----------------------------
DROP TABLE IF EXISTS `hi_validate_code_5`;
CREATE TABLE `hi_validate_code_5` (
  `Mobile` bigint(11) unsigned NOT NULL DEFAULT '0' COMMENT '手机号',
  `Code` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '验证码',
  `Type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '验证码类型(1:注册2:登录)',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '验证码生成时间',
  PRIMARY KEY (`Mobile`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户验证码表';

-- ----------------------------
-- Records of hi_validate_code_5
-- ----------------------------
INSERT INTO `hi_validate_code_5` VALUES ('18616383125', '1821', '1', '1515716341');

-- ----------------------------
-- Table structure for hi_validate_code_6
-- ----------------------------
DROP TABLE IF EXISTS `hi_validate_code_6`;
CREATE TABLE `hi_validate_code_6` (
  `Mobile` bigint(11) unsigned NOT NULL DEFAULT '0' COMMENT '手机号',
  `Code` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '验证码',
  `Type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '验证码类型(1:注册2:登录)',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '验证码生成时间',
  PRIMARY KEY (`Mobile`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户验证码表';

-- ----------------------------
-- Records of hi_validate_code_6
-- ----------------------------

-- ----------------------------
-- Table structure for hi_validate_code_7
-- ----------------------------
DROP TABLE IF EXISTS `hi_validate_code_7`;
CREATE TABLE `hi_validate_code_7` (
  `Mobile` bigint(11) unsigned NOT NULL DEFAULT '0' COMMENT '手机号',
  `Code` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '验证码',
  `Type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '验证码类型(1:注册2:登录)',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '验证码生成时间',
  PRIMARY KEY (`Mobile`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户验证码表';

-- ----------------------------
-- Records of hi_validate_code_7
-- ----------------------------
INSERT INTO `hi_validate_code_7` VALUES ('18616212507', '7492', '1', '1515681368');

-- ----------------------------
-- Table structure for hi_validate_code_8
-- ----------------------------
DROP TABLE IF EXISTS `hi_validate_code_8`;
CREATE TABLE `hi_validate_code_8` (
  `Mobile` bigint(11) unsigned NOT NULL DEFAULT '0' COMMENT '手机号',
  `Code` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '验证码',
  `Type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '验证码类型(1:注册2:登录)',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '验证码生成时间',
  PRIMARY KEY (`Mobile`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户验证码表';

-- ----------------------------
-- Records of hi_validate_code_8
-- ----------------------------

-- ----------------------------
-- Table structure for hi_validate_code_9
-- ----------------------------
DROP TABLE IF EXISTS `hi_validate_code_9`;
CREATE TABLE `hi_validate_code_9` (
  `Mobile` bigint(11) unsigned NOT NULL DEFAULT '0' COMMENT '手机号',
  `Code` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '验证码',
  `Type` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '验证码类型(1:注册2:登录)',
  `Time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '验证码生成时间',
  PRIMARY KEY (`Mobile`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户验证码表';

-- ----------------------------
-- Records of hi_validate_code_9
-- ----------------------------
