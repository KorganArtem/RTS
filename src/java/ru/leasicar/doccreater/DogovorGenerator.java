/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ru.leasicar.doccreater;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.sql.SQLException;
import java.util.Locale;
import java.util.Map;
import org.apache.poi.hwpf.HWPFDocument;
import org.apache.poi.hwpf.usermodel.Range;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import ru.leasicar.workerSql.DriverSQL;
import com.ibm.icu.text.*;
import java.util.Calendar;
import java.util.HashMap;
import ru.leasicar.workerSql.CarSQL;
/**
 *
 * @author korgan
 */
public class DogovorGenerator {
    Map<Integer, String> mounths = new HashMap();
    public DogovorGenerator(){
        mounths.put(1, "января");
        mounths.put(2, "февраля");
        mounths.put(3, "марта");
        mounths.put(4, "апреля");
        mounths.put(5, "мая");
        mounths.put(6, "июня");
        mounths.put(7, "июля");
        mounths.put(8, "августа");
        mounths.put(9, "сентября");
        mounths.put(10, "октября");
        mounths.put(11, "ноября");
        mounths.put(12, "декабря");
    }
    public String  createDog(int DriverId, String filePath) throws ClassNotFoundException, SQLException { 
        System.out.println(System.getProperty("catalina.base"));
        DriverSQL dsql = new DriverSQL();
        int numberDog = dsql.getDogNumber();
        Map<String, String> draverData = dsql.getAllDataDriver(DriverId);
        Calendar calendar = Calendar.getInstance();
        String dataDog = calendar.get(Calendar.DAY_OF_MONTH)+" "+mounths.get(calendar.get(Calendar.MONTH)+1)+" "+calendar.get(Calendar.YEAR);
        CarSQL csql = new CarSQL();
        Map<String, String> carData = csql.getCarDataForAct(Integer.parseInt(draverData.get("carId")));
        String transmission = "";
        if(carData.get("transmission")!=null){
            switch(carData.get("transmission").toString()){
                case "1": 
                    transmission="МКПП";
                    break;
                case "2": 
                    transmission="АКПП";
                    break;
            }
        }
        try {
            String fullName = draverData.get("driver_lastname")+" "+draverData.get("driver_firstname")+" "+draverData.get("driver_midName");
            POIFSFileSystem pfs = new POIFSFileSystem(new FileInputStream("/table/doc_tmp/dogovor_tmp.doc"));
            HWPFDocument doc = new HWPFDocument(pfs);
            String fileName = "dogFor_"+numberDog+".doc";
            Range range = doc.getRange(); 
            range.replaceText("{%dogNumber%}", numberDog+"");
            range.replaceText("{%numberDog%}", numberDog+"");
            range.replaceText("{%date%}", dataDog);
            range.replaceText("{%fulName%}", fullName);
            ////////////////////////////////////////////////////////////////////////
            range.replaceText("{%passportNumber%}", draverData.get("passportNumber"));
            range.replaceText("{%passportFrom%}", draverData.get("passportFrom"));
            range.replaceText("{%passportDate%}", draverData.get("passportDate"));
            range.replaceText("{%carTransmission%}", transmission);
            range.replaceText("{%currentDogDate%}", dataDog);
            range.replaceText("{%carModel%}", carData.get("modelName"));
            range.replaceText("{%carNumber%}", carData.get("number"));
            range.replaceText("{%carVIN%}", carData.get("VIN"));
            range.replaceText("{%carYear%}", carData.get("year"));
            range.replaceText("{%carColor%}", carData.get("color"));
            range.replaceText("{%carTransmission%}", transmission);
            range.replaceText("{%carSTS%}", carData.get("sts"));
            range.replaceText("{%carTTO%}", carData.get("ttoNumber"));
            range.replaceText("{%carOSAGO%}", carData.get("insuranceNamber"));
            ////////////////////////////////////////////////////////////////////////
            String address = draverData.get("postCode") +", "+draverData.get("country");
            if(draverData.get("province").length()>1)
                address = address + ", "+draverData.get("province");
            if(draverData.get("city").length()>1)
                address = address + ", гор. "+draverData.get("city");
            if(draverData.get("strit").length()>1)
                address = address + ", ул. "+draverData.get("strit")+", дом "+draverData.get("house");
            if(draverData.get("building").length()>0)
                address = address + ", стр. "+draverData.get("building");
            if(draverData.get("flat").length()>0)
                address = address + ", кв. "+draverData.get("flat");
            range.replaceText("{%driverAddress%}", address);
            ////////////////////////////////////////////////////////////////////////
            String addAddress = draverData.get("addPostCode") +", "+draverData.get("addCountry");
            if(draverData.get("addProvince").length()>1)
                addAddress = addAddress + ", "+draverData.get("addProvince");
            if(draverData.get("addCity").length()>1)
                addAddress = addAddress + ", гор. "+draverData.get("addCity");
            if(draverData.get("addStrit").length()>1)
                addAddress = addAddress + ", ул. "+draverData.get("addStrit")+", дом"+draverData.get("addHouse");
            if(draverData.get("addBuilding").length()>1)
                addAddress = addAddress + ", стр. "+draverData.get("addBuilding");
            if(draverData.get("addFlat").length()>1)
                addAddress = addAddress + ", кв. "+draverData.get("addFlat");
            range.replaceText("{%driverAddAddress%}", addAddress);
            range.replaceText("{%driverEmail%}", draverData.get("driver_email"));
            range.replaceText("{%driverPhone%}", draverData.get("driver_phone_number"));
            ////////////////////////////////////////////////////////////////////
            RuleBasedNumberFormat nf = new RuleBasedNumberFormat(Locale.forLanguageTag("ru"),
                RuleBasedNumberFormat.SPELLOUT);
            range.replaceText("{%rentSumInWords%}", nf.format(Integer.parseInt(draverData.get("driver_day_rent"))));
            range.replaceText("{%rentSum%}", draverData.get("driver_day_rent"));
            range.replaceText("{%currentDepositInWords%}", nf.format(Integer.parseInt(draverData.get("driver_deposit"))));
            range.replaceText("{%currentDeposit%}", draverData.get("driver_deposit"));
            OutputStream out = new FileOutputStream(filePath+"docs/"+fileName);
            doc.write(out);
            out.flush();
            out.close();
            dsql.writeDogovor(numberDog, DriverId);
            return fileName;
        }
        catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
}
