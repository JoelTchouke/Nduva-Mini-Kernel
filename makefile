CC = aarch64-elf-gcc
AS = aarch64-elf-as
LD = aarch64-elf-ld

CFLAGS = -ffreestanding -nostdlib -O2 -Wall -Wextra -Werror -mgeneral-regs-only -fno-builtin -fno-stack-protector -fno-omit-frame-pointer -g
LDFLAGS = -T linker.ld -nostdlib

QEMU = qemu-system-aarch64
QEMU_FLAGS = -M virt -cpu cortex-a53 -nographic -s -kernel

BUILD_DIR = ./build
TARGET = $(BUILD_DIR)/output.elf

# List your actual source files here
CSRCS = main.c
ASRCS = boot.S

# Automatically map source files to object files in the build directory
OBJS = $(patsubst %.c,$(BUILD_DIR)/%.o,$(CSRCS)) $(patsubst %.S,$(BUILD_DIR)/%.o,$(ASRCS))

.PHONY: all clean run

all: $(TARGET)

# Link step: combines all object files into the final .elf
$(TARGET): $(OBJS)
	@mkdir -p $(BUILD_DIR)
	$(CC) $(CFLAGS) $(LDFLAGS) $(OBJS) -o $(TARGET)

# Compilation rule for C files
$(BUILD_DIR)/%.o: %.c
	@mkdir -p $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

# Assembly rule for .S files
$(BUILD_DIR)/%.o: %.S
	@mkdir -p $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -rf $(BUILD_DIR)

run: $(TARGET)
	$(QEMU) $(QEMU_FLAGS) $(TARGET)
