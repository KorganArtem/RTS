<%-- 
    Document   : index
    Created on : 19.12.2017, 15:31:57
    Author     : korgan
--%>

<%@page import="ru.leasicar.workerSql.CarSQL"%>
<%@ page language="java" contentType="text/html; charset=utf-8"%>
<!DOCTYPE html>
<%@ page import="ru.leasicar.authorization.*" %>

<html lang="us">
<head>
	<meta charset="utf-8">
        <!-- index.jsp -->
        
        <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<title>Lease Car</title>
        <meta http-equiv='Cache-Control' content='no-cache'>
        <meta http-equiv='Cache-Control' content='private'>
        <script src='https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>
        <script src='https://code.jquery.com/jquery-1.12.4.js'></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        <script type='text/javascript' src='https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js'></script>
        <link rel='stylesheet' type='text/css' href='https://cdn.datatables.net/v/dt/dt-1.10.16/datatables.min.css'/>
        <!--link rel='stylesheet' type='text/css'  href='css/datatabel.css'/-->
        <link rel='stylesheet' type='text/css'  href='/RTS/css/main.css'/>
        <link rel="stylesheet" type="text/css" href="/RTS/css/view.css" media="all">
        <script type="text/javascript" src="/RTS/js/view.js"></script>
    </head>
<body>
    <div class='place' style="
    width: 800px;
    margin: auto;
    padding: 20px;
" >
      
    </div>
</body>
<script>
    $("document").ready(function(){
	$.ajax({
		type: 'POST',
		//url: '/RTS/car/carEditForm.jsp',
		url: '../spending/carSpending.jsp',
		data:'id=135',
		success: function(data){
		    $(".place").html(data);
		}
	    });
    });
    $( "#menuBox" ).dialog({
        position: { my: "left top", at: "right top"},
        autoOpen: false,
        width: 200,
        show: {
            effect: "blind",
            duration: 1
        },
        hide: {
            effect: "explode",
            duration: 1
        }
    });
    $( "#menu" ).menu();
</script>
    <script src='/RTS/js/main.js'></script>
</html>