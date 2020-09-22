VERSION 5.00
Object = "{248DD890-BB45-11CF-9ABC-0080C7E7B78D}#1.0#0"; "MSWINSCK.OCX"
Begin VB.Form Form1 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Connecting to a SOCKS4 server."
   ClientHeight    =   3750
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   7110
   Icon            =   "Form1.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   3750
   ScaleWidth      =   7110
   StartUpPosition =   3  'Windows Default
   Begin MSWinsockLib.Winsock Socket 
      Left            =   165
      Top             =   3165
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   393216
   End
   Begin VB.CommandButton cmdConnect 
      Caption         =   "Connect"
      Height          =   480
      Left            =   5670
      TabIndex        =   8
      Top             =   2385
      Width           =   1125
   End
   Begin VB.TextBox Text1 
      Alignment       =   2  'Center
      BackColor       =   &H0080C0FF&
      Height          =   270
      Index           =   3
      Left            =   5340
      MaxLength       =   5
      TabIndex        =   6
      Text            =   "6667"
      Top             =   1560
      Width           =   1680
   End
   Begin VB.TextBox Text1 
      Alignment       =   2  'Center
      BackColor       =   &H0080C0FF&
      Height          =   270
      Index           =   2
      Left            =   3510
      TabIndex        =   4
      Text            =   "62.235.13.228"
      Top             =   1560
      Width           =   1680
   End
   Begin VB.TextBox Text1 
      Alignment       =   2  'Center
      BackColor       =   &H0080C0FF&
      Height          =   270
      Index           =   1
      Left            =   1830
      MaxLength       =   5
      TabIndex        =   2
      Text            =   "1080"
      Top             =   1575
      Width           =   1500
   End
   Begin VB.TextBox Text1 
      BackColor       =   &H0080C0FF&
      Height          =   270
      Index           =   0
      Left            =   15
      TabIndex        =   0
      Text            =   "213.142.138.139"
      Top             =   1575
      Width           =   1680
   End
   Begin VB.Label Label1 
      BackColor       =   &H00FFFFFF&
      Caption         =   "Destination Port"
      Height          =   225
      Index           =   3
      Left            =   5370
      TabIndex        =   7
      Top             =   1140
      Width           =   1470
   End
   Begin VB.Label Label1 
      BackColor       =   &H00FFFFFF&
      Caption         =   "Destination IP"
      Height          =   225
      Index           =   2
      Left            =   3540
      TabIndex        =   5
      Top             =   1155
      Width           =   1470
   End
   Begin VB.Label Label1 
      BackColor       =   &H00FFFFFF&
      Caption         =   "Socks4 port"
      Height          =   225
      Index           =   1
      Left            =   1860
      TabIndex        =   3
      Top             =   1155
      Width           =   1470
   End
   Begin VB.Label Label1 
      BackColor       =   &H00FFFFFF&
      Caption         =   "Socks4  IP"
      Height          =   225
      Index           =   0
      Left            =   45
      TabIndex        =   1
      Top             =   1155
      Width           =   1470
   End
   Begin VB.Image Image1 
      Height          =   3780
      Left            =   -30
      Picture         =   "Form1.frx":0442
      Stretch         =   -1  'True
      Top             =   -30
      Width           =   7155
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'CODE IS MADE BY PANAGIOTIS GATZOULIS _
 FOr anything you want send feedback to PSC _
 If you dont like my programming style come clean
 
 
 
 Dim ConnectHeader(9) As Byte      'READ DOWN Bytes...Sock.....


Private Sub cmdConnect_Click()
                                  'Bytes...Socks4 servers dont understand string type _
                                   we should send data in byte format.We need a 9 bytes array
                                   


ConnectHeader(0) = 4               '4 and 1.I pass these data in the array accordinng to the pro _
                                   tocol which can be found here : http://archive.socks.permeo.com/protocol/socks4.protocol _
                                   Four says that the socks version is 4 and 1 represents the CONNECT command
ConnectHeader(1) = 1


                                   'It is ok now.Server knows that we are using socks4 proto and that we want to _
                                   establish a connection.But server doesnt know where we want it to connect.After _
                                   sending the last stuff we should send the remote port number.BEcause one byte _
                                   accept values between 0 - 255  and port numbers are >255 we need 2 bytes to send the _
                                   port number.However it is not very easy for beginners.!!!!Important!!!!If port number _
                                   is 6667 we wont send ConnectHeader(2)=66 and ConnectHeader(3)=67 !!!!Because accrding the _
                                   binary stuff the server will connect to the port 16963!!!!@@.if you dont know how to convert _
                                   binaries values to Decimal visit http://www.learnbinary.com/Binary2Dec.html before reading these comments _
                                   Assuming you know these stuff i am gonna write and example.
                                      'Port Number 6667

                                        '1 Byte            2 byte _
 _
                                        00011010           00001011 _
_
                'POWERS                 ^^^^^^^^           ^^^^^^^^ _
                           15,14,13,12,11,10,9,8           76543210


'Ok now. Assuming you know how to make the conversions
         'Firtst Byte                                     'Second byte
    '  |1* 2 ^12 + 1* 2 ^11 +  1 * 2 ^ 9| + | 1* 2 ^3 + 1 * 2 ^1 + 1 * 2 ^ 0 | =6667
    
    
    'What we have to send is to send these 2 bytes but EACH one with powers 0-7
    
    'The 1rst Byte with powers 0-7 has a value 26 and the second
    'So ConnectHeader(2)=26
    'So ConnectHeader(3)=11
 
 
 'Confused?No dont worry Server will multiply the 1rts byte with powers 8 -15 or it will multiply the 1rtst byte by 256 and the second with 1
'Server will do this Port = 256 * ByteIncome(4) + ByteIncome(6)
'So i am going to Convert the port number into Binary and afterwards find the decimal value of each one

RPort = Val(Text1(3).Text)
 If RPort = 0 Then Me.Caption = "No Destport": Exit Sub
Do Until Spcount = 16     '8 + 8 bits
Spcount = Spcount + 1

If RPort > 0 Then
ts = RPort Mod 2                 'Nothing weird here if you know how to convert these stuff
                                   'www.learnbinary.com

RPort = Int(RPort / 2)

Else

ts = 0
End If
If Spcount > 8 Then
bin2 = ts & bin2       'Byte 2
Else
bin = ts & bin    'Byte 1
End If


Loop


ConnectHeader(2) = Bin2Dec(bin2)

ConnectHeader(3) = Bin2Dec(bin)




                                     'Server now has enough information but it still needs the Remote ip Adress _

                                     
                                    'Luckily Because ip ranges are between 0 -255 we dont have to do difficult stuff _
                                    I will split the IP and i will add each part into a byte var

IPpart = Split(Text1(2).Text, ".")

If UBound(IPpart) = 3 Then

ConnectHeader(4) = IPpart(0)
ConnectHeader(5) = IPpart(1)
ConnectHeader(6) = IPpart(2)
ConnectHeader(7) = IPpart(3)

ConnectHeader(8) = 0

Else

Me.Caption = "FAIL"
Exit Sub
End If



                                      'OUR array is ready.Now we have to connect to the socks4 proxy server and send the
                                      'byte arrray.My monkey understood the following code
                                      
                                      
 Socket.Connect Text1(0).Text, Val(Text1(1).Text)
 
 
End Sub


Function Bin2Dec(Bstring) As Byte

For i = 8 To 1 Step -1

a = Mid(Bstring, i, 1)

t = t + a * 2 ^ p
p = p + 1
Next i

Bin2Dec = t

End Function

Private Sub Form_Unload(Cancel As Integer)
End
End Sub

Private Sub Socket_Connect()
Socket.SendData ConnectHeader
DonData.Show
End Sub

Private Sub Socket_DataArrival(ByVal bytesTotal As Long)
Dim data As String
Socket.GetData data

DonData.Text2.Text = DonData.Text2.Text & data
End Sub
