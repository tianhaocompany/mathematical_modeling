package swcparts;

import java.io.*;
import java.text.*;
import java.math.*;

public class SwcNeuron {
     public int maxSWClines = 100000;
     public int maxCommentLines = 50000;
     public String[] CommentLineArray = new String[maxCommentLines];
     public SwcLine[] LineArray = new SwcLine[maxSWClines];
     public int NeuronSize;
     public int CommentSize;
     public String FileName;
     public String PatternOut = "0.####";
     public DecimalFormat myFormatter = new DecimalFormat(PatternOut);
     public boolean termDegreeSet = false;

     public void InitSwcNeuron(String in) {
          FileName = in;
          try {
               //Buffer input stream
               //open input file
               FileInputStream fin = new FileInputStream(in);
               BufferedInputStream bin = new BufferedInputStream(fin);
               //character stream
               BufferedReader r = new BufferedReader(new InputStreamReader(bin));
               r.mark(1);

               //Input comment lines into string array
               for (int i = 1; 1 < maxCommentLines; i++) {
                    CommentLineArray[i] = new String();
                    CommentLineArray[i] = r.readLine();
                    if ( (CommentLineArray[i] != null) && (CommentLineArray[i].startsWith("#"))) {
                         ++CommentSize;
                    }
                    else {
                         break;
                    }
               }

               //Tokenize buffered input stream
               r.reset();
               StreamTokenizer tokens = new StreamTokenizer(r);

               //set tokens paramaters
               tokens.commentChar('#');
               tokens.parseNumbers();

               //initialize temp paramaters to read from swc file and place into SwcLines array
               int tempLineNum;
               int tempLineType;
               double tempX;
               double tempY;
               double tempZ;
               double tempRad;
               int tempLink = 0;
               boolean eof = false;
               boolean eol = false;
               int linesRead = 0;
               int c;
               int d;
               tokens.eolIsSignificant(true);

               while (eof == false) {
                    eol = false;
                    c = tokens.nextToken();
                    if (c == StreamTokenizer.TT_EOF) {
                         eof = true;
                    }
                    else if (c == StreamTokenizer.TT_EOL) {
                         eol = true;
                    }
                    else {
                         tempLineNum = (int) tokens.nval;
                         c = tokens.nextToken();
                         if (c == StreamTokenizer.TT_EOF) {
                              eof = true;
                         }
                         else if (c == StreamTokenizer.TT_EOL) {
                              eol = true;
                         }
                         else {
                              tempLineType = (int) tokens.nval;
                              c = tokens.nextToken();
                              if (c == StreamTokenizer.TT_EOF) {
                                   eof = true;
                              }
                              else if (c == StreamTokenizer.TT_EOL) {
                                   eol = true;
                              }
                              else {
                                   tempX = tokens.nval;
                                   c = tokens.nextToken();
                                   if (c == StreamTokenizer.TT_EOF) {
                                        eof = true;
                                   }
                                   else if (c == StreamTokenizer.TT_EOL) {
                                        eol = true;
                                   }
                                   else {
                                        tempY = tokens.nval;
                                        c = tokens.nextToken();
                                        if (c == StreamTokenizer.TT_EOF) {
                                             eof = true;
                                        }
                                        else if (c == StreamTokenizer.TT_EOL) {
                                             eol = true;
                                        }
                                        else {
                                             tempZ = tokens.nval;
                                             c = tokens.nextToken();
                                             if (c == StreamTokenizer.TT_EOF) {
                                                  eof = true;
                                             }
                                             else if (c == StreamTokenizer.TT_EOL) {
                                                  eol = true;
                                             }
                                             else {
                                                  tempRad = tokens.nval;
                                                  c = tokens.nextToken();
                                                  if (c == StreamTokenizer.TT_EOF) {
                                                       eof = true;
                                                  }
                                                  else if (c == StreamTokenizer.TT_EOL) {
                                                       eol = true;
                                                  }
                                                  else {
                                                       tempLink = (int) tokens.nval;
                                                       ++linesRead;
                                                  }
                                                  LineArray[linesRead] = new swcparts.SwcLine();
                                                  LineArray[linesRead].setLine(tempLineNum,
                                                         tempLineNum, tempLineType, tempX, tempY,
                                                         tempZ, tempRad, tempLink);
                                                  //System.out.println(linesRead);
                                                  if (tempLink > 0) {
                                                       LineArray[tempLink].setNumDaughters(
                                                              LineArray[
                                                              tempLink].getNumDaughters() + 1);

                                                       LineArray[tempLineNum].setSegLength(
                                                              LineArray[
                                                              tempLineNum].getDistance(LineArray[
                                                              tempLink]));

                                                       if (LineArray[tempLink].getNumDaughters() ==
                                                              1) {
                                                            LineArray[tempLink].setDaughter1num(
                                                                   tempLineNum);

                                                       }
                                                       else if (LineArray[tempLink].getNumDaughters() ==
                                                              2) {
                                                            LineArray[tempLink].setDaughter2num(
                                                                   tempLineNum);
                                                       }
                                                  }
                                             }
                                        }
                                   }
                              }
                         }
                    }
               }
               NeuronSize = linesRead;

               //System.out.println(LineArray.length);
               this.setLengths();
               this.setStemsStartRadAndBO();
               this.setAllLineTreeNumber();
               //    System.out.println(linesRead);
          }
          catch (IOException e) {
               System.out.println("error:  " + e.getMessage());
               System.out.println("Hit enter.");
               char character;
               try {
                    character = (char) System.in.read();
               }
               catch (IOException f) {}
          }
     }

//returns the cell partition asymetry
     public double getCellAsymetry(int typeToDo) {
          // if (!this.getTermDegreeSet()) {
          //      this.setTermDegrees();
          // }
          double j = 0;
          double asymSum = 0;
          double asymMean = 0;
          int tree1tips = 0;
          int tree2tips = 0;
          //  double tempAsyem = 0;

          for (int i = 2; i < NeuronSize; ++i) {
               if ( (this.getNumDaughters(i) == 2) && (this.getType(i) == typeToDo)) {
                    j += 1;
                    tree1tips = (this.getTreeSize(this.getDaughter1num(i)) + 1);

                    tree2tips = (this.getTreeSize(this.getDaughter2num(i)) + 1);
                    if ( (tree1tips == 1) && (tree2tips == 1)) {
                         asymSum += 0;

                         //     tempAsyem = 0;
                    }
                    else {
                         asymSum += Math.abs(tree1tips - tree2tips) /
                                (tree1tips + tree2tips - 2);
                         //    tempAsyem = Math.abs(tree1tips - tree2tips) /
                         //           (tree1tips + tree2tips - 2);
                    }

               }
          }
          asymMean = asymSum / j;
          return asymMean;
     }

     //returns the partition asymetry from the curent point on
     public double getTreeAsymetry(int currentBranch, int typeToDo) {
          double j = 0;
          double asymSum = 0;
          double asymMean = 0;
          double tree1tips = 0;
          double tree2tips = 0;
          int currentTreeNum = this.getTreeNumber(currentBranch);
          //  double tempAsyem = 0;
          for (int i = currentBranch; i < NeuronSize; ++i) {
               if ( (this.getNumDaughters(i) == 2) && (this.getType(i) == typeToDo)) {
                    if (this.getTreeNumber(i) == currentTreeNum) {
                         j += 1;
                         tree1tips = (this.getTreeSize(this.getDaughter1num(i)) + 1);
                         //   System.out.println("tree 1 tips = "+tree1tips);
                         tree2tips = (this.getTreeSize(this.getDaughter2num(i)) + 1);
                         //  System.out.println("tree 2 tips = "+tree2tips);
                         if ( (tree1tips == 1) && (tree2tips == 1)) {
                              asymSum += 0;
    //                          System.out.println(0);
                              //   tempAsyem = 0;
                         }
                         else {
                              asymSum += Math.abs(tree1tips - tree2tips) /
                                     (tree1tips + tree2tips - 2);
    //        System.out.println(Math.abs(tree1tips - tree2tips) /
                    //                 (tree1tips + tree2tips - 2));
                              //  tempAsyem = ( (Math.abs(tree1tips - tree2tips)) /
                              //               (tree1tips + tree2tips - 2));
                         }
                         // System.out.println("asymSum, j = "+asymSum+"  "+j);
                         //System.out.println("   tree num, line number,  Tips1, Tips2, Asyem : " +
                         //                   currentTreeNum + "  " + i + "  " + tree1tips + "  " +
                         //                   tree2tips + "  " + tempAsyem);
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

     //returns the surface area from the curent point on
     public double getTreeSurface(int currentBranch, int typeToDo) {
          double tempSurface = 0;
          int k = currentBranch;
          double currentLength = 0;
          if (this.getType(k) != typeToDo) {
              return 0;
          }

          while (this.getNumDaughters(k) == 1) {
               currentLength = LineArray[k].getDistance(LineArray[this.getDaughter1num(k)]);
               tempSurface += (Math.PI*(this.getRad(k)+this.getRad(this.getDaughter1num(k)))*currentLength);
              // System.out.println(currentLength +"  "+this.getRad(k)+"  "+this.getRad(this.getDaughter1num(k))+"  "+Math.PI*(this.getRad(k)+this.getRad(this.getDaughter1num(k)))*currentLength);
               k = this.getDaughter1num(k);
          }

          if (this.getNumDaughters(k) == 0) {
               return tempSurface;
          }
          if (this.getNumDaughters(k) == 2) {
               if ( (this.getType(this.getDaughter1num(k)) != typeToDo) &&
                   (this.getType(this.getDaughter1num(k)) != typeToDo)) {
                    tempSurface += 0;
                   // System.out.println("  both daughters bad type");
               }

               else if (this.getType(this.getDaughter1num(k)) != typeToDo) {
                    currentLength = LineArray[k].getDistance(LineArray[this.getDaughter2num(k)]);
               tempSurface += (Math.PI*(this.getRad(k)+this.getRad(this.getDaughter2num(k)))*currentLength);

               tempSurface += this.getTreeSurface(this.getDaughter2num(k), typeToDo);
                  //  System.out.println("  1 daughters bad type");
               }

               else if (this.getType(this.getDaughter2num(k)) != typeToDo) {
                    currentLength = LineArray[k].getDistance(LineArray[this.getDaughter1num(k)]);
               tempSurface += (Math.PI*(this.getRad(k)+this.getRad(this.getDaughter1num(k)))*currentLength);


                    tempSurface += this.getTreeSurface(this.getDaughter1num(k), typeToDo);
                    // System.out.println("  2 daughters bad type");
               }
               else {
                    currentLength = LineArray[k].getDistance(LineArray[this.getDaughter1num(k)]);
               tempSurface += (Math.PI*(this.getRad(k)+this.getRad(this.getDaughter1num(k)))*currentLength);

               currentLength = LineArray[k].getDistance(LineArray[this.getDaughter2num(k)]);
              tempSurface += (Math.PI*(this.getRad(k)+this.getRad(this.getDaughter2num(k)))*currentLength);


                    tempSurface += this.getTreeSurface(this.getDaughter1num(k), typeToDo) +
                           this.getTreeSurface(this.getDaughter2num(k), typeToDo);
                  //  System.out.println("  both daughters "+tempSurface);
               }
              // System.out.println("  "+tempSurface);
               return tempSurface;
          }
          return 0;

     }

     //returns the surface area asymetry from the curent point on
     public double getTreeSurfaceAsym(int currentBranch, int typeToDo) {
          double j = 0;
          double asymSum = 0;
          double asymMean = 0;
          double tree1surface = 0;
          double tree2surface = 0;
          int currentTreeNum = this.getTreeNumber(currentBranch);
          //  double tempAsyem = 0;
          for (int i = currentBranch; i < NeuronSize; ++i) {
               if ( (this.getNumDaughters(i) == 2) && (this.getType(i) == typeToDo)) {
                    if (this.getTreeNumber(i) == currentTreeNum) {
                         j += 1;
                         tree1surface = (this.getTreeSurface(this.getDaughter1num(i),typeToDo));
                         tree2surface = (this.getTreeSurface(this.getDaughter2num(i), typeToDo));
                         if ( (tree1surface == tree2surface)) {
                              asymSum += 0;

                         }
                         else {
                              asymSum += Math.abs(tree1surface - tree2surface) /
                                     (tree1surface + tree2surface);
                         }
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


//function to remove axons from basal trees (for example) so they don't mess up branch order/tree size calcs
     public void removeOtherTypeSideBranches(int type) {
          for (int i = 2; i < NeuronSize; ++i) {
               if ( (LineArray[i].getLineType() == type) && (LineArray[i].getNumDaughters() == 2)) {
                    if ( (LineArray[LineArray[i].getDaughter1num()].getLineType() != type) &&
                        (LineArray[LineArray[i].getDaughter2num()].getLineType() != type)) {
                         LineArray[i].setNumDaughters(0);
                         LineArray[i].setDaughter1num(0);
                         LineArray[i].setDaughter2num(0);
                    }
                    else if (LineArray[LineArray[i].getDaughter1num()].getLineType() != type) {
                         LineArray[i].setNumDaughters(1);
                         LineArray[i].setDaughter1num(LineArray[i].getDaughter2num());
                    }
                    else if (LineArray[LineArray[i].getDaughter2num()].getLineType() != type) {
                         LineArray[i].setNumDaughters(1);
                         LineArray[i].setDaughter2num(0);
                    }

               }
               else if ( (LineArray[i].getLineType() == type) &&
                        (LineArray[i].getNumDaughters() == 1)) {
                    if (LineArray[LineArray[i].getDaughter1num()].getLineType() != type) {
                         LineArray[i].setNumDaughters(0);
                         LineArray[i].setDaughter1num(0);
                    }
               }
          }
     }

     public int getSize() {
          return NeuronSize;
     }

     public double getSegLength(int linenum) {
          return this.LineArray[linenum].getSegLength();
     }

     public int getBranchOrder(int linenum) {
          return this.LineArray[linenum].getBranchOrder();
     }

     public double getBranchStartRad(int linenum) {
          return this.LineArray[linenum].getBranchStartRad();
     }

     public int getStemNumber(int linenum) {
          return this.LineArray[linenum].getStemNumber();
     }

     public int getTreeNumber(int linenum) {
          return this.LineArray[linenum].getLineTreeNum();

     }

     public double getTreeLength(int linenum) {
          return this.LineArray[linenum].getTreeLength();
     }

     public double getEDistanceToSoma(int linenum) {
          return this.LineArray[linenum].getEuclidianDistance();
     }

     public double getBranchLength(int linenum) {
          return this.LineArray[linenum].getBranchLength();
     }

     public double getZ(int linenum) {
          return LineArray[linenum].getLineZ();
     }

     public double getY(int linenum) {
          return LineArray[linenum].getLineY();
     }

     public double getX(int linenum) {
          return LineArray[linenum].getLineX();
     }

     public double getRad(int linenum) {
          return LineArray[linenum].getLineRad();
     }

     public int getLink(int linenum) {
          return LineArray[linenum].getLineLink();
     }

     public int getType(int linenum) {
          return LineArray[linenum].getLineType();
     }

     public int getNumDaughters(int linenum) {
          return LineArray[linenum].getNumDaughters();
     }

     public int getDaughter1num(int linenum) {
          return LineArray[linenum].getDaughter1num();
     }

     public int getDaughter2num(int linenum) {
          return LineArray[linenum].getDaughter2num();
     }

     public double getDaughter1rad(int linenum) {
          return LineArray[LineArray[linenum].getDaughter1num()].getLineRad();
     }

     public double getDaughter2rad(int linenum) {
          return LineArray[LineArray[linenum].getDaughter2num()].getLineRad();
     }

     public double getParentRad(int linenum) {
          return LineArray[LineArray[linenum].getLineLink()].getLineRad();
     }

// check for type 1.1 and 1.2 errors
     public void badType(PrintWriter fileout) {
          for (int i = 2; i < NeuronSize; ++i) {
               if ( (LineArray[i].getLineType() < (1)) || (LineArray[i].getLineType() > (10))) {
                    fileout.println("1.1  Line " + LineArray[i].getOrigionalLineNum() + " of type " +
                                    LineArray[i].getLineType() +
                                    " is of an invalid type.  (no action taken)");
                    fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " + this.getY(i) +
                                    "  " + this.getZ(i));
               }
               if ( (LineArray[i].getLineType() !=
                     LineArray[LineArray[i].getLineLink()].getLineType()) &&
                   (LineArray[LineArray[i].getLineLink()].getLineType() != 1)) {
                    fileout.println("1.2  Line " + LineArray[i].getOrigionalLineNum() + " of type " +
                                    LineArray[i].getLineType() + " links to incorrect type " +
                                    LineArray[LineArray[i].getLineLink()].getLineType() +
                                    ".  (no action taken)");
                    fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " + this.getY(i) +
                                    "  " + this.getZ(i));
               }
          }
     }

     // check for type 1.1 and 1.2 errors
     public void badTypeFix(PrintWriter fileout) {
          for (int i = 2; i < NeuronSize; ++i) {
               if ( (LineArray[i].getLineType() < (1)) || (LineArray[i].getLineType() > (10))) {
                    fileout.print("1.1  Line " + LineArray[i].getOrigionalLineNum() + " of type " +
                                  LineArray[i].getLineType() + " is of an invalid type");

                    if ( (LineArray[i].getLineType() !=
                          LineArray[LineArray[i].getLineLink()].getLineType()) &&
                        (LineArray[LineArray[i].getLineLink()].getLineType() ==
                         this.getFirstDaughterNumType(i))) {
                         LineArray[i].setLineType(LineArray[LineArray[i].getLineLink()].getLineType());
                         fileout.println("      (type changed to " +
                                         LineArray[LineArray[i].getLineLink()].getLineType() + ")");
                         fileout.println("     A       X, Y, Z:  " + this.getX(i) + "  " +
                                         this.getY(i) + "  " + this.getZ(i));

                    }
                    else {
                         fileout.println(".  (no action taken)");
                         fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " +
                                         this.getY(i) + "  " + this.getZ(i));
                    }
               }
               if ( (LineArray[i].getLineType() !=
                     LineArray[LineArray[i].getLineLink()].getLineType()) &&
                   (LineArray[LineArray[i].getLineLink()].getLineType() != 1)) {
                    fileout.print("1.2  Line " + LineArray[i].getOrigionalLineNum() + " of type " +
                                  LineArray[i].getLineType() + " links to incorrect type " +
                                  LineArray[LineArray[i].getLineLink()].getLineType());
                    if (LineArray[LineArray[i].getLineLink()].getLineType() ==
                        this.getFirstDaughterNumType(i)) {
                         LineArray[i].setLineType(LineArray[LineArray[i].getLineLink()].getLineType());
                         fileout.println("      (type changed to " +
                                         LineArray[LineArray[i].getLineLink()].getLineType() + ")");
                         fileout.println("     A       X, Y, Z:  " + this.getX(i) + "  " +
                                         this.getY(i) + "  " + this.getZ(i));

                    }
                    else {
                         fileout.println(".  (no action taken)");
                         fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " +
                                         this.getY(i) + "  " + this.getZ(i));
                    }
               }
          }
     }

     //check for type 2.2
     public void badStartType(PrintWriter fileout) {
          if (LineArray[1].getLineType() != 1) {
               fileout.println("2.2  Line 1 is of type " + LineArray[1].getLineType() +
                               ".  (no action taken)");
               fileout.println("     B1      X, Y, Z:  " + this.getX(1) + this.getY(1) +
                               this.getZ(1));
          }
     }

     //check for type 3.4
     public void badStartLink(PrintWriter fileout) {
          if (LineArray[1].getLineLink() != -1) {
               fileout.println("2.2  Line 1 links to " + LineArray[1].getLineLink() +
                               ".  (no action taken)");
               fileout.println("     B1      X, Y, Z:  " + this.getX(1) + this.getY(1) +
                               this.getZ(1));
          }
     }

     //check for and fix type 3.4
     public void badStartLinkFix(PrintWriter fileout) {
          if (LineArray[1].getLineLink() != -1) {
               fileout.println("2.2  Line 1 links to " + LineArray[1].getLineLink() +
                               "     Changed to -1");
               fileout.println("     A       X, Y, Z:  " + this.getX(1) + this.getY(1) +
                               this.getZ(1));
               LineArray[1].setLineLink( -1);
          }
     }

     //check for type 3.3
     public void pointSoma(PrintWriter fileout) {
          if (this.countType(1) == 1) {
               fileout.println("3.3  Line 1 links to " + LineArray[1].getLineLink() +
                               ".  (no action taken)");
               fileout.println("     B1      X, Y, Z:  " + this.getX(1) + this.getY(1) +
                               this.getZ(1));
          }
     }

     //check for type 4.1, 4.2, 4.3) min value, max stdev,
     public void badRadMinStdev(PrintWriter fileout, double min, double stDevm) {
          double mean = this.meanRad();
          double stdev = this.stdevRad();
          for (int i = 2; i < NeuronSize; ++i) {
               if (LineArray[i].getLineRad() == 0) {
                    fileout.println("4.1  Radius of line " + LineArray[i].getOrigionalLineNum() +
                                    " = 0.  (no action taken) ");
                    fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " + this.getY(i) +
                                    "  " + this.getZ(i));
               }
               else if (LineArray[i].getLineRad() <= min) {
                    fileout.println("4.2  Radius of line " + LineArray[i].getOrigionalLineNum() +
                                    " at " + LineArray[i].getLineRad() + " <= " + min +
                                    ".  (no action taken)");
                    fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " + this.getY(i) +
                                    "  " + this.getZ(i));
               }
               if (LineArray[i].getLineRad() - mean >= stdev * stDevm) {
                    fileout.println("4.3  Radius of line " + LineArray[i].getOrigionalLineNum() +
                                    " at " + LineArray[i].getLineRad() + " >= " + stDevm +
                                    " stdevs.  (no action taken)");
                    fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " + this.getY(i) +
                                    "  " + this.getZ(i));
               }
          }
     }

     //check for type 4.1, 4.2, 4.3)terminal stdev, min value, max stdev,
     public void badRadTermsMinStdev(PrintWriter fileout, double terms, double min, double stDevm) {
          double termMax = (this.meanTermRad() + (terms * this.stdevTermRad()));
          double mean = this.meanRad();
          double stdev = this.stdevRad();
          for (int i = 2; i < NeuronSize; ++i) {
               if (LineArray[i].getLineRad() == 0) {
                    fileout.println("4.1  Radius of line " + LineArray[i].getOrigionalLineNum() +
                                    " = 0.  (no action taken) ");
                    fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " + this.getY(i) +
                                    "  " + this.getZ(i));
               }

               else if (LineArray[i].getLineRad() <= min) {
                    fileout.println("4.2  Radius of line " + LineArray[i].getOrigionalLineNum() +
                                    " at " + LineArray[i].getLineRad() + " <= " + min +
                                    ".  (no action taken)");
                    fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " + this.getY(i) +
                                    "  " + this.getZ(i));
               }
               if ( (LineArray[i].getLineRad() >= termMax) && (LineArray[i].getNumDaughters() == 0)) {
                    fileout.println("4.5  Radius of terminal line " +
                                    LineArray[i].getOrigionalLineNum() + " at " +
                                    LineArray[i].getLineRad() + " >= " + terms +
                                    " stdevs above the mean.  (no action taken)");
                    fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " + this.getY(i) +
                                    "  " + this.getZ(i));
               }
               else if (LineArray[i].getLineRad() - mean >= stdev * stDevm) {
                    fileout.println("4.3  Radius of line " + LineArray[i].getOrigionalLineNum() +
                                    " at " + LineArray[i].getLineRad() + " >= " + stDevm +
                                    " stdevs above the mean.  (no action taken)");
                    fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " + this.getY(i) +
                                    "  " + this.getZ(i));
               }

          }
     }

     //check for type 4.1, 4.2, 4.3)min value, max stdev, type
     public void badRadMinStdev(PrintWriter fileout, double min, double stDevm, int type) {
          double mean = this.meanRad(type);
          double stdev = this.stdevRad(type);
          for (int i = 2; i < NeuronSize; ++i) {
               if ( (LineArray[i].getLineType() == type)) {
                    if (LineArray[i].getLineRad() == 0) {
                         fileout.println("4.1  Radius of line " + LineArray[i].getOrigionalLineNum() +
                                         " = 0.  (no action taken) ");
                         fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " +
                                         this.getY(i) + "  " + this.getZ(i));
                    }
                    else if (LineArray[i].getLineRad() <= min) {
                         fileout.println("4.2  Radius of line " + LineArray[i].getOrigionalLineNum() +
                                         " at " + LineArray[i].getLineRad() + " <= " + min +
                                         ".  (no action taken)");
                         fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " +
                                         this.getY(i) + "  " + this.getZ(i));
                    }
                    if (LineArray[i].getLineRad() - mean >= stdev * stDevm) {
                         fileout.println("4.3  Radius of line " + LineArray[i].getOrigionalLineNum() +
                                         " at " + LineArray[i].getLineRad() + " >= " + stDevm +
                                         " stdevs above the mean.  (no action taken)");
                         fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " +
                                         this.getY(i) + "  " + this.getZ(i));
                    }
               }
          }
     }

     //check for type 4.1, 4.2, 4.3)  terminal stdev, min value, max stdev, type
     public void badRadTermsMinStdev(PrintWriter fileout, double terms, double min, double stDevm,
                                     int type) {
          double termMax = (this.meanTermRad(type) + (terms * this.stdevTermRad(type)));
          double mean = this.meanRad(type);
          double stdev = this.stdevRad(type);
          for (int i = 2; i < NeuronSize; ++i) {
               if ( (LineArray[i].getLineType() == type)) {
                    if (LineArray[i].getLineRad() == 0) {
                         fileout.println("4.1  Radius of line " + LineArray[i].getOrigionalLineNum() +
                                         " = 0.  (no action taken) ");
                         fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " +
                                         this.getY(i) + "  " + this.getZ(i));
                    }

                    else if (LineArray[i].getLineRad() <= min) {
                         fileout.println("4.2  Radius of line " + LineArray[i].getOrigionalLineNum() +
                                         " at " + LineArray[i].getLineRad() + " <= " + min +
                                         ".  (no action taken)");
                         fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " +
                                         this.getY(i) + "  " + this.getZ(i));
                    }
                    if ( (LineArray[i].getLineRad() >= termMax) &&
                        (LineArray[i].getNumDaughters() == 0)) {
                         fileout.println("4.5  Radius of terminal line " +
                                         LineArray[i].getOrigionalLineNum() + " at " +
                                         LineArray[i].getLineRad() + " >= " + terms +
                                         " stdevs above the mean.  (no action taken)");
                         fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " +
                                         this.getY(i) + "  " + this.getZ(i));
                    }
                    else if (LineArray[i].getLineRad() - mean >= stdev * stDevm) {
                         fileout.println("4.3  Radius of line " + LineArray[i].getOrigionalLineNum() +
                                         " at " + LineArray[i].getLineRad() + " >= " + stDevm +
                                         " stdevs above the mean.  (no action taken)");
                         fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " +
                                         this.getY(i) + "  " + this.getZ(i));
                    }

               }
          }
     }

//check for type 4.1, 4.2, 4.3)  terminal stdev, min value, max stdev, type
     public void badRadTermsMinStdevFixZero(PrintWriter fileout, double terms, double min,
                                            double stDevm, int type) {
          double termMax = (this.meanTermRad(type) + (terms * this.stdevTermRad(type)));
          double mean = this.meanRad(type);
          double stdev = this.stdevRad(type);
          for (int i = 2; i <= NeuronSize; ++i) {
               if ( (LineArray[i].getLineType() == type)) {
                    if (LineArray[i].getLineRad() == 0) {
                         LineArray[i].setLineRadius(LineArray[LineArray[i].getLineLink()].
                                getLineRad());
                         fileout.println("4.1  Radius of line " + LineArray[i].getOrigionalLineNum() +
                                         " = 0.  (changed to " +
                                         LineArray[LineArray[i].getLineLink()].getLineRad() +
                                         ")");
                         fileout.println("     A       X, Y, Z:  " + this.getX(i) + "  " +
                                         this.getY(i) + "  " + this.getZ(i));
                    }
                    else if (LineArray[i].getLineRad() <= min) {
                         fileout.println("4.2  Radius of line " + LineArray[i].getOrigionalLineNum() +
                                         " at " + LineArray[i].getLineRad() + " <= " + min +
                                         ".  (no action taken)");
                         fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " +
                                         this.getY(i) + "  " + this.getZ(i));
                    }
                    if ( (LineArray[i].getLineRad() >= termMax) &&
                        (LineArray[i].getNumDaughters() == 0)) {
                         fileout.println("4.5  Radius of terminal line " +
                                         LineArray[i].getOrigionalLineNum() + " at " +
                                         LineArray[i].getLineRad() + " >= " + terms +
                                         " stdevs above the mean.  (no action taken)");
                         fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " +
                                         this.getY(i) + "  " + this.getZ(i));
                    }
                    else if (LineArray[i].getLineRad() - mean >= stdev * stDevm) {
                         fileout.println("4.3  Radius of line " + LineArray[i].getOrigionalLineNum() +
                                         " at " + LineArray[i].getLineRad() + " >= " + stDevm +
                                         " stdevs above the mean.  (no action taken)");
                         fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " +
                                         this.getY(i) + "  " + this.getZ(i));
                    }

               }
          }
     }

     //check for type 4.1, 4.2, 4.3)
     public void badRadTermsMinMax(PrintWriter fileout, double terms, double min, double max) {
          double termMax = (this.meanTermRad() + (terms * this.stdevTermRad()));
          for (int i = 2; i < NeuronSize; ++i) {
               if (LineArray[i].getLineRad() == 0) {
                    fileout.println("4.1  Radius of line " + LineArray[i].getOrigionalLineNum() +
                                    " = 0 .  (no action taken)");
                    fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " + this.getY(i) +
                                    "  " + this.getZ(i));
               }

               else if (LineArray[i].getLineRad() <= min) {
                    fileout.println("4.2  Radius of line " + LineArray[i].getOrigionalLineNum() +
                                    " at " + LineArray[i].getLineRad() + " <= " + min +
                                    ".  (no action taken)");
                    fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " + this.getY(i) +
                                    "  " + this.getZ(i));
               }
               if ( (LineArray[i].getLineRad() >= termMax) && (LineArray[i].getNumDaughters() == 0)) {
                    fileout.println("4.5  Radius of terminal line " +
                                    LineArray[i].getOrigionalLineNum() + " at " +
                                    LineArray[i].getLineRad() + " >= " + terms +
                                    " stdevs above the mean.  (no action taken)");
                    fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " + this.getY(i) +
                                    "  " + this.getZ(i));
               }
               else if (LineArray[i].getLineRad() >= max) {
                    fileout.println("4.3  Radius of line " + LineArray[i].getOrigionalLineNum() +
                                    " at " + LineArray[i].getLineRad() + " >= " + max +
                                    ".  (no action taken)");
                    fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " + this.getY(i) +
                                    "  " + this.getZ(i));
               }

          }
     }

//check for type 4.1, 4.2, 4.3)
     public void badRadMinMax(PrintWriter fileout, double min, double max) {
          for (int i = 2; i < NeuronSize; ++i) {
               if (LineArray[i].getLineRad() == 0) {
                    fileout.println("4.1  Radius of line " + LineArray[i].getOrigionalLineNum() +
                                    " = 0 .  (no action taken)");
                    fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " + this.getY(i) +
                                    "  " + this.getZ(i));
               }
               else if (LineArray[i].getLineRad() <= min) {
                    fileout.println("4.2  Radius of line " + LineArray[i].getOrigionalLineNum() +
                                    " at " + LineArray[i].getLineRad() + " <= " + min +
                                    ".  (no action taken)");
                    fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " + this.getY(i) +
                                    "  " + this.getZ(i));
               }
               if (LineArray[i].getLineRad() >= max) {
                    fileout.println("4.3  Radius of line " + LineArray[i].getOrigionalLineNum() +
                                    " at " + LineArray[i].getLineRad() + " >= " + max +
                                    ".  (no action taken)");
                    fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " + this.getY(i) +
                                    "  " + this.getZ(i));
               }
          }
     }

     //check for type 4.1, 4.2, 4.3)
     public void badRadMinMax(PrintWriter fileout, double min, double max, int type) {
          for (int i = 2; i < NeuronSize; ++i) {
               if ( (LineArray[i].getLineType() == type)) {
                    if (LineArray[i].getLineRad() == 0) {
                         fileout.println("4.1  Radius of line " + LineArray[i].getOrigionalLineNum() +
                                         " = 0.  (no action taken) ");
                         fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " +
                                         this.getY(i) + "  " + this.getZ(i));
                    }
                    else if (LineArray[i].getLineRad() <= min) {
                         fileout.println("4.2  Radius of line " + LineArray[i].getOrigionalLineNum() +
                                         " at " + LineArray[i].getLineRad() + " <= " + min +
                                         ".  (no action taken)");
                         fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " +
                                         this.getY(i) + "  " + this.getZ(i));
                    }
                    if (LineArray[i].getLineRad() >= max) {
                         fileout.println("4.3  Radius of line " + LineArray[i].getOrigionalLineNum() +
                                         " at " + LineArray[i].getLineRad() + " >= " + max +
                                         ".  (no action taken)");
                         fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " +
                                         this.getY(i) + "  " + this.getZ(i));
                    }
               }
          }
     }

     //check for type 4.1, 4.2, 4.3)
     public void badRadTermsMinMax(PrintWriter fileout, double terms, double min, double max,
                                   int type) {
          double termMax = (this.meanTermRad(type) + (terms * this.stdevTermRad(type)));

          for (int i = 2; i < NeuronSize; ++i) {
               if ( (LineArray[i].getLineType() == type)) {
                    if (LineArray[i].getLineRad() == 0) {
                         fileout.println("4.1  Radius of line " + LineArray[i].getOrigionalLineNum() +
                                         " = 0.  (no action taken) ");
                         fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " +
                                         this.getY(i) + "  " + this.getZ(i));
                    }
                    else if (LineArray[i].getLineRad() <= min) {
                         fileout.println("4.2  Radius of line " + LineArray[i].getOrigionalLineNum() +
                                         " at " + LineArray[i].getLineRad() + " <= " + min +
                                         ".  (no action taken)");
                         fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " +
                                         this.getY(i) + "  " + this.getZ(i));
                    }
                    if ( (LineArray[i].getLineRad() >= termMax) &&
                        (LineArray[i].getNumDaughters() == 0)) {
                         fileout.println("4.5  Radius of terminal line " +
                                         LineArray[i].getOrigionalLineNum() + " at " +
                                         LineArray[i].getLineRad() + " >= " + terms +
                                         " stdevs above the mean.  (no action taken)");
                         fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " +
                                         this.getY(i) + "  " + this.getZ(i));
                    }
                    else if (LineArray[i].getLineRad() >= max) {
                         fileout.println("4.3  Radius of line " + LineArray[i].getOrigionalLineNum() +
                                         " at " + LineArray[i].getLineRad() + " >= " + max +
                                         ".  (no action taken)");
                         fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " +
                                         this.getY(i) + "  " + this.getZ(i));
                    }

               }
          }
     }

//check for type 4.1, 4.2, 4.3)
     public void badRadMinMaxFixZero(PrintWriter fileout, double min, double max) {
          for (int i = 2; i < NeuronSize; ++i) {
               if (LineArray[i].getLineRad() == 0) {
                    LineArray[i].setLineRadius(LineArray[LineArray[i].getLineLink()].getLineRad());
                    fileout.println("4.1  Radius of line " + LineArray[i].getOrigionalLineNum() +
                                    " = 0.  (changed to " +
                                    LineArray[LineArray[i].getLineLink()].getLineRad() + ")");

                    fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " + this.getY(i) +
                                    "  " + this.getZ(i));
               }
               else if (LineArray[i].getLineRad() <= min) {
                    fileout.println("4.2  Radius of line " + LineArray[i].getOrigionalLineNum() +
                                    " at " + LineArray[i].getLineRad() + " <= " + min +
                                    ".  (no action taken)");
                    fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " + this.getY(i) +
                                    "  " + this.getZ(i));
               }
               if (LineArray[i].getLineRad() >= max) {
                    fileout.println("4.3  Radius of line " + LineArray[i].getOrigionalLineNum() +
                                    " at " + LineArray[i].getLineRad() + " >= " + max +
                                    ".  (no action taken)");
                    fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " + this.getY(i) +
                                    "  " + this.getZ(i));
               }
          }
     }

//check for type 4.1, 4.2, 4.3)
     public void badRadTermsMinMaxFixZero(PrintWriter fileout, double terms, double min, double max) {
          double termMax = (this.meanTermRad() + (terms * this.stdevTermRad()));

          for (int i = 2; i < NeuronSize; ++i) {
               if (LineArray[i].getLineRad() == 0) {
                    LineArray[i].setLineRadius(LineArray[LineArray[i].getLineLink()].getLineRad());
                    fileout.println("4.1  Radius of line " + LineArray[i].getOrigionalLineNum() +
                                    " = 0.  (changed to " +
                                    LineArray[LineArray[i].getLineLink()].getLineRad() + ")");

                    fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " + this.getY(i) +
                                    "  " + this.getZ(i));
               }
               else if (LineArray[i].getLineRad() <= min) {
                    fileout.println("4.2  Radius of line " + LineArray[i].getOrigionalLineNum() +
                                    " at " + LineArray[i].getLineRad() + " <= " + min +
                                    ".  (no action taken)");
                    fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " + this.getY(i) +
                                    "  " + this.getZ(i));
               }
               if ( (LineArray[i].getLineRad() >= termMax) && (LineArray[i].getNumDaughters() == 0)) {
                    fileout.println("4.5  Radius of terminal line " +
                                    LineArray[i].getOrigionalLineNum() + " at " +
                                    LineArray[i].getLineRad() + " >= " + terms +
                                    " stdevs above the mean.  (no action taken)");
                    fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " + this.getY(i) +
                                    "  " + this.getZ(i));
               }

               else if (LineArray[i].getLineRad() >= max) {
                    fileout.println("4.3  Radius of line " + LineArray[i].getOrigionalLineNum() +
                                    " at " + LineArray[i].getLineRad() + " >= " + max +
                                    ".  (no action taken)");
                    fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " + this.getY(i) +
                                    "  " + this.getZ(i));
               }
          }
     }

     //check for type 4.1, 4.2, 4.3)
     public void badRadMinMaxFixZero(PrintWriter fileout, double min, double max, int type) {
          for (int i = 2; i < NeuronSize; ++i) {
               if ( (LineArray[i].getLineType() == type)) {
                    if (LineArray[i].getLineRad() == 0) {
                         LineArray[i].setLineRadius(LineArray[LineArray[i].getLineLink()].
                                getLineRad());
                         fileout.println("4.1  Radius of line " + LineArray[i].getOrigionalLineNum() +
                                         " = 0.  (changed to " +
                                         LineArray[LineArray[i].getLineLink()].getLineRad() +
                                         ")");
                         fileout.println("     A       X, Y, Z:  " + this.getX(i) + "  " +
                                         this.getY(i) + "  " + this.getZ(i));
                    }
                    else if (LineArray[i].getLineRad() <= min) {
                         fileout.println("4.2  Radius of line " + LineArray[i].getOrigionalLineNum() +
                                         " at " + LineArray[i].getLineRad() + " <= " + min +
                                         ".  (no action taken)");
                         fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " +
                                         this.getY(i) + "  " + this.getZ(i));
                    }
                    if (LineArray[i].getLineRad() >= max) {
                         fileout.println("4.3  Radius of line " + LineArray[i].getOrigionalLineNum() +
                                         " at " + LineArray[i].getLineRad() + " >= " + max +
                                         ".  (no action taken)");
                         fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " +
                                         this.getY(i) + "  " + this.getZ(i));
                    }
               }
          }
     }

     //check for type 4.1, 4.2, 4.3)
     public void badRadTermsMinMaxFixZero(PrintWriter fileout, double terms, double min, double max,
                                          int type) {
          double termMax = (this.meanTermRad(type) + (terms * this.stdevTermRad(type)));

          for (int i = 2; i < NeuronSize; ++i) {
               if ( (LineArray[i].getLineType() == type)) {
                    if (LineArray[i].getLineRad() == 0) {
                         LineArray[i].setLineRadius(LineArray[LineArray[i].getLineLink()].
                                getLineRad());
                         fileout.println("4.1  Radius of line " + LineArray[i].getOrigionalLineNum() +
                                         " = 0.  (changed to " +
                                         LineArray[LineArray[i].getLineLink()].getLineRad() +
                                         ")");
                         fileout.println("     A       X, Y, Z:  " + this.getX(i) + "  " +
                                         this.getY(i) + "  " + this.getZ(i));
                    }
                    else if (LineArray[i].getLineRad() <= min) {
                         fileout.println("4.2  Radius of line " + LineArray[i].getOrigionalLineNum() +
                                         " at " + LineArray[i].getLineRad() + " <= " + min +
                                         ".  (no action taken)");
                         fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " +
                                         this.getY(i) + "  " + this.getZ(i));
                    }
                    if ( (LineArray[i].getLineRad() >= termMax) &&
                        (LineArray[i].getNumDaughters() == 0)) {
                         fileout.println("4.5  Radius of terminal line " +
                                         LineArray[i].getOrigionalLineNum() + " at " +
                                         LineArray[i].getLineRad() + " >= " + terms +
                                         " stdevs above the mean.  (no action taken)");
                         fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " +
                                         this.getY(i) + "  " + this.getZ(i));
                    }

                    else if (LineArray[i].getLineRad() >= max) {
                         fileout.println("4.3  Radius of line " + LineArray[i].getOrigionalLineNum() +
                                         " at " + LineArray[i].getLineRad() + " >= " + max +
                                         ".  (no action taken)");
                         fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " +
                                         this.getY(i) + "  " + this.getZ(i));
                    }
               }
          }
     }

     //compute mean radius in a neuron
     public double meanRad() {
          double mean = 0.0;
          if (this.NeuronSize > 0) {
               double sum = 0.0;
               for (int i = 1; i < this.NeuronSize; i++) {
                    sum += this.LineArray[i].getLineRad();
               }
               mean = sum / (this.NeuronSize);
          }
          return mean;
     }

     //comput mean radius for given type in a neuron
     public double meanRad(int type) {
          double mean = 0.0;
          if (this.NeuronSize > 0) {
               double sum = 0.0;
               int count = 0;
               for (int i = 1; i < this.NeuronSize; i++) {
                    if (this.LineArray[i].getLineType() == type) {
                         sum += this.LineArray[i].getLineRad();
                         ++count;
                    }
               }

               mean = sum / count;
          }
          return mean;
     }

     //comput mean radius for terminal points for given type in a neuron f
     public double meanTermRad(int type) {
          double mean = 0.0;
          if (this.NeuronSize > 0) {
               double sum = 0.0;
               int count = 0;

               for (int i = 1; i < this.NeuronSize; i++) {
                    if ( (this.LineArray[i].getLineType() == type) &&
                        (this.LineArray[i].getNumDaughters() == 0)) {
                         sum += this.LineArray[i].getLineRad();
                         ++count;
                    }
               }
               mean = sum / count;
          }
          return mean;
     }

     //comput mean radius for terminal points in a neuron
     public double meanTermRad() {
          double mean = 0.0;
          if (this.NeuronSize > 0) {
               double sum = 0.0;
               int count = 0;
               for (int i = 1; i < this.NeuronSize; i++) {
                    if (this.LineArray[i].getNumDaughters() == 0) {
                         sum += this.LineArray[i].getLineRad();
                         ++count;
                    }
               }
               mean = sum / count;
          }
          return mean;
     }

     //compute standard deviaion of radii in a cell
     public double stdevRad() {
          double stdDev = 0.0;
          if (this.NeuronSize > 1) {
               double meanValue = this.meanRad();
               double sum = 0.0;
               for (int i = 1; i < this.NeuronSize; i++) {
                    double diff = LineArray[i].getLineRad() - meanValue;
                    sum += diff * diff;
               }
               stdDev = Math.sqrt(sum / (this.NeuronSize - 1));
          }
          return stdDev;
     }

     //compute standard deviaion of radii for a given type in a cell
     public double stdevRad(int type) {
          double stdDev = 0.0;
          int count = 0;
          if (this.NeuronSize > 1) {
               double meanValue = this.meanRad(type);
               double sum = 0.0;
               for (int i = 1; i < this.NeuronSize; i++) {
                    if (this.LineArray[i].getLineType() == type) {
                         double diff = LineArray[i].getLineRad() - meanValue;
                         sum += diff * diff;
                         ++count;
                    }
               }
               stdDev = Math.sqrt(sum / (count - 1));
          }
          return stdDev;
     }

     //compute standard deviaion of radii for terminal points  in a cell
     public double stdevTermRad() {
          double stdDev = 0.0;
          int count = 0;
          if (this.NeuronSize > 1) {
               double meanValue = this.meanTermRad();
               double sum = 0.0;
               for (int i = 1; i < this.NeuronSize; i++) {
                    if (this.LineArray[i].getNumDaughters() == 0) {
                         double diff = LineArray[i].getLineRad() - meanValue;
                         sum += diff * diff;
                         ++count;
                    }
               }
               stdDev = Math.sqrt(sum / (count - 1));
          }
          return stdDev;
     }

//compute standard deviaion of radii for terminal points for a given type in a cell
     public double stdevTermRad(int type) {
          double stdDev = 0.0;
          int count = 0;
          if (this.NeuronSize > 1) {
               double meanValue = this.meanTermRad(type);
               double sum = 0.0;
               for (int i = 1; i < this.NeuronSize; i++) {
                    if ( (this.LineArray[i].getLineType() == type) &&
                        (this.LineArray[i].getNumDaughters() == 0)) {
                         double diff = LineArray[i].getLineRad() - meanValue;
                         sum += diff * diff;
                         ++count;
                    }
               }
               stdDev = Math.sqrt(sum / (count - 1));
          }
          return stdDev;
     }

//*********************************************bad seg length functions*************************************
      public void badSegLengthMinStdev(PrintWriter fileout, double min, double stDevm) {
           double mean = this.meanSegLength();
           double stdev = this.stdevSegLength();
           for (int i = 2; i < NeuronSize; ++i) {
                if (this.LineArray[i].getDistance(LineArray[LineArray[i].getLineLink()]) <= min) {
                     fileout.println("2.5  Length of segment ending at point " +
                                     LineArray[i].getOrigionalLineNum() + " <= " + min + " at " +
                                     myFormatter.format(this.LineArray[i].getDistance(LineArray[
                            LineArray[i].getLineLink()])) + ".  (no action taken)");
                     fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " + this.getY(i) +
                                     "  " + this.getZ(i));
                }
                if (this.LineArray[i].getDistance(LineArray[LineArray[i].getLineLink()]) - mean >=
                    stdev * stDevm) {
                     fileout.println("2.4  Length of segment ending at point " +
                                     LineArray[i].getOrigionalLineNum() + " >= " + stDevm +
                                     " stdevs above mean at " +
                                     myFormatter.format(this.LineArray[i].getDistance(LineArray[
                            LineArray[i].getLineLink()])) + ".  (no action taken)");
                     fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " + this.getY(i) +
                                     "  " + this.getZ(i));
                }
           }
      }

     public void badSegLengthMinStdev(PrintWriter fileout, double min, double stDevm, int type) {
          double mean = this.meanSegLength(type);
          double stdev = this.stdevSegLength(type);
          for (int i = 2; i < NeuronSize; ++i) {
               if ( (LineArray[i].getLineType() == type)) {
                    if (this.LineArray[i].getDistance(LineArray[LineArray[i].getLineLink()]) <= min) {
                         fileout.println("2.5  Length of segment ending at point " +
                                         LineArray[i].getOrigionalLineNum() + " <= " + min + " at " +
                                         myFormatter.format(this.LineArray[i].getDistance(LineArray[
                                LineArray[i].getLineLink()])) + ".  (no action taken)");
                         fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " +
                                         this.getY(i) + "  " + this.getZ(i));
                    }
                    if (this.LineArray[i].getDistance(LineArray[LineArray[i].getLineLink()]) - mean >=
                        stdev * stDevm) {
                         fileout.println("2.4  Length of segment ending at point " +
                                         LineArray[i].getOrigionalLineNum() + " >= " + stDevm +
                                         " stdevs above mean at " +
                                         myFormatter.format(this.LineArray[i].getDistance(LineArray[
                                LineArray[i].getLineLink()])) + ".  (no action taken)");
                         fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " +
                                         this.getY(i) + "  " + this.getZ(i));
                    }
               }
          }
     }

     public void badSegLengthMinMax(PrintWriter fileout, double min, double max) {
          for (int i = 2; i < NeuronSize; ++i) {
               if (this.LineArray[i].getDistance(LineArray[LineArray[i].getLineLink()]) <= min) {
                    fileout.println("2.5  Length of segment ending at point " +
                                    LineArray[i].getOrigionalLineNum() + " <= " + min + " at " +
                                    myFormatter.format(this.LineArray[i].getDistance(LineArray[
                           LineArray[i].getLineLink()])) + ".  (no action taken)");
                    fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " + this.getY(i) +
                                    "  " + this.getZ(i));
               }
               if (this.LineArray[i].getDistance(LineArray[LineArray[i].getLineLink()]) >= max) {
                    fileout.println("2.4  Length of segment ending at point " +
                                    LineArray[i].getOrigionalLineNum() + " >= " + max + " at " +
                                    myFormatter.format(this.LineArray[i].getDistance(LineArray[
                           LineArray[i].getLineLink()])) + ".  (no action taken)");
                    fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " + this.getY(i) +
                                    "  " + this.getZ(i));
               }
          }
     }

     public void badSegLengthMinMax(PrintWriter fileout, double min, double max, int type) {
          for (int i = 2; i < NeuronSize; ++i) {
               if ( (LineArray[i].getLineType() == type)) {
                    if (this.LineArray[i].getDistance(LineArray[LineArray[i].getLineLink()]) <= min) {
                         fileout.println("2.5  Length of segment ending at point " +
                                         LineArray[i].getOrigionalLineNum() + " <= " + min + " at " +
                                         myFormatter.format(this.LineArray[i].getDistance(LineArray[
                                LineArray[i].getLineLink()])) + ".  (no action taken)");
                         fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " +
                                         this.getY(i) + "  " + this.getZ(i));
                    }
                    if (this.LineArray[i].getDistance(LineArray[LineArray[i].getLineLink()]) >= max) {
                         fileout.println("2.4  Length of segment ending at point " +
                                         LineArray[i].getOrigionalLineNum() + " >= " + max + " at " +
                                         myFormatter.format(this.LineArray[i].getDistance(LineArray[
                                LineArray[i].getLineLink()])) + ".  (no action taken)");
                         fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " +
                                         this.getY(i) + "  " + this.getZ(i));
                    }
               }
          }
     }

//*********************************************bad seg length functions with small lines removed*************************************

      public void badSegLengthMinFixStdev(PrintWriter fileout, double min, double stDevm) {
           double mean = this.meanSegLength();
           double stdev = this.stdevSegLength();
           boolean firstTimeThrough = true;
           boolean linesRemoved = true;
           while (linesRemoved) {
                linesRemoved = false;
                for (int i = 2; i < NeuronSize; ++i) {
                     if (this.LineArray[i].getDistance(LineArray[LineArray[i].getLineLink()]) <=
                         min) {
                          fileout.println("2.5  Seg length ending at pt. " +
                                          this.LineArray[i].getOrigionalLineNum() + " <= " + min +
                                          " at " +
                                          myFormatter.format(this.LineArray[i].getDistance(
                                                 LineArray[
                                                 LineArray[i].getLineLink()])) + ".  (removed");
                          fileout.println("     A       X, Y, Z:  " + this.getX(i) + "  " +
                                          this.getY(i) + "  " + this.getZ(i));
                          this.removeLine(i);
                          linesRemoved = true;
                     }
                     if (firstTimeThrough) {
                          if (this.LineArray[i].getDistance(LineArray[LineArray[i].getLineLink()]) -
                              mean >= stdev * stDevm) {
                               fileout.println("2.4  Seg length ending at pt. " +
                                               LineArray[i].getOrigionalLineNum() + " >= " + stDevm +
                                               " stdevs above mean at " +
                                               myFormatter.format(this.LineArray[i].getDistance(
                                      LineArray[LineArray[i].getLineLink()])) +
                                               ".  (no action taken)");
                               fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " +
                                               this.getY(i) + "  " + this.getZ(i));
                          }
                     }
                }
                firstTimeThrough = false;
           }
      }

     public void badSegLengthMinFixStdev(PrintWriter fileout, double min, double stDevm, int type) {
          double mean = this.meanSegLength(type);
          double stdev = this.stdevSegLength(type);
          boolean firstTimeThrough = true;
          boolean linesRemoved = true;
          while (linesRemoved) {
               linesRemoved = false;
               for (int i = 2; i < NeuronSize; ++i) {
                    if ( (LineArray[i].getLineType() == type)) {
                         if (this.LineArray[i].getDistance(LineArray[LineArray[i].getLineLink()]) <=
                             min) {
                              fileout.println("2.5  Seg length ending at pt. " +
                                              this.LineArray[i].getOrigionalLineNum() + " <= " +
                                              min +
                                              " at " +
                                              myFormatter.format(this.LineArray[i].
                                     getDistance(LineArray[LineArray[i].getLineLink()])) +
                                              ".  (removed)");
                              fileout.println("     A       X, Y, Z:  " + this.getX(i) + "  " +
                                              this.getY(i) + "  " + this.getZ(i));
                              this.removeLine(i);
                              linesRemoved = true;
                         }
                         if (firstTimeThrough) {
                              if (this.LineArray[i].getDistance(LineArray[LineArray[i].getLineLink()]) -
                                  mean >= stdev * stDevm) {
                                   fileout.println("2.4  Seg length ending at pt. " +
                                          LineArray[i].getOrigionalLineNum() + " >= " + stDevm +
                                          " stdevs above mean at " +
                                          myFormatter.format(this.LineArray[i].getDistance(
                                                 LineArray[LineArray[i].getLineLink()])) +
                                          ".  (no action taken)");
                                   fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " +
                                          this.getY(i) + "  " + this.getZ(i));
                              }
                         }
                    }
               }
               firstTimeThrough = false;
          }
     }

     public void badSegLengthMinFixMax(PrintWriter fileout, double min, double max) {
          double mean = this.meanSegLength();
          double stdev = this.stdevSegLength();
          boolean firstTimeThrough = true;
          boolean linesRemoved = true;
          while (linesRemoved) {
               linesRemoved = false;
               for (int i = 2; i < NeuronSize; ++i) {
                    if (this.LineArray[i].getDistance(LineArray[LineArray[i].getLineLink()]) <= min) {
                         fileout.println("2.5  Seg length ending at pt. " +
                                         this.LineArray[i].getOrigionalLineNum() + " <= " + min +
                                         " at " +
                                         myFormatter.format(this.LineArray[i].getDistance(LineArray[
                                LineArray[i].getLineLink()])) + ".  (removed)");
                         fileout.println("     A       X, Y, Z:  " + this.getX(i) + "  " +
                                         this.getY(i) + "  " + this.getZ(i));
                         this.removeLine(i);
                         linesRemoved = true;
                    }
                    if (firstTimeThrough) {
                         if (this.LineArray[i].getDistance(LineArray[LineArray[i].getLineLink()]) >=
                             max) {
                              fileout.println("2.4  Seg length ending at pt. " +
                                              LineArray[i].getOrigionalLineNum() + " >= " + max +
                                              " at " +
                                              myFormatter.format(this.LineArray[i].getDistance(
                                     LineArray[LineArray[i].getLineLink()])) +
                                              ".  (no action taken)");
                              fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " +
                                              this.getY(i) + "  " + this.getZ(i));
                         }
                    }
               }
               firstTimeThrough = false;
          }
     }

     public void badSegLengthMinFixMax(PrintWriter fileout, double min, double max, int type) {
          double mean = this.meanSegLength(type);
          double stdev = this.stdevSegLength(type);
          boolean firstTimeThrough = true;
          boolean linesRemoved = true;
          while (linesRemoved) {
               linesRemoved = false;
               for (int i = 2; i < NeuronSize; ++i) {
                    if ( (LineArray[i].getLineType() == type)) {
                         if (this.LineArray[i].getDistance(LineArray[LineArray[i].getLineLink()]) <=
                             min) {
                              fileout.println("2.5  Seg length ending at pt. " +
                                              this.LineArray[i].getOrigionalLineNum() + " <= " +
                                              min +
                                              " at " +
                                              myFormatter.format(this.LineArray[i].
                                     getDistance(LineArray[LineArray[i].getLineLink()])) +
                                              ".  (removed)");
                              fileout.println("     A       X, Y, Z:  " + this.getX(i) + "  " +
                                              this.getY(i) + "  " + this.getZ(i));
                              this.removeLine(i);
                              linesRemoved = true;
                         }
                         if (firstTimeThrough) {
                              if (this.LineArray[i].getDistance(LineArray[LineArray[i].getLineLink()]) >=
                                  max) {
                                   fileout.println("2.4  Seg length ending at pt. " +
                                          LineArray[i].getOrigionalLineNum() + " >= " + max +
                                          " at " +
                                          myFormatter.format(this.LineArray[i].getDistance(
                                                 LineArray[LineArray[i].getLineLink()])) +
                                          ".  (no action taken)");
                                   fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " +
                                          this.getY(i) + "  " + this.getZ(i));
                              }
                         }
                    }
               }
               firstTimeThrough = false;
          }
     }

//********************************************************************************************************************

      public double meanSegLength() {
           double mean = 0.0;
           if (this.NeuronSize > 0) {
                double sum = 0.0;
                for (int i = 2; i < this.NeuronSize; i++) {
                     sum += this.LineArray[i].getDistance(LineArray[LineArray[i].getLineLink()]);
                }
                mean = sum / (this.NeuronSize);
           }
           return mean;
      }

     public double meanSegLength(int type) {
          double mean = 0.0;
          if (this.NeuronSize > 0) {
               double sum = 0.0;
               int count = 0;
               for (int i = 2; i < this.NeuronSize; i++) {
                    if (this.LineArray[i].getLineType() == type) {
                         sum += this.LineArray[i].getDistance(LineArray[LineArray[i].getLineLink()]);
                         ++count;
                    }
               }
               mean = sum / count;
          }
          return mean;
     }

     public double stdevSegLength() {
          double stdDev = 0.0;
          if (this.NeuronSize > 1) {
               double meanValue = this.meanSegLength();
               double sum = 0.0;
               for (int i = 2; i < this.NeuronSize; i++) {
                    double diff = this.LineArray[i].getDistance(LineArray[LineArray[i].getLineLink()]) -
                           meanValue;
                    sum += diff * diff;
               }
               stdDev = Math.sqrt(sum / (this.NeuronSize - 1));
          }
          return stdDev;
     }

     public double stdevSegLength(int type) {
          double stdDev = 0.0;
          int count = 0;
          if (this.NeuronSize > 1) {
               double meanValue = this.meanSegLength(type);
               double sum = 0.0;
               for (int i = 2; i < this.NeuronSize; i++) {
                    if (this.LineArray[i].getLineType() == type) {
                         double diff = this.LineArray[i].getDistance(LineArray[LineArray[i].
                                getLineLink()]) - meanValue;
                         sum += diff * diff;
                         ++count;
                    }
               }
               stdDev = Math.sqrt(sum / (count - 1));
          }
          return stdDev;
     }

     public void SetPatternOut(String SPO) {
          PatternOut = SPO;
     }

//find 2.1
     public void findTrifurcations(PrintWriter fileout) {
          if (this.NeuronSize > 0) {
               for (int i = 1; i < this.NeuronSize; i++) {
                    if (this.LineArray[i].getNumDaughters() > 2) {
                         fileout.println("2.1  Line " + LineArray[i].getOrigionalLineNum() +
                                         " has " + this.LineArray[i].getNumDaughters() +
                                         " daughters.  Type is " +
                                         LineArray[i].getLineType() + ".  (no action taken)");
                         fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " +
                                         this.getY(i) + "  " + this.getZ(i));
                    }
               }
          }
     }

//find 2.3
     public void badLinks(PrintWriter fileout) {
          if (this.NeuronSize > 0) {
               for (int i = 2; i < this.NeuronSize; i++) {
                    if ( (this.getLink(i) >= i) || (this.getLink(i) < -1)) {
                         fileout.println("2.3  Line " + LineArray[i].getOrigionalLineNum() +
                                         " links to " +
                                         LineArray[this.getLink(i)].getOrigionalLineNum() +
                                         ".  Last line num is " + this.NeuronSize + "  Type is " +
                                         LineArray[i].getLineType() + ".  (no action taken)");
                         fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " +
                                         this.getY(i) + "  " + this.getZ(i));
                    }
               }
          }
     }

//find 4.4
     public void badPositiveTaper(PrintWriter fileout, double ratiolimit) {
          if (this.NeuronSize > 0) {
               for (int i = 2; i < this.NeuronSize; i++) {
                    if ( (this.getRad(i) / this.getRad(this.getLink(i))) >= ratiolimit) {
                         fileout.println("4.4  Line " + LineArray[i].getOrigionalLineNum() +
                                         " of rad " + this.getRad(i) + " links to " +
                                         LineArray[this.getLink(i)].getOrigionalLineNum() +
                                         " of rad " + this.getRad(this.getLink(i)) +
                                         ".  (no action taken)");
                         fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " +
                                         this.getY(i) + "  " + this.getZ(i));
                    }
               }
          }
     }

//find 4.4
     public void badNegativeTaper(PrintWriter fileout, double ratiolimit) {
          if (this.NeuronSize > 0) {
               for (int i = 2; i < this.NeuronSize; i++) {
                    if ( (this.getRad(this.getLink(i)) / this.getRad(i)) >= ratiolimit) {
                         fileout.println("4.4  Line " + LineArray[i].getOrigionalLineNum() +
                                         " of rad " + this.getRad(i) + " links to " +
                                         LineArray[this.getLink(i)].getOrigionalLineNum() +
                                         " of rad " + this.getRad(this.getLink(i)) +
                                         ".  (no action taken)");
                         fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " +
                                         this.getY(i) + "  " + this.getZ(i));
                    }
               }
          }
     }

//find 2.7
     public void includedSideBranch(PrintWriter fileout) {
          if (this.NeuronSize > 0) {
               for (int i = 2; i < this.NeuronSize; i++) {
                    if ( (this.getRad(i) >=
                          this.LineArray[i].getDistance(LineArray[LineArray[i].getLineLink()]) &&
                          (this.LineArray[i].getNumDaughters() == 0) &&
                          (this.LineArray[this.LineArray[i].getLineLink()].getNumDaughters() == 2))) {
                         fileout.println("2.7  Line " + LineArray[i].getOrigionalLineNum() +
                                         " of rad " + this.getRad(i) +
                                         " is an included side branch.  (no action taken)");
                         fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " +
                                         this.getY(i) + "  " + this.getZ(i));
                    }
               }
          }
     }

//find 2.7
     public void includedSideBranchFix(PrintWriter fileout) {
          if (this.NeuronSize > 0) {
               for (int i = 2; i < this.NeuronSize; i++) {
                    if ( (this.getRad(i) >=
                          this.LineArray[i].getDistance(LineArray[LineArray[i].getLineLink()]) &&
                          (this.LineArray[i].getNumDaughters() == 0) &&
                          (this.LineArray[this.LineArray[i].getLineLink()].getNumDaughters() == 2))) {
                         fileout.println("2.7  Line " + LineArray[i].getOrigionalLineNum() +
                                         " of rad " + this.getRad(i) +
                                         " is an included side branch.  (removed)");
                         fileout.println("     A      X, Y, Z:  " + this.getX(i) + "  " +
                                         this.getY(i) + "  " + this.getZ(i));
                         this.removeLine(i);
                    }
               }
          }
     }

     //find 2.7
     public void includedSideBranch(PrintWriter fileout, int typeToDo) {
          if (this.NeuronSize > 0) {
               for (int i = 2; i < this.NeuronSize; i++) {
                    if (this.getType(i) == typeToDo) {
                         if ( (this.getRad(i) >=
                               this.LineArray[i].getDistance(LineArray[LineArray[i].getLineLink()]) &&
                               (this.LineArray[i].getNumDaughters() == 0) &&
                               (this.LineArray[this.LineArray[i].getLineLink()].getNumDaughters() ==
                                2))) {
                              fileout.println("2.7  Line " + LineArray[i].getOrigionalLineNum() +
                                              " of rad " + this.getRad(i) +
                                              " is an included side branch.  (no action taken)");
                              fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " +
                                              this.getY(i) + "  " + this.getZ(i));
                         }
                    }
               }
          }
     }

//find 2.7
     public void includedSideBranchFix(PrintWriter fileout, int typeToDo) {
          if (this.NeuronSize > 0) {
               for (int i = 2; i < this.NeuronSize; i++) {
                    if (this.getType(i) == typeToDo) {
                         if ( (this.getRad(i) >=
                               this.LineArray[i].getDistance(LineArray[LineArray[i].getLineLink()]) &&
                               (this.LineArray[i].getNumDaughters() == 0) &&
                               (this.LineArray[this.LineArray[i].getLineLink()].getNumDaughters() ==
                                2))) {
                              fileout.println("2.7  Line " + LineArray[i].getOrigionalLineNum() +
                                              " of rad " + this.getRad(i) +
                                              " is an included side branch.  (removed)");
                              fileout.println("     A      X, Y, Z:  " + this.getX(i) + "  " +
                                              this.getY(i) + "  " + this.getZ(i));
                              this.removeLine(i);
                         }
                    }
               }
          }
     }

     //find 2.6
     public void overlappingPoints(PrintWriter fileout) {
          if (this.NeuronSize > 0) {
               for (int i = 1; i < this.NeuronSize; i++) {
                    for (int j = i + 1; j < this.NeuronSize; j++) {
                         if ( (this.getX(j) == this.getX(i)) && (this.getY(j) == this.getY(i)) &&
                             (this.getZ(j) == this.getZ(i))) {
                              fileout.println("2.6  Line " + LineArray[i].getOrigionalLineNum() +
                                              " and line " + LineArray[j].getOrigionalLineNum() +
                                              " have the same coordinates.  (no action taken)");
                              fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " +
                                              this.getY(i) + "  " + this.getZ(i));
                         }
                    }
               }
          }
     }

//find 3.3
     public void badSoma(PrintWriter fileout) {
          if (this.NeuronSize > 0) {
               this.setDaughterNums();
               int numsomadaughters = 0;
               for (int i = 2; i < this.NeuronSize; i++) {
                    if (this.getType(i) == 1) {
                         if (this.LineArray[i].getNumDaughters() >= 2) {
                              for (int j = i; j < this.NeuronSize; j++) {
                                   if (this.getLink(j) == i && this.getType(j) == 1) {
                                        ++numsomadaughters;
                                   }
                              }
                              if (numsomadaughters >= 2) {
                                   fileout.println("3.3  Soma at line " +
                                          LineArray[i].getOrigionalLineNum() +
                                          " has 2 or more daughters also of type 1.  (no action taken)");
                                   fileout.println("     B1      X, Y, Z:  " + this.getX(i) + "  " +
                                          this.getY(i) + "  " + this.getZ(i));
                              }
                         }
                    }
               }
          }
     }

     public void setDaughterNums() {
          if (this.NeuronSize > 0) {
               for (int i = 1; i < this.NeuronSize; i++) {
                    this.LineArray[i].setNumDaughters(0);
               }

               for (int i = 2; i < this.NeuronSize; i++) {
                    this.LineArray[this.getLink(i)].setNumDaughters(this.LineArray[this.getLink(i)].
                           getNumDaughters() + 1);
               }
          }
     }

     public void moveEndLineToBeginning() {
          if (this.NeuronSize > 0) {
               SwcLine tempLine = new SwcLine();
               tempLine = this.LineArray[1];
               this.LineArray[1] = this.LineArray[this.NeuronSize];
               this.LineArray[1].setLineNum(1);
               this.LineArray[1].setLineLink( -1);
               for (int i = 2; i < this.NeuronSize - 1; i++) {
                    this.LineArray[i] = tempLine;
                    this.LineArray[i].setLineNum(i);
                    this.LineArray[i].setLineLink(this.getLink(i) + 1);
                    tempLine = this.LineArray[i + 1];
               }
               this.LineArray[this.NeuronSize] = tempLine;
               this.LineArray[this.NeuronSize].setLineNum(this.NeuronSize);
               this.LineArray[this.NeuronSize].setLineLink(this.getLink(this.NeuronSize) + 1);
          }
     }

     public void removeLine(int lineToDel) {
          if (this.NeuronSize > 0) {
               for (int i = 2; i < this.NeuronSize; i++) {
                    if (i >= lineToDel) {
                         int tempLink = this.LineArray[i].getLineLink();
                         this.LineArray[i] = this.LineArray[i + 1];
                         this.LineArray[i].setLineNum(i);
                         if (this.LineArray[i].getLineLink() >= lineToDel) {
                              this.LineArray[i].setLineLink(this.LineArray[i].getLineLink() - 1);
                         }
                         if (i == lineToDel) {
                              if (tempLink < lineToDel - 1) {
                                   this.LineArray[i].setLineLink(tempLink);
                              }
                         }
                    }

               }
               this.LineArray[this.NeuronSize] = null;
               this.NeuronSize = this.NeuronSize - 1;
          }
     }

     public void removeLines(int firstToDel, int lastToDel) {
          if (this.NeuronSize > 0) {
               for (int i = lastToDel; i >= firstToDel; i--) {
                    this.removeLine(i);
               }
          }
     }

     public int countType(int typeToCount) {
          int count = 0;
          if (this.NeuronSize > 0) {
               for (int i = 2; i < this.NeuronSize; i++) {
                    if (this.LineArray[i].getLineType() == typeToCount) {
                         ++count;
                    }
               }
          }
          return count;
     }

     public int getFirstDaughterNumType(int lineArraySub) {
          if (this.NeuronSize > 0) {
               for (int i = 1; i < this.NeuronSize; i++) {
                    if (this.LineArray[i].getLineLink() == lineArraySub) {
                         return this.LineArray[i].getLineType();
                    }
               }
          }
          return -1;
     }

     //output swc file into given print stream, header information added
     public void writeSWC(PrintWriter swcOut, double version) {
          if (this.NeuronSize > 0) {
               swcOut.println("# Origional file " + this.FileName + " edited using SWCfix version " +
                              version + ".  See SWCfix" + version + ".doc for more information.");
               swcOut.println("#");
               for (int i = 1; i <= this.CommentSize; i++) {
                    swcOut.println(CommentLineArray[i]);
               }
               for (int i = 1; i <= this.NeuronSize; i++) {
                    swcOut.println(i + " " + this.getType(i) + " " + this.getX(i) + " " +
                                   this.getY(i) + " " + this.getZ(i) + " " + this.getRad(i) + " " +
                                   this.getLink(i));
                    for (int j = 0; j < 5000; ++j) {
                    }
               }
          }
     }

     //output swc file into given print stream, extensive header information added
     public void writeSWC(PrintWriter swcOut, double version, String todaysDate, String userName,
                          String errorFile) {
          if (this.NeuronSize > 0) {
               swcOut.println("# Original file " + this.FileName + " edited by " + userName +
                              " using SWCfix version " + version + " on " + todaysDate + ".");
               swcOut.println("# Errors and fixes documented in " + errorFile + ".  See SWCfix" +
                              version + ".doc for more information.");
               swcOut.println("#");
               for (int i = 1; i <= this.CommentSize; i++) {
                    swcOut.println(CommentLineArray[i]);
               }
               for (int i = 1; i <= this.NeuronSize; i++) {
                    swcOut.println(i + " " + this.getType(i) + " " + this.getX(i) + " " +
                                   this.getY(i) + " " + this.getZ(i) + " " + this.getRad(i) + " " +
                                   this.getLink(i));
                    for (int j = 0; j < 5000; ++j) {
                    }
               }
          }
     }

     public void setLengths() {
          if (this.NeuronSize > 0) {
               for (int i = 2; i <= this.NeuronSize; i++) {
                    //set seg length as the distance between current point and parrent poing
                    // this.LineArray[i].setSegLength(this.LineArray[i].getDistance(this.LineArray[this.getLink(i)]));
                    //already donein (InitSwcNeuron)

                    //set tree lenght to seg length if parretn is soma, else add it to prev
                    if (this.getType(this.getLink(i)) == 1) {
                         this.LineArray[i].setTreeLength(this.LineArray[i].getSegLength());
                    }
                    else {
                         this.LineArray[i].setTreeLength(this.LineArray[i].getSegLength() +
                                this.LineArray[this.getLink(i)].getTreeLength());
                    }
                    //set branch length to seg if parrent is bif or soma, else add it to prev
                    if ( (this.LineArray[this.getLink(i)].getNumDaughters() == 2) ||
                        (this.getType(this.getLink(i)) == 1)) {
                         this.LineArray[i].setBranchLength(this.LineArray[i].getSegLength());
                         //  this.LineArray[i].setBranchLength(5);
                    }
                    else {
                         this.LineArray[i].setBranchLength(this.LineArray[i].getSegLength() +
                                this.LineArray[this.getLink(i)].getBranchLength());
                    }
                    //reset all soma point tree and branch lengths
                    if (this.getType(i) == 1) {
                         this.LineArray[i].setTreeLength(0);
                         this.LineArray[i].setBranchLength(0);
                    }
               }
          }
     }

     //output swc file into given print stream, no header information added
     public void writeSWC(PrintWriter swcOut) {
          if (this.NeuronSize > 0) {
               for (int i = 1; i <= this.CommentSize; i++) {
                    swcOut.println(CommentLineArray[i]);
               }
               for (int i = 1; i <= this.NeuronSize; i++) {
                    swcOut.println(i + " " + this.getType(i) + " " + this.getX(i) + " " +
                                   this.getY(i) + " " + this.getZ(i) + " " + this.getRad(i) + " " +
                                   this.getLink(i));
                    for (int j = 0; j < 5000; ++j) {
                    }
               }
          }
     }

     //temp to output branch order info
     public void writeBO(PrintWriter boOut) {
          System.out.println("printing branch order");
          if (this.NeuronSize > 0) {

               for (int i = 1; i <= this.NeuronSize; i++) {
                    boOut.println(" bo  " + this.getBranchOrder(i));
                    System.out.println(i);
               }
          }
     }

     public void setEuclidianDistancesToSoma() {
          if (this.NeuronSize > 0) {
               //for each line in the cell
               for (int i = 2; i <= this.NeuronSize; i++) {
                    if (this.LineArray[i].getLineType() != 1) {
//System.out.println(i + "  " +this.LineArray[i].getStemNumber());
                         this.LineArray[i].setEuclidianDistance(this.LineArray[i].getDistance(this.
                                LineArray[this.LineArray[i].getStemNumber()]));
                    }
               }
          }
     }

     public void setStemsStartRadAndBO() {
          boolean BranchStartNotSet = true;
          if (this.NeuronSize > 1) {
               //for each line in the cell
               // this.LineArray[2].setStemNumber(1);
               for (int i = 2; i <= this.NeuronSize; i++) {
                    BranchStartNotSet = true;
                    this.LineArray[i].setBranchOrder(0);
                    if (this.LineArray[this.LineArray[i].getLineLink()].getLineType() == 1) {
                         this.LineArray[i].setStemNumber(this.LineArray[i].getLineLink());
                         this.LineArray[i].setBranchOrder(0);
                         BranchStartNotSet = false;
                         this.LineArray[i].setBranchStartRad(this.getRad(i));

                    }
                    else {

                         //go recursively back through cell to soma
                         for (int k = this.LineArray[i].getLineLink();
                              this.LineArray[k].getLineType() != 1;
                              k = this.LineArray[k].getLineLink()) {
                              //update stem number
                              this.LineArray[i].setStemNumber(this.LineArray[k].getLineLink());
                              //update bo if bifurcation encountered
                              if ( (this.getNumDaughters(k) == 2) && (this.getType(k) != 1)) {
                                   this.LineArray[i].setBranchOrder(this.LineArray[i].
                                          getBranchOrder() + 1);
                                   if (BranchStartNotSet) { //if imediate parrent is bifurcation
                                        BranchStartNotSet = false;
                                        //set start rad to current radius
                                        this.LineArray[i].setBranchStartRad(this.getRad(i));
                                   }
                              }

                              //if parent is bifurcation set rad to current radius
                              if ( (this.getNumDaughters(this.getLink(k)) == 2) &&
                                  BranchStartNotSet) {
                                   BranchStartNotSet = false;
                                   this.LineArray[i].setBranchStartRad(this.getRad(k));
                              }

                              //if parrent is soma, set start rad to current point


                              if ( (this.getType(this.getLink(k)) == 1) && BranchStartNotSet) {
                                   BranchStartNotSet = false;
                                   this.LineArray[i].setBranchStartRad(this.getRad(k));
                              }
                         }
                    }
               }
          }
     }

     public int getTreeSize(int k) {
          int temp = 0;
          while (this.getNumDaughters(k) == 1) {
               k = this.getDaughter1num(k);
          }
          if (this.getNumDaughters(k) == 0) {
               return 0;
          }
          if (this.getNumDaughters(k) == 2) {
               temp = 1 + this.getTreeSize(this.getDaughter1num(k)) +
                      this.getTreeSize(this.getDaughter2num(k));
               //    System.out.println(k);
               return temp;
          }
          return 0;
     }

     public void setAllLineTreeNumber() {
          int lineNum = 0;
          if (this.NeuronSize > 1) {
               for (int i = 2; i <= this.NeuronSize; i++) {
                    if (this.getType(this.getLink(i)) == 1) { //if parrent is soma
                         ++lineNum;
                         this.setLineTreeNumbers(i, lineNum);
                    }
               }
          }
     }

     public void setLineTreeNumbers(int k, int lineNum) { //set all points in a tree to lineNum
          this.LineArray[k].setLineTreeNum(lineNum);
          if (this.getNumDaughters(k) == 1) {
               this.setLineTreeNumbers(this.getDaughter1num(k), lineNum);
          }
          if (this.getNumDaughters(k) == 2) {
               this.setLineTreeNumbers(this.getDaughter1num(k), lineNum);
               this.setLineTreeNumbers(this.getDaughter2num(k), lineNum);
          }
     }

     public int getTreeSize(int k, int type) {
          int temp = 0;
          while (this.getNumDaughters(k) == 1) {
               k = this.getDaughter1num(k);
               if (this.getType(k) != type) {
                    return 0;
               }
          }
          if (this.getNumDaughters(k) == 0) {
               return 0;
          }
          if (this.getNumDaughters(k) == 2) {
               if ( (this.getType(this.getDaughter1num(k)) != type) &&
                   (this.getType(this.getDaughter1num(k)) != type)) {
                    temp = 0;
               }

               else if (this.getType(this.getDaughter1num(k)) != type) {
                    temp = this.getTreeSize(this.getDaughter2num(k), type);
               }

               else if (this.getType(this.getDaughter2num(k)) != type) {
                    temp = this.getTreeSize(this.getDaughter1num(k), type);
               }
               else {
                    temp = 1 + this.getTreeSize(this.getDaughter1num(k), type) +
                           this.getTreeSize(this.getDaughter2num(k), type);
               }
               //    System.out.println("biff " + k);
               return temp;
          }
          return 0;
     }
}
