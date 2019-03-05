<%-- 
    Document   : wayBill
    Created on : Oct 15, 2018, 10:10:29 PM
    Author     : Artem
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="ru.leasicar.workerSql.CompanySQL"%>
<%@page import="java.util.Map"%>
<%@page import="ru.leasicar.workerSql.CarSQL"%>
<%@page import="ru.leasicar.workerSql.DriverSQL"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    int driverId = 0;
    try{
        driverId=Integer.parseInt(request.getParameter("driverId"));
    }
    catch(Exception ex){
        System.out.println(ex.getMessage());
        return;
    }
    DriverSQL dsql = new DriverSQL();
    Map<String, String> driverData = dsql.getAllDataDriver(driverId);
    CarSQL csql = new CarSQL();
    Map<String, String> carData = csql.getCarData(Integer.parseInt(driverData.get("carId")));
    CompanySQL compSQL = new CompanySQL();
    SimpleDateFormat sdt = new SimpleDateFormat("yyyy-MM-dd");
    String startDate =sdt.format(new Date().getTime());
    String endDate =sdt.format(new Date().getTime()+(60*60*24*7*1000));
%>
<div id="wayBillPrintForm">
    <form id="prinWayBill" class="appnitro"  action="docs/wayBillPrint.jsp" method="post" target="_blank">
        <ul>
            <li>
                <span>
                    <input type="text" name="driverId" hidden="true" value="<%= driverId %>"/>
                    <input type="text" name= "driverName" class="element date" disabled="true" maxlength="255" size="14" value="<%= driverData.get("driver_lastname") %>"/>
                    <label>Водитель</label>
                </span>
                <span>
                    <input type="text" name="carId" hidden="true" value="<%= driverData.get("carId")%>"/>
                    <input type="text" name= "carNumber" class="element date" disabled="true" maxlength="255" size="14" value="<%= carData.get("number") %>"/>
                    <label>АМ</label>
                </span> 
            </li>
            <li id="li_1" >
                <span>
                    <input type="date" id="element_1_1" name= "startDate" class="element date" maxlength="255" size="14" value="<%= startDate %>"/>
                    <label>Дата начала</label>
                </span>
                <span>
                    <input type="date" id="element_1_2" name= "endDate" class="element date" maxlength="255" size="14" value="<%= endDate %>"/>
                    <label>Дата окончания</label>
                </span> 
            </li>
            <li>
                <select id="companyName" name="companyId" style="width: 260px;">
                    <%= compSQL.getCompanyListSelect(Integer.parseInt(carData.get("carOwner"))) %>
                </select>
            </li>
            <li>
                <input type="submit" value="Распечатать" style="width: 260px;" />
            </li>
        </ul>
    </form>
</div>
                <!-- onclick="getFormWayBill()" -->
<script>
    function getFormWayBill(){
        var msg   = $('#prinWayBill').serialize();
        downloadWayBill(msg);
    }
</script>