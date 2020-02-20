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
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

/**
 *
 * @author Artem
 */
public class UserSQL {
    DataSource ds;
    public UserSQL() throws ClassNotFoundException, SQLException, NamingException{
        InitialContext initContext= new InitialContext();
	ds = (DataSource) initContext.lookup("java:comp/env/jdbc/dbconnect");
    }
    public String getUserForSelect() throws SQLException{
	Connection con = ds.getConnection();
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery("SELECT * FROM `users`");
        String forRet="";
        while(rs.next()){
            forRet = forRet+"<option value='"+rs.getInt("id")+"' >"+rs.getString("ful_name")+"</option>";
        }
        rs.close();
        st.close();
	con.close();
        return forRet;
    }
    public Map<String, String> getUser(int userId) throws SQLException{
	Connection con = ds.getConnection();
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery("SELECT * FROM `users` WHERE id="+userId);
        Map<String, String> forRet= new HashMap();
        if(rs.next()){
            forRet.put("id", rs.getString("id"));
            forRet.put("ful_name", rs.getString("ful_name"));
        }
        rs.close();
        st.close();
	con.close();
        return forRet;
    }
    public Map<Integer, Map> getUsersList(){
	try {
	    Connection con = ds.getConnection();
	    Statement st = con.createStatement();
	    ResultSet rs = st.executeQuery("SELECT * FROM `users`");
	    Map<Integer, Map> forRet= new HashMap();
	    while(rs.next()){
		Map<String, String> row = new HashMap();
		row.put("id", rs.getString("id"));
		row.put("ful_name", rs.getString("ful_name"));
		row.put("username", rs.getString("username"));
		row.put("group", rs.getString("group"));
		row.put("department", rs.getString("department"));
		forRet.put(rs.getInt("id"), row);
	    }
	    rs.close();
	    st.close();
	    con.close();
	    return forRet;
	} catch (SQLException ex) {
	    Logger.getLogger(UserSQL.class.getName()).log(Level.SEVERE, null, ex);
	}
	return null;
    }
    public Map<String, Map> getUserRules(int userId){
	try {
	    Connection con = ds.getConnection();
	    Statement st = con.createStatement();
	    ResultSet rs = st.executeQuery("SELECT " +
					    "    * " +
					    "FROM" +
					    "    rules" +
					    "        LEFT JOIN" +
					    "    (SELECT " +
					    "        *" +
					    "    FROM" +
					    "        userrules" +
					    "    WHERE" +
					    "        userId = "+userId+") AS usrRls ON rules.id = usrRls.ruleId");
	    
	    Map<String, Map> forRet= new HashMap();
	    while(rs.next()){
		Map<String, String> row = new HashMap();
		row.put("ruleDescription", rs.getString("ruleDescription"));
		row.put("ruleId", rs.getString("ruleId"));
		row.put("id", rs.getString("id"));
		row.put("userId", rs.getString("userId"));
		forRet.put(rs.getString("ruleName"), row);
	    }
	    rs.close();
	    st.close();
	    con.close();
	    return forRet;
	} catch (SQLException ex) {
	    Logger.getLogger(UserSQL.class.getName()).log(Level.SEVERE, null, ex);
	}
	return null;
    }

    public void writeUserRules(Map<String, String[]> userRulesList) {
	try {
	    Connection con = ds.getConnection();
	    Statement st = con.createStatement();
	    String userId = userRulesList.get("userId")[0];
	    st.execute("DELETE FROM userrules WHERE userId="+userId);
	    st.close();
	    // Map.Entry - описываем пару (ключ - значение) "3=Среда" и т.п.
	    // entrySet - возращает множество со значениями карты, т.е. [3=Среда, 2=Вторник, 1=Понедельник]
	    Statement stIn = con.createStatement();
		    
	    for (Map.Entry<String, String[]> entry : userRulesList.entrySet()) {
		if(entry.getKey().equals("userId"))
		    continue;
		stIn.execute("INSERT INTO userrules VALUES ("+userId+","+entry.getValue()[0]+")");
	    }
	    stIn.close();
	    con.close();
	} catch (Exception ex) {
	    Logger.getLogger(UserSQL.class.getName()).log(Level.SEVERE, null, ex);
	}
    }
}
