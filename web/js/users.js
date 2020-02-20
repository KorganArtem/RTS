/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function showUsers(){
    $('#workPlace').css('display', 'block');
    $.ajax({
        type: 'POST',
        url: 'user/users.jsp',
        success: function(data){
            $('#workPlace').html(data);
        },
        error:function (msg){
            alert('Error in geting users list!'+msg);
        }
    });
}

function editUser(id){
    console.log(id);
    $("#inpPhone_"+id).attr('readonly', false);
    $("#edit_"+id).css("display","none");
    $("#save_"+id).css("display","");
    $.ajax({
        type: 'POST',
        url: 'user/userRules.jsp',
        data: 'userId='+id,
        success: function(data){
	    $("#userRulesSection").html(data);
        }
    });
    $("#userFIO_"+id).attr('readonly', false);
    $("#inpPhone_"+id).attr('readonly', false);
}
function saveUser(id){
    if(id===0)
	var msg = $('#userNew').serialize();
    else{
	var msg = $('#user_'+id).serialize();
	var userRules = $('#userRule_'+id).serialize();
	console.log(userRules);
	console.log(msg);
    }
    $.ajax({
        type: 'POST',
        url: 'SaveUserRules',
        data: userRules,
        success: function(data){
        }
    });
    if(id!=0){
	$.ajax({
	    type: 'POST',
	    url: 'SaveUser',
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
    
}
function delUser(id){
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
    $('#userItemNew').css("display","block");
}

$("#logOut").click(function(){
    if(confirm('Вы действительно хотите выйти из программы?')){
	$.ajax({
	    type: 'POST',
	    url: 'LO',
	    success: function(data){
		location.href = 'auth.jsp';
	    }
	});
    }
});