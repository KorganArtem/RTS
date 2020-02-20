/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ru.leasicar.workerSql;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

/**
 *
 * @author korgan
 */
public class ReportSQL {
    DataSource ds ;
    public ReportSQL() throws ClassNotFoundException, SQLException, NamingException{
        InitialContext initContext= new InitialContext();
	ds = (DataSource) initContext.lookup("java:comp/env/jdbc/dbconnect");
    }
    
    public Map getPayList(int driverId, String begin, String end) throws SQLException{
	Connection con = ds.getConnection();
        System.out.println(begin + "  " +end);
        Statement stPayList = con.createStatement();
        ResultSet rsPayList = stPayList.executeQuery("SELECT zap1.`date_f`, zap1.`id`, zap1.`payName`, zap1.`user`, payType.payTypeName, zap1.`sum`, zap1.`balance`, zap1.`comment` FROM payType " +
                                "INNER JOIN (SELECT DATE_FORMAT(`date`, '%Y-%m-%d %H:%i') as date_f, `pay`.*, `paySource`.`payName` FROM `pay` " +
                                "LEFT join `paySource` " +
                                "ON `paySource`.`payId`=`pay`.`source`) as zap1 " +
                                "ON zap1.`type`=payType.payTapeId\n" +
                                "WHERE `driverId`="+driverId+" AND `date` > '"+begin+"' AND `date` < '"+end+" 23:59:59' ORDER BY `id`");
        Map payList = new HashMap<String, HashMap>();
        while(rsPayList.next()){
            Map payRaw = new HashMap<String, String>();
            payRaw.put("payTypeName", rsPayList.getString("payTypeName"));
            payRaw.put("payName", rsPayList.getString("payName"));
            payRaw.put("sum", rsPayList.getString("sum"));
            payRaw.put("balance", rsPayList.getString("balance"));
            payRaw.put("date", rsPayList.getString("date_f"));
            payRaw.put("comment", rsPayList.getString("comment"));
            payList.put(rsPayList.getString("id"), payRaw);
        }
        rsPayList.close();
        stPayList.close();
	con.close();
        return payList;
    }
    public Map getGroupPay(int driverId, String begin, String end) throws SQLException{
	Connection con = ds.getConnection();
        Statement stPayList = con.createStatement();
        ResultSet rsPayList = stPayList.executeQuery("SELECT `payGroup`.*, `paySource`.`payName` FROM `paySource` " +
                    "INNER JOIN (SELECT `source`, SUM(`sum`) as `sum` FROM `pay` WHERE `driverId`="+driverId+" AND `date` > '"+begin+" 00:00:00' "
                            + "AND `date` < '"+end+" 23:59:59' GROUP BY `source`) as `payGroup` " +
                    "ON `paySource`.`payId`=`payGroup`.`source`");
        Map payList = new HashMap<String, HashMap>();
        int indRep = 0;
        while(rsPayList.next()){
            Map payRaw = new HashMap<String, String>();
            payRaw.put("payName", rsPayList.getString("payName"));
            payRaw.put("sum", rsPayList.getString("sum"));
            payList.put(rsPayList.getString("source"), payRaw);
        }
        rsPayList.close();
        stPayList.close();
	con.close();
        return payList;
    }
    public Map getAllPayList(int operatorId, String begin, String end) throws SQLException{
	Connection con = ds.getConnection();
        String where= "`user`>"+operatorId+" AND";
        if(operatorId>0) 
            where= "`user`="+operatorId+" AND";
        System.out.println(begin + "  " +end);
        Statement stPayList = con.createStatement();
        String query = "SELECT zapPayWd.*, drivers.driver_lastname FROM drivers \n" +
                    "INNER JOIN (SELECT zapPayAll.`date_f`, zapPayAll.`driverId`, zapPayAll.`id`, zapPayAll.`payName`, zapPayAll.`user`, zapPayAll.payTypeName, zapPayAll.`sum`, `users`.ful_name FROM `users`\n" +
                    "	INNER JOIN \n" +
                    "		(SELECT zap1.`date_f`, zap1.`id`, zap1.`payName`, zap1.`user`, zap1.`driverId`, payType.payTypeName, zap1.`sum` FROM payType INNER JOIN (SELECT DATE_FORMAT(`date`, '%Y-%m-%d') as date_f, `pay`.*, `paySource`.`payName` FROM `pay` LEFT join `paySource` ON `paySource`.`payId`=`pay`.`source`) as zap1 ON zap1.`type`=payType.payTapeId\n" +
                    "		WHERE  "+where+" `date` > '"+begin+" 00:00:00' AND `date` < '"+end+" 23:59:59' ORDER BY `id`) as zapPayAll\n" +
                    "	ON `users`.id=zapPayAll.`user`)  as zapPayWd\n" +
                    "ON zapPayWd.driverId=drivers.driver_id";
        ResultSet rsPayList = stPayList.executeQuery(query);
        Map payList = new HashMap<String, HashMap>();
        while(rsPayList.next()){
            Map payRaw = new HashMap<String, String>();
            payRaw.put("payTypeName", rsPayList.getString("payTypeName"));
            payRaw.put("payName", rsPayList.getString("payName"));
            payRaw.put("sum", rsPayList.getString("sum"));
            payRaw.put("user", rsPayList.getString("ful_name"));
            payRaw.put("date", rsPayList.getString("date_f"));
            payRaw.put("driver", rsPayList.getString("driver_lastname"));
            payList.put(rsPayList.getString("id"), payRaw);
        }
        rsPayList.close();
        stPayList.close();
	con.close();
        return payList;
    }
    public Map getAllPayList(int operatorId, String begin, String end, String paySource) throws SQLException{
	Connection con = ds.getConnection();
        String where= "`user`>"+operatorId+" AND";
        if(operatorId>0) 
            where= "`user`="+operatorId+" AND";
        System.out.println(begin + "  " +end);
        Statement stPayList = con.createStatement();
        String query = "SELECT zapPayWd.*, drivers.driver_lastname FROM drivers \n" +
                    "INNER JOIN (SELECT zapPayAll.`date_f`, zapPayAll.`driverId`, zapPayAll.`id`, zapPayAll.`payName`, zapPayAll.`user`, zapPayAll.payTypeName, zapPayAll.`sum`, `users`.ful_name FROM `users`\n" +
                    "	INNER JOIN \n" +
                    "		(SELECT zap1.`date_f`, zap1.`id`, zap1.`payName`, zap1.`user`, zap1.`driverId`, payType.payTypeName, zap1.`sum` FROM payType INNER JOIN (SELECT DATE_FORMAT(`date`, '%Y-%m-%d') as date_f, `pay`.*, `paySource`.`payName` FROM `pay` LEFT join `paySource` ON `paySource`.`payId`=`pay`.`source` WHERE  `pay`.`source`="+ paySource +") as zap1 ON zap1.`type`=payType.payTapeId\n" +
                    "		WHERE  "+where+" `date` > '"+begin+" 00:00:00' AND `date` < '"+end+" 23:59:59' ORDER BY `id`) as zapPayAll\n" +
                    "	ON `users`.id=zapPayAll.`user`)  as zapPayWd\n" +
                    "ON zapPayWd.driverId=drivers.driver_id ";
        ResultSet rsPayList = stPayList.executeQuery(query);
        Map payList = new HashMap<String, HashMap>();
        while(rsPayList.next()){
            Map payRaw = new HashMap<String, String>();
            payRaw.put("payTypeName", rsPayList.getString("payTypeName"));
            payRaw.put("payName", rsPayList.getString("payName"));
            payRaw.put("sum", rsPayList.getString("sum"));
            payRaw.put("user", rsPayList.getString("ful_name"));
            payRaw.put("date", rsPayList.getString("date_f"));
            payRaw.put("driver", rsPayList.getString("driver_lastname"));
            payList.put(rsPayList.getString("id"), payRaw);
        }
        rsPayList.close();
        stPayList.close();
	con.close();
        return payList;
    }
    public Map getGroupPayByOperator(int operatorId, String begin, String end) throws SQLException{
	Connection con = ds.getConnection();
        String where= "`user`>="+operatorId+" AND";
        if(operatorId>0) 
            where= "`user`="+operatorId+" AND";
        Statement stPayList = con.createStatement();
        String query = "SELECT `payGroup`.*, `paySource`.`payName` FROM `paySource` " +
                    "INNER JOIN (SELECT `source`, SUM(`sum`) as `sum` FROM `pay` WHERE "+where+" `date` > '"+begin+" 00:00:00' AND `date` < '"+end+" 29:59:59' GROUP BY `source`) as `payGroup` " +
                    "ON `paySource`.`payId`=`payGroup`.`source`";
        System.out.println(query);
        ResultSet rsPayList = stPayList.executeQuery(query);
        Map payList = new HashMap<String, HashMap>();
        int indRep = 0;
        System.out.println("I get group");
        while(rsPayList.next()){
            Map<String, String> payRaw = new HashMap<String, String>();
            payRaw.put("payName", rsPayList.getString("payName"));
            payRaw.put("sum", rsPayList.getString("sum"));
            payList.put(rsPayList.getString("source"), payRaw);
        }
        rsPayList.close();
        stPayList.close();
	con.close();
        return payList;
    }
    public Map gerCarUseReport1(String begin, String end) throws SQLException, ParseException{
	Connection con = ds.getConnection();
        System.out.println("Get car use report");
        Map<Integer, Map> carList = new HashMap();
        Date startPeriodDate = new SimpleDateFormat("yyyy-MM-dd").parse(begin);
        Date endPeriodDate = new SimpleDateFormat("yyyy-MM-dd").parse(end);
        long previevChange = new Date().getTime();
        try{
            Statement st = con.createStatement();
            String query = "SELECT logCars.*, carState.* FROM carState INNER JOIN (SELECT carsChangeLog.changeType, carsChangeLog.idcarsChangeLog, carsChangeLog.carId, DATE_FORMAT(carsChangeLog.changeDate, '%Y-%m-%d') as changeDate, cars.number FROM carsChangeLog INNER JOIN cars ON cars.id=carsChangeLog.carId WHERE carId!=0 ORDER by carId, idcarsChangeLog desc ) as logCars ON logCars.changeType=carState.carStateId";
            System.out.println(query);
            ResultSet rs = st.executeQuery(query);
            int currentCar=0;
            boolean nextCar = false;
            while(rs.next()){
                Date changeDate=new SimpleDateFormat("yyyy-MM-dd").parse(rs.getString("changeDate").toString());
                if(startPeriodDate.getTime()>changeDate.getTime()){ 
                    //System.out.println("Out of period");
                    changeDate = startPeriodDate;
                    continue;
                } 
                if(currentCar != rs.getInt("carId")){
                    System.out.println("Next Car: "+rs.getString("number")+"   -  "+rs.getString("carId"));
                    currentCar = rs.getInt("carId");
                    previevChange = new Date().getTime(); 
                    nextCar=true;
                }
                long days = previevChange-changeDate.getTime();
                System.out.println( previevChange+"  "+changeDate.getTime());
                System.out.println("\t"+rs.getString("changeType")+"   "+rs.getString("changeDate")+"\t  "+days/1000/24/60/60+" \t  "+rs.getString("carStateName"));
                previevChange = changeDate.getTime();
                if(nextCar){
                    days = previevChange-startPeriodDate.getTime();
                    System.out.println("\t"+rs.getString("changeType")+"   "+rs.getString("changeDate")+"\t  "+days/1000/24/60/60+" \t   "+rs.getString("carStateName"));
                    previevChange = changeDate.getTime();
                    nextCar=false;
                }
            }
            rs.close();
            st.close();
	    con.close();
        }
        catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return carList;
    }
    public Map gerCarUseReport(String begin, String end) throws SQLException, ParseException{
	Connection con = ds.getConnection();
        System.out.println("Get car use report");
        Map<Integer, Map> carList = new HashMap();
        Date startPeriodDate = new SimpleDateFormat("yyyy-MM-dd").parse(begin);
        Date endPeriodDate = new SimpleDateFormat("yyyy-MM-dd").parse(end);
        if(endPeriodDate.getTime()>new Date().getTime()){
            endPeriodDate = new Date();
        }
        long previevChange = new Date().getTime();
        try{
            Statement st = con.createStatement();
            String query = "SELECT logCars.*, carState.* FROM carState INNER JOIN "
                    + "(SELECT carsChangeLog.changeType, carsChangeLog.idcarsChangeLog, carsChangeLog.carId, DATE_FORMAT(carsChangeLog.changeDate, '%Y-%m-%d') as changeDate, cars.number FROM carsChangeLog INNER JOIN cars ON cars.id=carsChangeLog.carId WHERE carId!=0 ORDER by carId, idcarsChangeLog desc ) as logCars "
                    + "ON logCars.changeType=carState.carStateId WHERE changeDate<='"+end+"'";
            ResultSet rs = st.executeQuery(query);
            int currentCar=0;
            boolean nextCar = false;
            boolean lastState = false;
            SimpleDateFormat smpFormat = new SimpleDateFormat("yyyy-MM-dd");
            while(rs.next()){
                if(currentCar != rs.getInt("carId")){
                    System.out.println("Next Car: "+rs.getString("number"));
                    currentCar = rs.getInt("carId");
                    previevChange = endPeriodDate.getTime(); 
                    lastState = false;
                }
                if(lastState)
                    continue;
                Date changeDate=new SimpleDateFormat("yyyy-MM-dd").parse(rs.getString("changeDate").toString());
                if(startPeriodDate.getTime()>changeDate.getTime()){ 
                    changeDate = startPeriodDate;
                    lastState = true;
                } 
                long days = previevChange-changeDate.getTime();
                System.out.println("\t\t"+rs.getString("changeType")
                        +"\t"+smpFormat.format(changeDate)
                        +"\t"+smpFormat.format(previevChange)
                        +"\t"+days/1000/24/60/60
                        +"\t"+rs.getString("carStateName"));
                if(nextCar){
                    previevChange = changeDate.getTime();
                    nextCar=false;
                    continue;
                }
                previevChange = changeDate.getTime();
                
            }
            rs.close();
            st.close();
	    con.close();
        }
        catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return carList;
    }
}
