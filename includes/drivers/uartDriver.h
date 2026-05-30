#include <stdint.h>
#include <stddef.h>
#define UARTDR    *(volatile uint32_t *)0x09000000
#define UARTRSR   *(volatile uint32_t *)0x09000004
#define UARTECR   UARTRSR
#define UARTFR    *(volatile uint32_t *)0x09000018
#define UARTILPR  *(volatile uint32_t *)0x09000020
#define UARTIBRD  *(volatile uint32_t *)0x09000024
#define UARTFBRD  *(volatile uint32_t *)0x09000028
#define UARTLCR_H *(volatile uint32_t *)0x0900002C
#define UARTCR    *(volatile uint32_t *)0x09000030
#define UARTIFLS  *(volatile uint32_t *)0x09000034
#define UARTIMSC  *(volatile uint32_t *)0x09000038
#define UARTRIS   *(volatile uint32_t *)0x0900003C
#define UARTMIS   *(volatile uint32_t *)0x09000040
#define UARTICR   *(volatile uint32_t *)0x09000044
#define UARTDMACR *(volatile uint32_t *)0x09000048

typedef enum
{
    UART_SUCCESS = 0,         // Operation completed successfully
    UART_ERROR_INVALID_PARAM, // Bad argument passed (e.g., NULL pointer)
    UART_ERROR_BUSY,          // Hardware is currently transmitting or receiving
    UART_ERROR_TIMEOUT,       // Clock cycles expired while waiting for a flag
    UART_ERROR_FRAMING,       // Stop bit was not received where expected
    UART_ERROR_OVERRUN,       // New data arrived before old data was read
    UART_ERROR_PARITY         // Data corrupted during transmission check
} uart_status_t;


/**
@Definition This function will return 0 if successful and 1 if init cu
*/
uart_status_t uart_init();
uart_status_t uart_write_char(char c);
//uart_status_t uart_read_char(char * buffer);