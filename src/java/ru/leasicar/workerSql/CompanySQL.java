/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ru.leasicar.workerSql;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

/**
 *
 * @author korgan
 */
public class CompanySQL {
    DataSource ds;
    public CompanySQL() throws ClassNotFoundException, SQLException, NamingException{
        InitialContext initContext= new InitialContext();
	ds = (DataSource) initContext.lookup("java:comp/env/jdbc/dbconnect");
    }
    public String getCompanyListSelect(int companyId) throws SQLException{
	String forRet;
	try (Connection con = ds.getConnection()) {
	    forRet = "";
	    Statement st = con.createStatement();
	    ResultSet rs = st.executeQuery("SELECT * FROM companies");
	    String selected = "";
	    while(rs.next()){
		if(companyId==rs.getInt("companyId"))
		    selected="selected";
		forRet = forRet + "<option "+selected+" value='"+rs.getString("companyId")+"'>"+rs.getString("name")+"</option>";
		selected="";
	    }   rs.close();
	    st.close();
	    con.close();
	}
        return forRet;
    }
        public Map getCompanyList() throws SQLException{
	    Map<Integer, Map> companyList = new HashMap();
	try (Connection con = ds.getConnection()) {
	    Statement st = con.createStatement();
	    ResultSet rs = st.executeQuery("SELECT * FROM companies");
	    while(rs.next()){
		Map<String, String> row = new HashMap();
		row.put("inn", rs.getString("inn"));
		row.put("kpp", rs.getString("kpp"));
		row.put("name", rs.getString("name"));
		row.put("address", rs.getString("address"));
		row.put("phone", rs.getString("phone"));
		companyList.put(rs.getInt("companyId"), row);
	    }
	    rs.close();
	    st.close();
	    con.close();
	}
	    return companyList;
    } 
	public void delCompany(String compId){
	try (Connection con = ds.getConnection()) {
	    Statement st = con.createStatement();
	    st.execute("DELETE FROM companies WHERE companyId="+compId);
	    con.close();
	}
	catch(SQLException ex){
	    Logger.getLogger(CompanySQL.class.getName()).log(Level.SEVERE, null, ex);
	}
    } 
    public void saveCompany(Map companyData) throws SQLException{
	try (Connection con = ds.getConnection()) {
	    Statement st = con.createStatement();
	    String idStr="";
	    if(!companyData.get("ID").equals("0"))
		idStr="companyId='"+companyData.get("ID")+"',";
	    String query = "INSERT INTO companies "
		    + "SET  "+idStr
		    + "inn='"+companyData.get("inn")+"', "
		    + "kpp='"+companyData.get("kpp")+"', "
		    + "name='"+companyData.get("name")+"', "
		    + "address='"+companyData.get("address")+"', "
		    + "phone='"+companyData.get("phone")+"' "
		    + " ON DUPLICATE KEY UPDATE "
		    + "inn='"+companyData.get("inn")+"', "
		    + "kpp='"+companyData.get("kpp")+"', "
		    + "name='"+companyData.get("name")+"', "
		    + "address='"+companyData.get("address")+"', "
		    + "phone='"+companyData.get("phone")+"' ";
	    st.execute(query);
	    st.close();
	    con.close();
	}
    }
    public String getServiceManList() throws SQLException{
	String forRet;
	try (Connection con = ds.getConnection()) {
	    forRet = "";
	    Statement st = con.createStatement();
	    ResultSet rs = st.executeQuery("SELECT * FROM users WHERE serviceMan>0");
	    String selected = "";
	    while(rs.next()){
		if(rs.getInt("serviceMan")==2)
		    selected="selected";
		forRet = forRet + "<option "+selected+" value='"+rs.getString("id")+"'>"+rs.getString("ful_name")+"</option>";
		selected="";
	    }   System.out.println(forRet);
	    rs.close();
	    st.close();
	    con.close();
	}
        return forRet;
    }
    public Map<String, String> getCompanyData(int companyId) throws SQLException{
	Map<String, String> companyData;
	try (Connection con = ds.getConnection()) {
	    companyData = new HashMap<String, String>();
	    Statement st = con.createStatement();
	    ResultSet rs = st.executeQuery("SELECT * FROM companies WHERE companyId="+companyId);
	    if(rs.next()){
		companyData.put("inn", rs.getString("inn"));
		companyData.put("kpp", rs.getString("kpp"));
		companyData.put("name", rs.getString("name"));
		companyData.put("address", rs.getString("address"));
		companyData.put("phone", rs.getString("phone"));
	    }   rs.close();
	    st.close();
	    con.close();
	}
        return companyData;
    }
    public String getCompanyName(int companyId) throws SQLException{
	String companyName;
	try (Connection con = ds.getConnection()) {
	    Map<String, String> companyData = new HashMap<String, String>();
	    companyName = "";
	    Statement st = con.createStatement();
	    ResultSet rs = st.executeQuery("SELECT * FROM companies WHERE companyId="+companyId);
	    if(rs.next()){
		companyName = rs.getString("name");
	    }   rs.close();
	    st.close();
	    con.close();
	}
        return companyName;
    }
}
