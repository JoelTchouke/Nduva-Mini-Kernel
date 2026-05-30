#include "Nduva-Mini-Kernel/includes/libs/nduvaiolib.h"

int nduva_main(void)
{
    int i = 0;
    while(i < 1000000000)
    {
        kprint("Joel\n");
        i++;
    }
    return 0;
}