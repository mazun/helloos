; naskfunc
; TAB=4

[FORMAT "WCOFF"] ; object file mode
[BITS 32]

[FILE "naskfunc.nas"]

    GLOBAL _io_hlt ; function name

[SECTION .text]

_io_hlt:
    HLT
    RET