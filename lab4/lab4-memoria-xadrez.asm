; *********************************************************************************
; * IST-UL
; * Modulo:    lab4-memoria-xadrez.asm
; * Descrição: Este programa ilustra o funcionamento do ecrã, em que os pixels
; *            são escritos por meio de acesso direto à memória do ecrã.
; *            Desenha um padrão de xadrez no ecrã, preenchendo todos os pixels. 
; *			Tem dois ciclos um dentro do outro (ciclo das colunas dentro do ciclo das linhas)
; *			Troca a cor do pixel, pixel sim, pixel não 
; *********************************************************************************

; *********************************************************************************
; * Constantes
; *********************************************************************************
MEMORIA_ECRA	EQU	8000H	; endereço base da memória do ecrã

APAGA_AVISO	EQU 6040H      ; endereço do comando para apagar o aviso de nenhum cenário selecionado
APAGA_ECRÃ	EQU 6002H      ; endereço do comando para apagar todos os pixels já desenhados

N_LINHAS       EQU  32        ; número de linhas do ecrã (altura)
N_COLUNAS      EQU  64        ; número de colunas do ecrã (largura)

COR_PIXEL      EQU 0FF00H     ; cor do pixel: vermelho em ARGB (opaco e vermelho no máximo, verde e azul a 0)

; *********************************************************************************
; * Código
; *********************************************************************************
PLACE   0                     ; o código tem de começar em 0000H
inicio:
     MOV  [APAGA_AVISO], R1	; apaga o aviso de nenhum cenário selecionado (o valor de R1 não é relevante)
     MOV  [APAGA_ECRÃ], R1	; apaga todos os pixels já desenhados (o valor de R1 não é relevante)
     
     MOV  R3, 0               ; primeiro pixel a 0                   
     MOV  R1, 0               ; linha corrente
proxima_linha:       		; escreve os pixels na linha corrente
     MOV  R2, 0               ; coluna corrente
	
proxima_coluna:       		; escreve o pixel na coluna corrente
	MOV	R0, MEMORIA_ECRA	; endereço de base da memória do ecrã
	MOV	R4, R1			; cópia da linha corrente
	SHL	R4, 6			; linha * 64
     ADD  R4, R2			; linha * 64 + coluna
     SHL  R4, 1			; * 2, para ter o endereço da palavra
	ADD	R0, R4			; MEMORIA_ECRA + 2 * (linha * 64 + coluna)
	MOV	[R0], R3			; escreve cor no pixel

     ADD  R2, 1               ; próxima coluna
     MOV  R5, N_COLUNAS
     CMP  R2, R5              ; chegou à última coluna?
     JZ  fim_linha
troca_cor:           		; troca a cor, de 0 para COR_PIXEL ou vice-versa
	CMP  R3, 0			; se a cor é 0, vai alterar a cor para COR_PIXEL. Se não, põe a 0.
	JZ   poe_cor
	MOV  R3, 0			; pixel desligado
	JMP  proxima_coluna
poe_cor:    
	MOV  R3, COR_PIXEL		; pixel com cor
	JMP  proxima_coluna
	
fim_linha:
     ADD  R1, 1               ; próxima linha
     MOV  R4, N_LINHAS
     CMP  R1, R4              ; chegou à última linha?
     JNZ  proxima_linha

fim:
     JMP  fim                 ; termina programa


