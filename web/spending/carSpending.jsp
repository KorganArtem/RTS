
<%@ page language="java" contentType="text/html; charset=utf-8"%>
<div id="carSpendingAdd" style="padding: 20px;">
    <form id="sppendForm"> </form>
    <h4>ДОБАВЛЕНИЕ РАСХОДА</h4>
    <label>Тип расхода</label>
    <select name="spendType" form="sppendForm">
	<option value="to">ТО</option>
	<option value="repair">Плановый ремонт</option>
	<option value="forsmajor">Не предвиденный ремон</option>
	<option value="crash">ДТП</option>
	<option value="inshuranse">Страховка</option>
	<option value="other">Другое</option>
    </select>
    <label>Пробег</label>
    <input type="number" name="millage" form="sppendForm"/>
    <br>
    <br>
    <br>
    <br>
    <label>По вине водителя</label><input type="checkbox" value="по вине водителя" form="sppendForm"/>
    <br>
    <label>Стоимость работ</label>
    <input type="number" name="jobCost" form="sppendForm" id="jobCostTotal"/>
    <label>Стоимость материалов</label>
    <input type="number" name="zipCost" id="zipCostTot" form="sppendForm"/>
    <br>
    <form id="addZipForm"></form>
    <table id="zipListTable">
	<thead>
	<tr>
	    <th>PP</th>
	    <th>Наименование</th>
	    <th>Кол-во</th>
	    <th>Стоимость</th>
	    <th>Итого</th>
	    <th></th>
	</tr>
	</thead>
	<tr>
	    <td>0</td>
	    <td>
		<select name="zipNamen" form="addZipForm" style="width: 100px;">
		    <option value="101">Маслянный фильтр</option>
		    <option value="102">Воздушный фильтр</option>
		    <option value="103">Салонный фильтр</option>
		    <option value="104">Колодки задние</option>
		    <option value="105">Колодки предние</option>
		</select>
	    </td>
	    <td><input type="number" id="zipCount" name="zipCountn" form="addZipForm" onkeyup="counterIt()"/></td>
	    <td><input type="number" id="zipCost" name="zipCostn" form="addZipForm" onkeyup="counterIt()"/></td>
	    <td><input type="number" id="itemTotal" name="itemTotaln" form="addZipForm" readonly="true"/></td>
	    <td id="ziplistAdd">+</td>
	</tr>
    </table>
    <label>Total</label>
    <input type="number" id="totalCost" readonly="true" value="0" name="totalCostn"/>
    <input type="button" id="sendButton" value="Save"/>
</div>
<script>
  jobCostTotal.oninput = function() {
    countTotal();
  };
   var data = {};
   var totalZip = 0;
   var counter = 1;
    var ziplisttable = $('#zipListTable').DataTable({
	bSort: false,
	"paging": false,
	 "searching": false
    });
    $('#ziplistAdd').click(function(){
	var formdata = $("#addZipForm").serializeArray();
	$(formdata ).each(function(index, obj){
	    data[obj.name] = obj.value;
	});
	
	
	 ziplisttable.row.add( [
            counter,
            data['zipNamen'],
            data['zipCountn'],
            data['zipCostn'],
            data['itemTotaln'],
	    '<div onclick=deleteRow('+counter+')>x</div>'
        ] ).draw( false );
 
        counter++;
	
	totalZip=ziplisttable.column(4).data().sum();
	$("#zipCostTot").val(totalZip);
	$('#addZipForm')[0].reset();
	countTotal();
    });
    function countTotal(){
	var totalZip = parseInt($("#zipCostTot").val());
	var totalJob = parseInt($("#jobCostTotal").val());
	var total = totalJob+totalZip;
	$("#totalCost").val(total);
    }
    function deleteRow(number){
	var rowIdx = ziplisttable.column(0).data().indexOf(number);
	ziplisttable.row(rowIdx).remove();
	ziplisttable.draw();
	totalZip=ziplisttable.column(4).data().sum();
	$("#totalCost").val(totalZip);
    }
    function counterIt(){
	var total = $("#zipCount").val()*$("#zipCost").val();
	$("#itemTotal").val(total);
    }
    $("#sendButton").click(function(){
	ziplisttable.row(0).remove();
	var allData = ziplisttable.rows().data();
	var myJsonString = JSON.stringify(allData.toArray());
	var msg   = $('#sppendForm').serialize();
	console.log(myJsonString);
	$.ajax({
	    url: '../spendidgIn',
	    data: 'zip='+myJsonString+'&'+msg,
	    success: function(){
		alert('I have set!');
	    }
	});
	ziplisttable.draw();
    })
    jQuery.fn.dataTable.Api.register( 'sum()', function ( ) {
	return this.flatten().reduce( function ( a, b ) {
		if ( typeof a === 'string' ) {
			a = a.replace(/[^\d.-]/g, '') * 1;
		}
		if ( typeof b === 'string' ) {
			b = b.replace(/[^\d.-]/g, '') * 1;
		}

		return a + b;
	}, 0 );
    } );
</script>