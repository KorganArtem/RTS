<%-- 
    Document   : wayBillReport
    Created on : Jan 7, 2019, 12:33:32 PM
    Author     : Artem
--%>

<%@page import="ru.leasicar.workerSql.CarSQL"%>
<%@page import="ru.leasicar.workerSql.CompanySQL"%>
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
    String[] mounths = {"Января", "Февраля", "Марта", "Апреля", "Мая", "Июня", "Июля", "Августа", "Сентября", "Октября", "Ноября", "Декабря"};
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
    CompanySQL cSQL = new CompanySQL();
    String companyName = cSQL.getCompanyName(companyId);
    Map<Integer, Map> wbList = wsql.getWayBillTabel(dateStart, dateEnd, companyId, 0, true);
    String dayStart = dateStart.split("-")[2];
    int mounth = Integer.parseInt(dateStart.split("-")[1]);
    System.out.println(mounth);
    String mounthStart = mounths[mounth-1];
    String yerStart = dateStart.split("-")[0];
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
                min-height: 250mm;
                border-collapse: collapse; /* Убираем двойные линии между ячейками */
               }
            td{
                border: solid #000 1px;
                       height: 8mm;
            }.titlePage{
                /*width: 210mm;
                height: 290mm;  */
            }
            .headerTitle{
                margin-left: 80mm;
                margin-top: 100mm;
                text-align: center;
                width: 50mm;
            }
            .dateTitle{
                margin-left: 100mm;
                margin-top: 100mm;
                text-align: right;
            }
            .companyTitle{
                text-align: center;
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
                      margin-left: 10mm;
                      margin-right: 20mm;
                      margin-bottom: 10mm;
                      margin-top: 10mm;
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
    <body><div class="titlePage more">
            <div class="headerTitle">
                <font style="font-size: 36px"><b>ЖУРНАЛ</b> </font>
                <font style="font-size: 25px">по проведению предрейсовых инструктажей </font><br>
                <font style="font-size: 25px">с водительским составом </font><br>
                <font style="font-size: 25px">по безопасности дорожного движения</font><br>
                <font style="font-size: 25px">за 2019 год	</font>
            </div>
            <div class="companyTitle">
                <p style="font-size: 26px"><b><%= companyName %></b></p>	
            </div>
            <div class="dateTitle">
                Начат	"___" ___________ <%= yerStart %><br>
                Окончен	"___" ___________ <%= yerStart %>
            </div>
        </div>
        <% 
            String table1 = "";
            String table2 = "";
            int rowCounter = 0;
            int pageCounter = 0;
            SortedSet<Integer> keys = new TreeSet<>(wbList.keySet());
            //for(Entry<String, Map> wayBill : wbList.entrySet()){
            int counterPP = 0;
            for (Integer key : keys) {
                Map row = wbList.get(key);
                if(rowCounter==0){
                    table1=null;
                    table2=null;
                    table1 = "<div class='firstPage leftPage' style=' page-break-after: always'><table>"
                            + "<tr style='height: 15mm;'><td>№ ПП</td>"
                            + "<td>Дата проведения инструктажа</td>"
                            + "<td>Марка ТС, гос. регистрационный знак</td>"
                            + "<td>ФИО водителя</td>"
                            + "<td>должность и ФИО лица проводившего инструктаж</td></tr>";
                    table2 = "<div class='firstPage rightPage' style=' page-break-after: always'><table>"
                            + "<tr style='height: 15mm;'><td>Краткое содержание инструктажа</td>"
                            + "<td>подпись лица проводившего инструктаж</td>"
                            + "<td>Подпись водителя</td></tr>";
                }
                rowCounter++;
                counterPP++;
                table1 = table1 + "<tr><td>" + counterPP + "</td>"
                        + "<td>" + row.get("waybillsDate") + "</td>"
                        + "<td>" + modelList.get(row.get("model"))+ " <br> " +  row.get("number") +"</td>"
                        + "<td>" + row.get("driver_lastname") + " " + row.get("driver_firstname") + " " + row.get("driver_midName") + "</td>"
                        + "<td>Специалист по БДД Марьин Е.М.</td></tr>";
                table2 = table2 + "<tr><td> ПДД,    погодные условия, правила перевозки, режим движения, организация отдыха и приема пищи</td>"
                        + "<td></td>"
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
                    if(pageCounter==60) break;  
                    
                }
              ;
            }
        %>
    </body>
</html>
