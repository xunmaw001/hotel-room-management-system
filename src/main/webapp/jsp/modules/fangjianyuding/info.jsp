<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <%@ include file="../../static/head.jsp" %>
    <link href="http://www.bootcss.com/p/bootstrap-datetimepicker/bootstrap-datetimepicker/css/datetimepicker.css"
          rel="stylesheet">
    <script type="text/javascript" charset="utf-8">
        window.UEDITOR_HOME_URL = "${pageContext.request.contextPath}/resources/ueditor/"; //UEDITOR_HOME_URL、config、all这三个顺序不能改变
    </script>
    <script type="text/javascript" charset="utf-8"
            src="${pageContext.request.contextPath}/resources/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8"
            src="${pageContext.request.contextPath}/resources/ueditor/ueditor.all.min.js"></script>
    <script type="text/javascript" charset="utf-8"
            src="${pageContext.request.contextPath}/resources/ueditor/lang/zh-cn/zh-cn.js"></script>
</head>
<style>

</style>
<body>
<!-- Pre Loader -->
<div class="loading">
    <div class="spinner">
        <div class="double-bounce1"></div>
        <div class="double-bounce2"></div>
    </div>
</div>
<!--/Pre Loader -->
<div class="wrapper">
    <!-- Page Content -->
    <div id="content">
        <!-- Top Navigation -->
        <%@ include file="../../static/topNav.jsp" %>
        <!-- Menu -->
        <div class="container menu-nav">
            <nav class="navbar navbar-expand-lg lochana-bg text-white">
                <button class="navbar-toggler" type="button" data-toggle="collapse"
                        data-target="#navbarSupportedContent"
                        aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="ti-menu text-white"></span>
                </button>

                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav mr-auto" id="navUl">

                    </ul>
                </div>
            </nav>
        </div>
        <!-- /Menu -->
        <!-- Breadcrumb -->
        <!-- Page Title -->
        <div class="container mt-0">
            <div class="row breadcrumb-bar">
                <div class="col-md-6">
                    <h3 class="block-title">编辑房间预定表</h3>
                </div>
                <div class="col-md-6">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">
                            <a href="${pageContext.request.contextPath}/index.jsp">
                                <span class="ti-home"></span>
                            </a>
                        </li>
                        <li class="breadcrumb-item">房间预定表管理</li>
                        <li class="breadcrumb-item active">房间预定表登记</li>
                    </ol>
                </div>
            </div>
        </div>
        <!-- /Page Title -->

        <!-- /Breadcrumb -->
        <!-- Main Content -->
        <div class="container">

            <div class="row">
                <!-- Widget Item -->
                <div class="col-md-12">
                    <div class="widget-area-2 lochana-box-shadow">
                        <h3 class="widget-title">房间预定表信息</h3>
                        <form id="addOrUpdateForm">
                            <div class="form-row">
                                    <input id="updateId" name="id" type="hidden">
                                <div class="form-group col-md-6">
                                    <label>
                                        预定房间
                                        <input id="fjTypesSelect" name="fjTypesSelect" class="form-control"
                                        // v-model="ruleForm.fjTypes" readonly
                                        >
                                    </label>
                                </div>
                                <div class="form-group col-md-6">
                                    <label>
                                        预定人
                                        <input id="yhTypesSelect" name="yhTypesSelect" class="form-control"
                                        // v-model="ruleForm.yhTypes" readonly
                                        >
                                    </label>
                                </div>
                                <div class="form-group col-md-6">
                                    <label>
                                        是否到达
                                        <input id="sfddTypesSelect" name="sfddTypesSelect" class="form-control"
                                        // v-model="ruleForm.sfddTypes" readonly
                                        >
                                    </label>
                                </div>
                                <div class="form-group col-md-12 mb-3">
                                    <button id="exitBtn" type="button" class="btn btn-primary btn-lg">返回</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                <!-- /Widget Item -->
            </div>
        </div>
        <!-- /Main Content -->
    </div>
    <!-- /Page Content -->
</div>
<!-- Back to Top -->
<a id="back-to-top" href="#" class="back-to-top">
    <span class="ti-angle-up"></span>
</a>
<!-- /Back to Top -->
<%@ include file="../../static/foot.jsp" %>
<script src="${pageContext.request.contextPath}/resources/js/vue.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery.ui.widget.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery.form.js"></script>

<script>
    <%@ include file="../../utils/menu.jsp"%>
            <%@ include file="../../static/setMenu.js"%>
            <%@ include file="../../utils/baseUrl.jsp"%>

    var tableName = "fangjianyuding";
    var pageType = "add-or-update";
    var updateId = "";

    var fjTypesOptions = [];
    var yhTypesOptions = [];
    var sfddTypesOptions = [];

    var ruleForm = {};
    var vm = new Vue({
        el: '#addOrUpdateForm',
        data: {
            ruleForm: {},
        },
        beforeCreate: function () {
            var id = window.sessionStorage.getItem("id");
            if (id != null && id != "" && id != "null") {
                $.ajax({
                    type: "GET",
                    url: baseUrl + "fangjianyuding/info/" + id,
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader("token", window.sessionStorage.getItem('token'));
                    },
                    success: function (res) {
                        if (res.code == 0) {
                            vm.ruleForm = res.data;
                        } else if (res.code == 401) {
                        <%@ include file="../../static/toLogin.jsp"%>
                        } else {
                            alert(res.msg)
                        }
                    },
                });
            }
        },
        methods: {}
    });

    //查询当前页面下所有列表
        function fjTypesSelect() {
            //填充下拉框选项
            http("dictionary/page?page=1&limit=100&sort=&order=&dicCode=fj_types", "GET", {}, (res) => {
                if(res.code == 0){
                    fjTypesOptions = res.data.list;
            }
        });
        }
        function yhTypesSelect() {
            //填充下拉框选项
            http("dictionary/page?page=1&limit=100&sort=&order=&dicCode=yh_types", "GET", {}, (res) => {
                if(res.code == 0){
                    yhTypesOptions = res.data.list;
            }
        });
        }
        function sfddTypesSelect() {
            //填充下拉框选项
            http("dictionary/page?page=1&limit=100&sort=&order=&dicCode=sfdd_types", "GET", {}, (res) => {
                if(res.code == 0){
                    sfddTypesOptions = res.data.list;
            }
        });
        }
    // 下拉框选项回显
    function setSelectOption() {
        for (var i = 0; i < fjTypesOptions.length; i++) {
            if(fjTypesOptions[i].codeIndex == ruleForm.fjTypes){//下拉框value对比,如果一致就赋值汉字
                var fjTypesSelect = document.getElementById("fjTypesSelect");
                    fjTypesSelect.value = fjTypesOptions[i].indexName;
            }
        }
        for (var i = 0; i < yhTypesOptions.length; i++) {
            if(yhTypesOptions[i].codeIndex == ruleForm.yhTypes){//下拉框value对比,如果一致就赋值汉字
                var yhTypesSelect = document.getElementById("yhTypesSelect");
                    yhTypesSelect.value = yhTypesOptions[i].indexName;
            }
        }
        for (var i = 0; i < sfddTypesOptions.length; i++) {
            if(sfddTypesOptions[i].codeIndex == ruleForm.sfddTypes){//下拉框value对比,如果一致就赋值汉字
                var sfddTypesSelect = document.getElementById("sfddTypesSelect");
                    sfddTypesSelect.value = sfddTypesOptions[i].indexName;
            }
        }
    }


    // 填充富文本框
    function setContent() {
    }

    // 获取当前详情
    function getDetails() {
        var id = window.sessionStorage.getItem("id");
        if (id != null && id != "" && id != "null") {
            $("#submitBtn").addClass("修改");
            updateId = id;
            window.sessionStorage.removeItem('id');
            $.ajax({
                type: "GET",
                url: baseUrl + "fangjianyuding/info/" + id,
                async:false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader("token", window.sessionStorage.getItem('token'));
                },
                success: function (res) {
                    if (res.code == 0) {
                        ruleForm = res.data
                        showImg();
                        setContent();
                        setMediaUrl();
                        setSelectOption();
                        // setDownloadBtn();
                    } else if (res.code == 401) {
                    <%@ include file="../../static/toLogin.jsp"%>
                    } else {
                        alert(res.msg);
                    }
                },
            });
        } else {
            $("#submitBtn").addClass("新增");
        }
    }

    //图片显示
    function showImg() {
    }

    function exit() {
        window.sessionStorage.removeItem("id");
        window.location.href = "list.jsp";
    }

    // 下载
    function download(fileName) {
        var url = baseUrl+'file/download?fileName='+fileName;
        window.open(url);
    }

    //设置下载
    function setDownloadBtn() {

    }


    //设置音视频播放链接
    function setMediaUrl() {
    }

    //打开新窗口播放媒体
    function mediaPlay(url) {
        //var url = baseUrl + "upload/" + fileName;
        window.open(url);
    }

    $(document).ready(function () {
        //设置右上角用户名
        $('.dropdown-menu h5').html(window.sessionStorage.getItem('username'))
        //设置项目名
        $('.sidebar-header h3 a').html(projectName)
        setMenu();
        $('#exitBtn').on('click', function (e) {
            e.preventDefault();
            exit();
        });

        //查询当前页面所有下拉框
        fjTypesSelect();
        yhTypesSelect();
        sfddTypesSelect();

        getDetails();

    <%@ include file="../../static/myInfo.js"%>
    });
    // 用户登出
    <%@ include file="../../static/logout.jsp"%>
</script>
</body>

</html>