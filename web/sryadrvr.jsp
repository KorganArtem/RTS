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
        $(document).ready(function() {
            getYa('b53db491026b445bbe2bc05880f26152');
            getYa('8203496c7a52479ab5035650b910fef3');
            getAllData('61f532420df640fd8741d3aacf732307', '8203496c7a52479ab5035650b910fef3');
           // getAllData('61f532420df640fd8741d3aacf732307', 'b53db491026b445bbe2bc05880f26152');
        });
        function getYa(token){
            $.ajax({
                type: 'POST',
                url: 'https://taximeter.yandex.rostaxi.org/api/driver/balance',
                data: 'apikey='+token,
                success: function(data){
                    console.log(data);
                    for(var row in data){
                        console.log(row);
                        getAllData(row, token);
                    }
                } ,
                error: function(msg){
                    console.log(msg);
                }
            });
        }
        function getAllData(yaId, token){
            $.ajax({
                type: 'POST',
                url: 'https://taximeter.yandex.rostaxi.org/api/driver/get',
                data: 'apikey='+token+'&id='+yaId,
                /*data: 'apikey=8203496c7a52479ab5035650b910fef3&id='+yaId,          */
                success: function(data){
                    console.log(data['driver']);
                    $('#box').after('<tr><td>'+yaId+'</td><td>' + data['driver']['LastName']+'</td>'
                                    +'<td>'+ data['driver']['FirstName']    +'</td>'+'<td>' + data['driver']['Phones']+'</td>'
                                    +'<td>' + parseInt(data['balance'])+'</td></tr>');;
                    
                } ,
                error: function(msg){
                    console.log(msg);
                }
            });
        }
    </script>
        
</html>
