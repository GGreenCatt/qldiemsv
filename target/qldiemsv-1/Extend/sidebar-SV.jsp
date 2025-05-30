<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String currentPage = request.getRequestURI();
    String fileName = currentPage.substring(currentPage.lastIndexOf("/") + 1);
%>

<div class="sidenav">
    <h1><a href="index.jsp">Quản lý điểm</a></h1>
    <ul>
        <li>
            <a class="<%= "index.jsp".equals(fileName) ? "active" : "" %>" href="index.jsp">
                <span class="material-symbols-outlined icon-menu">home</span>Trang chủ
            </a>
        </li>
        <li>
            <a class="<%= "TTC.jsp".equals(fileName) ? "active" : "" %>" href="TTC.jsp">
                <span class="material-symbols-outlined icon-menu">dataset</span>Thông tin chung
            </a>
        </li>
        <li class="dropdown-toggler">
            <a class="<%= "Diem.jsp".equals(fileName) ? "active" : "" %>" href="Diem.jsp">
                <span class="material-symbols-outlined icon-menu">monitoring</span>Xem điểm
            </a>
        </li>
        <li class="dropdown-toggler">
            <a class="<%= "DS-SV.jsp".equals(fileName) ? "active" : "" %>" href="DS-SV.jsp">
                <span class="material-symbols-outlined icon-menu">school</span>Sinh viên
            </a>
        </li>
        <li class="dropdown-toggler">
            <a class="<%= "DS-GV.jsp".equals(fileName) ? "active" : "" %>" href="DS-GV.jsp">
                <span class="material-symbols-outlined icon-menu">person</span>Giảng viên
            </a>
        </li>
        <li class="dropdown-toggler">
            <a class="<%= "DS-MH.jsp".equals(fileName) ? "active" : "" %>" href="DS-MH.jsp">
                <span class="material-symbols-outlined icon-menu">menu_book</span>Môn học
            </a>
        </li>
        <li class="dropdown-toggler">
            <a class="<%= "DS-LOP.jsp".equals(fileName) ? "active" : "" %>" href="DS-LOP.jsp">
                <span class="material-symbols-outlined icon-menu">class</span>Lớp
            </a>
        </li>
        <li>
            <a class="<%= "phanhoi.jsp".equals(fileName) ? "active" : "" %>" href="phanhoi.jsp">
                <span class="material-symbols-outlined icon-menu">forward_to_inbox</span>Phản hồi
            </a>
        </li>
    </ul>
</div>
