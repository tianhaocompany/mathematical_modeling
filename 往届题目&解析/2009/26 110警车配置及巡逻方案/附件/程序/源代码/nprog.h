// nprog.h : main header file for the NPROG application
//

#if !defined(AFX_NPROG_H__38B57F4E_3D72_46D8_B7A4_78196DA7C4D2__INCLUDED_)
#define AFX_NPROG_H__38B57F4E_3D72_46D8_B7A4_78196DA7C4D2__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#ifndef __AFXWIN_H__
	#error include 'stdafx.h' before including this file for PCH
#endif

#include "resource.h"		// main symbols

/////////////////////////////////////////////////////////////////////////////
// CNprogApp:
// See nprog.cpp for the implementation of this class
//

class CNprogApp : public CWinApp
{
public:
	CNprogApp();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CNprogApp)
	public:
	virtual BOOL InitInstance();
	//}}AFX_VIRTUAL

// Implementation

	//{{AFX_MSG(CNprogApp)
		// NOTE - the ClassWizard will add and remove member functions here.
		//    DO NOT EDIT what you see in these blocks of generated code !
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};


/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_NPROG_H__38B57F4E_3D72_46D8_B7A4_78196DA7C4D2__INCLUDED_)
