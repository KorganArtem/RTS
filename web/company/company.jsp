<%-- 
    Document   : company
    Created on : Nov 19, 2019, 10:39:52 PM
    Author     : Artem
--%>

<%@page import="java.util.Set"%>
<%@page import="java.util.Map"%>
<%@page import="ru.leasicar.workerSql.CompanySQL"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    CompanySQL csql = new CompanySQL();
    Map<Integer, Map> compList = csql.getCompanyList();
    Set<Integer> keys = compList.keySet();
    for(Integer key : keys){ %>
    <div class="companyItem item_<%= key %>"> 
	<form id="comp_<%= key %>" name="fcomp_<%= key %>">
		<input name="ID" id="ID_<%= key %>" type="text" style="display: none;" readonly value="<%= key %>"/>
	    
	    <div class="formIntem">
		<label>ИНН</label>
		<input name="inpINN" id="inpINN_<%= key %>" type="text" readonly value="<%= compList.get(key).get("inn") %>"/>
	    </div>
	    <div class="formIntem">
		<label>КПП</label>
		<input name="inpKPP" id="inpKPP_<%= key %>" type="text" readonly value="<%= compList.get(key).get("kpp") %>"/>
	    </div>
	    <div class="formIntem">
		<label>Название</label>
		<input name="inpNAME" id="inpNAME_<%= key %>" type="text" readonly value='<%= compList.get(key).get("name") %>'/>
	    </div>
	    <div class="formIntem">
		<label>Адрес</label>
		<input name="inpADDRESS" id="inpADDRESS_<%= key %>" type="text" readonly value="<%= compList.get(key).get("address") %>"/>
	    </div>
	    <div class="formIntem">
		<label>Телефон</label>
		<input name="inpPhone" id="inpPhone_<%= key %>" type="text" readonly value="<%= compList.get(key).get("phone") %>"/>
	    </div>
		<input name="save" id="save_<%= key %>" type="button" style="display: none;" value="Save" onclick="saveCompany(<%= key %>)"/>
		<input name="edit" id="edit_<%= key %>" type="button" value="Edit" onclick="editCompany(<%= key %>)"/>
		<input name="edit" id="edit_<%= key %>" type="button" value="Del" onclick="delCompany(<%= key %>)"/>
		
	    
	
	</form>
    </div>
    
    <%}
%>
<input type="button" value="Новая" onclick="showNewForm()"/>
   <div id="companyItemNew" style="display: none;"> 
	<form id="compNew" name="fcompNew">
	    <input name="ID"  type="text" style="display: none;" readonly value="0"/>
	    <input name="inpINN" type="text"  value="" placeholder="ИНН"/>
	    <input name="inpKPP"  type="text"  value="" placeholder="КПП"/>
	    <input name="inpNAME"  type="text"  value='' placeholder="Название"/>
	    <input name="inpADDRESS"  type="text"  value="" placeholder="Адрес"/>
	    <input name="inpPhone"  type="text"  value="" placeholder="Телефон"/>
	    <input name="save"  type="button"  value="Save" onclick="saveCompany(0)"/>
	</form>
    </div>
