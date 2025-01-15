# Implementation-of-Low-Power-Configurable-Multi-Clock-Digital-System

![Screenshot 2025-01-15 164345](https://github.com/user-attachments/assets/d52166ff-d6aa-46fb-8fa0-821b210ca449)

Description: It is responsible of receiving commands through UART receiver to do different system functions as register file reading/writing or doing some processing using ALU block and send result as well as CRC bits of result using 4 bytes frame through UART transmitter communication protocol.
Project phases: -
- RTL Design from Scratch of system blocks (ALU, Register File, Integer Clock Divider, Clock Gating, Synchronizers, Main Controller, UART TX, UART RX).
- Integrate and verify functionality through self-checking testbench.
- Constraining the system using synthesis TCL scripts.
- Synthesize and optimize the design using design compiler tool.
