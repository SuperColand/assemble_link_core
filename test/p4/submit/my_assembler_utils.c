/*****************************************************************
 * BUAA Fall 2022 Fundamentals of Computer Hardware
 * Project4 Assembler and Linker
 *****************************************************************
 * my_assembler_utils.c
 * Assembler Submission
 *****************************************************************/
#include <string.h>
#include <stdlib.h>
#include <stdio.h>

#include "my_assembler_utils.h"
#include "assembler-src/assembler_utils.h"
#include "lib/translate_utils.h"

/*
 * This function reads .data symbol from INPUT and add them to the SYMTBL
 * Note that in order to distinguish in the symbol table whether a symbol
 * comes from the .data segment or the .text segment, we append a % to the
 * symbol name when adding the .data segment symbol. Since only underscores and
 * letters will appear in legal symbols, distinguishing them by adding % will
 * not cause a conflict between the new symbol and the symbol in the assembly file.
 *
 * Return value:
 * Return the number of bytes in the .data segment.
 */
int read_data_segment(FILE *input, SymbolTable *symtbl) {
    char buf[ASSEMBLER_BUF_SIZE];
    int byte_offset = 0;
    fgets(buf, ASSEMBLER_BUF_SIZE, input);
    if (strcmp(strtok(buf, ASSEMBLER_IGNORE_CHARS), ".data") != 0) {
        printf("Error - get .data\n");
        return -1;
    }
    while (fgets(buf, ASSEMBLER_BUF_SIZE, input)) {
        int has_comment = strchr(buf, '#') != NULL;
        skip_comment(buf);
        char *token = strtok(buf, ASSEMBLER_IGNORE_CHARS);
        if (token == NULL && has_comment == 0) {
            return byte_offset;
        } else if (token == NULL && has_comment == 1) {
            continue;
        }
        char *name = token;
        size_t len = strlen(name);
        if (name[len - 1] != ':') {
            printf("Error - get global label\n");
            continue;
        }
        name[len - 1] = '\0';
        if (!is_valid_label(name)) {
            printf("Error - invalid gloal label\n");
            continue;
        }
        token = strtok(NULL, ASSEMBLER_IGNORE_CHARS);
        if (strcmp(token, ".space") != 0) {
            printf("Error - invalid directive\n");
            continue;
        }
        token = strtok(NULL, ASSEMBLER_IGNORE_CHARS);
        long int space;
        translate_num(&space, token, 0, 31);
        char label[ASSEMBLER_BUF_SIZE];
        sprintf(label, "%%%s", name);
        add_to_table(symtbl, label, byte_offset);
        byte_offset += space;
    }
    return -1;
}

/* Reads STR and determines whether it is a label (ends in ':'), and if so,
 * whether it is a valid label, and then tries to add it to the symbol table,
 * remerber to replace ':' with '\0'.
 *
 * Four scenarios can happen:
 *  1. STR is not a label (does not end in ':'). Returns 0.
 *  2. STR ends in ':', but is not a valid label. Returns -1.
 *  3a. STR ends in ':' and is a valid label. Addition to symbol table fails.
 *      Returns -1.
 *  3b. STR ends in ':' and is a valid label. Addition to symbol table succeeds.
 *      Returns 1.
 * 
 * Hint:
 *  Use is_valid_label, add_to_table and raise_label_error.
 */
int add_if_label(uint32_t input_line, char *str, uint32_t addr, SymbolTable *symtbl) {
    size_t len = strlen(str);
    if (str[len - 1] == ':') {
        str[len - 1] = '\0';
        if (is_valid_label(str)) {
            if (add_to_table(symtbl, str, addr) == 0) {
                return 1;
            } else {
                return -1;
            }
        } else {
            raise_label_error(input_line, str);
            return -1;
        }
    } else {
        return 0;
    }
}

/*
 * Convert memory instructions(including lw, lb, sw, sb) to machine code.
 * Output the instruction to the **OUTPUT**.(Consider using write_inst_hex()).
 * 
 * Arguments:
 *  opcode:     op segment in MIPS machine code
 *  args:       args[0] is the $rt register, and args[2] is the $rs register.
 *             The other cases are illegal and need not be considered
 *  num_args:   length of args array
 *  addr:       Address offset of the current instruction in the file
 * 
 * Hint:
 *  Use translate_reg, translate_num and write_inst_hex.
 */
int write_mem(uint8_t opcode, FILE *output, char **args, size_t num_args) {
    if (num_args != 3) {
        printf("invalid number of arguments. \n");
        return -1;
    }

    long int imm;
    int rt = translate_reg(args[0]);
    int rs = translate_reg(args[2]);
    int err = translate_num(&imm, args[1], INT16_MIN, INT16_MAX);

    if ((rs == -1) | (rt == -1)) {
        printf("Invalid register. \n");
        return -1;
    }
    if (err == -1) {
        printf("%li is not a valid number. \n", imm);
        return -1;
    }

    uint32_t instruction = 0;
    instruction = instruction | (imm & 0x0000ffff);
    instruction = instruction | (rt << 16);
    instruction = instruction | (rs << 21);
    instruction = instruction | (opcode << 26);
    write_inst_hex(output, instruction);
    return 0;
}