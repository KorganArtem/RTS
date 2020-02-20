/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
//////////////////////////////////////////////////////////////////////////////////
/////                             Show company list                           /////
////////////////////////////////////////////////////////////////////////////////


function showCompanies(){
    $('#workPlace').css('display', 'block');
    $.ajax({
        type: 'POST',
        url: 'company/company.jsp',
        success: function(data){
            $('#workPlace').html(data);
        },
        error:function (msg){
            alert('Error in geting car list!'+msg);
        }
    });
}
function editCompany(id){
    console.log(id);
    $("#inpINN_"+id).attr('readonly', false);
    $("#inpKPP_"+id).attr('readonly', false);
    $("#inpNAME_"+id).attr('readonly', false);
    $("#inpADDRESS_"+id).attr('readonly', false);
    $("#inpPhone_"+id).attr('readonly', false);
    $("#edit_"+id).css("display","none");
    $("#save_"+id).css("display","");
}
function saveCompany(id){
    if(id===0)
	var msg = $('#compNew').serialize();
    else
	var msg = $('#comp_'+id).serialize();
    $.ajax({
        type: 'POST',
        url: 'SaveCompany',
        data: msg,
        success: function(data){
	    $("#edit_"+id).css("display","");
	    $("#save_"+id).css("display","none");
	    if(id===0){
		$('#companyItemNew').css("display","none");
		showCompanies();
	    }
        }
    });
}
function delCompany(id){
    var msg = 'del=1&ID='+id;
    $.ajax({
        type: 'POST',
        url: 'SaveCompany',
        data: msg,
        success: function(data){
	    showCompanies();
        }
    });
}
function showNewForm(){
    $('#companyItemNew').css("display","block");
}
