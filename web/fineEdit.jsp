<%-- 
    Document   : fineEdit
    Created on : Sep 29, 2018, 4:38:26 PM
    Author     : Artem
--%>

<%@page import="com.google.gson.JsonObject"%>
<%@page import="ru.leasicar.authorization.AccessControl"%>
<%@page import="java.util.Map"%>
<%@page import="ru.leasicar.workerSql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
    AccessControl ac = new AccessControl();
    if(!ac.isLogIn(request.getSession().getId())){%>
        <meta http-equiv="refresh" content="1; URL=auth.jsp" />
    <%
        return ; 
    }
    if(request.getParameter("bill_id")==null){
        System.out.println("Not bill_id ");
        return;
    }   
    FineSQL fsql = new FineSQL();
    JsonObject  fineData =  fsql.getOneFine(request.getParameter("bill_id"));
    String driverName = "";
    if(fineData.get("driverId").getAsInt()>0) {
        driverName = fineData.get("driver_lastname").getAsString()+" "+fineData.get("driver_firstname").getAsString();
    }
    else
        driverName = "Неизвестно";
%>
<div>
    <label>Номер постановления </label>
    <span><%= fineData.get("bill_id").getAsString() %></span>
</div>
<div>
    <label>Статус</label>
    <span><%= fineData.get("gis_status").getAsString() %></span>
</div>
<div>
    <label>Дата нарушения</label>
    <span><%= fineData.get("pay_bill_date").getAsString() %></span>
</div>
<div>
    <label>Срок оплаты</label>
    <span><%= fineData.get("last_bill_date").getAsString() %></span>
</div>
    <label>Сумма</label>
    <span><%= fineData.get("pay_bill_amount").getAsString() %></span>
</div>
<div>
    <label>Скидка</label>
    <span><%= fineData.get("gis_discount").getAsString() %></span>
</div>
<div>
    <label>Сумма со скидкой </label>
    <span><%= fineData.get("pay_bill_amount_with_discount").getAsString() %></span>
</div>
<div>
    <label>Место нарушения</label>
    <span><%= fineData.get("offense_location").getAsString() %></span>
</div>
<div>
    <label>Статья</label>
    <span><%= fineData.get("offense_article").getAsString() %></span>
</div>
<div>
    <label>Дата нарушения</label>
    <span><%= fineData.get("offense_date").getAsString() %></span>
</div>
<div>
    <label>Время нарушения</label>
    <span><%= fineData.get("offense_time").getAsString() %></span>
</div>
<div>
    <label>Номер ТС </label>
    <span><%= fineData.get("carNumber").getAsString() %></span>
</div>
<div>
    <label>Водитель</label>
    <span><%= driverName %></span>
    <span id="setGuilty"> <img src="img/writing.png"</span>
</div>
<% 
    int userId = ac.getUserId(request.getSession().getId());
    System.out.println(userId);
    if(ac.checkPermission(userId, "fineOwnerChange")){
        DriverSQL dsql = new DriverSQL();
        String driverList=dsql.listDriverForSelect();
        %>
    
    <div id="guiltyList" style="display: none">
        <input id="bill_id" type="text" disabled value="<%= fineData.get("bill_id").getAsString() %>" style="display: none"/>
        <select id="guilty">
            <%= driverList %>
        </select>
        <input id="saveGuilty" type="button" value="Сохранить"/>
    </div>
<%
    }
%>
<script>
    $("#setGuilty").click(function(){
        $("#guiltyList").css('display', 'block');
    });
    $("#saveGuilty").click(function(){
        editFineSend($("#bill_id").val(), $("#guilty").val())
    });
</script>