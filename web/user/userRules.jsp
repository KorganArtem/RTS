<%-- 
    Document   : userRules
    Created on : Nov 30, 2019, 3:20:08 PM
    Author     : Artem
--%>

<%@page import="java.util.Set"%>
<%@page import="ru.leasicar.workerSql.UserSQL"%>
<%@page import="java.util.Map"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    int userId= Integer.parseInt(request.getParameter("userId")); 
    UserSQL usql = new UserSQL();
    Map<String, Map> userPermissions =usql.getUserRules(userId);
%>
<div id="">
    <form id="userRule_<%= userId %>">
	<input name="userId" hidden="true" value="<%= userId %>" />
    <%
	Set<String> keys = userPermissions.keySet();
	for(String key : keys){ 
	    Map row = userPermissions.get(key);
	    String checked = "";
	    if(row.get("userId")!=null){
		checked = "checked";
	    }
	%>
	<div><input name="<%= key %>" type="checkbox" <%= checked %> value="<%= row.get("id") %>"/> <label><%= row.get("ruleDescription") %></label></div>
	<% } %>
    </form> 
</div>
