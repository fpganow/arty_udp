## Run Udp/Ip parser on the Arty Artix-7 A100T board.

## Requirements:
* Vivado 2019.1
* LabVIEW 2020

## Clone the Repository
`git clone git@github.com:fpganow/arty_udp.git`

## Start Vivado 2019.1 (You can use later versions, but may run into issues)

## [1] Change to the following directory
`cd {E:\work\Arty\arty_udp\Vivado}`

![alt text](pictures/01-Change_Directory.png)

## [2] Source the project script
`source ./a100t_2019_1.tcl`

![alt text](pictures/02-Dir.png)

## [3] Generate Output Products
![alt text](pictures/03-Generate_Output_Products.png)

## [4] Generate Bitstream
![alt text](pictures/04-Generate_Bitstream.png)

## [5] Export Hardware
![alt text](pictures/05-Export_Hardware.png)

## [6] Export Hardware - include bitstream
![alt text](pictures/06-Export_Hardware_Include_Bitstream.png)

## [7] Start the Xilinx SDK (Software Development Kit)
![alt text](pictures/07-Launch_SDK.png)

## [8] Default Location is fine
![alt text](pictures/08-Launch_SDK_Default_Location.png)

## [9] What it looks like
![alt text](pictures/09-SDK-with_Hardware_Platform_Specification.png)

## [10] Create a new Application
![alt text](pictures/10-SDK_Create_lwIP_Echo.png)

## [11] Press next, not finish
![alt text](pictures/11-SDK_Select_Next_not_Finish.png)

## [12] Select lwIP Echo
![alt text](pictures/12-SDK_Select_lwIP.png)

## [13] Here is the default main.c
![alt text](pictures/13-SDK_Default_main_c.png)

## [14] Copy over the provided main.c (should work in 99% of cases)
![alt text](pictures/14-SDK_Overwrite_Provided_main_c.png)

## [15] Make sure the Arty is plugged in and find the COM Port
![alt text](pictures/15-SDK_Find_COM_Port_for_Arty.png)

## [16] I use Putty
![alt text](pictures/16-Putty_Connection_Serial.png)

## [17] If you see some text, a connection has been established
![alt text](pictures/17-Putty_Garbled_On_First_Run.png)

## [18] Program FPGA once
![alt text](pictures/18-SDK_Program_FPGA_First.png)

## [19] Default options are fine
![alt text](pictures/19-SDK_Program_FPGA_Default_Options.png)

## [20] Progress
![alt text](pictures/20-SDK_Program_FPGA_Progress.png)

## [21] Start via Run As
![alt text](pictures/21-SDK_Start_via_Run_As.png)

## [22] Once you ping the device, some ARP messages will appear, use udpSend.py to send payload
![alt text](pictures/22-Putty_After_It_Starts.png)
