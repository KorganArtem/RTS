<%@page import="ru.leasicar.workerSql.CompanySQL"%>
<%@page import="java.util.TreeSet"%>
<%@page import="java.util.SortedSet"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.Map"%>
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
    int mounth = Integer.parseInt(dateStart.split("-")[1])-1;
    String mounthStart = mounths[mounth];
    String yerStart = dateStart.split("-")[0];
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            TABLE {
                font-size: 11px;
                text-align: center;
                width: 250mm;
                border-collapse: collapse; /* Убираем двойные линии между ячейками */
               }
            td{
                border: solid #000 1px;
            }
            .headerTitle{
                /*margin-left: 80mm;*/
                margin-top: 50mm;
                text-align: center;
            }
            .dateTitle{
                margin-left: 130mm;
                margin-top: 80mm;
                text-align: right;
            }
            .companyTitle{
                text-align: center;
            }
            .alLeft{
                text-align: left;
            }

            @media print {
                @page {
                    size: 297mm 210mm; /* landscape */
                    /* you can also specify margins here: */
                    /*margin: 15mm; */
                    /*margin-right: 15mm; /* for compatibility with both A4 and Letter */
                  }
                  TABLE {
                    font-size: 11px;
                    text-align: center;
                    width: 250mm;
                    border-collapse: collapse; /* Убираем двойные линии между ячейками */
                   }
                   tr{
                       height: 7mm;
                   }
                  .leftPage{
                      margin-left: 7mm;
                      margin-right: 13mm;
                      margin-bottom: 12mm;
                      margin-top: 12mm;
                  }
                  .rightPage{
                      margin-left: 13mm;
                      margin-right: 7mm;
                      margin-bottom: 12mm;
                      margin-top: 12mm;
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
                <font style="font-size: 36px"><b>ЖУРНАЛ</b> </font><br>
                <font style="font-size: 30px">Журнал предрейсовых медосмотров</font><br>
                <font style="font-size: 30px">за <%= yerStart %> год	</font>
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
	    int lastDriverID =0;
            int rowCounter = 0;
            int pageCounter = 0;
            SortedSet<Integer> keys = new TreeSet<>(wbList.keySet());
            //for(Entry<String, Map> wayBill : wbList.entrySet()){
            boolean leftPage = true;
            for (int key : keys) {
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
                            + "<td>Заключение о результатах медицинского осмотра</td>"
                            + "<td>Подпись медицинского работника с расшифровкой</td>"
                            + "<td>Подпись работника</td></tr>";
                }
                rowCounter++;
                table1 = table1 + "<tr><td style='vertical-align: top;'>" + row.get("waybillsDate")+ " " + row.get("outTime")+ "</td>"
                        + "<td>" + row.get("driver_lastname") + " " + row.get("driver_firstname") + " " + row.get("driver_midName") + "</td>"
                        + "<td>" + row.get("sex") + "</td>"
                        + "<td>" + row.get("driver_bornDate") + "</td>"
                        + "<td>нет</td>"
                        + "<td>Норм.</td>"
                        + "<td>"+ row.get("temperature") +"</td>"
                        + "<td>"+ row.get("bloodPressure") +"</td>"
                        + "<td>"+ row.get("pulse") +"</td>"
                        + "<td>0,00</td>"
                        + "<td>Допуск</td>"
                        + "<td class='alLeft'>Захарова Г.Н. </td>"   //" + row.get("waybillsDate") + "
                        + "<td></td></tr>";  //" + row.get("driverId") + "
               
                if(rowCounter==20){ 
                    pageCounter++;
                    leftPage= !leftPage;
                    table1=table1+"</table>"
                            + "<div style='width: 100%; text-align: center; padding=1.5mm;'>"+pageCounter+"</div>"
                            + "</div><p class='more'></p>";
        %>
                    
                    <%= table1 %>
                    <%  rowCounter = 0;    
                    if(pageCounter==190) break; 
                }
              ;
            }
        %>
    </body>
</html>