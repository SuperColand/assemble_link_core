/*****************************************************************
 * BUAA Fall 2021 Fundamentals of Computer Hardware
 * Project7 Assembler and Linker
 *****************************************************************
 * my_linker_utils.c
 * Linker Submission
 *****************************************************************/
#include <stdio.h>
#include <stdint.h>
#include <string.h>

#include "lib/tables.h"
#include "linker-src/linker_utils.h"

/*
 * Detect whether the given instruction needs relocation.
 *
 * Return value:
 * 1 if the instruction needs relocation, 0 otherwise.
 *
 * Arguments:
 * inst: 32-bit MIPS instruction.
 */
int inst_needs_relocation(SymbolTable *reltbl, uint32_t offset) {
    const char *name = get_symbol_for_addr(reltbl, offset);
    return name != NULL;
}

/*
 * Builds the symbol table and relocation data for a single file.
 * Read the .data, .text, .symbol, .relocation segments in that order.
 * The size of the .data and .text segments are read and saved in the
 * relocation table of the current file. For the .symbol and .relocation
 * segments, save the symbols in them in the corresponding locations.
 *
 * Return value:
 * 0 if no errors, -1 if error.
 *
 * Arguments:
 * input:            file pointer.
 * symtbl:           symbol table.
 * reldt:            pointer to a Relocdata struct.
 * base_text_offset: base text offset.
 * base_data_offset: base data offset.
 */
int
fill_data(FILE *input, SymbolTable *symtbl, RelocData *reldt, uint32_t base_text_offset, uint32_t base_data_offset) {
    char buf[LINKER_BUF_SIZE];
    while (fgets(buf, LINKER_BUF_SIZE, input)) {
        char *token = strtok(buf, LINKER_IGNORE_CHARS);
        if (!token) {
            return 0;
        }
        if (strcmp(token, ".data") == 0) {
            long sz = calc_data_size(input);
            if (sz < 0) {
                printf("fill_data: calc_data_size failed\n");
                return -1;
            }
            reldt->data_size = sz;
        } else if (strcmp(token, ".text") == 0) {
            int sz = calc_text_size(input);
            if (sz < 0) {
                printf("fill_data: calc_text_size failed\n");
                return -1;
            }
            reldt->text_size = sz;
        } else if (strcmp(token, ".symbol") == 0) {
            if (add_to_symbol_table(input, symtbl, base_text_offset, base_data_offset) < 0) {
                printf("fill_data: add_to_symbol_table failed\n");
                return -1;
            }
        } else if (strcmp(token, ".relocation") == 0) {
            if (add_to_symbol_table(input, reldt->table, 0, 0) < 0) {
                printf("fill_data: add_to_symbol_table failed\n");
                return -1;
            }
        }
    }
    return 0;
}
