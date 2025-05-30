<%-- 
    Document   : logout
    Created on : May 23, 2025, 10:16:21 AM
    Author     : Laptop K1
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    session.invalidate(); // Hủy session
    response.sendRedirect("../index.jsp"); // Chuyển hướng về trang login
%>
