; *********************************************************************************
; * IST-UL
; * Modulo: 	lab4-memoria.asm
; * Descrição: Este programa escreve um pixel no ecrã, usando acesso à memória
; *
; *********************************************************************************

; *********************************************************************************
; * Constantes
; *********************************************************************************

MEMORIA_ECRA	 EQU	8000H	; endereço base da memória do ecrã

LINHA           EQU 2		; linha em que o pixel vai ser desenhado (entre 0 e 31)
COLUNA          EQU 1		; coluna em que o pixel vai ser desenhado (entre 0 e 63)

COR_PIXEL       EQU 0FF00H	; cor do pixel: vermelho em ARGB (opaco e vermelho no máximo, verde e azul a 0)
COR_APAGADO     EQU 0000H	; cor para apagar um pixel: todas as componentes a 0

; *********************************************************************************
; * Código
; *********************************************************************************
PLACE   0                   	; o código tem de começar em 0000H
inicio:
    MOV  R1, LINHA          	; define linha, coluna e cor do pixel a escrever
    MOV  R2, COLUNA
    MOV  R3, COR_PIXEL
    
escreve_pixel:
	MOV	R0, MEMORIA_ECRA	; endereço de base da memória do ecrã
	SHL	R1, 6			; linha * 64
     ADD  R1, R2			; linha * 64 + coluna
     SHL  R1, 1			; * 2, para ter o endereço da palavra
	ADD	R0, R1			; MEMORIA_ECRA + 2 * (linha * 64 + coluna)
	MOV	[R0], R3			; escreve cor no pixel
    
apaga_pixel:
    MOV  R3, COR_APAGADO
    MOV  [R0], R3			; altera a cor do pixel na linha e coluna já selecionadas

fim:
    JMP  fim
 
