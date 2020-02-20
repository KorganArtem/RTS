<%-- 
    Document   : wayBillReport
    Created on : Jan 7, 2019, 12:33:32 PM
    Author     : Artem
--%>

<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="ru.leasicar.workerSql.CarSQL"%>
<%@page import="java.util.Random"%>
<%@page import="java.util.TreeSet"%>
<%@page import="java.util.SortedSet"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.Map"%>
<%@page import="ru.leasicar.workerSql.WayBillSQL"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    CarSQL carSQL = new CarSQL();
    Map<String, String> modelList = carSQL.modelLiscArr();
    WayBillSQL wsql = new WayBillSQL();
    String dateStart = null;
    if(request.getParameter("dateStart")!=null){
        dateStart = request.getParameter("dateStart");
    }
    String dateEnd = null;
    if(request.getParameter("dateEnd")!=null){
        dateEnd = request.getParameter("dateEnd");
    }
    int companyId = Integer.parseInt(request.getParameter("companyId"));
    Map<Integer, Map> wbList = wsql.getWayBillTabel(dateStart, dateEnd, companyId, 0);
    
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            TABLE {
                font-size: 10px;
                float: left;
                text-align: center;
                width: 170mm;
                min-height: 250mm;
                border-collapse: collapse; /* Убираем двойные линии между ячейками */
               }
            td{
                border: solid #000 1px;
                       height: 8mm;
            }
            @media print {
                @page {
                    size: 210mm 297mm; /* landscape */
                    /* you can also specify margins here: */
                    /*margin: 15mm; */
                    /*margin-right: 15mm; /* for compatibility with both A4 and Letter */
                  }
                  TABLE {
                      float: none;
                    text-align: center;
                    width: 180mm;
                    border-collapse: collapse; /* Убираем двойные линии между ячейками */
                   }
                   tr{
                       height: 7mm;
                   }
                  .leftPage{
                      margin-left: 0mm;
                      margin-right: 30mm;
                      margin-bottom: 10mm;
                      margin-top: 8mm;
                  }
                  .rightPage{
                      margin-left: 20mm;
                      margin-right: 10mm;
                      margin-bottom: 10mm;
                      margin-top: 10mm;
                  }
                .more{
                 page-break-after: always;
                } 
            } 
        </style>
    </head>
    <body>
        <% 
            String table1 = "";
            String table2 = "";
            int rowCounter = 0;
            int pageCounter = 0;
            SortedSet<Integer> keys = new TreeSet<>(wbList.keySet());
            //for(Entry<String, Map> wayBill : wbList.entrySet()){
            int counterPP = 0;
	    DateFormat dateFormat = new SimpleDateFormat("HH-mm");
	    DateFormat dateFormatP = new SimpleDateFormat("HH:mm");
            for (Integer key : keys) {
                Map<String, String> row = wbList.get(key);
		//////////////   OUT TIME  /////////////////////////
		
		String outTime = row.get("outTime");
		Date d = dateFormat.parse(outTime);
		outTime=dateFormatP.format(d.getTime()+1000*60*10);
		String inTime=dateFormatP.format(d.getTime()+(60*60*1000)*10);	
                if(rowCounter==0){
                    table1=null;
                    table2=null;
                    table1 = "<div class='firstPage leftPage' style=' page-break-after: always'><table>"
                            + "<tr style='height: 15mm;'><td>№ ПП</td>"
                            + "<td style='width: 35mm;'>Дата</td>"
                            + "<td>Марка ТС, гос. регистрационный<br> знак</td>"
                            + "<td>ФИО водителя</td>"
                            + "<td>Время выезда на линию</td>"
			    + "<td>Показания спидометра при выезде</td>"
			    + "<td>Техническое состояние автомобиля</td></tr>";
                    table2 = "<div class='firstPage rightPage' style=' page-break-after: always'><table>"
                            + "<tr style='height: 15mm;'><td style='width: 60px;'>Время возврата</td>"
                            + "<td style='width: 100px;'>Показания спидометра при возврате</td>"
                            + "<td style='width: 60px;'>Техническое состояние автомобиля при возврате</td>"
			    + "<td>Ф.И.О. механика</td>"
			    + "<td>Подпись</td></tr>";
                }
                rowCounter++;
                counterPP++;
                table1 = table1 + "<tr><td>" + counterPP + "</td>"
                        + "<td>" + row.get("waybillsDate") + "</td>"
                        + "<td>"+ modelList.get(row.get("model"))+ " <br> " +  row.get("number") + "</td>"
                        + "<td>" + row.get("driver_lastname") + " " + row.get("driver_firstname") + " " + row.get("driver_midName") + "</td>"
                        + "<td>"+outTime+"</td>"
			+ "<td></td>"
			+ "<td>Исправен</td></tr>";
		
                table2 = table2 + "<tr><td>"+inTime+"</td>"
                        + "<td> </td>"
                        + "<td></td>"
			+ "<td>Микаилов А.Н.</td>"
			+ "<td></td></tr>";
                
                if(rowCounter==30){ 
                    pageCounter++;
                    table1=table1+"</table>"
                            + "<div style='width: 100%; text-align: center; padding=1mm;'>"+pageCounter+"</div>"
                            + "</div><p class='more'></p>";
                    pageCounter++;
                    table2=table2+"</table>"
                            + "<div style='width: 100%; text-align: center; padding=1mm;'>"+pageCounter+"</div>"
                            + "</div><p class='more'></p>";
        %>
                    
                    <%= table1 %>
                    <%= table2 %>
                    <%  rowCounter = 0;  
                    if(pageCounter==160) break;  
                    
                }
              ;
            }
        %>
    </body>
</html>
