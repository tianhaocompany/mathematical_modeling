#pragma once
#include"parameter.h"
#include"HpRandom.h"
#include<iostream>
using namespace std;
int c[4][12]={{1,0,0,0,0,0,1,0,0,0,0,0},{0,1,0,0,0,0,0,1,0,0,0,0},{0,0,0,1,0,0,0,0,0,1,0,0},{0,0,0,0,1,0,0,0,0,0,1,0}};
int a1[400][12];
int a2[400][12];
int s1[12]={4,4,4,4,4,4,4,4,4,4,4,4};
int s2[12]={3,3,3,3,3,3,2,2,2,2,2,2};
int exceptRight[12]={1,1,0,1,1,0,1,1,0,1,1,0};
int td1=2;//起动时延时
int td2=1;//由于黄灯停止的延误
int ty=3;//黄灯时间
int Nmin=6;
int Nmax=60;
int Lmin=48;
int Lmax=140;
double K=1;
double lumda=2;
double d=0.2;
void init_parameter(){
	//int test1[12];
	//int test2[12];
	//for(int i=0;i<12;i++){
	//	test1[i]=(int)HpRandom::getNextUniformly(1,4);
	//	test2[i]=(int)HpRandom::getNextUniformly(1,4);
	//}
	for(int i=0;i<400;i++){
		for(int j=0;j<12;j++){
			a1[i][j]=HpRandom::getNextPossion(2);
			a2[i][j]=HpRandom::getNextPossion(2);
		}
	}
	//for(int i=0;i<12;i++){
	//	std::cout<<test1[i]<<",";
	//}
	//cout<<endl;
	//for(int i=0;i<12;i++){
	//	cout<<test2[i]<<",";
	//}
}
