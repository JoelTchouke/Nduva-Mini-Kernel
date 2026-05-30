.global _start

_start:
    ldr x0, = 0x41000000
    # Setting the stack pointer to a safe address
    mov sp, x0 
    # jumping into main function
    bl nduva_main