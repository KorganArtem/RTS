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
import java.util.HashMap;
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
    public int writeWayBill(int driverId, int carId, int companyId, Date date, String docNum, 
            double bodyTemp, String bloodPressure, int pulse) throws SQLException{
        DateFormat formatOut = new SimpleDateFormat("yyyy-MM-dd");
        String date1 = formatOut.format(date.getTime());
        System.out.println(date1);
        String query = "INSERT INTO `waybills` SET `waybillsDate`='"+date1+"', "
                + "driverId="+driverId+", "
                + "carId="+carId+", "
                + "docNum="+docNum+", "
                + "companyId="+companyId+", "
                + "temperature="+bodyTemp+", "
                + "bloodPressure='"+bloodPressure+"', "
                + "pulse="+pulse;
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
    public Map<Integer, Map> getWayBillTabel(String dateStart, String dateEnd, int companyId) throws SQLException{
        Statement st = con.createStatement();
        String where = "WHERE companyId="+companyId+" ";
        if(dateStart!=null)
            where=where+" AND waybillsDate>'"+dateStart+"' ";
        if(dateEnd!=null)
            where=where+" AND waybillsDate<'"+dateEnd+"' ";
        /*String query = "SELECT concat(date_format(waybills.waybillsDate, '%y%m%d'), SUBSTRING(waybills.carId+1000, 2, 3)) as docNum, "
                + "waybills.waybillsDate, waybills.docNum as docNumInBill, drivers.driver_lastname,"
                + "drivers.driver_firstname, drivers.driver_midName, waybills.driverId, "
                + "cars.number,  DATE_ADD(waybills.waybillsDate, INTERVAL 1 DAY) as endDate FROM waybills "
                + "INNER JOIN drivers "
                + "ON drivers.driver_id=waybills.driverId "
                + "inner JOIN cars "
                + "ON cars.id=waybills.carId "+where+" ORDER BY docNum ";*/
        //String query = "SELECT concat(date_format(waybills.waybillsDate, '%y%m%d'), SUBSTRING(waybills.carId+1000, 2, 3)) as docNum,   waybills.waybillsDate, waybills.docNum as docNumInBill, drivers.driver_lastname,  drivers.driver_firstname, drivers.driver_midName, waybills.driverId,   cars.number, TIME_FORMAT(cars.outTime, '%H-%i') as outTime, drivers.driver_bornDate, drivers.sex, waybills.temperature, waybills.bloodPressure, waybills.pulse,  DATE_ADD(waybills.waybillsDate, INTERVAL 1 DAY) as endDate FROM waybills  INNER JOIN drivers   ON drivers.driver_id=waybills.driverId   inner JOIN cars  ON cars.id=waybills.carId "+where+" ORDER BY docNum ";
        String query = "SELECT concat(SUBSTRING(waybills.docNum, 1, 6), SUBSTRING(waybills.carId+1000, 3, 2)) as docNum,   "
                + "waybills.waybillsDate, waybills.docNum as docNumInBill, drivers.driver_lastname,  drivers.driver_firstname, "
                + "drivers.driver_midName, waybills.driverId,   CONCAT(cars.number, cars.regGosNumber) as number, TIME_FORMAT(cars.outTime, '%H-%i') as outTime, "
                + "drivers.driver_bornDate, drivers.sex, waybills.temperature, waybills.bloodPressure, waybills.pulse,  "
                + "DATE_ADD(waybills.waybillsDate, INTERVAL 1 DAY) as endDate FROM waybills  INNER JOIN drivers   "
                + "ON drivers.driver_id=waybills.driverId   inner JOIN cars  ON cars.id=waybills.carId "+where+" ORDER BY waybillsDate, outTime ";
        
        
        System.out.println(query);
        ResultSet rsGetWayBill  = st.executeQuery(query);
        Map<Integer, Map> wayBillsList = new HashMap<Integer, Map>();
        int counter = 1;
        while(rsGetWayBill.next()){
            Map<String, String> wayBillData = new HashMap<String, String>();
            wayBillData.put("docNum", rsGetWayBill.getString("docNum"));
            wayBillData.put("docNumInBill", rsGetWayBill.getString("docNumInBill"));
            wayBillData.put("waybillsDate", rsGetWayBill.getString("waybillsDate"));
            wayBillData.put("driver_lastname", rsGetWayBill.getString("driver_lastname"));
            wayBillData.put("driver_firstname", rsGetWayBill.getString("driver_firstname"));
            wayBillData.put("driver_midName", rsGetWayBill.getString("driver_midName"));
            wayBillData.put("driverId", rsGetWayBill.getString("driverId"));
            wayBillData.put("number", rsGetWayBill.getString("number"));
            wayBillData.put("driver_bornDate", rsGetWayBill.getString("driver_bornDate"));
            wayBillData.put("sex", rsGetWayBill.getString("sex"));
            wayBillData.put("temperature", rsGetWayBill.getString("temperature"));
            wayBillData.put("bloodPressure", rsGetWayBill.getString("bloodPressure"));
            wayBillData.put("pulse", rsGetWayBill.getString("pulse"));
            wayBillData.put("endDate", rsGetWayBill.getString("endDate"));
            if(rsGetWayBill.getString("outTime").equals("00-00"))
                wayBillData.put("outTime", "");
            else
                wayBillData.put("outTime", rsGetWayBill.getString("outTime"));
            wayBillsList.put(counter, wayBillData);
            counter++;
        }
        return wayBillsList;
    }
}
