/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ru.leasicar.workerSql;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

/**
 *
 * @author Artem
 */
public class WayBillSQL {
    DataSource ds;
    public WayBillSQL() throws ClassNotFoundException, SQLException, NamingException{
        InitialContext initContext= new InitialContext();
	ds = (DataSource) initContext.lookup("java:comp/env/jdbc/dbconnect");
    }
    public int writeWayBill(int driverId, int carId, int companyId, Date date, String docNum, 
            double bodyTemp, String bloodPressure, int pulse){
	
	try {
	    Connection con = ds.getConnection();
	    DateFormat formatOut = new SimpleDateFormat("yyyy-MM-dd");
	    String date1 = formatOut.format(date.getTime());
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
	    con.close();
	    return id;
	} catch (SQLException ex) {
	    Logger.getLogger(WayBillSQL.class.getName()).log(Level.SEVERE, null, ex);
	}
	return 0;
    }
    public Map<Integer, Map> getWayBillTabel(String dateStart, String dateEnd, int companyId, int driverId, boolean rejectDuble) throws SQLException{
        
	Connection con = ds.getConnection();
	Statement st = con.createStatement();
        String where = "WHERE companyId="+companyId+" ";
        if(dateStart!=null)
            where=where+" AND waybillsDate>'"+dateStart+"' ";
        if(dateEnd!=null)
            where=where+" AND waybillsDate<'"+dateEnd+"' ";
	if(driverId!=0)
	    where=where+" AND drivers.driver_id="+driverId+" ";
        String query = "SELECT concat(DATE_FORMAT(waybillsDate,'%y%m%d'), SUBSTRING(waybills.carId+1000, 3, 2)) as docNumE, waybills.wayBillsId,  waybills.carId as carIdO, "
                + "waybills.waybillsDate,     waybills.millage, waybills.docNum as docNumInBill, drivers.driver_lastname,  drivers.driver_firstname, "
                + "drivers.driver_midName, waybills.driverId,   CONCAT(cars.number, cars.regGosNumber) as number, cars.model, TIME_FORMAT(cars.outTime, '%H-%i') as outTime, "
                + "drivers.driver_bornDate, drivers.sex, waybills.temperature, waybills.bloodPressure, waybills.pulse,  "
                + "DATE_ADD(waybills.waybillsDate, INTERVAL 1 DAY) as endDate FROM waybills  INNER JOIN drivers   "
                + "ON drivers.driver_id=waybills.driverId   inner JOIN cars  ON cars.id=waybills.carId "+where+" ORDER BY waybillsDate, outTime, wayBillsId DESC";
        
        
        //System.out.println(query);
        ResultSet rsGetWayBill  = st.executeQuery(query);
        Map<Integer, Map> wayBillsList = new HashMap<Integer, Map>();
        int counter = 1;
	int lastDrierId = 0; 
	int lastCarId = 0; 
        while(rsGetWayBill.next()){
            Map<String, String> wayBillData = new HashMap<String, String>();
	    if(rejectDuble){
		if(lastDrierId==rsGetWayBill.getInt("driverId"))
		    continue;
		if(lastCarId==rsGetWayBill.getInt("carIdO"))
		    continue;
	    }
	    lastDrierId=rsGetWayBill.getInt("driverId");
	    lastCarId=rsGetWayBill.getInt("carIdO");
            wayBillData.put("docNum", rsGetWayBill.getString("docNumE"));
            wayBillData.put("millage", rsGetWayBill.getString("millage"));
            wayBillData.put("model", rsGetWayBill.getString("model"));
	    wayBillData.put("carId", rsGetWayBill.getString("carIdO"));
            wayBillData.put("wayBillsId", rsGetWayBill.getString("wayBillsId"));
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
            wayBillData.put("endDate", rsGetWayBill.getString("endDate"));
//            if(rsGetWayBill.getString("outTime").equals("00-00")){
//                wayBillData.put("outTime", "");
//		continue;
//	    }
//            else
//                wayBillData.put("outTime", rsGetWayBill.getString("outTime"));
	    
	    //System.out.println(rsGetWayBill.getString("driver_lastname"));
            wayBillsList.put(counter, wayBillData);
            counter++;	    
        }
        rsGetWayBill.close();
        st.close();
	con.close();
        return wayBillsList;
    }
    
    
    
    /////////
    public void allCarInRep() throws SQLException{
	Connection con = ds.getConnection();
	Statement st = con.createStatement();
	ResultSet rs = st.executeQuery("SELECT * FROM waybills GROUP BY carId");
	while(rs.next()){
	    int lastMill = getLastMill(rs.getString("carId"));
	    
	    //System.out.println(rs.getString("carId")+ "  " + lastMill*-1);
	    rander(lastMill*-1, rs.getString("carId"));
	}
	rs.close();
	st.close();
	con.close();
    }
    private int getLastMill(String carId) throws SQLException{
	Connection con = ds.getConnection();
	Statement st = con.createStatement();
	ResultSet rs = st.executeQuery("SELECT * FROM cars WHERE `id`="+carId);
	int mill = 0;
	if(rs.next()){
	    mill=rs.getInt("carMileage");
	}
	rs.close();
	st.close();
	con.close();
	return mill;
    }
    private void rander(int mill, String carId) throws SQLException{
	Connection con = ds.getConnection();
	Statement st = con.createStatement();
	Statement st111 = con.createStatement();
	ResultSet rs = st.executeQuery("SELECT * FROM waybills WHERE `carId`="+carId+" ORDER BY wayBillsId DESC");
	int currentMill = mill;
	Random rd = new Random();
	while(rs.next()){
	    currentMill=currentMill-150+rd.nextInt(150);
	    //System.out.println(rs.getString("wayBillsId")+" "+currentMill);
	    st111.execute("UPDATE waybills SET millage="+currentMill+"  WHERE  wayBillsId="+rs.getString("wayBillsId"));
	}
	rs.close();
	st.close();
	con.close();
    }
}
