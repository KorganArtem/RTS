<%-- 
    Document   : carForm
    Created on : 30.10.2018, 12:52:09
    Author     : korgan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class=" js "><head>
    <meta charset="utf-8">
    <title>GettPartner: Добавить новый ID</title>
        <script src='https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>
        <script src='https://code.jquery.com/jquery-1.12.4.js'></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        <link rel='stylesheet' type='text/css'  href='../css/main.css'/>
        <link rel="stylesheet" type="text/css" href="../css/view.css" media="all">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <style>
        div{
            overflow: hidden;
        }
        .containerForm{
            width: 800px;
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
        select, input{
            width: 98%;
            color: #555;
            background-image: none;
            border: 1px solid #fcb626;    
            box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
            transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;    
            display: block;
            height: 34px;
            font-size: 14px;
            line-height: 1.42857143;
        }
        .col-4 .itemInRow{
            width: 23%;
        }
        .col-6 .itemInRow{
            width: 15%;
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
<body style="">
    
        <div class="containerForm">
            <form action="" id="CreateDriver" enctype="multipart/form-data" method="post">
                <div>
                    <div class="itemInRow gosNum">
                                <label for="">Гос номер</label>
                                <input type="text" id="gosNum" style="text-transform:uppercase" size="6" class="form-control" name="driver_fio_rus" value="" placeholder="А111АА">
                                <input type="text" id="numReg"  size="3" class="form-control"  placeholder="777" name="driver_phone">
                        </div>
                </div>
                <div class="">
                    <div class="rowInForm col-4">
                        <div class="itemInRow">
                                <label for="">Модель авто</label>
                                <select name="car_model" class="CarModel form-control" id="SelectCarModel">
                                    <option value="" selected="">Выбрать модель</option>
                                </select>
                        </div>
                        <div class="itemInRow ">
                                <label for="">Год выпуска</label>
                                <select name="car_year" class="CarYear form-control">
                                    <option value="2010">2010</option>
                                    <option value="2011">2011</option>
                                    <option value="2012">2012</option>
                                    <option value="2013">2013</option>
                                    <option value="2014">2014</option>
                                    <option value="2015">2015</option>
                                    <option value="2016">2016</option>
                                    <option value="2017">2017</option>
                                    <option value="2018">2018</option>
                                </select>
                        </div>
                        <div class="itemInRow">
                                <label for="">Цвет а/м</label>
                                <select name="car_color_rus" class="CarColor form-control" id="CarColorMain">
                                    <option value="Бежевый">Бежевый</option>
                                    <option value="Белый">Белый</option>
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
                        </div>
                        <div class="itemInRow">
                                <label for="">Собственник</label>
                                <select name="car_color_rus" class="CarColor form-control" id="CarColorMain">
                                    <option value="Бежевый">Рай тур</option>
                                    <option value="Белый">Сетавиа</option>
                                </select>
                        </div>
                    </div>
                    <div class="rowInForm col-4">
                        <!--div class="itemInRow">
                                <label for="">Гос номер</label>
                                <input type="text" data-format="" id="gosNum" class="form-control" name="driver_fio_rus" value="" placeholder="А111АА">
                        </div>
                        <div class="itemInRow">
                                <label for="">Регион</label>
                                <input type="text" id="numReg" class="form-control" pattern="8\d{2-3}" placeholder="777" name="driver_phone">
                        </div-->
                        <div class="itemInRow">
                                <label for="">Номер СТС</label>
                                <input type="text" class="form-control" pattern="8\d{10}" placeholder="89851112233" name="driver_phone">
                        </div>
                        <div class="itemInRow">
                                <label for="">VIN</label>
                                <input type="text" class="form-control" pattern="[0-9a-zA-Z]{17}" placeholder="12345678901234567" name="driver_phone">
                        </div>
                    </div>
                    <div class="rowInForm col-6">
                        <div class="itemInRow">
                                <label for="">Полиса ОСАГО</label>
                                <input type="text" class="form-control" name="driver_fio_rus" value="" placeholder="Иванов Иван Иванович">
                        </div>
                        <div class="itemInRow">
                                <label for="">Срок действия</label>
                                <input type="text" class="form-control" pattern="8\d{10}" placeholder="89851112233" name="driver_phone">
                        </div>
                        <div class="itemInRow">
                                <label for="">Номер лицензии </label>
                                <input type="text" class="form-control" pattern="8\d{10}" placeholder="89851112233" name="driver_phone">
                        </div>
                        <div class="itemInRow">
                                <label for="">Срок действия</label>
                                <input type="text" class="form-control" name="driver_fio_rus" value="" placeholder="Иванов Иван Иванович">
                        </div>
                        <div class="itemInRow">
                                <label for="">Номер ДК</label>
                                <input type="text" class="form-control" pattern="8\d{10}" placeholder="89851112233" name="driver_phone">
                        </div>
                        <div class="itemInRow">
                                <label for="">Действительна до</label>
                                <input type="text" class="form-control" pattern="8\d{10}" placeholder="89851112233" name="driver_phone">
                        </div>
                    </div>
                </div>
            </form>
        </div>
    <script>
        $( "#gosNum" ).keyup(function(e) {
            var num = $( "#gosNum" ).val() ;
            var regexp = /[а-яё0-9]/i;
            if(!regexp.test(num[num.length-1])) {
                e.preventDefault();
                console.log("введите латинские символы");
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
    </script>
</body>
</html>