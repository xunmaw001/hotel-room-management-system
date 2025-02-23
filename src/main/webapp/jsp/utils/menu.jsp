<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
var menus = [{
	"backMenu": [{
		"child": [{
			"buttons": ["新增", "修改", "删除"],
			"menu": "用户信息",
			"menuJump": "列表",
			"tableName": "yonghu"
		}],
		"menu": "用户管理"
	}, {
		"child": [{
			"buttons": ["新增", "修改", "删除"],
			"menu": "房间信息",
			"menuJump": "列表",
			"tableName": "fangjian"
		}
		,
		{
			"buttons": ["修改", "删除", "审批", "入住"],
			"menu": "房间预定信息",
			"menuJump": "列表",
			"tableName": "fangjianyuding"
		}],
		"menu": "房间管理"
	}, {
		"child": [{
			"buttons": ["修改", "删除"],
			"menu": "住宿信息",
			"menuJump": "列表",
			"tableName": "zhusu"
		}
		,
		{
			"buttons": ["新增", "修改", "删除"],
			"menu": "酒店商店",
			"menuJump": "列表",
			"tableName": "shangdian"
		}],
		"menu": "住宿管理"
	}, {
		"child": [{
			"buttons": ["修改", "删除"],
			"menu": "财务信息",
			"menuJump": "列表",
			"tableName": "caiwu"
		}],
		"menu": "财务管理"
	}, {
		"child":[{
			"buttons":["删除"],
			"menu":"客服管理",
			"tableName":"kefuguanli"
		}
		,
		{
			"buttons":["新增","修改","删除"],
			"menu":"轮播图管理",
			"tableName":"lunbotuguanli"
		}
		,
		{
			"buttons":["新增","修改","删除"],
			"menu":"新闻资讯",
			"tableName":"news"
		}
		],
		"menu":"系统管理"
	}],
	"frontMenu": [],
	"roleName": "管理员",
	"tableName": "users"
}
,
{
	"backMenu": [{
		"child": [{
			"buttons": ["预约"],
			"menu": "房间信息",
			"menuJump": "列表",
			"tableName": "fangjian"
		}
		,
		{
			"buttons": ["取消预约"],
			"menu": "房间预定信息",
			"menuJump": "列表",
			"tableName": "fangjianyuding"
		}],
		"menu": "房间管理"
	}, {
		"child": [{
			"buttons": ["退房"],
			"menu": "住宿信息",
			"menuJump": "列表",
			"tableName": "zhusu"
		}
		,
		{
			"buttons": ["购买"],
			"menu": "酒店商店",
			"menuJump": "列表",
			"tableName": "shangdian"
		}],
		"menu": "住宿管理"
	}, {
		"child": [{
			"buttons": [],
			"menu": "花费记录",
			"menuJump": "列表",
			"tableName": "caiwu"
		}],
		"menu": "花费记录"
	}],
	"frontMenu": [],
	"roleName": "用户",
	"tableName": "yonghu"
}
];
var hasMessage = '';
