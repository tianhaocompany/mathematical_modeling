// floydDlg.cpp : 实现文件
//

#include "stdafx.h"
#include "floyd.h"
#include "floydDlg.h"
#include ".\floyddlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif


// 用于应用程序“关于”菜单项的 CAboutDlg 对话框

class CAboutDlg : public CDialog
{
public:
	CAboutDlg();

// 对话框数据
	enum { IDD = IDD_ABOUTBOX };

	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV 支持

// 实现
protected:
	DECLARE_MESSAGE_MAP()
};

CAboutDlg::CAboutDlg() : CDialog(CAboutDlg::IDD)
{
}

void CAboutDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
}

BEGIN_MESSAGE_MAP(CAboutDlg, CDialog)
END_MESSAGE_MAP()


// CfloydDlg 对话框



CfloydDlg::CfloydDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CfloydDlg::IDD, pParent)
	, m_Mess(_T(""))
	, m_Max(0)
{
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
}

void CfloydDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	DDX_Text(pDX, IDC_EDIT1, m_Mess);
	DDX_Text(pDX, IDC_EDIT2, m_Max);
}

BEGIN_MESSAGE_MAP(CfloydDlg, CDialog)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	//}}AFX_MSG_MAP
	ON_BN_CLICKED(IDC_BUTTON1, OnBnClickedButton1)
	ON_BN_CLICKED(IDC_BUTTON2, OnBnClickedButton2)
	ON_BN_CLICKED(IDC_BUTTON3, OnBnClickedButton3)
END_MESSAGE_MAP()


// CfloydDlg 消息处理程序

BOOL CfloydDlg::OnInitDialog()
{
	CDialog::OnInitDialog();

	// 将\“关于...\”菜单项添加到系统菜单中。

	// IDM_ABOUTBOX 必须在系统命令范围内。
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

	// 设置此对话框的图标。当应用程序主窗口不是对话框时，框架将自动
	//  执行此操作
	SetIcon(m_hIcon, TRUE);			// 设置大图标
	SetIcon(m_hIcon, FALSE);		// 设置小图标

	// TODO: 在此添加额外的初始化代码

	
	return TRUE;  // 除非设置了控件的焦点，否则返回 TRUE
}

void CfloydDlg::OnSysCommand(UINT nID, LPARAM lParam)
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

// 如果向对话框添加最小化按钮，则需要下面的代码
//  来绘制该图标。对于使用文档/视图模型的 MFC 应用程序，
//  这将由框架自动完成。

void CfloydDlg::OnPaint() 
{
	if (IsIconic())
	{
		CPaintDC dc(this); // 用于绘制的设备上下文

		SendMessage(WM_ICONERASEBKGND, reinterpret_cast<WPARAM>(dc.GetSafeHdc()), 0);

		// 使图标在工作矩形中居中
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// 绘制图标
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{
		CDialog::OnPaint();
	}
}

//当用户拖动最小化窗口时系统调用此函数取得光标显示。
HCURSOR CfloydDlg::OnQueryDragIcon()
{
	return static_cast<HCURSOR>(m_hIcon);
}


void CfloydDlg::OnBnClickedButton1()
{
	// TODO: 在此添加控件通知处理程序代码
	CString path;
	ifstream infile;
	char data[1000];
	char Data1[20],Data2[20],Data3[20];	
	//int temp;
	static char BASED_CODE szBuffer[]=
		"Text files(*.txt)|*.txt|All files(*.*)|*.*||";
	//打开文档	
	MessageBox("请选择数据文档","打开数据文档",MB_OK);
	CFileDialog dlg(TRUE,NULL,NULL,NULL,szBuffer);
	if(dlg.DoModal()==IDOK)
	{
		path=dlg.GetPathName();
	}
	else
		return;
	infile.open(path);
	//初始化数组读取数据
	for (i=0;i<UP;i++)
	{
		for (j=0;j<UP;j++)
		{
			d[i][j]=Max;
			r[i][j]=0;
		}
		d[i][i]=0;
	}
	while (!infile.eof())
	{
		infile>>Data1;
		infile>>Data2;
		infile>>Data3;        
		if (atol(Data1)<UP && atol(Data2)<UP)
		{
			d[atol(Data1)][atol(Data2)]=atol(Data3);
			d[atol(Data2)][atol(Data1)]=atol(Data3);			
		}
		//if (atol(Data1)==74 && atol(Data2)<UP)
		//{
		//	d[atol(Data1)-74][atol(Data2)]=atol(Data3);
		//	d[atol(Data2)][atol(Data1)-74]=atol(Data3);
		//}		
	}
	for (i=LOW+1;i<UP;i++)
	{
		d[LOW][i]=d[0][i];
		d[i][LOW]=d[i][0];
	}
	infile.close();	
	
	//************************打开文件输出************************
	MessageBox("打开文件输出floyd结果","打开文件",MB_OK);
	CFileDialog dlg1(FALSE,NULL,NULL,NULL,szBuffer);
	if (dlg1.DoModal()==IDOK)
	{
		path=dlg1.GetPathName();
	}
	else
		return;
	ofstream outfile;
	outfile.open(path,ios::out|ios::trunc);

	//************************输出原始数据************************
	outfile<<"  ";
	for (i=LOW;i<UP;i++)
	{
		if (i==LOW)
		{
			outfile<<0<<" ";
		}
		else
		{
			outfile<<i<<" ";
		}
	}
	outfile<<endl;
	for (i=LOW;i<UP;i++)
	{
		if (i==LOW)
		{
			outfile<<0<<"     ";
		}
		else
		{
			outfile<<i<<"     ";
		}		
		for (j=LOW;j<UP;j++)
		{
			sprintf(data,"%7d",d[i][j]);
			outfile<<data<<" ";
		}
		outfile<<endl;
	}
	//for (i=0;i<UP;i++)
	//{
	//	for (j=i+1;j<UP;j++)
	//	{
	//		if (d[i][j]!=Max)
	//		{
	//			outfile<<i<<" "<<j<<" "<<d[i][j]<<endl;
	//		}			
	//	}
	//}
	//************************Froyd************************
	for(k=LOW;k<UP;k++)
	{
		for(i=LOW;i<UP;i++)
		{
			for(j=LOW;j<UP;j++)
			{
				if(d[i][k]+d[k][j]<d[i][j])
				{
					d[i][j]=d[i][k]+d[k][j];
					r[i][j]=k;
				}
			}
		}
	}

	//************************输出计算数据************************
	outfile<<"  ";
	for (i=LOW;i<UP;i++)
	{
		if (i==LOW)
		{
			outfile<<0<<" ";
		}
		else
		{
			outfile<<i<<" ";
		}
	}
	outfile<<endl;
	for (i=LOW;i<UP;i++)
	{
		if (i==LOW)
		{
			outfile<<0<<" ";
		}
		else
		{
			outfile<<i<<" ";
		}		
		for (j=LOW;j<UP;j++)
		{
			sprintf(data,"%d",d[i][j]);
			outfile<<data<<" ";
		}
		outfile<<endl;
	}	
	if (LOW!=0)
	{
		for (i=LOW;i<UP;i++)
		{
			outfile<<0<<" "<<i<<" "<<d[0][i]<<endl;
		}
	}
//***************************************************************
	//for (i=1;i<UP;i++)
	//{
	//	for (j=1;j<i+1;j++)
	//	{
	//		s[i][j]=d[0][i]+d[0][j]-d[i][j];
	//		if (i==j)
	//		{
	//			s[i][j]=0;
	//		}
	//		sprintf(data,"%d",s[i][j]);
	//		outfile<<data<<" ";
	//	}
	//	outfile<<endl;
	//}
	
	//for (i=LOW;i<UP;i++)
	//{
	//	for (j=i+1;j<UP;j++)
	//	{
	//		outfile<<i<<" "<<j<<" "<<d[i][j]<<endl;						
	//	}
	//}
	//************************路径输出************************
	for(i=LOW;i<UP;i++)
	{
		for(j=i+1;j<UP;j++)
		{	
			for(k=LOW;k<UP;k++)
			{
				w[k]=0;
			}
			w[i]=j;
			findway(i,j);
			if(i!=j)
			{	
				if (i==LOW)
				{
					sprintf(data,"%4d",0);
				}
				else
				{
					sprintf(data,"%4d",i);
				}				
				outfile<<data<<" ";
				k=i;
				while(k!=j)
				{
					if (w[k]==LOW)
					{
						sprintf(data,"%4d",0);
					}
					else
					{
						sprintf(data,"%4d",w[k]);
					}						
					outfile<<" "<<data;					
					k=w[k];
				}
				outfile<<endl;
			}
		}
		/*outfile<<endl;*/
	}
	outfile.close();
	//////////////////////////////////////////////////////////////////////////
	
}

void CfloydDlg::findway(int i, int j)
{
	int k;
	k=r[i][j];
	if (k!=0)
	{
		w[k]=w[i];
		w[i]=k;
		findway(i,k);
		findway(k,j);
	}
}


void CfloydDlg::OnBnClickedButton2()
{
	// TODO: 在此添加控件通知处理程序代码
	static char BASED_CODE szBuffer[]=
		"Text files(*.txt)|*.txt|All files(*.*)|*.*||";
	CFileDialog dlg(TRUE,NULL,NULL,NULL,szBuffer);
	if(dlg.DoModal()==IDOK)
	{
		path22=dlg.GetPathName();
	}
	else
		return;
}

void CfloydDlg::OnBnClickedButton3()
{
	// TODO: 在此添加控件通知处理程序代码
	ifstream infile;
	infile.open(path22);
	char dataa[25];
	//for (i=0;i<UP;i++)
	//{
	//	RR[i]="888";
	//}
	i=0;
	while (!infile.eof())
	{
		infile>>dataa;
		if (dataa=="D")
		{
			RR[i]=0;
		}
		else if (dataa=="X1")
		{
			RR[i]=74;
		}
		else if (dataa=="X2")
		{
			RR[i]=75;
		}
		else if (dataa=="X3")
		{
			RR[i]=76;
		}
		else if (dataa=="X4")
		{
			RR[i]=77;
		}
		else if (dataa=="X5")
		{
			RR[i]=78;
		}
		else
		{
			RR[i]=atol(dataa);
		}
		i=i+1;
	}
	
}
