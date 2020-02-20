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
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import ru.leasicar.authorization.AccessControl;
import ru.leasicar.workerSql.CarSQL;
import ru.leasicar.workerSql.DriverSQL;

/**
 *
 * @author Artem
 */
@WebServlet(name = "CarAddSend", urlPatterns = {"/CAS"})
public class CarAddSend extends HttpServlet {

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
        
        try {
	    
	    AccessControl ac = new AccessControl();
	    if(!ac.isLogIn(request.getSession().getId()))
		return;
	    int userId = ac.getUserId(request.getSession().getId());
	    try (PrintWriter out = response.getWriter()) {
		Map<String, String[]> param = new HashMap<>();
		param = request.getParameterMap();
		Map<String, String> mapToSQL = new HashMap<>();
		for (Map.Entry<String, String[]> entry : param.entrySet()) {
		    mapToSQL.put(entry.getKey(), entry.getValue()[0]);
		}
		
		CarSQL wrk = new CarSQL();
		int carId=0;
		try{
		    carId = Integer.parseInt(request.getParameter("carId"));
		}
		catch(Exception ex){
		    System.out.println("Car ID is not Integer!");
		}
		if(carId!=0){
		    wrk.writeCarData(mapToSQL);
		}
		else{
		    carId = wrk.addCar(mapToSQL);
		    wrk.changeCarState(0, carId, Integer.parseInt(request.getParameter("carState")));
		    return;
		}
		if(!request.getParameter("carState").equals(request.getParameter("oldState"))){
		    System.out.println("State was changed!");
		    DriverSQL dsql = new DriverSQL();
		    wrk.changeCarState(dsql.getDriverIdbyCar(carId), carId, Integer.parseInt(request.getParameter("carState")));
		}
		out.print(0);
	    }
	    catch(Exception ex){
		System.out.println(ex);
	    }
	}
        catch(NamingException ex){
            Logger.getLogger(CarAddSend.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(CarAddSend.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(CarAddSend.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(CarAddSend.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(CarAddSend.class.getName()).log(Level.SEVERE, null, ex);
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
