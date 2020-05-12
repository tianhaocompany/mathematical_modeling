#include"individual.h"
#include"HpRandom.h"
#include"parameter.h"
#include<fstream>
#include<iostream>
#include<list>
#include<math.h>
#include<algorithm>
using namespace std;
#define MAXINDIVIDUAL 1000                   //定义种群规模
#define p_intercross 0.3                     //定义交叉概率
#define p_aberrance 0.2                      //定义变异概率
#define Max_Step 100                        //定义最大
Individual items[MAXINDIVIDUAL];            //种群
double selectTable[MAXINDIVIDUAL];          //记录轮赌盘
extern int Nmin;                            //定义绿灯持续的最小时间
extern int Nmax;                            //定义绿灯持续的最大时间
extern int Lmin;
extern int Lmax;
extern int a[400][8];
Individual best;
double bestValue;
bool check(const Individual item){
	if(item.x1<Nmin||item.x2-item.x1<Nmin||item.x3-item.x2<Nmin||item.x4-item.x3<Nmin){
		return false;
	}
	if(item.x1>Nmax||item.x2-item.x1>Nmax||item.x3-item.x2>Nmax||item.x4-item.x3>Nmax){
		return false;
	}
	if(item.x4>Lmax||item.x4<Lmin){
		return false;
	}
	return true;
}
Individual* generateNew(const Individual a1,const Individual a2){
	Individual* item=new Individual();
	do{
		double r1=HpRandom::getNextUniformly();
		double r2=HpRandom::getNextUniformly();
		double r3=HpRandom::getNextUniformly();
		double r4=HpRandom::getNextUniformly();
		item->x1=int(a1.x1*r1+a2.x1*(1-r1));
		item->x2=int(a1.x2*r2+a2.x2*(1-r2));
		item->x3=int(a1.x3*r3+a2.x3*(1-r3));
		item->x4=int(a1.x4*r4+a2.x4*(1-r4));
	}while(!check(*item));
	return item;
}
void aberrance(){
	for(int i=0;i<MAXINDIVIDUAL;i++){
		double r=HpRandom::getNextUniformly();
		int rr=int(HpRandom::getNextUniformly()*4);
		if(r<p_aberrance){
			do{
				switch(rr){
					case 0:
						items[i].x1=int(HpRandom::getNextUniformly(Nmin,Nmax));
						break;
					case 1:
						items[i].x2=int(HpRandom::getNextUniformly(Nmin*2,Nmax*2));
						break;
					case 2:
						items[i].x3=int(HpRandom::getNextUniformly(3*Nmin,Nmax*3));
						break;
					case 3:
						items[i].x4=int(HpRandom::getNextUniformly(4*Nmin,Nmax*4));
				}
			}while(!check(items[i]));
		}
	}
}
int select(){                 //定义选择操作
	int value=HpRandom::getNextUniformly()*(selectTable[MAXINDIVIDUAL-1]);
	for(int i=0;i<MAXINDIVIDUAL;i++){
		if(selectTable[i]>value){
			return i;
		}
	}
	return -1;
}
void intercross(){            //定义交叉操作
	selectTable[0]=items[0].getEval();
	for(int i=1;i<MAXINDIVIDUAL;i++){
		double value=items[i].getEval();
		selectTable[i]=selectTable[i-1]+value;
		if(bestValue<value){
			bestValue=value;
			best.x1=items[i].x1;
			best.x2=items[i].x2;
			best.x3=items[i].x3;
			best.x4=items[i].x4;
		}
	}
	//以上为初始化轮赌盘
	for(int i=0;i<MAXINDIVIDUAL;i++){
		double p=HpRandom::getNextUniformly();
		if(p<p_intercross){
			int index1=select();
			int index2=select();
			items[i]=*(generateNew(items[index1],items[index2]));
		}
	}
}
void m_init(){
	HpRandom::init();//初始化随机种子
	for(int i=0;i<MAXINDIVIDUAL;i++){
		do{
			items[i]=*(new Individual(HpRandom::getNextUniformly(Nmin,Nmax),HpRandom::getNextUniformly(2*Nmin,2*Nmax),HpRandom::getNextUniformly(3*Nmin,3*Nmax),HpRandom::getNextUniformly(4*Nmin,4*Nmax)));
		}while(!check(items[i]));
	}
	init_parameter();
}
void print(){
	for(int i=0;i<MAXINDIVIDUAL;i++){
		cout<<items[i].x1<<","<<items[i].x2<<","<<items[i].x3<<","<<items[i].x4<<endl;
	}
}
void printbest(){
	cout<<"最好的值为："<<best.getValue()<<endl;
	cout<<"配时:"<<best.x1<<" "<<best.x2-best.x1<<","<<best.x3-best.x2<<","<<best.x4-best.x3<<endl;
	cout<<"均车延误"<<best.getDelayPerCar()<<endl;
}
//void save(){
//	ofstream fout("E:\\data.txt",ios::app);
//	fout<<"交通流:"<<endl;
//	for(int i=0;i<400;i++){
//		for(int j=0;j<8;j++){
//			fout<<a[i][j]<<" ";
//		}
//		fout<<endl;
//	}
//	fout<<"最好的值为："<<items[printbest()].getValue()<<endl;
//	fout<<"配时:"<<items[printbest()].x1<<" "<<items[printbest()].x2-items[printbest()].x1<<","<<items[printbest()].x3-items[printbest()].x2<<","<<items[printbest()].x4-items[printbest()].x3<<endl;
//	fout.close();
//}
int main(){
	m_init();
	//int i=0;
	//while(i<Max_Step){
	//	intercross();
	//	aberrance();
	//	i++;
	//}
	//printbest();
	Individual* fixed= new Individual(2,4,6,8);
	cout<<"fixed: "<<fixed->getValue()<<endl;//<<"固定分配的均车延误:"
		//<<fixed->getDelayPerCar()<<endl;

}