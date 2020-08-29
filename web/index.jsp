<%-- 
    Document   : index
    Created on : 19.12.2017, 15:31:57
    Author     : korgan
--%>

<%@page import="ru.leasicar.workerSql.PaySQL"%>
<%@page import="ru.leasicar.workerSql.DriverSQL"%>
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
    DriverSQL dsql = new DriverSQL();
    PaySQL psql = new PaySQL();
    String carlist = "";
    DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
    String dateDiscountOut = format.format(new Date().getTime()+60*60*24*20*1000);
    String datePayOut = format.format(new Date().getTime()+60*60*24*60*1000);
    Logger.getLogger(ListDriver.class.getName()).log(Level.SEVERE, "erwerwer", "sdfsdf");
%>
<html lang="us">
<head>
    
    
    
    
    
    <link rel="stylesheet" id="font-awesome-css" href="http://td-pobedit.ru/wp-content/plugins/js_composer/assets/lib/bower/font-awesome/css/font-awesome.min.css?ver=5.0.1" type="text/css" media="all">

<link rel="stylesheet" id="font-awesome-official-css" href="https://use.fontawesome.com/releases/v5.12.0/css/all.css" type="text/css" media="all" integrity="sha384-REHJTs1r2ErKBuJB0fCK99gCYsVjwxHrSU0N7I1zl9vZbggVJXRMsv/sLlOAGb4M" crossorigin="anonymous">

<link rel="stylesheet" id="shiftnav-font-awesome-css" href="http://td-pobedit.ru/wp-content/plugins/shiftnav-responsive-mobile-menu/assets/css/fontawesome/css/font-awesome.min.css?ver=1.6.3" type="text/css" media="all">

<link rel="stylesheet" id="font-awesome-official-v4shim-css" href="https://use.fontawesome.com/releases/v5.12.0/css/v4-shims.css" type="text/css" media="all" integrity="sha384-AL44/7DEVqkvY9j8IjGLGZgFmHAjuHa+2RIWKxDliMNIfSs9g14/BRpYwHrWQgz6" crossorigin="anonymous">

<style id="font-awesome-official-v4shim-inline-css" type="text/css">
@font-face {
    font-family: "FontAwesome";
    src: url("https://use.fontawesome.com/releases/v5.12.0/webfonts/fa-brands-400.eot"),
         url("https://use.fontawesome.com/releases/v5.12.0/webfonts/fa-brands-400.eot?#iefix") format("embedded-opentype"),
         url("https://use.fontawesome.com/releases/v5.12.0/webfonts/fa-brands-400.woff2") format("woff2"),
         url("https://use.fontawesome.com/releases/v5.12.0/webfonts/fa-brands-400.woff") format("woff"),
         url("https://use.fontawesome.com/releases/v5.12.0/webfonts/fa-brands-400.ttf") format("truetype"),
         url("https://use.fontawesome.com/releases/v5.12.0/webfonts/fa-brands-400.svg#fontawesome") format("svg");
}

@font-face {
    font-family: "FontAwesome";
    src: url("https://use.fontawesome.com/releases/v5.12.0/webfonts/fa-solid-900.eot"),
         url("https://use.fontawesome.com/releases/v5.12.0/webfonts/fa-solid-900.eot?#iefix") format("embedded-opentype"),
         url("https://use.fontawesome.com/releases/v5.12.0/webfonts/fa-solid-900.woff2") format("woff2"),
         url("https://use.fontawesome.com/releases/v5.12.0/webfonts/fa-solid-900.woff") format("woff"),
         url("https://use.fontawesome.com/releases/v5.12.0/webfonts/fa-solid-900.ttf") format("truetype"),
         url("https://use.fontawesome.com/releases/v5.12.0/webfonts/fa-solid-900.svg#fontawesome") format("svg");
}

@font-face {
    font-family: "FontAwesome";
    src: url("https://use.fontawesome.com/releases/v5.12.0/webfonts/fa-regular-400.eot"),
         url("https://use.fontawesome.com/releases/v5.12.0/webfonts/fa-regular-400.eot?#iefix") format("embedded-opentype"),
         url("https://use.fontawesome.com/releases/v5.12.0/webfonts/fa-regular-400.woff2") format("woff2"),
         url("https://use.fontawesome.com/releases/v5.12.0/webfonts/fa-regular-400.woff") format("woff"),
         url("https://use.fontawesome.com/releases/v5.12.0/webfonts/fa-regular-400.ttf") format("truetype"),
         url("https://use.fontawesome.com/releases/v5.12.0/webfonts/fa-regular-400.svg#fontawesome") format("svg");
    unicode-range: U+F004-F005,U+F007,U+F017,U+F022,U+F024,U+F02E,U+F03E,U+F044,U+F057-F059,U+F06E,U+F070,U+F075,U+F07B-F07C,U+F080,U+F086,U+F089,U+F094,U+F09D,U+F0A0,U+F0A4-F0A7,U+F0C5,U+F0C7-F0C8,U+F0E0,U+F0EB,U+F0F3,U+F0F8,U+F0FE,U+F111,U+F118-F11A,U+F11C,U+F133,U+F144,U+F146,U+F14A,U+F14D-F14E,U+F150-F152,U+F15B-F15C,U+F164-F165,U+F185-F186,U+F191-F192,U+F1AD,U+F1C1-F1C9,U+F1CD,U+F1D8,U+F1E3,U+F1EA,U+F1F6,U+F1F9,U+F20A,U+F247-F249,U+F24D,U+F254-F25B,U+F25D,U+F267,U+F271-F274,U+F279,U+F28B,U+F28D,U+F2B5-F2B6,U+F2B9,U+F2BB,U+F2BD,U+F2C1-F2C2,U+F2D0,U+F2D2,U+F2DC,U+F2ED,U+F328,U+F358-F35B,U+F3A5,U+F3D1,U+F410,U+F4AD;
}
</style>    
	<meta charset="utf-8">
        <!-- index.jsp -->
        
        <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<title>RTS</title>
        <meta http-equiv='Cache-Control' content='no-cache'>
        <meta http-equiv='Cache-Control' content='private'>
        <script src='https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>
        <script src='https://code.jquery.com/jquery-1.12.4.js'></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        <script type='text/javascript' src='https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js'></script>
        <link rel='stylesheet' type='text/css' href='https://cdn.datatables.net/v/dt/dt-1.10.16/datatables.min.css'/>
        <!--link rel='stylesheet' type='text/css'  href='css/datatabel.css'/-->
        <link rel='stylesheet' type='text/css'  href='css/interface-styles.css'/>    
        <link rel='stylesheet' type='text/css'  href='css/main.css'/>
        <link rel="stylesheet" type="text/css" href="css/view.css" media="all">
        <script type="text/javascript" src="js/view.js"></script>
    </head>
<body>
    <div class='place' >
        
        <div id="header">
        <div id="logo">RTS-SOFT</div>
        
	<div id="Top_1" class="topPanelItem topActive">
		<% if(ac.checkPermission(ac.getUserId(request.getSession().getId()), "showBalance")){ %>
                <div id="Top_1_LeftPart">
                <span>Суммарный баланс:</span>
                <span class="Top_Margin_Right Top_Value" id="Top_1_SummBalanceValue"><%= dsql.getCurentGlobalBalance() %></span>
                <span >Поступления:</span>
                <span class="Top_Value" id="Top_1_Incomes"><%= psql.getPayToday() %></span>
                </div>
                <%}%>
                <div id="Top_1_RightPart" class="topPanelItem topActive">
                <span>Работают:</span>
                <span class="Top_Value" id="Top_1_Working"><%= dsql.getDriverCount() %></span>
                <i class="Top_Margin_Right Top_Value fas fa-caret-down"></i>
                
                <span>Принято:</span>
                <span class="Top_Value" id="Top_1_AcceptedHR"><%= dsql.addToday() %></span>
                <i class="Top_Margin_Right Top_Value fas fa-caret-down"></i>
                    
                <span>Уволено:</span>
                <span class="Top_Value" id="Top_1_Uvoleno"><%= dsql.fireToday() %></span>
                <i class="Top_Value fas fa-caret-down"></i>
                </div>
                
            </div>
            
             <div id="Top_2" class="topPanelItem">
                
                <div id="Top_2_Right">
                <span>Новый:</span>
                <span class="Top_Margin_Right Top_Value" id="Top_2_NewHR">1</span>

                <span>На рассмотрении:</span>
                <span class="Top_Margin_Right Top_Value" id="Top_2_OnView">1</span>

                
                <span>Ожидает Т/С:</span>
                <span class="Top_Margin_Right_Large Top_Value" id="Top_2_WaitForTS">1</span>
                
                    
                <span>Отказано:</span>
                <span class="Top_Value" id="Top_2_Rejected">1235</span>
                
                </div>
                
            </div>
            
            <div id="Top_3" class="topPanelItem">
                
                <div id="Top_3_Right">
                <span>Готова к выдачи:</span>
                <span class="Top_Margin_Right Top_Value" id="Top_3_Ready">1</span>

                <span>На линии:</span>
                <span class="Top_Margin_Right Top_Value" id="Top_3_Online">1</span>

                
                <span>Ремонт:</span>
                <span class="Top_Margin_Right Top_Value" id="Top_3_Fixing">1</span>
                
                <span>ДТП:</span>
                <span class="Top_Margin_Right Top_Value" id="Top_3_DTP">1</span>
                
                    
                <span>Заблокировано:</span>
                <span class="Top_Value" id="Top_3_Blocked">1235</span>
                
                </div>
                
            </div>
                
            </div>
            
            <div id="alarmer-holder">Уведомления</div><div id="alarmer"><div id="alarmCount"></div></div></div>
        
        <div id="leftMenu">
            <ul id="menu">
                <li>
                  <div ><i class="left-menu-icon fas fa-users"></i> Персонал</div>
                  <ul>
                      <li>
                      <div id='driverListButton'>Все</div>
                    </li>
                      <li>
                      <div id='driverListHR'>Соискатель</div>
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
                  <div id='carListButton'><i class="left-menu-icon fas fa-car"></i> Автопарк</div>
                <!--ul>
                    <li>
                      <div id="carListButtonAll">Все</div>
                    </li>
                    


                  </ul-->
                </li>
                
                <li>
                  <div id='WayBillReport'><i class="left-menu-icon fas fa-book"></i> Журналы</div>
                  <ul>
            <li>
			<div id="wayBillsReport" class="docsWaiMedikaPredreysoviy">Медицинский предрейсовый</div>
            </li>
            
            <li>
			<div id="wayBillsReport" class="docsWaiMedikaPoslereysoviy">Медицинский послерейсовый</div>
            </li>
                      
                      <li>
			<div id="wayBillsReport" class="docsWaiTechControl">Технического контроля</div>
            </li>
            
                      <li>
			<div id="wayBillsReport" class="docsWaiBillReport">Учета путевых листов</div>
            </li>
                 
            <li>
			<div id="wayBillsReport" class="docsWaiPredreysInstructaj">Предрейсовых инструктажей</div>
            </li>
                      
                      <li>
			<div id="wayBillsReport" class="docsWaiSeassonInstructaj">Сезонных инструктажей</div>
            </li>
                      <li>
			<div id="wayBillsReport" class="docsWaiSpecialInstruction">Специальных инструктажей</div>
            </li>
<li>
			<div id="wayBillsReport" class="docsWaiBillEnterInstruction">Вводных инструктажей</div>
            </li>     
                      
                  </ul>
                </li>
                
                <li>
                  <div id="fineList"><i class="left-menu-icon fas fa-gavel"></i> Штрафы</div>
                </li>
                
                <li>
                  <div id="fineYurHelp"><i class="left-menu-icon fas fa-shield-alt"></i> Юр. помощь</div>
                </li>
                
                <!--li>
                  <div id='mainProp'>Настройки</div>
                </li-->
                
                <li>
                  <div id='Reports'><i class="left-menu-icon fas fa-chart-pie"></i> Отчеты</div>
                  <ul>
                    <li>
                      <div id="allPayReport"><a href="reports/allPayReport.jsp" target="_blank">Платежи</a></div>
                    </li>
                  </ul>
                </li>
                <li>
                  <div><i class="left-menu-icon far fa-file-alt"></i> Реестры</div>
		  <ul>
                    <li>
			<div id="registryDocs">Договоров</div>
                    </li>
                    <li>
			<div id="registryClaim">Претензий</div>
                    </li>
                    <li>
			<div id="registryIskClaim">Исковых заявлений</div>
                    </li>
                  </ul>
                </li>
                
                <li>
                  <div><i class="left-menu-icon fas fa-cog"></i> Настройки</div>
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
                  <div id="LogOut"><i class="left-menu-icon fas fa-sign-out-alt"></i> Выйти</div>
                </li>
              </ul>
        </div>
        <div id='mainContainer'>
            <div id='listDriverBox' class='itemDisplay'>
                <div id="action-panel">
                    <a  class="add-rows-a-btn" id="add-rows" onclick="showAddDriverForm()">
                        
                        <div class="add-rows-div-btn hover-plus">
                            
                            <i style="color:black;" class="fas fa-plus"></i></div></a>
                    
                    <div class="control-btns-div">
                        
                        <span> Выбрано:</span> <span id="selected-rows">1</span>
                    
                    <a class="first-and-second-a-btn" id="download" >
                        
                        <i class="after-add-i-btn hover-plus fas fa-download"></i> 
                        
                        <span  class="after-add-span-btn">Скачать</span>
                        
                        </a>
                    
                        
                    <a class="first-and-second-a-btn"  id="do-print" >
                        
                        <i class="after-add-i-btn hover-plus fas fa-print"></i> <span  class="after-add-span-btn">Печать</span></a>
                    
                        <a class="third-a-btn" id="sms" >
                            
                            <i class="after-add-i-btn hover-plus  fas fa-sms"></i> <span class="after-add-span-btn">Сообщение</span></a>
                    </div>
                </div>
                
                <!-- <input type='button' value='Добавить водителя' onclick='showAddDriverForm()'/> --> 
		<div id="filterProp"><div id="openDriverFilter" ><i class="fas fa-filter"></i></div></div>
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
                            <th>Г/Н</th>
                            <th>Дата</th>
                            <th>Постановление</th>
                            <th>Адрес нарушения</th>
                            <th>Статья</th>
                            <th>Водитель</th>
                            <th>Сумма</th>
                            <th>Скидка</th>
                            <th>Скидка до</th>
                            <th>Оплатить до</th>
                        </tr>
                    </thead>
                </table>
            </div>
        </div>
    <div id="corrector"></div>
        <div id='editDriver'></div>
  
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