/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ru.leasicar.main;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import ru.leasicar.workerSql.DriverSQL;

/**
 *
 * @author Artem
 */
@WebServlet(name = "AddDriverNew", urlPatterns = {"/AddDriverNew"})
public class AddDriverNew extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            DriverSQL dsql = new DriverSQL();
            Map<String, String> driverData = new HashMap();
	    int takeDep = 0;
	    if(request.getParameter("takeDep")!=null)
		takeDep=1;
            driverData.put("lastName",	request.getParameter("lastName"));
            driverData.put("firstName",	request.getParameter("firstName")); 
            driverData.put("midlName",	request.getParameter("midlName")); 
            driverData.put("mainPhone",	request.getParameter("mainPhone")); 
            driverData.put("addPhone",	request.getParameter("addPhone")); 
            driverData.put("email",	request.getParameter("email")); 
            driverData.put("bornDate",	request.getParameter("bornDate")); 
            driverData.put("addDate",	request.getParameter("addDate")); 
            driverData.put("delDate",	request.getParameter("delDate")); 
            driverData.put("passportNumber",	request.getParameter("passportNumber")); 
            driverData.put("passportDate",	request.getParameter("passportDate")); 
            driverData.put("passportFrom",	request.getParameter("passportFrom")); 
            driverData.put("country",	request.getParameter("country")); 
            driverData.put("province",	request.getParameter("province")); 
            driverData.put("city",	request.getParameter("city")); 
            driverData.put("strit",	request.getParameter("strit")); 
            driverData.put("house",	request.getParameter("house")); 
            driverData.put("building",	request.getParameter("building")); 
            driverData.put("flat",	request.getParameter("flat")); 
            driverData.put("postCode", request.getParameter("postCode"));
            driverData.put("car",	request.getParameter("car")); 
            driverData.put("shedule",	request.getParameter("shedule")); 
            driverData.put("dayRent",	request.getParameter("dayRent")); 
            driverData.put("debtLimit",	request.getParameter("debtLimit")); 
            driverData.put("comment",	request.getParameter("comment")); 
            driverData.put("addCountry", request.getParameter("addCountry"));
            driverData.put("addProvince", request.getParameter("addProvince"));//
            driverData.put("addCity", request.getParameter("addCity"));
            driverData.put("addStrit", request.getParameter("addStrit"));
            driverData.put("addHouse", request.getParameter("addHouse"));
            driverData.put("addBuilding", request.getParameter("addBuilding"));
            driverData.put("addFlat", request.getParameter("addFlat"));
            driverData.put("addPostCode", request.getParameter("addPostCode"));
            driverData.put("vyNumber", request.getParameter("vyNumber"));
            driverData.put("vyDate", request.getParameter("vyDate"));
            driverData.put("vyFrom", request.getParameter("vyFrom"));
            driverData.put("dopPay", takeDep+"");
            System.out.println(request.toString());
            dsql.writeDriver(driverData);
        }
	catch(Exception ex){
	    System.out.println("Error beach!!! "+ex.getMessage());
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
            Logger.getLogger(AddDriverNew.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(AddDriverNew.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(AddDriverNew.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(AddDriverNew.class.getName()).log(Level.SEVERE, null, ex);
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
