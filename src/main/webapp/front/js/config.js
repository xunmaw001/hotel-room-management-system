
var projectName = '酒店客房管理系统';
/**
 * 轮播图配置
 */
var swiper = {
	// 设定轮播容器宽度，支持像素和百分比
	width: '100%',
	height: '400px',
	// hover（悬停显示）
	// always（始终显示）
	// none（始终不显示）
	arrow: 'none',
	// default（左右切换）
	// updown（上下切换）
	// fade（渐隐渐显切换）
	anim: 'default',
	// 自动切换的时间间隔
	// 默认3000
	interval: 2000,
	// 指示器位置
	// inside（容器内部）
	// outside（容器外部）
	// none（不显示）
	indicator: 'outside'
}

/**
 * 个人中心菜单
 */
var centerMenu = [{
	name: '个人中心',
	url: '../' + localStorage.getItem('userTable') + '/center.jsp'
}
]


var indexNav = [

{
	name: '房间推荐',
	url: './pages/fangjian/list.jsp'
}, 

{
	name: '新闻资讯',
	url: './pages/news/list.jsp'
},
]

var adminurl =  "http://localhost:8080/jiudiankefang/index.jsp";

var cartFlag = false

var chatFlag = false


chatFlag = true
cartFlag = true


var menu = [{
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
            "buttons":["新增","修改","删除"],
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
                    "buttons": [],
                    "menu": "房间预定信息",
                    "menuJump": "列表",
                    "tableName": "fangjianyuding"
                }
                ,
                {
                    "buttons":["删除"],
                    "menu":"房间收藏信息",
                    "tableName":"storeup"
                }],
            "menu": "房间管理"
        }, {
            "child": [{
                "buttons": ["删除"],
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

var isAuth = function (tableName,key) {
    let role = localStorage.getItem("userTable");
    let menus = menu;
    for(let i=0;i<menus.length;i++){
        if(menus[i].tableName==role){
            for(let j=0;j<menus[i].backMenu.length;j++){
                for(let k=0;k<menus[i].backMenu[j].child.length;k++){
                    if(tableName==menus[i].backMenu[j].child[k].tableName){
                        let buttons = menus[i].backMenu[j].child[k].buttons.join(',');
                        return buttons.indexOf(key) !== -1 || false
                    }
                }
            }
        }
    }
    return false;
}

var isFrontAuth = function (tableName,key) {
    let role = localStorage.getItem("userTable");
    let menus = menu;
    for(let i=0;i<menus.length;i++){
        if(menus[i].tableName==role){
            for(let j=0;j<menus[i].frontMenu.length;j++){
                for(let k=0;k<menus[i].frontMenu[j].child.length;k++){
                    if(tableName==menus[i].frontMenu[j].child[k].tableName){
                        let buttons = menus[i].frontMenu[j].child[k].buttons.join(',');
                        return buttons.indexOf(key) !== -1 || false
                    }
                }
            }
        }
    }
    return false;
}
