/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ru.leasycar.company;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import ru.leasicar.workerSql.CompanySQL;

/**
 *
 * @author Artem
 */
@WebServlet(name = "SaveCompany", urlPatterns = {"/SaveCompany"})
public class SaveCompany extends HttpServlet {

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
	    throws ServletException, IOException {
	response.setContentType("text/html;charset=UTF-8");
	try (PrintWriter out = response.getWriter()) {
	    /* TODO output your page here. You may use following sample code. */
	    if(request.getParameter("del")!=null){
		try{
		    CompanySQL csql = new CompanySQL();
		    csql.delCompany(request.getParameter("ID"));
		}
		catch(Exception ex){
		    System.out.println("Error when write company"+ex.getMessage());
		}
		System.out.println("I WILL DEL COMPANY "+request.getParameter("ID"));
	    }
	    else{
		Map<String, String> company = new HashMap();
		company.put("ID",	request.getParameter("ID"));
		company.put("inn",	request.getParameter("inpINN"));
		company.put("kpp",	request.getParameter("inpKPP"));
		company.put("name",	request.getParameter("inpNAME"));
		company.put("address", request.getParameter("inpADDRESS"));
		company.put("phone", request.getParameter("inpPhone"));
		try{
		    CompanySQL csql = new CompanySQL();
		    csql.saveCompany(company);
		}
		catch(Exception ex){
		    System.out.println("Error when write company"+ex.getMessage());
		}
	    }
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
	processRequest(request, response);
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
	processRequest(request, response);
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
