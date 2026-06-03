// boot.S
.global _start

.section .text.boot     // <--- This section must come FIRST
_start:
    ldr x0, =_vector_table
    msr vbar_el1, x0    // Load table pointer
    
    ldr x0, =0x41000000
    mov sp, x0          // Set initial stack pointer
    bl nduva_main       // Call main kernel core

.section .text.vectors
.balign 2048
_vector_table:
    # B STACK_RESET
    .org _vector_table + 0x400
    B SVC_64
    # .org _vector_table + 0x600
    # B SVC_32