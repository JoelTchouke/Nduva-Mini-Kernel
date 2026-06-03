#include "kernel/includes/traps/syscalls.h"
#include "user/includes/libs/nduvaiolib.h"

void kprint()
{
    sys_write();
}