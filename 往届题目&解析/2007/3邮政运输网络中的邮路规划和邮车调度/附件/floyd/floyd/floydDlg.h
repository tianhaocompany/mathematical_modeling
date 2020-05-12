// floydDlg.h : 头文件

#pragma once
#include "atlcomtime.h"
#include "afxwin.h"
#include <afxtempl.h>
#include <fstream>
#include <iostream>
using namespace std;
#define LOW 0
#define UP 79
#define Max 99999

// CfloydDlg 对话框
class CfloydDlg : public CDialog
{
// 构造
public:
	CfloydDlg(CWnd* pParent = NULL);	// 标准构造函数

// 对话框数据
	enum { IDD = IDD_FLOYD_DIALOG };

	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV 支持


// 实现
protected:
	HICON m_hIcon;

	// 生成的消息映射函数
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	DECLARE_MESSAGE_MAP()
public:
	CString m_Mess;
	afx_msg void OnBnClickedButton1();
	int m_Max;
	int i,j,k;
	int d[UP][UP],r[UP][UP];
	void findway(int i, int j);
	int w[UP];
	int s[UP][UP];
	int RR[UP];
	CString path22;
	//struct Road 
	//{
	//	Road *head,*tail;
	//	int num;
	//}road[UP];
	afx_msg void OnBnClickedButton2();
	afx_msg void OnBnClickedButton3();
};
