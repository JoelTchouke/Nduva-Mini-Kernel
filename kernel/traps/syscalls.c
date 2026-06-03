#include <stdint.h>
#include <sys/types.h> // For ssize_t
#include "kernel/includes/traps/syscalls.h"

ssize_t sys_write(void)
{
    // 1. Map your clean C parameter to the physical X8 register
    register int reg_x8 __asm__("x8") = SYS_WRITE_ID; 

    // 2. Execute the trap with perfectly aligned colons
    __asm__ volatile (
        "svc #0\n\t"
        :              // 1st Colon: Empty Output section
        : "r"(reg_x8)  // 2nd Colon: Input section (reg_x8 goes here!)
        : "memory"     // 3rd Colon: Clobber section
    );

    return 0;
}
