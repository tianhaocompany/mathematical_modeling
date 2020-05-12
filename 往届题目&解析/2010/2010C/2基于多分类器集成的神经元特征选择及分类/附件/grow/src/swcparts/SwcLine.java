package swcparts;

import java.math.*;

public class SwcLine {

     static private int totalLines; //the same for all instances of SwcLine class
     private int lineNumber;
     private int origionalLineNumber;
     private int lineType;
     private double lineX;
     private double lineY;
     private double lineZ;
     private double lineRad;
     private int lineLink;
     private int numDaughters;
     private int lineTreeNum;
     private int lineBranchNum;
     private double segLength;
     private double branchLength;
     private double treeLength;
     private double eculidianDistanceToSoma;
     private int stemNumber;
     private int branchOrder;
     private int daughter1num;
     private int daughter2num;
     private double branchStartRad;
     private int termDegree;


     public void seTtermDegree(int tdg) {
         termDegree = tdg;
    }

    public int getTermDegree() {
         return termDegree;
    }

     public void setBranchStartRad(double bsr) {
          branchStartRad = bsr;
     }

     public double getBranchStartRad() {
          return branchStartRad;
     }

     public void setStemNumber(int SN) {
          stemNumber = SN;
     }

     public int getStemNumber() {
          return stemNumber;
     }

     public void setBranchOrder(int BO) {
          branchOrder = BO;
     }

     public int getBranchOrder() {
          return branchOrder;
     }

     public void setDaughter1num(int d1n) {
          daughter1num = d1n;
     }

     public void setDaughter2num(int d2n) {
          daughter2num = d2n;
     }

     public int getDaughter1num() {
          return daughter1num;
     }

     public int getDaughter2num() {
          return daughter2num;
     }

     public void setSegLength(double SL) {
          segLength = SL;
     }

     public void setBranchLength(double BL) {
          branchLength = BL;
     }

     public void setTreeLength(double TL) {
          treeLength = TL;
     }

     public void setEuclidianDistance(double ED) {
          eculidianDistanceToSoma = ED;
     }

     public double getSegLength() {
          return segLength;
     }

     public double getBranchLength() {
          return branchLength;
     }

     public double getTreeLength() {
          return treeLength;
     }

     public double getEuclidianDistance() {
          return eculidianDistanceToSoma;
     }

     public void setLine(int lnum, int ltype, double lx, double ly, double lz, double lRad,
                         int llink) {
          lineNumber = lnum;
          lineType = ltype;
          lineX = lx;
          lineY = ly;
          lineZ = lz;
          lineRad = lRad;
          lineLink = llink;
          origionalLineNumber = lnum;
     }

     public void setLine(int lnum, int olnum, int ltype, double lx, double ly, double lz,
                         double lRad, int llink) {
          lineNumber = lnum;
          origionalLineNumber = olnum;
          lineType = ltype;
          lineX = lx;
          lineY = ly;
          lineZ = lz;
          lineRad = lRad;
          lineLink = llink;
     }

     static public void setTotalLines(int ltnum) {
          totalLines = ltnum;
     }

     public void setNumDaughters(int nd) {
          numDaughters = nd;

     }

     public void setLineTreeNum(int ltn) {
          lineTreeNum = ltn;
     }

     public void setLineBranchNum(int lbn) {
          lineBranchNum = lbn;
     }

     public void setLineNum(int ln) {
          lineNumber = ln;
     }

     public void setLineType(int lt) {
          lineType = lt;
     }

     public void setLineX(double lx) {
          lineX = lx;
     }

     public void setLineY(double ly) {
          lineY = ly;
     }

     public void setLineZ(double lz) {
          lineZ = lz;
     }

     public void setLineRadius(double ld) {
          lineRad = ld;
     }

     public void setLineLink(int ll) {
          lineLink = ll;
     }

     public void setOrigionalLineNum(int oln) {
          origionalLineNumber = oln;
     }

     static public int getTotalLines() {
          return totalLines;
     }

     public int getLineNumber() {
          return lineNumber;
     }

     public int getLineType() {
          return lineType;
     }

     public double getLineX() {
          return lineX;
     }

     public double getLineY() {
          return lineY;
     }

     public double getLineZ() {
          return lineZ;
     }

     public double getLineRad() {
          return lineRad;
     }

     public int getLineLink() {
          return lineLink;
     }

     public int getNumDaughters() {
          return numDaughters;
     }

     public int getLineTreeNum() {
          return lineTreeNum;
     }

     public int getLineBranchNum() {
          return lineBranchNum;
     }

     public int getOrigionalLineNum() {
          return origionalLineNumber;
     }

     public double getDistance(SwcLine l1) {
          if ( ( (this.lineX - l1.lineX) * (this.lineX - l1.lineX)) +
              ( (this.lineY - l1.lineY) * (this.lineY - l1.lineY)) +
              ( (this.lineZ - l1.lineZ) * (this.lineZ - l1.lineZ)) == 0) {
               return 0;
          }
          else {
               return Math.sqrt( ( (this.lineX - l1.lineX) * (this.lineX - l1.lineX)) +
                                ( (this.lineY - l1.lineY) * (this.lineY - l1.lineY)) +
                                ( (this.lineZ - l1.lineZ) * (this.lineZ - l1.lineZ)));
          }
     }

}
