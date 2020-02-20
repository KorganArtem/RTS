    /*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ru.leasicar.workerSql;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Date;
import java.util.Map;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

/**
 *
 * @author korgan
 */
public class FineSQL {
    DataSource ds;
    public FineSQL() throws ClassNotFoundException, SQLException, NamingException{
        InitialContext initContext= new InitialContext();
	ds = (DataSource) initContext.lookup("java:comp/env/jdbc/dbconnect");
	
    }
    public JsonArray getAllFine() throws SQLException{
	Connection con = ds.getConnection();
        Statement fineListSt = con.createStatement();
	String query = "SELECT finecar.*, drivers.driver_lastname FROM drivers " +
                            "RIGHT JOIN (SELECT fine.*, cars.number as carNumber FROM fine  " +
                            "INNER JOIN cars " +
                            "ON fine.fineCar=cars.id " +
                            "WHERE fineState=0 ) as finecar " +
                            "ON finecar.driver_id=drivers.driver_id";
	System.out.println(query);
        ResultSet fineListRs = fineListSt.executeQuery(query);
        JsonArray fineList = new JsonArray();
        while(fineListRs.next()){
            JsonObject oneFine = new JsonObject();
            oneFine.addProperty("fineUis", fineListRs.getString("fineUis"));
            oneFine.addProperty("fineSum", fineListRs.getString("fineSum"));
            oneFine.addProperty("fineDate", fineListRs.getString("fineDate"));
            oneFine.addProperty("fineReason", fineListRs.getString("fineReason"));
            oneFine.addProperty("fineState", fineListRs.getString("fineState"));
            oneFine.addProperty("fineDatePay", fineListRs.getString("fineDatePay"));
            oneFine.addProperty("finePlace", fineListRs.getString("finePlace"));
            oneFine.addProperty("fineDescription", fineListRs.getString("fineDescription"));
            oneFine.addProperty("carNumber", fineListRs.getString("carNumber"));
            oneFine.addProperty("fineOffender", fineListRs.getString("fineOffender"));
            oneFine.addProperty("driver_lastname", fineListRs.getString("driver_lastname"));
            fineList.add(oneFine);
        }
        fineListRs.close();
        fineListSt.close();
	    con.close();
        return fineList;
    }
    public JsonArray getAllFineOG(boolean deleted) throws SQLException{
	Connection con = ds.getConnection();
        Statement fineListSt = con.createStatement();
	
	String where = " AND cars.state!=8 ";
	if(deleted){
	    where="";
	}
	String query = "SELECT finecar.*, CAST(finecar.gis_discount_uptodate AS char) as gis_discount_uptodate1, drivers.driver_lastname FROM drivers "
                + "RIGHT JOIN (SELECT `offenses`.*, cars.number as carNumber FROM `offenses`  " +
                "INNER JOIN cars \n" +
                "ON offenses.carId=cars.id \n" +
                "WHERE `gis_status`='nopayed' AND (bill_id like '188101%' OR bill_id like '188105%' OR bill_id like '035%') "+where+" ) as finecar\n" +
                "ON finecar.driverId=drivers.driver_id";
	System.out.println(query);
        ResultSet fineListRs = fineListSt.executeQuery(query);   //
        JsonArray fineList = new JsonArray();
        while(fineListRs.next()){
            JsonObject oneFine = new JsonObject();
            oneFine.addProperty("carNumber", fineListRs.getString("carNumber"));
            oneFine.addProperty("driver_lastname", fineListRs.getString("driver_lastname"));
            oneFine.addProperty("bill_id", fineListRs.getString("bill_id"));
            oneFine.addProperty("gis_status", fineListRs.getString("gis_status"));
            oneFine.addProperty("pay_bill_date", fineListRs.getString("pay_bill_date"));
            oneFine.addProperty("last_bill_date" , fineListRs.getString("last_bill_date"));
            oneFine.addProperty("pay_bill_amount", fineListRs.getString("pay_bill_amount"));
            oneFine.addProperty("gis_discount", fineListRs.getString("gis_discount"));
            oneFine.addProperty("gis_discount_uptodate", fineListRs.getString("gis_discount_uptodate1"));
            oneFine.addProperty("pay_bill_amount_with_discount", fineListRs.getString("pay_bill_amount_with_discount"));
            oneFine.addProperty("offense_location", fineListRs.getString("offense_location"));
            oneFine.addProperty("offense_article", fineListRs.getString("offense_article"));
            oneFine.addProperty("offense_date", fineListRs.getString("offense_date"));
            oneFine.addProperty("offense_time", fineListRs.getString("offense_time"));
            oneFine.addProperty("offense_article_number", fineListRs.getString("offense_article_number"));
            oneFine.addProperty("carId", fineListRs.getString("carId"));
            oneFine.addProperty("driverId", fineListRs.getString("driverId"));
            fineList.add(oneFine);
        }
        fineListRs.close();
        fineListSt.close();
	    con.close();
        return fineList;
    }
    public JsonObject getOneFine(String bill_id) throws SQLException{
	Connection con = ds.getConnection();
        Statement fineSt = con.createStatement();
        ResultSet fineRs = fineSt.executeQuery("SELECT finecar.*, drivers.driver_lastname , drivers.driver_firstname FROM drivers "
                + "RIGHT JOIN (SELECT `offenses`.*, cars.number as carNumber FROM `offenses`  " +
                "INNER JOIN cars \n" +
                "ON offenses.carId=cars.id \n" +
                "WHERE bill_id='"+bill_id+"') as finecar\n" +
                "ON finecar.driverId=drivers.driver_id");
        JsonObject oneFine = new JsonObject();
        if(fineRs.next()){
            oneFine.addProperty("carNumber", fineRs.getString("carNumber"));
            oneFine.addProperty("driver_lastname", fineRs.getString("driver_lastname"));
            oneFine.addProperty("driver_firstname", fineRs.getString("driver_firstname"));
            oneFine.addProperty("bill_id", fineRs.getString("bill_id"));
            oneFine.addProperty("gis_status", fineRs.getString("gis_status"));
            oneFine.addProperty("pay_bill_date", fineRs.getString("pay_bill_date"));
            oneFine.addProperty("last_bill_date" , fineRs.getString("last_bill_date"));
            oneFine.addProperty("pay_bill_amount", fineRs.getString("pay_bill_amount"));
            oneFine.addProperty("gis_discount", fineRs.getString("gis_discount"));
            oneFine.addProperty("gis_discount_uptodate", fineRs.getString("gis_discount_uptodate"));
            oneFine.addProperty("pay_bill_amount_with_discount", fineRs.getString("pay_bill_amount_with_discount"));
            oneFine.addProperty("offense_location", fineRs.getString("offense_location"));
            oneFine.addProperty("offense_article", fineRs.getString("offense_article"));
            oneFine.addProperty("offense_date", fineRs.getString("offense_date"));
            oneFine.addProperty("offense_time", fineRs.getString("offense_time"));
            oneFine.addProperty("offense_article_number", fineRs.getString("offense_article_number"));
            oneFine.addProperty("carId", fineRs.getString("carId"));
            oneFine.addProperty("driverId", fineRs.getString("driverId"));
        }
        fineRs.close();
        fineSt.close();
	    con.close();
        return oneFine;
    }
    public void setDriver(int driverId, String bill_id) throws SQLException, ClassNotFoundException, NamingException{
	Connection con = ds.getConnection();
        Statement st = con.createStatement();
        st.execute("UPDATE offenses SET driverId="+driverId+" WHERE bill_id='"+ bill_id +"'");
        PaySQL psql = new PaySQL();
        psql.addPayDriver(driverId, 2, (getSumFine(bill_id)+30)*-1, 11, 0, bill_id);
        st.close();
	    con.close();
    }
    public double getSumFine(String billId){
        try{
	    Connection con = ds.getConnection();
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM offenses WHERE bill_id='"+ billId +"'");
            double sumFine = 0.0;
            if(rs.next()){

                if(rs.getDate("gis_discount_uptodate").getTime()> new Date().getTime()){
                    System.out.println("Fine is late");
                    sumFine = rs.getDouble("pay_bill_amount_with_discount");
                }
                else{
                    System.out.println("Fine normal");
                    sumFine = rs.getDouble("pay_bill_amount");
                }
            }
            rs.close();
            st.close();
	    con.close();
            return sumFine;
        }
        catch(Exception ex){
            System.out.println(ex.getMessage());
            return 0.0;
        }
    }

    public JsonArray getAllFineOG(boolean deleted, String discountOutDate, String payOutDate) throws SQLException {
	
	JsonArray fineList;
	try (Connection con = ds.getConnection()) {
	    Statement fineListSt = con.createStatement();
	    String where = "AND ((`offenses`.gis_discount_uptodate <= '"+discountOutDate+"' AND `offenses`.gis_discount_uptodate!='0000-00-00')\n" +
		    "            OR (`offenses`.last_bill_date <= '"+payOutDate+"' AND `offenses`.gis_discount_uptodate='0000-00-00')) ";
	    where = where + " AND cars.state!=8 ";
	    if(deleted){
		where="";
	    }   String query = "SELECT finecar.*, drivers.driver_lastname FROM drivers "
		    + "RIGHT JOIN (SELECT `offenses`.*, cars.number as carNumber FROM `offenses`  " +
		    "INNER JOIN cars \n" +
		    "ON offenses.carId=cars.id \n" +
		    "WHERE `gis_status`='nopayed' AND (bill_id like '188101%' OR bill_id like '188105%' OR bill_id like '035%') "+where+" ) as finecar\n" +
		    "ON finecar.driverId=drivers.driver_id";
	    System.out.println(query);
	    ResultSet fineListRs = fineListSt.executeQuery(query);   //
	    fineList = new JsonArray();
	    while(fineListRs.next()){
		JsonObject oneFine = new JsonObject();
		oneFine.addProperty("carNumber", fineListRs.getString("carNumber"));
		oneFine.addProperty("driver_lastname", fineListRs.getString("driver_lastname"));
		oneFine.addProperty("bill_id", fineListRs.getString("bill_id"));
		oneFine.addProperty("gis_status", fineListRs.getString("gis_status"));
		oneFine.addProperty("pay_bill_date", fineListRs.getString("pay_bill_date"));
		oneFine.addProperty("last_bill_date" , fineListRs.getString("last_bill_date"));
		oneFine.addProperty("pay_bill_amount", fineListRs.getString("pay_bill_amount"));
		oneFine.addProperty("gis_discount", fineListRs.getString("gis_discount"));
		oneFine.addProperty("gis_discount_uptodate", fineListRs.getString("gis_discount_uptodate"));
		oneFine.addProperty("pay_bill_amount_with_discount", fineListRs.getString("pay_bill_amount_with_discount"));
		oneFine.addProperty("offense_location", fineListRs.getString("offense_location"));
		oneFine.addProperty("offense_article", fineListRs.getString("offense_article"));
		oneFine.addProperty("offense_date", fineListRs.getString("offense_date"));
		oneFine.addProperty("offense_time", fineListRs.getString("offense_time"));
		oneFine.addProperty("offense_article_number", fineListRs.getString("offense_article_number"));
		oneFine.addProperty("carId", fineListRs.getString("carId"));
		oneFine.addProperty("driverId", fineListRs.getString("driverId"));
		fineList.add(oneFine);
	    }   
	    fineListRs.close();
	    fineListSt.close();
	    con.close();
	}
        return fineList;
    }
}
