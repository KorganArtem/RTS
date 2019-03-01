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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author korgan
 */
public class ReportSQL {
     public String url;
    public String login;
    public String pass;
    public Connection con;
    Map config;
    boolean iscon;
    public ReportSQL() throws ClassNotFoundException, SQLException{
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
    
    public Map getPayList(int driverId, String begin, String end) throws SQLException{
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
        return payList;
    }
    public Map getGroupPay(int driverId, String begin, String end) throws SQLException{
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
        return payList;
    }
    public Map getAllPayList(int operatorId, String begin, String end) throws SQLException{
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
        return payList;
    }
    public Map getAllPayList(int operatorId, String begin, String end, String paySource) throws SQLException{
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
        return payList;
    }
    public Map getGroupPayByOperator(int operatorId, String begin, String end) throws SQLException{
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
        return payList;
    }
    public Map gerCarUseReport(String begin, String end) throws SQLException, ParseException{
        System.out.println("Get car use report");
        Map<Integer, Map> carList = new HashMap();
        Date startPeriodDate = new SimpleDateFormat("yyyy-MM-dd").parse(begin);
        Date endPeriodDate = new SimpleDateFormat("yyyy-MM-dd").parse(end);
        long previevChange = new Date().getTime();
        try{
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("SELECT logCars.*, carState.* FROM carState " +
                                "INNER JOIN " +
                                "(SELECT carsChangeLog.changeType, carsChangeLog.carId, DATE_FORMAT(carsChangeLog.changeDate, '%Y-%m-%d') as changeDate, " +
                                "cars.number FROM carsChangeLog " +
                                "INNER JOIN cars " +
                                "ON cars.id=carsChangeLog.carId " +
                                "WHERE carId!=0 ORDER by carId, changeDate desc ) as logCars " +
                                "ON logCars.changeType=carState.carStateId");
            int currentCar=0;
            boolean nextCar = false;
            while(rs.next()){
                Date changeDate=new SimpleDateFormat("yyyy-MM-dd").parse(rs.getString("changeDate").toString());
                if(startPeriodDate.getTime()>changeDate.getTime()){
                    System.out.println("Out of period");
                    changeDate = startPeriodDate;
                }
                if(currentCar != rs.getInt("carId")){
                    System.out.println("Next Car: "+rs.getString("number")+"   -  "+rs.getString("carId"));
                    currentCar = rs.getInt("carId");
                    previevChange = new Date().getTime();  
                    nextCar=true;
                }
                long days = previevChange-changeDate.getTime();
                System.out.println("\t"+rs.getString("changeType")+"   "+rs.getString("changeDate")+"  "+days/1000/24/60/60+"   "+rs.getString("carStateName"));
                previevChange = changeDate.getTime();
                if(nextCar){
                    days = previevChange-startPeriodDate.getTime();
                    System.out.println("\t"+rs.getString("changeType")+"   "+rs.getString("changeDate")+"  "+days/1000/24/60/60+"   "+rs.getString("carStateName"));
                    previevChange = changeDate.getTime();
                    nextCar=false;
                }
            }
        }
        catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return carList;
    }
}
