<%-- 
    Document   : addDriverNew
    Created on : 17.04.2018, 20:10:58
    Author     : korgan
--%>

<%@page import="java.util.Date"%>
<%@page import="com.ibm.icu.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="ru.leasicar.workerSql.*"%>
<% 
    DriverSQL dsql = new DriverSQL(); 
    CarSQL csql = new CarSQL(); 
    SimpleDateFormat sdt = new SimpleDateFormat("yyyy-MM-dd");
    String dateYerMore =sdt.format(new Date().getTime());
%>
    <div id="form_container">
        <form id="addDriverFormN" class="appnitro"  method="post" >
            <div class="form_description">
                <h2>Добавление водителя</h2>
            </div>	
            <ul >
                <li id="li_1" >
                    <span>
			<input id="element_1_1" name= "lastName" class="element text" size="14" value=""/>
			<label>Фамилия</label>
                    </span>
                    <span>
                        <input id="element_1_2" name= "firstName" class="element text" size="14" value=""/>
                        <label>Имя</label>
                    </span> 
                    <span>
                        <input id="element_1_2" name= "midlName" class="element text" size="14" value=""/>
                        <label>Отчество</label>
                    </span> 
		</li>
                <li id="li_1" >
                    <span>
			<input id="element_1_1" name= "mainPhone" class="element text" size="14" value=""/>
			<label>Моб. Тел.</label>
                    </span>
                    <span>
                        <input id="element_1_2" name= "addPhone" class="element text" size="14" value=""/>
                        <label>Доп. Тел.</label>
                    </span> 
                    <span>
                        <input id="element_1_2" name= "email" class="element text" size="14" value=""/>
                        <label>Email</label>
                    </span> 
		</li>
                <li id="li_1" >
                    <span>
			<input type="date" id="element_1_1" name= "bornDate" class="element date" size="14" value="2000-01-01"/>
			<label>Дата рождения</label>
                    </span>
                    <span>
                        <input type="date" id="element_1_2" name= "addDate" class="element date" size="14" value="<%= dateYerMore %>"/>
                        <label>Дата принятия</label>
                    </span> 
                    <span>
                        <input type="date" id="element_1_2" name= "delDate" class="element date" size="14"/>
                        <label>Дата увольнения</label>
                    </span> 
		</li>
                <li id="li_1" >
                    <label class="description" for="element_3">Паспорт </label>
                    <span>
			<input id="element_1_1" name= "passportNumber" class="element text"  size="14" value=""/>
			<label>Серия номер</label>
                    </span>
                    <span>
                        <input type="date" id="element_1_2" name= "passportDate" class="element text" size="14" value="2000-01-01"/>
                        <label>Дата выдачи</label>
                    </span> 
                    <span>
                        <input id="element_1_2" name= "passportFrom" class="element text" size="14" value=""/>
                        <label>Выдан</label>
                    </span> 
		</li>	
                <li id="li_1" >
                    <label class="description" for="element_3">Водительское удостоверение </label>
                    <span>
			<input id="element_1_1" name= "vyNumber" class="element text"  size="14" value=""/>
			<label>Серия номер</label>
                    </span>
                    <span>
                        <input type="date" id="element_1_2" name= "vyDate" class="element text" size="14" value="2000-01-01"/>
                        <label>Дата выдачи</label>
                    </span> 
                    <span>
                        <input id="element_1_2" name= "vyFrom" class="element text" size="14" value=""/>
                        <label>Кем выдано</label>
                    </span> 
		</li>		
                <li id="li_3" >
                    
                    <div id="address">
                        <label class="description" for="element_3">Адрес </label>
                        <div class="left">
                                <input id="element_3_3" name="country" class="element text medium" value="" type="text">
                                <label for="element_3_3">Страна</label>
                        </div>
                        <div class="right">
                                <input id="element_3_4" name="province" class="element text medium" value="" type="text">
                                <label for="element_3_4">Область</label>
                        </div>
                        <div class="left">
                                <input id="element_3_5" name="city" class="element text medium"  value="" type="text">
                                <label for="element_3_5">Город</label>
                        </div>
                        <div class="right">
                            <input id="element_3_5" name="strit" class="element text medium"  value="" type="text">
                            <label for="element_3_6">Улица</label>
                        </div> 
                        <span>
                            <input id="element_1_1" name= "house" class="element text"  size="9" value=""/>
                            <label>Дом</label>
                        </span>
                        <span>
                            <input id="element_1_2" name= "building" class="element text"  size="9" value=""/>
                            <label>Корпус/Строение</label>
                        </span> 
                        <span>
                            <input id="element_1_2" name= "flat" class="element text"  size="9" value=""/>
                            <label>Квартира</label>
                        </span> 
                        <span>
                            <input id="element_1_2" name= "postCode" class="element text"  size="9" value=""/>
                            <label>Индекс</label>
                        </span> 
                    </div>
                    <div id="addAddress">
                        <label class="description" for="element_3">Почтовый адрес </label>
                        <div class="left">
                                <input id="element_3_3" name="addCountry" class="element text medium" value="" type="text">
                                <label for="element_3_3">Страна</label>
                        </div>
                        <div class="right">
                                <input id="element_3_4" name="addProvince" class="element text medium" value="" type="text">
                                <label for="element_3_4">Область</label>
                        </div>
                        <div class="left">
                                <input id="element_3_5" name="addCity" class="element text medium"  value="" type="text">
                                <label for="element_3_5">Город</label>
                        </div>
                        <div class="right">
                            <input id="element_3_5" name="addStrit" class="element text medium"  value="" type="text">
                            <label for="element_3_6">Улица</label>
                        </div> 
                        <span>
                            <input id="element_1_1" name= "addHouse" class="element text"  size="9" value=""/>
                            <label>Дом</label>
                        </span>
                        <span>
                            <input id="element_1_2" name= "addBuilding" class="element text"  size="9" value=""/>
                            <label>Корпус/Строение</label>
                        </span> 
                        <span>
                            <input id="element_1_2" name= "addFlat" class="element text"  size="9" value=""/>
                            <label>Квартира</label>
                        </span> 
                        <span>
                            <input id="element_1_2" name= "addPostCode" class="element text"  size="9" value=""/>
                            <label>Индекс</label>
                        </span> 
                    </div>
		</li>		
                <li id="li_5" >
                    <label class="description" for="element_5">Аренда </label>
                    <span>
                        <select class="element  " style="width: 100px;" id="element_5" name="car"> 
                            <%= csql.getFreeCarList()%>
                        </select>
                        <label>Машина</label>
                    </span> 
                    <span>
                        <select class="element  " style="width: 100px;" id="element_5" name="shedule"> 
                            <option value='0'>Без выходных</option>
                            <option value='11'>10/1</option>
                            <option value='7'>6/1</option>
                        </select>
                        <label>График</label>
                    </span> 
                    <span>
                        <input id="element_1_2" name= "dayRent" class="element text"  size="9" value="0"/>
                        <label>Аренда</label>
                    </span> 
                    <span>
                        <input id="element_1_2" name= "debtLimit" class="element text"  size="8" value="0"/>
                        <label>Лимит</label>
                    </span> 
			
                    <span>
                        <input type='checkbox' id='takeDep' name='dopPay' />
                        <label style="float: left">Списывать депозит</label>
                    </span>
                    <!--span>
                        <input type='text' id='yaId' name='yaId' value='' />
                        <label>yaId</label>
                    </span--> 
		</li>	
		
                <li id="li_4" >
                    <label class="description" for="element_4">Комментарий </label>
                    <div>
			<textarea id="element_4" name="comment" class="element textarea medium"></textarea> 
                    </div> 
		</li>
                <li class="buttons">
                    <input type="hidden" name="form_id" value="6362" />
                    <input id="saveForm" class="button_text" type="button" onClick="addDriverN()" name="submit" value="Сохранить" />
                    <input id="saveForm" class="button_text" type="button" onClick="closeModWind()" name="submit" value="Отмена" />
		</li>
            </ul>
	</form>	
    </div>
    <img id="bottom" src="bottom.png" alt="">