<%-- 
    Document   : CaerEdit
    Created on : 15.10.2018, 14:11:37
    Author     : korgan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="../css/app.css?id=97df80879d9fc021ddb2">
        <link rel="stylesheet" href="../css/login-promo.css">
        <link rel="stylesheet" href="../css/wickedpicker.css">
    </head>
    <body>
        <div class="col-lg-9 col-md-9 col-sm-12 col-xs-12 fleet">
            <div class="floatleft"><h3>Добавить АМ</h3></div>
            <div class="row"></div>
            <div class="grid-80 prefix-20 main admin driver-add">
                <div class="page-resp driver-add">
                    <div class="row">
                        <form action="https://gettpartner.ru/fleet/drivers/add/ajax" id="CreateDriver" enctype="multipart/form-data" method="post">
                            <div class="col-lg-7 col-md-7">
                                <input type="hidden" name="_token" value="gkczc5RoKvpoUSHDJU6TT1CSaXyYgrloShAWuzHD">
                                <input type="hidden" name="Action" value="Create">
                                <div class="row">
                                    <div class="col-lg-6 col-md-6">
                                        <div class="form-group">
                                            <label for="">Гос. номер</label>
                                            <input type="text" class="form-control" name="driver_fio_rus" value="" placeholder="А000АА">
                                        </div>
                                    </div>
                                    <div class="col-lg-6 col-md-6">
                                        <div class="form-group">
                                            <label for="">Регион</label>
                                            <input type="text" class="form-control" pattern="8\d{10}" placeholder="777" name="driver_phone">
                                        </div>
                                    </div>
                                </div>
                                <hidden class="checkClassBizNoNInputs">
                                    <div class="row">
                                        <div class="col-lg-6 col-md-6">
                                            <div class="form-group">
                                                <label for="">Дата рождения</label>
                                                <input type="text" placeholder="30/01/1985" value="" id="BirthDate" name="driver_birthdate" class="form-control hasDatepicker" autocomplete="off">
                                            </div>
                                        </div>
                                        <div class="col-lg-6 col-md-6">
                                            <div class="form-group">
                                                <label for="">Хобби</label>
                                                <select name="driver_hobby" class="form-control">
                                                    <option value="">—</option>
                                                    <option value="Автомобили">Автомобили</option>
                                                    <option value="Авиация ">Авиация </option>
                                                    <option value="Активный отдых">Активный отдых</option>
                                                    <option value="Домашнее хозяйство ">Домашнее хозяйство </option>
                                                    <option value="Игры">Игры</option>
                                                                                            <option value="Иностранные языки ">Иностранные языки </option>
                                                                                            <option value="История ">История </option>
                                                                                            <option value="Зимние виды спорта">Зимние виды спорта</option>
                                                                                            <option value="Кино">Кино</option>
                                                                                            <option value="Книги">Книги</option>
                                                                                            <option value="Коллекционирование">Коллекционирование</option>
                                                                                            <option value="Компьютерные игры">Компьютерные игры</option>
                                                                                            <option value="Компьютеры">Компьютеры</option>
                                                                                            <option value="Кулинария">Кулинария</option>
                                                                                            <option value="Культура">Культура</option>
                                                                                            <option value="Музыка">Музыка</option>
                                                                                            <option value="Наука">Наука</option>
                                                                                            <option value="Охота">Охота</option>
                                                                                            <option value="Психология ">Психология </option>
                                                                                            <option value="Путешествия">Путешествия</option>
                                                                                            <option value="Рыбалка">Рыбалка</option>
                                                                                            <option value="Спорт">Спорт</option>
                                                                                            <option value="Танцы">Танцы</option>
                                                                                            <option value="Техника">Техника</option>
                                                                                            <option value="Технические виды спорта ">Технические виды спорта </option>
                                                                                            <option value="Фотография">Фотография</option>
                                                                                            <option value="Футбол">Футбол</option>
                                                                                    </select>
                                    </div>
                                </div>
                                                                </div>


                            <div class="row">
                                <div class="col-lg-6 col-md-6">
                                    <div class="form-group">
                                        <label for="">№ Водит. удостоверения</label>
                                        <input type="text" placeholder="5001777123" value="" name="driver_license" class="form-control" id="DriverLicense" autocomplete="off">
                                    </div>
                                </div>
                                <div class="col-lg-6 col-md-6">
                                    <div class="form-group">
                                        <label for="">Гос. номер а/м</label>
                                        <input type="text" placeholder="А123МР190/АА11177" value="" name="car_number" class="form-control" id="CarNumberMask" autocomplete="off">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-6 col-md-6">

                                    <div class="form-group">
                                        <label for="">Номер разрешения на перевозку</label>
                                        <input type="text" pattern="^[0-9А-Яа-яЁё]+$" value="" placeholder="Номер разрешения" name="car_licence" class="form-control" id="CarLicenseMask" autocomplete="off">
                                    </div>
                                </div>
                                <div class="col-lg-6 col-md-6">
                                    <div class="form-group">
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
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-lg-6 col-md-6">
                                    <div class="form-group">
                                        <label for="">Марка авто</label>
                                        <select name="car_brand_id" class="CarBrand form-control" id="SelectCarBrand">
                                            <option value="" selected="">Выберите марку авто</option>
                                                                                            <option value="1">Acura</option>
                                                                                            <option value="2">Audi</option>
                                                                                            <option value="3">BMW</option>
                                                                                            <option value="4">Cadillac</option>
                                                                                            <option value="5">Chevrolet</option>
                                                                                            <option value="6">Citroen</option>
                                                                                            <option value="38">Fiat</option>
                                                                                            <option value="8">Ford</option>
                                                                                            <option value="10">Honda</option>
                                                                                            <option value="11">Hyundai</option>
                                                                                            <option value="12">Infiniti</option>
                                                                                            <option value="13">Jaguar</option>
                                                                                            <option value="14">Kia</option>
                                                                                            <option value="15">Land Rover</option>
                                                                                            <option value="16">Lexus</option>
                                                                                            <option value="79">London Taxi</option>
                                                                                            <option value="17">Mazda</option>
                                                                                            <option value="18">Mercedes</option>
                                                                                            <option value="36">Mini</option>
                                                                                            <option value="19">Mitsubishi</option>
                                                                                            <option value="20">Nissan</option>
                                                                                            <option value="21">Opel</option>
                                                                                            <option value="22">Peugeot</option>
                                                                                            <option value="23">Porsche</option>
                                                                                            <option value="24">Renault</option>
                                                                                            <option value="26">Skoda</option>
                                                                                            <option value="27">SsangYong</option>
                                                                                            <option value="28">Subaru</option>
                                                                                            <option value="29">Suzuki</option>
                                                                                            <option value="31">Toyota</option>
                                                                                            <option value="32">Volkswagen</option>
                                                                                            <option value="33">Volvo</option>
                                                                                    </select>
                                    </div>
                                </div>
                                <div class="col-lg-3 col-md-3">
                                    <div class="form-group">
                                        <label for="">Модель авто</label>
                                        <select name="car_model" class="CarModel form-control" id="SelectCarModel">
                                            <option value="" selected="">—</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-lg-3 col-md-3">
                                    <div class="form-group">
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
                                </div>
                            </div>


                            <div class="col-lg-12 col-md-12 Classes">
    

    

    <div class="ShowXL hidden car-classes">
        <div class="form-group">
            <div class="form_driver_labels w150">А/м класса XL</div>
            <div class="form_inputs">
                <input type="checkbox" name="ClassXL" id="checkboxG14" class="css-checkbox Business "><label for="checkboxG14" value="Yes" class="css-label "></label>
            </div>
        </div>
    </div>


            <div class="ShowComfort hidden car-classes">
            <div class="form-group">
                <div class="form_driver_labels w150">А/м комфорт класса</div>
                <div class="form_inputs">

                    <input type="checkbox" name="ClassComfort" id="checkboxG11" class="css-checkbox "><label for="checkboxG11" value="Yes" class="css-label"></label>

                </div>
            </div>
        </div>

        <div class="ShowEconom hidden car-classes">
            <div class="form-group">
                <div class="form_driver_labels w150">А/м эконом класса</div>
                <div class="form_inputs">
                    <input type="checkbox" name="ClassEconom" id="checkboxG9" class="css-checkbox ">
                    <label for="checkboxG9" value="Yes" class="css-label"></label>
                </div>
            </div>
        </div>
    
</div>


                            

                                                    </hidden>

                        <div class="row">

                            <div class="col-lg-12 col-md-12">
    <div class="form_driver_labels">Место прохождения обучения</div>
    <div class="form-group">

        <div class="form_inputs labels">
            <span class="type-device">


                            <label>
                    <input type="radio" name="TrainingPlace" value="ЦПВ Gett" id="TrainingPlace_0" checked="">&nbsp;ЦПВ
                    Gett
                </label>
            

            

                                                <label>
                        <input type="radio" name="TrainingPlace" value="Переход из другого парка" id="TrainingPlace_1">&nbsp;Переход из другого таксопарка</label>
                            




                                        



            

                        </span>
        </div>
    </div>
</div>



                        </div>


                        <div class="OldId hidden">
                            <div class="col-lg-6 col-md-6">
                                <div class="form-group">
                                    <label for="">Предыдущий ID</label>
                                    <input type="text" placeholder="до 6 цифр" name="DriverOldID" class="DriverOldID rfield2 form-control" id="PhoneMask" autocomplete="off" value="">
                                </div>
                            </div>
                        </div>

                        <div id="TrainingDateDiv">
                            <div class="col-lg-6 col-md-6">
                                <div class="form-group">
                                    <label for="">Дата прохождения обучения</label>
                                    <input type="text" placeholder="20/01/2015" name="TrainingDate" class="CarModel rfield TrainingDateValue form-control hasDatepicker" autocomplete="off" id="datepicker2" value="">
                                </div>
                            </div>
                        </div>


                        <showbtn class="btnCheckClassBiz">
                            <div class="col-lg-6 col-md-6">
                                <div class="form-group">
                                    <label for="">&nbsp;</label>
                                    <div id="btnCheckAjax" class="btn_submit"><i class="fa fa-angle-double-right" aria-hidden="true"></i> Далее</div>
                                </div>
                            </div>
                        </showbtn>

                        <hidden class="checkClassBizNoNInputs">

                            <div class="col-lg-6 col-md-6">
        <div class="form-group">
            <label for="">Страна выдачи паспорта</label>
            <select name="passport_country" class="DriverHobby form-control">
                <option value="Россия">Россия</option>
                <option value="Азербайджан">Азербайджан</option>
                <option value="Армения">Армения</option>
                <option value="Белоруссия">Белоруссия</option>
                <option value="Казахстан">Казахстан</option>
                <option value="Киргизия">Киргизия</option>
                <option value="Молдавия">Молдавия</option>
                <option value="Таджикистан">Таджикистан</option>
                <option value="Туркмения">Туркмения</option>
                <option value="Узбекистан">Узбекистан</option>
                <option value="Украина">Украина</option>
                <option value="Грузия">Грузия</option>
                <option value="Другое">Другое</option>
            </select>
        </div>
    </div>
    <div class="row"></div>
    <div class="col-lg-6 col-md-6">
        <div class="form-group">
            <label for="">Серия и номер паспорта</label><br>
            <input class="form-control" type="text" autocomplete="false" name="pass_num" value="">
        </div>
    </div>

    <div class="col-lg-6 col-md-6">
        <div class="form-group">
            <label for="">Фотография паспорта</label>
            <input type="file" name="passport_file" id="passport_file" class="rfield form-control">
        </div>
    </div>



                            <div class="row">
                                <div class="col-lg-12 col-md-12">
                                    <div class="form-group">
                                        <label for="">Дополнительная информация</label>
                                        <textarea name="driver_description" class="Descriptions form-control" placeholder="Примечания по водителю"></textarea>
                                    </div>
                                </div>


                            </div>
                                <div class="col-lg-12 col-md-12">
                                    <div class="form-group">
                                        <input type="checkbox" name="acceptance" id="acceptance">
                                        Партнёр подтверждает наличие отношений с водителем и согласие последнего на сотрудничество с указанным партнёром при распределении заказов на перевозку в рамках ПО GT.

                                    </div>
                                </div>
                    </hidden></div>
                    
                    <div class="col-lg-5 col-md-5">
                        <div class="row">
                            <hidden class="checkClassBizNoNInputs">
<div class="PhotoContainer">
    <div class="">
        <div class=" ">
            <div id="cropContainerModal">

                <div class="PhotoRulesBtn">
                    <span>ДЛЯ ЗАГРУЗКИ ФОТОГРАФии НАЖМИТЕ на жёлтую стрелку</span>
                </div>
            <div class="cropControls cropControlsUpload"> <i class="cropControlUpload"></i> </div><form class="cropContainerModal_imgUploadForm" style="visibility: hidden;">  <input type="file" name="img" id="cropContainerModal_imgUploadField">  </form></div>
        </div>
    </div>
</div>
<input type="hidden" name="driver_photo" id="photoDriver">
<input type="hidden" name="passport_url">
    <div align="center"><a href="/docs/photo-standarts.pdf" target="_blank">Стандарт фотографии</a></div>
</hidden>
                            <hidden class="checkClassBizNoNInputs">
            <div class="down-driver-license">
            <div class="select-panel">
                <span>Формат В/У</span>
                <div class="right">
                    <div id="a169" class="btn-select-type  active">Горизонтальный</div>
                    <div id="a43" class="btn-select-type">Вертикальный</div>
                </div>
            </div>

            <div id="cropContainerModalBY" class="modalHorisontal" style="height: 202px; width: 302px;"><div class="cropControls cropControlsUpload"> <i class="cropControlUpload"></i> </div><form class="cropContainerModalBY_imgUploadForm" style="visibility: hidden;">  <input type="file" name="img" id="cropContainerModalBY_imgUploadField">  </form></div>
        </div>
        <input type="hidden" name="driver_license_photo">
    </hidden>
                        </div>
                    </div>


                    <hidden class="checkClassBizNoNInputs">
                        <div class="col-lg-12 col-md-12 col-sm-8 col-xs-10 col-xs-offset-1 col-lg-offset-0">
                            <div class="row">
                                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                    <input type="submit" id="btn-submit-create" class=" btn btn-gt form-control" value="Отправить данные на обработку">
                                </div>
                            </div>
                        </div>
                    </hidden>



                </form>

            </div>


        </div>
    </div>


    <style>
                   .checkClassBizNoNInputs {
            display: block;
        }

        .btnCheckClassBiz {
            display: none;
        }
            </style>




                </div>
    </body>
</html>
