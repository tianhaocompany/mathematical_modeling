#include "stdafx.h"
#include "PetrolCity.h"
#include <math.h>

int  CAR_LEN  =  3333 ; 
int VERTEX_SIZE		;


POINT pos[390] ;
POINT key[3] ; 
Road road[390][390];
Vertex vertex[390] ; 

POINT position[390] ;
Road r[390][390] ; 
int passcnt[390][390] ;
int path[50][1000];

 
int pccnt ;
PetrolCar pc[50] ;


int crtpc ;
set<int> SetVertex[50] ;
int dirx,diry ; 


Way::Way( int start )
{
	v_vertex.push_back(start) ;
	length = 0 ; 
	inilen = 0 ;
}

Way::Way( int i , int j , int len )
{
	v_vertex.push_back(i);
	v_vertex.push_back(j);
	length  = len ;
	inilen  = len ;
}

bool  Way::NextWay(Way &w_new ,int next_vertex)
{
	int crt_vertex ;
	crt_vertex = v_vertex[ v_vertex.size()-1 ]  ; 
	if( length > CAR_LEN )
		return false ;
	
	int size = v_vertex.size() ;
	if( size >= 2 )
	{
		if(v_vertex[size-2] == next_vertex)
			return false ;
	}
	
	w_new = *this;
	w_new.length = road[crt_vertex][next_vertex].length + length ;
	w_new.v_vertex.push_back(next_vertex);
	return true ; 
}
bool  Way::End()
{
	if( length > CAR_LEN )
	{
		return true ;
	}
	int i , size ;
	size = v_vertex.size() ; 
	
	for( i = 0 ; i < size - 1  ; i++ )
	{
		if( v_vertex[ i ] == v_vertex[ size - 1 ])
		{
			return true ;
		}
	}
	return  false ;
}
ostream & Way::Output(ostream &out)
{
	int i;
	for( i = 0 ; i < v_vertex.size() ; i++ )
	{
		out<< v_vertex[i] + 1 <<"\t";
	}
	out<<length<<endl ; 
	return out;
}


void Way::CoverRoad()
{
	int i = 0 , size ;
	size = v_vertex.size() ; 
	int length ;
	length = this->length ;
	
	
	int k , j ; 
	if( inilen != 0 )
	{
		j = v_vertex[0] ;
		k = v_vertex[1] ;
		
		road[k][j].cover = inilen ; 
		length -= inilen ;
		i = 1 ;
	}
	
	for(  ; i < size - 2  ; i++ )
	{
		j = v_vertex[i] ;
		k = v_vertex[i+1] ;
		road[k][j].bcover = road[j][k].bcover = true ;
	}
	
	
	if( length > CAR_LEN )
	{
		j = v_vertex[ size - 2 ] ;
		k = v_vertex[ size - 1 ] ;
		int cover ;
		cover = road[j][k].length - ( length - CAR_LEN  ) ;
		
		if( cover > road[j][k].cover)
			road[j][k].cover = cover ;
	}
	
}
void Way::CoverVertex( set<int> &s_vertex)
{
	int i ;
	for( i = 0 ; i < v_vertex.size() ; i++ )
	{
		s_vertex.insert(v_vertex[i]);
	}
}

void Way::Draw(CDC * pDC , int cl)
{
	int i ;
	
	CPen p( PS_SOLID , 1 , RGB(0,0,255)) ;
	pDC->SelectObject(p);
	POINT bgpos ;
	bgpos = pos[v_vertex[0]] ;
	int len , k , j ;
	if( inilen != 0 )
	{
		j = v_vertex[0] ; 
		k = v_vertex[1] ;	
		
		int x , y ; 
		x = pos[j].x - pos[k].x ;
		y = pos[j].y - pos[k].y ;
		
		float rate ;
		rate = float(road[j][k].length - inilen) / float(road[j][k].length) ;
		
		int x2 = pos[j].x - rate*x ;
		int y2 = pos[j].y - rate*y;
		bgpos.x = x2 ;
		bgpos.y = y2 ;		
	}
	
	CPen rpen( PS_SOLID , 1 ,RGB( 100* cl/4 , 100*cl/3 ,40*(cl%3) ));
	pDC->SelectObject(rpen);
	
	pDC->Rectangle(bgpos.x / 12 - 4 ,bgpos.y / 12 - 4 , bgpos.x / 12 + 4 ,bgpos.y / 12 + 4 ) ;
	pDC->Rectangle(bgpos.x / 12 - 3 ,bgpos.y / 12 - 3 , bgpos.x / 12 + 3 ,bgpos.y / 12 + 3 ) ;

	CPen pen(PS_SOLID , 1 , RGB(255,0,0)) ;
	pDC->SelectObject(pen);
	pc[crtpc].pos = bgpos;
	
	pDC->MoveTo( bgpos.x / 12  , bgpos.y / 12 ) ;
	int size = v_vertex.size() ; 
	for( i = 1 ; i < size- 1 ; i++ )
	{
		pDC->LineTo(pos[v_vertex[i]].x / 12  , pos[v_vertex[i]].y / 12 );
	}
	j = v_vertex[size - 2] ;
	k = v_vertex[size - 1] ; 
	if( length > CAR_LEN )
	{
		len = road[j][k].length - ( length - CAR_LEN  )  ;
	}
	else
	{
		return ;
	}
	
	int x , y ; 
	x = pos[j].x - pos[k].x ;
	y = pos[j].y - pos[k].y ;
	
	float rate ;
	rate = float(len) / float(road[j][k].length) ;
	
	int x2 = pos[j].x - rate*x ;
	int y2 = pos[j].y - rate*y;
	pDC->LineTo(x2/12 -1, y2/12 - 1 );
	
	//	ot<<"end-----\n"<<pos[j].x<<"\t"<<pos[j].y<<"\n"<<x2<<"\t"<<y2<<"\n"<<pos[k].x<<"\t"<<pos[k].y<<endl<<"-----\n";
}
PetrolCar::PetrolCar( int i )
{
	start_vertex = i-1 ; 
	crt_vertex = i - 1; 
	next_vertex = crt_vertex ;
	pre_vertex = -1;
	crt_len = 0 ;
	totallen = 0;
	pathcnt = 0 ;
}

void PetrolCar::operator = (BasicCar &r) 
{
	crt_len = r.crt_len ;
	crt_vertex = r.crt_vertex;
	pre_vertex = r.pre_vertex;
	next_vertex = r.next_vertex;
	totallen = 0 ;
	pathcnt = 0 ;
}
PetrolCar::PetrolCar(  )
{
	start_vertex = 0 ; 
	crt_vertex = 0 ;
	next_vertex = 0 ;
	crt_len = 0 ; 
	pre_vertex = -1;
	pathcnt = 0 ;
}
void PetrolCar::ClearWay()
{
	v_way.clear();
}
ofstream os("srway.txt");
void PetrolCar::SerachWay() 
{
	int i ;
	
	queue<Way> q_way ;
	
	Way w(start_vertex) ;
	
	if( crt_len == 0 )
	{
		q_way.push(w);
	}
	else
	{
		os<<crt_vertex<<"\t"<<next_vertex<<endl;
		
		w = Way( crt_vertex , next_vertex , road[crt_vertex][next_vertex].length - crt_len ) ;
		q_way.push(w);
		w = Way( next_vertex , crt_vertex , crt_len ) ; 
		q_way.push(w);
	}
	
	while( !q_way.empty() )
	{
		w = q_way.front();
		q_way.pop();
		int index = w.v_vertex.size() - 1 ; 
		int v = w.v_vertex[index] ;
		
		for( i = 0 ; i < vertex[v].cnt ; i++ )
		{
			Way w_new = w ;
			if( w.NextWay( w_new , vertex[v].next[i] ) )
			{
				if( w_new.End() )
				{
					v_way.push_back( w_new ) ; 
				}
				else
				{
					q_way.push(w_new) ; 
				}
			}
		}
	}
}
ostream& PetrolCar::Output(ostream &out) 
{
	out<<"PetrolCar "<< start_vertex + 1 <<endl;
	int i ;
	for( i = 0 ; i < v_way.size() ; i++ )
	{
		v_way[i].Output(out) ; 
	}
	out<<"覆盖区域顶点----"<<endl;
	set<int> s ;
	CoverVertex(s);
	set<int>::iterator itr ;
	for( itr = s.begin() ; itr != s.end() ; itr++ )
	{
		out<<*itr + 1 <<"\t";
	}
	out<<endl<<endl;
	return out ;
}

void PetrolCar::CoverVertex( set<int> &s_vertex)
{
	int i;
	for( i = 0 ; i < v_way.size() ; i++ )
	{
		v_way[i].CoverVertex( s_vertex ) ;
	}
}

void PetrolCar::DrawWay(CDC *pDC , int cl )
{
	int i ;
	for( i = 0  ; i < v_way.size() ; i++)
	{
		v_way[i].Draw(pDC , cl );
	}
}
void PetrolCar::CoverRoad()
{
	int i ;
	for( i = 0  ; i < v_way.size() ; i++)
	{
		v_way[i].CoverRoad();
	}
}

int PetrolCar::GetNextVertex(const set<int> &si )
{
	int next ;
	float rate[10] , rcnt = 0 ;
	
	int vi,i ;
	vi = next_vertex ;
	PetrolCar p ;
	p = *this ;
	float maxrate = 0 ,minrate = 1 ;
	int maxpos = 0 , minpos ;
	int maxdis = 0 ;
	int  mincnt = 1000  ;
	int weight[10] ,maxweight;
	set<int> s_next ;

	s_next.insert(vertex[vi].next , vertex[vi].next + vertex[vi].cnt );
	set<int>::iterator itr ;

	set<int> s_nnext ;int vj;	
	int maxcnt ;

	if( crt_vertex == next_vertex )//初始状态
	{
		next = vertex[vi].next[rand()%vertex[vi].cnt];
		goto END ;
	}	

	minpos = 0 ;
	mincnt = 1000 ;	
	for( i = 0 ; i < vertex[vi].cnt  ; i++ )//区域之外
	{		
		if( si.find(vertex[vi].next[i]) == si.end() )
		{
			s_next.erase(vertex[vi].next[i] ) ;
			if( s_next.size() == 1 )
			{
				goto END;
			}
		}
	}
	for( i = 0 ; i < vertex[vi].cnt  ; i++ )
	{
		vj = vertex[vi].next[i] ; 
		if( passcnt[vi][vj] > 4 )
		{
			s_next.erase(vj);
			if(s_next.size() == 1 )
				goto END;
		}

	} 

	for( i = 0 ; i < vertex[vi].cnt ; i++ ) //选择未巡逻的路线
	{

		vj = vertex[vi].next[i] ;

		if( passcnt[vi][vj] < mincnt  )
		{
			mincnt  = passcnt[vi][vj] ;
			minpos = vj ;
		}
	}	

	for( i = 0 ; i < vertex[vi].cnt ; i++ ) 
	{
		int t ;
		t = vertex[vi].next[i] ;
		if( passcnt[vi][ t] > mincnt )
		{
			s_next.erase(t);
			if(s_next.size() == 1)
				goto END ;
		}
	}



END:

	if( s_next.size() == 1 )
	{
		next = *s_next.begin();
	}
	else
	{
		
		set<int>::iterator itr ;

		int i;
		i = rand()%s_next.size();
		int t = 0 ;
		set<int>::iterator  itr2 = s_next.begin();
		next = *itr2 ;
		while( t< i && itr2 != s_next.end() )
		{
			itr2 ++ ;
			t++ ;
			next = *itr2 ;
		}
	}
END1 :
	*this = p ;
	pre_vertex = crt_vertex ;
	crt_vertex = next_vertex ;
	next_vertex = next ;
	crt_len = 0 ;

	path[crtpc][pathcnt] = next ;
	pathcnt ++ ;
	
	passcnt[crt_vertex][next] ++ ;
	return next ;
}

int PetrolCar::GetNextVertex( set<int> &si , int ii ) //选择未巡逻的道路  , 随机选择
{/*

	crt_vertex = next_vertex ;
	set<int> s_next ;
	int vi ;
	vi = next_vertex ;	
	s_next.insert(vertex[vi].next , vertex[vi].next + vertex[vi].cnt );
	int next ;	
	int i;
	for( i = 0 ; i < vertex[vi].cnt  ; i++ )
	{		
		if( si.find(vertex[vi].next[i]) == si.end() )//区域之外
		{
			s_next.erase(vertex[vi].next[i] ) ;
		}
	}	


	passcnt[crt_vertex][next] ++ ;
	passcnt[next][crt_vertex] ++ ;*/
	return 1 ;
	
	
}

int Vertex::Get(int i) 
{
	return next[i] ;
}
void Vertex::Add(int v)
{
	next[cnt] = v ;
	cnt ++ ; 
}
float CoverRate()
{
	float rate ;
	int coverdis = 0  ;
	int i , j ;
	for( i = 0 ; i < pccnt ; i++ )
	{
		pc[i].CoverRoad();
	}
	
	ofstream dbout("dbout.txt");
	dbout<<pccnt<<endl;
	
	
	for( i = 0 ; i < VERTEX_SIZE ; i++)
	{
		for( j = i ; j < VERTEX_SIZE ;j++ )
		{	
			if(road[i][j].cover + road[j][i].cover > road[i][j].length)
			{
				road[i][j].bcover = road[j][i].bcover = true ;
			}
		}
	}
	
	
	for( i = 0 ; i < VERTEX_SIZE ; i++)
	{ 
		for( j = i + 1 ; j < VERTEX_SIZE ;j++ )
		{
			if( road[i][j].bcover)
			{
				coverdis += road[i][j].length ; 
				//	dbout<<i+1<<"\t"<<j+1<<road[i][j].length<<endl;
			}
		}
	}	
	
	int uncover = 0 ; 
	for( i = 0 ; i < VERTEX_SIZE ; i++)
	{
		for( j = 0 ; j < VERTEX_SIZE ;j++ )
		{
			if( road[i][j].cover != 0  && !road[i][j].bcover)
			{
				coverdis += road[i][j].cover ; 	
				dbout<<i+1<<"\t"<<j+1<<"\t"<<road[i][j].cover<<endl;
			}
		}
	}
	
	for( i = 0 ; i < VERTEX_SIZE ; i++)
	{ 
		for( j = i + 1 ; j < VERTEX_SIZE ;j++ )
		{
			if( !road[i][j].bcover)
			{
				uncover += road[i][j].length  - road[i][j].cover - road[j][i].cover ; 
				//	dbout<<i+1<<"\t"<<j+1<<road[i][j].length<<endl;
				
			}
		}
	}	
	
	
	ifstream in("totaldistance.txt") ;
	int totaldis ;
	in>>totaldis ;
	rate = float(coverdis) / float(totaldis) ; 
	
	dbout<<uncover<<endl;
	dbout<<coverdis<<endl;
	dbout<<uncover+coverdis<<endl ; 
	dbout<<totaldis<<endl;
	
	return rate ;
}

void DataIni()
{	
	
	key[0].x = 5112;
	key[0].y = 4806;
	key[1].x = 9126;
	key[1].y = 4266;
	key[2].x = 7434;
	key[2].y = 1332;
	dirx = 0 ;
	diry = 0 ;
	
	int i ;	
	
	for( i = 0 ; i < 390 ; i++ )
	{
		vertex[i].cnt = 0 ;
	}
	
	ifstream posin("pos.txt");
	ifstream linkin("road.txt");
	
	int  j = 0 ;
	
	while(posin>>i)
	{
		posin>>pos[i-1].x>>pos[i-1].y;
		position[i-1].x = pos[i-1].x ;
		position[i-1].y = pos[i-1].y ; 
	}
	VERTEX_SIZE =  i ;
	
	for( i = 0 ; i < 390 ; i ++ )
	{
		for( j = 0 ; j < 390 ; j++ )
		{
			road[i][j].length = 0 ; 
			road[i][j].bcover = false ;
			road[i][j].cover = 0 ; 
			road[i][j].passcnt = 0 ;
			passcnt[i][j] = 0 ; 
		}
	}
	
	int start , end ;
	while( linkin>>start>>end )
	{
		int x , y ; 
		start--;
		end--;
		vertex[start].Add( end );
		vertex[end].Add(start) ;
		
		x = pos[end].x - pos[start].x ;
		y = pos[end].y - pos[start].y ;
		road[end][start].length = road[start][end].length = sqrt( float( x*x + y*y ) ) ;
	}		
	for( i = 0 ; i < 390 ; i ++ )
	{
		for( j = 0 ; j < 390 ; j++ )
		{
			r[i][j] = road[i][j] ;
		}
	}
	
	ifstream pin("test.txt");
	if(!pin)
	{
		MessageBox(NULL , "打开text.txt文件失败", "" ,MB_OK);
	}
	int vertex ;
	pccnt = 0 ; 
	while(pin>>vertex)
	{
		pc[pccnt] = PetrolCar(vertex);
		pccnt++;
	}	
	
	for( i = 0 ; i < pccnt ; i++ )
	{
		pc[i].v_way.clear();
	}
	
	
	time_t ltime;
	time( &ltime ); 
	srand(ltime);
	
}
void ResetEnvior()
{
	int  i = 0 , j = 0 ;
	for( i = 0 ; i < 390 ; i++ )
	{
		pos[i] = position[i] ;
	}
	
	for( i = 0 ; i < 390 ; i ++ )
	{
		for( j = 0 ; j < 390 ; j++ )
		{
			road[i][j] = r[i][j] ; 
		}
	}
	
	for( i = 0 ; i < pccnt ; i++ )
	{
		pc[i].v_way.clear();
	}
}
void DrawGraph(CDC *pDC)
{
	int i , j  ;
	
	pDC->Rectangle(0,0,1500,690);
	for( i = 0 ; i < VERTEX_SIZE ; i++)
	{
		pDC->SetPixel(pos[i].x/12   , pos[i].y/12 -1, RGB(255,0,0));
		pDC->SetPixel(pos[i].x/12-1 , pos[i].y/12 -1, RGB(255,0,0));
		pDC->SetPixel(pos[i].x/12   , pos[i].y/12   , RGB(255,0,0));
		pDC->SetPixel(pos[i].x/12-1 , pos[i].y/12   , RGB(255,0,0));
	}
	pDC->SetBkMode( TRANSPARENT );
	
	CPen p( PS_SOLID , 1 , RGB(255,0,0)) ,p2(PS_SOLID,1,RGB(0,0,0));
	
	for( i = 0 ; i < VERTEX_SIZE ; i++ )
	{
		for( j = 0 ; j < vertex[i].cnt ;j++ )
		{	
		/*		char ch[10] ;
		itoa(i+1,ch,10);
		pDC->TextOut(pos[i].x/12 , pos[i].y/12  , ch);
			*/
			
			int k = vertex[i].next[j] ;
			if( road[i][k].length < 333  )
			{
				pDC->SelectObject(p);
			}
			else
			{
				pDC->SelectObject(p2);
			}
			pDC->MoveTo(pos[i].x/12 , pos[i].y/12 );
			pDC->LineTo(pos[k].x/12 , pos[k].y/12 );
			
		}
	}
	COLORREF c(RGB(0,0,255));
	
	int k ; 
	for( i = 0 ; i < 3 ; i++ )
	{
		for( j = 0 ; j < 5 ; j ++ )
		{
			for( k = 0 ;  k < 5 ; k++ )
			{
				
				pDC->SetPixel(key[i].x/12 + j , key[i].y/12 + k,   c);
				
			}
		}
	}
}
bool PCGroup::operator < ( const PCGroup &r) const 
{
	return rate < r.rate ;
}

PCGroup PCGroup::Born(int *gune)
{
	PCGroup pcg ;
	pcg = *this ;
	
	int i  ;
	for( i = 0 ; i < carcnt ; i++ )
	{
		pcg.vertex[i] = gune[i] ;
	}
	return pcg ;
}
void PCGroup::ResetEnvior()
{
	//	ifstream posin("pos.txt");
	//	ifstream linkin("road.txt");
	
	int  i = 0 , j = 0 ;
	
	for( i = 0 ; i < 390 ; i++ )
	{
		pos[i] = position[i] ;
	}
	
	for( i = 0 ; i < 390 ; i ++ )
	{
		for( j = 0 ; j < 390 ; j++ )
		{
			road[i][j] = r[i][j] ; 
		}
	}
	
	pccnt = carcnt ;
	
	for( i = 0 ; i < pccnt ; i++ )
	{
		pc[i] = PetrolCar( vertex[i]  ) ;
	}
}
void PCGroup::GetRate()
{	
	int i;
	for( i = 0 ; i < pccnt ; i++ )
	{
		pc[i].SerachWay();
	}
	rate = CoverRate() ;
}
PCGroup PCGroup::NextPCG(  )
{
	PCGroup pcg ;
	pcg = *this ;
	int i ;
	int minpos , mlen;
	minpos = 0 ;
	mlen = 8000 ;
	int len ;
	
	for( i = 0 ; i < carcnt ; i++ )
	{
		len = road[ pc[i].crt_vertex ][ pc[i].next_vertex ].length - pc[i].crt_len ;
		if( mlen > len )
		{
			mlen = len ;
			minpos = i ;
		}
	}
	
	return pcg ;
	
}

ostream& PCGroup::Output(ostream & out )
{
	out<<carcnt<<endl;
	int i;
	for( i = 0 ; i < carcnt ; i++ )
	{
		out<<vertex[i]<<"\t";
	}
	out<<endl;
	out<<"覆盖率-----"<<rate<<endl;
	return out;
}
PCGroup::PCGroup(int count , int *v)
{
	carcnt = count ;
	int i;
	for( i = 0 ; i < carcnt ; i++ )
	{
		vertex[i] = v[i] ;
	}
}
PCGroup::PCGroup()
{
	carcnt = 0 ;
}

Genu::Genu()
{
	int i;
	for( i = 0 ; i < 20 ; i++ )
		data[ i ] = 0 ; 
	len = 0 ; 
}

void Genu::Aberr()
{
	int i , j , k ; 	
	
	for( i = 0 ; i < 2 ; i ++ )
	{
		j = rand()%len ;
		k = rand()%vertex[j].cnt;
		data[j] = vertex[j].next[k] ;
	}
}
void Genu::Aberr2()
{	
	int i , j , k ; 	
	
	for( i = 0 ; i < 10 ; i ++ )
	{
		j = rand()%len ;
		data[j] = rand()%308;
	}
}
void Genu::Cross(Genu &r)
{
	int i , j , k ;
	time_t ltime;
	time( &ltime ); 
	//	srand(ltime);
	
	j = rand()%(len - 4) ;
	for( i = j ; i < j+4 ; i++ )
	{
		k = data[i] ;
		data[i] = r.data[i] ; 
		r.data[i] =  k ;
	}
	
}
bool Genu::operator< (const Genu &r) const 
{
	return rate < r.rate ;
}
GenuGroup::GenuGroup( PCGroup pcg  )
{
	generation = 0 ;
	gpsize = 50 ;
	int i , j ;
	
	for( i = 0 ; i < gpsize ; i++ )
	{
		genu[i].pcg = pcg ; 
	}
	
	genu[0].len = genu[0].pcg.carcnt ;
	genu[gpsize-1].len = genu[gpsize-1].pcg.carcnt ;
	for( i = 0 ; i < pcg.carcnt ; i++ )
	{
		genu[0].data[i] =  genu[0].pcg.vertex[i] ; 
		genu[ gpsize - 1 ].data[i] =  genu[gpsize -1 ].pcg.vertex[i] ; 
	}
	
	for( i = 1; i < gpsize - 1 ; i++ )
	{
		genu[i].len = genu[i].pcg.carcnt ;
		for( j = 0 ; j < genu[i].pcg.carcnt ; j++  )
		{
			genu[i].data[j] = rand()%308 + 1  ;
		}
	}	
	
	for( i = 0 ; i < gpsize ; i++)
	{
		sort( genu[i].data , genu[i].data + genu[i].len );
		genu[i].pcg = genu[i].pcg.Born( genu[i].data ) ;
		genu[i].pcg.ResetEnvior();
		genu[i].pcg.GetRate();
		genu[i].rate = genu[i].pcg.rate ; 
	}
}
void GenuGroup::Evolution()
{
	int i ;
	time_t ltime;
	time( &ltime ); 
	//	srand(ltime);
	generation ++ ;
	
	sort(genu , genu + gpsize) ;
	Genu g[3] ;
	
	g[0] = genu[ gpsize - 1] ; 
	
	
	for( i = 0 ; i < 40 ; i++ )
	{
		i = rand()%(gpsize - 1) ;
		genu[i].Aberr();
	}		
	
	for(  i = gpsize - 3 ; i > gpsize/2 ; i-- )
	{ 
		if(genu[i].rate == genu[gpsize - 1].rate )
		{
			genu[i].Aberr() ; 
		}
		else
		{
			break ; 
		}
	}
	
/*	for( i = 0 ; i < 30 ; i++ )
	{
		i = rand()%(gpsize - 1) ;
		genu[i].Aberr2();
	}
*/	
	for( i = 0 ; i < 30 ; i++ )
	{
		int j , k ;
		j = rand()%(gpsize-1) ;
		k = rand()%(gpsize-1) ;
		while( j == k )
		{
			k = rand()%(gpsize-1) ; 
		}
		genu[j].Cross( genu[k] ) ;
	}

	
	for( i = 0 ; i < gpsize ; i++)
	{
		sort(genu[i].data , genu[i].data + genu[i].len ) ;

		int j ;
		for( j = 0 ; j < genu[i].len - 1 ; j++ )
		{
			int vi , vj ;
			vi = genu[i].data[j] ;
			vj = genu[i].data[j+1] ; 
			if( vi == vj || road[vi][vj].length != 0 )
			{
				genu[i].data[j] = rand()%308 ;
				i--;
				break;
			}
		}
	}	
	for( i = 0 ; i < gpsize ; i++)
	{
		genu[i].pcg = genu[i].pcg.Born( genu[i].data ) ;
		genu[i].pcg.ResetEnvior();
		genu[i].pcg.GetRate();
		genu[i].rate = genu[i].pcg.rate ; 
	}
	
	genu[0] = g[ 0 ] ; 
}
ostream & GenuGroup::Output(ostream &out)
{
	out<<"遗传算法第"<<generation<<"代"<<endl;
	int i ;
	for( i = 0 ; i < gpsize ; i++ )
	{
		out<<"个体"<<i<<endl;
		genu[i].pcg.Output(out);
	}
	out.flush();
	return out;
}
RandomGroup::RandomGroup( ){}

RandomGroup::RandomGroup( int ii )
{
	totallen = 0 ;
	int i , j  ; 
	for( i = 0 ; i < pccnt ; i++)
	{
		pc[i].crt_len = ::pc[i].crt_len;
		pc[i].crt_vertex = ::pc[i].crt_vertex;
		pc[i].next_vertex = ::pc[i].next_vertex;
		pc[i].pre_vertex = ::pc[i].pre_vertex;
	}
	for( i = 0 ; i<pccnt ; i++ )
	{
		int vj ;
		vj = pc[i].crt_vertex ;
		pc[i].next_vertex = vertex[vj].next[ rand()%vertex[vj].cnt ] ;
		pc[i].crt_len = 0 ; 
	}
	totallen = 0 ;


}/*
RandomGroup & RandomGroup::operator = (RandomGroup &r) 
{
	for( i = 0 ; i <pccnt ; i++ )
	{
		pc[i].
	}
}*/
float RandomGroup::GetRate(CDC *pDC)
{
	ResetEnvior();
	int i ;
	for( i = 0 ; i < pccnt ; i++ )
	{
		::pc[i] = pc[i] ;
	}

	for( i = 0  ; i < pccnt ; i++)
	{
		::pc[i].ClearWay();
		::pc[i].SerachWay();
		::pc[i].DrawWay(pDC) ;
	}	
	
	for( i = 0  ; i < pccnt ; i++)
	{
		::pc[i].CoverRoad();
	}
	  rate = CoverRate();		
	  
	 for( i = 0  ; i < pccnt ; i++)
	{
		 ::pc[i].ClearWay();
	}	
	  return rate ;

}
ofstream ipcout("ipc.txt");
RandomGroup RandomGroup::Born(  )
{	
	RandomGroup rg ;
	rg = *this ;
	rg.pc[ipc].pre_vertex = rg.pc[ipc].crt_vertex ;	
	rg.pc[ipc].crt_vertex = rg.pc[ipc].next_vertex ;	
	rg.pc[ipc].next_vertex = rg.dir[crtdir] ;
	crtdir ++ ;	

	return rg ;

}
ostream& RandomGroup::Output(ofstream &out)
{
	out<<"总里程\t"<<totallen<<endl;
	out<<"当前覆盖率\t"<<rate<<endl;
	int i;
	for(i = 0 ; i < pccnt ;i ++ )
	{
		out<<pc[i].crt_vertex<<"\t";
	}
	out<<endl;
	return out ;
}
RandomGroup RandomGroup::Go(  )
{
	int i , j , k , len , minlen = 200000 , minpos = 0 ;

	
	for( i = 0 ; i < pccnt ; i++ )
	{
		j = pc[i].crt_vertex ;
		k = pc[i].next_vertex ;

		if( road[j][k].length != 0 )
		{
			len = road[j][k].length - pc[i].crt_len ;
			if( minlen > len )
			{
				minpos = i ;
				minlen = len ;
			}
		}
	}
	ipc = crtpc = minpos ; 	
	
	for( i = 0 ; i < pccnt ; i++ )
	{
		if(i != minpos)
		{
			pc[i].crt_len += minlen ;
		}
		else
		{
			pc[i].crt_len = 0 ;
		}
	}
	totallen += minlen ;
	
	

	pc[ipc].pre_vertex = pc[ipc].crt_vertex ;
	pc[ipc].crt_vertex = pc[ipc].next_vertex ;

	pc[ipc].crt_len = 0 ;

	ipcout<<ipc<<endl;

	int vi ;

	vi = pc[ipc].crt_vertex ;
	set<int> s_next ; 
	s_next.insert(vertex[vi].next , vertex[vi].next + vertex[vi].cnt );
	
	set<int> &si= SetVertex[ipc];

	for( i = 0 ; i < vertex[vi].cnt  ; i++ )
	{		
		if( si.find(vertex[vi].next[i]) == si.end() )//区域之外
		{
			s_next.erase(vertex[vi].next[i] ) ;
		}
	}	

	set<int>::iterator itr ;
	if(s_next.size() > 1 )
		s_next.erase(pc[ipc].pre_vertex) ;

	dircnt = 0 ;
	for( itr = s_next.begin() ; itr != s_next.end() ; itr++)
	{
		dir[dircnt] = *itr ;
		dircnt ++ ;
	}
	crtdir = 0  ;

	RandomGroup rg ;
	rg = *this ;
	rg.pc[ipc].pre_vertex = rg.pc[ipc].crt_vertex ;	
	rg.pc[ipc].crt_vertex = rg.pc[ipc].next_vertex ;	
	rg.pc[ipc].next_vertex = rg.dir[crtdir] ;

	crtdir ++ ;	

	return rg ;

}







Graph::Graph( int i )
{
	PetrolCar pc;
	pc.start_vertex = i ;
	pc.ClearWay();
	pc.SerachWay();	

	int j ; 
	
	for( j = 0 ; j < pc.v_way.size() ; j++ )
	{
		s_vertex.insert( pc.v_way[j].v_vertex.begin() , pc.v_way[j].v_vertex.end()-1   );
	}
	set<int>::iterator itr ;
	for( itr = s_vertex.begin() ; itr != s_vertex.end() ; itr++ )
	{
		v_vertex.push_back( vertex[*itr] );
	}
	
	
	
}