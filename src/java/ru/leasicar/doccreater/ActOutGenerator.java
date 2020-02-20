/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ru.leasicar.doccreater;

import com.ibm.icu.text.RuleBasedNumberFormat;
import com.ibm.icu.text.Transliterator;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import javax.naming.NamingException;
import org.apache.poi.hwpf.HWPFDocument;
import org.apache.poi.hwpf.usermodel.Range;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import ru.leasicar.workerSql.CarSQL;
import ru.leasicar.workerSql.DriverSQL;

/**
 *
 * @author korgan
 */
public class ActOutGenerator {
    Map<Integer, String> mounths = new HashMap();
    public ActOutGenerator(){
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
    public String  createAct(int DriverId, String filePath) throws ClassNotFoundException, SQLException, NamingException { 
        System.out.println(System.getProperty("catalina.base"));
        DriverSQL dsql = new DriverSQL();
        Map<String, String> draverData = dsql.getAllDataDriver(DriverId);
        String fullName = draverData.get("driver_lastname")+" "+draverData.get("driver_firstname")+" "+draverData.get("driver_midName");    
        String[] dateDog = draverData.get("dogovorDate").split("-");
        String currenDogDate = dateDog[2]+" "+mounths.get(Integer.parseInt(dateDog[1]))+" "+dateDog[0]; 
        Calendar calendar = Calendar.getInstance();
        String dataAct = calendar.get(Calendar.DAY_OF_MONTH)+" "+mounths.get(calendar.get(Calendar.MONTH)+1)+" "+calendar.get(Calendar.YEAR);
        String numberDog = draverData.get("dogovorNumber");
        String fileName = "actOutFor_"+numberDog+".doc";
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
            POIFSFileSystem pfs = new POIFSFileSystem(new FileInputStream("/table/doc_tmp/act_out_tmp.doc"));
            HWPFDocument doc = new HWPFDocument(pfs);
            Range range = doc.getRange();
            range.replaceText("{%date%}", dataAct);  
            range.replaceText("{%numberDog%}", numberDog);
            range.replaceText("{%currentDogDate%}", currenDogDate);
            range.replaceText("{%carModel%}", carData.get("modelName"));
            range.replaceText("{%carNumber%}", carData.get("number")+carData.get("regGosNumber"));
            range.replaceText("{%carVIN%}", carData.get("VIN"));
            range.replaceText("{%carYear%}", carData.get("year"));
            range.replaceText("{%carColor%}", carData.get("color"));
            range.replaceText("{%carTransmission%}", transmission);
            range.replaceText("{%carSTS%}", carData.get("sts"));
            range.replaceText("{%carTTO%}", carData.get("ttoNumber"));
            range.replaceText("{%carOSAGO%}", carData.get("insuranceNamber"));
            range.replaceText("{%dogNumber%}", numberDog+"");
            range.replaceText("{%numberDog%}", numberDog+"");
            range.replaceText("{%date%}", currenDogDate);
            range.replaceText("{%fulName%}", fullName);
            range.replaceText("{%driver_bornDate%}", draverData.get("driver_bornDate"));
            ////////////////////////////////////////////////////////////////////////
            range.replaceText("{%passportNumber%}", draverData.get("passportNumber"));
            range.replaceText("{%passportFrom%}", draverData.get("passportFrom"));
            range.replaceText("{%passportDate%}", draverData.get("passportDate"));
            range.replaceText("{%carTransmission%}", transmission);
            range.replaceText("{%currentDogDate%}", currenDogDate);
            range.replaceText("{%carModel%}", carData.get("modelName"));
            range.replaceText("{%carNumber%}", carData.get("number")+carData.get("regGosNumber"));
            range.replaceText("{%carVIN%}", carData.get("VIN"));
            range.replaceText("{%carYear%}", carData.get("year"));
            range.replaceText("{%carColor%}", carData.get("color"));
            range.replaceText("{%carTransmission%}", transmission);
            range.replaceText("{%carSTS%}", carData.get("sts"));
            range.replaceText("{%carTTO%}", carData.get("ttoNumber"));
            range.replaceText("{%carOSAGO%}", carData.get("insuranceNamber"));
            range.replaceText("{%carMileage%}", carData.get("carMileage"));
            ////////////////////////////////////////////////////////////////////////
            String address = draverData.get("postCode") +", "+draverData.get("country");
	    
            range.replaceText("{%vyNumber%}", draverData.get("vyNumber"));
            range.replaceText("{%vyFrom%}", draverData.get("vyFrom"));
	    range.replaceText("{%vyDate%}", draverData.get("vyDate"));
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
            System.out.println(filePath+"docs/"+fileName);
            OutputStream out = new FileOutputStream(filePath+"docs/"+fileName);
            doc.write(out);
            out.flush();
            out.close();
            return fileName;
        }
        catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
}
