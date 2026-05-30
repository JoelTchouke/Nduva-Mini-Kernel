# Nduva-Mini-Kernel

A bare-metal kernel focused on reliability, observability, and recovery for embedded systems. This code runs directly on the computer hardware without using an operating system like Linux or Windows.

---

## Project Structure

* **boot.S**: Written in assembly language. It sets up the processor memory so the C code can start running.
* **linker.ld**: A configuration file that tells the compiler exactly where to place the code inside the computer's memory.
* **main.c**: The main program file where the core code starts and runs forever in a loop.
* **drivers/uartDriver.c**: Code that talks directly to the serial port hardware so the kernel can print text to your screen.

---

## Requirements

Before you start, you must install two tools on your actual computer:
1. **Docker**: Used to automatically compile the code inside a clean environment.
2. **QEMU**: A hardware emulator used to run and test the compiled code.

---

## How to Build and Run

You do not need to install complex compilers. The build file handles everything inside Docker automatically.

To compile your code and start the kernel, run this command in your terminal:

```bash
make run
```

To delete all the compiled files and start fresh, run:

```bash
make clean
```

---

## How to Stop the Program

When you run the kernel, it takes over your terminal window. Normal keys like `Ctrl + C` will not stop it. 

To exit the program and get your terminal back, press this key sequence:
1. Press **`Ctrl + A`** at the same time.
2. Release those keys, then press the **`X`** key.
