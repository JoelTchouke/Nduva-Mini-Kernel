#include "kernel/includes/drivers/uartDriver.h"

#define BAUD_RATE 115200
#define CLOCK_SPEED 24 //MHZ
#define INTEGER_BAUD_RATE (unsigned int) ((CLOCK_SPEED * 1000000) / (16 * BAUD_RATE))
#define FRACTIONAL_BAUD_RATE (unsigned int) (((((CLOCK_SPEED * 1000000.0) / (16.0 * BAUD_RATE)) - INTEGER_BAUD_RATE) * 64.0) + 0.5)
#define CONTROL_REGISTER_VAL 0x07FF
#define LINE_CONTROL_VAL 0x70


uart_status_t uart_init()
{
    UARTCR &= ~1U;
    UARTIMSC = 0U;
    UARTICR = CONTROL_REGISTER_VAL;
    UARTIBRD = INTEGER_BAUD_RATE;
    UARTFBRD = FRACTIONAL_BAUD_RATE;
    UARTLCR_H = LINE_CONTROL_VAL;
    UARTCR = 0x0301; //end of config

    return UART_SUCCESS;
}

uart_status_t uart_write_char(char c)
{
    while ((UARTFR & (1U << 5U)) != 0U);
    UARTDR = (uint32_t) c;
    return UART_SUCCESS;
}

/*uart_status_t uart_read_char(char * buffer)
{
   return UART_SUCCESS;
}
*/
