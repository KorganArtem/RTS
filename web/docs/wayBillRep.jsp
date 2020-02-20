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
    CarSQL csql = new CarSQL();
    CompanySQL compSQL = new CompanySQL();
    SimpleDateFormat sdt = new SimpleDateFormat("yyyy-MM-dd");
    String startDate =sdt.format(new Date().getTime());
    String endDate =sdt.format(new Date().getTime()+(60*60*24*7*1000));
%>
<div id="wayBillPrintForm">
    <form id="prinWayBill" class="appnitro" target="_blank">
        <ul>
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
                    <%= compSQL.getCompanyListSelect(1) %>
                </select>
            </li>
	    <li>
                <select id="typeRep" name="typeRep" style="width: 260px;">
                    <option value="wayBillReport.jsp">Регестрации путвых листов</option>
                    <option value="medicalReport.jsp">Предрейсовый мед. осмотр</option>
                    <option value="medicalReportAfter.jsp">Послерейсовый мед. осмотр</option>
                    <option value="safetyBrifing.jsp">Инструктажа БДД</option>
                    <option value="carCheck.jsp">Механика</option>
                </select>
            </li>
            <li>
                <input type="button" value="Распечатать" onclick="getFormWayBill()" style="width: 260px;" />
            </li>
        </ul>
    </form>
</div>
                <!-- onclick="getFormWayBill()" -->
<script>
    function getFormWayBill(){
        //var msg   = $('#prinWayBill').serialize();
	var comp = 'docs/'+$('#typeRep').val()+'?dateStart='+$('#element_1_1').val()+'&dateEnd='+$('#element_1_2').val()+'&companyId='+$('#companyName').val();
	//'safetyBrifing.jsp?dateStart=2019-08-15&dateEnd=2019-09-25=1';
        console.log(comp);
	window.open(comp);
    }
</script>