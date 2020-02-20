<%-- 
    Document   : wayBillReport
    Created on : Jan 7, 2019, 12:33:32 PM
    Author     : Artem
--%>

<%@page import="ru.leasicar.workerSql.CompanySQL"%>
<%@page import="java.util.TreeSet"%>
<%@page import="java.util.SortedSet"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.Map"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="ru.leasicar.workerSql.WayBillSQL"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
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
    Map<Integer, Map> wbList = wsql.getWayBillTabel(dateStart, dateEnd, companyId, 0);
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
                text-align: center;
                width: 180mm;
                border-collapse: collapse; /* Убираем двойные линии между ячейками */
               }
            td{
                border: solid #000 1px;
            }
            .titlePage{
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
                    text-align: center;
                    width: 160mm;
                    border-collapse: collapse; /* Убираем двойные линии между ячейками */
                   }
                   tr{
                       height: 8mm;
                   }
                  .leftPage{
                      margin-left: 12mm;
                      margin-right: 22mm;
                      margin-bottom: 18mm;
                      margin-top: 15mm;
                  }
                  .rightPage{
                      margin-left: 22mm;
                      margin-right: 12mm;
                      margin-bottom: 18mm;
                      margin-top: 15mm;
                  }
                .more{
                 page-break-after: always;
                } 
            } 
        </style>
    </head>
    <body>
        <div class="titlePage more">
            <div class="headerTitle">
                <font style="font-size: 36px"><b>ЖУРНАЛ</b> </font>
                <font style="font-size: 30px">учета путевых листов</font><br>
                <font style="font-size: 30px">за 2019 год	</font>
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
            for (Integer key : keys) {
                Map<String, String> row = wbList.get(key);
                DateFormat formatDocNum = new SimpleDateFormat("yyMMdd");
                String docNum = row.get("carIdO")+1000;  
                //docNum = formatDocNum.format(date)+docNum.substring(1);
                if(rowCounter==0){
                    table1=null;
                    table2=null;
                    table1 = "<div class='firstPage leftPage' style=' page-break-after: always'><table>"
                            + "<tr><td>Номер <br> путевого <br> листа</td>"
                            + "<td>Дата</td>"
                            + "<td>ФИО</td>"
                            + "<td>Табельный номер</td></tr>";
                    table2 = "<div class='firstPage rightPage' style=' page-break-after: always'><table>"
                            + "<tr><td>Гаражный <br> номер <br> а/м</td>"
                            + "<td>Подпись водителя</td>"
                            + "<td>Подпись диспетчера и дата</td>"
                            + "<td>Подпись бухгалтера</td></tr>";
                }
                rowCounter++;
                table1 = table1 + "<tr><td>" + row.get("docNumInBill")+row.get("wayBillsId")+ "</td>"
                        + "<td>" + row.get("waybillsDate") + "</td>"
                        + "<td>" + row.get("driver_lastname") + " " + row.get("driver_firstname") + " " + row.get("driver_midName") + "</td>"
                        + "<td>" + row.get("driverId") + "</td></tr>";
                table2 = table2 + "<tr><td>" + row.get("number") + "</td>"
                        + "<td></td>"
                        + "<td>" + row.get("endDate") + "</td>"
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
