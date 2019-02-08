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
                text-align: center;
                /*width: 250mm;*/
                border-collapse: collapse; /* Убираем двойные линии между ячейками */
               }
            td{
                border: solid #000 1px;
            }
            @media print {
                @page {
                    size: 297mm 210mm; /* landscape */
                    /* you can also specify margins here: */
                    /*margin: 15mm; */
                    /*margin-right: 15mm; /* for compatibility with both A4 and Letter */
                  }
                  TABLE {
                    font-size: 10px;
                    text-align: center;
                    /*width: 250mm;*/
                    border-collapse: collapse; /* Убираем двойные линии между ячейками */
                   }
                   tr{
                       height: 8mm;
                   }
                   .leftPage{
                      margin-left: 7mm;
                      margin-right: 13mm;
                      margin-bottom: 10mm;
                      margin-top: 10mm;
                  }
                  .rightPage{
                      margin-left: 13mm;
                      margin-right: 7mm;
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
            int rowCounter = 0;
            int pageCounter = 0;
            SortedSet<String> keys = new TreeSet<>(wbList.keySet());
            //for(Entry<String, Map> wayBill : wbList.entrySet()){
            boolean leftPage = true;
            for (String key : keys) {
                Map row = wbList.get(key);
                String pageClass="leftPage";
                if(!leftPage)
                    pageClass = "rightPage";
                if(rowCounter==0){
                    table1=null;
                    table1 = "<div class='firstPage "+pageClass+"' style=' page-break-after: always'><table >"
                            + "<tr><td>Дата время<br> проведения осмотра</td>"
                            + "<td>ФИО </td>"
                            + "<td>Пол </td>"
                            + "<td>Дата рождения водителя</td>"
                            + "<td>Жалобы</td>"
                            + "<td>Визуальный осмотр</td>"
                            + "<td>Температура тела</td>"
                            + "<td>Артериальное давление</td>"
                            + "<td>Пульс</td>"
                            + "<td>Проба на наличие алкоголя</td>"
                            + "<td>Заключение о результатах <br>медицинского осмотра</td>"
                            + "<td>Подпись <br>медицинского работника с расшифровкой</td>"
                            + "<td>Подпись работника</td></tr>";
                }
                rowCounter++;
                table1 = table1 + "<tr><td>" + row.get("waybillsDate")+ " " + row.get("outTime")+ "</td>"
                        + "<td>" + row.get("driver_lastname") + " " + row.get("driver_firstname") + " " + row.get("driver_midName") + "</td>"
                        + "<td>" + row.get("sex") + "</td>"
                        + "<td>" + row.get("driver_bornDate") + "</td>"
                        + "<td>нет</td>"
                        + "<td>Норм.</td>"
                        + "<td>" + row.get("temperature") + "</td>"
                        + "<td>" + row.get("bloodPressure") + "</td>"
                        + "<td>" + row.get("pulse") + "</td>"
                        + "<td>0,00</td>"
                        + "<td>Признаки воздействия вредных (опасных) факторов, состояний и заболеваний отсутствуют</td>"
                        + "<td>" + row.get("waybillsDate") + "</td>"
                        + "<td>" + row.get("driverId") + "</td></tr>";
                
                
                if(rowCounter==20){ 
                    pageCounter++;
                    leftPage= !leftPage;
                    table1=table1+"</table>"
                            + "<div style='width: 100%; text-align: center; padding=1.5mm;'>"+pageCounter+"</div>"
                            + "</div><p class='more'></p>";
        %>
                    
                    <%= table1 %>
                    <%  rowCounter = 0;
                    if(pageCounter==90) break;  
                }
              ;
            }
        %>
    </body>
</html>