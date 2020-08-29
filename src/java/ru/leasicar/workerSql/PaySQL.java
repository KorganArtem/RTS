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
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

/**
 *
 * @author korgan
 */
public class PaySQL {
    DataSource ds;
    public PaySQL() throws ClassNotFoundException, SQLException, NamingException{
        InitialContext initContext= new InitialContext();
	ds = (DataSource) initContext.lookup("java:comp/env/jdbc/dbconnect");
	
    }
   public void deletePay(String idPay, int driverId) throws SQLException{
       Connection con = ds.getConnection();
       System.out.println("I will remove pay "+idPay);
       Statement stGetSumPay = con.createStatement();
       ResultSet rsGetPaySum = stGetSumPay.executeQuery("SELECT `sum` FROM `pay` WHERE `id`='"+idPay+"'");
       double sumPay;
       if(rsGetPaySum.next()){
	   sumPay = rsGetPaySum.getDouble("sum");
       }
       else{
	   System.out.println("I did not get sum");
	   rsGetPaySum.close();
	   stGetSumPay.close();
	   return;
       }
       Statement stRemovePay = con.createStatement();
       stRemovePay.execute("DELETE FROM pay WHERE `id`='"+idPay+"'");
       /////// change all affter
       System.out.println("Balance"+(1000-sumPay));
       
       Statement stChangePays = con.createStatement();
       stChangePays.execute("UPDATE pay SET `balance`=`balance`-"+sumPay+"  WHERE `id`>'"+idPay+"' AND driverId="+driverId);
       
       Statement stChangeBalance = con.createStatement();
       stChangeBalance.execute("UPDATE drivers SET `driver_current_debt`=`driver_current_debt`-"+sumPay+" WHERE driver_id="+driverId);
       con.close();
   }
   public void addPayDriver(int driverId, int payType, double sum, int source, int userId, String comment) throws SQLException{
        double balanceDriver = 0;
       Connection con = ds.getConnection();
        if(source!=6){
            Statement stGetBalance = con.createStatement();
            ResultSet rsGetBalance = stGetBalance.executeQuery("SELECT `driver_current_debt` FROM `drivers` "
                + "WHERE `driver_id`="+driverId);
            if(rsGetBalance.next())
                balanceDriver=rsGetBalance.getDouble("driver_current_debt")+sum;
        }
        Statement st = con.createStatement();
        st.execute("INSERT INTO `pay` (`type`, `date`, `source`, `sum`, `driverId`, `user`, `balance`, `comment`) "
                + "VALUES ('"+payType+"', NOW(), '"+source+"', '"+sum+"', '"+driverId+"', '"+userId+"', '"+balanceDriver+"', '"+comment+"')");
        st.close();
        if(source==6){
           Statement stUpdateCurrentDebt = con.createStatement();
            stUpdateCurrentDebt.execute("UPDATE `drivers` SET `driver_deposit`=`driver_deposit`-"+sum+" WHERE `driver_id`="+driverId);
            stUpdateCurrentDebt.close(); 
        }
        Statement stUpdateCurrentDebt = con.createStatement();
        stUpdateCurrentDebt.execute("UPDATE `drivers` SET `driver_current_debt`=(SELECT sum(`sum`) FROM `pay` WHERE driverId="+driverId+" and type!=3) WHERE `driver_id`="+driverId);
        stUpdateCurrentDebt.close();
	con.close();
    }

    public void addPayDeposit(int driverId, double sum, int source, int userId) throws SQLException {
       Connection con = ds.getConnection();
        Statement st = con.createStatement();
        st.execute("INSERT INTO `pay` (`type`, `date`, `source`, `sum`, `driverId`, `user`) "
                + "VALUES ('3', NOW(), '"+source+"', '"+sum+"', '"+driverId+"', '"+userId+"')");
        st.close();
        Statement stUpdateCurrentDebt = con.createStatement();
        stUpdateCurrentDebt.execute("UPDATE `drivers` SET `driver_deposit`=`driver_deposit`+"+sum+" WHERE `driver_id`="+driverId);
        stUpdateCurrentDebt.close();
	con.close();
    }

    public String paySourceSelect() throws SQLException{
       Connection con = ds.getConnection();
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery("SELECT * FROM `paySource` WHERE `active`=1");
        String forRet = "";
        while(rs.next()){
            forRet = forRet+"<option value='" + rs.getString("payId")+"'>" + rs.getString("payName") + "</option>";
        }
        rs.close();
        st.close();
	con.close();
        return forRet;
    }
    public double getPayToday() throws SQLException{
	Connection con = ds.getConnection();
        Statement st = con.createStatement();
	double sum = 0.0;
        ResultSet rs = st.executeQuery("SELECT sum(`sum`) as gotTo FROM `pay` WHERE `date` > curdate() and `type`=1");
	if(rs.next())
	    sum=rs.getDouble("gotTo");
	rs.close();
        st.close();
	con.close();
	return sum;
    }
}
