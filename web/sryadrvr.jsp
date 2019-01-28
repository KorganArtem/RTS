<%-- 
    Document   : sryadrvr
    Created on : 22.03.2018, 14:54:49
    Author     : korgan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script src='https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>
    </head>
    <body>
        <h1>Hello World!</h1>
        <table id="box"></table>
    </body>
    
    <script>
        $.ajax({
            type: 'POST',
            url: 'https://taximeter.yandex.rostaxi.org/api/driver/balance',
            data: 'apikey=b53db491026b445bbe2bc05880f26152',
            /*data: 'apikey=8203496c7a52479ab5035650b910fef3',*/
            success: function(data){
                for(var row in data){
                    getAllData(row);
                }
            } ,
            error: function(msg){
                console.log(msg);
            }
        });
        function getAllData(yaId){
            $.ajax({
                type: 'POST',
                url: 'https://taximeter.yandex.rostaxi.org/api/driver/get',
                data: 'apikey=b53db491026b445bbe2bc05880f26152&id='+yaId,
                /*data: 'apikey=8203496c7a52479ab5035650b910fef3&id='+yaId,*/
                success: function(data){
                    console.log(data['driver']['LastName']);
                    $('#box').after('<tr><td>'+yaId+'</td><td>' + data['driver']['LastName']+'</td>'
                                    +'<td>' + data['driver']['FirstName']+'</td>'+'<td>' + data['driver']['Phones']+'</td>'
                                    +'<td>' + parseInt(data['balance'])+'</td></tr>');;
                    
                } ,
                error: function(msg){
                    console.log(msg);
                }
            });
        }
    </script>
        
</html>
