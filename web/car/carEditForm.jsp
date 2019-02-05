<%-- 
    Document   : carForm
    Created on : 30.10.2018, 12:52:09
    Author     : korgan
--%>

<%@page import="java.util.Map"%>
<%@page import="ru.leasicar.workerSql.CompanySQL"%>
<%@page import="ru.leasicar.workerSql.CarSQL"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

    <style>
        .containerForm{
            overflow: hidden;
        }
        .containerForm{
            width: 740px;
            margin: auto;
            background-color: white;
            overflow: hidden;
            padding: 20px;
        }
        .rowInForm{
            display: block;
            overflow: hidden;
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
    CompanySQL compSQL = new CompanySQL();
    Map<String, String> carData = wsql.getCarData(Integer.parseInt(request.getParameter("id")));
    String companySelect = compSQL.getCompanyListSelect(Integer.parseInt(carData.get("carOwner")));
    modelList = wsql.modelLisc(Integer.parseInt(carData.get("model")));
    String stateList = wsql.stateList(Integer.parseInt(carData.get("state")));
    String insList = wsql.insCompList(Integer.parseInt(carData.get("insuranceCompany")));
    %>
<body style="">
    <div class="containerForm">
        <form  id="createCar" enctype="multipart/form-data" method="post">
            <div>
                <div class="rowInForm">
                    <h3> Основная информация </h3>
                    <div class="itemInRow gosNum  ">
                        <label for="gosNum">Гос номер</label>
                        <input required type="text" id="gosNum" name="gosNum" size="6" value="<%= carData.get("number") %>" placeholder="А111АА" class="editable">
                        <input required type="text" id="numReg" name="numReg" size="3" value="<%= carData.get("regGosNumber") %>" placeholder="777" pattern="\d{3}" class="editable">
                    </div>
                    <div class="itemInRow">
                        <label for="carSTS">Номер СТС</label>
                        <input required type="text" id="carSTS" name="carSTS" size="10" value="<%= carData.get("sts") %>" class="form-control editable" pattern="\d{10}" placeholder="7712345678" maxlength="10">
                    </div>
                    <div class="itemInRow">
                        <label for="carVIN">VIN</label>
                        <input required type="text" id="carVIN" name="carVIN" size="18" value="<%= carData.get("VIN") %>" pattern="[0-9A-Z]{17}" placeholder="12345678901234567" maxlength="17" class="form-control editable">
                    </div>
                    <div class="itemInRow">
                        <label for="CarOwner">Собственник</label>
                        <select name="carOwner" class="CarColor form-control editable" id="CarOwner">
                            <%= companySelect %>
                        </select>
                    </div> 
                    <div class="itemInRow">
                        <label for="carState">Статус</label>
                        <select id="carState" name="carState" class="CarModel form-control editable" >
                            <%= stateList %>
                        </select>
                    </div>
                </div>
                <div class="rowInForm">
                    <h3> Техническая информация </h3>
                    
                    <div class="itemInRow">
                        <label for="carModel">Модель авто</label>
                        <select id="carModel" name="carModel" class="CarModel form-control editable" >
                            <%= modelList %>
                        </select>
                    </div>
                    <div class="itemInRow ">
                        <label for="carYear">Год выпуска</label>
                        <select id="carYear" name="carYear" class="CarYear form-control editable">
                            <option value="2015" <% if(carData.get("year").equals("2015")){ %> selected <%}%> >2015</option>
                            <option value="2016" <% if(carData.get("year").equals("2016")){ %> selected <%}%> >2016</option>
                            <option value="2017" <% if(carData.get("year").equals("2017")){ %> selected <%}%> >2017</option>
                            <option value="2018" <% if(carData.get("year").equals("2018")){ %> selected <%}%> >2018</option>
                            <option value="2019" <% if(carData.get("year").equals("2019")){ %> selected <%}%> >2019</option>
                        </select>
                    </div>
                    <div class="itemInRow">
                        <label for="CarColorMain">Цвет а/м</label>
                        <select id="CarColorMain" name="CarColorMain" class="CarColor form-control editable" >
                            <option value="Белый" <% if(carData.get("carColor").equals("Белый")){ %> selected <%}%> >Белый</option>
                            <option value="Бежевый" <% if(carData.get("carColor").equals("Бежевый")){ %> selected <%}%> >Бежевый</option>
                            <option value="Бордовый" <% if(carData.get("carColor").equals("Бордовый")){ %> selected <%}%> >Бордовый</option>
                            <option value="Голубой" <% if(carData.get("carColor").equals("Голубой")){ %> selected <%}%> >Голубой</option>
                            <option value="Желтый" <% if(carData.get("carColor").equals("Желтый")){ %> selected <%}%> >Желтый</option>
                            <option value="Зеленый" <% if(carData.get("carColor").equals("Зеленый")){ %> selected <%}%> >Зеленый</option>
                            <option value="Золотой" <% if(carData.get("carColor").equals("Золотой")){ %> selected <%}%> >Золотой</option>
                            <option value="Коричневый" <% if(carData.get("carColor").equals("Коричневый")){ %> selected <%}%> >Коричневый</option>
                            <option value="Красный" <% if(carData.get("carColor").equals("Красный")){ %> selected <%}%> >Красный</option>
                            <option value="Оранжевый" <% if(carData.get("carColor").equals("Оранжевый")){ %> selected <%}%> >Оранжевый</option>
                            <option value="Пурпурный" <% if(carData.get("carColor").equals("Пурпурный")){ %> selected <%}%> >Пурпурный</option>
                            <option value="Розовый" <% if(carData.get("carColor").equals("Розовый")){ %> selected <%}%> >Розовый</option>
                            <option value="Серебряный" <% if(carData.get("carColor").equals("Серебряный")){ %> selected <%}%> >Серебряный</option>
                            <option value="Серый" <% if(carData.get("carColor").equals("Серый")){ %> selected <%}%> >Серый</option>
                            <option value="Синий" <% if(carData.get("carColor").equals("Синий")){ %> selected <%}%> >Синий</option>
                            <option value="Фиолетовый" <% if(carData.get("carColor").equals("Фиолетовый")){ %> selected <%}%> >Фиолетовый</option>
                            <option value="Черный" <% if(carData.get("carColor").equals("Черный")){ %> selected <%}%> >Черный</option>
                        </select>
                    </div><div class="itemInRow">
                        <label for="CarColorMain">Цветовая схема</label>
                        <select id="carSchem" name="carSchem" class="CarColor form-control editable" >
                            <option value="1">Яндекс</option>
                            <option value="2">Ситимобил</option>
                            <option value="3">Get</option>\
                            <option value="4">Без брэнда</option>
                        </select>
                    </div>
                    <div class="itemInRow ">
                        <label for="carTransmission">Трансмиссия</label>
                        <select id="carTransmission" name="carTransmission" class="form-control editable">
                            <option value="1" <% if(carData.get("transmission").equals("1")){ %> selected <%}%> >МКПП</option>
                            <option value="2" <% if(carData.get("transmission").equals("2")){ %> selected <%}%> >АКПП</option>
                        </select>
                    </div>
                    <div class="itemInRow ">
                        <label for="carTransmission">Время выхода на линию</label>
                        <input required type="time" id="outTime" name="outTime" min="7:00" max="21:00" value="<%= carData.get("outTime") %>" class="form-control editable" required>
                    </div>
                </div>
                        <br>
                <div class="rowInForm">
                    <div class="itemInRow">
                        <label for="carRent">Аренда</label>
                        <input required id="carRent" name="carRent" size="5" value="<%= carData.get("cost") %>"  type="text" class="form-control editable" pattern="\d{1-5}" placeholder="12345678">
                    </div>
                    <div class="itemInRow">
                        <label for="carMileage">Пробег</label>
                        <input required id="carMileage" name="carMileage" size="6" value="<%= carData.get("carMileage") %>"  type="text" pattern="[0-9]{1-6}" class="form-control editable"  placeholder="12345678">
                    </div>
                    <div class="itemInRow">
                        <label for="carLastTOM">Последнее ТО</label>
                        <input required id="carLastTOM" name="carLastTOM" size="6" value="<%= carData.get("lastService") %>"  type="text" pattern="\d{1-6}" class="form-control editable"  >
                    </div>
                    <div class="itemInRow">
                        <label for="carLastTOD">Дата </label>
                        <input required id="carLastTOD" name="carLastTOD" type="date" value="<%= carData.get("lastServiceDate") %>"  class="form-control editable"/>
                    </div>
                    <div class="itemInRow">
                        <label for="carGlanasID">ID ГЛОНАС</label>
                        <input required id="carGlanasID" name="carGlanasID" size="10" value="<%= carData.get("glanasId") %>"  type="text" class="form-control editable"  placeholder="12345678">
                    </div>
                </div>
                <div class="rowInForm">
                    <h3> Документы </h3>
                    <div class="itemInRow">
                        <div>   
                            <label for="carOSAGONumber">Полиса ОСАГО</label>
                            <input required id="carOSAGONumber" name="carOSAGONumber" value="<%= carData.get("insuranceNamber") %>"  type="text" class="form-control editable"  placeholder="  ААА5003573870">
                        </div>
                        <div>
                            <label for="carOSAGODate">Срок действия</label>
                            <input required id="carOSAGODate" name="carOSAGODate" type="date" value="<%= carData.get("insuranceDateEnd") %>"  class="form-control editable">
                        </div>
                        <div>
                            <label for="carOSAGOCompany">Страховая Компания</label>
                            <select id="carOSAGOCompany" name="insuranceCompany" class="form-control editable">
                                <%= insList %>
                            </select>
                        </div>
                    </div>
                    <div class="itemInRow">
                        <div class="carLic">
                            <label for="carLicNumber">Номер лицензии </label>
                            <input required id="carLicNumber" name="carLicNumber" type="text" size="12" value="<%= carData.get("licNumber") %>"  class="form-control editable" placeholder="" >
                        </div>
                        <div>
                            <label for="carLicDate">Срок действия</label>
                            <input required id="carLicDate" name="carLicDate" type="date" value="<%= carData.get("licEndDate") %>"  class="form-control editable">
                        </div>
                    </div>
                    <div class="itemInRow">
                        <div>
                            <label for="carDCNumber">Номер ДК</label>
                            <input required id="carDCNumber" name="carDCNumber" type="text" value="<%= carData.get("ttoNumber") %>"  class="form-control editable" pattern="\d{15}" placeholder="">
                        </div>
                        <div>
                            <label for="carDCDate">Срок действия</label>
                            <input required id="carDCDate" name="carDCDate" type="date" value="<%= carData.get("ttoEndDate") %>"  class="form-control editable">
                        </div>
                    </div>
                </div>
            </div>
            <div style="display: none">
                <input type="text" name="carId" value="<%= carData.get("id") %>"/>
                <input type="text" name="oldState" value="<%= carData.get("state") %>"/>
            </div>
            
        <input id="editor" type="button" value="Редактировать"/>
        <input id="sendCarForm1" type="submit" value="Сохранить"/>
        
        </form>
    </div>
    <script>
        $(document).ready(function(){
            $( ".editable" ).prop( "disabled", true );
            $( "#editor" ).prop( "disabled", false );
                $( "#sendCarForm" ).prop( "disabled", false );
        });
        $("#createCar").submit(function(){
            var msg   = $('#createCar').serialize();
                $.ajax({
                    type: 'POST',
                    url: 'CAS',
                    data: msg,
                    success: function(data){
                        closeModWind();
                    }
                });
            return false;
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