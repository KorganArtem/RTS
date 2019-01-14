/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ru.leasicar.healthCheck;

import java.util.Random;

/**
 *
 * @author Artem
 */
public class HealthDataGenerator {
    public double getBodyTem(){
        double bodyTemp = 36;
        Random rd = new Random(System.currentTimeMillis());
        double dec = rd.nextInt(10);
        bodyTemp = bodyTemp + dec/10;
        return bodyTemp;
    }
    public String getBloodPressure(int yearsOld){
        String bloodPressure = "120/80";
        Random rd = new Random();
        int highPressure = 0;
        int lowPressure = 0;
        if(yearsOld<40){
            highPressure = 110 + rd.nextInt(20);
            lowPressure = 70 + rd.nextInt(10);
        }
        else{
            highPressure = 125 + rd.nextInt(15);
            lowPressure = 80 + rd.nextInt(8);
        }
        bloodPressure = highPressure+"/"+lowPressure;
        return bloodPressure;
    }
    public int getPulse(int yearsOld){
        int pulse = 0;
        Random rd = new Random();
        if(yearsOld<40)
            pulse = 65 + rd.nextInt(10);
        else
            pulse = 70 + rd.nextInt(10);
        return pulse;
    }
}
