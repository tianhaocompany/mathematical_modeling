package swcparts;

import java.util.*;
import java.io.PrintWriter;

public class BinnedBiffData {

     private int arraySize; // holder for array size for use in passing array into function where size is needed, to be set for [1]
//basic parameters
     private double DRmean; //Daughter ratio mean for bin
     private double DRstdev; //Daughter ratio stdev for bin
     private double DRmin; //Daughter ratio min for bin
     private double DRmax; //Daughter ratio max for bin
     private double DRuf; //Daughter ratio unity fraction
     private int DRcurve; //Daughter ratio curve type

     private double PDRmean; //Daughter ratio mean for bin
     private double PDRstdev; //Daughter ratio stdev for bin
     private double PDRmin; //Daughter ratio min for bin
     private double PDRmax; //Daughter ratio max for bin
     private double PDRuf; //Daughter ratio unity fraction
     private int PDRcurve; //Daughter ratio curve type

     private double TRmean; //Daughter ratio mean for bin
     private double TRstdev; //Daughter ratio stdev for bin
     private double TRmin; //Daughter ratio min for bin
     private double TRmax; //Daughter ratio max for bin
     private double TRuf; //Daughter ratio unity fraction
     private int TRcurve; //Taper ratio curve type

     private double BPLmean; //Daughter ratio mean for bin
     private double BPLstdev; //Daughter ratio stdev for bin
     private double BPLmin; //Daughter ratio min for bin
     private double BPLmax; //Daughter ratio max for bin
     private int BPLcurve; //Daughter ratio curve type

     private double BifPercent; //Bifurcate?  (0 = never bifurcate, 1 for always)
     private int Nbifs;
     private int Ntips;
     private String FundementalParam;
     private double FPbinMax;

//******************************************************************************
      public void setAll(double fDRmean, double fDRstdev, double fDRmin, double fDRmax,
                         double fDRuf, double fPDRmean, double fPDRstdev, double fPDRmin,
                         double fPDRmax, double fPDRuf, double fTRmean, double fTRstdev,
                         double fTRmin, double fTRmax, double fTRuf, double fBPLmean,
                         double fBPLstdev, double fBPLmin, double fBPLmax, double fBifPercent,
                         int fNbifs, int fNtips, String fFundementalParam) {
           DRmean = fPDRmean;
           DRmean = fDRmean;
           DRstdev = fDRstdev;
           DRmin = fDRmin;
           DRmax = fDRmax;
           DRuf = fDRuf;
           PDRmean = fPDRmean;
           PDRstdev = fPDRstdev;
           PDRmin = fPDRmin;
           PDRmax = fPDRmax;
           PDRuf = fPDRuf;
           TRmean = fTRmean;
           TRstdev = fTRstdev;
           TRmin = fTRmin;
           TRmax = fTRmax;
           TRuf = fTRuf;
           BPLmean = fBPLmean;
           BPLstdev = fBPLstdev;
           BPLmin = fBPLmin;
           BPLmax = fBPLmax;
           BifPercent = fBifPercent;
           Nbifs = fNbifs;
           Ntips = fNtips;
           FundementalParam = fFundementalParam;
           // FPbinMax = fFPbinMax;

      }

//******************************************************************************

      public void setArraySize(int as) {
           arraySize = as;
      }

     public int getArraySize() {
          return arraySize;
     }

     public void setDRmean(double fDRmean) {
          DRmean = fDRmean;
     }

     public double getDRmean() {
          return DRmean;
     }

     public void setDRstdev(double fDRstdev) {
          DRstdev = fDRstdev;
     }

     public double getDRstdev() {
          return DRstdev;
     }

     public void setDRmax(double fDRmax) {
          DRmax = fDRmax;
     }

     public double getDRmax() {
          return DRmax;
     }

     public void setDRmin(double fDRmin) {
          DRmin = fDRmin;
     }

     public double getDRmin() {
          return DRmin;
     }

     public void setDRuf(double fDRuf) {
          DRuf = fDRuf;
     }

     public double getDRuf() {
          return DRuf;
     }

     public void setDRcurveType(int ct) {
          DRcurve = ct;
     }

     public int getDRcurveType() {
          return DRcurve;
     }

//******************************************************************************
      public void setPDRmean(double fPDRmean) {
           PDRmean = fPDRmean;
      }

     public double getPDRmean() {
          return PDRmean;
     }

     public void setPDRstdev(double fPDRstdev) {
          PDRstdev = fPDRstdev;
     }

     public double getPDRstdev() {
          return PDRstdev;
     }

     public void setPDRmax(double fPDRmax) {
          PDRmax = fPDRmax;
     }

     public double getPDRmax() {
          return PDRmax;
     }

     public void setPDRmin(double fPDRmin) {
          PDRmin = fPDRmin;
     }

     public double getPDRmin() {
          return PDRmin;
     }

     public void setPDRuf(double fPDRuf) {
          PDRuf = fPDRuf;
     }

     public double getPDRuf() {
          return PDRuf;
     }

     public void setPDRcurveType(int ct) {
          PDRcurve = ct;
     }

     public int getPDRcurveType() {
          return PDRcurve;
     }

//******************************************************************************
      public void setTRmean(double fTRmean) {
           TRmean = fTRmean;
      }

     public double getTRmean() {
          return TRmean;
     }

     public void setTRstdev(double fTRstdev) {
          TRstdev = fTRstdev;
     }

     public double getTRstdev() {
          return TRstdev;
     }

     public void setTRmax(double fTRmax) {
          TRmax = fTRmax;
     }

     public double getTRmax() {
          return TRmax;
     }

     public void setTRmin(double fTRmin) {
          TRmin = fTRmin;
     }

     public double getTRmin() {
          return TRmin;
     }

     public void setTRuf(double fTRuf) {
          TRuf = fTRuf;
     }

     public double getTRuf() {
          return TRuf;
     }

     public void setTRcurveType(int ct) {
          TRcurve = ct;
     }

     public int getTRcurveType() {
          return TRcurve;
     }

//******************************************************************************
      public void setBPLmean(double fBPLmean) {
           BPLmean = fBPLmean;
      }

     public double getBPLmean() {
          return BPLmean;
     }

     public void setBPLstdev(double fBPLstdev) {
          BPLstdev = fBPLstdev;
     }

     public double getBPLstdev() {
          return BPLstdev;
     }

     public void setBPLmax(double fBPLmax) {
          BPLmax = fBPLmax;
     }

     public double getBPLmax() {
          return BPLmax;
     }

     public void setBPLmin(double fBPLmin) {
          BPLmin = fBPLmin;
     }

     public double getBPLmin() {
          return BPLmin;
     }

     public void setBPLcurveType(int ct) {
          BPLcurve = ct;
     }

     public int getBPLcurveType() {
          return BPLcurve;
     }

//******************************************************************************
      public void setBifPercent(double fsetBifPercent) {
           BifPercent = fsetBifPercent;
      }

     public double getBifPercent() {
          return BifPercent;
     }

     public void setNbifs(int fNbifs) {
          Nbifs = fNbifs;
     }

     public int getNbifs() {
          return Nbifs;
     }

     public void setNtips(int fNtips) {
          Ntips = fNtips;
     }

     public int getNtips() {
          return Ntips;
     }

     public void setFPbinMax(double fFPbinMax) {
          FPbinMax = fFPbinMax;
     }

     public double getFPbinMax() {
          return FPbinMax;
     }

     public void setFundementalParam(String fFundementalParam) {
          FundementalParam = fFundementalParam;
     }

     public String getFundementalParam() {
          return FundementalParam;
     }

     public void setFPmax(double fFPbinMax) {
          FPbinMax = fFPbinMax;
     }

//******************************************************************************
      public BinnedBiffData() {
      }

     /*
          public double getParamValue(String paramToGet, Random globalRand) {
               double tempparam = 0;
               double tempUF = 0;
               double tempMAX = 0;
               double tempMIN = 0;
               double tempMEAN = 0;
               double tempSTDEV = 0;


               if (paramToGet.equals("BP")) {
                    return BifPercent;
               }
               else if (paramToGet.equals("TP")) {
                    tempUF = TRuf;
                    tempMAX = TRmax;
                    tempMIN = TRmin;
                    tempMEAN = TRmean;
                    tempSTDEV = TRstdev;
               }
               else if (paramToGet.equals("BPL")) {
                    tempMAX = BPLmax;
                    tempMIN = BPLmin;
                    tempMEAN = BPLmean;
                    tempSTDEV = BPLstdev;
               }
               else if (paramToGet.equals("DR")) {
                    tempUF = DRuf;
                    tempMAX = DRmax;
                    tempMIN = DRmin;
                    tempMEAN = DRmean;
                    tempSTDEV = DRstdev;
               }
               else if (paramToGet.equals("PDR")) {
                    tempUF = DRuf;
                    tempMAX = PDRmax;
                    tempMIN = PDRmin;
                    tempMEAN = PDRmean;
                    tempSTDEV = PDRstdev;
               }
               else {
      System.out.println("Invalid call to getParamValue, param sent = " + paramToGet);
                    System.exit(99);
               }

               if (globalRand.nextDouble() < tempUF) {
                    return 1;
               }
               else {
                    if (tempSTDEV <= 0) {
                         return tempMEAN;
                    }
                    if (tempMIN > tempMEAN) {
                         return tempMIN;
                    }
                    if (tempMAX < tempMEAN) {
                         return tempMAX;
                    }
                    tempparam = TRmin - 1;

                    //Gaussian
                    //while ((tempparam < tempMIN) || (tempparam > tempMAX)){
                    //     tempparam = (globalRand.nextGaussian() * tempSTDEV) + tempMEAN;
                    //}

                    //Uniform
                    tempparam = (globalRand.nextDouble() * (tempMAX - tempMIN) + tempMIN);

                    //Gamma
                    // while ( (tempparam < tempMIN) || (tempparam > tempMAX)) {
                    //     tempparam = (gd.GetGammaMS(tempMEAN, tempSTDEV, globalRand));
                    // }
               }
               return tempparam;
          }

          public double getParamValueGamma(String paramToGet, Random globalRand, GammaDist gd) {
               double tempparam = 0;
               double tempUF = 0;
               double tempMAX = 0;
               double tempMIN = 0;
               double tempMEAN = 0;
               double tempSTDEV = 0;

               if (paramToGet.equals("BP")) {
                    return BifPercent;
               }
               else if (paramToGet.equals("TP")) {
                    tempUF = TRuf;
                    tempMAX = TRmax;
                    tempMIN = TRmin;
                    tempMEAN = TRmean;
                    tempSTDEV = TRstdev;
               }
               else if (paramToGet.equals("BPL")) {
                    tempMAX = BPLmax;
                    tempMIN = BPLmin;
                    tempMEAN = BPLmean;
                    tempSTDEV = BPLstdev;
               }
               else if (paramToGet.equals("DR")) {
                    tempUF = DRuf;
                    tempMAX = DRmax;
                    tempMIN = DRmin;
                    tempMEAN = DRmean;
                    tempSTDEV = DRstdev;
               }
               else if (paramToGet.equals("PDR")) {
                    tempUF = DRuf;
                    tempMAX = PDRmax;
                    tempMIN = PDRmin;
                    tempMEAN = PDRmean;
                    tempSTDEV = PDRstdev;
               }
               else {
      System.out.println("Invalid call to getParamValue, param sent = " + paramToGet);
                    System.exit(99);
               }

               if (globalRand.nextDouble() < tempUF) {
                    return 1;
               }
               else {
                    if (tempSTDEV <= 0) {
                         return tempMEAN;
                    }
                    if (tempMIN > tempMEAN) {
                         return tempMIN;
                    }
                    if (tempMAX < tempMEAN) {
                         return tempMAX;
                    }
                    tempparam = tempMIN - 1;

                    //Gaussian
                    //while ((tempparam < tempMIN) || (tempparam > tempMAX)){
                    //     tempparam = (globalRand.nextGaussian() * tempSTDEV) + tempMEAN;
                    //}

                    //Uniform
                    //tempparam = (globalRand.nextDouble() * (tempMAX - tempMIN) + tempMIN);

                    //Gamma
                    while ( (tempparam < tempMIN) || (tempparam > tempMAX)) {
                         tempparam = (gd.GetGammaMS(tempMEAN, tempSTDEV, globalRand));
                    }
               }
               return tempparam;
          }
      */
     public double getParamValueCurve(String paramToGet, Random globalRand, GammaDist gd) {
          double tempparam = 0;
        //  double tempUF = 0;
          double tempMAX = 0;
          double tempMIN = 0;
          double tempMEAN = 0;
          double tempSTDEV = 0;
          int tempCurve = 0;
          double tempSymetricMax = 0; //for gamma and gaussian curves

          if (paramToGet.equals("BP")) {
               return BifPercent;
          }
          else if (paramToGet.equals("TP")) {
           //    tempUF = TRuf;
               tempMAX = TRmax;
               tempMIN = TRmin;
               tempMEAN = TRmean;
               tempSTDEV = TRstdev;
               tempCurve = TRcurve;
          }
          else if (paramToGet.equals("BPL")) {
               tempMAX = BPLmax;
               tempMIN = BPLmin;
               tempMEAN = BPLmean;
               tempSTDEV = BPLstdev;
               tempCurve = BPLcurve;
          }
          else if (paramToGet.equals("DR")) {
            //   tempUF = DRuf;
               tempMAX = DRmax;
               tempMIN = DRmin;
               tempMEAN = DRmean;
               tempSTDEV = DRstdev;
               tempCurve = DRcurve;
          }
          else if (paramToGet.equals("PDR")) {
             //  tempUF = DRuf;
               tempMAX = PDRmax;
               tempMIN = PDRmin;
               tempMEAN = PDRmean;
               tempSTDEV = PDRstdev;
               tempCurve = PDRcurve;
          }
          else {
               System.out.println("Invalid call to getParamValue, param sent = " + paramToGet);
               System.exit(99);
          }
          tempSymetricMax = ( (tempMEAN * 2) - tempMIN);
         // if (globalRand.nextDouble() < tempUF) {
         //      return 1;
         // }

         // else {
               if (tempSTDEV <= 0) {
                    return tempMEAN;
               }
               if (tempMIN > tempMEAN) {
                    return tempMIN;
               }
               if (tempMAX < tempMEAN) {
                    return tempMAX;
               }

               //temporary, should be tempMin
               tempparam = tempMIN - 1;

               if (tempCurve == 1) {
                    tempparam = (globalRand.nextDouble() * (tempSymetricMax - tempMIN) + tempMIN);
               }
               else if (tempCurve == 2) {
                    while ( (tempparam < tempMIN) || (tempparam > tempSymetricMax)) {
                         tempparam = (globalRand.nextGaussian() * tempSTDEV) + tempMEAN;
                    }
               }
               else if (tempCurve == 3) {
                    while ( (tempparam < tempMIN) || (tempparam > tempMAX)) {
                         tempparam = (gd.GetGammaMS(tempMEAN, tempSTDEV, globalRand));
                    }
               }
               else {
                    System.out.println("Invalid curve type in getParamValue, CurveType = " +
                                       tempCurve);
                    System.exit(98);
               }
        //  }
          return tempparam;
     }

     static public void writeOutInputTable(swcparts.BinnedBiffData[] InputTable,
                                           PrintWriter fileout, int arraySize) {

          fileout.println();
          fileout.println("j, binMax, BifPercent,DRmean,DRstdev,DRmax,DRmin, DRuf, DRcurve, PDRmean, PDRstdev,PDRmax,PDRmin, PDRuf,PDRcurve, TRmean,TRstdev,TRmax,TRmin,TRuf, TRcurve,Nbifs,Ntips,BPLmean,BPLstdev,BPLmax,BPLmin, BPLcurve");

          for (int j = 1; j <= arraySize; j++) {
               fileout.println(j + "," + InputTable[j].getFPbinMax() + "," +
                               InputTable[j].getBifPercent() + "," +
                               InputTable[j].getDRmean() + "," +
                               InputTable[j].getDRstdev() + "," +
                               InputTable[j].getDRmax() + "," +
                               InputTable[j].getDRmin() + "," +
                               InputTable[j].getDRuf() + "," +
                               InputTable[j].getDRcurveType() + "," +
                               InputTable[j].getPDRmean() + "," +
                               InputTable[j].getPDRstdev() + "," +
                               InputTable[j].getPDRmax() + "," +
                               InputTable[j].getPDRmin() + "," +
                               InputTable[j].getPDRuf() + "," +
                               InputTable[j].getPDRcurveType() + "," +
                               InputTable[j].getTRmean() + "," +
                               InputTable[j].getTRstdev() + "," +
                               InputTable[j].getTRmax() + "," +
                               InputTable[j].getTRmin() + "," +
                               InputTable[j].getTRuf() + "," +
                               InputTable[j].getTRcurveType() + "," +
                               InputTable[j].getNbifs() + "," +
                               InputTable[j].getNtips() + "," +
                               InputTable[j].getBPLmean() + "," +
                               InputTable[j].getBPLstdev() + "," +
                               InputTable[j].getBPLmax() + "," +
                               InputTable[j].getBPLmin() + "," +
                               InputTable[j].getBPLcurveType());
          }

     }

}
