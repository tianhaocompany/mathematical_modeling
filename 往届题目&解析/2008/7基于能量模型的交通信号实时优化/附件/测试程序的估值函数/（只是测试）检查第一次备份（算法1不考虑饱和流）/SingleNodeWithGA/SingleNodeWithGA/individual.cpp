#pragma once
#include"individual.h"
#include"parameter.h"
#include<math.h>
#include<list>
using namespace std;
extern int a[400][8];
extern int c[4][8];
extern int s[8];//饱和流量
extern int td1;//起动时延时
extern int td2;//由于黄灯停止的延误
extern int ty;//黄灯时间

double Individual::getEval(){
	int N1=0;//第一相位的车辆总数
	int N2=0;//第二相位的车辆总数
	int N3=0;//第三相位的车辆总数
	int N4=0;//第三相位的车辆总数
	//第一相位
	int Ein1=0;
	int temp=0;
	for(int i=0;i<this->x1+ty;i++){
		temp=0;
		for(int j=0;j<8;j++){
			temp+=a[i][j];
		}
		Ein1+=temp*(this->x1-i);
	}
	int Eout1=0;
	temp=0;
	for(int j=0;j<8;j++){
		temp+=s[j]*c[0][j];
	}
	int tempOut=temp;
	for(int i=td1;i<this->x1+ty-td2;i++){
		Eout1+=temp*(this->x1+ty-td2-i);
	}
	for(int i=0;i<this->x1+ty;i++){
		for(int j=0;j<8;j++){
			N1+=a[i][j];
		}
	}
	N1-=tempOut;
	//第二相位
	int Ein2=N1*(this->x2+ty-this->x1);
	temp=0;
	for(int i=this->x1+ty;i<this->x2+ty;i++){
		temp=0;
		for(int j=0;j<8;j++){
			temp+=a[i][j];
		}
		Ein2+=temp*(this->x2-i);
	}
	int Eout2=0;
	temp=0;
	for(int i=0;i<8;i++){
		temp+=s[i]*c[1][i];
	}
	tempOut=temp;
	for(int i=this->x1+td1;i<this->x2+ty-td2;i++){
		Eout2+=temp*(this->x2+ty-td2-i);
	}
	N2=N1;
	for(int i=this->x1+ty;i<this->x2+ty;i++){
		for(int j=0;j<8;j++){
			N2+=a[i][j];
		}
	}
	N2-=tempOut*(this->x2+ty-td2-this->x1-td1);


	//第三相位的势能
	int Ein3=N2*(this->x3+ty-this->x2);
	temp=0;
	for(int i=this->x2+ty;i<this->x3+ty;i++){
		temp=0;
		for(int j=0;j<8;j++){
			temp+=a[i][j];
		}
		Ein3+=temp*(this->x3-i);
	}
	int Eout3=0;
	temp=0;
	for(int i=0;i<8;i++){
		temp+=s[i]*c[2][i];
	}
	tempOut=temp;
	for(int i=this->x2+td1;i<this->x3+ty-td2-1;i++){
		Eout2+=temp*(this->x3+ty-td2-i);
	}
	N3=N2;
	for(int i=this->x2+ty;i<this->x3+ty;i++){
		for(int j=0;j<8;j++){
			N3+=a[i][j];
		}
	}
	N3-=tempOut*(this->x3+ty-td2-this->x2-td1);	
	//第四相位
	int Ein4=N3*(this->x4+ty-this->x3);
	temp=0;
	for(int i=this->x3+ty;i<this->x4+ty;i++){
		temp=0;
		for(int j=0;j<8;j++){
			temp+=a[i][j];
		}
		Ein4+=temp*(this->x4-i);
	}
	int Eout4=0;
	temp=0;
	for(int i=0;i<8;i++){
		temp+=s[i]*c[3][i];
	}
	tempOut=temp;
	for(int i=this->x3+td1;i<this->x4+ty-td2;i++){
		Eout4+=temp*(this->x4+ty-td2-i);
	}
	N4=N3;
	for(int i=this->x3+ty;i<this->x4+ty;i++){
		for(int j=0;j<8;j++){
			N4+=a[i][j];
		}
	}
	N4-=tempOut*(this->x3+ty-td2-this->x2-td1);	
	//计算能量
	int E1=Ein1-Eout1;
	int E2=E1+Ein2-Eout2;
	int E3=E2+Ein3-Eout3;
	int E4=E3+Ein4-Eout4;
	double result=1000*double(this->x4+ty)/E4;
	return result;
}
double Individual::getValue(){
	return 1000/this->getEval();
}
