; hello-os
; TAB=4

CYLS EQU 10

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
    DB "HARIBOTEOS "
    DB "FAT12   "
    RESB 18

; Main program

entry:
    MOV AX, 0 ; Initialize the register
    MOV SS, AX
    MOV SP, 0x7c00
    MOV DS, AX

    MOV AX, 0x0820
    MOV ES, AX
    MOV CH, 0 ; sylinder 0
    MOV DH, 0 ; head 0
    MOV CL, 2 ; sector 2

readloop:
    MOV SI, 0 ; counter for error

retry:
    MOV AH, 0x02 ; AH=0x02: read disk
    MOV AL, 1    ; one sector
    MOV BX, 0
    MOV DL, 0x00 ; drive A
    INT 0x13     ; call disk BIOS
    JNC next     ; go to fin if no error
    ADD SI, 1    ; count up
    CMP SI, 5    ; compare SI to 5
    JAE error    ; go to error if SI >= 5
    MOV AH, 0x00
    MOV DL, 0x00 ; drive A
    INT 0x13     ; reset drive
    JMP retry

next:
    MOV AX, ES ; advance address by 0x20
    ADD AX, 0x0020
    MOV ES, AX ; cannot write like `ADD ES, 0x020`
    ADD CL, 1 
    CMP CL, 18
    JBE readloop
    MOV CL, 1
    ADD DH, 1
    CMP DH, 2
    JB readloop
    MOV DH, 0
    ADD CH, 1
    CMP CH, CYLS
    JB readloop

    MOV [0x0ff0], CH ; tell how many sylinders did we load
    JMP 0xc200 ; jamp to haribote.sys

error:
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
    DB "load error"
    DB 0x0a
    DB 0

    RESB 0x7dfe-$

    DB 0x55, 0xaa