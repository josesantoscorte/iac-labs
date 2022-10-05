; *******************************************************************
; * IST-UL
; * Modulo:    semaforo.asm
; * Descrição: Exemplo de um controlador de semáforos no PEPE-8.
; ********************************************************************

;constantes de dados
vermelho	EQU	01H		;valor do vermelho (lâmpada liga ao bit 0)
amarelo	EQU	02H		;valor do amarelo (lâmpada liga ao bit 1)
verde	EQU	04H		;valor do verde (lâmpada liga ao bit 2)

;constantes de endereços
semaforo	EQU	80H		;endereço 128 (periférico de saída)

;programa
inicio:
	LD	verde		;Carrega o registo A com o valor para semáforo verde
	ST	[semaforo]	;Atualiza o periférico de saída
semVerde:
	NOP				;faz um compasso de espera
	NOP				;faz um compasso de espera
	NOP				;faz um compasso de espera
	LD	amarelo		;Carrega o registo A com o valor para semáforo amarelo
	ST	[semaforo]	;Atualiza o periférico de saída
semAmar:
	NOP				;faz um compasso de espera
	LD	vermelho		;Carrega o registo A com o valor para semáforo vermelho
	ST	[semaforo]	;Atualiza o periférico de saída
semVerm:
	NOP				;faz um compasso de espera
	NOP				;faz um compasso de espera
	NOP				;faz um compasso de espera
	NOP				;faz um compasso de espera
	JMP	inicio		;vai fazer mais uma ronda
