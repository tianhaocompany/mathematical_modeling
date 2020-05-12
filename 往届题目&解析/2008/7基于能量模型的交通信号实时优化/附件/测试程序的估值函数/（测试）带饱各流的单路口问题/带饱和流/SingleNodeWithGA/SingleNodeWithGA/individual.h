#include"parameter.h"
class Individual{
public:
	int x1,x2,x3,x4;
	Individual(int x1,int x2,int x3,int x4){
        this->x1=x1;
		this->x2=x2;
		this->x3=x3;
		this->x4=x4;
	}
	Individual():x1(30),x2(60),x3(90),x4(120){}
	double getEval();
	double getValue();
	double getDelayPerCar();
private:
	int getNpi(int vInit,int from,int ni,int minusNumber,int index);//解出某车道将所有积累车流放完的时间
};