/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ru.leasicar.doccreater;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.Map;
import javax.naming.NamingException;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import ru.leasicar.workerSql.CarSQL;
import ru.leasicar.workerSql.CompanySQL;
import ru.leasicar.workerSql.DriverSQL;

/**
 *
 * @author Artem
 */
public class WayBillExcel {
    public String write(int DriverId, String filePath, int carId, int cmpanyId) throws FileNotFoundException, IOException, ClassNotFoundException, SQLException, NamingException {
	// TODO code application logic here
	String fileName = "wayBill_"+DriverId+".xls";
	String fullPath = filePath+"docs/"+fileName;
	DriverSQL dsql = new DriverSQL();
	Map<String, String> driverData;
	Map<String, String> carData ;
	Map<String, String> compData;
	driverData = dsql.getAllDataDriver(DriverId);
	CarSQL csql = new CarSQL();
	carData = csql.getCarDataForAct(carId);
	CompanySQL compSQL = new CompanySQL();
	compData = compSQL.getCompanyData(cmpanyId);
	String fullName = driverData.get("driver_lastname")+" "+driverData.get("driver_firstname")+" "+driverData.get("driver_midName");
	DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
	String driverLicNum = driverData.get("vyNumber");
	POIFSFileSystem fs = new POIFSFileSystem(new FileInputStream("/table/doc_tmp/wayBill_tmp.xls"));
	HSSFWorkbook hb = new HSSFWorkbook(fs);
	HSSFSheet sheet= hb.getSheetAt(0);
	HSSFRow rowCh = sheet.getRow(21);
	HSSFCell cell = rowCh.getCell(29);
	cell.setCellValue("FFFFFFFF");
	HSSFCell celDriver = sheet.getRow(11).getCell(12);
	celDriver.setCellValue(fullName);
	writeWorkbook(hb, fullPath);
	return fullPath;
    }
    public void writeWorkbook(HSSFWorkbook wb, String fileName) {
	System.out.println(fileName);
       try {
               FileOutputStream fileOut = new FileOutputStream(fileName);
               wb.write(fileOut);
               fileOut.close();
       }
       catch (Exception e) {
               //Обработка ошибки
       }
    }  
}
