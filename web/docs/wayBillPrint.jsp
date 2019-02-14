<%-- 
    Document   : wayBillPrint
    Created on : 19.10.2018, 17:09:57
    Author     : korgan
--%>

<%@page import="ru.leasicar.healthCheck.HealthDataGenerator"%>
<%@page import="ru.leasicar.workerSql.WayBillSQL"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Map"%>
<%@page import="ru.leasicar.workerSql.CompanySQL"%>
<%@page import="ru.leasicar.workerSql.CarSQL"%>
<%@page import="ru.leasicar.workerSql.DriverSQL"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
        <script src='https://code.jquery.com/jquery-1.12.4.js'></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<META HTTP-EQUIV="CONTENT-TYPE" CONTENT="text/html; charset=utf-8">
	<TITLE></TITLE>
	<STYLE TYPE="text/css">
            @media print {
                @page { margin: 0; }
                div { margin: 1.6cm; }
              }
	<!--
		/*@page {margin-right: 0.59in; margin-top: 0.37in; margin-bottom: 0.5in }*/
		P { margin-top: 0.08in; direction: ltr; color: #000000; widows: 2; orphans: 2 }
		P.western { font-family: "Times New Roman", serif; font-size: 14pt; so-language: ru-RU }
		P.cjk { font-family: "Times New Roman", serif; font-size: 14pt }
		P.ctl { font-family: "Times New Roman", serif; font-size: 10pt; so-language: ar-SA }
                
	-->
	</STYLE>
</HEAD>
<BODY LANG="en-US" TEXT="#000000" DIR="LTR">
    <%
        
    Map<String, String> driverData;
    Map<String, String> carData ;
    Map<String, String> compData;
    int cmpanyId = Integer.parseInt(request.getParameter("companyId"));
    int driverId = Integer.parseInt(request.getParameter("driverId"));
    int carId = Integer.parseInt(request.getParameter("carId"));
    DriverSQL dsql = new DriverSQL();
    driverData = dsql.getAllDataDriver(driverId);
    CarSQL csql = new CarSQL();
    carData = csql.getCarDataForAct(carId);
    CompanySQL compSQL = new CompanySQL();
    compData = compSQL.getCompanyData(cmpanyId);
    String fullName = driverData.get("driver_lastname")+" "+driverData.get("driver_firstname")+" "+driverData.get("driver_midName");
    DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
    Date startDate = format.parse(request.getParameter("startDate"));
    Date endDate = format.parse(request.getParameter("endDate"));
    String driverLicNum = driverData.get("vyNumber");
    /*String[] comment = driverData.get("comment").split("/");
    if(comment.length>1){
        driverLicNum = comment[0];
    }
    else
        driverLicNum=driverData.get("comment");*/
    WayBillSQL wbsql = new WayBillSQL();
    int years = Integer.parseInt(driverData.get("driver_age"));
    for(long i=startDate.getTime(); i<=endDate.getTime(); i=i+(60*60*24*1000)){
        Date date = new Date(i);
        System.out.println(years);
        //String docNum = date.getTime()/1000+"";
        //docNum = docNum.substring(2, 10);
        DateFormat formatOut = new SimpleDateFormat("dd.MM.yyyy");
        DateFormat formatDocNum = new SimpleDateFormat("yyMMdd");
        String docNum = carId+1000+"";
        docNum = formatDocNum.format(date)+docNum.substring(1);
        String date1 = formatOut.format(date.getTime());
        String date2 = formatOut.format(date.getTime()+(60*60*24*1000));
        HealthDataGenerator hdg = new HealthDataGenerator();
        double bodyTemp = hdg.getBodyTem();
        System.out.println(bodyTemp);
        String bloodPressure = hdg.getBloodPressure(years);
        int pulse = hdg.getPulse(years);
        int wayBillId = wbsql.writeWayBill(driverId, carId, cmpanyId, date, docNum, bodyTemp, bloodPressure, pulse);
    %>
    
    
    <div STYLE="page-break-before: always">
    <TABLE WIDTH=694 CELLPADDING=2 CELLSPACING=0 STYLE="page-break-before: always">
	<TR>
		<TD ROWSPAN=2 COLSPAN=3 WIDTH=109 HEIGHT=20 STYLE="border: none; padding: 0in">
			<P  ALIGN=CENTER><FONT FACE="Arial, sans-serif"><FONT SIZE=1 STYLE="font-size: 6pt">Место
			для штампа<BR>организации</FONT></FONT></P>
		</TD>
		<TD COLSPAN=17 WIDTH=282 VALIGN=BOTTOM STYLE="border: none; padding: 0in">
			<P  ALIGN=CENTER><FONT FACE="Arial, sans-serif"><FONT SIZE=1 STYLE="font-size: 8pt"><FONT SIZE=2 STYLE="font-size: 9pt"><B>ПУТЕВОЙ
			ЛИСТ № ТМ </B></FONT><FONT SIZE=2 STYLE="font-size: 9pt"><SPAN LANG="en-US"><B><%= docNum+wayBillId %></B></SPAN></FONT></FONT></FONT></P>
		</TD>
		<TD ROWSPAN=2 COLSPAN=15 WIDTH=291 VALIGN=TOP STYLE="border: none; padding: 0in">
			<P  ALIGN=RIGHT><FONT FACE="Arial, sans-serif"><FONT SIZE=1 STYLE="font-size: 6pt"><I>Типовая
			форма № 4<BR>Утверждена постановлением
			Госкомстата России<BR>от 28.11.97 № с78</I></FONT></FONT></P>
		</TD>
	</TR>
	<TR>
		<TD COLSPAN=17 WIDTH=282 VALIGN=TOP STYLE="border: none; padding: 0in">
			<P  ALIGN=CENTER><FONT FACE="Arial, sans-serif"><FONT SIZE=2 STYLE="font-size: 9pt"><B>легкового такси</B></FONT></FONT></P>
		</TD>
	</TR>
	<TR VALIGN=TOP>
		<TD COLSPAN=3 WIDTH=109 HEIGHT=12 STYLE="border: none; padding: 0in">
			<P ><BR>
			</P>
		</TD>
		<TD COLSPAN=17 WIDTH=282 STYLE="border: none; padding: 0in">
			<P  ALIGN=CENTER><FONT FACE="Arial, sans-serif">
				<FONT SIZE=1 STYLE="font-size: 8pt"> с <%= date1 %> по <%= date2 %> </FONT></FONT></P>
		</TD>
		<TD COLSPAN=9 WIDTH=141 STYLE="border: none; padding: 0in">
			<P >
			</P>
		</TD>
		<TD WIDTH=6 STYLE="border: none; padding: 0in">
			<P >
			</P>
		</TD>
		<TD COLSPAN=5 WIDTH=136 STYLE="border-top: 1px solid #000000; border-bottom: 2.25pt solid #000000; border-left: 1px solid #000000; border-right: 1px solid #000000; padding: 0in 0.02in">
			<P  ALIGN=CENTER><FONT FACE="Arial, sans-serif"><FONT SIZE=1>Коды</FONT></FONT></P>
		</TD>
	</TR>
	<TR>
		<TD COLSPAN=29 WIDTH=540 HEIGHT=15 VALIGN=TOP STYLE="border: none; padding: 0in">
			<P  ALIGN=RIGHT><FONT FACE="Arial, sans-serif"><FONT SIZE=1 STYLE="font-size: 8pt">Форма
			по ОКУД</FONT></FONT></P>
		</TD>
		<TD WIDTH=6 VALIGN=TOP STYLE="border: none; padding: 0in">
			<P ><BR>
			</P>
		</TD>
		<TD COLSPAN=5 WIDTH=136 STYLE="border-top: 2.25pt solid #000000; border-bottom: 1px solid #000000; border-left: 2.25pt solid #000000; border-right: 2.25pt solid #000000; padding: 0in 0.02in">
			<P  ALIGN=CENTER><FONT FACE="Arial, sans-serif"><FONT SIZE=1 STYLE="font-size: 8pt">0345003</FONT></FONT></P>
		</TD>
	</TR>
	<TR>
		<TD COLSPAN=3 WIDTH=109 HEIGHT=15 VALIGN=TOP STYLE="border: none; padding: 0in">
			<P ><FONT FACE="Arial, sans-serif"><FONT SIZE=1 STYLE="font-size: 8pt">Организация</FONT></FONT></P>
		</TD>
		<TD COLSPAN=21 WIDTH=346 VALIGN=TOP STYLE="border-top: none; border-bottom: 1px solid #000000; border-left: none; border-right: none; padding: 0in">
                    <P  ALIGN=CENTER STYLE="margin-bottom: 0in; widows: 0; orphans: 0"><FONT SIZE=3><B><%= compData.get("name") %></B></FONT></P>
		</TD>
		<TD COLSPAN=5 WIDTH=77 VALIGN=TOP STYLE="border: none; padding: 0in">
			<P  ALIGN=RIGHT><FONT FACE="Arial, sans-serif"><FONT SIZE=1 STYLE="font-size: 8pt">по ОКПО</FONT></FONT></P>
		</TD>
		<TD WIDTH=6 VALIGN=TOP STYLE="border: none; padding: 0in">
			<P >
			</P>
		</TD>
		<TD COLSPAN=5 WIDTH=136 STYLE="border-top: 1px solid #000000; border-bottom: 1px solid #000000; border-left: 2.25pt solid #000000; border-right: 2.25pt solid #000000; padding: 0in 0.02in">
			<P  ALIGN=CENTER>
			</P>
		</TD>
	</TR>
	<TR>
		<TD COLSPAN=3 WIDTH=109 HEIGHT=15 VALIGN=TOP STYLE="border: none; padding: 0in">
		</TD>
		<TD COLSPAN=17 ALIGN=CENTER WIDTH=282 VALIGN=TOP STYLE="border: none; padding: 0in">
                    <FONT FACE="Arial, sans-serif"><FONT SIZE=1 STYLE="font-size: 6pt">наименование, адрес, номер телефона</FONT></FONT>
		</TD>
		<TD ALIGN=RIGHT COLSPAN=9 WIDTH=141 VALIGN=TOP STYLE="border: none; padding: 0in">
                    <FONT FACE="Arial, sans-serif"><FONT SIZE=1 STYLE="font-size: 8pt">Колонна (отряд)</FONT></FONT>
		</TD>
		<TD WIDTH=6 VALIGN=TOP STYLE="border: none; padding: 0in">
		</TD>
		<TD COLSPAN=5 WIDTH=136 STYLE="border-top: 1px solid #000000; border-bottom: 1px solid #000000; border-left: 2.25pt solid #000000; border-right: 2.25pt solid #000000; padding: 0in 0.02in">
		</TD>
	</TR>
	<TR>
		<TD COLSPAN=29 WIDTH=540 HEIGHT=15 VALIGN=TOP STYLE="border: none; padding: 0in">
			<P  ALIGN=RIGHT><FONT FACE="Arial, sans-serif"><FONT SIZE=1 STYLE="font-size: 8pt">Бригада</FONT></FONT></P>
		</TD>
		<TD WIDTH=6 VALIGN=TOP STYLE="border: none; padding: 0in">
			<P >
			</P>
		</TD>
		<TD COLSPAN=5 WIDTH=136 STYLE="border-top: 1px solid #000000; border-bottom: 1px solid #000000; border-left: 2.25pt solid #000000; border-right: 2.25pt solid #000000; padding: 0in 0.02in">
			<P  ALIGN=CENTER>
			</P>
		</TD>
	</TR>
	<TR>
		<TD COLSPAN=6 WIDTH=145 HEIGHT=15 VALIGN=TOP STYLE="border: none; padding: 0in">
			<P ><FONT FACE="Arial, sans-serif"><FONT SIZE=1 STYLE="font-size: 8pt">Марка автомобиля</FONT></FONT></P>
		</TD>
		<TD COLSPAN=23 WIDTH=391 VALIGN=TOP STYLE="border-top: none; border-bottom: 1px solid #000000; border-left: none; border-right: none; padding: 0in">
			<P ALIGN=CENTER><FONT FACE="Arial, sans-serif"><FONT SIZE=2>
                            <%= carData.get("modelName") %>
                        </FONT></FONT></P>
		</TD>
		<TD WIDTH=6 VALIGN=TOP STYLE="border: none; padding: 0in">
			<P >
			</P>
		</TD>
		<TD COLSPAN=5 WIDTH=136 STYLE="border-top: 1px solid #000000; border-bottom: 1px solid #000000; border-left: 2.25pt solid #000000; border-right: 2.25pt solid #000000; padding: 0in 0.02in">
			<P  ALIGN=CENTER>
			</P>
		</TD>
	</TR>
	<TR>
		<TD COLSPAN=12 WIDTH=259 HEIGHT=15 VALIGN=TOP STYLE="border: none; padding: 0in">
			<P ><FONT FACE="Arial, sans-serif"><FONT SIZE=1 STYLE="font-size: 8pt">Государственный номерной знак</FONT></FONT></P>
		</TD>
		<TD COLSPAN=5 WIDTH=55 VALIGN=TOP STYLE="border-top: none; border-bottom: 1px solid #000000; border-left: none; border-right: none; padding: 0in">
			<P><FONT FACE="Arial, sans-serif"><FONT SIZE=1 STYLE="font-size: 8pt">
                            <%= carData.get("number") %> <%= carData.get("regGosNumber") %>
                        </FONT></FONT></P>
		</TD>
		<TD COLSPAN=6 WIDTH=117 VALIGN=TOP STYLE="border: none; padding: 0in">
			<P ><FONT FACE="Arial, sans-serif"><FONT SIZE=1 STYLE="font-size: 8pt">Гаражный
			номер</FONT></FONT></P>
		</TD>
		<TD COLSPAN=6 WIDTH=97 VALIGN=TOP STYLE="border-top: none; border-bottom: 1px solid #000000; border-left: none; border-right: none; padding: 0in">
			<P ><FONT FACE="Arial, sans-serif"><FONT SIZE=1 STYLE="font-size: 8pt"><%= carData.get("id") %></FONT></FONT></P>
		</TD>
		<TD WIDTH=6 VALIGN=TOP STYLE="border: none; padding: 0in">
			<P >
			</P>
		</TD>
		<TD COLSPAN=5 WIDTH=136 STYLE="border-top: 1px solid #000000; border-bottom: 1px solid #000000; border-left: 2.25pt solid #000000; border-right: 2.25pt solid #000000; padding: 0in 0.02in">
			<P  ALIGN=CENTER>
			</P>
		</TD>
	</TR>
	<TR>
		<TD WIDTH=82 HEIGHT=15  STYLE="border: none; padding: 0in">
			<P ><FONT FACE="Arial, sans-serif"><FONT SIZE=1 STYLE="font-size: 8pt">Водитель</FONT></FONT></P>
		</TD>
		<TD COLSPAN=20 WIDTH=326  STYLE="border-top: none; border-bottom: 1px solid #000000; border-left: none; border-right: none; padding: 0in">
			<P ><FONT FACE="Arial, sans-serif"><FONT SIZE=1 STYLE="font-size: 8pt">
                            <%= fullName %>
                        </FONT></FONT></P>
		</TD>
		<TD COLSPAN=8 WIDTH=125   STYLE="border: none; padding: 0in">
			<P ><FONT FACE="Arial, sans-serif"><FONT SIZE=1 STYLE="font-size: 8pt">Табельный номер</FONT></FONT></P>
		</TD>
		<TD WIDTH=6 VALIGN=TOP STYLE="border: none; padding: 0in"> 
		
		</TD>
		<TD COLSPAN=5 WIDTH=136 STYLE="border-top: 1px solid #000000; border-bottom: 2.25pt solid #000000; border-left: 2.25pt solid #000000; border-right: 2.25pt solid #000000; padding: 0in 0.02in">
			 
		</TD>
	</TR>
	<TR VALIGN=TOP>
		<TD WIDTH=82 HEIGHT=12 STYLE="border: none; padding: 0in">
			 
		</TD>
		<TD ALIGN=CENTER COLSPAN=20 WIDTH=326 STYLE="border: none; padding: 0in">
                    <FONT FACE="Arial, sans-serif"><FONT SIZE=1 STYLE="font-size: 6pt">фамилия, имя, отчество</FONT></FONT>
		</TD>
		<TD COLSPAN=8 WIDTH=125 STYLE="border: none; padding: 0in">
		</TD>
		<TD WIDTH=6 STYLE="border: none; padding: 0in">
		</TD>
		<TD COLSPAN=5 WIDTH=136 STYLE="border-top: 2.25pt solid #000000; border-bottom: none; border-left: none; border-right: none; padding: 0in">
		
		</TD>
	</TR>
    </TABLE>
    <TABLE>
	<TR>
            <TD WIDTH=90 HEIGHT=21 STYLE="border: none; padding: 0in">
                <P ><FONT FACE="Arial, sans-serif"><FONT SIZE=1 STYLE="font-size: 8pt">Удостоверение № </FONT></FONT></P>
            </TD>
            <TD WIDTH=80 VALIGN=BOTTOM  ALIGN=CENTER STYLE="border-top: none; border-bottom: 1px solid #000000; border-left: none; border-right: none; padding: 0in">
                <FONT SIZE=1>
                    <%= driverLicNum %>
                </FONT>
            </TD>
            <TD WIDTH=20 STYLE="border: none; padding: 0in">
            </TD>
            <TD  WIDTH=35 STYLE="border: none; padding: 0in">
                <P ><FONT FACE="Arial, sans-serif"><FONT SIZE=1 STYLE="font-size: 8pt">Класс</FONT></FONT></P>
            </TD>
            <TD WIDTH=80 VALIGN=BOTTOM  ALIGN=CENTER STYLE="border-top: none; border-bottom: 1px solid #000000; border-left: none; border-right: none; padding: 0in">
                <FONT SIZE=1>
                </FONT>
            </TD>
            <TD WIDTH=20 STYLE="border: none; padding: 0in">
            </TD>
            <TD WIDTH=120 STYLE="border: none; padding: 0in">
                <P ><FONT FACE="Arial, sans-serif"><FONT SIZE=1 STYLE="font-size: 8pt">Лицензионная карточка</FONT></FONT></P>
            </TD>
            <TD WIDTH=172 VALIGN=BOTTOM STYLE="border-top: none; border-bottom: 1px solid #000000; border-left: none; border-right: none; padding: 0in">
		<P  ALIGN=CENTER>           <FONT FACE="Arial, sans-serif"><FONT SIZE=1>стандартная, ограниченная</FONT></FONT></P>
            </TD>
	</TR>
	<TR VALIGN=TOP>
		<TD STYLE="border-top: none;  border-left: none; border-right: none; padding: 0in">
		</TD>
		<TD STYLE="border-top: none;  border-left: none; border-right: none; padding: 0in">
		</TD>
		<TD STYLE="border: none; padding: 0in">
		</TD>
		<TD STYLE="border: none; padding: 0in">
		</TD>
		<TD STYLE="border: none; padding: 0in">
		</TD>
		<TD STYLE="border: none; padding: 0in">
		</TD>
		<TD STYLE="border: none; padding: 0in">
		</TD>
		<TD VALIGN=TOP STYLE="border: none; padding: 0in">
			<P  ALIGN=CENTER STYLE="    margin-top: 0in;"><FONT FACE="Arial, sans-serif"><FONT SIZE=1 STYLE="font-size: 6pt">ненужное
			зачеркнуть</FONT></FONT></P>
		</TD>
	</TR>
    </TABLE>
    <TABLE>
           <TR>
               <TD>
                   <TABLE WIDTH=298 cellspacing="0" STYLE="border: 2.25pt solid #000000;">
                        <TR STYLE="border-bottom: 1px solid #000000;">
                            <TD COLSPAN=4  HEIGHT=15 VALIGN=TOP STYLE="border-bottom: 1px solid #000000; border-right: none; padding-top: 0in; padding-bottom: 0in; padding-left: 0.02in; padding-right: 0in">
                                <P  ALIGN=CENTER><FONT FACE="Arial, sans-serif"><FONT SIZE=1 STYLE="font-size: 6pt">Время</FONT></FONT></P>
                            </TD>
                        </TR>
                        <TR STYLE="">
                            <TD COLSPAN=2 WIDTH=155 HEIGHT=15 STYLE="border-bottom: 1px solid #000000; border-right: none; padding-top: 0in; padding-bottom: 0in; padding-left: 0.02in; padding-right: 0in">
                                <P  ALIGN=CENTER><FONT FACE="Arial, sans-serif"><FONT SIZE=1 STYLE="font-size: 6pt">выезда
                                на линию</FONT></FONT></P>
                            </TD>
                            <TD COLSPAN=2 WIDTH=139 STYLE="border-bottom: 1px solid #000000; border-left: 1px solid #000000; border-right: none; padding-top: 0in; padding-bottom: 0in; padding-left: 0.02in; padding-right: 0in">
                            <P  ALIGN=CENTER><FONT FACE="Arial, sans-serif"><FONT SIZE=1 STYLE="font-size: 6pt">возвращения
                            в парк</FONT></FONT></P>
                            </TD>
                        </TR>
                        <TR>
                            <TD  WIDTH=82 HEIGHT=31 STYLE="border-bottom: 1px solid #000000; border-top: none; border-right: none; padding-top: 0in; padding-bottom: 0in; padding-left: 0.02in; padding-right: 0in">
                                    <P  ALIGN=CENTER><FONT FACE="Arial, sans-serif"><FONT SIZE=1 STYLE="font-size: 6pt">по
                                    графику</FONT></FONT></P>
                            </TD>
                            <TD  WIDTH=69 STYLE="border-bottom: 1px solid #000000; border-left: 1px solid #000000; border-right: none; padding-top: 0in; padding-bottom: 0in; padding-left: 0.02in; padding-right: 0in">
                                <P  ALIGN=CENTER><FONT FACE="Arial, sans-serif"><FONT SIZE=1 STYLE="font-size: 6pt">фактически</FONT></FONT></P>
                            </TD>
                            <TD  WIDTH=69 STYLE="border-bottom: 1px solid #000000; border-left: 1px solid #000000; border-right: none; padding-top: 0in; padding-bottom: 0in; padding-left: 0.02in; padding-right: 0in">
                                <P  ALIGN=CENTER><FONT FACE="Arial, sans-serif"><FONT SIZE=1 STYLE="font-size: 6pt">по
                                    графику</FONT></FONT></P>
                            </TD>
                            <TD  WIDTH=66 STYLE="border-bottom: 1px solid #000000; border-top: none; border-left: 1px solid #000000; border-right: none; padding-top: 0in; padding-bottom: 0in; padding-left: 0.02in; padding-right: 0in">
                                    <P  ALIGN=CENTER><FONT FACE="Arial, sans-serif"><FONT SIZE=1 STYLE="font-size: 6pt">фактически</FONT></FONT></P>
                            </TD>
                        </TR>
                        <TR>
                            <TD HEIGHT=15 STYLE=" border-bottom: 1px solid #000000;  border-right: none; padding-top: 0in; padding-bottom: 0in; padding-left: 0.02in; padding-right: 0in">
                            </TD>
                            <TD STYLE=" border-bottom: 1px solid #000000; border-left: 1px solid #000000; border-right: none; padding-top: 0in; padding-bottom: 0in; padding-left: 0.02in; padding-right: 0in">
                            </TD>
                            <TD  STYLE=" border-bottom: 1px solid #000000; border-left: 1px solid #000000; border-right: none; padding-top: 0in; padding-bottom: 0in; padding-left: 0.02in; padding-right: 0in">
                            </TD>
                            <TD STYLE=" border-bottom: 1px solid #000000; border-left: 1px solid #000000; border-right: none; padding-top: 0in; padding-bottom: 0in; padding-left: 0.02in; padding-right: 0in">
                            </TD>
                        </TR>
                        <TR>
                            <TD HEIGHT=15 STYLE="border-bottom: 1px solid #000000; border-right: none; padding-top: 0in; padding-bottom: 0in; padding-left: 0.02in; padding-right: 0in">
                            </TD>
                            <TD  STYLE=" border-bottom: 1px solid #000000; border-left: 1px solid #000000; border-right: none; padding-top: 0in; padding-bottom: 0in; padding-left: 0.02in; padding-right: 0in">
                            </TD>
                            <TD  STYLE=" border-bottom: 1px solid #000000; border-left: 1px solid #000000; border-right: none; padding-top: 0in; padding-bottom: 0in; padding-left: 0.02in; padding-right: 0in">
			
                            </TD>
                            <TD  STYLE=" border-bottom: 1px solid #000000; border-left: 1px solid #000000; border-right: none; padding-top: 0in; padding-bottom: 0in; padding-left: 0.02in; padding-right: 0in">

                            </TD>
                        </TR>
                        <TR>
                                <TD HEIGHT=15 STYLE=" border-right: none; padding-top: 0in; padding-bottom: 0in; padding-left: 0.02in; padding-right: 0in">
                                        <P ALIGN=CENTER><FONT FACE="Arial, sans-serif"><FONT SIZE=1> <%= date1 %> </FONT></FONT></P>
                                </TD>
                                <TD STYLE="border-left: 1px solid #000000;  border-right: none; padding-top: 0in; padding-bottom: 0in; padding-left: 0.02in; padding-right: 0in">
                                        <P ALIGN=CENTER><FONT FACE="Arial, sans-serif"><FONT SIZE=1> <%= date1 %> </FONT></FONT></P>
                                </TD>
                                <TD STYLE="border-left: 1px solid #000000;  border-right: none; padding-top: 0in; padding-bottom: 0in; padding-left: 0.02in; padding-right: 0in">
                                        <P ALIGN=CENTER><FONT FACE="Arial, sans-serif"><FONT SIZE=1> <%= date2 %> </FONT></FONT></P>
                                </TD>
                                <TD STYLE="border-left: 1px solid #000000; border-right: none; padding-top: 0in; padding-bottom: 0in; padding-left: 0.02in; padding-right: 0in">
                                        <P  ALIGN=CENTER><BR>
                                        </P>
                                </TD>
                        </TR>
                   </TABLE>
               </TD>
               <TD>
                   <TABLE>
                        <TR>
                            <TD COLSPAN="4" WIDTH=388 VALIGN=BOTTOM STYLE="border-top: none; border-bottom: none;  border-right: none; padding-top: 0in; padding-bottom: 0in; padding-left: 0.02in; padding-right: 0in">
                                <P  ALIGN=RIGHT STYLE="margin-bottom: 0in">       
                                    <FONT FACE="Arial, sans-serif">
                                        <FONT SIZE=1 STYLE="font-size: 8pt">
                                                <FONT SIZE=1 STYLE="font-size: 6pt">
                                                        <B>Регистрационный № __________     Серия _________ № ________</B>
                                                </FONT>
                                        </FONT>
                                    </FONT>
                                </P>
                            </TD>
                        </TR>
                        <TR>
                            <TD colspan="4">
                                <P  STYLE="margin-bottom: 0in">    
                                    <FONT FACE="Arial, sans-serif"><FONT SIZE=1 STYLE="font-size: 8pt"><FONT SIZE=1>
                                        <B>Автомобиль исправен.</B>
                                    </FONT></FONT></FONT>
                                </P>
                            </TD>
                        </TR>
                        <TR>
                            <TD colspan="4">
                                <P >    
                                    <FONT FACE="Arial, sans-serif"><FONT SIZE=1 STYLE="font-size: 8pt"><FONT SIZE=1>
                                                <B>Автомобиль прошел профилактическое обслуживание согласно графику.</B>
                                    </FONT></FONT></FONT>
                                </P>
                            </TD>
                        </TR>
                        <TR>
                            <TD  WIDTH=150 VALIGN=TOP STYLE="border: none; padding-top: 0in; padding-bottom: 0in; padding-left: 0.02in; padding-right: 0in">
                                    <P >     
                                        <FONT FACE="Arial, sans-serif">
                                            <FONT SIZE=1 STYLE="font-size: 8pt"><FONT SIZE=1><B>Выезд разрешен. МЕХАНИК</B></FONT></FONT>
                                        </FONT>
                                    </P>
                            </TD>
                            <TD  WIDTH=70 STYLE="border-bottom: 1pt solid #000000;">
                            </TD>
                            <TD WIDTH=15>
                            </TD>
                            <TD ALIGN=CENTER STYLE="border-bottom: 1pt solid #000000;">
                                Микаилов А.Н.
                            </TD>
                        </TR>
                        <TR>
                            <TD>
                            </TD>
                            <TD ALIGN=CENTER VALIGN=TOP STYLE="border: none; padding: 0in">
                                <FONT FACE="Arial, sans-serif" SIZE=1 STYLE="font-size: 5pt">подпись</FONT>
                            </TD>
                            <TD>
                            </TD>
                            <TD   ALIGN=CENTER VALIGN=TOP STYLE="border: none; padding: 0in">
                                <FONT FACE="Arial, sans-serif" SIZE=1 STYLE="font-size: 5pt">расшифровка подписи</FONT>
                            </TD>
                        </TR>
                        <TR>
                            <TD  ALIGN=LEFT COLSPAN=4 WIDTH=66 STYLE=" border: none; padding-top: 0in; padding-bottom: 0in; padding-left: 0.02in; padding-right: 0in">
                                <FONT FACE="Arial, sans-serif" SIZE=1 ><B>Автомобиль принял в исправном состоянии.</B></FONT>
                            </TD>
                        </TR>
                        <TR>
                            <TD COLSPAN=4 WIDTH=388 VALIGN=TOP STYLE=" border: none; padding-top: 0in; padding-bottom: 0in; padding-left: 0.02in; padding-right: 0in">
                                <FONT FACE="Arial, sans-serif" SIZE=1>
                                    <B>Часы заведены. При обнаружении неисправности оборудования на линии ОБЯЗУЮСЬ немедленно вернуться в парк.</B>
				</FONT>
                            </TD>
                        </TR>
                   </TABLE>
               </TD>
           </TR>
    </TABLE>
    <TABLE cellpadding="5">
        <TR valign="bottom" >
            <TD height="40" WIDTH=35 STYLE="border: none; padding: 0in">
                    <P  ALIGN=LEFT>                  
			<FONT FACE="Arial, sans-serif"><FONT SIZE=1 STYLE="font-size: 6pt"><FONT SIZE=2>Врач</FONT></FONT></FONT>
                    </P>
		</TD>
		<TD WIDTH=55 STYLE="border-bottom: 1pt solid #000000;; padding: 0in">
		
		</TD>
		<TD WIDTH=10 STYLE="border: none; padding: 0in">
		
		</TD>
		<TD WIDTH=110 STYLE="border-bottom: 1pt solid #000000;  padding: 0in"> 
		
		</TD>
		<TD WIDTH=40 STYLE="border: none; padding: 0in">
			<P  ALIGN=LEFT><FONT FACE="Arial, sans-serif"><FONT SIZE=2>Механик</FONT></FONT></P>
		</TD>
		<TD WIDTH=55 STYLE="border-bottom: 1pt solid #000000;; padding: 0in"> 
		</TD>
		<TD WIDTH=10 STYLE="border: none; padding: 0in">
		
		</TD>
		<TD ALIGN=CENTER WIDTH=110 STYLE="border-bottom: 1pt solid #000000;; padding: 0in"> 
                    Микаилов А.Н.
		</TD>
		<TD WIDTH=67 STYLE="border: none; padding: 0in">
			<P  ALIGN=CENTER><FONT FACE="Arial, sans-serif"><FONT SIZE=2>Водитель</FONT></FONT></P>
		</TD>
		<TD WIDTH=55 STYLE="border-bottom: 1pt solid #000000; padding: 0in">
		
		</TD>
		<TD WIDTH=10 STYLE="border: none; padding: 0in">
		
		</TD>
		<TD WIDTH=110 ALIGN=CENTER STYLE="border-bottom: 1pt solid #000000; padding: 0in">
                    <%= driverData.get("driver_lastname") %>
		</TD>
	</TR>
	<TR VALIGN=TOP height="40">
		<TD WIDTH=35 STYLE="border: none; padding: 0in">
		
		</TD>
		<TD STYLE="border: none; padding: 0in">
			<P  ALIGN=CENTER style="    margin-top: 0in;"><FONT FACE="Arial, sans-serif"><FONT SIZE=1 STYLE="font-size: 5pt">подпись</FONT></FONT></P>
		</TD>
		<TD WIDTH=10 STYLE="border: none; padding: 0in">
		
		</TD>
		<TD  STYLE="border: none; padding: 0in">
			<P  ALIGN=CENTER style="    margin-top: 0in;"><FONT FACE="Arial, sans-serif"><FONT SIZE=1 STYLE="font-size: 5pt">расшифровка подписи</FONT></FONT></P>
		</TD>
		<TD  STYLE="border: none; padding: 0in">
		
		</TD>
		<TD STYLE="border: none; padding: 0in">
			<P  ALIGN=CENTER style="    margin-top: 0in;">    <FONT FACE="Arial, sans-serif"><FONT SIZE=1 STYLE="font-size: 5pt">подпись</FONT></FONT></P>
		</TD> 
		<TD WIDTH=10 STYLE="border: none; padding: 0in">
		
		</TD>
		<TD STYLE="border: none; padding: 0in">
			<P  ALIGN=CENTER style="    margin-top: 0in;"><FONT FACE="Arial, sans-serif"><FONT SIZE=1 STYLE="font-size: 5pt">расшифровка подписи</FONT></FONT></P>
		</TD>
		<TD STYLE="border: none; padding: 0in">
		</TD>
		<TD   STYLE="border: none; padding: 0in">
			<P  ALIGN=CENTER style="    margin-top: 0in;"> <FONT FACE="Arial, sans-serif"><FONT SIZE=1 STYLE="font-size: 5pt">подпись</FONT></FONT></P>
		</TD>
		<TD WIDTH=10 STYLE="border: none; padding: 0in">
		
		</TD>
		<TD  STYLE="border: none; padding: 0in">
			<P  ALIGN=CENTER style="    margin-top: 0in;"><FONT FACE="Arial, sans-serif"><FONT SIZE=1 STYLE="font-size: 5pt">расшифровка подписи</FONT></FONT></P>
		</TD>
	</TR>
</TABLE>

<TABLE WIDTH=285 CELLPADDING=7 CELLSPACING=0>
	<COL WIDTH=123>
	<COL WIDTH=128>
	<TR VALIGN=TOP>
		<TD WIDTH=123 HEIGHT=13 STYLE="border-top: 2.25pt solid #000000; border-bottom: 1px solid #000000; border-left: 2.25pt solid #000000; border-right: none; padding-top: 0in; padding-bottom: 0in; padding-left: 0.08in; padding-right: 0in">
			<P  CLASS="western"><FONT FACE="Arial, sans-serif"><FONT SIZE=1>Операция</FONT></FONT></P>
		</TD>
		<TD WIDTH=128 STYLE="border-top: 2.25pt solid #000000; border-bottom: 1px solid #000000; border-left: 1px solid #000000; border-right: 2.25pt solid #000000; padding: 0in 0.08in">
			<P  CLASS="western"><FONT FACE="Arial, sans-serif"><FONT SIZE=1>Показание
			спидометра</FONT></FONT></P>
		</TD>
	</TR>
	<TR VALIGN=TOP>
		<TD WIDTH=123 HEIGHT=10 STYLE="border-top: 1px solid #000000; border-bottom: 1px solid #000000; border-left: 2.25pt solid #000000; border-right: none; padding-top: 0in; padding-bottom: 0in; padding-left: 0.08in; padding-right: 0in">
			<P  CLASS="western"><FONT FACE="Arial, sans-serif"><FONT SIZE=1>При
			возвращении</FONT></FONT></P>
		</TD>
		<TD WIDTH=128 STYLE="border-top: 1px solid #000000; border-bottom: 1px solid #000000; border-left: 1px solid #000000; border-right: 2.25pt solid #000000; padding: 0in 0.08in">
			
		</TD>
	</TR>
	<TR VALIGN=TOP>
		<TD WIDTH=123 HEIGHT=18 STYLE="border-top: 1px solid #000000; border-bottom: 1px solid #000000; border-left: 2.25pt solid #000000; border-right: none; padding-top: 0in; padding-bottom: 0in; padding-left: 0.08in; padding-right: 0in">
			<P  CLASS="western"><FONT FACE="Arial, sans-serif"><FONT SIZE=1>При
			выезде        </FONT></FONT>
			</P>
		</TD>
		<TD WIDTH=128 STYLE="border-top: 1px solid #000000; border-bottom: 1px solid #000000; border-left: 1px solid #000000; border-right: 2.25pt solid #000000; padding: 0in 0.08in">
			
		</TD>
	</TR>
	<TR VALIGN=TOP>
		<TD WIDTH=123 HEIGHT=14 STYLE="border-top: 1px solid #000000; border-bottom: 2.25pt solid #000000; border-left: 2.25pt solid #000000; border-right: none; padding-top: 0in; padding-bottom: 0in; padding-left: 0.08in; padding-right: 0in">
			<P  CLASS="western"><FONT FACE="Arial, sans-serif"><FONT SIZE=1>Результат</FONT></FONT></P>
		</TD>
		<TD WIDTH=128 STYLE="border-top: 1px solid #000000; border-bottom: 2.25pt solid #000000; border-left: 1px solid #000000; border-right: 2.25pt solid #000000; padding: 0in 0.08in">
			
		</TD>
	</TR>
</TABLE>

<TABLE WIDTH=320 CELLPADDING=2 CELLSPACING=0>
	<TR>
		<TD WIDTH=60 VALIGN=TOP STYLE="border: none; padding: 0in" colspan=5>
			<P  ALIGN=LEFT STYLE="margin-bottom: 0in"><FONT FACE="Arial, sans-serif"><FONT SIZE=2>После рейсовый осмотр: <br> <br></FONT></FONT></P>
		</TD>
	</TR>
	<TR>
		<TD WIDTH=30 VALIGN=TOP STYLE="border: none; padding: 0in">
			<P  ALIGN=LEFT STYLE="margin-bottom: 0in"><FONT FACE="Arial, sans-serif"><FONT SIZE=1 STYLE="font-size: 6pt"><FONT SIZE=2>Врач
			    </FONT></FONT></FONT></P>
		</TD>
		<td WIDTH=10></td>
		<td WIDTH=150 style="border-bottom: 1pt solid #000000;"> </td>
		<td WIDTH=10></td>
		<td WIDTH=150 style="border-bottom: 1pt solid #000000; "> </td>
	</TR>
	<TR VALIGN=TOP>
		<TD WIDTH=30 VALIGN=TOP STYLE="border: none; padding: 0in">
		</TD>
		<td WIDTH=10></td>
		<td WIDTH=150>
			<P  ALIGN=CENTER style="    margin-top: 0in;"> 
				<FONT FACE="Arial, sans-serif"><FONT SIZE=1 STYLE="font-size: 5pt">подпись</FONT></FONT>
			</P>
		</td>
		<td WIDTH=10></td>
		<td WIDTH=150>
			<P  ALIGN=CENTER style="    margin-top: 0in;"> 
				<FONT FACE="Arial, sans-serif"><FONT SIZE=1 STYLE="font-size: 5pt">расшифровка подписи</FONT></FONT>
			</P>
		</td>
	</TR>
</TABLE>

<P  CLASS="western" STYLE="margin-bottom: 0in">
	<FONT FACE="Arial, sans-serif"><FONT SIZE=2 STYLE="font-size: 9pt">Разные отметки и замечания в работе на линии <BR>
	Телефоны организации: <%= compData.get("phone") %></FONT></FONT></P>
	
<TABLE>
	<TR ><TD WIDTH=690 HEIGHT=15 style="border-bottom: 1pt solid #000000;"> <TD></TR>
	<TR ><TD WIDTH=690 HEIGHT=15 style="border-bottom: 1pt solid #000000;"> <TD></TR>
	<TR ><TD WIDTH=690 HEIGHT=15 style="border-bottom: 1pt solid #000000;"> <TD></TR>
	<TR ><TD WIDTH=690 HEIGHT=15 style="border-bottom: 1pt solid #000000;"> <TD></TR>
	<TR ><TD WIDTH=690 HEIGHT=15 style="border-bottom: 1pt solid #000000;"> <TD></TR>
</TABLE>

<TABLE WIDTH=690>
	<TR> 
		<TD VALIGN=TOP WIDTH=345  HEIGHT=150  style="border-right: 1pt solid #000000;">
			<P  CLASS="western" STYLE="margin-bottom: 0in">
				<FONT FACE="Arial, sans-serif"><FONT SIZE=1 STYLE="font-size: 8pt">Отметка техпомощи:                                                  
             </FONT></FONT></P>
		</TD>
		<TD VALIGN=TOP WIDTH=345 >
			<TABLE>
				<TR> 
					<TD COLSPAN=5>
						<P  CLASS="western" STYLE="margin-bottom: 0in">
							<FONT FACE="Arial, sans-serif"><FONT SIZE=1 STYLE="font-size: 8pt">Автомобиль сдал:                                                 
							</FONT></FONT>
						</P>
					</TD>
				</TR>
				<TR> 
					<TD>
						<P  ALIGN=CENTER><FONT FACE="Arial, sans-serif"><FONT SIZE=1 STYLE="font-size: 8pt">
							<B>водитель:</B>
							</FONT></FONT>
						</P>
					</TD>
					<TD WIDTH=5></TD>
					<TD WIDTH=70 style="border-bottom: 1pt solid #000000;"></TD>
					<TD WIDTH=5></TD>
					<TD style="border-bottom: 1pt solid #000000;">
						<P  ALIGN=CENTER><FONT FACE="Arial, sans-serif"><FONT SIZE=1 STYLE="font-size: 8pt"><SPAN LANG="en-US">
                    <%= driverData.get("driver_lastname") %></SPAN></FONT></FONT></P>
					</TD>
				</TR>
				<TR VALIGN=TOP> 
					<TD></TD>
					<TD> </TD>
					<TD>
						<P  ALIGN=CENTER style="    margin-top: 0in;"> 
							<FONT FACE="Arial, sans-serif"><FONT SIZE=1 STYLE="font-size: 5pt">подпись</FONT></FONT>
						</P>
					</TD>
					<TD></TD>
					<TD>
						<P  ALIGN=CENTER style="    margin-top: 0in;"> 
							<FONT FACE="Arial, sans-serif"><FONT SIZE=1 STYLE="font-size: 5pt">расшифровка подписи</FONT></FONT>
						</P>
					</TD>
				</TR>
				
				<TR> 
					<TD COLSPAN=5>
						<P  CLASS="western" STYLE="margin-bottom: 0in">
							<FONT FACE="Arial, sans-serif"><FONT SIZE=1 STYLE="font-size: 8pt">Автомобиль принял:                                                 
							</FONT></FONT>
						</P>
					</TD>
				</TR>
				<TR> 
					<TD>
						<P  ALIGN=CENTER><FONT FACE="Arial, sans-serif"><FONT SIZE=1 STYLE="font-size: 8pt">
							<B>механик:</B>
							</FONT></FONT>
						</P>
					</TD>
					<TD WIDTH=5></TD>
					<TD WIDTH=70 style="border-bottom: 1pt solid #000000;"></TD>
					<TD WIDTH=5></TD>
					<TD style="border-bottom: 1pt solid #000000;">
						<P  ALIGN=CENTER><FONT FACE="Arial, sans-serif"><FONT SIZE=1 STYLE="font-size: 8pt"><SPAN LANG="en-US"></SPAN></FONT></FONT></P>
					</TD>
				</TR>
				<TR VALIGN=TOP> 
					<TD></TD>
					<TD> </TD>
					<TD>
						<P  ALIGN=CENTER style="    margin-top: 0in;"> 
							<FONT FACE="Arial, sans-serif"><FONT SIZE=1 STYLE="font-size: 5pt">подпись</FONT></FONT>
						</P>
					</TD>
					<TD></TD>
					<TD>
						<P  ALIGN=CENTER style="    margin-top: 0in;"> 
							<FONT FACE="Arial, sans-serif"><FONT SIZE=1 STYLE="font-size: 5pt">расшифровка подписи</FONT></FONT>
						</P>
					</TD>
				</TR>
			</TABLE>
		</TD>
	</TR>
    </TABLE>
    </DIV>
<%
    }
%>
<SCRIPT>
    $(document).ready(function() {
        window.print();
    });
</SCRIPT>
</BODY>

</HTML>
