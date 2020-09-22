VERSION 5.00
Begin VB.Form DonData 
   Caption         =   "Form2"
   ClientHeight    =   5115
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   8010
   LinkTopic       =   "Form2"
   ScaleHeight     =   5115
   ScaleWidth      =   8010
   StartUpPosition =   3  'Windows Default
   Begin VB.Frame Frame2 
      Caption         =   "OUTcome"
      Height          =   4905
      Left            =   4170
      TabIndex        =   1
      Top             =   105
      Width           =   3600
      Begin VB.CheckBox Check1 
         Caption         =   "INCLUDE VBCRLF"
         Height          =   480
         Left            =   2415
         TabIndex        =   3
         Top             =   1950
         Width           =   1065
      End
      Begin VB.TextBox Text1 
         Height          =   285
         Left            =   75
         TabIndex        =   2
         Text            =   "Text1"
         Top             =   1650
         Width           =   3405
      End
      Begin VB.Label Label1 
         Caption         =   "Type what you want to send and hit the enter key"
         Height          =   510
         Left            =   180
         TabIndex        =   4
         Top             =   765
         Width           =   2925
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "INCOME"
      Height          =   4950
      Left            =   30
      TabIndex        =   0
      Top             =   45
      Width           =   4035
      Begin VB.TextBox Text2 
         Height          =   4470
         Left            =   195
         MultiLine       =   -1  'True
         ScrollBars      =   3  'Both
         TabIndex        =   5
         Top             =   270
         Width           =   3735
      End
   End
End
Attribute VB_Name = "DonData"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Text1_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then

If Check1.Value = 1 Then
Form1.Socket.SendData Text1.Text & vbCrLf
Else
Form1.Socket.SendData Text1.Text

End If
End If
End Sub
