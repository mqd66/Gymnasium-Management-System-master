package project.servlet;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import project.bean.Place;
import project.bean.User;
import project.util.ImageUtil;
import project.util.Page;

import org.springframework.web.util.HtmlUtils;

public class UserServlet extends BaseBackServlet {
    public String add(HttpServletRequest request, HttpServletResponse response, Page page) {
        Map<String, String> params = new HashMap<>();
        InputStream is = super.parseUpload(request, params);

        User user = new User();
//        user.setId(Integer.parseInt(params.get("id")));
        user.setName(params.get("name"));
        user.setPassword(params.get("password"));
        user.setEmail(params.get("email"));
        user.setAccount(params.get("account"));
        user.setPhone(params.get("phone"));
        user.setMajorClass(params.get("majorClass"));
        userDAO.add(user);
        return "@admin_user_list";

    }

    public String delete(HttpServletRequest request, HttpServletResponse response, Page page) {
        int id = Integer.parseInt(request.getParameter("id"));
        userDAO.delete(id);
        return "@admin_user_list";

    }

    public String edit(HttpServletRequest request, HttpServletResponse response, Page page) {
        int id = Integer.parseInt(request.getParameter("id"));
            User user = userDAO.get(id);
        request.setAttribute("user", user);
        return "admin/editUser.jsp";
    }

     public static User userOnlyOne;
    public String list(HttpServletRequest request, HttpServletResponse response, Page page) {
        List<User> us = userDAO.list(page.getStart(), page.getCount());
        int total = userDAO.getTotal();
        page.setTotal(total);
        if(userOnlyOne == null){
            userOnlyOne = (User) request.getSession().getAttribute("user");
            System.out.println("============================="+userOnlyOne.getName());
            request.setAttribute("userOnlyOne",userOnlyOne.getName());
        }
        request.setAttribute("us", us);
        request.setAttribute("page", page);

        return "admin/listUser.jsp";
    }

    public String update(HttpServletRequest request, HttpServletResponse response, Page page) {
        Map<String, String> params = new HashMap<>();
        InputStream is = super.parseUpload(request, params);

        User user = new User();
        user.setId(Integer.parseInt(params.get("id")));
        user.setName(params.get("name"));
        user.setPassword(params.get("password"));
        user.setEmail(params.get("email"));
        user.setAccount(params.get("account"));
        user.setPhone(params.get("phone"));
        user.setMajorClass(params.get("majorClass"));
        userDAO.update(user);
        return "@admin_user_list";
    }

}
