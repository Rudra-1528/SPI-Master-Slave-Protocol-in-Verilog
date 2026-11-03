# SPI Master-Slave Protocol in Verilog (Deployed on MAX 10 FPGA)

## Overview
This project implements a complete, parameterized **Serial Peripheral Interface (SPI)** protocol from scratch in Verilog. Designed with a dual-clock architecture, it bridges a high-speed FPGA system clock down to standard serial communication speeds. The design was verified in Xilinx Vivado via a self-checking testbench and successfully synthesized and deployed onto physical hardware using an Intel MAX 10 FPGA (DE10-Lite).

## Key Technical Highlights
* **Dual-Clock Domain Architecture:** Implemented a synchronous clock divider to step down the 50MHz FPGA system clock (`sys_clk`) to a 1MHz serial clock (`sclk`) to drive the SPI bus.
* **Parameterized Design:** Configurable clock frequencies and variable data widths (currently set to 12-bit transmission).
* **FSM-Based Control:** Utilized a Finite State Machine to control `CS` (Chip Select), `MOSI` (Master Out Slave In), and capture `MISO` (Master In Slave Out) data using shift registers.
* **Hardware Porting & Decoding:** Successfully mapped the RTL design to physical hardware using Intel Quartus Prime. Included a custom 7-segment display decoder to translate the raw 12-bit binary output into human-readable Hexadecimal directly on the FPGA board.

## Verification & Synthesis
The design was first verified using a **Loopback Testbench** where the `MOSI` output was wired directly to the `MISO` input to ensure 100% data reconstruction. It was then synthesized in Quartus with zero timing violations or multiple-driver conflicts.

### 1. Vivado Simulation Waveform
![Simulation Waveform]()

### 2. Vivado RTL Schematic
*(Drag and drop your RTL Schematic screenshot here!)*

### 3. Hardware Deployment (Intel MAX 10 DE10-Lite)
*(Drag and drop a photo of your physical FPGA board here, showing the switches set to a binary pattern and the 7-segment displays showing the correct Hexadecimal equivalent!)*
