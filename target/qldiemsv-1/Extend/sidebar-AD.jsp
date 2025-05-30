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
            <a class="<%= "Diem.jsp".equals(fileName) ? "active" : "" %>" href="#">
                <span class="material-symbols-outlined icon-menu">monitoring</span>Xem điểm
            </a>
            <ul class="dropdown">
                <li><a href="Diem.jsp?id=K10">Khóa 10</a></li>
                <li><a href="Diem.jsp?id=K11">Khóa 11</a></li>
            </ul>
        </li>

        <li class="dropdown-toggler">
            <a class="<%= "Nhap_diem.jsp".equals(fileName) ? "active" : "" %>" href="#">
                <span class="material-symbols-outlined icon-menu">edit_document</span>Nhập điểm
            </a>
            <ul class="dropdown">
                <li><a href="Nhap_diem.jsp?id=K10">Khóa 10</a></li>
                <li><a href="Nhap_diem.jsp?id=K11">Khóa 11</a></li>
            </ul>
        </li>

        <li class="dropdown-toggler">
            <a class="<%= ("DS-SV.jsp".equals(fileName) || "Them-SV.jsp".equals(fileName)) ? "active" : "" %>" href="#">
                <span class="material-symbols-outlined icon-menu">school</span>Sinh viên
            </a>
            <ul class="dropdown">
                <li><a href="DS-SV.jsp">Danh sách</a></li>
                <li><a href="Them-SV.jsp">Thêm</a></li>
            </ul>
        </li>

        <li class="dropdown-toggler">
            <a class="<%= ("DS-GV.jsp".equals(fileName) || "Them-GV.jsp".equals(fileName)) ? "active" : "" %>" href="#">
                <span class="material-symbols-outlined icon-menu">person</span>Giảng viên
            </a>
            <ul class="dropdown">
                <li><a href="DS-GV.jsp">Danh sách</a></li>
                <li><a href="Them-GV.jsp">Thêm</a></li>
            </ul>
        </li>

        <li class="dropdown-toggler">
            <a class="<%= ("DS-MH.jsp".equals(fileName) || "Them-MH.jsp".equals(fileName)) ? "active" : "" %>" href="#">
                <span class="material-symbols-outlined icon-menu">menu_book</span>Môn học
            </a>
            <ul class="dropdown">
                <li><a href="DS-MH.jsp">Danh sách</a></li>
                <li><a href="Them-MH.jsp">Thêm</a></li>
            </ul>
        </li>

        <li class="dropdown-toggler">
            <a class="<%= ("DS-LOP.jsp".equals(fileName) || "Them-LOP.jsp".equals(fileName)) ? "active" : "" %>" href="#">
                <span class="material-symbols-outlined icon-menu">class</span>Lớp
            </a>
            <ul class="dropdown">
                <li><a href="DS-LOP.jsp">Danh sách</a></li>
                <li><a href="Them-LOP.jsp">Thêm</a></li>
            </ul>
        </li>

        <li>
            <a class="<%= "phanhoi.jsp".equals(fileName) ? "active" : "" %>" href="phanhoi.jsp">
                <span class="material-symbols-outlined icon-menu">forward_to_inbox</span>Phản hồi
            </a>
        </li>
    </ul>
</div>
