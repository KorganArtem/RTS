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

/**
 *
 * @author korgan
 */
public class CompanySQL {
    
    public String url;
    public String login;
    public String pass;
    public Connection con;
    Map config;
    boolean iscon;
    public CompanySQL() throws ClassNotFoundException, SQLException{
        ConfigurationReader cr = new ConfigurationReader();
        config=cr.readFile();
        url="jdbc:mysql://"+config.get("dbhost")+":"+config.get("dbport")+"/"+config.get("dbname")+"?useUnicode=true&characterEncoding=UTF-8";
        try
        {
            Class.forName("com.mysql.jdbc.Driver"); 
            login=config.get("dbuser").toString();
            pass=config.get("dbpassword").toString();
            con = DriverManager.getConnection(url, login, pass);
            iscon = true;
        }
        catch(SQLException ex)
        {
            System.out.println("Mysql ERROR: "+ex.getMessage());
        }
    }
    public String getCompanyListSelect(int companyId) throws SQLException{
        String forRet = "";
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery("SELECT * FROM companies");
        String selected = "";
        while(rs.next()){
            if(companyId==rs.getInt("companyId"))
                selected="selected";
            forRet = forRet + "<option "+selected+" value='"+rs.getString("companyId")+"'>"+rs.getString("name")+"</option>";
            selected="";
        }
        System.out.println(forRet);
        rs.close();
        st.close();
        return forRet;
    }
    public Map<String, String> getCompanyData(int companyId) throws SQLException{
        Map<String, String> companyData = new HashMap<String, String>();
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery("SELECT * FROM companies WHERE companyId="+companyId);
        if(rs.next()){
            companyData.put("inn", rs.getString("inn"));
            companyData.put("kpp", rs.getString("kpp"));
            companyData.put("name", rs.getString("name"));
            companyData.put("address", rs.getString("address"));
            companyData.put("phone", rs.getString("phone"));
        }
        rs.close();
        st.close();
        return companyData;
    }
    public String getCompanyName(int companyId) throws SQLException{
        Map<String, String> companyData = new HashMap<String, String>();
        String companyName = "";
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery("SELECT * FROM companies WHERE companyId="+companyId);
        if(rs.next()){
           companyName = rs.getString("name");
        }
        rs.close();
        st.close();
        return companyName;
    }
}
