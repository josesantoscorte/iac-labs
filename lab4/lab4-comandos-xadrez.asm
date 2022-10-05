; *********************************************************************************
; * IST-UL
; * Modulo:    lab4-comandos-xadrez.asm
; * Descrição: Este programa ilustra o funcionamento do ecrã, em que os pixels
; *            são escritos por meio de comandos.
; *            Desenha um padrão de xadrez no ecrã, preenchendo todos os pixels.
; *			Tem dois ciclos um dentro do outro (ciclo das colunas dentro do ciclo das linhas)
; *			Troca a cor do pixel, pixel sim, pixel não 
; *********************************************************************************

; *********************************************************************************
; * Constantes
; *********************************************************************************
DEFINE_LINHA    EQU 600AH      ; endereço do comando para definir a linha
DEFINE_COLUNA   EQU 600CH      ; endereço do comando para definir a coluna
DEFINE_PIXEL    EQU 6012H      ; endereço do comando para escrever um pixel
APAGA_AVISO     EQU 6040H      ; endereço do comando para apagar o aviso de nenhum cenário selecionado
APAGA_ECRÃ	 EQU 6002H      ; endereço do comando para apagar todos os pixels já desenhados

N_LINHAS        EQU  32        ; número de linhas do ecrã (altura)
N_COLUNAS       EQU  64        ; número de colunas do ecrã (largura)

COR_PIXEL       EQU 0FF00H     ; cor do pixel: vermelho em ARGB (opaco e vermelho no máximo, verde e azul a 0)

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
	MOV  [DEFINE_LINHA], R1	; seleciona a linha
	MOV  [DEFINE_COLUNA], R2	; seleciona a coluna
	MOV  [DEFINE_PIXEL], R3	; altera a cor do pixel na linha e coluna selecionadas
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
