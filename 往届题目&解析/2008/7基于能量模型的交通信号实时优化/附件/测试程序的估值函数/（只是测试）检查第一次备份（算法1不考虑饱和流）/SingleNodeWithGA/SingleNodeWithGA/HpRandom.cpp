#include"HpRandom.h"
#include<math.h>
#include<iostream>
double HpRandom::getNextUniformly(double a,double b){
	return (double(rand())/(RAND_MAX+1))*(b-a)+a;
}
void HpRandom::init(){
	srand((unsigned)(time(NULL)));
}
double HpRandom::getNextNormal(double u,double delta){
	double sum=0;
	for(int i=0;i<12;i++){
		sum+=getNextUniformly();
	}
	return u+sqrt(delta)*(sum-6);
}
int HpRandom::getNextPossion(double lumta){
	int x=0;
	double b=1;
	double	temp_u=HpRandom::getNextUniformly(0,1);
	double value=exp(-lumta);
	while(b>=value){
		b=b*temp_u;
		temp_u=HpRandom::getNextUniformly(0,1);
        x++;
	}
	return x-1;
}
double HpRandom::getNextExponent(double beta){
	double temp=HpRandom::getNextUniformly();
	return -beta*log(temp);
}
//int main(){
//	HpRandom::init();
//	double temp[20];
//	double sum=0;
//	for(int i=0;i<20;i++){
//		temp[i]=HpRandom::getNextPossion(30);
//		sum+=temp[i];
//		std::cout<<temp[i]<<std::endl;
//	}
//	std::cout<<"sum:"<<sum<<std::endl<<"¾ùÖµÎª:"<<sum/20<<std::endl;
//	system("pause");
//}