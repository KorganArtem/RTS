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
                font-size: 11px;
                float: left;
                text-align: center;
                width: 170mm;
                min-height: 270mm;
                border-collapse: collapse; /* Убираем двойные линии между ячейками */
               }
            td{
                border: solid #000 1px;
                       height: 10mm;
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
                       height: 10mm;
                   }
                  .leftPage{
                      margin-right: 20mm;
                      margin-bottom: 10mm;
                  }
                  .rightPage{
                      margin-left: 20mm;
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
            int counterPP = 0;
            for (String key : keys) {
                Map row = wbList.get(key);
                if(rowCounter==0){
                    table1=null;
                    table2=null;
                    table1 = "<table class='firstPage leftPage' style='page-break-after: always'>"
                            + "<tr style='height: 15mm;'><td>№ ПП</td>"
                            + "<td>Дата проведения инструктажа</td>"
                            + "<td>Марка ТС, гос. регистрационный знак</td>"
                            + "<td>ФИО водителя</td>"
                            + "<td>должность и ФИО лица проводившего инструктаж</td></tr>";
                    table2 = "<table class='rightPage'>"
                            + "<tr style='height: 15mm;'><td>Краткое содержание инструктажа</td>"
                            + "<td>подпись лица проводившего инструктаж</td>"
                            + "<td>Подпись водителя</td></tr>";
                }
                rowCounter++;
                counterPP++;
                table1 = table1 + "<tr><td>" + counterPP + "</td>"
                        + "<td>" + row.get("waybillsDate") + "</td>"
                        + "<td>" +  row.get("number") + "</td>"
                        + "<td>" + row.get("driver_lastname") + " " + row.get("driver_firstname") + " " + row.get("driver_midName") + "</td>"
                        + "<td>механик Микаилов А.Н.</td></tr>";
                table2 = table2 + "<tr><td> ПДД,    погодные условия, правила перевозки</td>"
                        + "<td></td>"
                        + "<td></td></tr>";
                
                if(rowCounter==25){ 
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
