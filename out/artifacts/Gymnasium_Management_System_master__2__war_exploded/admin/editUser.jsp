<%--
  Created by IntelliJ IDEA.
  User: Meng
  Date: 2024/2/25/11
  Time: 23:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" import="java.util.*"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../include/admin/adminHeader.jsp"%>
<%@ include file="../include/admin/adminNavigator.jsp"%>

<script>
    $(function () {
        $("#addForm").submit(function () {
            if (!checkEmpty("name", "姓名"))
                return false;
            if (!checkEmpty("password", "密码"))
                return false;
            if (!checkEmpty("email", "邮箱"))
                return false;
            if (!checkEmpty("account", "账号名"))
                return false;
            if (!checkEmpty("phone", "手机号"))
                return false;
            // if (!checkEmpty("majorClass", "专业班级"))
            //     return false;
            return true;
        });
    });

</script>


<div class="workingArea">

    <ol class="breadcrumb">
        <li><a href="admin_user_list">用户管理</a></li>
        <li><a href="admin_user_edit?id=${user.id}">${user.name}</a></li>
        <li class="active">用户信息</li>
    </ol>

    <div class="panel panel-warning addDiv">
        <div class="panel-heading">修改用户信息</div>
        <div class="panel-body">
            <form method="post" id="addForm" action="admin_user_update" enctype="multipart/form-data">
                <table class="addTable">
                    <tr>
                        <input type="hidden" name="id" value="${user.id}" />
                    </tr>
                    <tr>
                        <td>姓名</td>
                        <td><input id="name" name="name" type="text" class="form-control" value="${user.name}"/></td>
                    </tr>
                    <tr>
                        <td>密码</td>
                        <td>
                            <input id="password" name="password" type="text" class="form-control" value="${user.password}"/>
                        </td>
                    </tr>
                    <tr>
                        <td>邮箱</td>
                        <td>
                            <input id="email" name="email" type="text" class="form-control" value="${user.email}"/>
                        </td>
                    </tr>
                    <tr>
                        <td>账号名</td>
                        <td>
                            <input id="account" name="account" class="form-control" value="${user.account}">
                        </td>
                    </tr>
                    <tr>
                        <td>手机号</td>
                        <td>
                            <input id="phone" name="phone" class="form-control" value="${user.phone}">
                        </td>
                    </tr>
                    <tr>
                        <td>专业班级</td>
                        <td>
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
                        </td>
                    </tr>
                    <tr class="submitTR">
                        <td colspan="2" align="center">
                            <button type="submit" class="btn btn-success">提交</button>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
</div>

<%@ include file="../include/admin/adminFooter.jsp"%>
