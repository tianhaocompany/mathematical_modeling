#include <iostream>
#include <fstream>
#include <string>
#include <math.h>
using namespace std;
//大实心方块 0
//小实心方块 1
//大空心方块 2
//小空心方块 3
//大实心蜂巢 4
//小实心蜂巢 5
//大空心蜂巢 6
//小空心蜂巢 7
//大三角锥   8
//小三角锥   9
string name[]={
				"大实心方块",
				"小实心方块",
				"大空心方块",
				"小空心方块",
				"大实心蜂巢",
				"小实心蜂巢",
				"大空心蜂巢",
				"小空心蜂巢",
				"大三角锥",
				"小三角锥"
				};
const int N = 10;
const dropType = 3;
const vecType = 4;
const heightType = 3;
const double meanK=1050;
const double volumn[N] = {0.000256,    //体积
                        0.000032,
						0.000192,
						0.000024,
						0.00016238,
						0.000019476,
						0.000113293,
						0.000013586,
						0.00002545588,
						0.000003181981};
const double quality[N] = {0.000256*2300,    //质量m
                        0.000032*2300,
						0.000192*2300,
						0.000024*2300,
						0.00016238*2300,
						0.000019476*2300,
						0.000113293*2300,
						0.000013586*2300,
						0.00002545588*2300,
						0.000003181981*2300};
const double qualityF[N] = {0.000256*1000,    //质量mf
                        0.000032*1000,
						0.000192*1000,
						0.000024*1000,
						0.00016238*1000,
						0.000019476*1000,
						0.000113293*1000,
						0.000013586*1000,
						0.00002545588*1000,
						0.000003181981*1000};



double Sxy[10][3][2]={//受力面积
	{{0.0032,0.0064},{0.0064,0.0032},{0.0032,0.0032}},
    {{0.0008,0.0016},{0.0016,0.0008},{0.0008,0.0008}},
	{{0.0032,0.0048},{0.0048,0.0032},{0.0032,0.0032}},
	{{0.0008,0.0012},{0.0012,0.0008},{0.0008,0.0008}},
	{{0.0021651,0.0064952},{0.0064952,0.0021651},{0.0021651,0.0021651}},
	{{0.0005196,0.0016238},{0.0016238,0.0005196},{0.0005196,0.0005196}},
	{{0.0021651,0.0044957},{0.0044957,0.0021651},{0.0021651,0.0021651}},
	{{0.0005196,0.000828},{0.000828,0.0005196},{0.0005196,0.0005196}},
	{{0.001559,0.001559},{0.001559,0.001559},{0.001559,0.001559}},
	{{0.00039,0.00039},{0.00039,0.00039},{0.00039,0.00039}},
					};

double calM_()  //计算m'
{
	return 1000*9.8*pow(10,-6);
}
const double M_ = calM_();

//n表示个体的序号
//type表示投放的方式
double  calA(int n,int type)  //求dotaA
{
	double result=0;
	result=(M_+pow(10,-4));
    double max = fabs(1.0/(meanK*Sxy[n][type][1]));
	if( (quality[n]-qualityF[n])/(meanK*Sxy[n][type][1]*Sxy[n][type][1]) > max)
		max=(quality[n]-qualityF[n])/(meanK*Sxy[n][type][1]*Sxy[n][type][1]);
	result*=max;
	return result;
}

double  calB(int n,int type)//求dotaB
{
	double result = 0.5*pow(10,-4);
	result*=sqrt((quality[n]*9.8-1000*volumn[n]*9.8)/(meanK*Sxy[n][type][1]));
	result*=1.0/Sxy[n][type][1];
	return result;
}

double  calE(int n,double h0)//求e
{
	double result = M_+0.01;
	double max = (quality[n]*sqrt(2.0*9.8*h0))/((quality[n]+qualityF[n])*(quality[n]+qualityF[n]));
	if(quality[n]/((quality[n]+qualityF[n])*sqrt(8.0*9.8*h0)) > max)
		max=(quality[n]+qualityF[n])*sqrt(8.0*9.8*h0);
	result *= max;
	return result;
}

double calC(int n,double h0,int type) //求c
{
	double result;
	double e=calE(n,h0);
	double b=calB(n,type);
	double V2= -(quality[n]*sqrt(2.0*9.8*h0))/(quality[n]+qualityF[n]);
	double B=sqrt((quality[n]*9.8-1000*volumn[n]*9.8)/(meanK*Sxy[n][type][1]));
	double max;
	/*if(V2>(-B))
	{
		max=-2*B/((V2+B)*(V2+B));
		if( 2*V2/((V2+B)*(V2+B)) > max)
			max = 2*V2/((V2+B)*(V2+B));
	}
	else if(V2<(-B))
	{
		max=2*B/((V2+B)*(V2+B));
		if( -2*V2/((V2+B)*(V2+B)) > max)
			max = -2*V2/((V2+B)*(V2+B));
	}*/
		max=-2*B/((V2+B)*(V2+B));
		if( 2*V2/((V2+B)*(V2+B)) > max)
			max = 2*V2/((V2+B)*(V2+B));
	result = (e+b)*max;
	return result;
}

double calTd(int n,double h0,int type)  //计算td
{
	double result;
	double V2= -(quality[n]*sqrt(2.0*9.8*h0))/(quality[n]+qualityF[n]);
	double B=sqrt((quality[n]*9.8-1000*volumn[n]*9.8)/(meanK*Sxy[n][type][1]));
	double c4=fabs((V2-B))/fabs((V2+B));
	double A=(quality[n]-qualityF[n])/(meanK*Sxy[n][type][1]);
	double Tao=(-(1.0-c4)*exp(0.275/A) + sqrt(((1.0-c4)*exp(0.275/A))*((1.0-c4)*exp(0.275/A))+4.0*c4)) / (2.0*c4);
	result = A*log(Tao)/B;
	return result;
}

double calDotaX(int n,double h0,int type,double  v0)
{
	double result=fabs(M_)+pow(10,-4);
	double TD = calTd(n,h0,type);
	double t=0;
	double max1=0,max2=0,max=0;
	while(t < TD)
	{
		double temp = meanK*Sxy[n][type][0]*v0*t+quality[n]+qualityF[n];
		double x1=1.0/(meanK*quality[n]+qualityF[n])*log((quality[n]+qualityF[n])/temp);
		x1+=v0*t/temp;
		if(fabs(x1) > max1) max1=fabs(x1);

		double x2=(quality[n]+qualityF[n])/(meanK*Sxy[n][type][0]*Sxy[n][type][0]);
		x2 *= log(temp/(quality[n]+qualityF[n]));
		x2 -= v0*t*(quality[n]+qualityF[n])/(Sxy[n][type][0]*temp);
		if(fabs(x2) > max2) max2=fabs(x2);

		t+=0.01;
	}
	if(max1>max) max=max1;
	if(max2>max) max=max2;
	result *= max;
	return result;
}

double calDotaY(int n,double h0,int type,double  v0)
{
	double result;
	double max;
	double V2= -(quality[n]*sqrt(2.0*9.8*h0))/(quality[n]+qualityF[n]);
	double B=sqrt((quality[n]*9.8-1000*volumn[n]*9.8)/(meanK*Sxy[n][type][1]));
	double c4;
	double A=(quality[n]-qualityF[n])/(meanK*Sxy[n][type][1]);
	double TD = calTd(n,h0,type);
	double t=0;
	double max1=0,max2=0,max3=0;
	c4=fabs((-V2+B))/fabs((V2+B));
	while(t<TD)
	{
		double temp = exp(2*B*t/A);
		double x1=t + 2*t*c4*temp/(1+c4*temp);
		if(fabs(x1) > max1) max1=fabs(x1);
			
		double x2=-log(1+c4*temp) - (2*B*t*c4*temp)/(A*(1+c4*temp)) + log(1+c4);
		if(fabs(x2) > max2) max2=fabs(x2);
			
		double x3=-A*temp/(1+c4*temp) + A/(1+c4);
		if(fabs(x3)>max3) max3=fabs(x3);
			
		t+=0.01;
	}
    /*if(V2>(-B))
	{
		c4=(-V2+B)/(V2+B);
		while(t<TD)
		{
			double temp = exp(2*B*t/A);
			double x1=t + 2*t*c4*temp/(1+c4*temp);
			if(fabs(x1) > max1) max1=fabs(x1);
			
			double x2=-log(1+c4*temp) - (2*B*t*c4*temp)/(A*(1+c4*temp)) + log(1+c4);
			if(fabs(x2) > max2) max2=fabs(x2);
			
			double x3=-A*temp/(1+c4*temp) + A/(1+c4);
			if(fabs(x3)>max3) max3=fabs(x3);
			
			t+=0.01;
		}
	}
	else if(V2<(-B))
	{
		c4=(-V2+B)/(-V2-B);
		while(t<TD)
		{
			double temp = exp(2*B*t/A);
			double x1=t + 2*t*c4*temp/(1-c4*temp);
			if(fabs(x1) > max1) max1=fabs(x1);
			
			double x2=log(1-c4*temp) + (2*B*t*c4*temp)/(A*(1-c4*temp)) - log(1-c4);
			if(fabs(x2) > max2) max2=fabs(x2);
			
			double x3=A*temp/(1-c4*temp) - A/(1-c4);
			if(fabs(x3)>max3) max3=fabs(x3);
			
			t+=0.01;
		}
	}*/

	//double c4=fabs((V2-B))/fabs((V2+B));
	//double A=(quality[n]-qualityF[n])/(meanK*Sxy[n][type][1]);
	max=max1;
	if(max2>max) max=max2;
	if(max3>max) max=max3;
	double b=calB(n,type);
	double a=calA(n,type);
	double c=calC(n,h0,type);
	//result=max*(b+a+c);
	result=max*(b+a);
	//result=max*(0.001+b+a);
	return result;
}
int main()
{
	//(int n,double h0,int type,double  v0)
	ofstream fout;
	fout.open("error.txt");
	double valueX,valueY;
	string dropName[]={"平放","立放","竖放"};
	double velc[]={0.34,0.40,0.47,0.55};
    double height[]={0,0.05,0.12};
	int i,j,k,m;
	for(i=0;i<10;i++)   //10种物品
	{
		cout<<name[i]<<":\n"<<endl;
		fout<<name[i]<<":\n"<<endl;
		for(j=0;j<3;j++)   //3种高度
		{
			cout<<"--高度:"<<height[j]<<endl;
			fout<<"--高度:"<<height[j]<<endl;
			for(k=0;k<4;k++) //4种速度
			{
				cout<<"----速度:"<<velc[k]<<endl;
				fout<<"----速度:"<<velc[k]<<endl;
				for(m=0;m<3;m++)  //3种投放方式
				{
					valueX=calDotaX(i,height[j],m,velc[k]);
					valueY=calDotaY(i,height[j],m,velc[k]);
					//printf(" (%.9f,%.9f) ",valueX,valueY);
					fout<<" ("<<valueX<<","<<valueY<<") ";
				}
				cout<<endl;
				fout<<endl;
			}
		}
		cout<<"====================================================="<<endl;
		fout<<"====================================================="<<endl;
	}
	//double value = calDotaY(0,0.12,0,0.34);
	//printf("%.9f\n",value);
	return 0;
}
