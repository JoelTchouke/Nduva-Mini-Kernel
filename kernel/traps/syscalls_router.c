
#include "kernel/includes/traps/syscalls.h"
#include "kernel/includes/traps/syscalls_router.h"
#include "kernel/includes/traps/syscalls_handler.h"


int syscalls_router()
{
    uint64_t syscall_id;
    __asm__ volatile("mov %0, x8" :"=r"(syscall_id));
    switch(syscall_id)
    {
        case SYS_WRITE_ID:
            sys_write_handler();
            break;
        default:
    }
    return 0;
}