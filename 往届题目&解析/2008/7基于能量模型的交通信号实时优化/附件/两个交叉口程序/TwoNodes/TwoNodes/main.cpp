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
extern int a1[400][12];
extern int a2[400][12];
bool check(const Individual item){
	if(item.x1<Nmin||item.x2-item.x1<Nmin||item.x3-item.x2<Nmin||item.x4-item.x3<Nmin){
		return false;
	}
	if(item.x1>Nmax||item.x2-item.x1>Nmax||item.x3-item.x2>Nmax||item.x4-item.x3>Nmax){
		return false;
	}
	if(item.x5<Nmin||item.x6-item.x5<Nmin||item.x7-item.x6<Nmin||item.x8-item.x7<Nmin){
		return false;
	}
	if(item.x5>Nmax||item.x6-item.x5>Nmax||item.x7-item.x6>Nmax||item.x8-item.x7>Nmax){
		return false;
	}
	if(item.x8>Lmax||item.x8<Lmin){
		return false;
	}
	if(item.x4>Lmax||item.x4<Lmin){
		return false;
	}
	if(item.x4!=item.x8){    //周期不等
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
		double r5=HpRandom::getNextUniformly();
		double r6=HpRandom::getNextUniformly();
		double r7=HpRandom::getNextUniformly();
		double r8=HpRandom::getNextUniformly();
		item->x1=int(a1.x1*r1+a2.x1*(1-r1));
		item->x2=int(a1.x2*r2+a2.x2*(1-r2));
		item->x3=int(a1.x3*r3+a2.x3*(1-r3));
		item->x4=int(a1.x4*r4+a2.x4*(1-r4));
		item->x5=int(a1.x5*r5+a2.x5*(1-r5));
		item->x6=int(a1.x6*r6+a2.x6*(1-r6));
		item->x7=int(a1.x7*r7+a2.x7*(1-r7));
		item->x8=int(a1.x8*r8+a2.x8*(1-r8));
	}while(!check(*item));
	return item;
}
void aberrance(){
	for(int i=0;i<MAXINDIVIDUAL;i++){
		double r=HpRandom::getNextUniformly();
		int rr=int(HpRandom::getNextUniformly()*8);
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
						items[i].x8=items[i].x4;
						break;
					case 4:
						items[i].x5=int(HpRandom::getNextUniformly(Nmin,Nmax));
						break;
					case 5:
						items[i].x6=int(HpRandom::getNextUniformly(Nmin*2,Nmax*2));
						break;
					case 6:
						items[i].x7=int(HpRandom::getNextUniformly(3*Nmin,Nmax*3));
						break;
					case 7:
						items[i].x8=int(HpRandom::getNextUniformly(4*Nmin,Nmax*4));
						items[i].x4=items[i].x8;
						break;
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
		selectTable[i]=selectTable[i-1]+items[i].getEval();
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
			int temp[8];
			temp[0]=HpRandom::getNextUniformly(Nmin,Nmax);
			for(int k=1;k<4;k++){
				temp[k]=HpRandom::getNextUniformly(temp[k-1]+Nmin,temp[k-1]+Nmax);
			}
			temp[4]=HpRandom::getNextUniformly(Nmin,Nmax);
			for(int k=5;k<7;k++){
				temp[k]=HpRandom::getNextUniformly(temp[k-1]+Nmin,temp[k-1]+Nmax);
			}
			temp[7]=temp[3];
			items[i]=*(new Individual(temp[0],temp[1],temp[2],temp[3],temp[4],temp[5],temp[6],temp[7]));
		}while(!check(items[i]));
	}
	init_parameter();
}
void print(){
	for(int i=0;i<MAXINDIVIDUAL;i++){
		cout<<items[i].x1<<","<<items[i].x2<<","<<items[i].x3<<","<<items[i].x4<<endl;
	}
}
int printbest(){
	double value=0;
	int maxIndex=0;
	for(int i=0;i<MAXINDIVIDUAL;i++){
		if(items[i].getEval()>value){
			value=items[i].getEval();
			maxIndex=i;
		}
	}
	Individual temp=items[maxIndex];
	cout<<"best is:"<<endl<<"x1="<<temp.x1<<endl<<"x2="<<temp.x2-temp.x1<<endl<<"x3="<<temp.x3-temp.x2<<endl<<"x4="<<temp.x4-temp.x3<<endl;
	cout<<"best is:"<<endl<<"x5="<<temp.x5<<endl<<"x6="<<temp.x6-temp.x5<<endl<<"x7="<<temp.x7-temp.x6<<endl<<"x4="<<temp.x8-temp.x7<<endl;
	cout<<"best value is: "<<temp.getValue()<<endl<<"E1:"<<temp.getE1Eval()<<"E2:"<<temp.getE2Eval()<<endl<<"EM:"<<temp.getEmEval()<<endl;

	//cout<<"value:"<<1/value*(items[maxIndex].x4+3)<<endl<<endl;
	return maxIndex;
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
	for(int k=0;k<10;k++){
		cout<<"第"<<k<<"组数据："<<endl;
		m_init();
		int i=0;
		while(i<Max_Step){
			intercross();
			aberrance();
			i++;
		}
		int best=printbest();
		Individual* fixed= new Individual();
		cout<<"fixed: "<<fixed->getValue()<<endl;
	}
}