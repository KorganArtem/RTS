/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$('#companyList').click(function(){
    $('.itemDisplay').css('display', 'none');
    $('.itemMenu').attr('disabled', false);
    $('#mainProp').attr('disabled', true);
    showCompanies()
});
$('#userList').click(function(){
    $('.itemDisplay').css('display', 'none');
    $('.itemMenu').attr('disabled', false);
    $('#mainProp').attr('disabled', true);
    showUsers()
});
$('#passChange').click(function(){
    $.ajax({
        type: 'POST',
        url: 'pasChange.jsp',
        success: function(data){
            $('#modalConteiner').html(data);
	    openModWind(180, 190);
	}
    });
});
