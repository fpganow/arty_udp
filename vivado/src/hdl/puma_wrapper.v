`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/13/2021 04:39:46 PM
// Design Name: 
// Module Name: puma_wrapper
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module puma_wrapper(
    ddr3_sdram_addr, // output [13:0]ddr3_sdram_addr
    ddr3_sdram_ba, // output [2:0]ddr3_sdram_ba
    ddr3_sdram_cas_n, // output ddr3_sdram_cas_n
    ddr3_sdram_ck_n, // output [0:0]ddr3_sdram_ck_n
    ddr3_sdram_ck_p, // output [0:0]ddr3_sdram_ck_p
    ddr3_sdram_cke, // output [0:0]ddr3_sdram_cke
    ddr3_sdram_cs_n, // output [0:0]ddr3_sdram_cs_n
    ddr3_sdram_dm, // output [1:0]ddr3_sdram_dm
    ddr3_sdram_dq, // inout [15:0]ddr3_sdram_dq
    ddr3_sdram_dqs_n, // inout [1:0]ddr3_sdram_dqs_n  
    ddr3_sdram_dqs_p, // inout [1:0]ddr3_sdram_dqs_p
    ddr3_sdram_odt, // output [0:0]ddr3_sdram_odt
    ddr3_sdram_ras_n, // output ddr3_sdram_ras_n
    ddr3_sdram_reset_n, // output ddr3_sdram_reset_n
    ddr3_sdram_we_n, // output ddr3_sdram_we_n
    eth_mdio_mdc_mdc, // output eth_mdio_mdc_mdc
    eth_mdio_mdc_mdio_io, // inout eth_mdio_mdc_mdio_io
    eth_ref_clk, // output eth_ref_clk
    phy_col_0, // input phy_col_0
    phy_crs_0, // input phy_crs_0
    phy_dv_0, // input phy_dv_0
    phy_rst_n_0, // output phy_rst_n_0
    phy_rx_clk_0, // input phy_rx_clk_0
    phy_rx_data_0, // input [3:0]phy_rx_data_0
    phy_rx_er_0, // input phy_rx_er_0
    phy_tx_clk_0, // input phy_tx_clk_0
    phy_tx_data_0, // output [3:0]phy_tx_data_0
    phy_tx_en_0, // output phy_tx_en_0
    qspi_flash_io0_io, // inout qspi_flash_io0_io
    qspi_flash_io1_io, // inout qspi_flash_io1_io
    qspi_flash_io2_io, // inout qspi_flash_io2_io
    qspi_flash_io3_io, // inout qspi_flash_io3_io
    qspi_flash_sck_io, // inout qspi_flash_sck_io
    qspi_flash_ss_io, // inout qspi_flash_ss_io
    reset, // input reset
    sys_clock, // input sys_clock
    usb_uart_rxd, // input usb_uart_rxd
    usb_uart_txd, // output usb_uart_txd
    ip_btn_in_1, // input ip_btn_in_1
    ip_btn_in_2, // input ip_btn_in_2
//    ip_btn_in_3, // input ip_btn_in_3
//    ip_btn_in_4, // input ip_btn_in_4
    ip_btn_out_1, // output ip_btn_out_1
    ip_btn_out_2, // output ip_btn_out_2
//    ip_btn_out_3, // output ip_btn_out_3
//    ip_btn_out_4, // output ip_btn_out_4
    ni_reset, // input ni_reset
    ni_enable_in, // input ni_enable_in
    ni_enable_out, // output ni_enable_out
    ni_enable_clr, // input ni_enable_clr
    puma_led1_r, // output puma_led1_r
    puma_led1_g, // output puma_led1_g
    puma_led1_b // output puma_led1_b
);

    output [13:0]ddr3_sdram_addr;
    output [2:0]ddr3_sdram_ba;
    output ddr3_sdram_cas_n;
    output [0:0]ddr3_sdram_ck_n;
    output [0:0]ddr3_sdram_ck_p;
    output [0:0]ddr3_sdram_cke;
    output [0:0]ddr3_sdram_cs_n;
    output [1:0]ddr3_sdram_dm;
    inout [15:0]ddr3_sdram_dq;
    inout [1:0]ddr3_sdram_dqs_n;
    inout [1:0]ddr3_sdram_dqs_p;
    output [0:0]ddr3_sdram_odt;
    output ddr3_sdram_ras_n;
    output ddr3_sdram_reset_n;
    output ddr3_sdram_we_n;
    output eth_mdio_mdc_mdc;
    inout eth_mdio_mdc_mdio_io;
    output eth_ref_clk;
    input phy_col_0;
    input phy_crs_0;
    input phy_dv_0;
    output phy_rst_n_0;
    input phy_rx_clk_0;
    input [3:0]phy_rx_data_0;
    input phy_rx_er_0;
    input phy_tx_clk_0;
    output [3:0]phy_tx_data_0;
    output phy_tx_en_0;
    inout qspi_flash_io0_io;
    inout qspi_flash_io1_io;
    inout qspi_flash_io2_io;
    inout qspi_flash_io3_io;
    inout qspi_flash_sck_io;
    inout qspi_flash_ss_io;
    input reset;
    input sys_clock;
    input usb_uart_rxd;
    output usb_uart_txd;
    input ip_btn_in_1;
    input ip_btn_in_2;
//    input ip_btn_in_3;
//    input ip_btn_in_4;
    output ip_btn_out_1;
    output ip_btn_out_2;
//    output ip_btn_out_3;
//    output ip_btn_out_4;
    input ni_reset;
	input ni_enable_in;
	output ni_enable_out;
	input ni_enable_clr;
	output puma_led1_r;
	output puma_led1_g;
	output puma_led1_b;

    wire [13:0]ddr3_sdram_addr;
    wire [2:0]ddr3_sdram_ba;
    wire ddr3_sdram_cas_n;
    wire [0:0]ddr3_sdram_ck_n;
    wire [0:0]ddr3_sdram_ck_p;
    wire [0:0]ddr3_sdram_cke;
    wire [0:0]ddr3_sdram_cs_n;
    wire [1:0]ddr3_sdram_dm;
    wire [15:0]ddr3_sdram_dq;
    wire [1:0]ddr3_sdram_dqs_n;
    wire [1:0]ddr3_sdram_dqs_p;
    wire [0:0]ddr3_sdram_odt;
    wire ddr3_sdram_ras_n;
    wire ddr3_sdram_reset_n;
    wire ddr3_sdram_we_n;
    wire eth_mdio_mdc_mdc;
    wire eth_mdio_mdc_mdio_i;
    wire eth_mdio_mdc_mdio_io;
    wire eth_mdio_mdc_mdio_o;
    wire eth_mdio_mdc_mdio_t;
    wire eth_ref_clk;
    wire phy_col_0;
    wire phy_crs_0;
    wire phy_dv_0;
    wire phy_rst_n_0;
    wire phy_rx_clk_0;
    wire [3:0]phy_rx_data_0;
    wire phy_rx_er_0;
    wire phy_tx_clk_0;
    wire [3:0]phy_tx_data_0;
    wire phy_tx_en_0;
    wire qspi_flash_io0_i;
    wire qspi_flash_io0_io;
    wire qspi_flash_io0_o;
    wire qspi_flash_io0_t;
    wire qspi_flash_io1_i;
    wire qspi_flash_io1_io;
    wire qspi_flash_io1_o;
    wire qspi_flash_io1_t;
    wire qspi_flash_io2_i;
    wire qspi_flash_io2_io;
    wire qspi_flash_io2_o;
    wire qspi_flash_io2_t;
    wire qspi_flash_io3_i;
    wire qspi_flash_io3_io;
    wire qspi_flash_io3_o;
    wire qspi_flash_io3_t;
    wire qspi_flash_sck_i;
    wire qspi_flash_sck_io;
    wire qspi_flash_sck_o;
    wire qspi_flash_sck_t;
    wire qspi_flash_ss_i;
    wire qspi_flash_ss_io;
    wire qspi_flash_ss_o;
    wire qspi_flash_ss_t;
    wire reset;
    wire sys_clock;
    wire usb_uart_rxd;
    wire usb_uart_txd;
    // Clock
    wire clk_83;
    // This is where data from our 'MAC' comes from - all output
    wire [31:0]   from_mac_data_out_0;
    wire          from_mac_data_valid_out_0;
    wire          from_mac_end_of_frame_out_0;
    // These 3 are the wires going to FIFO #1 to MicroBlaze
    wire [31:0]   to_mb_data_out_0;
    wire          to_mb_data_valid_out_0;
    wire          to_mb_end_of_frame_out_0;
    // Connections to board inputs
    wire ip_btn_in_1;
    wire ip_btn_in_2;
//    wire ip_btn_in_3;
//    wire ip_btn_in_4;
    // Connections to board outputs
    wire ip_btn_out_1;
    wire ip_btn_out_2;
//    wire ip_btn_out_3;
//    wire ip_btn_out_4;
    wire [31:0]ip_addr_tri_o;
    wire [47:0]mac_5_0;
    wire [15:0]udp_port_tri_o;

    design_1_wrapper design_1_wrapper_i(
        // This FIFO is connected to the 2nd (FIFO #1) that is connected
        // to the MicroBlaze
        // RXD means MicroBlaze is receiving data
        .AXI_STR_RXD_0_tdata(to_mb_data_out_0),
        .AXI_STR_RXD_0_tlast(to_mb_end_of_frame_out_0),
        .AXI_STR_RXD_0_tready(),
        .AXI_STR_RXD_0_tvalid(to_mb_data_valid_out_0),
        .AXI_STR_TXD_0_tdata(puma_led1_r),
        .AXI_STR_TXD_0_tlast(puma_led1_g),
        .AXI_STR_TXD_0_tready(1),
        .AXI_STR_TXD_0_tvalid(puma_led1_b),
        .clk_83(clk_83),
        // This is where data from our 'MAC' comes from - all output
//        .data_out_0(from_mac_data_out_0),
//        .data_valid_out_0(from_mac_data_valid_out_0),
//        .end_of_frame_out_0(from_mac_end_of_frame_out_0),
        .data_out_0(from_mac_data_out_0),
        .data_valid_out_0(from_mac_data_valid_out_0),
        .end_of_frame_out_0(from_mac_end_of_frame_out_0),
        // Other
        .ddr3_sdram_addr(ddr3_sdram_addr),
        .ddr3_sdram_ba(ddr3_sdram_ba),
        .ddr3_sdram_cas_n(ddr3_sdram_cas_n),
        .ddr3_sdram_ck_n(ddr3_sdram_ck_n),
        .ddr3_sdram_ck_p(ddr3_sdram_ck_p),
        .ddr3_sdram_cke(ddr3_sdram_cke),
        .ddr3_sdram_cs_n(ddr3_sdram_cs_n),
        .ddr3_sdram_dm(ddr3_sdram_dm),
        .ddr3_sdram_dq(ddr3_sdram_dq),
        .ddr3_sdram_dqs_n(ddr3_sdram_dqs_n),
        .ddr3_sdram_dqs_p(ddr3_sdram_dqs_p),
        .ddr3_sdram_odt(ddr3_sdram_odt),
        .ddr3_sdram_ras_n(ddr3_sdram_ras_n),
        .ddr3_sdram_reset_n(ddr3_sdram_reset_n),
        .ddr3_sdram_we_n(ddr3_sdram_we_n),
        .eth_mdio_mdc_mdc(eth_mdio_mdc_mdc),
        .eth_mdio_mdc_mdio_io(eth_mdio_mdc_mdio_io),
        .eth_ref_clk(eth_ref_clk),
        // Ethernet Configuration
        .ip_addr_tri_o(ip_addr_tri_o),
        .mac_5_0(mac_5_0),
        .phy_col_0(phy_col_0),
        .phy_crs_0(phy_crs_0),
        .phy_dv_0(phy_dv_0),
        .phy_rst_n_0(phy_rst_n_0),
        .phy_rx_clk_0(phy_rx_clk_0),
        .phy_rx_data_0(phy_rx_data_0),
        .phy_rx_er_0(phy_rx_er_0),
        .phy_tx_clk_0(phy_tx_clk_0),
        .phy_tx_data_0(phy_tx_data_0),
        .phy_tx_en_0(phy_tx_en_0),
        .qspi_flash_io0_io(qspi_flash_io0_io),
        .qspi_flash_io1_io(qspi_flash_io1_io),
        .qspi_flash_io2_io(qspi_flash_io2_io),
        .qspi_flash_io3_io(qspi_flash_io3_io),
        .qspi_flash_sck_io(qspi_flash_sck_io),
        .qspi_flash_ss_io(qspi_flash_ss_io),
        .reset(reset),
        .sys_clock(sys_clock),
        .udp_port_tri_o(udp_port_tri_o),
        .usb_uart_rxd(usb_uart_rxd),
        .usb_uart_txd(usb_uart_txd));

    wire [31:0]mac_3_0_tri_o;
    wire [15:0]mac_5_4_tri_o;

    NiFpgaIPWrapper_fpga_top labview_i (
        .reset(ni_reset),
        .enable_in(ni_enable_in),
        .enable_out(ni_enable_out),
        .enable_clr(ni_enable_clr),
        // Configuration of Ethernet
        .ctrlind_03_MAC_Address(mac_5_0),
        .ctrlind_04_IP_Address(ip_addr_tri_o),
        .ctrlind_05_Dest_Port(udp_port_tri_o),
        // Data coming from Block Design MAC and going in to
        // the LabVIEW IP
        .ctrlind_06_data_in(from_mac_data_out_0),
        .ctrlind_07_data_valid_in(from_mac_data_valid_out_0),
        .ctrlind_08_end_of_frame_in(from_mac_end_of_frame_out_0),
        // Data coming out of the LabVIEW IP going to the 
        // FIFO for receiving
        .ctrlind_00_tlast(to_mb_end_of_frame_out_0),
        .ctrlind_01_tvalid(to_mb_data_valid_out_0),
        .ctrlind_02_tdata(to_mb_data_out_0),
        // Push buttons and LEDs
        .ctrlind_09_out_2(ip_btn_out_2),
        .ctrlind_10_out_1(ip_btn_out_1),
        .ctrlind_11_in_2(ip_btn_in_2),
        .ctrlind_12_in_1(ip_btn_in_1),
        .Clk40Derived2x1I0MHz(clk_83)
        );

endmodule