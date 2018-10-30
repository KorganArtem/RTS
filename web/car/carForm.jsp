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
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <style>
        .containerForm{
            width: 1000px;
            margin: auto;
        }
        .rowInForm{
            display: block;
        }
        .itemInRow{
            float: left;
            padding-left: 15px;
        }
        .containerForm label{
            display: block;
        }
        select, input{
            width: 100%;
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
            width: 22%;
        }
    </style>
</head>
<body style="">
        <div class="containerForm">
            <form action="" id="CreateDriver" enctype="multipart/form-data" method="post">
                <div class="">
                    <div class="rowInForm col-4">
                        <div class="itemInRow">
                                <label for="">Модель авто</label>
                                <select name="car_model" class="CarModel form-control" id="SelectCarModel">
                                    <option value="" selected="">—</option>
                                </select>
                        </div>
                        <div class="itemInRow">
                                <label for="">Год выпуска</label>
                                <select name="car_year" class="CarYear form-control">
                                    <option value="">—</option>
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
                    <div class="rowInForm">
                        <div class="itemInRow">
                                <label for="">Гос номер</label>
                                <input type="text" class="form-control" name="driver_fio_rus" value="" placeholder="Иванов Иван Иванович">
                        </div>
                        <div class="itemInRow">
                                <label for="">Регион</label>
                                <input type="text" class="form-control" pattern="8\d{10}" placeholder="89851112233" name="driver_phone">
                        </div>
                        <div class="itemInRow">
                                <label for="">Номер СТС</label>
                                <input type="text" class="form-control" pattern="8\d{10}" placeholder="89851112233" name="driver_phone">
                        </div>
                    </div>
                </div>
            </form>
        </div>
</body>
</html>