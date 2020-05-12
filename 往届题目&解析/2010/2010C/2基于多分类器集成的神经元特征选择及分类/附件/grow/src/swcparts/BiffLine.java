package swcparts;

import java.util.*;

public class BiffLine {

//Fundemental parameters
     private int BO; //Branch Order
     private double startPLS; //Path distance to soma
     private double endPLS; //Path distance to soma
     private double EDS; //Euclidian distance to soma
     private double YPOS; //Y position of point
     private double endRAD; //Radius of point (end radius)

//Basic parameters
     private double DR; //Daughter ratio (larger/smaller)
     private double PDR; //Parent daughter ratio (parent/larger)
     private double TR; //Taper rate (end/start)
     private double BPL; //Branch path length
     private int BIFF; //Bifurcate?  (0 for no, 1 for yes)

//core information
     private double startRAD; //Starting radius of branch
     private double DLRAD; //Radius of larger daughter
     private double DSRAD; //Radius of smaller daughter

     //conectivity
     private int D1num; //number of first daughter
     private int D2num; //number of first daughter
     private int ParrentNum; //number of parrent

//other information
     private int endBinLine;
     private int startBinLine;
     private double surfaceArea;

     //   private double TP1;  //Taper 1 value ((start-end)/BPL)
     //   private int TD;      //Terminal degree

     public void setAll(int bo, double startpls, double endpls, double eds, double ypos,
                        double endrad, double startrad,
                        double bpl, int biff, double dsrad, double dlrad) {
          BO = bo;
          startPLS = startpls;
          endPLS = endpls;
          EDS = eds;
          YPOS = ypos;
          startRAD = startrad;
          endRAD = endrad;
          BPL = bpl;
          BIFF = biff;
          DLRAD = dlrad;
          DSRAD = dsrad;
          DR = dlrad / dsrad;
          PDR = endrad / dlrad;
          TR = startrad / endrad;

     }

//***************    Fundemental parameter functions    ************************
//******************************************************************************
       public void setBO(int branchorder) {
            BO = branchorder;
       }

     public int getBO() {
          return BO;
     }

     public void setEndBinLine(int EBL) {
          endBinLine = EBL;
     }

     public int getEndBinLine() {
          return endBinLine;
     }

     public void setStartBinLine(int SBL) {
          startBinLine = SBL;
     }

     public int getStartBinLine() {
          return startBinLine;
     }

     public void setStartPLS(double pathLengthSoma) {
          startPLS = pathLengthSoma;
     }

     public double getEndPLS() {
          return endPLS;
     }

     public void setEndPLS(double pathLengthSoma) {
          endPLS = pathLengthSoma;
     }

     public double getStartPLS() {
          return startPLS;
     }

     public void setEDS(double euclidianDistanceSoma) {
          EDS = euclidianDistanceSoma;
     }

     public double getEDS() {
          return EDS;
     }

     public void setYPOS(double yPosition) {
          YPOS = yPosition;
     }

     public double getYPOS() {
          return YPOS;
     }

     public void setEndRAD(double radius) {
          endRAD = radius;
     }

     public double getEndRAD() {
          return endRAD;
     }

//******************************************************************************
      public void setDR(double daughterRatio) {
           DR = daughterRatio;
      }

     public double getDR() {
          return DR;
     }

     public void setPDR(double parentdaughterratio) {
          PDR = parentdaughterratio;
     }

     public double getPDR() {
          return PDR;
     }

     public void setTR(double taperrate) {
          TR = taperrate;
     }

     public double getTR() {
          return TR;
     }

     public void setBPL(double branchpathlength) {
          BPL = branchpathlength;
     }

     public double getBPL() {
          return BPL;
     }

     public void setBIFF(int bifurcate) {
          BIFF = bifurcate;
     }

     public double getBIFF() {
          return BIFF;
     }

     public void setDLRAD(double largedaughterradius) {
          DLRAD = largedaughterradius;
     }

     public double getDLRAD() {
          return DLRAD;
     }

     public void setDSRAD(double smalldaughterradius) {
          DSRAD = smalldaughterradius;
     }

     public double getDSRAD() {
          return DSRAD;
     }

     public void setStartRAD(double startradius) {
          startRAD = startradius;
     }

     public double getStartRAD() {
          return startRAD;
     }

     public void setD1num(int d1number) {
          D1num = d1number;
     }

     public int getD1num() {
          return D1num;
     }

     public void setD2num(int d2number) {
          D2num = d2number;
     }

     public int getD2num() {
          return D2num;
     }

     public void setParrentNum(int pnum) {
          ParrentNum = pnum;
     }

     public int getParrentNum() {
          return ParrentNum;
     }

     public BiffLine() {
     }

     public double getEndFundementalParamValue(String paramToDo) {
          if (paramToDo.startsWith("BO")) {
               return BO;
          }
          else if (paramToDo.startsWith("RAD")) {
               return endRAD;
          }
          else if (paramToDo.startsWith("PLS")) {
               return endPLS;
          }
          else if (paramToDo.startsWith("EDS")) {
               return EDS;
          }
          else if (paramToDo.startsWith("YPOS")) {
               return YPOS;
          }
          else {
               System.out.println(
                      "Incorect string given to getFundementalParamValue function, program terminated");
               System.exit( -3);
               return 0;
          }

     }

     public double getStartFundementalParamValue(String paramToDo) {
          if (paramToDo.startsWith("BO")) {
               return BO;
          }
          else if (paramToDo.startsWith("RAD")) {
               return startRAD;
          }
          else if (paramToDo.startsWith("PLS")) {
               return startPLS;
          }
          else if (paramToDo.startsWith("EDS")) {
               return EDS;
          }
          else if (paramToDo.startsWith("YPOS")) {
               return YPOS;
          }
          else {
               System.out.println(
                      "Incorect string given to getFundementalParamValue function, program terminated");
               System.exit( -3);
               return 0;
          }

     }

     //turn a biff array into an input table array
     public static swcparts.BinnedBiffData[] createBBDTable(swcparts.BiffLine[] BifsArray,
            int actualBiffLines, String paramToDo, int Binning, Random myRand) {
          int maxBins = 100;
          int actualBins = 1;
          int DRconstant = 1;
          int PDRconstant = 1;
          int TRconstant = 1;

          swcparts.BiffLine tempBiffLine = new swcparts.BiffLine();
          swcparts.BinnedBiffData[] bbdTable = new swcparts.BinnedBiffData[maxBins];

          //nested loops to bubble sort biflines by fundemental parameter
          for (int i = actualBiffLines + 1; --i >= 1; ) { //for each biffline
               for (int j = 1; j < i; j++) {
                    if (paramToDo.startsWith("RAD")) {
                         if (BifsArray[j].getStartRAD() > BifsArray[j + 1].getStartRAD()) {
                              tempBiffLine = BifsArray[j];
                              BifsArray[j] = BifsArray[j + 1];
                              BifsArray[j + 1] = tempBiffLine;
                         }
                    }
                    else if (paramToDo.startsWith("BO")) {
                         if (BifsArray[j].getBO() > BifsArray[j + 1].getBO()) {
                              tempBiffLine = BifsArray[j];
                              BifsArray[j] = BifsArray[j + 1];
                              BifsArray[j + 1] = tempBiffLine;
                         }
                    }
                    else if (paramToDo.startsWith("PLS")) {
                         if (BifsArray[j].getStartPLS() > BifsArray[j + 1].getStartPLS()) {
                              tempBiffLine = BifsArray[j];
                              BifsArray[j] = BifsArray[j + 1];
                              BifsArray[j + 1] = tempBiffLine;
                         }
                    }
                    else {
                         System.out.println(
                                "Incorect fundemental paramater given.  only RAD, PLS, and BO, allowed");
                         System.exit(2);
                    }
               }
          }
          //output bifsarray for error check
          int binCount = 0;
          //assign each bifline to a bin with min number of lines given by Binning variable
          for (int i = 1; i <= actualBiffLines; i++) { //for each biffline
               ++binCount;

               if (i >= 2) {
                    if ( (binCount > Binning) &&
                        (BifsArray[i].getStartFundementalParamValue(paramToDo) !=
                         BifsArray[i - 1].getStartFundementalParamValue(paramToDo))) {
                         ++actualBins;
                         //      System.out.println("actual bins, binncount, binning "+actualBins+"  "+binCount+"  "+Binning);
                         binCount = 0;
                    }
               }
               BifsArray[i].setStartBinLine(actualBins);

          }

          //Set bin fp max for all biflines
          double tempFPmax = 0;

          for (int j = 1; j <= actualBins; j++) { //go through each bin
               bbdTable[j] = new swcparts.BinnedBiffData();
               for (int i = 1; i <= actualBiffLines; i++) { //for each biffline
                    if (BifsArray[i].getStartBinLine() == j) {

                         if (j == actualBins) { //if in last bin set max to current value (will be max when i finishes
                              tempFPmax = BifsArray[i].getStartFundementalParamValue(paramToDo);
                         }
                         else { //otherwise set bin max to average of this bin max and next bin min
                              if (BifsArray[i + 1].getStartBinLine() == (j + 1)) {
                                   tempFPmax = (BifsArray[i].getStartFundementalParamValue(
                                          paramToDo) + BifsArray[i +
                                                1].getStartFundementalParamValue(paramToDo)) / 2;
                              }
                         }
                    }
               }
               bbdTable[j].setFPmax(tempFPmax);
          }

          //set end bin line
          for (int i = 1; i <= actualBiffLines; i++) { //for each biffline
               BifsArray[i].setEndBinLine(actualBins);
               for (int j = actualBins; j >= 1; j--) {
                    if (BifsArray[i].getEndFundementalParamValue(paramToDo) <=
                        bbdTable[j].getFPbinMax()) {
                         BifsArray[i].setEndBinLine(j);
                    }
               }
          }

//**************Create input table for sampling virtual neurons****************


           // compute basic parameter means, mins, maxes, and unity fractions
           double tempDRmin;
          double tempDRmax;
          double tempDRsum;
          int tempDRcount;
          int tempDRConstantCount;
          double[] tempDRarray = new double[actualBiffLines];
          int tempDRcurveType;

          double tempPDRmin;
          double tempPDRmax;
          double tempPDRsum;
          int tempPDRcount;
          int tempPDRConstantCount;
          double[] tempPDRarray = new double[actualBiffLines];
          int tempPDRcurveType;

          double tempTRmin;
          double tempTRmax;
          double tempTRsum;
          int tempTRcount;
          int tempTRConstantCount;
          double[] tempTRarray = new double[actualBiffLines];
          int tempTRcurveType;

          double tempBPLmin;
          double tempBPLmax;
          double tempBPLsum;
          int tempBPLcount;
          double[] tempBPLarray = new double[actualBiffLines];
          int tempBPLcurveType;

          double tempBiffPercent;

          int tempBifs;
          int tempTerms;

          //for each bin
          for (int j = 1; j <= actualBins; j++) { //go through each bin

               tempDRmax = 0;
               tempDRcount = 0;
               tempDRConstantCount = 0;
               tempDRsum = 0;
               tempDRmin = 1000;
               tempDRcurveType = 0;
               java.util.Arrays.fill(tempDRarray, 0);

               tempPDRmax = 0;
               tempPDRcount = 0;
               tempPDRConstantCount = 0;
               tempPDRsum = 0;
               tempPDRmin = 1000;
               tempPDRcurveType = 0;
               java.util.Arrays.fill(tempPDRarray, 0);

               tempTRmax = 0;
               tempTRcount = 0;
               tempTRConstantCount = 0;
               tempTRsum = 0;
               tempTRmin = 1000;
               tempTRcurveType = 0;
               java.util.Arrays.fill(tempTRarray, 0);

               tempBPLmax = 0;
               tempBPLcount = 0;
               tempBPLsum = 0;
               tempBPLmin = 1000;
               tempBPLcurveType = 0;
               java.util.Arrays.fill(tempBPLarray, 0);

               tempBiffPercent = 0;

               tempBifs = 0;
               tempTerms = 0;
               for (int i = 1; i <= actualBiffLines; i++) { //for each biffline

                    if (BifsArray[i].getEndBinLine() == j) {
                         if (BifsArray[i].getBIFF() == 1) {
                              ++tempBifs;
                              if (BifsArray[i].getDR() == DRconstant) {
                                   ++tempDRConstantCount;
                              }
                              else {
                                   ++tempDRcount;
                                   tempDRarray[tempDRcount] = BifsArray[i].getDR();
                                   tempDRsum = tempDRsum + BifsArray[i].getDR();
                                   if (tempDRmax < BifsArray[i].getDR()) {
                                        tempDRmax = BifsArray[i].getDR();
                                   }
                                   if (tempDRmin > BifsArray[i].getDR()) {
                                        tempDRmin = BifsArray[i].getDR();
                                   }
                              }
                              if (BifsArray[i].getPDR() == PDRconstant) {
                                   ++tempPDRConstantCount;
                              }
                              else {
                                   ++tempPDRcount;
                                   tempPDRarray[tempPDRcount] = BifsArray[i].getPDR();
                                   tempPDRsum = tempPDRsum + BifsArray[i].getPDR();
                                   if (tempPDRmax < BifsArray[i].getPDR()) {
                                        tempPDRmax = BifsArray[i].getPDR();
                                   }
                                   if (tempPDRmin > BifsArray[i].getPDR()) {
                                        tempPDRmin = BifsArray[i].getPDR();
                                   }
                              }
                         }
                         else {
                              ++tempTerms;
                         }
                    }

                    if (BifsArray[i].getStartBinLine() == j) {
                         if (BifsArray[i].getTR() == TRconstant) {
                              ++tempTRConstantCount;
                         }
                         else {
                              ++tempTRcount;
                              tempTRarray[tempTRcount] = BifsArray[i].getTR();
                              tempTRsum = tempTRsum + BifsArray[i].getTR();
                              if (tempTRmax < BifsArray[i].getTR()) {
                                   tempTRmax = BifsArray[i].getTR();
                              }
                              if (tempTRmin > BifsArray[i].getTR()) {
                                   tempTRmin = BifsArray[i].getTR();
                              }
                         }
                         ++tempBPLcount;
                         tempBPLarray[tempBPLcount] = BifsArray[i].getBPL();
                         tempBPLsum = tempBPLsum + BifsArray[i].getBPL();
                         if (tempBPLmax < BifsArray[i].getBPL()) {
                              tempBPLmax = BifsArray[i].getBPL();
                         }
                         if (tempBPLmin > BifsArray[i].getBPL()) {
                              tempBPLmin = BifsArray[i].getBPL();
                         }
                    }
               }

               double tempDRuf = 0;
               double tempPDRuf = 0;
               double tempTRuf = 0;

               tempDRcurveType = GammaDist.getCurveType(tempDRarray, tempDRcount, myRand);
               tempPDRcurveType = GammaDist.getCurveType(tempPDRarray, tempPDRcount, myRand);
               tempTRcurveType = GammaDist.getCurveType(tempTRarray, tempTRcount, myRand);
               tempBPLcurveType = GammaDist.getCurveType(tempBPLarray, tempBPLcount, myRand);

               tempDRuf = ( (double) tempDRConstantCount /
                           (double) (tempDRcount + tempDRConstantCount));
               tempPDRuf = (double) tempPDRConstantCount /
                      (double) (tempPDRcount + tempPDRConstantCount);
               tempTRuf = (double) tempTRConstantCount /
                      (double) (tempTRcount + tempTRConstantCount);

               double tempDRmean = tempDRsum / tempDRcount;
               double tempPDRmean = tempPDRsum / tempPDRcount;
               double tempTRmean = tempTRsum / tempTRcount;
               double tempBPLmean = tempBPLsum / tempBPLcount;

               double tempDRstdev = 0;
               double diffSqSumDR = 0;
               double tempPDRstdev = 0;
               double diffSqSumPDR = 0;
               double tempTRstdev = 0;
               double diffSqSumTR = 0;
               double tempBPLstdev = 0;
               double diffSqSumBPL = 0;

               //compute stdevs and bin maxes
               for (int i = 1; i <= actualBiffLines; i++) { //for each biffline
                    if (BifsArray[i].getEndBinLine() == j) {
                         if (BifsArray[i].getBIFF() == 1) {
                              //compute sum of differences squared for different parameters
                              if (BifsArray[i].getDR() != DRconstant) {
                                   diffSqSumDR = diffSqSumDR +
                                          ( (BifsArray[i].getDR() - tempDRmean) *
                                           (BifsArray[i].getDR() - tempDRmean));
                              }
                              if (BifsArray[i].getPDR() != PDRconstant) {
                                   diffSqSumPDR = diffSqSumPDR +
                                          ( (BifsArray[i].getPDR() - tempPDRmean) *
                                           (BifsArray[i].getPDR() - tempPDRmean));
                              }
                         }
                    }
                    if (BifsArray[i].getStartBinLine() == j) {
                         if (BifsArray[i].getTR() != TRconstant) {
                              diffSqSumTR = diffSqSumTR +
                                     ( (BifsArray[i].getTR() - tempTRmean) *
                                      (BifsArray[i].getTR() - tempTRmean));
                         }
                         diffSqSumBPL = diffSqSumBPL +
                                ( (BifsArray[i].getBPL() - tempBPLmean) *
                                 (BifsArray[i].getBPL() - tempBPLmean));
                    }
               }

               if ( (diffSqSumDR == 0) || (tempDRcount <= 2)) {
                    tempDRstdev = 0;
               }
               else {
                    tempDRstdev = java.lang.Math.sqrt(diffSqSumDR / (tempDRcount - 1));
               }
               if ( (diffSqSumPDR == 0) || (tempPDRcount <= 2)) {
                    tempPDRstdev = 0;
               }
               else {
                    tempPDRstdev = java.lang.Math.sqrt(diffSqSumPDR / (tempPDRcount - 1));
               }
               if ( (diffSqSumTR == 0) || (tempTRcount <= 2)) {
                    tempTRstdev = 0;
               }
               else {
                    tempTRstdev = java.lang.Math.sqrt(diffSqSumTR / (tempTRcount - 1));
               }
               if ( (diffSqSumBPL == 0) || (tempBPLcount <= 2)) {
                    tempBPLstdev = 0;
               }
               else {
                    tempBPLstdev = java.lang.Math.sqrt(diffSqSumBPL / (tempBPLcount - 1));
               }

               //if uf = 1, set all other params to 0
               if (tempDRuf == 1) {
                    tempDRmean = 0;
                    tempDRstdev = 0;
                    tempDRmin = 0;
                    tempDRmax = 0;
               }
               if (tempPDRuf == 1) {
                    tempPDRmean = 0;
                    tempPDRstdev = 0;
                    tempPDRmin = 0;
                    tempPDRmax = 0;
               }
               if (tempTRuf == 1) {
                    tempTRmean = 0;
                    tempTRstdev = 0;
                    tempTRmin = 0;
                    tempTRmax = 0;
               }
               //if there are no bifurcations, set pdr and dr to 1
               if (tempBifs == 0){
                    tempDRmean = 1;
                    tempPDRmean = 1;
                    tempDRuf = 1;
                    tempPDRuf = 1;
               }

               //if there are no bifurcationsor terminations, set biff % to 1 (happens in early PL bins)
           if ((tempBifs == 0) && (tempTerms == 0)){
                tempBiffPercent = 1;
           }
           else{
                tempBiffPercent = ( (double) tempBifs / (double) (tempBifs + tempTerms));
           }


               bbdTable[j].setAll(tempDRmean, tempDRstdev, tempDRmin,
                                  tempDRmax, tempDRuf, tempPDRmean,
                                  tempPDRstdev, tempPDRmin,
                                  tempPDRmax, tempPDRuf, tempTRmean,
                                  tempTRstdev, tempTRmin, tempTRmax,
                                  tempTRuf, tempBPLmean, tempBPLstdev,
                                  tempBPLmin, tempBPLmax,
                                  tempBiffPercent,
                                  tempBifs, tempTerms, paramToDo);
               bbdTable[j].setDRcurveType(tempDRcurveType);
               bbdTable[j].setPDRcurveType(tempPDRcurveType);
               bbdTable[j].setTRcurveType(tempTRcurveType);
               bbdTable[j].setBPLcurveType(tempBPLcurveType);

          }
          bbdTable[1].setArraySize(actualBins);
          return bbdTable;
     }


     public static int getTreeSize(swcparts.BiffLine[] BifsArray, int currentBranch) {
          int treeSize = 0;
          if (BifsArray[currentBranch].getBIFF() == 1) {
               treeSize = 1 +
                      BifsArray[currentBranch].getTreeSize(BifsArray,
                      BifsArray[currentBranch].getD1num()) +
                      BifsArray[currentBranch].getTreeSize(BifsArray,
                      BifsArray[currentBranch].getD2num());
               //    System.out.println(k);
               return treeSize;
          }
          // return 0;
          return treeSize;
     }

     public static double getVirtualAsymetry(swcparts.BiffLine[] BifsArray,
                                             int actualBiffLines) {
          double asymMean = 0;
          double asymSum = 0;
          double tree1tips = 0;
          double tree2tips = 0;
          double j = 0;

//System.out.println("   lines: "+actualBiffLines);
          for (int i = 1; i <= actualBiffLines; i++) { //for each biffline
               if (BifsArray[i].getBIFF() == 1) {
                    ++j;
                    tree1tips = (getTreeSize(BifsArray, BifsArray[i].getD1num()) + 1);
                 //   System.out.println("   i : "+i);
                 //   System.out.println("   t1tips :  "+tree1tips);
                    tree2tips = (getTreeSize(BifsArray, BifsArray[i].getD2num()) + 1);
                 //   System.out.println("   t2tips :  "+tree2tips);
                    if ( (tree1tips == 1) && (tree2tips == 1)) {
                         asymSum += 0;
                    }
                    else {
                         asymSum += Math.abs(tree1tips - tree2tips) / (tree1tips + tree2tips - 2);
                    }
                 //   System.out.println("  asymSum, j  "+asymSum+"  "+ j);
               }
          }
          if (j == 0) {
               return -1;
          }
          if (asymSum == 0) {
          //     System.out.println("returned :   0");
               return 0;
          }
          asymMean = asymSum / j;
        //  System.out.println("returned :   "+asymMean);
          return asymMean;
     }

     //returns the surface area from the curent point on
     public static double getVirtualSurface(swcparts.BiffLine[] BifsArray, int startLine) {
          double tempSurface = 0;
        //  double currentLength = BifsArray[startLine].BPL;
          tempSurface = BifsArray[startLine].getSurfaceArea();
         // System.out.println(startLine + " " + BifsArray[startLine].getD1num() + " " +
           //                  BifsArray[startLine].getD2num() + "  " +tempSurface);
          if (BifsArray[startLine].BIFF == 1) {
               tempSurface += getVirtualSurface(BifsArray, BifsArray[startLine].getD1num());
               tempSurface += getVirtualSurface(BifsArray, BifsArray[startLine].getD2num());
          }

          return tempSurface;
     }

     public static double getVirtualSurfaceAsym(swcparts.BiffLine[] BifsArray, int actualBiffLines) {
          double asymMean = 0;
          double asymSum = 0;
          double tree1Surface = 0;
          double tree2Surface = 0;
          double j = 0;

          for (int i = 1; i <= actualBiffLines; i++) { //for each biffline
               if (BifsArray[i].getBIFF() == 1) {
                    ++j;
                    tree1Surface = (getVirtualSurface(BifsArray, BifsArray[i].getD1num()));
                    //
                    tree2Surface = (getVirtualSurface(BifsArray, BifsArray[i].getD2num()));
                    //
                    if (tree1Surface == tree2Surface) {
                         asymSum += 0;
                    }
                    else {
                         asymSum += Math.abs(tree1Surface - tree2Surface) /
                                (tree1Surface + tree2Surface);
                    }
               }
          }
          if (j == 0) {
               return -1;
          }
          if (asymSum == 0) {
               return 0;
          }
          asymMean = asymSum / j;
          return asymMean;
     }

        public double getSurfaceArea() {
          return surfaceArea;
     }

     public void setSurface(double SA) {
          surfaceArea = SA;
     }
}
