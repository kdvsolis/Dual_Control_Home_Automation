#line 1 "C:/Users/ADMIN/Desktop/Dual_Control_Home_Automation/Firmware/Dual_Control_Home_Automation.c"
sbit LCD_RS at RB2_bit;
sbit LCD_EN at RB3_bit;
sbit LCD_D7 at RB7_bit;
sbit LCD_D6 at RB6_bit;
sbit LCD_D5 at RB5_bit;
sbit LCD_D4 at RB4_bit;
sbit LCD_RS_Direction at TRISB2_bit;
sbit LCD_EN_Direction at TRISB3_bit;
sbit LCD_D7_Direction at TRISB7_bit;
sbit LCD_D6_Direction at TRISB6_bit;
sbit LCD_D5_Direction at TRISB5_bit;
sbit LCD_D4_Direction at TRISB4_bit;

void RelayController(int pinIndex, char* OutletStatus, int isFromSerial);

void main()
{
int i;
int isFromSerial = 0;
char OutletIndicator[10] = "OUTLETX:0";
int OutletStatusVal[10] = {0,0,0,0,0,0,0,0,0};
ADCON1 = 0x07;
CMCON = 0x07;

TRISA = 0x6F;
TRISE = 0x07;
TRISD = 0x00;
TRISC2_bit = 0;
PORTD = 0x00;

PWM1_Init(5000);
PWM1_Start();
UART1_Init(9600);
Lcd_Init();
Lcd_Cmd(_LCD_CLEAR);
Lcd_Cmd(_LCD_CURSOR_OFF);

for(i = 0; i < 8; i++)
{
 OutletIndicator[6] = 49 + i;
 Lcd_Out(i%4 + 1, i > 3? 12: 1, OutletIndicator);
}

while(1)
{
 if(UART1_Data_Ready())
 {
 i = UART1_Read() - 48;
 if(i < 8 && i > -1)
 isFromSerial = 1;
 else
 i = 0;
 }
 RelayController(i, OutletStatusVal, isFromSerial);
 if(isFromSerial)
 {
 i = 0;
 isFromSerial = 0;
 }
 else
 {
 i = (i + 1) % 8;
 }
}

}

void RelayController(int pinIndex, char* OutletStatus, int isFromSerial)
{
 if((PORTA >> pinIndex == 1 && pinIndex < 6) || isFromSerial)
 {
 Lcd_Out((pinIndex%4 + 1), 9 + ((pinIndex > 3)? 11 : 0), !OutletStatus[pinIndex]? "1" : "0");
 OutletStatus[pinIndex] = (OutletStatus[pinIndex] + 1)%2;
 PORTD ^= 1 << pinIndex;
 Delay_ms(250);
 }
 else if((PORTE >> (pinIndex - 6) == 1 && pinIndex > 5) || isFromSerial)
 {
 Lcd_Out((pinIndex%4 + 1), 20, !OutletStatus[pinIndex]? "1" : "0");
 OutletStatus[pinIndex] = (OutletStatus[pinIndex] + 1)%2;
 PORTD ^= 1 << pinIndex;
 Delay_ms(250);
 }
}
