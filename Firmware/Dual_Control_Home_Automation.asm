
_main:

;Dual_Control_Home_Automation.c,16 :: 		void main()
;Dual_Control_Home_Automation.c,19 :: 		int isFromSerial = 0;
	CLRF       main_isFromSerial_L0+0
	CLRF       main_isFromSerial_L0+1
	MOVLW      79
	MOVWF      main_OutletIndicator_L0+0
	MOVLW      85
	MOVWF      main_OutletIndicator_L0+1
	MOVLW      84
	MOVWF      main_OutletIndicator_L0+2
	MOVLW      76
	MOVWF      main_OutletIndicator_L0+3
	MOVLW      69
	MOVWF      main_OutletIndicator_L0+4
	MOVLW      84
	MOVWF      main_OutletIndicator_L0+5
	MOVLW      88
	MOVWF      main_OutletIndicator_L0+6
	MOVLW      58
	MOVWF      main_OutletIndicator_L0+7
	MOVLW      48
	MOVWF      main_OutletIndicator_L0+8
	CLRF       main_OutletIndicator_L0+9
	CLRF       main_OutletStatusVal_L0+0
	CLRF       main_OutletStatusVal_L0+1
	CLRF       main_OutletStatusVal_L0+2
	CLRF       main_OutletStatusVal_L0+3
	CLRF       main_OutletStatusVal_L0+4
	CLRF       main_OutletStatusVal_L0+5
	CLRF       main_OutletStatusVal_L0+6
	CLRF       main_OutletStatusVal_L0+7
	CLRF       main_OutletStatusVal_L0+8
	CLRF       main_OutletStatusVal_L0+9
	CLRF       main_OutletStatusVal_L0+10
	CLRF       main_OutletStatusVal_L0+11
	CLRF       main_OutletStatusVal_L0+12
	CLRF       main_OutletStatusVal_L0+13
	CLRF       main_OutletStatusVal_L0+14
	CLRF       main_OutletStatusVal_L0+15
	CLRF       main_OutletStatusVal_L0+16
	CLRF       main_OutletStatusVal_L0+17
	CLRF       main_OutletStatusVal_L0+18
	CLRF       main_OutletStatusVal_L0+19
;Dual_Control_Home_Automation.c,22 :: 		ADCON1 = 0x07; // All AtoD pins on PORTA to digital
	MOVLW      7
	MOVWF      ADCON1+0
;Dual_Control_Home_Automation.c,23 :: 		CMCON = 0x07; // Disable Comparators
	MOVLW      7
	MOVWF      CMCON+0
;Dual_Control_Home_Automation.c,25 :: 		TRISA = 0x6F;
	MOVLW      111
	MOVWF      TRISA+0
;Dual_Control_Home_Automation.c,26 :: 		TRISE = 0x07;
	MOVLW      7
	MOVWF      TRISE+0
;Dual_Control_Home_Automation.c,27 :: 		TRISD = 0x00;
	CLRF       TRISD+0
;Dual_Control_Home_Automation.c,28 :: 		TRISC2_bit = 0;
	BCF        TRISC2_bit+0, BitPos(TRISC2_bit+0)
;Dual_Control_Home_Automation.c,29 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;Dual_Control_Home_Automation.c,31 :: 		PWM1_Init(5000);
	BSF        T2CON+0, 0
	BCF        T2CON+0, 1
	MOVLW      249
	MOVWF      PR2+0
	CALL       _PWM1_Init+0
;Dual_Control_Home_Automation.c,32 :: 		PWM1_Start();
	CALL       _PWM1_Start+0
;Dual_Control_Home_Automation.c,33 :: 		UART1_Init(9600);               // Initialize UART module at 9600 bps
	MOVLW      129
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;Dual_Control_Home_Automation.c,34 :: 		Lcd_Init();// Initialize LCD
	CALL       _Lcd_Init+0
;Dual_Control_Home_Automation.c,35 :: 		Lcd_Cmd(_LCD_CLEAR);// Clear Display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Dual_Control_Home_Automation.c,36 :: 		Lcd_Cmd(_LCD_CURSOR_OFF); // Cursor Off
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;Dual_Control_Home_Automation.c,38 :: 		for(i = 0; i < 8; i++)
	CLRF       main_i_L0+0
	CLRF       main_i_L0+1
L_main0:
	MOVLW      128
	XORWF      main_i_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main39
	MOVLW      8
	SUBWF      main_i_L0+0, 0
L__main39:
	BTFSC      STATUS+0, 0
	GOTO       L_main1
;Dual_Control_Home_Automation.c,40 :: 		OutletIndicator[6] = 49 + i;
	MOVF       main_i_L0+0, 0
	ADDLW      49
	MOVWF      main_OutletIndicator_L0+6
;Dual_Control_Home_Automation.c,41 :: 		Lcd_Out(i%4 + 1, i > 3? 12: 1, OutletIndicator);
	MOVLW      4
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       main_i_L0+0, 0
	MOVWF      R0+0
	MOVF       main_i_L0+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	INCF       R0+0, 0
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      main_i_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main40
	MOVF       main_i_L0+0, 0
	SUBLW      3
L__main40:
	BTFSC      STATUS+0, 0
	GOTO       L_main3
	MOVLW      12
	MOVWF      ?FLOC___mainT7+0
	GOTO       L_main4
L_main3:
	MOVLW      1
	MOVWF      ?FLOC___mainT7+0
L_main4:
	MOVF       ?FLOC___mainT7+0, 0
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      main_OutletIndicator_L0+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Dual_Control_Home_Automation.c,38 :: 		for(i = 0; i < 8; i++)
	INCF       main_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       main_i_L0+1, 1
;Dual_Control_Home_Automation.c,42 :: 		}
	GOTO       L_main0
L_main1:
;Dual_Control_Home_Automation.c,44 :: 		while(1)
L_main5:
;Dual_Control_Home_Automation.c,46 :: 		if(UART1_Data_Ready())
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main7
;Dual_Control_Home_Automation.c,48 :: 		i = UART1_Read() - 48;
	CALL       _UART1_Read+0
	MOVLW      48
	SUBWF      R0+0, 0
	MOVWF      R1+0
	CLRF       R1+1
	BTFSS      STATUS+0, 0
	DECF       R1+1, 1
	MOVF       R1+0, 0
	MOVWF      main_i_L0+0
	MOVF       R1+1, 0
	MOVWF      main_i_L0+1
;Dual_Control_Home_Automation.c,49 :: 		if(i < 8 && i > -1)
	MOVLW      128
	XORWF      R1+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main41
	MOVLW      8
	SUBWF      R1+0, 0
L__main41:
	BTFSC      STATUS+0, 0
	GOTO       L_main10
	MOVLW      127
	MOVWF      R0+0
	MOVLW      128
	XORWF      main_i_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main42
	MOVF       main_i_L0+0, 0
	SUBLW      255
L__main42:
	BTFSC      STATUS+0, 0
	GOTO       L_main10
L__main33:
;Dual_Control_Home_Automation.c,50 :: 		isFromSerial = 1;
	MOVLW      1
	MOVWF      main_isFromSerial_L0+0
	MOVLW      0
	MOVWF      main_isFromSerial_L0+1
	GOTO       L_main11
L_main10:
;Dual_Control_Home_Automation.c,52 :: 		i = 0;
	CLRF       main_i_L0+0
	CLRF       main_i_L0+1
L_main11:
;Dual_Control_Home_Automation.c,53 :: 		}
L_main7:
;Dual_Control_Home_Automation.c,54 :: 		RelayController(i, OutletStatusVal, isFromSerial);
	MOVF       main_i_L0+0, 0
	MOVWF      FARG_RelayController_pinIndex+0
	MOVF       main_i_L0+1, 0
	MOVWF      FARG_RelayController_pinIndex+1
	MOVLW      main_OutletStatusVal_L0+0
	MOVWF      FARG_RelayController_OutletStatus+0
	MOVF       main_isFromSerial_L0+0, 0
	MOVWF      FARG_RelayController_isFromSerial+0
	MOVF       main_isFromSerial_L0+1, 0
	MOVWF      FARG_RelayController_isFromSerial+1
	CALL       _RelayController+0
;Dual_Control_Home_Automation.c,55 :: 		if(isFromSerial)
	MOVF       main_isFromSerial_L0+0, 0
	IORWF      main_isFromSerial_L0+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_main12
;Dual_Control_Home_Automation.c,57 :: 		i = 0;
	CLRF       main_i_L0+0
	CLRF       main_i_L0+1
;Dual_Control_Home_Automation.c,58 :: 		isFromSerial = 0;
	CLRF       main_isFromSerial_L0+0
	CLRF       main_isFromSerial_L0+1
;Dual_Control_Home_Automation.c,59 :: 		}
	GOTO       L_main13
L_main12:
;Dual_Control_Home_Automation.c,62 :: 		i = (i + 1) % 8;
	MOVF       main_i_L0+0, 0
	ADDLW      1
	MOVWF      R0+0
	MOVLW      0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      main_i_L0+1, 0
	MOVWF      R0+1
	MOVLW      8
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      main_i_L0+0
	MOVF       R0+1, 0
	MOVWF      main_i_L0+1
;Dual_Control_Home_Automation.c,63 :: 		}
L_main13:
;Dual_Control_Home_Automation.c,64 :: 		}
	GOTO       L_main5
;Dual_Control_Home_Automation.c,66 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_RelayController:

;Dual_Control_Home_Automation.c,68 :: 		void RelayController(int pinIndex, char* OutletStatus, int isFromSerial)
;Dual_Control_Home_Automation.c,70 :: 		if((PORTA >> pinIndex == 1 && pinIndex < 6) || isFromSerial)
	MOVF       FARG_RelayController_pinIndex+0, 0
	MOVWF      R0+0
	MOVF       PORTA+0, 0
	MOVWF      R1+0
	MOVF       R0+0, 0
L__RelayController44:
	BTFSC      STATUS+0, 2
	GOTO       L__RelayController45
	RRF        R1+0, 1
	BCF        R1+0, 7
	ADDLW      255
	GOTO       L__RelayController44
L__RelayController45:
	MOVF       R1+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L__RelayController37
	MOVLW      128
	XORWF      FARG_RelayController_pinIndex+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__RelayController46
	MOVLW      6
	SUBWF      FARG_RelayController_pinIndex+0, 0
L__RelayController46:
	BTFSC      STATUS+0, 0
	GOTO       L__RelayController37
	GOTO       L__RelayController36
L__RelayController37:
	MOVF       FARG_RelayController_isFromSerial+0, 0
	IORWF      FARG_RelayController_isFromSerial+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__RelayController36
	GOTO       L_RelayController18
L__RelayController36:
;Dual_Control_Home_Automation.c,72 :: 		Lcd_Out((pinIndex%4 + 1), 9 + ((pinIndex > 3)? 11 : 0), !OutletStatus[pinIndex]? "1" : "0");
	MOVLW      4
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FARG_RelayController_pinIndex+0, 0
	MOVWF      R0+0
	MOVF       FARG_RelayController_pinIndex+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	INCF       R0+0, 0
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      FARG_RelayController_pinIndex+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__RelayController47
	MOVF       FARG_RelayController_pinIndex+0, 0
	SUBLW      3
L__RelayController47:
	BTFSC      STATUS+0, 0
	GOTO       L_RelayController19
	MOVLW      11
	MOVWF      ?FLOC___RelayControllerT24+0
	GOTO       L_RelayController20
L_RelayController19:
	CLRF       ?FLOC___RelayControllerT24+0
L_RelayController20:
	MOVF       ?FLOC___RelayControllerT24+0, 0
	ADDLW      9
	MOVWF      FARG_Lcd_Out_column+0
	MOVF       FARG_RelayController_pinIndex+0, 0
	ADDWF      FARG_RelayController_OutletStatus+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_RelayController21
	MOVLW      ?lstr1_Dual_Control_Home_Automation+0
	MOVWF      ?FLOC___RelayControllerT31+0
	GOTO       L_RelayController22
L_RelayController21:
	MOVLW      ?lstr2_Dual_Control_Home_Automation+0
	MOVWF      ?FLOC___RelayControllerT31+0
L_RelayController22:
	MOVF       ?FLOC___RelayControllerT31+0, 0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Dual_Control_Home_Automation.c,73 :: 		OutletStatus[pinIndex] = (OutletStatus[pinIndex] + 1)%2;
	MOVF       FARG_RelayController_pinIndex+0, 0
	ADDWF      FARG_RelayController_OutletStatus+0, 0
	MOVWF      FLOC__RelayController+0
	MOVF       FLOC__RelayController+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	ADDLW      1
	MOVWF      R0+0
	CLRF       R0+1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVLW      2
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       FLOC__RelayController+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;Dual_Control_Home_Automation.c,74 :: 		PORTD ^= 1 << pinIndex;
	MOVF       FARG_RelayController_pinIndex+0, 0
	MOVWF      R1+0
	MOVLW      1
	MOVWF      R0+0
	MOVF       R1+0, 0
L__RelayController48:
	BTFSC      STATUS+0, 2
	GOTO       L__RelayController49
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__RelayController48
L__RelayController49:
	MOVF       R0+0, 0
	XORWF      PORTD+0, 1
;Dual_Control_Home_Automation.c,75 :: 		Delay_ms(250);
	MOVLW      7
	MOVWF      R11+0
	MOVLW      88
	MOVWF      R12+0
	MOVLW      89
	MOVWF      R13+0
L_RelayController23:
	DECFSZ     R13+0, 1
	GOTO       L_RelayController23
	DECFSZ     R12+0, 1
	GOTO       L_RelayController23
	DECFSZ     R11+0, 1
	GOTO       L_RelayController23
	NOP
	NOP
;Dual_Control_Home_Automation.c,76 :: 		}
	GOTO       L_RelayController24
L_RelayController18:
;Dual_Control_Home_Automation.c,77 :: 		else if((PORTE >> (pinIndex - 6) == 1 && pinIndex > 5) || isFromSerial)
	MOVLW      6
	SUBWF      FARG_RelayController_pinIndex+0, 0
	MOVWF      R0+0
	MOVLW      0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      FARG_RelayController_pinIndex+1, 0
	MOVWF      R0+1
	MOVF       PORTE+0, 0
	MOVWF      R1+0
	MOVF       R0+0, 0
L__RelayController50:
	BTFSC      STATUS+0, 2
	GOTO       L__RelayController51
	RRF        R1+0, 1
	BCF        R1+0, 7
	ADDLW      255
	GOTO       L__RelayController50
L__RelayController51:
	MOVF       R1+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L__RelayController35
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      FARG_RelayController_pinIndex+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__RelayController52
	MOVF       FARG_RelayController_pinIndex+0, 0
	SUBLW      5
L__RelayController52:
	BTFSC      STATUS+0, 0
	GOTO       L__RelayController35
	GOTO       L__RelayController34
L__RelayController35:
	MOVF       FARG_RelayController_isFromSerial+0, 0
	IORWF      FARG_RelayController_isFromSerial+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__RelayController34
	GOTO       L_RelayController29
L__RelayController34:
;Dual_Control_Home_Automation.c,79 :: 		Lcd_Out((pinIndex%4 + 1), 20, !OutletStatus[pinIndex]? "1" : "0");
	MOVLW      4
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FARG_RelayController_pinIndex+0, 0
	MOVWF      R0+0
	MOVF       FARG_RelayController_pinIndex+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	INCF       R0+0, 0
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      20
	MOVWF      FARG_Lcd_Out_column+0
	MOVF       FARG_RelayController_pinIndex+0, 0
	ADDWF      FARG_RelayController_OutletStatus+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_RelayController30
	MOVLW      ?lstr3_Dual_Control_Home_Automation+0
	MOVWF      ?FLOC___RelayControllerT55+0
	GOTO       L_RelayController31
L_RelayController30:
	MOVLW      ?lstr4_Dual_Control_Home_Automation+0
	MOVWF      ?FLOC___RelayControllerT55+0
L_RelayController31:
	MOVF       ?FLOC___RelayControllerT55+0, 0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;Dual_Control_Home_Automation.c,80 :: 		OutletStatus[pinIndex] = (OutletStatus[pinIndex] + 1)%2;
	MOVF       FARG_RelayController_pinIndex+0, 0
	ADDWF      FARG_RelayController_OutletStatus+0, 0
	MOVWF      FLOC__RelayController+0
	MOVF       FLOC__RelayController+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	ADDLW      1
	MOVWF      R0+0
	CLRF       R0+1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVLW      2
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       FLOC__RelayController+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;Dual_Control_Home_Automation.c,81 :: 		PORTD ^= 1 << pinIndex;
	MOVF       FARG_RelayController_pinIndex+0, 0
	MOVWF      R1+0
	MOVLW      1
	MOVWF      R0+0
	MOVF       R1+0, 0
L__RelayController53:
	BTFSC      STATUS+0, 2
	GOTO       L__RelayController54
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__RelayController53
L__RelayController54:
	MOVF       R0+0, 0
	XORWF      PORTD+0, 1
;Dual_Control_Home_Automation.c,82 :: 		Delay_ms(250);
	MOVLW      7
	MOVWF      R11+0
	MOVLW      88
	MOVWF      R12+0
	MOVLW      89
	MOVWF      R13+0
L_RelayController32:
	DECFSZ     R13+0, 1
	GOTO       L_RelayController32
	DECFSZ     R12+0, 1
	GOTO       L_RelayController32
	DECFSZ     R11+0, 1
	GOTO       L_RelayController32
	NOP
	NOP
;Dual_Control_Home_Automation.c,83 :: 		}
L_RelayController29:
L_RelayController24:
;Dual_Control_Home_Automation.c,84 :: 		}
L_end_RelayController:
	RETURN
; end of _RelayController
