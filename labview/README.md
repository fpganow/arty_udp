## How to Edit the LabVIEW FPGA IP and re-run the demo on the Arty Artix-7 Board

## Requirements:
* Vivado 2019.1
* LabVIEW 2020

## Clone the Repository
`git clone git@github.com:fpganow/arty_udp.git`

## [1] Start LabVIEW 2020 - not 2020 SP1
![alt text](pictures/01-Labview_Open_Project.png)

## [2] Select LabVIEW project file 'demo_1.lvproj' (probably will be renamed soon)
![alt text](pictures/02-Labview_Select_Project.png)

## [3] Take a look at the Test Harness
![alt text](pictures/03-Open_Test_Harness.png)

## [4] Make sure you are in FPGA Simulation Mode
![alt text](pictures/04-Make_Sure_Simulation_Mode.png)

## [5] Look at the String input, it is the same as the output from the MicroBlaze C++ Console.  You can copy the output directly in to this String input.
![alt text](pictures/05-Look-At-String-Input.png)

## [6] Run the VI in Simulation mode, and then you will see the decoded UDP payload.  In the following screen shot, you see 4 garbled characteres, these are the CRC of the Ethernet Frame that I have not yet trimmed from the UDP/IP processor.
![alt text](pictures/06-Udp_Payload.png)

## [7] Take a look at fpga_top.vi
![alt text](pictures/07-Open_Fpga_Top.png)

## [8] The only VI is called udp_reader.vi, all the fancy sub-vi's (colored reddish) are part of the LabVIEW Network (UDP/IP) library.
![alt text](pictures/08-Make_Changes.png)

## [9] Now switch back to FPGA Target
![alt text](pictures/09-Set_to_Target.png)

## [10] Right-click on the build specification and select 'Export VI to Netlist File'
![alt text](pictures/10-Export_to_Netlist.png)

## [11] Pay attention, there is no waiting for you to click 'OK' or 'Finished'
![alt text](pictures/11-Pay_Attention.png)

## [12] Browse to the C:\NIFPGA\compilation directory, the newest file (by date/time) is what you want to look at.
![alt text](pictures/12-Get_Results_Latest_Date.png)

## [13] Copy both the dcp and the vhd file.  The VHD should not have changed unless you made some changes to the controls and indicators on the top level VI.
![alt text](pictures/13-Copy_Both_Files.png)

## [14] Yes, overwrite them
![alt text](pictures/14-Overwrite.png)

## [15] Run Generate Bitstream
![alt text](pictures/15-Generate_Bitstream_Again.png)

## [16] Export the Hardware
![alt text](pictures/16-Export_Hardware_Again.png)

## [17] If your Xilinx SDK is already loaded (as it should be) you will see the following warning
![alt text](pictures/17-Regenerate_bsp_and_the_rest.png)

## [18] Re-generate BSP files from the echo_bsp project, the echo project should auto-build and you can run the app with the latest changes made in the FPGA.