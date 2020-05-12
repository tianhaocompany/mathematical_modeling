#pragma once
#include"individual.h"
#include"parameter.h"
#include<math.h>
#include<list>
#include<iostream>
using namespace std;
extern int a1[400][12];
extern int a2[400][12];
extern int exceptRight[12];//除去右转的控制向量
extern int c[4][12];
extern int s1[12];//饱和流量
extern int s2[12];
extern int td1;//起动时延时
extern int td2;//由于黄灯停止的延误
extern int ty;//黄灯时间
extern double K;
extern double lumda;
extern double d;
double Individual::getEval(){
	double a=getE1Eval();
	double b=getE2Eval();
	double c=getEmEval();
	if(a+b+c<0){
		std::cout<<"error"<<std::endl;
	}
	return 1/(a+b+c);
	//cout<<a<<","<<b<<","<<c<<endl;
}
double Individual::getValue(){
	return 1/(this->getEval());
}
//计算E1的能量
double Individual::getE1Eval(){
	int N1=0;//第一相位的车辆总数
	int N2=0;//第二相位的车辆总数
	int N3=0;//第三相位的车辆总数
	int N4=0;//第三相位的车辆总数
	//第一相位
	int Ein1=0;
	int temp=0;
	for(int i=0;i<this->x1+ty;i++){
		temp=0;
		for(int j=0;j<12;j++){
			temp+=a1[i][j]*exceptRight[j];
		}
		Ein1+=temp*(this->x1-i);
	}
	int Eout1=0;
	temp=0;
	for(int j=0;j<12;j++){
		temp+=s1[j]*c[0][j]*exceptRight[j];
	}
	int tempOut=temp;
	for(int i=td1;i<this->x1+ty-td2;i++){
		Eout1+=temp*(this->x1+ty-td2-i);
	}
	for(int i=0;i<this->x1+ty;i++){
		for(int j=0;j<12;j++){
			N1+=a1[i][j]*exceptRight[j];
		}
	}
	N1-=tempOut;
	//第二相位
	int Ein2=N1*(this->x2+ty-this->x1);
	temp=0;
	for(int i=this->x1+ty;i<this->x2+ty;i++){
		temp=0;
		for(int j=0;j<12;j++){
			temp+=a1[i][j]*exceptRight[j];
		}
		Ein2+=temp*(this->x2-i);
	}
	int Eout2=0;
	temp=0;
	for(int i=0;i<12;i++){
		temp+=s1[i]*c[1][i]*exceptRight[i];
	}
	tempOut=temp;
	for(int i=this->x1+td1;i<this->x2+ty-td2;i++){
		Eout2+=temp*(this->x2+ty-td2-i);
	}
	N2=N1;
	for(int i=this->x1+ty;i<this->x2+ty;i++){
		for(int j=0;j<12;j++){
			N2+=a1[i][j]*exceptRight[j];
		}
	}
	N2-=tempOut*(this->x2+ty-td2-this->x1-td1);
	//第三相位的势能
	int Ein3=N2*(this->x3+ty-this->x2);
	temp=0;
	for(int i=this->x2+ty;i<this->x3+ty;i++){
		temp=0;
		for(int j=0;j<12;j++){
			temp+=a1[i][j]*exceptRight[j];
		}
		Ein3+=temp*(this->x3-i);
	}
	int Eout3=0;
	temp=0;
	for(int i=0;i<12;i++){
		temp+=s1[i]*c[2][i]*exceptRight[i];
	}
	tempOut=temp;
	for(int i=this->x2+td1;i<this->x3+ty-td2-1;i++){
		Eout2+=temp*(this->x3+ty-td2-i);
	}
	N3=N2;
	for(int i=this->x2+ty;i<this->x3+ty;i++){
		for(int j=0;j<12;j++){
			N3+=a1[i][j]*exceptRight[j];
		}
	}
	N3-=tempOut*(this->x3+ty-td2-this->x2-td1);	
	//第四相位
	int Ein4=N3*(this->x4+ty-this->x3);
	temp=0;
	for(int i=this->x3+ty;i<this->x4+ty;i++){
		temp=0;
		for(int j=0;j<12;j++){
			temp+=a1[i][j]*exceptRight[j];
		}
		Ein4+=temp*(this->x4-i);
	}
	int Eout4=0;
	temp=0;
	for(int i=0;i<12;i++){
		temp+=s1[i]*c[3][i]*exceptRight[i];
	}
	tempOut=temp;
	for(int i=this->x3+td1;i<this->x4+ty-td2;i++){
		Eout4+=temp*(this->x4+ty-td2-i);
	}
	N4=N3;
	for(int i=this->x3+ty;i<this->x4+ty;i++){
		for(int j=0;j<12;j++){
			N4+=a1[i][j]*exceptRight[j];
		}
	}
	N4-=tempOut*(this->x3+ty-td2-this->x2-td1);	
	//计算能量
	int E1=Ein1-Eout1;
	int E2=E1+Ein2-Eout2;
	int E3=E2+Ein3-Eout3;
	int E4=E3+Ein4-Eout4;
	double result=(double)E4/double(this->x4+ty);
	return result;
}
//计算E2的能量
double Individual::getE2Eval(){
	int N1=0;//第一相位的车辆总数
	int N2=0;//第二相位的车辆总数
	int N3=0;//第三相位的车辆总数
	int N4=0;//第三相位的车辆总数
	//第一相位
	int Ein1=0;
	int temp=0;
	for(int i=0;i<this->x5+ty;i++){
		temp=0;
		for(int j=0;j<12;j++){
			temp+=a2[i][j]*exceptRight[j];
		}
		Ein1+=temp*(this->x5-i);
	}
	int Eout1=0;
	temp=0;
	for(int j=0;j<12;j++){
		temp+=s2[j]*c[0][j]*exceptRight[j];
	}
	int tempOut=temp;
	for(int i=td1;i<this->x5+ty-td2;i++){
		Eout1+=temp*(this->x5+ty-td2-i);
	}
	for(int i=0;i<this->x5+ty;i++){
		for(int j=0;j<12;j++){
			N1+=a2[i][j]*exceptRight[j];
		}
	}
	N1-=tempOut;
	//第二相位
	int Ein2=N1*(this->x6+ty-this->x5);
	temp=0;
	for(int i=this->x5+ty;i<this->x6+ty;i++){
		temp=0;
		for(int j=0;j<12;j++){
			temp+=a2[i][j]*exceptRight[j];
		}
		Ein2+=temp*(this->x6-i);
	}
	int Eout2=0;
	temp=0;
	for(int i=0;i<12;i++){
		temp+=s2[i]*c[1][i]*exceptRight[i];
	}
	tempOut=temp;
	for(int i=this->x5+td1;i<this->x6+ty-td2;i++){
		Eout2+=temp*(this->x6+ty-td2-i);
	}
	N2=N1;
	for(int i=this->x5+ty;i<this->x6+ty;i++){
		for(int j=0;j<12;j++){
			N2+=a2[i][j]*exceptRight[j];
		}
	}
	N2-=tempOut*(this->x6+ty-td2-this->x5-td1);
	//第三相位的势能
	int Ein3=N2*(this->x7+ty-this->x6);
	temp=0;
	for(int i=this->x6+ty;i<this->x7+ty;i++){
		temp=0;
		for(int j=0;j<12;j++){
			temp+=a2[i][j]*exceptRight[j];
		}
		Ein3+=temp*(this->x7-i);
	}
	int Eout3=0;
	temp=0;
	for(int i=0;i<12;i++){
		temp+=s2[i]*c[2][i]*exceptRight[i];
	}
	tempOut=temp;
	for(int i=this->x6+td1;i<this->x7+ty-td2-1;i++){
		Eout2+=temp*(this->x7+ty-td2-i);
	}
	N3=N2;
	for(int i=this->x6+ty;i<this->x7+ty;i++){
		for(int j=0;j<12;j++){
			N3+=a2[i][j]*exceptRight[j];
		}
	}
	N3-=tempOut*(this->x7+ty-td2-this->x6-td1);	
	//第四相位
	int Ein4=N3*(this->x8+ty-this->x7);
	temp=0;
	for(int i=this->x7+ty;i<this->x8+ty;i++){
		temp=0;
		for(int j=0;j<12;j++){
			temp+=a2[i][j]*exceptRight[j];
		}
		Ein4+=temp*(this->x8-i);
	}
	int Eout4=0;
	temp=0;
	for(int i=0;i<12;i++){
		temp+=s2[i]*c[3][i]*exceptRight[i];
	}
	tempOut=temp;
	for(int i=this->x7+td1;i<this->x8+ty-td2;i++){
		Eout4+=temp*(this->x8+ty-td2-i);
	}
	N4=N3;
	for(int i=this->x7+ty;i<this->x8+ty;i++){
		for(int j=0;j<12;j++){
			N4+=a2[i][j]*exceptRight[j];
		}
	}
	N4-=tempOut*(this->x7+ty-td2-this->x6-td1);	
	//计算能量
	int E1=Ein1-Eout1;
	int E2=E1+Ein2-Eout2;
	int E3=E2+Ein3-Eout3;
	int E4=E3+Ein4-Eout4;
	double result=(double)E4/double(this->x8+ty);
	return result;
}
double Individual::getEmEval(){
	double ap=K*exp(-lumda*d);
	int temp1=0;
	for(int i=0;i<this->x4+ty+1;i++){
        temp1+=a1[i][11];
	}
	int temp2=0;
	for(int i=0;i<this->x8+ty+1;i++){
        temp2+=a1[i][5];
	}
	int m1=(this->x2-this->x1-td1-td2)*s1[1]+(this->x3-this->x2-td1-td2)*s1[3]+temp1;
	int m2=(this->x6-this->x5-td1-td2)*s2[7]+(this->x7-this->x6-td1-td2)*s2[9]+temp2;
	int m3=0;
	for(int i=this->x1+ty+td1;i<this->x3+ty+1;i++){
        m3+=a1[i][6]+a1[i][7];
	}
	for(int i=this->x5+ty+td1;i<this->x7+ty+1;i++){
	    m3+=a2[i][0]+a2[i][1];
	}
	return ap*(m1+m2-m3);
}
