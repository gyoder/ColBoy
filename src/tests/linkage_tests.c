#include "linkage_tests.h"

#include <stdio.h>

void basic_linkage_test() {
    printf("Successfully Linked and Called\n");
}

void pass_value_test(char arg) {
    printf("Pass Value Test: Passed %d\n", arg);
}

void pass_reference_test(char* value) {
    printf("Pass Reference Test: Reference %d. incrementing by 1\n", *value);
    (*value)++;
}