Hardware-Efficient Implementation of the Fast Chebyshev Transform for Speech Signal Processing
Overview
This project provides a hardware-efficient implementation of the Fast Chebyshev Transform (FCT) designed for Speech Signal Processing applications. 
The design is written in Verilog and is optimized for Basys -3 FPGA board and ASIC 180nm CMOS technology

Features
Pipelined Architecture: Utilizes a multi-stage pipeline (Stage 0 to Stage 4) to maximize throughput.
Stream Processing: Includes a top-level streaming interface (dct16_stream_top.v) for continuous data input.
Hardware Efficient: Optimized for resource utilization (LUTs, DSPs, Registers).
Complete Testbench: Includes a testbench (tb.v) for verification and simulation.

Repository Structure
Here is a brief description of the files included in this repository:
dct16_stream_top.v: The top-level module containing the streaming interface.
dct_stage0_input.v to dct_stage4_y.v: The individual pipeline stages of the transform algorithm.
fct.xdc: Xilinx Design Constraints file (used for pin mapping and timing constraints).
tb.v: The Verilog testbench used to simulate and verify the design.
Tools & Requirements
To simulate and synthesize this project, you will need:

For FPGA Simulation, Synthesis, and Implementation:
Xilinx Vivado 2025.1

For ASIC Simulation, Synthesis, and Implementation:
Simulation: Cadence Xcelium
Synthesis: Cadence Genus
Physical Design (Floorplanning, Power Planning, CTS, and Routing): Cadence Innovus
Final Physical Verification (DRC/LVS): Cadence Virtuoso & Siemens Calibre
