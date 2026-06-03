IMAGE_NAME = aarch64-build-env

# Check if we are running inside the Docker container
ifdef AM_I_IN_A_CONTAINER
    # =========================================================================
    # INSIDE DOCKER: COMPILATION ENVIRONMENT
    # =========================================================================
    CC = aarch64-linux-gnu-gcc
    AS = aarch64-linux-gnu-as
    LD = aarch64-linux-gnu-ld

    CFLAGS = -ffreestanding -nostdlib -O2 -Wall -Wextra -Werror -mgeneral-regs-only -fno-builtin -fno-stack-protector -fno-omit-frame-pointer -g -I/workspace
    LDFLAGS = -T linker.ld -nostdlib

    BUILD_DIR = ./build
    TARGET = $(BUILD_DIR)/nduva.elf

    CSRCS = kernel/main.c \
			$(wildcard kernel/drivers/*.c) \
      $(wildcard kernel/traps/*.c) \
      $(wildcard user/libs/*.c) \

    ASRCS = boot.S \
          $(wildcard kernel/traps/*.S)
    OBJS = $(addprefix $(BUILD_DIR)/, $(notdir $(CSRCS:.c=.o) $(ASRCS:.S=.o)))
    VPATH = $(sort $(dir $(CSRCS)))

    all: $(TARGET)

    $(TARGET): $(OBJS)
		@mkdir -p $(BUILD_DIR)
		$(CC) $(CFLAGS) $(LDFLAGS) $(OBJS) -o $(TARGET)

    $(BUILD_DIR)/%.o: %.c
		@mkdir -p $(BUILD_DIR)
		$(CC) $(CFLAGS) -c $< -o $@

    $(BUILD_DIR)/%.o: %.S
		@mkdir -p $(BUILD_DIR)
		$(CC) $(CFLAGS) -c $< -o $@

    clean:
		rm -rf $(BUILD_DIR)

else
    # =========================================================================
    # OUTSIDE DOCKER: HOST INTERACTION ENVIRONMENT
    # =========================================================================
    QEMU = qemu-system-aarch64
    QEMU_FLAGS = -M virt -cpu cortex-a53 -nographic -s -kernel
    TARGET = ./build/nduva.elf

    .PHONY: all clean run

    # Redirect build to Docker
    all:
		docker run --rm -e AM_I_IN_A_CONTAINER=true -v "$$(pwd)":/workspace $(IMAGE_NAME) make all --debug=v

    # Redirect clean to Docker
    clean:
		docker run --rm -e AM_I_IN_A_CONTAINER=true -v "$$(pwd)":/workspace $(IMAGE_NAME) make clean

    # Compile via Docker FIRST, then boot QEMU directly on your host machine
    run: all
		$(QEMU) $(QEMU_FLAGS) $(TARGET)

endif
