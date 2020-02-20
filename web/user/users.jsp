<%-- 
    Document   : company
    Created on : Nov 19, 2019, 10:39:52 PM
    Author     : Artem
--%>

<%@page import="ru.leasicar.workerSql.UserSQL"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Map"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div id="UserListSection">
    <%
	UserSQL csql = new UserSQL();
	Map<Integer, Map> compList = csql.getUsersList();
	Set<Integer> keys = compList.keySet();
	for(Integer key : keys){ %>
	<div class="userItem item_<%= key %>"> 
	    <form id="user_<%= key %>" name="fuser_<%= key %>">
		    <input name="ID" id="ID_<%= key %>" type="text" style="display: none;" readonly value="<%= key %>"/>

		<div class="formIntem">
		    <label>Логин</label>
		    <input name="userLogin" id="userLogin_<%= key %>" type="text" readonly value="<%= compList.get(key).get("username") %>"/>
		</div>
		<div class="formIntem">
		    <label>ФИО</label>
		    <input name="userFIO" id="userFIO_<%= key %>" type="text" readonly value="<%= compList.get(key).get("ful_name") %>"/>
		</div>

		    <input name="save" id="save_<%= key %>" type="button" style="display: none;" value="Save" onclick="saveUser(<%= key %>)"/>
		    <input name="edit" id="edit_<%= key %>" type="button" value="Edit" onclick="editUser(<%= key %>)"/>
		    <input name="del" id="del_<%= key %>" type="button" value="Del" onclick="delUser(<%= key %>)"/>



	    </form>
	</div>

	<%} %>
	<input type="button" value="Создать" onclick="showNewForm()"/>
       <div id="userItemNew" style="display: none;"> 
	    <form id="userNew" name="userNew">
		<input id="userId" name="userId"  type="text" style="display: none;" readonly value="0"/>
		<input id="userFIO" name="userFIO" type="text"  value="" placeholder="ИНН"/>
		<input id="serviceMan" name="serviceMan"  type="text"  value="" placeholder="КПП"/>
		<input id="save" name="save"  type="button"  value="Save" onclick="saveUser(0)"/>
	    </form>
	</div>
</div>
	<div id="userRulesSection">
	    
	</div>
