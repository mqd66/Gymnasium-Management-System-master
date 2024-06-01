package project.servlet;

import org.springframework.web.util.HtmlUtils;
import project.bean.*;
import project.dao.*;
import project.util.Page;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.*;

@WebServlet(name = "ForeServlet")
public class ForeServlet extends  BaseForeServlet{
    //主页
    public String home(HttpServletRequest request, HttpServletResponse response, Page page) {
        //场馆
        List<Place> placeList = placeDAO.list(0, 5);
        request.setAttribute("places", placeList);
        //通知
        List<News> newsList = newsDAO.list(0, 5);
        request.setAttribute("news", newsList);
        request.setAttribute("where", "home.jsp");
        return "home.jsp";
    }
    //场馆介绍页
    public String introduce(HttpServletRequest request, HttpServletResponse response, Page page) {
        request.setAttribute("where", "introduce.jsp");

        List<Place> placeList = placeDAO.list();
        request.setAttribute("placeList", placeList);

        return "introduce.jsp";
    }

    //注册
    public String register(HttpServletRequest request, HttpServletResponse response, Page page) {
        try {
            request.setCharacterEncoding("UTF-8");
            response.setCharacterEncoding("UTF-8");

            String account = new String(request.getParameter("account").getBytes("ISO-8859-1"),"UTF-8");
            account = HtmlUtils.htmlEscape(account);

            String name = new String(request.getParameter("name").getBytes("ISO-8859-1"),"UTF-8");
            name = HtmlUtils.htmlEscape(name);

            String password = new String(request.getParameter("password").getBytes("ISO-8859-1"),"UTF-8");
            password = HtmlUtils.htmlEscape(password);

            String phone = new String(request.getParameter("phone").getBytes("ISO-8859-1"),"UTF-8");
            phone = HtmlUtils.htmlEscape(phone);

            String majorClass = new String(request.getParameter("majorClass").getBytes("ISO-8859-1"),"UTF-8");
            majorClass = HtmlUtils.htmlEscape(majorClass);

            boolean exist = userDAO.isExist(account);

            if (exist) {
                request.setAttribute("msg", "账号已经被使用，请重新注册！");
                return "register.jsp";
            }
            System.out.println("Name: " + account);
            System.out.println("Password: " + password);
            System.out.println("Phone: " + phone);
            System.out.println("Major Class: " + majorClass);
            User user = new User();
            user.setPhone(phone);
            user.setName(name);
            user.setMajorClass(majorClass);
            user.setPassword(password);
            user.setAccount(account);
            userDAO.add(user);

            // Output the variables to the console
            System.out.println("account: " + account);
            System.out.println("Password: " + password);
            System.out.println("Phone: " + phone);
            System.out.println("Major Class: " + majorClass);
        } catch (IOException e) {
            e.printStackTrace();
        }

        return login(request, response, page);
    }


    //登陆、登出
    public String login(HttpServletRequest request, HttpServletResponse response, Page page) {
        try {
            request.setCharacterEncoding("UTF-8");
            response.setCharacterEncoding("UTF-8");
            String name = new String(request.getParameter("account").getBytes("ISO-8859-1"),"UTF-8");
            name = HtmlUtils.htmlEscape(name);
            String password = request.getParameter("password");

            User user = userDAO.get(name, password);
//            System.out.println(user.toString());
            if (user == null) {
                request.setAttribute("msg", "账号密码错误");
                return "login.jsp";
            } else if (user.getAccount().equals("20225620111")|| user.getAccount().equals("20225620110")) {
                request.getSession().setAttribute("user", user);
//                request.getSession().setAttribute("abcdd", user);
                return "@admin_place_list";
            }
            request.getSession().setAttribute("user", user);

        } catch (IOException e) {
            e.printStackTrace();
        }
        return "@forehome";
    }
    //    public String getUser(HttpServletRequest request, HttpServletResponse response, Page page) {
//        user.setName(request.getParameter("name"));
//        return user(request, response, page);
//    }
    public String logout(HttpServletRequest request, HttpServletResponse response, Page page) {
        request.getSession().removeAttribute("user");
        return "@forehome";
    }

    public String checkLogin(HttpServletRequest request, HttpServletResponse response, Page page) {
        User user =(User) request.getSession().getAttribute("user");
        if(null!=user)
            return "%success";
        return "%fail";
    }

    public String loginAjax(HttpServletRequest request, HttpServletResponse response, Page page) {
        String name = request.getParameter("name");
        String password = request.getParameter("password");
        User user = userDAO.get(name,password);

        if(null==user){
            return "%fail";
        }
        request.getSession().setAttribute("user", user);
        return "%success";
    }

    //   模糊搜索
    public String queryLike(HttpServletRequest request, HttpServletResponse response, Page page) throws UnsupportedEncodingException {
//        book(request,response,page);
//        System.out.println("===============================================================================");
        //所有场馆
        List<Place> placeList = new PlaceDAO().list();
        request.setAttribute("placeList", placeList);
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String query = request.getParameter("query");

        Place place = new PlaceDAO().getLike(query);
        if(place == null){
            throw new RuntimeException("出错了！");
        }
        placeStadiumDAO.fill(place);  //填充场馆的场地
        request.setAttribute("place", place);
        //可选日期信息
        Date current = new Date(System.currentTimeMillis());
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(current);
        List<java.sql.Date> dateValid = new ArrayList<>();
        calendar.add(Calendar.DATE, 0);
        dateValid.add(new java.sql.Date(calendar.getTimeInMillis()));
        calendar.add(Calendar.DATE, 1);
        dateValid.add(new java.sql.Date(calendar.getTimeInMillis()));
        calendar.add(Calendar.DATE, 1);
        dateValid.add(new java.sql.Date(calendar.getTimeInMillis()));
        request.setAttribute("dates", dateValid);

//        PlaceStadium placeStadium = placeStadiumDAO.get(place.getId());
//        placeStadiumDAO.fill(placeStadium.getPlace());
//        request.removeAttribute("place");
//        request.setAttribute("place", placeStadium.getPlace());

//        List<List<StadiumPlan>> lists = new ArrayList<>();
//        //每个日期获得一个安排表列表
////        for (int i = 0; i < dateValid.size(); i++)
////            lists.add(stadiumPlanDAO.search(placeStadium.getId(), dateValid.get(i)));
////        request.setAttribute("lists", lists);
//
//
//        String date = null;   //日期：切换场馆或场地设的日期
//            date = dateValid.get(0).toString();
//
//        request.setAttribute("date", date);
//        request.setAttribute("where", "book.jsp");
//
//        if (request.getParameter("flag") != null)
//            request.setAttribute("flag", 1);



        return "book.jsp";
    }


    //预定页
    public String book(HttpServletRequest request, HttpServletResponse response, Page page) {

        //所有场馆
        List<Place> placeList = new PlaceDAO().list();
        request.setAttribute("placeList", placeList);

        //可选日期信息
        Date current = new Date(System.currentTimeMillis());
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(current);
        List<java.sql.Date> dateValid = new ArrayList<>();
        calendar.add(Calendar.DATE, 0);
        dateValid.add(new java.sql.Date(calendar.getTimeInMillis()));
        calendar.add(Calendar.DATE, 1);
        dateValid.add(new java.sql.Date(calendar.getTimeInMillis()));
        calendar.add(Calendar.DATE, 1);
        dateValid.add(new java.sql.Date(calendar.getTimeInMillis()));
        request.setAttribute("dates", dateValid);

        //当前所选场馆、场地、安排表
        String pid = request.getParameter("pid");
        String psid = request.getParameter("psid");


        Place place = null;     //场馆：需要填充场地
        PlaceStadium placeStadium = null;       //场地：需要填充安排表
        String date = null;   //日期：切换场馆或场地设的日期

        //获得场馆
        if (pid == null) {  //未选择场馆
            place = placeList.get(0);
        } else {
            place = placeDAO.get(Integer.parseInt(pid));
        }
        placeStadiumDAO.fill(place);  //填充场馆的场地
        request.setAttribute("place", place);

        //获得场地
        if (psid == null) {   //未选择场地
            placeStadium = place.getPlaceStadium().get(0);
        } else {    //选过场地，移除默认场馆
            placeStadium = placeStadiumDAO.get(Integer.parseInt(psid));
            placeStadiumDAO.fill(placeStadium.getPlace());
            request.removeAttribute("place");
            request.setAttribute("place", placeStadium.getPlace());
        }
        request.setAttribute("placeStadium", placeStadium);
        request.setAttribute("name", placeStadium.getName());

        List<List<StadiumPlan>> lists = new ArrayList<>();
        //每个日期获得一个安排表列表
        for (int i = 0; i < dateValid.size(); i++)
            lists.add(stadiumPlanDAO.search(placeStadium.getId(), dateValid.get(i)));
        request.setAttribute("lists", lists);


        if (date == null) {
            date = dateValid.get(0).toString();
        }
        request.setAttribute("date", date);
        request.setAttribute("where", "book.jsp");

        if (request.getParameter("flag") != null)
            request.setAttribute("flag", 1);

        return "book.jsp";
    }


    //预约单号生成：安排项修改为：未预约，预约单号修改为未预约
    public String bookSubmit(HttpServletRequest request, HttpServletResponse response, Page page) {
        /*生成新预约单号*/
        Reserve reserve = new Reserve();
//        request.setAttribute("fare");
        /*预约单号提交的处理*/
        User user =(User) request.getSession().getAttribute("user");    //用户
        int pid = Integer.parseInt(request.getParameter("pid"));     //场馆
        int psid = Integer.parseInt(request.getParameter("psid"));   //场地
//        int fare = Integer.parseInt(request.getParameter("fare"));      //总价格

        //新增预约单号
        reserve.setTime(new java.sql.Timestamp(System.currentTimeMillis()));
        reserve.setName(placeDAO.get(pid).getName()+placeStadiumDAO.get(psid).getName());
//        reserve.setFare(fare);
        reserve.setStatus("未预约");
        reserve.setUser(user);

        reserveDAO.add(reserve);

        Enumeration all = request.getParameterNames();

        while(all.hasMoreElements()) {
            String name = all.nextElement().toString();
            if (!name.equals("pid") && !name.equals("psid") && !name.equals("fare")) {
                System.out.println(name);
                //修改安排表项状态
                int itemId = Integer.parseInt(request.getParameter(name));
                stadiumPlanItemDAO.edit(itemId, "未预约"); //编辑状态
                //新增预约单号项
                ReserveItem reserveItem = new ReserveItem();
                reserveItem.setStadiumPlanItem(stadiumPlanItemDAO.get(itemId));
                reserveItem.setReserveId(reserve.getId());
                reserveItemDAO.add(reserveItem);
            }
        }

        return "@forebook?flag=1";
    }

    //用户页及操作
    public String user(HttpServletRequest request, HttpServletResponse response, Page page) {
        User user = (User)request.getSession().getAttribute("user");
        List<Reserve> reserveList = reserveDAO.list(user.getId());
        for (int i = 0; i < reserveList.size(); i++) {
            reserveItemDAO.fill(reserveList.get(i));
        }
        request.setAttribute("reserveList", reserveList);
        return "user.jsp";
    }
    //    修改个人信息
    public String useredit(HttpServletRequest request, HttpServletResponse response, Page page) {
        User user = (User)request.getSession().getAttribute("user");
        user.setName(request.getParameter("name"));
        user.setEmail(request.getParameter("email"));
        user.setPhone(request.getParameter("phone"));
        user.setPassword(request.getParameter("password"));
        user.setMajorClass(request.getParameter("majorClass"));

//        System.out.println(user.toString());
        userDAO.update(user);
        return user(request, response, page);
    }
    //预约及修改状态
    public String userPay(HttpServletRequest request, HttpServletResponse response, Page page) {
        int rid = Integer.parseInt(request.getParameter("rid"));
        Reserve reserve = new Reserve();
        reserve.setId(rid);
        //预约单号状态修改为已预约
        reserveDAO.edit(rid, "审核中");
        //场地安排表项状态修改为"审核中"
        reserveItemDAO.fill(reserve);
        for (int i = 0; i < reserve.getReserveItemList().size(); i++) {
            stadiumPlanItemDAO.edit(reserve.getReserveItemList().get(i).getId(), "审核中");
        }
        return "@foreuser";
    }

    public String deleteReserve(HttpServletRequest request, HttpServletResponse response, Page page) {
        reserveDAO.delete(Integer.parseInt(request.getParameter("rid")));
        return "@foreuser";
    }


    //通知页
    public String news(HttpServletRequest request, HttpServletResponse response, Page page) {
        request.setAttribute("where", "news.jsp");

        List<News> newsList = newsDAO.list();
        request.setAttribute("newsList", newsList);
        return "news.jsp";
    }

    public String newsShow(HttpServletRequest request, HttpServletResponse response, Page page) {
        request.setAttribute("where", "news.jsp");

        int id = Integer.parseInt(request.getParameter("nid"));
        News news = newsDAO.get(id);
        request.setAttribute("news", news);
        return "newsShow.jsp";
    }

}
