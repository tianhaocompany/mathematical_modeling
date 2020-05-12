#ifndef PETROLCITY_H
#define PETROLCITY_H


#define LINE_SIZE		


#include <queue> 
#include <vector>
#include <fstream>
#include <set>
using namespace std;

	

struct Road
{
	int length ;
	int cover ;
	bool bcover ;
	int passcnt ;
};

struct Way
{
	Way(int start);
	Way( int i , int j ,int len ) ;

	bool	NextWay(Way &w_new ,int next_vertex);
	bool	End();
void Draw(CDC * pDC , int cl = 0 );
	void	CoverRoad();
	ostream& Output(ostream &out) ;
	void CoverVertex( set<int> &s_vertex);

	vector<int> v_vertex ;
	int		length ;
	int		inilen ; 
};

struct Vertex
{
	int start ;
	int next[10] ;
	int cnt ;
	void Add(int v);
	inline int Get(int i) ;
};
struct BasicCar
{
	int crt_vertex ;
	int next_vertex ;
	int pre_vertex ;
	int crt_len ;
};
struct PetrolCar
{
	PetrolCar( int i ) ; 
	PetrolCar() ; 

	POINT pos;
	int start_vertex ;

	int crt_vertex ;
	int next_vertex ;
	int pre_vertex ;
	int crt_len ;
	int pathcnt ;

	int totallen ;

	vector<Way> v_way ;

	void SerachWay()  ;
	void ClearWay();

	void DrawWay(CDC *pDC , int cl = 0 );
	void CoverRoad();
	int GetNextVertex( set<int> &si , int ii);
	int GetNextVertex(const set<int> &si  );
	void operator =(BasicCar &r) ; 

	
	ostream& Output(ostream &out) ;
	void CoverVertex( set<int> &s_vertex);

};
struct PCGroup
{
	PCGroup(int count , int *v);
	PCGroup();
	int carcnt ;
	int vertex[50] ;
	float rate ;

	PCGroup NextPCG();

	void GetRate();
	void ResetEnvior();
	PCGroup Born(int *gune);
	ostream& Output(ostream & out );
	bool operator < ( const PCGroup &r) const ;
};

struct Genu
{
	Genu();
	int data[50] ;
	int len ;
	float rate ;
	PCGroup pcg;
	void Aberr2();

	void Aberr();
	void Cross(Genu &r);
	bool operator< (const Genu &r) const ;
};

struct GenuGroup
{
	int gpsize ;
	int generation ;
	GenuGroup( PCGroup pcg );
	Genu  genu[50] ;

	void Evolution();
	ostream& Output(ostream &out);
};

struct RandomGroup
{
	BasicCar pc[40] ;
	int dir[10];
	int dircnt ;
	int crtdir ;
	float rate ;
	int totallen ;
	int ipc  ;

	RandomGroup();
	RandomGroup(int i);

	RandomGroup Born();
	ostream& Output(ofstream &out);
	RandomGroup Go();
	float GetRate(CDC *pDC);
/*	RandomGroup & operator = (RandomGroup &r) ;*/
};

struct Graph
{
	set<int> s_vertex ;
	vector<Vertex> v_vertex ;
	Graph( int i);
};

float CoverRate();
void DataIni();
void DrawGraph(CDC *pDC);
void ResetEnvior();

#endif