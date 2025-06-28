This repository showcases the hardware implementation of a high-speed binary multiplier system, meticulously designed in Verilog HDL and deployed on a Basys-3 FPGA board. The system leverages Booth's Algorithm for efficient multiplication of signed binary numbers.

Its core architecture comprises a distinctively designed Control Unit, powered by an optimized Finite State Machine (FSM) where each state governs a specific operation, and a robust Datapath. The Datapath integrates several load and shift-enabled registers, along with dedicated load registers, all precisely controlled by signals from the Control Unit.

Development was conducted within Xilinx Vivado, encompassing RTL elaboration for architectural insight, test bench simulations to verify timing performance, and a complete implemented design generating comprehensive area, power, and timing reports.
