// nprogDlg.h : header file
//

#if !defined(AFX_NPROGDLG_H__212D52CE_10FB_425E_8E2B_9DB9C81953C0__INCLUDED_)
#define AFX_NPROGDLG_H__212D52CE_10FB_425E_8E2B_9DB9C81953C0__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

/////////////////////////////////////////////////////////////////////////////
// CNprogDlg dialog

class CNprogDlg : public CDialog
{
// Construction
public:
	CNprogDlg(CWnd* pParent = NULL);	// standard constructor

// Dialog Data
	//{{AFX_DATA(CNprogDlg)
	enum { IDD = IDD_NPROG_DIALOG };
	CString	m_coverrate;
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CNprogDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	HICON m_hIcon;

	// Generated message map functions
	//{{AFX_MSG(CNprogDlg)
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	virtual void OnOK();
	afx_msg void OnBtnGenu();
	afx_msg void OnBtnForward();
	afx_msg void OnBtnTime();
	afx_msg void OnBtnBack();
	afx_msg void OnButton1();
	afx_msg void OnButton2();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_NPROGDLG_H__212D52CE_10FB_425E_8E2B_9DB9C81953C0__INCLUDED_)
