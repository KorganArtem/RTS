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
import java.text.SimpleDateFormat;
import java.util.Date;
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
import ru.leasicar.workerSql.CarSQL;

/**
 *
 * @author Artem
 */
@WebServlet(name = "Alarmer", urlPatterns = {"/Alarmer"})
public class Alarmer extends HttpServlet {

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
            throws ServletException, IOException, ClassNotFoundException, SQLException, ParseException {
	try {
	    response.setContentType("text/html;charset=UTF-8");
	    AccessControl ac = new AccessControl();
	    if(ac.isLogIn(request.getSession().getId())){
		try (PrintWriter out = response.getWriter()) {
		    CarSQL csql = new CarSQL();
		    Map<Integer, Map> carAlert = csql.gerCarAlert();
		    if(request.getParameter("show").equals("1")){
			Iterator<Map.Entry<Integer, Map>> entries = carAlert.entrySet().iterator();
			out.println("<table class='alertList'><thead><tr><td>Гос. Номер</td><td>Страховка</td><td>Лиц</td><td>ТТО</td>"
				+ "<td>ТО</td></tr></thead>");
			while (entries.hasNext()) {
			    Map.Entry<Integer, Map> entry = entries.next();
			    Map carAlertRow = entry.getValue();
			    out.println("<tr >"
				    + "<td onclick='editShow("+entry.getKey()+")'>"+carAlertRow.get("number")+"</td>"
					    + "<td>"+carAlertRow.get("insuranceDateEnd")+"</td>"
						    + "<td>"+carAlertRow.get("licEndDate")+"</td>"
							    + "<td>"+carAlertRow.get("ttoEndDate")+"</td>"
								    + "<td>"+carAlertRow.get("aftTO")+"</td>"
									    + "</tr>");
//                        long nowDate = new Date().getTime();
//                        if(carAlertRow.get("ttoEndDate")!=null){
//                            Date ttoEndDate=new SimpleDateFormat("yyyy-MM-dd").parse(carAlertRow.get("ttoEndDate").toString());
//                            if(ttoEndDate.getTime() < nowDate+60*60*24*7*1000&&ttoEndDate.getTime()>nowDate){
//                                out.println(carAlertRow.get("number")+" Талон техосмотра просрочен "+carAlertRow.get("ttoEndDate")+"<br>");
//                            }
//                        }
//                        if(carAlertRow.get("insuranceDateEnd")!=null){
//                            Date insuranceDateEnd=new SimpleDateFormat("yyyy-MM-dd").parse(carAlertRow.get("insuranceDateEnd").toString()); 
//                            if(insuranceDateEnd.getTime() < nowDate+60*60*24*7*1000&&insuranceDateEnd.getTime()>nowDate){
//                                out.println(carAlertRow.get("number")+"Страховой полис просрочен "+carAlertRow.get("insuranceDateEnd")+"<br>");
//                            }
//                        }
//                        if(carAlertRow.get("licEndDate")!=null){
//                            Date licEndDate=new SimpleDateFormat("yyyy-MM-dd").parse(carAlertRow.get("licEndDate").toString());  
//                            if(licEndDate.getTime() < nowDate+60*60*24*7*1000&&licEndDate.getTime()>nowDate){
//                                out.println(carAlertRow.get("number")+"Лицензия просрочена "+carAlertRow.get("licEndDate")+"<br>");
//                            }
//                        }
//
			}
			out.println("</table>");
		    }
		    else
			out.println(carAlert.size());
		}
	    }
	} catch (NamingException ex) {
	    Logger.getLogger(Alarmer.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(Alarmer.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(Alarmer.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ParseException ex) {
            Logger.getLogger(Alarmer.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(Alarmer.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(Alarmer.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ParseException ex) {
            Logger.getLogger(Alarmer.class.getName()).log(Level.SEVERE, null, ex);
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
