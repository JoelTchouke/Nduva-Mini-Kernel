#include "Nduva-Mini-Kernel/includes/libs/nduvaiolib.h"

void kprint(char * buffer)
{
    if (buffer == NULL) return;
    while (*buffer != '\0')
    {
        uart_write_char(*buffer);
        buffer++;
    }
}