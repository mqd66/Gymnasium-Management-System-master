<%--
  Created by IntelliJ IDEA.
  User: Meng
  Date: 2023/3/2
  Time: 17:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
            if (!checkEmpty("account", "帐号名"))
                return false;
            if (!checkEmpty("phone", "手机号"))
                return false;
            if (!checkEmpty("majorClass", "专业班级"))
                return false;
            return true;
        });
    });

</script>

<title>用户管理</title>

<div class="workingArea">
    <h1 class="label label-info">用户管理</h1>

    <br>
    <br>

    <div class="listDataTableDiv">
        <table class="table table-striped table-bordered table-hover table-condensed">
            <thead>
                <tr class="success">
                    <th>ID</th>
                    <th>姓名</th>
<%--                    <th>密码</th>--%>
<%--                    <th>用户邮箱</th>--%>
<%--                    <th>账号名称</th>--%>
                    <th>手机号</th>
                    <th>专业班级</th>
                    <th>编辑</th>
                    <th>删除</th>
                </tr>
            </thead>
            <tbody>


            <c:forEach items="${us}" var="u">
                <c:if test="${user.name != '管理员' || u.name != '超级管理员'}">
                    <tr>
                        <td>${u.id}</td>
                        <td>${u.name}</td>
                        <!-- 其他用户信息 -->
                        <td>${u.phone}</td>
                        <c:choose>
                            <c:when test="${u.name != '管理员' && u.name != '超级管理员'}">
                                <td>${u.majorClass}</td>
                            </c:when>
                            <c:otherwise>
                                <!-- 在此处添加您希望在 else 条件下显示的内容 -->
                                <td>------</td>
                            </c:otherwise>
                        </c:choose>
                        <!-- 显示超级管理员的编辑和删除链接 -->
                        <td><a href="admin_user_edit?id=${u.id}"><span class="glyphicon glyphicon-edit"></span></a></td>
                        <td><a deleteLink="true" href="admin_user_delete?id=${u.id}"><span class="glyphicon glyphicon-trash"></span></a></td>
                    </tr>
                </c:if>
            </c:forEach>
            </tbody>

        </table>
    </div>

    <div class="pageDiv">
        <%@include file="../include/admin/adminPage.jsp"%>
    </div>

    <div class="panel panel-warning addDiv">
        <div class="panel-heading">新增用户</div>
        <div class="panel-body">
            <form method="post" id="addForm" action="admin_user_add" enctype="multipart/form-data">
                <table class="addTable">
                    <tr>
                        <input type="hidden" name="id"  />
                    </tr>
                    <tr>
                        <td>姓名</td>
                        <td><input id="name" name="name" type="text" class="form-control"/></td>
                    </tr>
                    <tr>
                        <td>密码</td>
                        <td>
                            <input id="password" name="password" type="text" class="form-control" />
                        </td>
                    </tr>
                    <tr>
                        <td>邮箱</td>
                        <td>
                            <input id="email" name="email" type="text" class="form-control" />
                        </td>
                    </tr>
                    <tr>
                        <td>账号名</td>
                        <td>
                            <input id="account" name="account" class="form-control">
                        </td>
                    </tr>
                    <tr>
                        <td>手机号</td>
                        <td>
                            <input id="phone" name="phone" class="form-control">
                        </td>
                    </tr>
                    <tr>
                        <td>专业班级</td>
                        <td>
                            <select class="form-control" name="majorClass" id="majorClass" style="height: 30px">
                                <option value="">请选择专业班级</option>
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
<%@include file="../include/admin/adminFooter.jsp"%>