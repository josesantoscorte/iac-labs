; *******************************************************************
; * IST-UL
; * Modulo:    conta-uns.asm
; * Descrição: Programa do PEPE-8 que conta o número de bits a 1 num dado valor.
; ********************************************************************

valor		EQU	76H		; Valor cujo número de bits a 1 é para ser contado
mascaraInicial	EQU	01H		; 0000 0001 em binário (máscara inicial)
mascaraFinal	EQU	80H		; 1000 0000 em binário (máscara final)

contador	EQU	00H			; Endereço da célula de memória que guarda 
						; o valor corrente do contador de bits a 1
mascara	EQU	01H			; Endereço da célula de memória que guarda 
						; o valor corrente da máscara
inicio:
	LD	0				; Inicializa o registo A a zero
	ST	[contador]		; Inicializa o contador de bits com zero
	LD	mascaraInicial		; Carrega valor da máscara inicial
	ST	[mascara]			; Atualiza na memória
teste:
	AND	valor			; Isola o bit que se quer ver se é 1
	JZ	proximo			; Se o bit for zero, passa à máscara seguinte
	LD	[contador]		; O bit é 1, vai buscar o valor atual do contador
	ADD	1				; Incrementa-o
	ST	[contador]		; e atualiza de novo na memória
proximo:
	LD	[mascara]			; Vai buscar de novo a máscara atual
	SUB	mascaraFinal		; Compara com a máscara final, fazendo a subtração
	JZ	fim				; Se der zero, eram iguais e portanto já terminou
	LD	[mascara]			; Tem de carregar a máscara de novo
	ADD	[mascara]			; Soma com ela própria para a multiplicar por 2
	ST	[mascara]			; Atualiza o valor da máscara na memória
	JMP	teste			; Vai fazer mais um teste com a nova máscara
fim:	JMP	fim				; Fim do programa