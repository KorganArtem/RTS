<%-- 
    Document   : takePay
    Created on : 05.02.2018, 18:18:13
    Author     : korgan
--%>

<%@page import="ru.leasicar.workerSql.PaySQL"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    PaySQL psql = new PaySQL();
    String selectSourcePay = psql.paySourceSelect();
%>
<div id='takePay1'>
    <form class='takePayForm'>
        <input type='text' style='display: none' disabled id='typePay'/><br>
        <input type='text' disabled id='takePayDriverId'/><br>
        <input type='text' disabled id='takePayDriverName'/><br>
        <input type='text' id='takePayDriverSum'/><br>
        <select id='takePayDriverType'><br>
                <%= selectSourcePay %>
        </select><br>
        <input type='button' id='takePayButton' onclick="takePaySend()" value='Принять'/>
        <input type='button' id='takePayButton' onclick="closeModWind()" value='Отмена'/>
    </form>
</div>
