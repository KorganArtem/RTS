<%-- 
    Document   : carForm
    Created on : 30.10.2018, 12:52:09
    Author     : korgan
--%>

<%@page import="ru.leasicar.workerSql.CarSQL"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

    <style>
        .containerForm{
            overflow: hidden;
        }
        .containerForm{
            width: 550px;
            margin: auto;
            background-color: white;
            overflow: hidden;
            padding: 20px;
        }
        .rowInForm{
            display: block;
        }
        .itemInRow{
            float: left;
            padding-left: 13px;
        }
        .containerForm label{
            display: block;
        }
        .editable select, .editable select input{
            text-transform:uppercase;
            color: #555;   
            box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
            transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;    
            display: block;
            height: 30px;
            font-size: 14px;
            line-height: 1.42857143;
            width: 100%;
            display: initial;
            text-align: center;
            border: none;
            border-bottom: 1px solid #56698f;
            background-color: white;
            padding: 0px 0px 0px 0px;
        }
        .editable select{
            height: 31px;
        }
        .carLic input{
            width: auto;                
            display: initial;
            text-align: center;
            border: none;
            border-bottom: 1px solid #56698f;
        }
        #carVIN{
            width: 130px;
        }
        #carSTS{
            width: 80px;
        }
        .gosNum input{
            width: auto;                
            display: initial;
            text-align: center;
            border: none;
            border-bottom: 1px solid #56698f;
        }
    </style>
</head>
<%
    CarSQL wsql = new CarSQL();
    String modelList = wsql.modelLisc();
    %>
<body style="">
    <div class="containerForm">
        <form  id="createCar" enctype="multipart/form-data" method="post">
            <div>
                <div class="rowInForm">
                    <h3> Основная информация </h3>
                    <div class="itemInRow gosNum  ">
                        <label for="gosNum">Гос номер</label>
                        <input type="text" id="gosNum" name="gosNum" size="6"  placeholder="А111АА" class="editable">
                        <input type="text" id="numReg" name="numReg" size="3"  placeholder="777" class="editable">
                    </div>
                    <div class="itemInRow">
                        <label for="carSTS">Номер СТС</label>
                        <input type="text" id="carSTS" name="carSTS" size="10" class="form-control editable" pattern="\d{10}" placeholder="7712345678" maxlength="10">
                    </div>
                    <div class="itemInRow">
                        <label for="carVIN">VIN</label>
                        <input type="text" id="carVIN" name="carVIN" class="form-control editable" size="18" pattern="[0-9A-Z]{17}" placeholder="12345678901234567" maxlength="17">
                    </div>
                    <div class="itemInRow">
                        <label for="CarOwner">Собственник</label>
                        <select name="carOwner" class="CarColor form-control editable" id="CarOwner">
                            <option value="1">Рай тур</option>
                            <option value="2">Сетавиа</option>
                        </select>
                    </div>
                </div>
                <div class="rowInForm">
                    <h3> Техническая информация </h3>
                    <div class="itemInRow">
                        <label for="carState">Статус</label>
                        <select id="carState" name="carState" class="CarModel form-control editable" >
                            <option value="1">ГОТОВА К ВЫДАЧЕ</option>
                            <option value="2">НА ЛИНИИ</option>
                            <option value="3">РЕМОНТ</option>
                            <option value="4">ДТП</option>
                            <option value="5">ДТП ПО ВИНЕ ВОДИТЕЛЯ</option>
                            <option value="6">ЗАБЛОКИРОВАННА</option>
                        </select>
                    </div>
                    <div class="itemInRow">
                        <label for="carModel">Модель авто</label>
                        <select id="carModel" name="carModel" class="CarModel form-control editable" >
                            <%= modelList %>
                        </select>
                    </div>
                    <div class="itemInRow ">
                        <label for="carYear">Год выпуска</label>
                        <select id="carYear" name="carYear" class="CarYear form-control editable">
                            <option value="2014">2014</option>
                            <option value="2015">2015</option>
                            <option value="2016">2016</option>
                            <option value="2017">2017</option>
                            <option value="2018">2018</option>
                        </select>
                    </div>
                    <div class="itemInRow">
                        <label for="CarColorMain">Цвет а/м</label>
                        <select id="CarColorMain" name="CarColorMain" class="CarColor form-control editable" >
                            <option value="Белый">Белый</option>
                            <option value="Бежевый">Бежевый</option>
                            <option value="Бордовый">Бордовый</option>
                            <option value="Голубой">Голубой</option>
                            <option value="Желтый">Желтый</option>
                            <option value="Зеленый">Зеленый</option>
                            <option value="Золотой">Золотой</option>
                            <option value="Коричневый">Коричневый</option>
                            <option value="Красный">Красный</option>
                            <option value="Оранжевый">Оранжевый</option>
                            <option value="Пурпурный">Пурпурный</option>
                            <option value="Розовый">Розовый</option>
                            <option value="Серебряный">Серебряный</option>
                            <option value="Серый">Серый</option>
                            <option value="Синий">Синий</option>
                            <option value="Фиолетовый">Фиолетовый</option>
                            <option value="Черный">Черный</option>
                        </select>
                    </div><div class="itemInRow">
                        <label for="CarColorMain">Цветовая схема</label>
                        <select id="carSchem" name="carSchem" class="CarColor form-control editable" >
                            <option value="1">Яндекс</option>
                            <option value="2">Ситимобил</option>
                            <option value="3">Get</option>
                        </select>
                    </div>
                    <div class="itemInRow ">
                        <label for="carTransmission">Трансмиссия</label>
                        <select id="carTransmission" name="carTransmission" class="form-control editable">
                            <option value="1">МКПП</option>
                            <option value="2">АКПП</option>
                        </select>
                    </div>
                    <div class="itemInRow ">
                        <label for="carTransmission">Время выхода на линию</label>
                        <input type="time" id="outTime" name="outTime" min="9:00" max="18:00" value="10:00" class="form-control editable" required>
                    </div>
                </div>
                        <br>
                <div class="rowInForm">
                    <div class="itemInRow">
                        <label for="carRent">Аренда</label>
                        <input id="carRent" name="carRent" size="5" type="text" class="form-control editable"  placeholder="12345678">
                    </div>
                    <div class="itemInRow">
                        <label for="carMileage">Пробег</label>
                        <input id="carMileage" name="carMileage" size="6" type="text" class="form-control editable"  placeholder="12345678">
                    </div>
                    <div class="itemInRow">
                        <label for="carLastTOM">Последнее ТО</label>
                        <input id="carLastTOM" name="carLastTOM" size="6" type="text" class="form-control editable"  >
                    </div>
                    <div class="itemInRow">
                        <label for="carLastTOD">Дата </label>
                        <input id="carLastTOD" name="carLastTOD" type="date" class="form-control editable"/>
                    </div>
                    <div class="itemInRow">
                        <label for="carGlanasID">ID ГЛОНАС</label>
                        <input id="carGlanasID" name="carGlanasID" size="10" type="text" class="form-control editable"  placeholder="12345678">
                    </div>
                </div>
                <div class="rowInForm">
                    <h3> Документы </h3>
                    <div class="itemInRow">
                        <div>   
                            <label for="carOSAGONumber">Полиса ОСАГО</label>
                            <input id="carOSAGONumber" name="carOSAGONumber" type="text" class="form-control editable"  placeholder="  ААА5003573870">
                        </div>
                        <div>
                            <label for="carOSAGODate">Срок действия</label>
                            <input id="carOSAGODate" name="carOSAGODate" type="date" class="form-control editable">
                        </div>
                        <div>
                            <label for="carOSAGODate">Срок действия</label>
                            <select id="carOSAGODate" name="insuranceCompany" class="form-control editable">
                                <option value="1">РосгосСтрах</option>
                            </select>
                        </div>
                    </div>
                    <div class="itemInRow">
                        <div class="carLic">
                            <label for="carLicNumber">Номер лицензии </label>
                            <input id="carLicNumber" name="carLicNumber" type="text" size="4" class="form-control editable" pattern="8\d{10}" placeholder="" >
                            <input id="carLicNumber" name="carLicNumber" type="text" size="2" class="form-control editable" pattern="8\d{10}" placeholder="" >
                            <input id="carLicNumber" name="carLicNumber" type="text" size="4" class="form-control editable" pattern="8\d{10}" placeholder="" >
                        </div>
                        <div>
                            <label for="carLicDate">Срок действия</label>
                            <input id="carLicDate" name="carLicDate" type="date" class="form-control editable">
                        </div>
                    </div>
                    <div class="itemInRow">
                        <div>
                            <label for="carDCNumber">Номер ДК</label>
                            <input id="carDCNumber" name="carDCNumber" type="text" class="form-control editable" pattern="8\d{10}" placeholder="89851112233">
                        </div>
                        <div>
                            <label for="carDCDate">Срок действия</label>
                            <input id="carDCDate" name="carDCDate" type="date" class="form-control editable">
                        </div>
                    </div>
                </div>
            </div>
        </form>
        <input id="editor" type="button" value="Редактировать"/>
        <input id="sendCarForm" type="button" value="Сохранить"/>
    </div>
    <script>
        $(document).ready(function(){
            $( ".editable" ).prop( "disabled", true );
            $( "#editor" ).prop( "disabled", false );
                $( "#sendCarForm" ).prop( "disabled", false );
        });
        $("#editor").click(function(){  
            if($( ".editable" ).prop( "disabled")){
                $( ".editable" ).prop( "disabled", false );
            }
            else{
                $( "editable" ).prop( "disabled", true );
                $( "#editor" ).prop( "disabled", false );
                $( "#sendCarForm" ).prop( "disabled", false );
            }
        });
        $( "#gosNum" ).keyup(function(e) {
            var num = $( "#gosNum" ).val() ;
            var regexp = /[а-яё0-9]/i;
            if(!regexp.test(num[num.length-1])) {
                e.preventDefault();
                console.log("введите латинские символы");
                $( "#gosNum" ).val(num.substr(0, num.length-1));
            }
            if($.isNumeric(num[0])) {
                $( "#gosNum" ).val(num.substr(0, num.length-1));
            }
            if(num.length > 1 && num.length < 5){
                console.log('Num part');
                if(!$.isNumeric(num[num.length-1])){
                    $( "#gosNum" ).val(num.substr(0, num.length-1));
                }
            }
            if(num.length===5){
                console.log(num[4]);
                if($.isNumeric(num[4])){
                    $( "#gosNum" ).val(num.substr(0, 4));
                    $( "#numReg" ).focus();
                    $( "#numReg" ).val(num[4]);
                }
            }
            if(num.length===6){
                $( "#numReg" ).focus();
            }
          });
          $("#sendCarForm").click(function(){
              var msg   = $('#createCar').serialize();
                $.ajax({
                    type: 'POST',
                    url: 'CAS',
                    data: msg,
                    success: function(data){
                        
                    }
                });
          });
          
    </script>