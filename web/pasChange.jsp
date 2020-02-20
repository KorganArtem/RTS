<%-- 
    Document   : pasChange
    Created on : Nov 24, 2019, 8:47:10 PM
    Author     : Artem Korgan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>


    <div class='passChangeConteiner'>
	<form id='chPassForm'>
	    <label>Старый пароль</label>
	    <input type='password' id='oldPass' name='oldPass' placeholder="Старый пароль" required />
	    <label>Новый пароль</label>
	    <input type='password' id='newPass' name='newPass' placeholder="Новый пароль" required />
	    <label>Подтверждение пароля</label>
	    <input type='password' id='confirmPass' name='confirmPass' placeholder="Подтверждение пароля" required />
	    <input type='submit' id='changePassButt' value='Сменить' onclick="sendNewPass()"/>
	<div id='errMess'></div>
	    
	</form>
    </div>
<script>
    function sendNewPass(){
	
    }
    $("#chPassForm").submit(function(e){
	var oldPass = $("#oldPass").val();
	var newPass = $("#newPass").val();
	var confirmPass = $("#confirmPass").val();
	if(newPass===confirmPass){
	    $.ajax({
	    type: 'POST',
	    url: 'CP',
	    data: 'oldpass='+oldPass+'&newpass='+newPass,
	    success: function(data){
		if(data==1){
		    alert('Пароль изменен!')
		    closeModWind();
		}
		else{
		    $('#errMess').html("Неверный пароль!!!")
		}
	    }
	});
	}
	else{
	    $('#errMess').html("Пароли не совпадают!!!")
	}
	return false;
    });
</script>