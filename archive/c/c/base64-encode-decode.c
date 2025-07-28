#include <ctype.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static const unsigned char base64_alphabet[65] =
"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

static unsigned char* base64_encode(const unsigned char* input, size_t length, size_t* output_length);
static unsigned char* base64_decode(const unsigned char* input, size_t length, size_t* output_length);
static int is_valid_base64(const char* string);
static void show_usage(void);

int main(int argc, char* argv[]) {
    if (argc != 3) {
        show_usage();
    }

    const char* mode = argv[1];
    const char* input_text = argv[2];

    if (strcmp(mode, "encode") == 0) {
        if (strlen(input_text) == 0) show_usage();

        size_t input_length = strlen(input_text);
        unsigned char* data = base64_encode((const unsigned char*)input_text, input_length, NULL);
        if (!data) {
            show_usage();
        }

        printf("%s\n", data);
        free(data);
    }
    else if (strcmp(mode, "decode") == 0) {
        if (strlen(input_text) == 0 || !is_valid_base64(input_text)) {
            show_usage();
        }

        size_t input_length = strlen(input_text);
        size_t decoded_length;
        unsigned char* data = base64_decode((const unsigned char*)input_text, input_length, &decoded_length);
        if (!data || decoded_length == 0) {
            show_usage();
        }

        fwrite(data, 1, decoded_length, stdout);
        fflush(stdout);
        free(data);
    }
    else {
        show_usage();
    }

    return 0;
}

static void show_usage(void) {
    fprintf(stderr, "Usage: please provide a mode and a string to encode/decode\n");
    exit(EXIT_FAILURE);
}

static int is_valid_base64(const char* str) {
    if (!str) return 0;

    size_t length = strlen(str);

    // Base64 strings must have length multiple of 4
    if (length == 0 || length % 4 != 0) {
        return 0;
    }

    // Each character must be alphanumeric, '+' or '/', or '=' for padding
    for (size_t i = 0; i < length; i++) {
        unsigned char c = (unsigned char)str[i];
        if (!isalnum(c) && c != '+' && c != '/' && c != '=') {
            return 0;
        }
    }

    // Padding '=' only allowed at the end (max two)
    size_t padding_count = 0;
    if (length >= 1 && str[length - 1] == '=') {
        padding_count++;
    }
    if (length >= 2 && str[length - 2] == '=') {
        padding_count++;
    }
    // '=' should not appear before the padding section
    for (size_t i = 0; i < length - padding_count; i++) {
        if (str[i] == '=') {
            return 0;
        }
    }

    return 1;
}

static unsigned char* base64_encode(const unsigned char* input, size_t length, size_t* output_length) {
    if (!input) return NULL;

    // 4 chars for every 3 bytes, rounded up
    size_t encoded_length = 4 * ((length + 2) / 3);
    unsigned char* data = malloc(encoded_length + 1);  // +1 for NUL terminator
    if (!data) return NULL;

    size_t input_index = 0, encoded_index = 0;
    while (input_index < length) {
        uint32_t buffer = 0;
        int remaining = (int)(length - input_index);

        // Pack up to 3 bytes into 24 bits buffer
        buffer |= ((uint32_t)input[input_index++]) << 16;
        if (remaining > 1) {
            buffer |= ((uint32_t)input[input_index++]) << 8;
        }
        if (remaining > 2) {
            buffer |= (uint32_t)input[input_index++];
        }

        // Extract 6-bit groups and map to Base64 chars
        data[encoded_index++] = base64_alphabet[(buffer >> 18) & 0x3F];
        data[encoded_index++] = base64_alphabet[(buffer >> 12) & 0x3F];
        data[encoded_index++] = (remaining > 1) ? base64_alphabet[(buffer >> 6) & 0x3F] : '=';
        data[encoded_index++] = (remaining > 2) ? base64_alphabet[buffer & 0x3F] : '=';
    }

    data[encoded_index] = '\0';  // Null-terminate output string

    if (output_length) {
        *output_length = encoded_index;
    }
    return data;
}

static unsigned char* base64_decode(const unsigned char* input, size_t length, size_t* output_length) {
    if (!input) return NULL;

    unsigned char decoding_table[256];
    memset(decoding_table, 0x80, 256);  // 0x80 marks invalid chars

    for (int i = 0; i < 64; i++) {
        decoding_table[base64_alphabet[i]] = (unsigned char)i;
    }
    decoding_table['='] = 0;

    // Count valid base64 characters (ignore whitespace or invalid chars)
    size_t valid_char_count = 0;
    for (size_t i = 0; i < length; i++) {
        if (decoding_table[input[i]] != 0x80) {
            valid_char_count++;
        }
    }

    if (valid_char_count == 0 || valid_char_count % 4 != 0) {
        return NULL;
    }

    size_t decoded_length = valid_char_count / 4 * 3;
    unsigned char* data = malloc(decoded_length);
    if (!data) return NULL;

    size_t input_index = 0, decoded_index = 0;
    unsigned char block[4];
    int padding_count = 0;
    size_t block_char_count = 0;

    while (input_index < length) {
        unsigned char val = decoding_table[input[input_index++]];
        if (val == 0x80) {
            continue;  // skip invalid chars (including whitespace)
        }

        if (input[input_index - 1] == '=') {
            padding_count++;
        }
        block[block_char_count++] = val;

        if (block_char_count == 4) {
            data[decoded_index++] = (block[0] << 2) | (block[1] >> 4);
            data[decoded_index++] = (block[1] << 4) | (block[2] >> 2);
            data[decoded_index++] = (block[2] << 6) | block[3];
            block_char_count = 0;

            if (padding_count) {
                if (padding_count == 1) {
                    decoded_index--;
                }
                else if (padding_count == 2) {
                    decoded_index -= 2;
                }
                else {
                    free(data);
                    return NULL;  // invalid padding length
                }
                break;
            }
        }
    }

    if (output_length) {
        *output_length = decoded_index;
    }
    return data;
}
