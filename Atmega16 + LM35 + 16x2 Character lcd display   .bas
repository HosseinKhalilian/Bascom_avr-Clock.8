'======================================================================='

' Title: LCD Display Clock * Temp
' Last Updated :  04.2022
' Author : A.Hossein.Khalilian
' Program code  : BASCOM-AVR 2.0.8.5
' Hardware req. : Atmega16 + LM35 + 16x2 Character lcd display

'======================================================================='

$regfile = "m16def.dat"

Config Portb = Input
Config Lcd = 16 * 2
Config Lcdpin = Pin , Db4 = Portd.4 , Db5 = Portd.5 , Db6 = Portd.6 , Db7 = Portd.7 , Rs = Portd.3 , E = Portd.2
Config Timer2 = Timer , Async = On , Prescale = 128
Config Adc = Single , Prescaler = Auto

Dim _Sec As Byte
Dim _Min As Byte
Dim _Hour As Byte
Dim A As Word
Dim B As Byte

Deflcdchar 0 , 12 , 18 , 18 , 12 , 32 , 32 , 32 , 32
Deflcdchar 1 , 32 , 4 , 12 , 28 , 28 , 32 , 32 , 32
Deflcdchar 2 , 32 , 4 , 14 , 31 , 31 , 32 , 32 , 32
Deflcdchar 3 , 32 , 4 , 14 , 31 , 31 , 7 , 6 , 4
Deflcdchar 4 , 32 , 4 , 14 , 31 , 31 , 31 , 14 , 4
Deflcdchar 5 , 32 , 32 , 32 , 32 , 32 , 32 , 32 , 32


Start Adc
B = 1
Enable Interrupts
Enable Timer2

On Timer2 K
Start Timer2
Cls
Cursor Off

'-----------------------------------------------------------

Do

Loop

End

'-----------------------------------------------------------

K:

A = Getadc(0)
A = A / 2
Locate 2 , 1
Lcd "temp =" ; A ; Chr(0) ; "c   "
Locate 2 , 16
Lcd Chr(b)
Incr B
If B > 6 Then B = 1

''''''''''''''''''''''''''''''

Incr _Sec
If _Sec > 59 Then
   Incr _Min
   _Sec = 0
      If _Min > 59 Then
      Incr _Hour
      _Min = 0
      _Sec = 0
         If _Hour > 23 Then
            _Hour = 0
            _Sec = 0
            _Min = 0
         End If
    End If
End If
If Pinb.2 = 1 Then
  _Min = 0
Elseif Pinb.0 = 1 Then
   Incr _Min
     Elseif Pinb.1 = 1 Then
       Incr _Hour
       End If

Locate 1 , 1
If _Hour < 10 Then
   Lcd "0" ; _Hour ; ":"
Else
   Lcd _Hour ; ":"
End If
If _Min < 10 Then
   Lcd "0" ; _Min ; ":"
Else
   Lcd _Min ; ":"
End If
If _Min < 10 Then
   Lcd "0" ; _Min
Else
   Lcd _Min
End If

Return

'-----------------------------------------------------------