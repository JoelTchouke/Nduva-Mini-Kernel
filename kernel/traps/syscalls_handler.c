#include "kernel/includes/drivers/uartDriver.h"
#include "kernel/includes/traps/syscalls_handler.h"

int sys_write_handler()
{
    uart_init();
    uart_write_char('J');

    return 0;
}