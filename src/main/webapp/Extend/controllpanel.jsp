<%-- 
    Document   : controllpanel
    Created on : Apr 1, 2025, 10:43:50 PM
    Author     : Laptop K1
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

        <div class="controlpanel">
            <div class="status">
                <h2>Trang chủ</h2>
            </div>

            <ul class="menu">
                <li class="user_DRD"><img src="" alt=""><%= session.getAttribute("username") %>
                  <div class="user_DRD_CT">
                      <a href="../../Extend/logout.jsp">Đăng xuất</a>
                  </div>
              </li>
            </ul>
        </div>
