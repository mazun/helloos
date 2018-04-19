; hello-os
; TAB=4

    ORG 0x7c00 ; address where this program is loaded

; FAT12
    JMP entry
    DB 0x90
    DB "HELLOIPL"
    DW 512
    DB 1
    DW 1
    DB 2
    DW 224
    DW 2880
    DB 0xf0
    DW 9
    DW 18
    DW 2
    DD 0
    DD 2880
    DB 0, 0, 0x29
    DD 0xffffffff
    DB "HELLO-OS   "
    DB "FAT12   "
    RESB 18

; Main program

entry:
    MOV AX, 0 ; Initialize the register
    MOV SS, AX
    MOV SP, 0x7c00
    MOV DS, AX
    MOV ES, AX

    MOV SI, msg

putloop:
    MOV AL, [SI]
    ADD SI, 1
    CMP AL, 0
    JE fin
    MOV AH, 0x0e ; function to print one character
    MOV BX, 15 ; color code
    INT 0x10 ; call video BIOS
    JMP putloop

fin:
    HLT ; halt cpu
    JMP fin ; infinite loop

msg:
    DB 0x0a, 0x0a
    DB "hello, world"
    DB 0x0a
    DB 0

    RESB 0x7dfe-$

    DB 0x55, 0xaa