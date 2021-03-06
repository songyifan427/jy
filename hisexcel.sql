﻿/*
 Navicat Premium Data Transfer

 Source Server         : local_MySQL5.6
 Source Server Type    : MySQL
 Source Server Version : 50643
 Source Host           : localhost:3306
 Source Schema         : hisexcel

 Target Server Type    : MySQL
 Target Server Version : 50643
 File Encoding         : 65001

 Date: 21/04/2019 09:58:05
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for bus_contract
-- ----------------------------
DROP TABLE IF EXISTS `bus_contract`;
CREATE TABLE `bus_contract`  (
  `id` bigint(20) NOT NULL COMMENT '主键ID',
  `main_id` bigint(20) NULL DEFAULT NULL COMMENT '主合同ID',
  `orgin_id` bigint(20) NULL DEFAULT NULL COMMENT '原合同ID',
  `main_flag` int(11) NOT NULL COMMENT '是否主合同: 0-否(补充合同); 1-是',
  `cont_title` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '合同标题',
  `cont_code` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '合同编号',
  `cont_type` bigint(20) NULL DEFAULT NULL COMMENT '合同类型ID',
  `oppo_id` bigint(20) NOT NULL COMMENT '商机ID',
  `price_id` bigint(20) NOT NULL COMMENT '报价ID',
  `cust_id` bigint(20) NOT NULL COMMENT '客户ID',
  `cust_cn` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '客户名称',
  `bus_type` int(11) NOT NULL COMMENT '业务类型',
  `combo_id` bigint(20) NOT NULL COMMENT '套餐ID',
  `sign_subject_id` bigint(20) NOT NULL DEFAULT 0 COMMENT '合同签约主体ID',
  `standard_flag` int(11) NOT NULL COMMENT '是否标准：0-否；1-是',
  `renew_flag` int(11) NOT NULL COMMENT '是否被续签：0-否；1-是',
  `ower_flag` int(11) NULL DEFAULT NULL COMMENT '我司属于: 1-甲方; 2-乙方',
  `draft_flag` int(11) NULL DEFAULT NULL COMMENT '合同拟定方: 1-我司; 2-客户',
  `printer_flag` int(11) NULL DEFAULT NULL COMMENT '合同打印方: 1-我司; 2-客户',
  `proxy_id` bigint(20) NULL DEFAULT NULL COMMENT '代理人ID',
  `linker_id` bigint(20) NULL DEFAULT NULL COMMENT '对接人ID',
  `remark` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '内容备注',
  `check_remark` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '核验编辑备注',
  `cont_status` int(11) NOT NULL COMMENT '合同状态: 0-编辑中; 1-审批中;2-已审批;3-核验编辑中;4-核验审批中;5-已核验;6-已归档;7-已终止;8-已作废;',
  `effect_flag` int(11) NULL DEFAULT NULL COMMENT '生效状态：0-失效；1-生效；2-未生效',
  `start_date` date NULL DEFAULT NULL COMMENT '开始日期',
  `end_date` date NULL DEFAULT NULL COMMENT '结束日期',
  `act_end_time` timestamp(0) NULL DEFAULT NULL COMMENT '实际终止时间',
  `act_end_user_id` bigint(20) NULL DEFAULT NULL COMMENT '实际终止人id',
  `create_time` timestamp(0) NULL DEFAULT NULL,
  `update_time` timestamp(0) NULL DEFAULT NULL,
  `create_uid` bigint(20) NOT NULL DEFAULT 0,
  `update_uid` bigint(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `cont_code`(`cont_code`) USING BTREE,
  INDEX `oppo_id`(`oppo_id`) USING BTREE,
  INDEX `price_id`(`price_id`) USING BTREE,
  INDEX `cust_id`(`cust_id`) USING BTREE,
  INDEX `combo_id`(`combo_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商务合同-主信息' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of bus_contract
-- ----------------------------
INSERT INTO `bus_contract` VALUES (312, NULL, NULL, 1, '成都凝聚户外拓展运动有限公司', 'SBJTT201601070001', 0, 76294, 0, 257, '成都凝聚户外拓展运动有限公司', 1, 101, 4, 1, 0, 2, 0, NULL, NULL, NULL, NULL, NULL, 8, NULL, '2016-01-07', '2036-01-07', NULL, NULL, NULL, NULL, 1, 1);

-- ----------------------------
-- Table structure for mainform
-- ----------------------------
DROP TABLE IF EXISTS `mainform`;
CREATE TABLE `mainform`  (
  `id` int(9) NOT NULL AUTO_INCREMENT COMMENT '唯一自增id',
  `create_time` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '自动创建时间',
  `create_userid` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '自动创建人',
  `state` tinyint(1) NULL DEFAULT 1 COMMENT '状态:1正常0删除',
  `合同编号` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `客户名称` char(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `业务类型` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `产品名称` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `首次启动人数` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `项目启动日期` date NULL DEFAULT NULL,
  `客服经理` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `账单出具日` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `到账约定` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `付款方式` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `雇员对接方式` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `是否涉及宣讲` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `是否涉及社保公积金转移` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `是否涉及退休办理` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `是否涉及三期人员` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `是否涉及贷款人员` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `渠道名称` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `渠道返佣方式` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `渠道返佣金额` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `报销服务费比例` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `服务费收费方式` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `服务费报价1` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '按人月收',
  `服务费报价2分类` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '按比例收',
  `服务费报价2比例` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '按比例收',
  `服务费报价2下限` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '按比例收',
  `增值服务是否收费` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `会员费` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `会员费收取月份` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `风险金收款凭证类型` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `风险金收费方式` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `风险金报价1` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '一次性收费，按月收费',
  `风险金报价2比例` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '按比例收',
  `风险金报价2下限` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '按比例收',
  `客户开票主体` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `统一信用代码` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `客户是否一般纳税人` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `税费承担方式` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `税率` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `灵活用工个人税费承担方式` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `雇佣主体` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `我司签约主体` char(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `期限类型` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `雇佣合同期限` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `雇佣合同签署试用期` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `雇佣合同类型` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `雇佣合同签约方式` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `用工方式` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `是否涉及劳动合同换签` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `工资与参保地是否一致` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `是否需要办理入离职` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `入职资料` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `离职资料` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `是否需要代为招聘` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `招聘类型` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `招聘需求备注` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `是否需要商保` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `商保收费频率` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `商保收费金额` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `商保到款日` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `商保付款方式` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `商保备注` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `体检信息` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for salaryform
-- ----------------------------
DROP TABLE IF EXISTS `salaryform`;
CREATE TABLE `salaryform`  (
  `id` int(9) NOT NULL AUTO_INCREMENT COMMENT '唯一自增id',
  `create_time` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '自动创建时间',
  `create_userid` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '自动创建人',
  `state` tinyint(1) NULL DEFAULT 1 COMMENT '状态:1正常0删除',
  `合同编号` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `工资报税地` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `工资到款日` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `工资发放日` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `工资发放类型` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `薪税需求备注` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for securityform
-- ----------------------------
DROP TABLE IF EXISTS `securityform`;
CREATE TABLE `securityform`  (
  `id` int(9) NOT NULL AUTO_INCREMENT COMMENT '唯一自增id',
  `create_time` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '自动创建时间',
  `create_userid` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '自动创建人',
  `state` tinyint(1) NULL DEFAULT 1 COMMENT '状态:1正常0删除',
  `合同编号` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `社保缴纳城市` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `是否减免残保金` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `社保到款日` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `是否涉及异地参保` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for userinfo
-- ----------------------------
DROP TABLE IF EXISTS `userinfo`;
CREATE TABLE `userinfo`  (
  `userid` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '员工工号',
  `username` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '员工姓名',
  `password` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  PRIMARY KEY (`userid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of userinfo
-- ----------------------------
INSERT INTO `userinfo` VALUES ('18551799664', '孙蓉蓉', '123456');
INSERT INTO `userinfo` VALUES ('test1', '测试员1', 'test1');
INSERT INTO `userinfo` VALUES ('test10', '测试员10', 'test10');
INSERT INTO `userinfo` VALUES ('test2', '测试员2', 'test2');
INSERT INTO `userinfo` VALUES ('test3', '测试员3', 'test3');
INSERT INTO `userinfo` VALUES ('test4', '测试员4', 'test4');
INSERT INTO `userinfo` VALUES ('test5', '测试员5', 'test5');
INSERT INTO `userinfo` VALUES ('test6', '测试员6', 'test6');
INSERT INTO `userinfo` VALUES ('test7', '测试员7', 'test7');
INSERT INTO `userinfo` VALUES ('test8', '测试员8', 'test8');
INSERT INTO `userinfo` VALUES ('test9', '测试员9', 'test9');

SET FOREIGN_KEY_CHECKS = 1;
