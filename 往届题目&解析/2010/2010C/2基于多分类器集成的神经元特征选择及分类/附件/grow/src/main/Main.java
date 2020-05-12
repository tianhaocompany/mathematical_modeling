package main;
import java.io.*;
import java.text.*;
import java.util.*;
import swcparts.*;
import java.math.*;
public class Main {
	public static int TIMES=1; //recursive times...
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		
		DistillSwc.INPUT_FILE="Purkinje cell 1.swc";
		DistillSwc.OUTPUT_DIR="test";
        SwcNeuron neuron=DistillSwc.distillSwc();
        
        //step 1: find the tips...
        int[] tips=new int[neuron.NeuronSize];
        for(int i=0;i<tips.length;i++)
        	tips[i]=1;
        
        for(int i=0;i<neuron.NeuronSize;i++){
        	int cur=neuron.LineArray[i+1].getLineNumber();
        	for(int j=i+1;j<neuron.NeuronSize;j++){
        		if(neuron.LineArray[i+1].getLineNumber()==neuron.LineArray[j].getLineLink()){
        			tips[i]=0;
        			break;
        		}
        	}
        	
        }
        
        //for(int i=0;i<neuron.NeuronSize;i++){
        	//if(tips[i]==1)
        	//	System.out.println(i);
        //}
        
        
        //steo 2: calculate each tip's distributions
        
        double proOv, proNov, proTrm, proAmp, proTor,R1,R2;
        
        
        for(int i=0;i<tips.length;i++){
        	if(tips[i]!=0){
        		//this is a tip point in current tree...
        		double x=neuron.LineArray[i+1].getLineX();
        		double y=neuron.LineArray[i+1].getLineY();
        		double z=neuron.LineArray[i+1].getLineZ();
        		double radius=neuron.LineArray[i+1].getLineRad()*2;
        		int FatPos=neuron.LineArray[i+1].getLineLink();
        		
        		double px=neuron.LineArray[FatPos].getLineX();
        		double py=neuron.LineArray[FatPos].getLineY();
        		double pz=neuron.LineArray[FatPos].getLineZ();
        		
        		double diletaL;
        		
        		if(neuron.LineArray[i+1].getLineType()==2){
        			//轴突...
        			proOv=0.0;
        			proNov=0.0;
        			proTrm=0.0; 
        			proAmp=0.0; 
        			proTor=0.0;
        			R1=1.0;
        			R2=1.0;
        			
        			
        		}
        		if((neuron.LineArray[i+1].getLineType()==3)||(neuron.LineArray[i+1].getLineType()==4)){
        			
        			//double rad=neuron.LineArray[i].getLineRad();
        			
        			//System.out.println(i+1);
        			
        		    //树突...
        			proOv=0.0; // no branch ,just grow...
        			proNov=0.0; //grow with branch...
        			proTrm=0.0; // stop grow...
        			proAmp=0.0; //branch alpha
        			proTor=0.0; //
        			R1=1.0; //radiuses radio...
        			R2=1.0;
        			
        			diletaL=2.91;
        			
        			proOv=0.0355*Math.exp(0.7237*radius);
        			proNov=0.2349*Math.exp(-0.0116*radius);
        			proTrm=0.4539*Math.exp(-1.1533*radius);
        			
        			System.out.println(radius+" -> radius");
        			
        			System.out.println(proNov+" -> proNov");
        			System.out.println(proOv+" -> proOv");
        			System.out.println(proTrm+" -> proTrm");
        			
        			
        			Random random_1=new Random();
        			double decim=random_1.nextDouble();
        			
        			Random random_2=new Random();
        			proAmp=random_2.nextGaussian()*30+71;
        			
        			while((proAmp>179)||(proAmp<0))
        				proAmp=random_2.nextGaussian()*30+71;
        			
        			Random random_3=new Random();
        			proTor=random_3.nextGaussian()*13.5;
        			
        			double pR1=0.246; 
        			double proR1=0.136;
        			double pR2=0.754;
        			double proR2=random_1.nextGaussian()*0.035+0.112;
        			
        			Random random_r1=new Random();
        			if(random_r1.nextDouble()>pR1){
        				R1=proR2;
        			}else{
        				R1=proR1;
        			}
        			
        			Random random_r2=new Random();
        			if(random_r2.nextDouble()<pR2){
        				R2=proR2;
        			}else{
        				R2=proR1;
        			}
        			
        			double AK=5.47078;
        			double DSTEM=5.5;
        			
        			//double prob_1=0.0; //probability grow with bifurcation....
        			//double prob_2=0.0; //probability grow with elongation....
        			//double prob_3=0.0; //probability stop growing...
        			
        			//....
        			Random random_brr1=new Random();
        			Random random_brr2=new Random();
        			//first find if it branch...
        			Random random_br=new Random();
        			if(random_br.nextDouble()<proNov){
        				
        				System.out.println(neuron.LineArray[i+1].getLineNumber()+" -> branch line num");
        				
        				//branch...
        				//if branch, calculate the branches position
        				
        				proAmp=proAmp*Math.PI/180;
        				double dx1=-(diletaL*Math.cos(proTor*Math.PI/180))*Math.sin(proAmp/2);
        				double dy1=(diletaL*Math.cos(proTor*Math.PI/180))*Math.cos(proAmp/2);
        				double dx2=(diletaL*Math.cos(proTor*Math.PI/180))*Math.sin(proAmp/2);
        				double dy2=(diletaL*Math.cos(proTor*Math.PI/180))*Math.cos(proAmp/2);
        				
        				double disX=Math.abs(x-px);
        				double disY=Math.abs(y-py);
        				double dis=Math.sqrt(disX*disX+disY*disY);
        				
        				double dx1_r=(dx1*disY/dis)-(dy1*disX/dis)+x;
        				double dy1_r=(dx1*disX/dis)+(dy1*disY/dis)+y;
        				double dx2_r=(dx2*disY/dis)-(dy2*disX/dis)+x;
        				double dy2_r=(dx2*disX/dis)+(dy2*disY/dis)+y;
        				
        				//find the radius of the branches....
        				double radius_1=0.0;
        				double radius_2=0.0;
        				double l=random_brr1.nextDouble();
        				double m=random_brr2.nextDouble();
        				
        				radius_1=(R1*l+R2*m*AK)/2;
        				radius_2=(R1*l+R2*m*AK)/2;
        				
        				double dz1=diletaL*Math.sin(proTor*Math.PI/180)+z;
        				double dz2=diletaL*Math.sin(proTor*Math.PI/180)+z;
        				
        				SwcLine newLine1=new SwcLine();
        				SwcLine newLine2=new SwcLine();
        				
        				int num1=neuron.NeuronSize+1;
        				int num2=neuron.NeuronSize+2;
        				int cur=i+1;
        				
        				//System.out.println("FUCK!--"+num1+" | "+neuron.LineArray[i+1].getLineType()+" | "+dx1_r+" | "+dy1_r+" | "+dz1+" | "+radius_1+" | "+cur);
        				//System.out.println("FUCK!--"+num2+" | "+neuron.LineArray[i+1].getLineType()+" | "+dx2_r+" | "+dy2_r+" | "+dz2+" | "+radius_2+" | "+cur);
        				
        				newLine1.setLine(num1, neuron.LineArray[i+1].getLineType(), dx1_r, dy1_r, dz1, radius_1, cur);
        				newLine2.setLine(num2, neuron.LineArray[i+1].getLineType(), dx2_r, dy2_r, dz2, radius_2, cur);
        				
        				neuron.NeuronSize=neuron.NeuronSize+2;
        				
        				neuron.LineArray[num1]=newLine1;
        				
        				neuron.LineArray[num2]=newLine2;
        				
        				
        				System.out.println(neuron.LineArray[num1].getLineNumber()+" |"+neuron.LineArray[num1].getLineType()+" |"+neuron.LineArray[num1].getLineX()+" |"+neuron.LineArray[num1].getLineY()+" |"+neuron.LineArray[num1].getLineZ()+" |"+neuron.LineArray[num1].getLineRad()+" |"+neuron.LineArray[num1].getLineLink());
        				System.out.println(neuron.LineArray[num2].getLineNumber()+" |"+neuron.LineArray[num2].getLineType()+" |"+neuron.LineArray[num2].getLineX()+" |"+neuron.LineArray[num2].getLineY()+" |"+neuron.LineArray[num2].getLineZ()+" |"+neuron.LineArray[num2].getLineRad()+" |"+neuron.LineArray[num2].getLineLink());
        				/*
        				PrintWriter writer;
        				try{
        					writer=new PrintWriter(new FileWriter(DistillSwc.OUTPUT_DIR+"\\test.txt"));
        					neuron.writeSWC(writer);
        					writer.close();
        				}catch(Exception e){
        					System.out.println(e.getLocalizedMessage());
        				}
        				*/
        				
        			}else{
        				//no branch//
        				
            			Random random_eg=new Random();
            			if(random_eg.nextDouble()<proOv){
            			  
            				z=diletaL*Math.sin(proTor*Math.PI/180)+z;
            				double disX=Math.abs(x-px);
            				double disY=Math.abs(y-py);
            				double dis=Math.sqrt(disX*disX+disY*disY);
            				
            				x=x+(diletaL*Math.cos(proTor*Math.PI/180)*disX/dis);
            				y=y+(diletaL*Math.cos(proTor*Math.PI/180)*disY/dis);
            				
            				neuron.LineArray[i+1].setLine(i+1, neuron.LineArray[i+1].getLineType(), x, y, z, radius/2, neuron.LineArray[i+1].getLineLink());
            				
            				/*
            				PrintWriter writer;
            				try{
            					writer=new PrintWriter(new FileWriter(DistillSwc.OUTPUT_DIR+"\\test.txt"));
            					neuron.writeSWC(writer);
            					writer.close();
            				}catch(Exception e){
            					System.out.println(e.getLocalizedMessage());
            				}
            				*/
            			}
        				
        			} 
        			
        		}
        	    
        		//
        	}
        }
        
		//System.out.println(neuron.LineArray[neuron.NeuronSize].getLineNumber()+" |"+neuron.LineArray[neuron.NeuronSize].getLineType()+" |"+neuron.LineArray[neuron.NeuronSize].getLineX()+" |"+neuron.LineArray[neuron.NeuronSize].getLineY()+" |"+neuron.LineArray[neuron.NeuronSize].getLineZ()+" |"+neuron.LineArray[neuron.NeuronSize].getLineRad()+" |"+neuron.LineArray[neuron.NeuronSize].getLineLink());
        int nn=neuron.NeuronSize;
		//System.out.println(neuron.LineArray[2067].getLineNumber()+" |"+neuron.LineArray[2067].getLineType()+" |"+neuron.LineArray[2067].getLineX()+" |"+neuron.LineArray[2067].getLineY()+" |"+neuron.LineArray[2067].getLineZ()+" |"+neuron.LineArray[2067].getLineRad()+" |"+neuron.LineArray[2067].getLineLink());
        for(int i=1;i<=nn;i++){
        	System.out.println(neuron.LineArray[i].getLineNumber()+" |"+neuron.LineArray[i].getLineType()+" |"+neuron.LineArray[i].getLineX()+" |"+neuron.LineArray[i].getLineY()+" |"+neuron.LineArray[i].getLineZ()+" |"+neuron.LineArray[i].getLineRad()+" |"+neuron.LineArray[i].getLineLink());
        }
        
        PrintWriter writer;
		try{
			writer=new PrintWriter(new FileWriter(DistillSwc.OUTPUT_DIR+"\\test.swc"));
			neuron.writeSWC(writer);
			writer.close();
		}catch(Exception e){
			System.out.println(e.getLocalizedMessage());
		}
        
	}

}
