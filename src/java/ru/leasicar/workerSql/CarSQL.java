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
public class CarSQL {
    
    public String url;
    public String login;
    public String pass;
    public Connection con;
    Map config;
    boolean iscon;
    public CarSQL() throws ClassNotFoundException, SQLException{
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
    public Map carList() throws SQLException {
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery("SELECT carsZap.*, carState.* FROM carState " +
        "INNER JOIN (SELECT *  FROM `cars` INNER JOIN `models` ON `cars`.`model`=`models`.`modelId` ) as carsZap " +
        "ON carsZap.state=carState.carStateId " +
        "WHERE `carsZap`.`state`>0");
        Map<String, Map> listDriver = new HashMap<>();
        while(rs.next()){
            Map rowDriver = new HashMap<String, HashMap>();
            rowDriver.put("id", rs.getString("id"));
            rowDriver.put("number", rs.getString("number"));
            rowDriver.put("model", rs.getString("model"));
            rowDriver.put("modelName", rs.getString("modelName"));
            rowDriver.put("VIN", rs.getString("VIN"));
            rowDriver.put("transmission", rs.getString("transmission"));
            rowDriver.put("year", rs.getString("year"));
            rowDriver.put("cost", rs.getString("cost"));
            rowDriver.put("sts", rs.getString("sts"));
            rowDriver.put("glanasId", rs.getString("glanasId"));
            rowDriver.put("carStateName", rs.getString("carStateName"));
            listDriver.put(rs.getString("id"), rowDriver);
        }
        return listDriver;
    }
    public Map getCarData(int id) throws SQLException{
        Map<String, String> carData = new HashMap<>();
        try{
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("SELECT *  FROM `cars` WHERE `id`="+id);
            if(rs.next()){
                carData.put("id", rs.getString("id"));
                carData.put("number", rs.getString("number"));
                carData.put("regGosNumber", rs.getString("regGosNumber"));
                carData.put("sts", rs.getString("sts"));
                carData.put("VIN", rs.getString("VIN"));
                carData.put("carOwner", rs.getString("carOwner"));
                carData.put("model", rs.getString("model"));
                carData.put("year", rs.getString("year"));
                carData.put("carColor", rs.getString("carColor"));
                carData.put("transmission", rs.getString("transmission"));
                carData.put("cost", rs.getString("cost"));
                carData.put("carMileage", rs.getString("carMileage"));
                carData.put("lastService", rs.getString("lastService"));
                carData.put("lastServiceDate", rs.getString("lastServiceDate"));
                carData.put("glanasId", rs.getString("glanasId"));
                carData.put("state", rs.getString("state"));
                carData.put("ttoNumber", rs.getString("ttoNumber"));
                carData.put("insuranceNamber", rs.getString("insuranceNamber"));
                carData.put("insuranceDateEnd", rs.getString("insuranceDateEnd"));
                carData.put("licNumber", rs.getString("licNumber"));
                carData.put("licEndDate", rs.getString("licEndDate"));
                carData.put("insuranceCompany", rs.getString("insuranceCompany"));
                carData.put("ttoEndDate", rs.getString("ttoEndDate"));
                carData.put("outTime", rs.getString("outTime"));
            }
        }
        catch(Exception ex){
            System.out.println("Error " + ex.getMessage());
        }
        return carData;
    }
    public Map getCarDataForAct(int id) throws SQLException{
        Map carData = new HashMap<String, String>();
        try{
            String query = "SELECT *  FROM `cars` " +
                        "INNER JOIN `models` " +
                        "ON `cars`.`model`=`models`.`modelId` WHERE `id`="+id;
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(query);
            if(rs.next()){
                carData.put("id", rs.getString("id"));
                carData.put("number", rs.getString("number"));
                carData.put("modelName", rs.getString("modelName"));
                carData.put("VIN", rs.getString("VIN"));
                carData.put("transmission", rs.getString("transmission"));
                carData.put("year", rs.getString("year"));
                carData.put("cost", rs.getString("cost"));
                carData.put("glanasId", rs.getString("glanasId"));
                carData.put("color", rs.getString("carColor"));
                carData.put("sts", rs.getString("sts"));
                carData.put("insuranceNamber", rs.getString("insuranceNamber"));
                carData.put("insuranceDateEnd", rs.getString("insuranceDateEnd"));
                carData.put("ttoNumber", rs.getString("ttoNumber"));
            }
        }
        catch(Exception ex){
            System.out.println("Error " + ex.getMessage());
        }
        return carData;
    }
    public void writeCarData(String carNumber, 
            String carVIN, String carModel, String carTransmission,
            String carYear, String carCost, String carGlanasId, String carId,
            String carStsNumber, String carOsagoNumber, String carOsagoEnd, String ttoNumber) throws SQLException {
        System.out.println("Попытка внести изменения в информации о машине()");
        Statement st = con.createStatement();
        st.execute("UPDATE `cars` SET `number`='" +carNumber+ "'"+
                                            ", `model`='" + carModel+ "'"+
                                            ", `VIN`='" + carVIN+"'"+
                                            ", `transmission`='" + carTransmission+"'"+
                                            ", `year`='" + carYear+"'"+
                                            ", `cost`='" + carCost+"'"+
                                            ", `glanasId`= '"+ carGlanasId+"'"+
                                            ", `sts`= '"+ carStsNumber+"'"+
                                            ", `insuranceNamber`= '"+ carOsagoNumber+"'"+
                                            ", `insuranceDateEnd`= '"+ carOsagoEnd+"'"+
                                            ", `ttoNumber`= '"+ ttoNumber+"'"+
                                            " WHERE `id`="+carId);
    }
    public void writeCarData(Map carData) throws SQLException {
        System.out.println("Попытка внести изменения в информации о машине()");
        Statement st = con.createStatement();
        st.execute("UPDATE `cars` SET "
                + "`number`='"+carData.get("gosNum")+"', "
                + "`regGosNumber`='"+carData.get("numReg")+"', "
                + "`VIN`='"+carData.get("carVIN")+"', " 
                + "`transmission`='"+carData.get("carTransmission")+"', "
                + "`year`='"+carData.get("carYear")+"', "
                + "`cost`='"+carData.get("carRent")+"', "
                + "`sts`='"+carData.get("carSTS")+"', "
                + "`insuranceNamber`='"+carData.get("carOSAGONumber")+"', "
                + "`insuranceDateEnd`='"+carData.get("carOSAGODate")+"', "
                + "`insuranceCompany`='"+carData.get("insuranceCompany")+"', "
                + "`ttoNumber`='"+carData.get("carDCNumber")+"', "
                + "`ttoEndDate`='"+carData.get("carDCDate")+"', "
                + "`glanasId`='"+carData.get("carGlanasID")+"', "
                + "`carOwner`='"+carData.get("carOwner")+"', "
                + "`model`='"+carData.get("carModel")+"', "
                + "`carColor`='"+carData.get("CarColorMain")+"', "
                + "`carSchem`='"+carData.get("carSchem")+"', "
                + "`carMileage`='"+carData.get("carMileage")+"', "
                + "`lastService`='"+carData.get("carLastTOM")+"', "
                + "`lastServiceDate`='"+carData.get("carLastTOD")+"', "
                + "`state`='"+carData.get("carState")+"', "
                + "`licNumber`='"+carData.get("carLicNumber")+"', "
                + "`licEndDate`='"+carData.get("carLicDate")+"', "
                + "`outTime`='"+carData.get("outTime")+"' "
                        + "WHERE `id`="+carData.get("carId")); 
        st.close();
    }
    public String modelLisc(int currentIds) throws SQLException{
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery("SELECT * FROM `models`");
        String forRet="";
        while(rs.next()) {
            forRet =forRet+"<option value='"+rs.getInt("modelId")+"' ";
            if(rs.getInt("modelId")== currentIds)
                forRet = forRet+" selected "; 
            forRet =forRet+ ">" + rs.getString("modelName")+"</option>";           
        }
        return forRet;
    }
    public String insCompList(int currentIds) throws SQLException{
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery("SELECT * FROM `insuranceCompany`");
        String forRet="";
        while(rs.next()) {
            forRet =forRet+"<option value='"+rs.getInt("idinsuranceCompanyId")+"' ";
            if(rs.getInt("idinsuranceCompanyId")== currentIds)
                forRet = forRet+" selected "; 
            forRet =forRet+ ">" + rs.getString("insuranceCompanyName")+"</option>";           
        }
        return forRet;
    }
    public String stateList(int currentIds) throws SQLException{
        try{
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM `carState`");
            String forRet="";
            while(rs.next()) {
                forRet =forRet+"<option value='"+rs.getInt("carStateId")+"' ";
                if(rs.getInt("carStateId")== currentIds)
                    forRet = forRet+" selected "; 
                forRet =forRet+ ">" + rs.getString("carStateName")+"</option>";           
            }
            return forRet;
        }
        catch(Exception ex){
            System.out.println(ex.getMessage());
        }
        return null;
    }
    public String modelLisc() throws SQLException{
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery("SELECT * FROM `models`");
        String forRet="";
        while(rs.next()) {
            forRet =forRet+"<option value='"+rs.getInt("modelId")+"' ";
            forRet =forRet+ ">" + rs.getString("modelName")+"</option>";           
        }
        return forRet;
    }
    public void addCar(String carNumber, 
            String carVIN, String carModel, String carTransmission,
            String carYear, String carCost, String carGlanasId,
            String carStsNumber, String carOsagoNumber, String carOsagoEnd, String ttoNumber) throws SQLException {
        System.out.println("Попытка внести изменения в информации о машине()");
        Statement st = con.createStatement();
        st.execute("INSERT INTO `cars` (`number`, `model`, `VIN`, `transmission`, "
                + "`year`, `cost`, `glanasId`, `sts`, `insuranceNamber`, `insuranceDateEnd`, `ttoNumber`)"
                + " VALUES ('" +carNumber+ "', '"+carModel+ "', "+
                                            " '" + carVIN+"', "+
                                            " '" + carTransmission+"', "+
                                            " '" + carYear+"', "+
                                            " '" + carCost+"', "+
                                            " '"+ carGlanasId+"', "+
                                            " '"+ carStsNumber+"', "+
                                            " '"+ carOsagoNumber+"', "+
                                            " '"+ carOsagoEnd+"', "+
                                            " '"+ ttoNumber+"')");
    }
    public void addCar(Map carData) throws SQLException {
        System.out.println("Попытка внести изменения в информации о машине()");
        Statement st = con.createStatement();
        st.execute("INSERT INTO `cars` SET "
                + "`number`='"+carData.get("gosNum")+"', "
                + "`regGosNumber`='"+carData.get("numReg")+"', "
                + "`VIN`='"+carData.get("carVIN")+"', " 
                + "`transmission`='"+carData.get("carTransmission")+"', "
                + "`year`='"+carData.get("carYear")+"', "
                + "`cost`='"+carData.get("carRent")+"', "
                + "`sts`='"+carData.get("carSTS")+"', "
                + "`insuranceNamber`='"+carData.get("carOSAGONumber")+"', "
                + "`insuranceDateEnd`='"+carData.get("carOSAGODate")+"', "
                + "`insuranceCompany`='"+carData.get("insuranceCompany")+"', "
                + "`ttoNumber`='"+carData.get("carDCNumber")+"', "
                + "`ttoEndDate`='"+carData.get("carDCDate")+"', "
                + "`glanasId`='"+carData.get("carGlanasID")+"', "
                + "`carOwner`='"+carData.get("carOwner")+"', "
                + "`model`='"+carData.get("carModel")+"', "
                + "`carColor`='"+carData.get("CarColorMain")+"', "
                + "`carSchem`='"+carData.get("carSchem")+"', "
                + "`carMileage`='"+carData.get("carMileage")+"', "
                + "`lastService`='"+carData.get("carLastTOM")+"', "
                + "`lastServiceDate`='"+carData.get("carLastTOD")+"', "
                + "`state`='"+carData.get("carState")+"', "
                + "`licNumber`='"+carData.get("carLicNumber")+"', "
                + "`licEndDate`='"+carData.get("carLicDate")+"', "
                + "`outTime`='"+carData.get("outTime")+"'"); 
    }
    public String getFreeCarList() throws SQLException{
        String carData = "<option value='0'>Выбрать</option>";
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery("SELECT zap1.*, models.* FROM models \n" +
                            "INNER JOIN (SELECT * FROM `cars` WHERE `id` not in (SELECT `carId` FROM `drivers` WHERE `driver_deleted`=0) ORDER BY number) zap1" +
                            " ON zap1.model=models.modelId");
        while(rs.next()){
            carData = carData +"<option value='"+rs.getString("id")+"'>"+rs.getString("number")+"("+rs.getString("modelName")+")</option>";
        }
        return carData;
    }
    public String getFreeCarList(int driverId) throws SQLException{
        String carData = "<option value='0'>Выбрать</option>";
        Statement st = con.createStatement();
        int currentCarId=0;
        ResultSet carentCarRes = con.createStatement().executeQuery("SELECT * FROM `cars` "
                + "WHERE `id` in (SELECT carId FROM drivers WHERE driver_id= "+driverId+")");
        if(carentCarRes.next())
            currentCarId=carentCarRes.getInt("id");
        ResultSet rs = st.executeQuery("SELECT zap1.*, models.* FROM models \n" +
                            "INNER JOIN (SELECT * FROM `cars` WHERE `id` not in (SELECT `carId` FROM `drivers` WHERE `driver_deleted`=0) or `id` in (SELECT `carId` FROM `drivers` WHERE `driver_id`="+driverId+") ORDER BY number) zap1 " +
                            "ON zap1.model=models.modelId");
        while(rs.next()){
            String selected = "";
            if(rs.getInt("id")==currentCarId)
                selected="selected";
            carData = carData +"<option value='"+rs.getString("id")+"' "+selected+">"+rs.getString("number")+"("+rs.getString("modelName")+")</option>";
        }
        return carData;
    }
    public void changeCarState(int driverId, int carId, int state) throws SQLException{
        Statement st = con.createStatement();
        st.execute("INSERT INTO `carsChangeLog` SET `carId`="+carId+",  `driverId`="+driverId+", `changeType`="+state+", `changeDate`=NOW()");
        st.close();
    }
}
