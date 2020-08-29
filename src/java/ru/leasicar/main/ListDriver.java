/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ru.leasicar.main;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.Iterator;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.NamingException;
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
            throws ServletException, IOException, ClassNotFoundException, SQLException, ParseException, NamingException {
        response.setContentType("text/html;charset=UTF-8");
        AccessControl ac = new AccessControl();
        if(ac.isLogIn(request.getSession().getId())){
            try (PrintWriter out = response.getWriter()) {
                DriverSQL wsql = new DriverSQL();
		out.println("<table id='listDriverTabel' class='listDriver'>"); 
                boolean showBalance = ac.checkPermission(ac.getUserId(request.getSession().getId()), "showBalance");
                String colsBalance="";
                if(showBalance){
                    colsBalance="<td>Баланс</td><td>Депозит</td><td class='noPrint'> </td><td class='noPrint'></td>";   
                
		}
		Map listDriver=null;
		if(request.getParameter("filtered")!=null){
		    String where="";
		    if(request.getParameter("addDate")!=null){
			if(request.getParameter("addDateS")!=null){
			    if(where.length()>1)
				where=where+" AND ";
			    where=where+" driverStartDate>'"+request.getParameter("addDateS")+"' ";
			}
			if(request.getParameter("addDateE")!=null){
			    if(where.length()>1)
				where=where+" AND ";
			    where=where+" driverStartDate<'"+request.getParameter("addDateE")+"' ";
			}
		    }
		    if(request.getParameter("deleted")!=null){
			if(where.length()>1)
				where=where+" AND ";
			where=where+" driver_deleted=1";
			if(request.getParameter("delDateS")!=null){
			    if(where.length()>1)
				where=where+" AND ";
			    where=where+" driverEndDate>'"+request.getParameter("delDateS")+"' ";
			}
			if(request.getParameter("delDateE")!=null){
			    if(where.length()>1)
				where=where+" AND ";
			    where=where+" driverEndDate<'"+request.getParameter("delDateE")+"' ";
			}
		    }
		    System.out.println(where);
		    listDriver = wsql.listDriver(where);
		}
		else{
		    int showDeleted = Integer.parseInt(request.getParameter("deleted"));
		    listDriver = wsql.listDriver("driver_deleted="+showDeleted);
		}
                Iterator<Map.Entry<String, Map>> entries = listDriver.entrySet().iterator();
                out.println("<div class='scrollingBlock'>");
                out.println("<thead><tr><td>"
			+ "<input type='checkbox' name='allCh' value='allCh'>"
				+ "</td><td>Фамилия</td><td>Имя</td><td>Номер</td><td>Марка</td><td>Телефон</td>");
                out.println(colsBalance+"<td class='noPrint'></td></tr></thead>");
                while (entries.hasNext()) {
                    Map.Entry<String, Map> entry = entries.next();
                    Map<String, String> draverData = entry.getValue();
                    String day_off="";
                    if(draverData.get("dayOff")==null || draverData.get("dayOff").equals("1"))
                        day_off="<div class='dayOff'>Выходной</div>";
                    else
                        day_off="<div class='wrkDay'>Работает</div>";
                    String colorRow = "green";
                    if(Double.parseDouble((String) draverData.get("driver_current_debt"))<0.0)
                        colorRow="yellow";
                    if(Double.parseDouble((String) draverData.get("driver_current_debt"))<Integer.parseInt((String) draverData.get("driver_limit")))
                        colorRow="red";
                    if(showBalance)
                        colsBalance="<td><div class="+colorRow+" onClick='takePay("+entry.getKey()+")'>"+draverData.get("driver_current_debt")+"</div></td>"
                            + "<td>"+draverData.get("driver_deposit")+"</td>";
                    else
                        colsBalance="";
                    String report = "";
		    
                    if(showBalance)
                        report="<td><div class='reportButt' onClick='getReport("+entry.getKey()+")'>отчет</div></td>";
                    out.println("<tr>"
			    +"<td><input type='checkbox' name='"+entry.getKey()+"' value='"+entry.getKey()+"'></td>"
                            + "<td ondblclick='editDriver("+entry.getKey()+")' class='clickable' id='listDriverFirstName"+entry.getKey()+"'>"+draverData.get("driver_lastname")+"</td>"
                            + "<td id='listDriverLastName"+entry.getKey()+"'>"+draverData.get("driver_firstname")+"</td>"
                            /*+ "<td id='listDriverCarNamber"+entry.getKey()+"'>"+draverData.get("driver_carnumber")+"</td>"*/
                            + "<td id='listDriverCarNamber"+entry.getKey()+"'>"+draverData.get("id_car")+"</td>"
                            + "<td>"+draverData.get("modelName")+"</td>"
                            + "<td class='phoneInList'>"+draverData.get("driver_phone_number")+"</td>"
                            /*+ "<td>"+draverData.get("modelName")+"</td>"*/
                            + colsBalance     
                            + "<td class='wrkday noPrint'>"+day_off+"</td>"
                            + report
                                    + "<td class='docsCol' driverId='"+entry.getKey()+"' >");  //driverId='"+entry.getKey()+"'
                    if(draverData.get("haveBill").equals("2"))
                        out.println("<img src='img/docs.png' alt='' title='"+draverData.get("lastbill")+"'/></td></tr>");
                    else if(draverData.get("haveBill").equals("0"))
                        out.println("<img src='img/doc1.png' alt='' title='"+draverData.get("lastbill")+"'/></td></tr>");
                    else if(draverData.get("haveBill").equals("1"))
                        out.println("<img src='img/doc2.png' alt='' title='"+draverData.get("lastbill")+"'/></td></tr>");
                }
                out.println("</table></div>");
                
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
        } catch (ParseException ex) {
            Logger.getLogger(ListDriver.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NamingException ex) {
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
        } catch (ParseException ex) {
            Logger.getLogger(ListDriver.class.getName()).log(Level.SEVERE, null, ex);
        } catch (NamingException ex) {
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
