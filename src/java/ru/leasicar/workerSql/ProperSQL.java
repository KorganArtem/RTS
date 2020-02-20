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
import java.util.Map;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

/**
 *
 * @author Artem
 */
public class ProperSQL {
    DataSource ds;
    
    public ProperSQL() throws ClassNotFoundException, SQLException, NamingException{
        InitialContext initContext= new InitialContext();
	ds = (DataSource) initContext.lookup("java:comp/env/jdbc/dbconnect");
    }
    public boolean getBoolParam(String paramName) throws SQLException{
	Connection con = ds.getConnection();
        boolean paramValue = false;
        Statement stGetBoolParam = con.createStatement();
        ResultSet rsGetBoolParam = stGetBoolParam.executeQuery("SELECT paramValue FROM param WHERE paramName='"+paramName+"'");
        System.out.println("SELECT paramValue FROM param WHERE paramValue='"+paramName+"'");
        if(rsGetBoolParam.next()){
            System.out.println(rsGetBoolParam.getString("paramValue"));
            if(rsGetBoolParam.getString("paramValue").equals("1"))
                paramValue = true;
        }
        rsGetBoolParam.close();
        stGetBoolParam.close();
	con.close();
        System.out.println("Param "+paramValue);
        return paramValue;
    }
    public int getIntParam(String paramName) throws SQLException{
	Connection con = ds.getConnection();
        int paramValue = 0;
        Statement stGetBoolParam = con.createStatement();
        ResultSet rsGetBoolParam = stGetBoolParam.executeQuery("SELECT paramValue FROM param WHERE paramName='"+paramName+"'");
        if(rsGetBoolParam.next()){
	    paramValue = rsGetBoolParam.getInt("paramValue");
        }
        rsGetBoolParam.close();
        stGetBoolParam.close();
	con.close();
        System.out.println("Param "+paramValue);
        return paramValue;
    }
}
