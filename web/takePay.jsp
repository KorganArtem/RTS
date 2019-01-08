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
        <select id='typePay'>
            <option value="1">Пополнение баланса</option>
            <option value="3">Пополнение депозита</option>
        </select><br>
        <label>ИД водителя</label>
        <input type='text' disabled id='takePayDriverId'/><br>
        <label>Фамилия имя</label>
        <input type='text' disabled id='takePayDriverName'/><br>
        <label>Сумма</label>
        <input type='text' id='takePayDriverSum'/><br>
        <select id='takePayDriverType'><br><br>
                <%= selectSourcePay %>
        </select><br>
        <label>Коментарий</label>
        <input type='text' id='takePayDriverComment'/><br><br>
        <input type='button' id='takePayButton' onclick="takePaySend()" value='Принять'/>
        <input type='button' id='takePayButton' onclick="closeModWind()" value='Отмена'/>
    </form>
</div>
