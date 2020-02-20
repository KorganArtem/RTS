/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var showFilter = false;

$('#openDriverFilter').click(function(){
    if(showFilter){
	$('#driverListFilter').css('display', 'none');
	$('#listDriver').css('padding-top', '1px');
	
	showFilter = false;
    }else{
	$('#driverListFilter').css('display', 'block');
	showFilter=true;
    }
});
$('#searchButton').click(function(){
    var driversFilter   = $('#driverFilterForm').serialize();
    listDriverShowFiltred(driversFilter);
});
