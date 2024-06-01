<%--
  Created by IntelliJ IDEA.
  User: Meng
  Date: 2024/2/25/21
  Time: 20:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="include/fore/foreHeader.jsp"%>
<link rel="stylesheet" href="css/fore/register.css">
</head>
<%@ include file="include/fore/foreNavigator.jsp"%>
<title>注册</title>
<script src="js/fore/register.js"></script>
<script>
    $(function () {
        <c:if test="${!empty msg}">
        // 使用 alert 函数显示错误信息
        alert("${msg}");
        $("span.errorMessage").html("${msg}");
        // $("div.registerErrorMessageDiv").css("visibility", "visible");
        </c:if>
    })
</script>




    <div class="content">
    <div class="login_wrapper" style="background-image:url('image/fore/main.jpg'); background-repeat: no-repeat; margin-top: 10px">
        <div class="glass" style="height: 518px"></div>
        <div class="login_content">
            <form role="form" method="post" action="foreregister" class="registerForm">
                <h5 class="login-text" style="font-size: 20px;text-align: center">注册账号</h5>

                <div class="registerErrorMessageDiv" style="margin: 3px">
                    <div class="alert" role="alert">
                        <span class="errorMessage" style="color: red"></span>
                    </div>
                </div>

                <div style="">
                    <div class="login-item form-group">
                        姓名:
                        <input type="text" class="form-control" name="name" id="name" placeholder="请输入姓名" required title="请输入姓名" onkeyup="validateName()">
                        <span id="name-tishi"></span>
                    </div>
                    <div class="login-item form-group">
                        手机号:
                        <input type="text" class="form-control" name="phone" id="phone" placeholder="请输入手机号" required title="请输入手机号" onkeyup="validatePhoneNumber()">
                        <span id="phone-tishi"></span>
                    </div>
                    <div class="login-item form-group">
                        账号:
                        <input type="text" class="form-control" name="account" id="account" placeholder="请输入合法账号" required title="请输入合法账号" onkeyup="validateAccount()">
                        <span id="account-tishi"></span>
                    </div>
                    <div class="login-item form-group">
                        密码:
                        <input type="password" class="form-control" name="password" placeholder="请输入密码" required id="pwd1">
                    </div>
                    <div class="login-item form-group">
                        确认密码:
                        <input type="password" class="form-control" placeholder="请确认密码" required id="pwd2" onkeyup="validate()">
                        <span id="tishi"></span>
                    </div>

                    <div class="login-item form-group">
                        专业班级:
                        <select class="form-control" name="majorClass" id="majorClass" style="height: 30px">
                            <option value="" disabled>请选择专业班级</option>
                            <option value="软件工程(大数据与机器学习方向)">软件工程(大数据与机器学习方向)</option>
                            <option value="软件工程(中外合作办学)">软件工程(中外合作办学)</option>
                            <option value="软件工程">软件工程</option>
                            <option value="计算机科学与技术">计算机科学与技术</option>
                            <option value="网络工程（智能互联方向）">网络工程（智能互联方向）</option>
                            <option value="电子信息工程">电子信息工程</option>
                            <option value="机器人工程">机器人工程</option>
                            <option value="数字媒体技术">数字媒体技术</option>
                            <option value="日语">日语</option>
                            <option value="商务英语">商务英语</option>
                            <option value="财务管理">财务管理</option>
                            <option value="电子商务">电子商务</option>
                            <option value="物流管理">物流管理</option>
                            <option value="市场营销(大数据营销本科方向&国际营销方向)">市场营销(大数据营销本科方向&国际营销方向)</option>
                            <option value="工商管理(创业与经营管理方向&智慧量化管理本科方向)">工商管理(创业与经营管理方向&智慧量化管理本科方向)</option>
                            <option value="大数据管理与应用">大数据管理与应用</option>
                            <option value="健康服务与管理">健康服务与管理</option>
                            <option value="信息管理与信息系统">信息管理与信息系统</option>
                            <option value="视觉传达设计">视觉传达设计</option>
                            <option value="环境设计">环境设计</option>
                            <option value="数字媒体艺术">数字媒体艺术</option>
                            <option value="动画">动画</option>
                            <option value="商务英语">商务英语</option>
                        </select>
                    </div>

                    <div class="login-item form-group d-flex justify-content-around">
                        <div class="btn-group">
                            <button type="submit" class="btn btn-primary" id="submit">&nbsp;&nbsp;注册&nbsp;&nbsp;</button>
                        </div>
                        <div class="btn-group">
                            <button type="reset" class="btn btn-primary" onclick="resetpwd()">&nbsp;&nbsp;重置&nbsp;&nbsp;</button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

    </div>
</div>
<%@ include file="include/fore/foreFooter.jsp"%>