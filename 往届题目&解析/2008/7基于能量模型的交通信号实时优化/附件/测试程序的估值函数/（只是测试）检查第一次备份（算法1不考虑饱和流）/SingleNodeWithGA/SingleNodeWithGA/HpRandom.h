#include<stdlib.h>
#include"time.h"
class HpRandom{
public:
	static void init();
	//返回一个U(a,b)分布的随机数
	static double getNextUniformly(double a=0,double b=1);
	//返回一个满足正态分布
	static double getNextNormal(double u=0,double delta=1);
	//返回一个满足lumta的泊松分布
	static int getNextPossion(double lumta);
	//返回一个满足指数分布f=1/beta*exp(-x/beta),x>=0的分布
	static double getNextExponent(double beta);
};