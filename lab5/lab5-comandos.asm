; *********************************************************************************
; * IST-UL
; * Modulo: 	lab5-comandos.asm
; * Descrição: Este programa define uma rotina para escrever um pixel no ecrã,
; *            usando comandos, e ilustra a sua utlização
; *
; *********************************************************************************

; *********************************************************************************
; * Constantes
; *********************************************************************************

DEFINE_LINHA		EQU 600AH		; endereço do comando para definir a linha
DEFINE_COLUNA		EQU 600CH		; endereço do comando para definir a coluna
DEFINE_PIXEL		EQU 6012H		; endereço do comando para escrever um pixel

LINHA			EQU 2		; linha em que o pixel vai ser desenhado (entre 0 e 31)
COLUNA			EQU 1		; coluna em que o pixel vai ser desenhado (entre 0 e 63)

COR_PIXEL			EQU 0FF00H	; cor do pixel: vermelho em ARGB (opaco e vermelho no máximo, verde e azul a 0)
COR_APAGADO		EQU 0000H		; cor para apagar um pixel: todas as componentes a 0

; *********************************************************************************
; * Dados 
; *********************************************************************************
	PLACE       1000H
pilha:
	STACK 100H			; espaço reservado para a pilha 
						; (200H bytes, pois são 100H words)
SP_inicial:				; este é o endereço (1200H) com que o SP deve ser 
						; inicializado. O 1.º end. de retorno será 
						; armazenado em 11FEH (1200H-2)
							
; *********************************************************************************
; * Código
; *********************************************************************************
	PLACE   0				; o código tem de começar em 0000H
inicio:
	MOV  SP, SP_inicial		; inicializa SP para a palavra a seguir
						; à última da pilha
                            
	MOV  R1, LINHA			; define linha, coluna e cor do pixel a escrever
	MOV  R2, COLUNA
	MOV  R3, COR_PIXEL
	CALL escreve_pixel		; escreve o pixel no ecrã (com COR_PIXEL)
    
	MOV  R3, COR_APAGADO
	CALL escreve_pixel		; escreve o pixel no ecrã (com COR_APAGADO, ou seja, apaga-o)
						; linha e coluna mantêm-se
fim:
	JMP  fim
 
; **********************************************************************
; ESCREVE_PIXEL - Escreve um pixel na linha e coluna indicadas.
; Argumentos:   R1 - linha
;               R2 - coluna
;               R3 - cor do pixel (em formato ARGB de 16 bits)
;
; **********************************************************************
escreve_pixel:
	MOV  [DEFINE_LINHA], R1		; seleciona a linha
	MOV  [DEFINE_COLUNA], R2		; seleciona a coluna
	MOV  [DEFINE_PIXEL], R3		; altera a cor do pixel na linha e coluna já selecionadas
	RET
