/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ru.leasicar.authorization;

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
 * @author korgan
 */
public class AccessControl {
    public DataSource ds;
    Map config;
    boolean iscon;
    public AccessControl() throws ClassNotFoundException, SQLException, NamingException{
        InitialContext initContext= new InitialContext();
	ds = (DataSource) initContext.lookup("java:comp/env/jdbc/dbconnect");
    }
    public boolean checkUser(String username, String password, String sessionId) throws ClassNotFoundException, SQLException{
        try (Connection con = ds.getConnection(); Statement st = con.createStatement()) {
	    st.execute("DELETE FROM `session` WHERE `sessionId`='"+sessionId+"'");
	    ResultSet rs = st.executeQuery("SELECT `id` FROM `users` WHERE `username`='"
		    +username+"' and `password`=md5('"+password+"')");
	    if(rs.next()){
		System.out.println("Login successful username="+username+" user_id="+rs.getInt("id"));
		writeSession(rs.getInt("id"), sessionId);
		rs.close();
		st.close();
		con.close();
		return true;
	    }
	    else
		System.out.println("Username or password is wrong! username="+username);
	    rs.close();
	    con.close();
	}
        catch(Exception ex ){
            System.out.println("Error in authorization!!!\n"+ex.getMessage());
        }
        return false;
    }
    private void writeSession(int userId, String sessionId){
        try{
	    Connection con = ds.getConnection();
            Statement st = con.createStatement();
            st.execute("DELETE FROM `session` WHERE  unix_timestamp(`timeLastUse`)<unix_timestamp(NOW())-3000");
            st.execute("INSERT INTO `session` (`sessionId`, `userId`, `timeCreated`, `timeLastUse`)"
                    + "VALUES ('"+sessionId+"', "+userId+", NOW(), NOW())");
            st.close();
	    con.close();
        }
        catch(Exception ex ){
            System.out.println("Error in authorization!!!\n"+ex.getMessage());
        }
    }
    public boolean isLogIn(String sessionId){
        try{
	    Connection con = ds.getConnection();
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("SELECT `userId` FROM `session` "
                    + "WHERE `sessionId`='"+sessionId+"' "
                    + "AND unix_timestamp(`timeLastUse`) > unix_timestamp(NOW())-6000000 LIMIT 1");
            if(rs.next()){
                rs.close();
                String updateQuery = "UPDATE `session` SET `timeLastUse`=NOW() WHERE `sessionId`='"+sessionId+"'";
                //System.out.println("Update session time 'sessionId'='"+sessionId+"' \n "+updateQuery);
                st.execute(updateQuery);
                st.close();
		con.close();
                return true;
            }
            rs.close();
            st.execute("DELETE FROM `session` WHERE `sessionId`='"+sessionId+"'");
            st.close();
	    con.close();
        }
        catch(Exception ex ){
            System.out.println("Error in authorization!!!\n"+ex.getMessage());
        }
        return false;
    }
    public boolean checkPermission(int userId, String permissionName){
        boolean allow = false;
        try{
	    Connection con = ds.getConnection();
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM `userrules` "
                    + "WHERE userId="+userId+" "
                            + "and ruleId=(SELECT id FROM rules WHERE ruleName='"+permissionName+"');");
            if(rs.next()){
                allow=true;
                System.out.println(" - allow");
            }
            else 
                System.out.println(" - forbidden");
            rs.close();
            st.close();
	    con.close();
        }
        catch(Exception ex){
            System.out.println("Error in check permission \n" + ex.getMessage());
        }
        
        return allow;
    }
    public int getUserId(String sessionId){
        int userId = 0;
        try (Connection con = ds.getConnection()) {
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery("SELECT * FROM `session` "
			+ "WHERE sessionId='"+sessionId+"'  LIMIT 1");
		if(rs.next()){
		    userId=rs.getInt("userId");
		}
		else
		    System.out.println("You can not do it!");
		rs.close();
		st.close();
        }
        catch(Exception ex){
            System.out.println("Error in get user id \n" + ex.getMessage());
        }
        return userId;
    }
    public void logOut(String sessionId){
        try{
	    Connection con = ds.getConnection();
            Statement st = con.createStatement();
            st.execute("DELETE FROM `session` WHERE `sessionId`='"+sessionId+"'");
            st.close();
	    con.close();
        }
        catch(Exception ex ){
            System.out.println("Error in authorization!!!\n"+ex.getMessage());
        }
    }

    void changePass(int userId, String password) throws SQLException, InterruptedException {
	Connection con = ds.getConnection();
        Statement st = con.createStatement();
        st.execute("UPDATE `users` SET `password`=md5('"+password+"') WHERE `id`="+userId);
	st.close();
	con.close();
    }

    String getUserName(int userId) {
        String userName = null;
        try{
	    Connection con = ds.getConnection();
            Statement st = con.createStatement();
            String query = "SELECT * FROM `users` WHERE `id`='"+userId+"'";
            ResultSet rs = st.executeQuery(query);
            if(rs.next()){
                userName=rs.getString("username");
            }
            else 
                System.out.println("You can not do it!");
            rs.close();
            st.close();
	    con.close();
        }
        catch(Exception ex){
            System.out.println("Error in get users name \n" + ex.getMessage());
        }
        return userName;
    }
}
