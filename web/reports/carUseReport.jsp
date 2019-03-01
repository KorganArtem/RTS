<%-- 
    Document   : carUseReport
    Created on : 15.02.2019, 17:29:03
    Author     : korgan
--%>
 
<%@page import="ru.leasicar.workerSql.ReportSQL"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
    ReportSQL rsql = new ReportSQL();
    if(request.getParameter("startDate")==null || request.getParameter("endDate")==null){
        %>
        Did not send request parametr
        <% return;
    }
    rsql.gerCarUseReport(request.getParameter("startDate"), request.getParameter("endDate"));
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>
