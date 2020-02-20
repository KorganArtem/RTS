<%-- 
    Document   : index
    Created on : 19.12.2017, 15:31:57
    Author     : korgan
--%>

<%@page import="java.util.logging.Logger"%>
<%@page import="ru.leasicar.main.ListDriver"%>
<%@page import="java.util.logging.Level"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="ru.leasicar.workerSql.CarSQL"%>
<%@ page language="java" contentType="text/html; charset=utf-8"%>
<!DOCTYPE html>
<%@ page import="ru.leasicar.authorization.*" %>
<% 
    AccessControl ac = new AccessControl();
    if(!ac.isLogIn(request.getSession().getId())){%>
        <meta http-equiv="refresh" content="1; URL=auth.jsp" />
        <%
        return ; 
    }
    String carlist = "";
    DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
    String dateDiscountOut = format.format(new Date().getTime()+60*60*24*20*1000);
    String datePayOut = format.format(new Date().getTime()+60*60*24*60*1000);
    Logger.getLogger(ListDriver.class.getName()).log(Level.SEVERE, "erwerwer", "sdfsdf");
%>
<html lang="us">
<head>
	<meta charset="utf-8">
        <!-- index.jsp -->
        
        <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<title>Lease Car</title>
        <meta http-equiv='Cache-Control' content='no-cache'>
        <meta http-equiv='Cache-Control' content='private'>
        <script src='https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>
        <script src='https://code.jquery.com/jquery-1.12.4.js'></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        <script type='text/javascript' src='https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js'></script>
        <link rel='stylesheet' type='text/css' href='https://cdn.datatables.net/v/dt/dt-1.10.16/datatables.min.css'/>
        <!--link rel='stylesheet' type='text/css'  href='css/datatabel.css'/-->
        <link rel='stylesheet' type='text/css'  href='css/main.css'/>
        <link rel="stylesheet" type="text/css" href="css/view.css" media="all">
        <script type="text/javascript" src="js/view.js"></script>
    </head>
<body>
    <div class='place' >
        <div id="leftMenu">
            <ul id="menu">
                <li>
                  <div >Водители</div>
                  <ul>
                    <li>
                      <div id='driverListButton'>Работающие</div>
                    </li>
                    <li>
                      <div id="driversListDeleted">Уволенные</div>   
                    </li>
                    <li>
                      <a href='sryadrvr.jsp'>Водители Яндекс</a>
                    </li>
                  </ul>
                </li>
                <li>
                  <div id='carListButton'>Автомобили</div>
                </li>
                <!--li>
                  <div id='mainProp'>Настройки</div>
                </li-->
                
                <li>
                  <div id='Reports'>отчеты</div>
                  <ul>
                    <li>
                      <div id="allPayReport"><a href="reports/allPayReport.jsp" target="_blank">Платежи</a></div>
                    </li>
                  </ul>
                </li>
                <li>
                  <div id='WayBillReport'>Журналы</div>
                  <ul>
                    <li>
			<div id="wayBillsReport" class="docsWaiBillReport">Путевых листов</div>
                    </li>
                  </ul>
                </li>
                <li>
                  <div id="fineList">Штрафы</div>
                </li>
                <li>
                  <div>Настройки</div>
		  <ul>
                    <li>
			<div id="companyList">Компании</div>
                    </li>
                    <li>
			<div id="userList">Пользователи</div>
                    </li>
                    <li>
			<div id="passChange">Сменить Пароль</div>
                    </li>
                  </ul>
                </li>
		<li>
                  <div id="logOut">Выйти</div>
                </li>
              </ul>
        </div>
        <div id='mainContainer'>
            <div id='listDriverBox' class='itemDisplay'>
                <input type='button' value='Добавить водителя' onclick='showAddDriverForm()'/>
		<div id="filterProp"><div id="openDriverFilter" >Фильтр</div></div>
		<div id="driverListFilter">
		    <form name='driverFilterForm' id='driverFilterForm'>
			<input type='checkbox' hidden="true" name='filtered' checked/>
			<div class="filterItem">
			    <input type="checkbox" id="addDate" name="addDate"/><label>Дата принятия</label>
			    <div>
				<label>C</label><input type="date" id="addDateS" name="addDateS"/>
			    </div>
			    <div>
				<label>По</label><input type="date" id="addDateE" name="addDateE"/>
			    </div>

			</div>
			<div class="filterItem">
			    <input type="checkbox" id="showDeleted" name="deleted"/><label>Уволенные </label>
			    <div>
			       <label>C</label><input type="date" id="delDateS" name="delDateS"/>
			    </div>
			    <div>
				<label>По</label><input type="date" id="delDateE" name="delDateE"/>
			    </div>

			</div>
			<input type='button' name='search' id='searchButton' value="Найти"/>
		    </form>
		</div>
                <div id='listDriver'>
                </div>
            </div>
            <div id='carList' class='itemDisplay'></div>
            <div id='prop' class='itemDisplay'></div>
            <div id='workPlace' class='itemDisplay'></div>
            <div id='fineListBlock' class='itemDisplay' style="display: none">
		<div>
		    <input type="checkbox" id="showDeletecarsfine"/><label>Показать удаленные машины</label>
		    <input type="date" value="<%= dateDiscountOut %>" id="discountOut"/><label>Скидка до</label>
		    <input type="date" value="<%= datePayOut %>" id="payOut"/><label>Оплатить до</label>
		    <input type="button" value="Показать" id="fineFilter"/>
		    <input type="button" value="Выгрузить" id="exportFine"/>
		</div>
                <table id="tableFine">
                    <thead>
                        <tr>
                            <th>Номер машины</th>
                            <th>Дата</th>
                            <th>Номер постановления</th>
                            <th>Адрес нарушения</th>
                            <th>Статья</th>
                            <th>Нарушитель</th>
                            <th>Статья</th>
                            <th>Скидка</th>
                            <th>Скидка до</th>
                            <th>Оплатить до</th>
                        </tr>
                    </thead>
                </table>
            </div>
        </div>
        <div id="alarmer"><img src="img/alarm.png" width="50"/><div id="alarmCount"></div></div>
        <div id='editDriver'></div>
    </div>
    <div id='modal_form'>
        <div class="closeModButt" onClick="closeModWind()">x</div>
        <div id="modalConteiner">
        </div>
    </div>
    <div id='overlay'>   
    </div>
    <div id="menuBox" title="Документы">
	<ul id="docMenu">
		<li class="menuItem" id="getDog" data="dogovor">Договор</li>
		<li class="menuItem" data="aktvidachi">Акт выдачи</li>
		<li class="menuItem" data="aktpriema">Акт приемки</li>
		<li class="menuItem" data="putevoilist">Путевые листы</li>
	</ul>
    </div>
</body>
<script>
    $( "#menuBox" ).dialog({
        position: { my: "left top", at: "right top"},
        autoOpen: false,
        width: 200,
        show: {
            effect: "blind",
            duration: 1
        },
        hide: {
            effect: "explode",
            duration: 1
        }
    });
    $( "#menu" ).menu();
</script>
    <script src='js/main.js'></script>
    <script src='js/company.js'></script>
    <script src='js/menuproc.js'></script>
    <script src='js/users.js'></script>
    <script src='js/driver.js'></script>
</html>