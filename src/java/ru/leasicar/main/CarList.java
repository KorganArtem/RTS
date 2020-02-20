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
 * @author korgan
 */
@WebServlet(name = "CarList", urlPatterns = {"/CL"})
public class CarList extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            AccessControl ac = null;
	    try {
		ac = new AccessControl();
	    } catch (NamingException ex) {
		Logger.getLogger(CarList.class.getName()).log(Level.SEVERE, null, ex);
	    }
            if(ac.isLogIn(request.getSession().getId())){
                    out.println("<input type='button' value='Добавить машину' onClick='addCarNew()'/>");
                    out.println("<table id='carListTabel' class='listDriver'>");
                    ///////////////////////////////////////////////////////////////
                    boolean delete = ac.checkPermission(ac.getUserId(request.getSession().getId()), "deletDriver");
                    String colDel="";
                    if(delete)
                        colDel="<td></td>";
                    ///////////////////////////////////////////////////////////////
                    CarSQL wsql = new CarSQL();
                    Map carList = wsql.carList();
                    Iterator<Map.Entry<String, Map>> entries = carList.entrySet().iterator();
                    out.println("<thead><tr><td>Гос. Номер</td><td>Модель</td><td>VIN</td><td>Год выпуска</td>"
                            + "<td>КПП</td><td>СТС</td><td>Собственник</td><td>Время</td><td>Статус</td><td></td></tr></thead>");
                    while (entries.hasNext()) {
                        Map.Entry<String, Map> entry = entries.next();
                        Map carData = entry.getValue();
                        out.println("<tr ><td class='edit' onClick='editShow("+carData.get("id")+")'>"+
                                carData.get("number")+"</td>");
                        
                        ////////////////////////// Model ///////////////////////
                        out.println("<td>"+carData.get("modelName")+"</td>");
                        out.println("<td>"+carData.get("VIN")+"</td>"+
                                        "<td>"+carData.get("year")+"</td>");
                        ////////////////////////////////////////////////////////
                        
                        ////////////////////////// Transmission ////////////////
                        if(carData.get("transmission")!=null){
                            switch(carData.get("transmission").toString()){
                                case "1": 
                                    out.println("<td>МКПП</td>");
                                    break;
                                case "2": 
                                    out.println("<td>АКПП</td>");
                                    break;
                            }
                        }
                        else 
                            out.println("<td>Not</td>");
                        ////////////////////////////////////////////////////////
                        
                        /*
                        rowDriver.put("ttoEndDate", rs.getString("ttoEndDate"));
            rowDriver.put("licEndDate", rs.getString("licEndDate"));
            rowDriver.put("insuranceDateEnd", rs.getString("insuranceDateEnd"));
                        
                        */
                        String comment ="";
                        long nowDate = new Date().getTime();
                        boolean ttoEnded = false;
                        if(carData.get("ttoEndDate")!=null){
                            Date ttoEndDate=new SimpleDateFormat("yyyy-MM-dd").parse(carData.get("ttoEndDate").toString());
                            if(ttoEndDate.getTime() < nowDate){
                                ttoEnded = true;
                                comment = comment+"Талон техосмотра просрочен "+carData.get("ttoEndDate")+"&#013;";
                            }
                        }
                        boolean insuranceEnded = false;
                        if(carData.get("insuranceDateEnd")!=null){
                            Date insuranceDateEnd=new SimpleDateFormat("yyyy-MM-dd").parse(carData.get("insuranceDateEnd").toString()); 
                            if(insuranceDateEnd.getTime() < nowDate){
                                insuranceEnded = true;
                                comment = comment+"Страховой полис просрочен "+carData.get("insuranceDateEnd")+"&#013;";
                            }
                        }
                        boolean licEnded = false;
                        if(carData.get("licEndDate")!=null){
                            Date licEndDate=new SimpleDateFormat("yyyy-MM-dd").parse(carData.get("licEndDate").toString());  
                            if(licEndDate.getTime() < nowDate){
                                licEnded = true;
                                comment = comment+"Лицензия просрочена "+carData.get("licEndDate")+"&#013;";
                            }
                        }
                        
                        boolean ttoNearEnd = false;
                        if(carData.get("ttoEndDate")!=null){
                            Date ttoEndDate=new SimpleDateFormat("yyyy-MM-dd").parse(carData.get("ttoEndDate").toString());
                            if(ttoEndDate.getTime() < nowDate+60*60*24*7*1000&&ttoEndDate.getTime()>nowDate){
                                ttoNearEnd = true;
                                comment = comment+"Талон техосмотра  скоро закончится "+carData.get("ttoEndDate")+"&#013;";
                            }
                        }
                        boolean insuranceNearEnd = false;
                        if(carData.get("insuranceDateEnd")!=null){
                            Date insuranceDateEnd=new SimpleDateFormat("yyyy-MM-dd").parse(carData.get("insuranceDateEnd").toString()); 
                            if(insuranceDateEnd.getTime() < nowDate+60*60*24*7*1000&&insuranceDateEnd.getTime()>nowDate){
                                insuranceEnded = true;
                                comment = comment+"Страховой полис скоро закончится "+carData.get("insuranceDateEnd")+"&#013;";
                            }
                        }
                        boolean licNearEnd = false;
                        if(carData.get("licEndDate")!=null){
                            Date licEndDate=new SimpleDateFormat("yyyy-MM-dd").parse(carData.get("licEndDate").toString());  
                            if(licEndDate.getTime() < nowDate+60*60*24*7*1000&&licEndDate.getTime()>nowDate){
                                licEnded = true;
                                comment = comment+"Лицензия  скоро закончится "+carData.get("licEndDate")+"&#013;";
                            }
                        }
                        
                        
                        String docStateImgPath="img/ok.png";
                        if(licNearEnd||insuranceNearEnd||ttoNearEnd){
                            docStateImgPath="img/alert.png";
                        }
                        if(licEnded||insuranceEnded||ttoEnded){
                            docStateImgPath="img/down.png";
                        }
                        out.println("<td>"+carData.get("sts")+"</td>");
                        out.println("<td>"+carData.get("companyName")+"</td>");
                        out.println("<td>"+carData.get("outTime")+"</td>");
                        out.println("<td>"+carData.get("carStateName")+"</td>");
                        out.println("<td><img class='alertImg' src='"+docStateImgPath+"' title='"+comment+"'/></td></tr>");
                    }
                    out.println("</table>");
                }
            else{
                System.out.println("Go to login Page!");
                request.getRequestDispatcher("/").forward(request, response);
                return;
            }
        } catch (NamingException ex) {
	    Logger.getLogger(CarList.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(CarList.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(CarList.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ParseException ex) {
            Logger.getLogger(CarList.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(CarList.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(CarList.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ParseException ex) {
            Logger.getLogger(CarList.class.getName()).log(Level.SEVERE, null, ex);
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
