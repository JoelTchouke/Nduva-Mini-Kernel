.global _start

_start:
    ldr x0, =0x41000000
    mov sp, x0

    bl nduva_main