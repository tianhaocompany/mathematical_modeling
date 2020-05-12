// nprogDlg.cpp : implementation file
//

#include "stdafx.h"
#include "nprog.h"
#include "nprogDlg.h"

#include <fstream>
#include <math.h>
using namespace std;
#include "PetrolCity.h"

extern int VERTEX_SIZE ; 
extern int CAR_LEN ;

extern POINT pos[390] ;
extern POINT key[3] ; 

extern Road road[390][390];
extern Vertex vertex[390] ; 

extern PetrolCar pc[30] ;
extern int pccnt ;
extern int crtpc ;
extern int POS[30] ;
extern int passcnt[390][390];
extern int path[50][1000];

extern set<int> SetVertex[30] ; 



#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CAboutDlg dialog used for App About

class CAboutDlg : public CDialog
{
public:
	CAboutDlg();
	
	// Dialog Data
	//{{AFX_DATA(CAboutDlg)
	enum { IDD = IDD_ABOUTBOX };
	//}}AFX_DATA
	
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CAboutDlg)
protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL
	
	// Implementation
protected:
	//{{AFX_MSG(CAboutDlg)
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

CAboutDlg::CAboutDlg() : CDialog(CAboutDlg::IDD)
{
	//{{AFX_DATA_INIT(CAboutDlg)
	//}}AFX_DATA_INIT
}

void CAboutDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CAboutDlg)
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CAboutDlg, CDialog)
//{{AFX_MSG_MAP(CAboutDlg)
// No message handlers
//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CNprogDlg dialog

CNprogDlg::CNprogDlg(CWnd* pParent /*=NULL*/)
: CDialog(CNprogDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CNprogDlg)
	m_coverrate = _T("");
	//}}AFX_DATA_INIT
	// Note that LoadIcon does not require a subsequent DestroyIcon in Win32
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
}

void CNprogDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CNprogDlg)
	DDX_Text(pDX, IDC_COVER, m_coverrate);
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CNprogDlg, CDialog)
//{{AFX_MSG_MAP(CNprogDlg)
ON_WM_SYSCOMMAND()
ON_WM_PAINT()
ON_WM_QUERYDRAGICON()
ON_BN_CLICKED(IDC_BTN_GENU, OnBtnGenu)
ON_BN_CLICKED(IDC_BTN_FORWARD, OnBtnForward)
ON_BN_CLICKED(IDC_BTN_TIME, OnBtnTime)
ON_BN_CLICKED(IDC_BTN_BACK, OnBtnBack)
	ON_BN_CLICKED(IDC_BUTTON1, OnButton1)
	ON_BN_CLICKED(IDC_BUTTON2, OnButton2)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CNprogDlg message handlers

BOOL CNprogDlg::OnInitDialog()
{
	CDialog::OnInitDialog();
	
	// Add "About..." menu item to system menu.
	
	// IDM_ABOUTBOX must be in the system command range.
	ASSERT((IDM_ABOUTBOX & 0xFFF0) == IDM_ABOUTBOX);
	ASSERT(IDM_ABOUTBOX < 0xF000);
	
	CMenu* pSysMenu = GetSystemMenu(FALSE);
	if (pSysMenu != NULL)
	{
		CString strAboutMenu;
		strAboutMenu.LoadString(IDS_ABOUTBOX);
		if (!strAboutMenu.IsEmpty())
		{
			pSysMenu->AppendMenu(MF_SEPARATOR);
			pSysMenu->AppendMenu(MF_STRING, IDM_ABOUTBOX, strAboutMenu);
		}
	}
	
	// Set the icon for this dialog.  The framework does this automatically
	//  when the application's main window is not a dialog
	SetIcon(m_hIcon, TRUE);			// Set big icon
	SetIcon(m_hIcon, FALSE);		// Set small icon
	
	// TODO: Add extra initialization here
	
	return TRUE;  // return TRUE  unless you set the focus to a control
}

void CNprogDlg::OnSysCommand(UINT nID, LPARAM lParam)
{
	if ((nID & 0xFFF0) == IDM_ABOUTBOX)
	{
		CAboutDlg dlgAbout;
		dlgAbout.DoModal();
	}
	else
	{
		CDialog::OnSysCommand(nID, lParam);
	}
}

// If you add a minimize button to your dialog, you will need the code below
//  to draw the icon.  For MFC applications using the document/view model,
//  this is automatically done for you by the framework.

void CNprogDlg::OnPaint() 
{
	if (IsIconic())
	{
		CPaintDC dc(this); // device context for painting
		
		SendMessage(WM_ICONERASEBKGND, (WPARAM) dc.GetSafeHdc(), 0);
		
		// Center icon in client rectangle
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;
		
		// Draw the icon
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{
		CDialog::OnPaint();
	}
}

// The system calls this to obtain the cursor to display while the user drags
//  the minimized window.
HCURSOR CNprogDlg::OnQueryDragIcon()
{
	return (HCURSOR) m_hIcon;
}
ofstream stout("set.txt");
void CNprogDlg::OnOK() 
{
	CAR_LEN  = 2500 ;
	CClientDC dc(this);
	
	DataIni(); 
	ResetEnvior();
	DrawGraph(&dc);	
	int i;
	pc[0].next_vertex = 298;
	//	pc[0].crt_len = 400 ; 
	for( i = 0 ; i < pccnt ; i++ )
	{
		if( pc[i].start_vertex == 105 || pc[i].start_vertex == 276 || pc[i].start_vertex == 122)
		{
			CAR_LEN = 1333;	
		}
		pc[i].SerachWay();
		CAR_LEN = 2000;
	}

	set<int> si ;
	set<int>::iterator iitr ;
	for( i = 0 ; i < pccnt ; i++ )
	{
		int j ;
		for( j = 0 ; j < pc[i].v_way.size() ; j++ )
		{
			si.insert(pc[i].v_way[j].v_vertex.begin()  , pc[i].v_way[j].v_vertex.end() );
		}
		stout<<pc[i].start_vertex+1<<endl;
		for(iitr = si.begin() ; iitr != si.end() ; iitr++)
		{
			stout<<*iitr+1<<"  ";
		}
		stout<<endl;
		si.clear();
	}

	
	ofstream out("way.txt") ; 
	for( i = 0 ; i < pccnt ; i++ )
	{
		pc[i].Output(out);
	}
	
	for( i = 0 ; i < pccnt ; i++ )
	{
		pc[i].DrawWay(&dc);
	}
	
	static int ratecnt = 0  ;
	float averrate = 0  ;
	
	float f = CoverRate();
	
	averrate = (averrate * ratecnt + f ) /(ratecnt + 1 ) ;
	
	
	m_coverrate.Format("覆盖率%f -- 平均覆盖率%f" , f ,averrate ) ; 
	UpdateData(FALSE) ;

	
	for( i = 0 ; i < pccnt ; i++ )
	{
		int vj , j ; 
		vj = pc[i].start_vertex ;
		
		/*	SetVertex[i].insert( vertex[vj].next , vertex[vj].next + vertex[vj].cnt );
		SetVertex[i].insert(pc[i].start_vertex);
		*/
		for( j = 0 ; j < pc[i].v_way.size() ; j++ )
		{
			SetVertex[i].insert(pc[i].start_vertex  );
			
			if(pc[i].start_vertex == 210)
			{
				SetVertex[i].insert(192);
				SetVertex[i].insert(254);
				SetVertex[i].insert(259);
				SetVertex[i].insert(210);
				SetVertex[i].insert(166);
				continue ;
			}
			else if( pc[i].start_vertex == 31)
			{
				SetVertex[i].insert(31);
				SetVertex[i].insert(32);
				SetVertex[i].insert(35);
				SetVertex[i].insert(37);
				SetVertex[i].insert(13);
				SetVertex[i].insert(8);
				SetVertex[i].insert(11);
				SetVertex[i].insert(25);
				
				continue ;
			}
			else if( pc[i].start_vertex == 51)
			{
				SetVertex[i].insert(51);
				SetVertex[i].insert(41);
				SetVertex[i].insert(40);
				SetVertex[i].insert(46);
				continue ;
				
			}
			int minus  = 0;
			

			int index ;
			index = pc[i].crt_vertex ;

			if( pos[ index ].x > 2178 && pos[ index ].x < 11574 && pos[index].y > 864 && pos[index].y < 7164  )
			{
				minus = 0 ;
			}

			if( pc[i].start_vertex == 305 ||pc[i].start_vertex == 35   )
			{
				
				SetVertex[i].insert( pc[i].v_way[j].v_vertex.begin() , pc[i].v_way[j].v_vertex.end() - minus   );
				SetVertex[i].insert(pc[i].start_vertex  );
			}
			else
			{
				SetVertex[i].insert( pc[i].v_way[j].v_vertex.begin() , pc[i].v_way[j].v_vertex.end() - 1 - minus  );	
				SetVertex[i].insert(pc[i].start_vertex  );
			}if( pc[i].start_vertex == 76)
			{
				SetVertex[i].insert(78);
				SetVertex[i].insert(76);
				SetVertex[i].insert(38);
				SetVertex[i].insert(39);
			}
			if(pc[i].start_vertex == 9)
			{
				SetVertex[i].erase(8) ;
			}
			else if(pc[i].start_vertex == 251)
			{
				SetVertex[i].insert(200);
				SetVertex[i].insert(205);
				SetVertex[i].insert(206);
				SetVertex[i].insert(155);
			}
			else if(pc[i].start_vertex == 82)
			{
				SetVertex[i].insert(55);
				SetVertex[i].insert(53);
				SetVertex[i].insert(86);
				//	SetVertex[i].insert();
			}
			else if(pc[i].start_vertex == 26)
			{
				SetVertex[i].erase(6);
				
			}else if( pc[i].start_vertex == 296)
			{
				
				SetVertex[i].insert(297);
			}else if( pc[i].start_vertex == 76)
			{
				SetVertex[i].insert(78);
				SetVertex[i].insert(76);
				SetVertex[i].insert(38);
				SetVertex[i].insert(39);
			}
			else if( pc[i].start_vertex == 34)
			{
				SetVertex[i].insert(1);
				SetVertex[i].insert(20);
			}else if(pc[i].start_vertex == 85)
			{
				SetVertex[i].insert(85);
				SetVertex[i].insert(78);
			}else if(pc[i].start_vertex == 122)
			{
				SetVertex[i].insert(147);
				SetVertex[i].insert(135);
				SetVertex[i].insert(307);
				SetVertex[i].insert(140);
			}else if(pc[i].start_vertex == 70)
			{
				SetVertex[i].insert(72);
				SetVertex[i].insert(88);
			}else if(pc[i].start_vertex == 34)
			{
				SetVertex[i].insert(38);
				SetVertex[i].insert(39);
			}else if(pc[i].start_vertex == 302)
			{
				SetVertex[i].insert(302);
				SetVertex[i].insert(293);
			}
			else if(pc[i].start_vertex == 105)
			{
				SetVertex[i].insert(105);
				SetVertex[i].insert(86);
				SetVertex[i].insert(89);
			}
			else if(pc[i].start_vertex == 35)
			{
				SetVertex[i].insert(76);
				SetVertex[i].insert(80);
				SetVertex[i].insert(39);
				SetVertex[i].insert(38);
				SetVertex[i].insert(35);
			}
			
			
		}
	}
	
	/*	int v[20] ;
	for( i = 0 ; i < pccnt ; i++ )
	{
	v[i] = pc[i].start_vertex ;
	}
	
	  
		PCGroup pcg( pccnt , v );
		ofstream pcgout("pcgtest.txt");
		pcg.ResetEnvior();
		pcg.GetRate();
		pcg.Output(pcgout);*/	
		CAR_LEN = 2000; 
		
}

void CNprogDlg::OnBtnGenu() 
{
	PCGroup pcg;
	pcg.carcnt = pccnt ;
	int vertex[30];// = {2,14,22,25,58,78,79,130,140,174,196,215,255,277,291,307} ; 
	int i ; 
	for( i = 0 ; i < pccnt ; i++ )
	{
		vertex[i] = pc[i].start_vertex + 1  ; 
	}
	for( i = 0 ; i < pcg.carcnt ; i++ )
	{
		pcg.vertex[i] = vertex[i] ; 
	}
	pcg.ResetEnvior();
	pcg.GetRate();
	
	ofstream out("新遗传算法.txt");
	GenuGroup gg(pcg ) ;
	for( i = 0 ; i < 100 ; i++ )
	{
		gg.Evolution();
		gg.Output(out);
	}
	MessageBox("ok");
	
	
	/*	time_t ltime;
	time( &ltime ); 
	srand(ltime);
	PCGroup rpcg ;
	PetrolCar rpc[14] ;
	
	  set<int> s_i[14] ; 
	  for( i = 0 ; i < 16 ; i++ )
	  {
	  int j ;
	  for( j = 0 ; j< pc[i].v_way.size() ; j++  )
	  {
	  int k ; 
	  for( k = 0 ; k < pc[i].v_way[j].v_vertex.size() ; k++ )
	  {
	  s_i[i].insert(pc[i].v_way[j].v_vertex[k]);
	  }
	  }
	  }
	  
		vector<int> v_i[16];
		set<int>::iterator itr ;
		ofstream outt("vertex.txt") ; 
		for( i = 0 ; i < 16 ; i++ )
		{		
		outt<<i<<endl;
		for( itr = s_i[i].begin() ; itr != s_i[i].end() ; itr++ )
		{
		v_i[i].push_back(*itr);
		outt<<*itr<<"\t";
		}
		outt<<endl;
		outt<<v_i[i].size()<<endl;
		}
		
		  
			ofstream out("完全随机算法结果.txt");
			int j ;
			rpcg.carcnt = 16 ; 
			for( i = 0 ; i < 1000 ; i++ )
			{ 	
			for( j = 0 ; j < 16 ; j++ )
			{
			rpcg.vertex[j] = v_i[j][ rand()%v_i[j].size()  ] ;
			}
			out<<i<<endl;
			
			  rpcg.ResetEnvior();
			  rpcg.GetRate();
			  rpcg.Output(out);
			  }
	*/
	
	
	
	
	/*
	
	  int i , j ; 
	  ofstream out("totaldistance.txt");
	  int total = 0 ; 
	  for( i = 0 ; i < SIZE ; i++ )
	  {
	  for( j = i ; j < SIZE ; j++ )
	  {
	  if(road[i][j].length!=0)
	  {
	  total += road[i][j].length ;
	  }
	  }
	  }
	out<<total<<"\n" ;*/
	
}
ofstream out("out.txt") ;
ofstream cntout("次数.txt");
ofstream cvout("节点-覆盖率.txt") ;
ofstream tmout("节点时间.txt");
ofstream sdout("standard.txt");
void CNprogDlg::OnBtnForward() 
{
	int ttt ;
	int rrrrr  = 0 ; 
	int pretime = 1 ;	
	
	POINT pos[5] ;
	int i;
		for( i = 0 ; i< 5 ; i++)
		{
			pos[i].x = rand()%308 ;
			pos[i].y = vertex[pos[i].x].next[rand()%vertex[pos[i].x].cnt];
		}
		static int cir = 10000;
		cir = 90000 ; 
	while( pc[0].totallen < cir )
	{
		rrrrr ++ ;
		int i , j , k ;
		int minpos = 0 , minlen = 8000 ;
		
		int len  ; 
		static int s = 0 ;
		ResetEnvior();
		CClientDC dc(this) ;
		//DrawGraph(&dc) ; 
		if( s == 0 )
		{
			for( i = 0 ; i <pccnt ; i++ )
			{
				crtpc = i ;
				pc[i].GetNextVertex( SetVertex[i] );
				pc[i].ClearWay();
				pc[i].SerachWay();
				pc[i].DrawWay(&dc,i);
			}
			s++ ; 
		}
		
	
		//	ResetEnvior();
		
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
		crtpc = minpos ; 	
		
		for( i = 0 ; i < pccnt ; i++ )
		{
			if(i != minpos)
			{
				pc[i].crt_len += minlen ;
			}
		}
		pc[0].totallen += minlen ;
		
		pc[minpos].GetNextVertex(SetVertex[minpos]);
	
		ResetEnvior();
			for( i = 0  ; i < pccnt ; i++)
		{
			pc[i].ClearWay();
			pc[i].SerachWay();
			crtpc = i ;
			pc[i].DrawWay(&dc , i  );
			out<<s<<"\t"<<i<<"\t"<<pc[i].crt_vertex<<"\t"<<pc[i].next_vertex<<endl;
		}		
	
		if( pc[0].totallen/333 +1 == pretime  )
		{
			sdout<<pretime-1; 
				for( i = 0 ; i < pccnt ; i++ )
				{
					sdout<<",("<<pc[i].pos.x<<","<<pc[i].pos.y<<")";
				}
				sdout<<endl;
				pretime ++ ;
	
		for( i = 0 ; i < pccnt ; i++ )
		{
			for( j = 0 ; j < 5 ; j++ )
			{
				if(pc[i].crt_vertex == pos[j].x && pc[i].next_vertex == pos[j].y || 
					pc[i].crt_vertex == pos[j].y&& pc[i].next_vertex == pos[j].x 
					)
				{
					tmout<<pc[0].totallen/333<<"\t"<<pos[j].x+1<<"\t"<<pos[j].y+1<<endl;
				}
			}
		}
	}

	
		float f = CoverRate();
		static int ratecnt = 0  ;
		static float averrate = 0  ;
		if(pc[0].totallen > 10000 && f > 0.91)
			return ;
			
		
		averrate = (averrate * ratecnt + f)/(ratecnt+1);ratecnt ++ ; 
		m_coverrate.Format("覆盖率%f-车辆数%d" , f ,pccnt ) ; 
		UpdateData(FALSE) ;
		cvout<<"节点"<<rrrrr<<"覆盖率	"<<f<<endl;

			
	}		
	int j;
	for( i = 0 ; i <VERTEX_SIZE ;i++ )
	{
		for( j = 0 ; j < VERTEX_SIZE ; j++ )
		{
			if(road[i][j].length != 0 )
			{	
				int c = passcnt[i][j];
				cntout<<i+1<<"\t"<<j+1<<"\t"<<c<<endl;
			}
		}
	}
	
}
ofstream tout("time-pos.txt") ; 

void CNprogDlg::OnBtnTime() 
{
	static int time = 0 ; 
	
	int i ; 
	for ( i = 0 ; i < pccnt ; i++ )
	{
		pc[i].GetNextVertex( SetVertex[i]) ; 
	}
	
	for( time = 0 ; time < 240 ; time ++ )
	{
		int vi , vj ;
		
		int  minpos=0 , minlen=10000 ;
		for( i = 0 ; i < pccnt ; i++ )
		{
			pc[i].crt_len += 333 ;
		}
		
		do
		{
			minlen = 10000 ;
			minpos = 0 ;
			for( i = 0 ; i < pccnt ; i++ )
			{
				vi = pc[i].crt_vertex ;
				vj = pc[i].next_vertex ;
				
				if( road[vi][vj].length - pc[i].crt_len < minlen )
				{
					minlen = road[vi][vj].length - pc[i].crt_len ;
					minpos = i ; 
				}
			}
			if( minlen < 0 )
			{
				pc[minpos].GetNextVertex(SetVertex[minpos]);
			}
			for( i = 0 ; i < pccnt ; i++ )
			{
				if( i!= minpos )
				{
					pc[i].crt_len += minlen ;
				}
				else
				{
					pc[i].crt_len = - minlen ;
				}
			}
		}while( minlen < 0 );
		
		
		ResetEnvior();
		CClientDC dc(this) ;	
		tout<<time;
		for( i = 0  ; i < pccnt ; i++)
		{
			pc[i].ClearWay();
			pc[i].SerachWay();
			crtpc = i ; 
			pc[i].DrawWay(&dc , i  );
			tout<<",("<<pc[i].pos.x<<","<<pc[i].pos.y<<")";
		}	
		tout<<endl;
		
		float f = CoverRate();
		cvout<<"覆盖率\t"<<f<<endl;	
	}	
	

}

RandomGroup rpc[1000] ;
void CNprogDlg::OnBtnBack() 
{
	CClientDC dc(this);
	
	int crtindex = 0 ;
	float rate ;
	rate = 0.5 ;
	bool rtn ;
	rpc[0]= RandomGroup(1);
	int j , i  ;
	for( i = 1 ; i < pccnt ; i++ )
	{
		rpc[i] = rpc[0] ;
		int vi ;
		rpc[i].ipc = i ; 
		vi = rpc[i].pc[i].crt_vertex;
		
		for( j = 0 ; j < vertex[vi].cnt ; j++  )
		{
			rpc[i].dir[j] = vertex[vi].next[j] ;
		}
		rpc[i].dircnt = vertex[vi].cnt ;
		rpc[i].crtdir = 0 ; 
	}
	rpc[0].Go();
	rate = rpc[0].GetRate(&dc);
	rpc[1] = rpc[0 ] ;
	
	ofstream out("回溯.txt");
	RandomGroup p ;
	
	
	crtindex = 19 ;
	while( crtindex >= 19 || rpc[crtindex].totallen < 80000 )
	{
		i = crtindex ;
		
		if( rpc[i].crtdir < rpc[i].dircnt )
		{
			rpc[ i + 1 ] = rpc[i].Go(  ) ; 
		}
		else
		{
			out<<"nomore back "<<"\t";
			crtindex -- ;
			continue;
		}
		
		rpc[i+1].Output(out);
		rate =  rpc[i+1].GetRate(&dc) ;
		
		if( rate < 0.90 )
		{
			crtindex -- ;
			out<<"small rate back "<<endl;
			continue;
		}
		
		crtindex++;
	}
	out<<"完成\t"<<crtindex<<endl;
	
}

void CNprogDlg::OnButton1() 
{
	ofstream road("路线.txt") ;
	 int i , j ;
	for( i = 0 ; i< pccnt ; i++ )
	{
		road<<pc[i].start_vertex<<pc[i].pathcnt<<endl;
		for(  j = 0 ; j < pc[i].pathcnt ; j++ )
		{
			road<<path[i][j]<<"   " ;
		}
		road<<endl;
	}
	road.close();
}

void CNprogDlg::OnButton2() 
{
	int i ;
	set<int>::iterator itr , itr2;
	int max , min ;
	int cnt ;
	float rate[50] ;
	ofstream outrate("比率方差.txt");
	max = 0 ;
	float w[100] , total;
	int icnt=0 ; ;
	for(i = 0 ; i <pccnt ; i++)
	{
		total = 0 ;
		icnt = 0 ;
		for(itr = SetVertex[i].begin();itr!=SetVertex[i].end();itr++)
		{
			itr2 = itr ;
			for( itr2 ++ ; itr2 != SetVertex[i].end() ; itr2++)
			{
				if( road[*itr][*itr2].length != 0 )
				{
					cnt = passcnt[*itr][*itr2] +  passcnt[*itr2][*itr];
					
				//	if(cnt <= 16 )
					{
						w[icnt] = cnt ;
						total += cnt ;
						icnt ++ ;
						if(max < cnt )
							max = cnt ;
					}
				}
			}
		}

		rate[i] = 0;
		int j;
		outrate<<endl;

		total = 0 ;
		for( j = 0 ; j < icnt ; j++ )
		{
			total +=(w[j]/=max);
		}
			
		for( j = 0 ; j < icnt ; j++ )
		{
			rate[i] += (w[j] - float(total)/float(icnt) ) * (w[j] - float(total)/float(icnt) ) ;
		}
		rate[i]/=icnt ;
		outrate<<pc[i].start_vertex + 1 <<"	"<<rate[i]<<endl;
	}

}
