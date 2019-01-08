/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ru.leasicar.workerSql;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

/**
 *
 * @author Artem
 */
public class WayBillSQL {
     public String url;
    public String login;
    public String pass;
    public Connection con;
    Map config;
    boolean iscon;
    public WayBillSQL() throws ClassNotFoundException, SQLException{
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
    public int writeWayBill(int driverId, int carId, int companyId, Date date, String docNum) throws SQLException{
        DateFormat formatOut = new SimpleDateFormat("yyyy-MM-dd");
        String date1 = formatOut.format(date.getTime());
        System.out.println(date1);
        String query = "INSERT INTO `waybills` SET `waybillsDate`='"+date1+"', "
                + "driverId="+driverId+", "
                + "carId="+carId+", "
                + "docNum="+docNum+", "
                + "companyId="+companyId;
        int id = 0;
        PreparedStatement ps = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
        //ps.setString(1,"Neeraj");
            
            ps.executeUpdate();
            ResultSet rs=ps.getGeneratedKeys();
            
            if(rs.next()){
                id = rs.getInt(1);
            }
            rs.close();
            ps.close();
            return id;
    }
    public Map<String, Map> getWayBillTabel(String dateStrt, String dateEnd) throws SQLException{
        Statement st = con.createStatement();
        ResultSet rsGetWayBil  = st.executeQuery("SELECT * FROM wayBills");
        return null;
    }
}
