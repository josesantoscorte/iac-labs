; *********************************************************************************
; * IST-UL
; * Modulo: 	lab4-comandos.asm
; * Descrição: Este programa escreve um pixel no ecrã, usando comandos
; *
; *********************************************************************************

; *********************************************************************************
; * Constantes
; *********************************************************************************

DEFINE_LINHA    EQU 600AH	; endereço do comando para definir a linha
DEFINE_COLUNA   EQU 600CH	; endereço do comando para definir a coluna
DEFINE_PIXEL    EQU 6012H	; endereço do comando para escrever um pixel

LINHA           EQU 2		; linha em que o pixel vai ser desenhado (entre 0 e 31)
COLUNA          EQU 1		; coluna em que o pixel vai ser desenhado (entre 0 e 63)

COR_PIXEL       EQU 0FF00H	; cor do pixel: vermelho em ARGB (opaco e vermelho no máximo, verde e azul a 0)
COR_APAGADO     EQU 0000H     ; cor para apagar um pixel: todas as componentes a 0

							
; *********************************************************************************
; * Código
; *********************************************************************************
PLACE   0                   	; o código tem de começar em 0000H
inicio:
    MOV  R1, LINHA          	; define linha, coluna e cor do pixel a escrever
    MOV  R2, COLUNA
    MOV  R3, COR_PIXEL
    
escreve_pixel:
    MOV  [DEFINE_LINHA], R1	; seleciona a linha
    MOV  [DEFINE_COLUNA], R2	; seleciona a coluna
    MOV  [DEFINE_PIXEL], R3	; altera a cor do pixel na linha e coluna já selecionadas
    
apaga_pixel:
    MOV  R3, COR_APAGADO
    MOV  [DEFINE_PIXEL], R3	; altera a cor do pixel na linha e coluna já selecionadas

fim:
    JMP  fim
 
