#include <iostream>
#include <fstream>
#include <vector>
#include <string>
#include <math.h>
using namespace std;

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


const int In = 8;

double calTime(double y0,double v0,double h0,int type)
{
	y0 = y0/100;
	double A=(quality[In]-qualityF[In])/(meanK*Sxy[In][type][2]);
	double B=sqrt((quality[In]*9.8-1000*volumn[In]*9.8)/(meanK*Sxy[In][type][1]));
	double V2= -(quality[In]*sqrt(2.0*9.8*h0))/(quality[In]+qualityF[In]);
	double C4;
	double T;
	double  result;
	if(V2>(-B))
	{
		C4=(B-V2)/(V2+B);
		T=(
			(1.0+C4)*exp((0.275-y0)/A) + 
			sqrt(((1.0+C4)*exp((0.275-y0)/A))*((1.0+C4)*exp((0.275-y0)/A)) - 4.0*C4)
			)/(2.0*C4);
		result = A*log(T)/B;
	}
	else if(V2<(-B))
	{
		C4=(B-V2)/(-V2-B);
		T=(
			-(1.0-C4)*exp((0.275-y0)/A) - 
			sqrt(((1.0-C4)*exp((0.275-y0)/A))*((1.0+C4)*exp((0.275-y0)/A)) + 4.0*C4)
			)/(2.0*C4);
		result = A*log(T)/B;
	}
	else if(V2==(-B))
	{
		result=(0.275-y0)/B;
	}
	return result;
}
double calStartTime(double y0,double v0,double h0,int type)
{
	y0 = y0/100;
	double A=(quality[In]-qualityF[In])/(meanK*Sxy[In][type][2]);
	double B=sqrt((quality[In]*9.8-1000*volumn[In]*9.8)/(meanK*Sxy[In][type][1]));
	double V2= -(quality[In]*sqrt(2.0*9.8*h0))/(quality[In]+qualityF[In]);
	double C4=fabs((B-V2))/fabs((V2+B));
	//double C4=fabs((B-V2)/(V2+B));
	double T=(
		(1.0+C4)*exp((0.275-y0)/A) + 
		sqrt(((1.0+C4)*exp((0.275-y0)/A))*((1.0+C4)*exp((0.275-y0)/A)) - 4.0*C4)
		)/(2.0*C4);
	double result=A*log(T)/B;
	return result;   //起始时间
}
double calEndTime(double y1,double v0,double h0,int type)
{
	double  et=0;
	y1 = y1/100;
	double A=(quality[In]-qualityF[In])/(meanK*Sxy[In][type][2]);
	double B=sqrt((quality[In]*9.8-1000*volumn[In]*9.8)/(meanK*Sxy[In][type][1]));
	double V2= -(quality[In]*sqrt(2.0*9.8*h0))/(quality[In]+qualityF[In]);
	double C4=fabs((B-V2))/fabs((V2+B));
	//double C4=fabs((B-V2)/(V2+B));
	double T=(
		(1.0+C4)*exp((0.275-y1)/A) + 
		sqrt(((1.0+C4)*exp((0.275-y1)/A))*((1.0+C4)*exp((0.275-y1)/A)) - 4.0*C4)
		)/(2.0*C4);
	double result=A*log(T)/B;
	return result;   //起始时间
}
void getXY(double t,double& x,double& y,double v0,double h0,int type)
{
	double A=(quality[In]-qualityF[In])/(meanK*Sxy[In][type][2]);
	double B=sqrt((quality[In]*9.8-1000*volumn[In]*9.8)/(meanK*Sxy[In][type][1]));
	double V2= -(quality[In]*sqrt(2.0*9.8*h0))/(quality[In]+qualityF[In]);
	/*double C4;
	if(V2>(-B))
	{
	C4=(-V2+B)/(V2+B);
	y=0.275+B*t-A*log(1+C4*exp(2*B*t/A))+A*log(1+C4);
	}
	else if(V2<(-B))
	{
	C4=(-V2+B)/(-V2-B);
	y=0.275+B*t-A*log(1-C4*exp(2*B*t/A))+A*log(1-C4);
	}
	else if(V2==(-B))
	{
	y=0.275-B*t;
}*/
	double C4=fabs((B-V2))/fabs((V2+B));
	x=v0*t-((quality[In]+qualityF[In])/meanK*Sxy[In][type][0])*log(meanK*Sxy[In][type][0]*v0*t+quality[In]+qualityF[In])
		+((quality[In]+qualityF[In])/(meanK*Sxy[In][type][0]))*log(quality[In]+qualityF[In]);
	y=0.275+B*t-A*log(1+C4*exp(2*B*t/A))+A*log(1+C4);
}
int main()
{
	vector<double >posY;
	vector<double >posX;
	ifstream fin;
	fin.open("33.txt");  ///文件名。。。。。
	ofstream fout,ftime;
	fout.open("result.txt");
	ftime.open("time.txt");
	string typeName[]={"平放","立放","竖放"};
	double velc[]={0.34,0.40,0.47,0.55};
	double height[]={0,0.05,0.12};
	double a;
	int i=0,j=0,k=0,m; //控制当前的模型的速度、高度、投放种类
	int flags=0;
	for(i=0;i<4;i++)  //速度
	{
		cout<<"--速度:"<<velc[i]<<endl;
		fout<<"--速度:"<<velc[i]<<endl;
		ftime<<"--速度:"<<velc[i]<<endl;
		for(j=0;j<3;j++)  //高度
		{
			cout<<"----高度:"<<height[j]<<endl;
			fout<<"----高度:"<<height[j]<<endl;
			ftime<<"----高度:"<<height[j]<<endl;
			if(In==8||In==9)
			{
					flags=0;
					posY.clear();
					posX.clear();
					while(flags!=2)
					{
						fin>>a;
						if(a==0) 
						{flags++;continue;}
						if(flags==0) posY.push_back(a);
						else if(flags==1) posX.push_back(a);
					}
					int vecSize=posY.size();
					//double sTime=calTime(posY[0],velc[i],height[j],k);//calStartTime(posY[0],velc[i],height[j],k);
					double sTime = calStartTime(posY[0],velc[i],height[j],k);
					//cout<<sTime<<endl;
					//double eTime=calTime(posY[vecSize-1],velc[i],height[j],k);
					double eTime = calEndTime(posY[vecSize-1],velc[i],height[j],k);
					ftime<<" ("<<sTime<<","<<eTime<<") ";
					double t=sTime;
					double meanError=0;
					for(m=0;t<=eTime,m<vecSize;)
					{
						double x,y;
						getXY(t,x,y,velc[i],height[j],k);
						meanError += ((x-posX[m]/100)*(x-posX[m]/100)+(y-posY[m]/100)*(y-posY[m]/100));
						m++;
						t=sTime+m*0.04;
					}
					meanError/=m;
					fout<<meanError<<endl;
			}
			else
			{
				for(k=0;k<3;k++)  //投放方式
				{
					cout<<"------方式:"<<typeName[k]<<endl;
					fout<<"------方式:"<<typeName[k]<<endl;
					ftime<<"------方式:"<<typeName[k]<<endl;
					flags=0;
					posY.clear();
					posX.clear();
					while(flags!=2)
					{
						fin>>a;
						if(a==0) 
						{flags++;continue;}
						if(flags==0) posY.push_back(a);
						else if(flags==1) posX.push_back(a);
					}
					int vecSize=posY.size();
					//double sTime=calTime(posY[0],velc[i],height[j],k);//calStartTime(posY[0],velc[i],height[j],k);
					double sTime = calStartTime(posY[0],velc[i],height[j],k);
					//cout<<sTime<<endl;
					//double eTime=calTime(posY[vecSize-1],velc[i],height[j],k);
					double eTime = calEndTime(posY[vecSize-1],velc[i],height[j],k);
					ftime<<" ("<<sTime<<","<<eTime<<") ";
					double t=sTime;
					double meanError=0;
					for(m=0;t<=eTime;)
					{
						double x,y;
						getXY(t,x,y,velc[i],height[j],k);
						meanError += ((x-posX[m]/100)*(x-posX[m]/100)+(y-posY[m]/100)*(y-posY[m]/100));
						m++;
						t=sTime+m*0.04;
					}
					meanError/=m;
					fout<<meanError<<endl;
					/*for(m=0;m<vecSize;m++)
					{
					cout<<" ("<<posX[m]<<","<<posY[m]<<") ";
					fout<<" ("<<posX[m]<<","<<posY[m]<<") ";
				}*/
					cout<<endl;
					fout<<endl;
					ftime<<endl;
				}
			}
			cout<<endl;
			fout<<endl;
			ftime<<endl;
		}
		cout<<"========================================================="<<endl;
		fout<<"========================================================="<<endl;
		ftime<<"========================================================="<<endl;
	}
	fin.close();
	fout.close();
	ftime.close();
	return 0;
}
