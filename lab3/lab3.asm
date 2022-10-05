; *********************************************************************
; * IST-UL
; * Modulo:    lab3.asm
; * Descri��o: Exemplifica o acesso a um teclado.
; *            L� uma linha do teclado, verificando se h� alguma tecla
; *            premida nessa linha.
; *
; * Nota: Observe a forma como se acede aos perif�ricos de 8 bits
; *       atrav�s da instru��o MOVB
; *********************************************************************

; **********************************************************************
; * Constantes
; **********************************************************************
; ATEN��O: constantes hexadecimais que comecem por uma letra devem ter 0 antes.
;          Isto n�o altera o valor de 16 bits e permite distinguir n�meros de identificadores
DISPLAYS   EQU 0A000H  ; endere�o dos displays de 7 segmentos (perif�rico POUT-1)
TEC_LIN    EQU 0C000H  ; endere�o das linhas do teclado (perif�rico POUT-2)
TEC_COL    EQU 0E000H  ; endere�o das colunas do teclado (perif�rico PIN)
LINHA      EQU 1       ; linha a testar (4� linha, 1000b)
MASCARA    EQU 0FH     ; para isolar os 4 bits de menor peso, ao ler as colunas do teclado

; **********************************************************************
; * C�digo
; **********************************************************************
PLACE      0
inicio:		
; inicializa��es
    MOV  R2, TEC_LIN   ; endere�o do perif�rico das linhas
    MOV  R3, TEC_COL   ; endere�o do perif�rico das colunas
    MOV  R4, DISPLAYS  ; endere�o do perif�rico dos displays
    MOV  R5, MASCARA   ; para isolar os 4 bits de menor peso, ao ler as colunas do teclado

; corpo principal do programa
ciclo:
    MOV  R1, 0 
    MOVB [R4], R1      ; escreve linha e coluna a zero nos displays

espera_tecla:          ; neste ciclo espera-se at� uma tecla ser premida
    MOV  R1, LINHA     ; testar a linha 4 
    MOVB [R2], R1      ; escrever no perif�rico de sa�da (linhas)
    MOVB R0, [R3]      ; ler do perif�rico de entrada (colunas)
    AND  R0, R5        ; elimina bits para al�m dos bits 0-3
    CMP  R0, 0         ; h� tecla premida?
    JZ   espera_tecla  ; se nenhuma tecla premida, repete
                       ; vai mostrar a linha e a coluna da tecla
    SHL  R1, 4         ; coloca linha no nibble high
    OR   R1, R0        ; junta coluna (nibble low)
    MOVB [R4], R1      ; escreve linha e coluna nos displays
    
ha_tecla:              ; neste ciclo espera-se at� NENHUMA tecla estar premida
    MOV  R1, LINHA     ; testar a linha 4  (R1 tinha sido alterado)
    MOVB [R2], R1      ; escrever no perif�rico de sa�da (linhas)
    MOVB R0, [R3]      ; ler do perif�rico de entrada (colunas)
    AND  R0, R5        ; elimina bits para al�m dos bits 0-3
    CMP  R0, 0         ; h� tecla premida?
    JNZ  ha_tecla      ; se ainda houver uma tecla premida, espera at� n�o haver
    JMP  ciclo         ; repete ciclo

