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
extern int v0;//每个道品初始的车辆数，为一个定参数
double Individual::getEval(){
	int v01=v0;
	int np1=getNpi(v01,0,this->x1+ty-td2,td1,0);
	int v05=v0;
	int np5=getNpi(v05,0,this->x1+ty-td2,td1,4);
	int v02=v0;
	for(int i=0;i<this->x1+ty+td1;i++){
		v02+=a[i][1];
	}
	int np2=getNpi(v02,this->x1+ty+td1,this->x2+ty-td2,(this->x1+ty+td1),1);
    int v06=v0;
	for(int i=0;i<this->x1+ty+td1;i++){
		v06+=a[i][5];
	}
	int np6=getNpi(v06,this->x1+ty+td1,this->x2+ty-td2,(this->x1+ty+td1),5);
    int v03=v0;
	for(int i=0;i<this->x2+ty+td1-1;i++){
		v03+=a[i][2];
	}
	int np3=getNpi(v03,this->x2+ty+td1,this->x3+ty-td2,(this->x2+ty+td1),2);
    int v07=v0;
	for(int i=0;i<this->x2+ty+td1-1;i++){
		v07+=a[i][6];
	}
	int np7=getNpi(v07,this->x2+ty+td1,this->x3+ty-td2,(this->x2+ty+td1),6);
	int v04=v0;
	for(int i=0;i<this->x3+ty+td1-1;i++){
		v04+=a[i][3];
	}
	int np4=getNpi(v04,this->x3+ty+td1,this->x4+ty-td2,this->x3+ty+td1,3);
    int v08=v0;
	for(int i=0;i<this->x3+ty+td1-1;i++){
		v04+=a[i][7];
	}
	int np8=getNpi(v08,this->x3+ty+td1,this->x4+ty-td2,this->x3+ty+td1,7);
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
	for(int j=td1;j<=np1;j++){
		Eout1+=s[0]*(this->x1+ty-td2-j);
	}
	for(int j=td1;j<=np5;j++){
		Eout1+=s[4]*(this->x1+ty-td2-j);
	}
	for(int i=np1+1;i<this->x1+ty-td2;i++){
		Eout1+=a[i][0]*(this->x1+ty-td2-i);
	}
	for(int i=np5+1;i<this->x1+ty-td2;i++){
		Eout1+=a[i][4]*(this->x1+ty-td2-i);;
	}
	int N1=8*v0-s[0]*(np1-td1)-s[4]*(np5-td1);
	temp=0;
	for(int i=0;i<this->x1+ty;i++){
		for(int j=0;j<8;j++){
			N1+=a[i][j];
		}
	}
	for(int i=np1+1;i<=this->x1+ty-td2;i++){
		temp+=a[i][0];
	}
	for(int i=np5+1;i<=this->x1+ty-td2;i++){
		temp+=a[i][4];
	}
	N1-=temp;
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
	temp=0;
    int Eout2=0;
	for(int j=this->x1+td1;j<=np2;j++){
		Eout2+=s[1]*(this->x2+ty-td2-j);
	}
	for(int j=this->x1+td1;j<=np6;j++){
		Eout2+=s[5]*(this->x2+ty-td2-j);
	}
	for(int i=np2+1;i<this->x2+ty-td2;i++){
		Eout2+=a[i][1]*(this->x2+ty-td2-i);
	}
	for(int i=np6+1;i<this->x2+ty-td2;i++){
		Eout2+=a[i][5]*(this->x2+ty-td2-i);
	}
	int N2=N1-s[1]*(np1-td1)-(np5-td1)*s[5];
	temp=0;
	for(int i=this->x1+ty;i<this->x2+ty;i++){
		for(int j=0;j<8;j++){
            N2+=a[i][j];
		}
	}
	for(int i=np2+1;i<=this->x2+ty-td2;i++){
		temp+=a[i][1];
	}
	for(int i=np6+1;i<=this->x2+ty-td2;i++){
		temp+=a[i][5];
	}
	N2-=temp;
	//第三相位
	int Ein3=N2*(this->x3+ty-this->x2);
	temp=0;
	for(int i=this->x2+ty;i<this->x3+ty;i++){
		temp=0;
		for(int j=0;j<8;j++){
			temp+=a[i][j];
		}
		Ein3+=temp*(this->x3-i);
	}
	temp=0;
    int Eout3=0;
	for(int j=this->x2+td1;j<=np3;j++){
		Eout3+=s[2]*(this->x3+ty-td2-j);
	}
	for(int j=this->x2+td1;j<=np7;j++){
		Eout3+=s[6]*(this->x3+ty-td2-j);
	}
	for(int i=np3+1;i<=this->x3+ty-td2;i++){
		Eout3+=a[i][2]*(this->x3+ty-td2-i);
	}
	for(int i=np7+1;i<=this->x3+ty-td2;i++){
		Eout3+=a[i][6]*(this->x3+ty-td2-i);
	}
	int N3=N2-s[2]*(np3-this->x2-td1)-(np7-this->x2-td1)*s[6];
	temp=0;
	for(int i=this->x2+ty;i<this->x3+ty;i++){
		for(int j=0;j<8;j++){
            N3+=a[i][j];
		}
	}
	for(int i=np3+1;i<this->x3+ty-td2;i++){
		temp+=a[i][2];
	}
	for(int i=np7+1;i<this->x3+ty-td2;i++){
		temp+=a[i][6];
	}
	N3-=temp;
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
	temp=0;
    int Eout4=0;
	for(int j=this->x3+td1;j<=np4;j++){
		Eout4+=s[3]*(this->x4+ty-td2-j);
	}
	for(int j=this->x3+td1;j<=np8;j++){
		Eout4+=s[7]*(this->x4+ty-td2-j);
	}
	for(int i=np4+1;i<=this->x4+ty-td2;i++){
		Eout4+=a[i][3]*(this->x4+ty-td2-i);
	}
	for(int i=np8+1;i<=this->x4+ty-td2;i++){
		Eout4+=a[i][7]*(this->x4+ty-td2-i);
	}
	int N4=N3-s[3]*(np4-this->x3-td1)-(np8-this->x3-td1)*s[7];
	temp=0;
	for(int i=this->x3+ty;i<this->x4+ty;i++){
		for(int j=0;j<8;j++){
            N4+=a[i][j];
		}
	}
	for(int i=np4+1;i<this->x4+ty-td2;i++){
		temp+=a[i][3];
	}
	for(int i=np8+1;i<this->x4+ty-td2;i++){
		temp+=a[i][7];
	}
	N4-=temp;
	int E1=Ein1-Eout1;
	int E2=E1+Ein2-Eout2;
	int E3=E2+Ein3-Eout3;
	int E4=E3+Ein4-Eout4;
    double result=1000*double(this->x4+ty)/E4;
	return result;
}
int Individual::getNpi(int vInit,int from,int ni,int minusNumber,int index){
	int l_sum=vInit;
	int i;
	for(i=from;i<ni;i++){
		l_sum+=a[i][index];
		if(l_sum<(i-minusNumber+1)*s[0]){
			break;
		}
	}
	return (i<ni)?i:ni;
}
double Individual::getValue(){
	return 1000/this->getEval();
}
double Individual::getDelayPerCar(){
		int v01=v0;
	int np1=getNpi(v01,0,this->x1+ty-td2,td1,0);
	int v05=v0;
	for(int i=this->x1+ty-td2+1;i<this->x4+ty;i++){
		v05+=a[i][4];
	}
	int np5=getNpi(v05,0,this->x1+ty-td2,td1,4);
	int v02=v0;
	for(int i=0;i<this->x1+ty+td1-1;i++){
		v02+=a[i][1];
	}
	int np2=getNpi(v02,this->x1+ty+td1,this->x2+ty-td2,(this->x1+ty+td1),1);
    int v06=v0;
	for(int i=0;i<this->x1+ty+td1-1;i++){
		v06+=a[i][5];
	}
	int np6=getNpi(v06,this->x1+ty+td1,this->x2+ty-td2,(this->x1+ty+td1),5);
    int v03=v0;
	for(int i=0;i<this->x2+ty+td1-1;i++){
		v03+=a[i][2];
	}
	int np3=getNpi(v03,this->x2+ty+td1,this->x3+ty-td2,(this->x2+ty+td1),2);
    int v07=v0;
	for(int i=0;i<this->x2+ty+td1-1;i++){
		v07+=a[i][6];
	}
	int np7=getNpi(v07,this->x2+ty+td1,this->x3+ty-td2,(this->x2+ty+td1),6);
	int v04=v0;
	for(int i=0;i<this->x3+ty+td1-1;i++){
		v04+=a[i][3];
	}
	int np4=getNpi(v04,this->x3+ty+td1,this->x4+ty-td2,this->x3+ty+td1,3);
    int v08=v0;
	for(int i=0;i<this->x3+ty+td1-1;i++){
		v04+=a[i][7];
	}
	int np8=getNpi(v08,this->x3+ty+td1,this->x4+ty-td2,this->x3+ty+td1,7);
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
	for(int j=td1;j<=np1;j++){
		Eout1+=s[0]*(this->x1+ty-td2-j);
	}
	for(int j=td1;j<=np5;j++){
		Eout1+=s[4]*(this->x1+ty-td2-j);
	}
	for(int i=np1+1;i<this->x1+ty-td2;i++){
		Eout1+=a[i][0]*(this->x1+ty-td2-i);
	}
	for(int i=np5+1;i<this->x1+ty-td2;i++){
		Eout1+=a[i][4]*(this->x1+ty-td2-i);;
	}
	int N1=8*v0-s[0]*(np1-td1)-s[4]*(np5-td1);
	temp=0;
	for(int i=0;i<this->x1+ty;i++){
		for(int j=0;j<8;j++){
			N1+=a[i][j];
		}
	}
	for(int i=np1+1;i<=this->x1+ty-td2;i++){
		temp+=a[i][0];
	}
	for(int i=np5+1;i<=this->x1+ty-td2;i++){
		temp+=a[i][4];
	}
	N1-=temp;
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
	temp=0;
    int Eout2=0;
	for(int j=this->x1+td1;j<=np2;j++){
		Eout2+=s[1]*(this->x2+ty-td2-j);
	}
	for(int j=this->x1+td1;j<=np6;j++){
		Eout2+=s[5]*(this->x2+ty-td2-j);
	}
	for(int i=np2+1;i<this->x2+ty-td2;i++){
		Eout2+=a[i][1]*(this->x2+ty-td2-i);
	}
	for(int i=np6+1;i<this->x2+ty-td2;i++){
		Eout2+=a[i][5]*(this->x2+ty-td2-i);
	}
	int N2=N1-s[1]*(np1-td1)-(np5-td1)*s[5];
	temp=0;
	for(int i=this->x1+ty;i<this->x2+ty;i++){
		for(int j=0;j<8;j++){
            N2+=a[i][j];
		}
	}
	for(int i=np2+1;i<=this->x2+ty-td2;i++){
		temp+=a[i][1];
	}
	for(int i=np6+1;i<=this->x2+ty-td2;i++){
		temp+=a[i][5];
	}
	N2-=temp;
	//第三相位
	int Ein3=N2*(this->x3+ty-this->x2);
	temp=0;
	for(int i=this->x2+ty;i<this->x3+ty;i++){
		temp=0;
		for(int j=0;j<8;j++){
			temp+=a[i][j];
		}
		Ein3+=temp*(this->x3-i);
	}
	temp=0;
    int Eout3=0;
	for(int j=this->x2+td1;j<=np3;j++){
		Eout3+=s[2]*(this->x3+ty-td2-j);
	}
	for(int j=this->x2+td1;j<=np7;j++){
		Eout3+=s[6]*(this->x3+ty-td2-j);
	}
	for(int i=np3+1;i<=this->x3+ty-td2;i++){
		Eout3+=a[i][2]*(this->x3+ty-td2-i);
	}
	for(int i=np7+1;i<=this->x3+ty-td2;i++){
		Eout3+=a[i][6]*(this->x3+ty-td2-i);
	}
	int N3=N2-s[2]*(np3-this->x2-td1)-(np7-this->x2-td1)*s[6];
	temp=0;
	for(int i=this->x2+ty;i<this->x3+ty;i++){
		for(int j=0;j<8;j++){
            N3+=a[i][j];
		}
	}
	for(int i=np3+1;i<this->x3+ty-td2;i++){
		temp+=a[i][2];
	}
	for(int i=np7+1;i<this->x3+ty-td2;i++){
		temp+=a[i][6];
	}
	N3-=temp;
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
	temp=0;
    int Eout4=0;
	for(int j=this->x3+td1;j<=np4;j++){
		Eout4+=s[3]*(this->x4+ty-td2-j);
	}
	for(int j=this->x3+td1;j<=np8;j++){
		Eout4+=s[7]*(this->x4+ty-td2-j);
	}
	for(int i=np4+1;i<=this->x4+ty-td2;i++){
		Eout4+=a[i][3]*(this->x4+ty-td2-i);
	}
	for(int i=np8+1;i<=this->x4+ty-td2;i++){
		Eout4+=a[i][7]*(this->x4+ty-td2-i);
	}
	int N4=N3-s[3]*(np4-this->x3-td1)-(np8-this->x3-td1)*s[7];
	temp=0;
	for(int i=this->x3+ty;i<this->x4+ty;i++){
		for(int j=0;j<8;j++){
            N4+=a[i][j];
		}
	}
	for(int i=np4+1;i<this->x4+ty-td2;i++){
		temp+=a[i][3];
	}
	for(int i=np8+1;i<this->x4+ty-td2;i++){
		temp+=a[i][7];
	}
	N4-=temp;
	int E1=Ein1-Eout1;
	int E2=E1+Ein2-Eout2;
	int E3=E2+Ein3-Eout3;
	int E4=E3+Ein4-Eout4;
    double result=E4/N4;
	return result;
}