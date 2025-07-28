# Booth's Multiplier Implementation

This repository showcases the hardware implementation of a high-speed binary multiplier system, meticulously designed in Verilog HDL and deployed on a Basys-3 FPGA board. The system leverages Booth's Algorithm for efficient multiplication of signed binary numbers.
<img width="788" height="691" alt="Booth'sAlgoFlow drawio" src="https://github.com/user-attachments/assets/fb9ed837-516d-4e60-9877-70b2c671d71c" />

*Figure 1: Flowchart for Booth's Algorithm*

Its core architecture comprises a distinctively designed Control Unit, powered by an optimized Finite State Machine (FSM) where each state governs a specific operation, and a robust Datapath. The Datapath integrates several load and shift-enabled registers, along with dedicated load registers, all precisely controlled by signals from the Control Unit.
<img width="1076" height="460" alt="MultiplierSysRTL" src="https://github.com/user-attachments/assets/9342c633-0d40-4fd9-8d71-013171e10361" />

*Figure 2: Multiplier System (RTL Elaborated Image)*

<img width="947" height="268" alt="MultCURTL" src="https://github.com/user-attachments/assets/3e9f58be-c418-4d5d-84da-af1c8443b580" />

*Figure 1:  Control Unit of the System (RTL Elaborated Image)*

<img width="818" height="432" alt="MulDatapathRTL" src="https://github.com/user-attachments/assets/5b1f63c3-05af-4075-9d65-216d84015265" />

*Figure 1:  Datapath of the System (RTL Elaborated Image)*

<img width="1061" height="209" alt="MultWaveform" src="https://github.com/user-attachments/assets/db8fb84c-c796-404e-8a24-296ca71cc688" />

*Figure 1: Waveform Generated from Simultaion*

Development was conducted within Xilinx Vivado, encompassing RTL elaboration for architectural insight, test bench simulations to verify timing performance, and a complete implemented design generating comprehensive area, power, and timing reports.
