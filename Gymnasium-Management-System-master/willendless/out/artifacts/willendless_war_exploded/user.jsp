<%--
  Created by IntelliJ IDEA.
  User: Meng
  Date: 2024/2/25/25
  Time: 21:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="include/fore/foreHeader.jsp" %>
<link rel="stylesheet" href="css/fore/introduce.css">
<style>
    dd {
        cursor: pointer;
    }

    .row-fluid {
        background-color: white;
    }

    p, span, h1, h2, h3 {
        background-color: white;
    }

    #menu3 li {
        font-size: 14px;
        text-align: left;
        margin: 8px;
        display: block;
    }


</style>
</head>
<%@ include file="include/fore/foreNavigator.jsp" %>
<title>个人中心</title>

<script>
    function jump(id) {
        var tmp = document.getElementsByTagName("dd");
        for (var i = 0; i < tmp.length; i++) {
            tmp[i].style.backgroundColor = "white";
            tmp[i].style.color = "";
        }
        id.style.backgroundColor = "#007bff";
        id.style.color = "white";
        document.getElementById("where").innerText = id.innerText;
        document.getElementById("menu1").style.display = "none";
        document.getElementById("menu2").style.display = "none";
        document.getElementById("menu3").style.display = "none";
        // document.getElementById("menu4").style.display = "none";
        document.getElementById("menu" + id.id.toString()).style.display = "";
    }

    function checkDelete(status) {
        // if (status != '未预约') {
        //     alert("抱歉，预约完成后，无法删除预约单号！");
        //     return false;
        // }

        var ret = window.confirm("确认是否删除该预约单号？");
        return ret;
    }
</script>

<!-- tab标签开始 -->
<div id="wrapper" style="margin-top: 20px">


    <div class="sub-nav" id="sub-nav" style="min-height: 670px; width: 180px">
        <dl style="background-color: #fff;">
            <dt>个人中心</dt>
            <dd id="1" style="background-color: #007bff; color: white; border-bottom: 1px solid #ddd"
                onclick="jump(this)">预约单号管理
            </dd>
            <dd id="2" style="background-color: white;border-bottom: 1px solid #ddd" onclick="jump(this)">预约规则</dd>
            <dd id="3" style="background-color: white;border-bottom: 1px solid #ddd" onclick="jump(this)">个人信息</dd>
        </dl>
        <div class="img-box">
            <img src="image/fore/sub-img.jpg" style="padding-top: 70px; background-color: white" width="178"
                 height="300"/>
        </div>
    </div>

    <div class="sub-content-con" style="width: 900px;min-height: 598px; background-color: white">
        <div class="position-bar">
            当前位置：个人中心&nbsp;>&nbsp;<span id="where" style="background-color: #f0f0f0">预约单号管理</span>
        </div>

        <!-- 预约单号内容 -->
        <div style="padding: 12px;" id="menu1">
            <div class="reserveList">
                <!--总表头部-->
                <table class="orderListTitleTable">
                    <tr>
                        <%--                        <td width="70px">场地</td>--%>
                        <%--                        <td width="350px">预约时间</td>--%>
                        <%--&lt;%&ndash;                        <td width="70px">预约人数</td>&ndash;%&gt;--%>
                        <%--                        <td width="60px">状态</td>--%>
                        <td width="19px">场地</td>
                        <td width="68px">预约时间</td>
                        <%--                        <td width="70px">预约人数</td>--%>
                        <td width="78px">状态</td>
                    </tr>
                </table>


                <c:forEach items="${reserveList}" var="r">
                    <table class="orderListItemTable">

                        <!--预约单号头-->
                        <tr class="orderListItemFirstTR">
                            <td colspan="2">
                                <b><fmt:formatDate value="${r.time}" pattern="yyyy-MM-dd HH:mm:ss"/> </b>
                                <span style="background-color: #f0f0f0">预约单号：${r.id}</span>
                            </td>
                            <td colspan="1"></td>
                            <td class="orderItemDeleteTD">
                                <a href="foredeleteReserve?rid=${r.id}"
                                   onclick="return checkDelete('${reserve.status}')"><span
                                        class="orderListItemDelete glyphicon glyphicon-trash"></span></a></span>
                            </td>
                        </tr>

                        <!--预约单号内容-->

                        <c:forEach items="${r.reserveItemList}" var="reserveItem" varStatus="st">
                            <tr class="orderItemTR">
                                <td class="orderItemProductInfoPartTD">${reserveItem.stadiumPlanItem.name}</td>
                                <td class="orderItemProductInfoPartTD">${reserveItem.stadiumPlanItem.beg}~${reserveItem.stadiumPlanItem.end}</td>

                                <c:if test="${st.count == 1}">
                                    <%--                                <td valign="center" rowspan="${fn:length(r.reserveItemList)}" class="orderListItemNumberTD orderItemOrderInfoPartTD" width="100px">--%>
                                    <%--                                    <span class="orderListItemNumber">${r.fare}元</span>--%>
                                    <%--                                </td>--%>
                                    <td valign="center" rowspan="${fn:length(r.reserveItemList)}"
                                        class="orderListItemNumberTD orderItemOrderInfoPartTD" width="100px">

<%--                                        <c:if test="${r.status eq '未预约'}">--%>
<%--                                            <a href="foreuserPay?rid=${r.id}"><span--%>
<%--                                                    class="glyphicon glyphicon-ok">预约</span></a>--%>
<%--                                        </c:if>--%>
                                        <c:if test="${r.status eq '审核中'}">
                                            <span>预约成功,审核中</span>
                                        </c:if>
                                        <c:if test="${r.status eq '审核通过'}">
                                            <span>审核通过</span>
                                        </c:if>
                                        <c:if test="${r.status eq '审核未通过'}">
                                            <a href="#" style="cursor: pointer"><span>审核未通过！</span></a>
                                        </c:if>
                                    </td>
                                </c:if>
                            </tr>
                        </c:forEach>

                    </table>
                </c:forEach>

            </div>
        </div>

        <!--预约规则-->
        <div style="padding: 12px;background-color: white; display: none" id="menu2">
            <div class="row-fluid" style="background-color: white;">
                <h3>场馆预约系统须知</h3>
                <p style="line-height:20px;margin-bottom:10px;"><span
                        style="font-family:helvetica;color:#333333;font-size:14px;font-family:宋体;">一、本系统支持网上预约用户为学校内学生和教职工</span><span
                        style="font-family:helvetica;color:#333333;font-size:14px"></span></p>
                <p style="line-height:20px;margin-bottom:10px;"><span
                        style="font-family:helvetica;color:#333333;font-size:14px"><span style="font-family:宋体;">二、系统提供</span>3<span
                        style="font-family:宋体;">天内场地使用情况浏览与预约</span></span><span
                        style="font-family:helvetica;color:#333333;font-size:14px"></span></p>
                <p style="line-height:20px;margin-bottom:10px;"><span
                        style="font-family:helvetica;color:#333333;font-size:14px;font-family:宋体;">三、各场馆网上预约时间与方式</span><span
                        style="font-family:helvetica;color:#333333;font-size:14px"></span></p>
                <p style="line-height:20px;margin-bottom:10px;"></p>
                <p style="line-height:20px;margin-bottom:10px;"><span
                        style="font-family:helvetica;color:#333333;font-size:14px"><span style="font-family:宋体;">预约时间：全天预约当天及后</span>3<span
                        style="font-family:宋体;">天的场地，每天早</span><span
                        style="font-family:helvetica;">8</span><span style="font-family:宋体;">点准时开放第</span><span
                        style="font-family:helvetica;">4</span><span style="font-family:宋体;">天的场地，以此类推。</span></span><span
                        style="font-family:helvetica;color:#333333;font-size:14px"></span></p>
                <p style="line-height:20px;margin-bottom:10px;"><span
                        style="font-family:helvetica;color:#333333;font-size:14px;font-family:宋体;">预约方式：网上预约，现场预约。</span><span
                        style="font-family:helvetica;color:#333333;font-size:14px"></span></p>
                <p style="line-height:20px;margin-bottom:10px;"><span
                        style="color:#333333;font-size:14px;font-family:宋体;">四</span><span
                        style="font-family:helvetica;color:#333333;font-size:14px;font-family:宋体;">、入场须出示预定场地人员校园卡。</span><span
                        style="font-family:helvetica;color:#333333;font-size:14px"></span></p>
                <p style="line-height:20px;margin-bottom:10px;"><span
                        style="color:#333333;font-size:14px;font-family:宋体;">五</span><span
                        style="font-family:helvetica;color:#333333;font-size:14px;font-family:宋体;">、为规范管理，确保场馆的正常运行，请到场锻炼人员自觉遵守以下规定：</span><span
                        style="font-family:helvetica;color:#333333;font-size:14px"></span></p>
                <p style="line-height:20px;margin-bottom:10px;"><span
                        style="font-family:helvetica;color:#333333;font-size:14px">1<span style="font-family:宋体;">、自觉维护场地秩序，遵守社会公德，讲文明礼貌，服从管理人员管理；</span></span><span
                        style="font-family:helvetica;color:#333333;font-size:14px"></span></p>
                <p style="line-height:20px;margin-bottom:10px;"><span
                        style="font-family:helvetica;color:#333333;font-size:14px">2<span style="font-family:宋体;">、进入场地的人员须穿运动专业鞋或浅色软胶底无钉运动鞋。如遇雨雪天气，须鞋底干净后方可进入场地，雨具须在指定地点存放，不得带入场地；</span></span><span
                        style="font-family:helvetica;color:#333333;font-size:14px"></span></p>
                <p style="line-height:20px;margin-bottom:10px;"><span
                        style="font-family:helvetica;color:#333333;font-size:14px">3<span style="font-family:宋体;">、须按预定场地位置进行活动，禁止打空场、边场；如额外使用其他空闲场地请自觉交费；</span></span><span
                        style="font-family:helvetica;color:#333333;font-size:14px"></span></p>
                <p style="line-height:20px;margin-bottom:10px;"><span
                        style="font-family:helvetica;color:#333333;font-size:14px">4<span style="font-family:宋体;">、如客户因故不能按时来馆锻炼，请至少提前</span><span
                        style="font-family:helvetica;">24</span><span style="font-family:宋体;">小时通知我馆，否则按出席计算；如遇场馆大型活动占用场地，场地将自动顺延或另行安排；</span></span><span
                        style="font-family:helvetica;color:#333333;font-size:14px"></span></p>
                <p style="line-height:20px;margin-bottom:10px;"><span
                        style="font-family:helvetica;color:#333333;font-size:14px">5<span style="font-family:宋体;">、未成年人（</span><span
                        style="font-family:helvetica;">14</span><span style="font-family:宋体;">岁以下）须由成年人陪伴方可进入，并在活动中对其负监护责任；</span></span><span
                        style="font-family:helvetica;color:#333333;font-size:14px"></span></p>
                <p style="line-height:20px;margin-bottom:10px;"><span
                        style="font-family:helvetica;color:#333333;font-size:14px">6<span style="font-family:宋体;">、自觉维护馆内和场地卫生，严禁在场地内食用口香糖等食物、喝碳酸饮料、随地吐痰、乱丢杂物，场馆严禁吸烟；</span></span><span
                        style="font-family:helvetica;color:#333333;font-size:14px"></span></p>
                <p style="line-height:20px;margin-bottom:10px;"><span
                        style="font-family:helvetica;color:#333333;font-size:14px">7<span style="font-family:宋体;">、注意安全，不要在球场间快跑穿行，以免发生危险；酒后或患有高血压、心脏病、癫痫等危险易急性发病者，不宜参加剧烈运动，禁止入内，后果自负；</span></span><span
                        style="font-family:helvetica;color:#333333;font-size:14px"></span></p>
                <p style="line-height:20px;margin-bottom:10px;"><span
                        style="font-family:helvetica;color:#333333;font-size:14px">8<span style="font-family:宋体;">、自行保管私人物品，防止丢失，丢失责任自负；</span></span><span
                        style="font-family:helvetica;color:#333333;font-size:14px"></span></p>
                <p style="line-height:20px;margin-bottom:10px;"><span
                        style="font-family:helvetica;color:#333333;font-size:14px">9<span style="font-family:宋体;">、场馆禁止一切私自培训，包括教练私自带班、学生自己请教练等一切培训行为，如发现立即取消其全部场地，并将该用户记录到诚信记录里，取消订场资格；</span></span><span
                        style="font-family:helvetica;color:#333333;font-size:14px"></span></p>
                <p style="line-height:20px;margin-bottom:10px;"><span
                        style="font-family:helvetica;color:#333333;font-size:14px">10<span style="font-family:宋体;">、损坏场馆设施，一律照价赔偿；</span></span><span
                        style="font-family:helvetica;color:#333333;font-size:14px"></span></p>
                <p style="line-height:20px;margin-bottom:10px;"><span
                        style="font-family:helvetica;color:#333333;font-size:14px">11<span style="font-family:宋体;">、教工或学生订场后必须是本校教工或学生锻炼使用，不得擅自出租或转让给校外人员使用，如发现场馆将通报批评，取消场地使用权，并将该用户记录到诚信记录里，取消订场资格；</span></span><span
                        style="font-family:helvetica;color:#333333;font-size:14px"></span></p>
                <p style="line-height:20px;margin-bottom:10px;"><span
                        style="font-family:helvetica;color:#333333;font-size:14px">12<span style="font-family:宋体;">、进入场地人员必须严格遵守以上规定，凡违反管理规定者，管理人员有权终止其使用权。</span></span><span
                        style="font-family:helvetica;color:#333333;font-size:14px"></span></p>

                <p style="line-height:20px;margin-bottom:10px;"><span
                        style="font-family:helvetica;color:#333333;font-size:14px"> </span></p>
                <p style="line-height:20px;margin-bottom:10px;"><span
                        style="font-family:helvetica;color:#333333;font-size:14px"> </span></p>
                <p style="line-height:20px;margin-bottom:10px;"><span style="color:#333333;font-size:14px"> </span></p>
                <p style="text-align:right;line-height:20px;text-align:right;margin-bottom:10px;"><span
                        style="font-family:helvetica;color:#333333;font-size:14px;font-family:宋体;">场馆预约管理中心</span><span
                        style="font-family:helvetica;color:#333333;font-size:14px"></span></p>
                <p style="text-align:right;line-height:20px;text-align:right;"><span
                        style="font-family:helvetica;color:#333333;font-size:14px">2024<span
                        style="font-family:宋体;">年</span><span style="font-family:helvetica;">3</span><span
                        style="font-family:宋体;">月</span></span><span
                        style="font-family:helvetica;color:#333333;font-size:14px"></span></p>
                <p><br/></p>
            </div>
        </div>

        <!--个人信息-->
        <div style="padding: 12px; background-color: white; display: none" id="menu3">
            <div id="userInfoForm" style="background-color: white;margin: 20px 260px;  color: #333333;">
                <img src="image/fore/moren.png" style="width: 110px;margin-left:75px;margin-bottom: 20px">
                <form action="foreuseredit">
                    <ul style="list-style: none">
<%--                        <li>--%>
<%--                            <span class="fh">用户名:</span>--%>
<%--                            <span style="padding-left: 15px">${user.name}</span>--%>
<%--                        </li>--%>
                        <li>
                            <span class="fh">姓名:</span>
                            <input style="margin-left: 25px" type="text" name="name" id="name" value="${user.name}"/>
                        </li>
                        <li>
                            <span class="fh">邮箱:</span>
                            <input style="margin-left: 25px" type="text" name="email" id="email" value="${user.email}"/>
                        </li>
                        <li>
                            <span class="fh">手机号:</span>
                            <input style="margin-left: 25px" type="text" name="phone" id="phone" value="${user.phone}" required title="请输入手机号" onkeyup="validatePhoneNumber()"/>
                        </li>
                        <li>
                            <span class="fh">专业班级:</span>
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
                        </li>
                        <li>
                            <span class="fh">修改密码:</span>
                            <input type="password" class="form-control" name="password" placeholder="请输入密码" required id="pwd1">
                        </li>
                        <li>
                            <span class="fh">确认密码:</span>
                            <input type="password" class="form-control" placeholder="请确认密码" required id="pwd2" onkeyup="validate()">
                        </li>


                    </ul>
                    <div class="submitTR" style="margin-left: 108px; margin-top: 20px">
                        <td colspan="2">
                            <button type="submit" class="btn btn-success">保存</button>
                        </td>
                    </div>
                </form>
            </div>
        </div>

    </div>


</div>


</div>
</div>
<script>
    var userMajorClass = "${user.majorClass}";

    var majorClassSelect = document.getElementById("majorClass");
    for (var i = 0; i < majorClassSelect.options.length; i++) {
        if (majorClassSelect.options[i].value === userMajorClass) {
            majorClassSelect.options[i].selected = true;
            break;
        }
    }
</script>
<%@include file="include/fore/foreFooter.jsp" %>


