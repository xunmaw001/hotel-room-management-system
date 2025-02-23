<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page isELIgnored="true" %>

<!-- 首页 -->
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>首页</title>
    <link rel="stylesheet" href="../../layui/css/layui.css">
    <!-- 样式 -->
    <link rel="stylesheet" href="../../css/style.css"/>
    <!-- 主题（主要颜色设置） -->
    <link rel="stylesheet" href="../../css/theme.css"/>
    <!-- 通用的css -->
    <link rel="stylesheet" href="../../css/common.css"/>
</head>
<body>

<div id="app">

    <div class="data-detail">
        <div class="data-detail-breadcrumb">
					<span class="layui-breadcrumb">
						<a href="../home/home.jsp">首页</a>
						<a><cite>{{title}}</cite></a>
					</span>


        </div>
        <div class="layui-row">
            <div class="layui-col-md5">
                <div class="layui-carousel" id="swiper">
                    <div carousel-item id="swiper-item">
                        <div v-for="(item,index) in swiperList" v-bind:key="index">
                            <img class="swiper-item" :src="item.img">
                        </div>
                    </div>
                </div>


            </div>
            <div class="layui-col-md7" style="padding-left: 20px;">
                <h1 class="title">{{title}}</h1>


                <div v-if="detail.thewhere" class="detail-item">
                    <span>房间位置：</span>
                    <span class="thewhere">
								{{detail.thewhere}}
							</span>
                </div>
                <div v-if="detail.fjlxTypes" class="detail-item">
                    <span>房间类型：</span>
                    <span class="fjlxTypes">
								{{detail.fjlxTypes}}
							</span>
                </div>
                <div v-if="detail.money" class="detail-item">
                    <span>一天价格：</span>
                    <span class="money">
								{{detail.money}}RMB
							</span>
                </div>
                <div v-if="detail.fjztTypes" class="detail-item">
                    <span>房屋状态：</span>
                    <span class="fjztTypes">
								{{detail.fjztTypes}}
							</span>
                </div>


                <div class="detail-item">
                    <button v-if="detail.fjztTypes == '未入住'" @click="buyTap" type="button" class="layui-btn btn-submit">
                        立即预约
                    </button>


                </div>

                <div class="detail-item" style="text-align: right;">


                </div>
            </div>
        </div>


        <div class="layui-row">
            <div class="layui-tab layui-tab-card">

                <ul class="layui-tab-title">

                    <li class="layui-this">详情</li>


                </ul>

                <div class="layui-tab-content">

                    <div class="layui-tab-item layui-show">
                        <div v-html="detail.fangjianContent"></div>
                    </div>


                </div>
            </div>
        </div>
    </div>

</div>


<script src="../../layui/layui.js"></script>
<script src="../../js/vue.js"></script>
<!-- 组件配置信息 -->
<script src="../../js/config.js"></script>
<!-- 扩展插件配置信息 -->
<script src="../../modules/config.js"></script>
<!-- 工具方法 -->
<script src="../../js/utils.js"></script>

<script>
    var vue = new Vue({
        el: '#app',
        data: {
            // 轮播图
            swiperList: [],
            // 数据详情
            detail: {
                id: 0
            },
            // 商品标题
            title: '',
            // 倒计时
            count: 0,
            fjlxTypesSelectSearch: [],
            fjztTypesSelectSearch: [],
            // 加入购物车数量
            buynumber: 1,
            // 当前详情页表
            detailTable: 'fangjian',
            // 评价列表
            dataList: [],
            // 选座座位列表
            numberList: []
        },
        // 倒计时效果
        computed: {

        },
        //  清除定时器
        destroyed: function () {
            window.clearInterval(this.inter);
        },
        methods: {
            jump(url) {
                jump(url)
            },
            isAuth(tablename, button) {
                return isFrontAuth(tablename, button)
            },
            // 倒计时初始化
            countDown() {
                let reversetime = new Date(this.detail.reversetime).getTime()
                let now = new Date().getTime();
                let count = reversetime - now;
                if (count > 0) {
                    this.count = count / 1000
                    var _this = this;
                    this.inter = window.setInterval(function () {
                        _this.count = _this.count - 1;
                        if (_this.count < 0) {
                            window.clearInterval(_this.inter);
                            layer.msg("活动已结束", {
                                time: 2000,
                                icon: 5
                            })
                        }
                    }, 1000);
                }
            },

            // 下载文件
            downFile(url) {
                var download = $("#download");
                download.append(
                    "<a id=\"down\" href=\"aaaa.txt\" target=\"_blank\" download=\"aaaa.txt\" style=\"display:none\">下载该文件</a>");
                console.log(download);
                $("#down")[0].click();
            },
            // 跨表
            onAcrossTap(acrossTable) {
                localStorage.setItem('crossTable', `fangjian`);
                localStorage.setItem('crossObj', JSON.stringify(this.detail));
                jump(`../${acrossTable}/add.jsp?corss=true`);
            },

            // 立即购买
            buyTap() {
                    layui.http.request('fangjian/subscribe?ids='+layui.http.getParam('id'), 'get', {
                    }, function (res) {
                        vue.detail.fjztTypes = "已预定"
                        layer.msg(`预约成功`, {
                            time: 2000,
                            icon: 6
                        });
                    });
            },




        }
    })

    layui.use(['layer', 'form', 'element', 'carousel', 'http', 'jquery', 'laypage'], function () {
        var layer = layui.layer;
        var element = layui.element;
        var form = layui.form;
        var carousel = layui.carousel;
        var http = layui.http;
        var jquery = layui.jquery;
        var laypage = layui.laypage;

        var limit = 10;

        // 数据ID
        var id = http.getParam('id');
        vue.detail.id = id;



        http.request(`dictionary/page?page=1&limit=100&sort=&order=&dicCode=fjlx_types` , 'get', {}, function (res) {
            if (res && res.code === 0) {
                vue.fjlxTypesSelectSearch = res.data.list;
            } else {
                vue.$message.error(res.msg);
            }
        });
        http.request(`dictionary/page?page=1&limit=100&sort=&order=&dicCode=fjzt_types` , 'get', {}, function (res) {
            if (res && res.code === 0) {
                vue.fjztTypesSelectSearch = res.data.list;
            } else {
                vue.$message.error(res.msg);
            }
        });


        // 商品信息
        http.request(`${vue.detailTable}/info/` + id, 'get', {}, function (res) {
            // 详情信息
            vue.detail = res.data
            vue.title = vue.detail.name;

            var bbb = vue.detail;

            var fjlxTypesSelect = vue.fjlxTypesSelectSearch;
            for(var i=0 ; i< fjlxTypesSelect.length ; i++){
                if(fjlxTypesSelect[i].codeIndex == bbb.fjlxTypes){
                    bbb.fjlxTypes =  fjlxTypesSelect[i].indexName;
                }
            }

            var fjztTypesSelect = vue.fjztTypesSelectSearch;
            for(var i=0 ; i< fjztTypesSelect.length ; i++){
                if(fjztTypesSelect[i].codeIndex == bbb.fjztTypes){
                    bbb.fjztTypes =  fjztTypesSelect[i].indexName;
                }
            }


            // 轮播图片
                swiperItemHtml =
                    '<div>' +
                    '<img class="swiper-item" src="' + vue.detail.imgPhoto + '">' +
                    '</div>';
            jquery('#swiper-item').html(swiperItemHtml);
            // 轮播图
            carousel.render({
                elem: '#swiper',
                width: swiper.width, height: swiper.height,
                arrow: swiper.arrow,
                anim: swiper.anim,
                interval: swiper.interval,
                indicator: swiper.indicator
            });


        });



    });
</script>
</body>
</html>
