/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ru.leasicar.main;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.Iterator;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import ru.leasicar.authorization.AccessControl;
import ru.leasicar.workerSql.DriverSQL;

/**
 *
 * @author korgan
 */
@WebServlet(name = "LD", urlPatterns = {"/LD"})
public class ListDriver extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        AccessControl ac = new AccessControl();
        if(ac.isLogIn(request.getSession().getId())){
            try (PrintWriter out = response.getWriter()) {
                /* TODO output your page here. You may use following sample code. */
                out.println("<table id='listDriverTabel' class='listDriver'>"); 
                ///////////////////////////////////////////////////////////////
                boolean delete = ac.checkPermission(ac.getUserId(request.getSession().getId()), "deletDriver");
                String colDel="";
                if(delete)
                    colDel="<td></td>";
                ///////////////////////////////////////////////////////////////
                boolean showBalance = ac.checkPermission(ac.getUserId(request.getSession().getId()), "showBalance");
                String colsBalance="";
                if(showBalance)
                    colsBalance="<td>Лимит</td><td>Баланс</td><td>Депозит</td><td class='noPrint'> </td><td class='noPrint'></td>";   
                int showDeleted = Integer.parseInt(request.getParameter("deleted"));
                DriverSQL wsql = new DriverSQL();
                Map listDriver = wsql.listDriver(showDeleted);
                Iterator<Map.Entry<String, Map>> entries = listDriver.entrySet().iterator();
                out.println("<div class='scrollingBlock'>");
                out.println("<thead><tr><td>Фамилия</td><td>Имя</td><td>Номер</td><td>Марка</td><td>Телефон</td>");
                out.println(colsBalance+"<td class='noPrint'></td>"+colDel+"<td class='noPrint'></td></tr></thead>");
                while (entries.hasNext()) {
                    Map.Entry<String, Map> entry = entries.next();
                    Map<String, String> draverData = entry.getValue();
                    String day_off="";
                    if(draverData.get("dayOff")==null || draverData.get("dayOff").equals("1"))
                        day_off="<img src='img/day_off.png'/>";
                    else
                        day_off="<img src='img/wrk.png'/>";
                    String colorRow = "white";
                    if(Double.parseDouble((String) draverData.get("driver_current_debt"))<0.0)
                        colorRow="yellow";
                    if(Double.parseDouble((String) draverData.get("driver_current_debt"))<Integer.parseInt((String) draverData.get("driver_limit"))*-1)
                        colorRow="red";
                    String delButton = "";
                    if(delete)
                        delButton="<td onClick='delDriver("+entry.getKey()+")'>Уволить</td>";
                    if(showBalance)
                        colsBalance="<td>"+draverData.get("driver_limit")+"</td>"
                            + "<td>"+draverData.get("driver_current_debt")+"</td>"
                            + "<td>"+draverData.get("driver_deposit")+"</td>"
                            + "<td class='takeMoney noPrint' onClick='takePay("+entry.getKey()+")'><img src='img/takeMoney.png'/></td>";
                    else
                        colsBalance="";
                    String report = "";
                    if(showBalance)
                        report="<td class='wrkday noPrint' onClick='getReport("+entry.getKey()+")'>отчет</td>";
                    out.println("<tr class="+colorRow+">"
                            + "<td ondblclick='editDriver("+entry.getKey()+")' class='clickable' id='listDriverFirstName"+entry.getKey()+"'>"+draverData.get("driver_lastname")+"</td>"
                            + "<td id='listDriverLastName"+entry.getKey()+"'>"+draverData.get("driver_firstname")+"</td>"
                            /*+ "<td id='listDriverCarNamber"+entry.getKey()+"'>"+draverData.get("driver_carnumber")+"</td>"*/
                            + "<td id='listDriverCarNamber"+entry.getKey()+"'>"+draverData.get("id_car")+"</td>"
                            + "<td>"+draverData.get("modelName")+"</td>"
                            + "<td class='phoneInList'>"+draverData.get("driver_phone_number")+"</td>"
                            /*+ "<td>"+draverData.get("modelName")+"</td>"*/
                            + colsBalance 
                            + delButton        
                            + "<td class='wrkday noPrint'>"+day_off+"</td>"
                            + report
                                    + "<td class='docsCol' driverId='"+entry.getKey()+"' >");  //driverId='"+entry.getKey()+"'
                    if(draverData.get("haveBill").equals("1"))
                        out.println("<img src='img/docs.png' alt=''/></td></tr>");
                    else
                        out.println("<img src='img/doc1.png' alt=''/></td></tr>");
                }
                out.println("</table></div>");
                if(showBalance)
                    out.println("Итоговый баланс: "+wsql.getCurentGlobalBalance());
                //wsql.addAccrual();
                wsql.con.close();
                
            }
        }
        else{
            System.out.println("Go to login Page!");
            request.getRequestDispatcher("/").forward(request, response);
            return;
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ListDriver.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(ListDriver.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ListDriver.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(ListDriver.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
