# Create work library
vlib work

# Compile Verilog
#     All Verilog files that are part of this design should have
#     their own "vlog" line below.
vlog "./connectFour.sv/"
vlog "./clock_divider.sv/"
vlog "./columnDetetctor/"
vlog "./DE1_SoC.sv/"
vlog "./playerDetector.sv/"
vlog "./LEDDriver.sv/"
vlog "./rEdge.sv/"
vlog "./ledController.sv/"
vlog "./gameBoard.sv/"
vlog "./rowCounter.sv/"
vlog "./userInput.sv/"
vlog "./seg7.sv/"
vlog "./victory.sv/"


# Call vsim to invoke simulator
#     Make sure the last item on the line is the name of the
#     testbench module you want to execute.
vsim -voptargs="+acc" -t 1ps -lib work columnDetector_testbench

# Source the wave do file
#     This should be the file that sets up the signal window for
#     the module you are testing.
do DE1_SoC_wave.do

# Set the window types
view wave
view structure
view signals

# Run the simulation
run -all

# End
