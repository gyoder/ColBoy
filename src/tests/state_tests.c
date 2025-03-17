#include "state_tests.h"
#include "../interfaces/interfaces.h"
#include "../cpu/cpu.h"

#include <stdio.h>

#define SMALL_NUMBER 45
#define BIG_NUMBER 555

void verify_reg() {

    CPU_RESET();
    char small_registers[8][2] = {"a", "b", "c", "d", "e", "f", "h", "l" };
    char big_registers[5][3] = {"bc", "de", "hl", "pc", "sp"};

    for (int i = 0; i < 8; i++) {
        SET_REGISTER(SMALL_NUMBER, small_registers[i]);
        short ret = 0;
        GET_REGISTER(&ret, small_registers[i]);
        if (ret != SMALL_NUMBER) {
            printf("FAIL: REGISTER INTEGRITY FAILED\n");
            return;
        }
    }

    for (int i = 0; i < 5; i++) {
        SET_REGISTER(BIG_NUMBER, big_registers[i]);
        short ret = 0;
        GET_REGISTER(&ret, big_registers[i]);
        if (ret != BIG_NUMBER) {
            printf("FAIL: REGISTER INTEGRITY FAILED\n");
            return;
        }
    } 

    printf("Registers working\n");

}