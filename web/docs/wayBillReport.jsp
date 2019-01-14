<%-- 
    Document   : wayBillReport
    Created on : Jan 7, 2019, 12:33:32 PM
    Author     : Artem
--%>

<%@page import="java.util.TreeSet"%>
<%@page import="java.util.SortedSet"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.Map"%>
<%@page import="ru.leasicar.workerSql.WayBillSQL"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    WayBillSQL wsql = new WayBillSQL();
    String dateStart = null;
    if(request.getParameter("dateStart")!=null){
        dateStart = request.getParameter("dateStart");
    }
    String dateEnd = null;
    if(request.getParameter("dateEnd")!=null){
        dateEnd = request.getParameter("dateStart");
    }
    int companyId = Integer.parseInt(request.getParameter("companyId"));
    Map<String, Map> wbList = wsql.getWayBillTabel(dateStart, dateEnd, companyId);
    
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            TABLE {
                text-align: center;
                width: 180mm;
                border-collapse: collapse; /* Убираем двойные линии между ячейками */
               }
            td{
                border: solid #000 1px;
            }
            @media print {
                @page {
                    size: 210mm 297mm; /* landscape */
                    /* you can also specify margins here: */
                    /*margin: 15mm; */
                    /*margin-right: 15mm; /* for compatibility with both A4 and Letter */
                  }
                  TABLE {
                    text-align: center;
                    width: 160mm;
                    border-collapse: collapse; /* Убираем двойные линии между ячейками */
                   }
                   tr{
                       height: 9mm;
                   }
                  .leftPage{
                      margin-right: 40mm;
                      margin-bottom: 10mm;
                  }
                  .rightPage{
                      margin-left: 40mm;
                      margin-bottom: 10mm;
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
            SortedSet<String> keys = new TreeSet<>(wbList.keySet());
            //for(Entry<String, Map> wayBill : wbList.entrySet()){
            for (String key : keys) {
                Map row = wbList.get(key);
                if(rowCounter==0){
                    table1=null;
                    table2=null;
                    table1 = "<table class='firstPage leftPage' style='float: left; page-break-after: always'>"
                            + "<tr><td>Номер <br> путевого <br> листа</td>"
                            + "<td>Дата</td>"
                            + "<td>ФИО</td>"
                            + "<td>Табельный номер</td></tr>";
                    table2 = "<table class='rightPage'>"
                            + "<tr><td>Гаражный <br> номер <br> а/м</td>"
                            + "<td>Подпись водителя</td>"
                            + "<td>Подпись диспетчера и дата</td>"
                            + "<td>Подпись бухгалтера</td></tr>";
                }
                rowCounter++;
                table1 = table1 + "<tr><td>" + row.get("docNumInBill") + "</td>"
                        + "<td>" + row.get("waybillsDate") + "</td>"
                        + "<td>" + row.get("driver_lastname") + " " + row.get("driver_firstname") + " " + row.get("driver_midName") + "</td>"
                        + "<td>" + row.get("driverId") + "</td></tr>";
                table2 = table2 + "<tr><td>" + row.get("number") + "</td>"
                        + "<td></td>"
                        + "<td>" + row.get("endDate") + "</td>"
                        + "<td></td></tr>";
                
                if(rowCounter==30){ 
                    table1=table1+"</table><p class='more'></p>";
                    table2=table2+"</table><p class='more'></p>";
        %>
                    
                    <%= table1 %>
                    <%= table2 %>
                    <%  rowCounter = 0;    
                }
              ;
            }
        %>
    </body>
</html>
