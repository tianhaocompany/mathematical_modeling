#include"parameter.h"
class Individual{
public:
	int x1,x2,x3,x4,x5,x6,x7,x8;
	Individual(int x1,int x2,int x3,int x4,int x5,int x6,int x7,int x8){
        this->x1=x1;
		this->x2=x2;
		this->x3=x3;
		this->x4=x4;
		this->x5=x5;
		this->x6=x6;
        this->x7=x7;
		this->x8=x8;
	}
	Individual():x1(30),x2(60),x3(90),x4(120),x5(30),x6(60),x7(90),x8(120){}
	double getEval();
	double getValue();
//private:
	double getE1Eval();
	double getE2Eval();
	double getEmEval();
};