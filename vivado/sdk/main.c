/*
 * Copyright (C) 2009 - 2019 Xilinx, Inc.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 *    this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 * 3. The name of the author may not be used to endorse or promote products
 *    derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR IMPLIED
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT
 * SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT
 * OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
 * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY
 * OF SUCH DAMAGE.
 *
 */

#include <stdio.h>

#include "xparameters.h"

#include "netif/xadapter.h"

#include "platform.h"
#include "platform_config.h"
#if defined (__arm__) || defined(__aarch64__)
#include "xil_printf.h"
#endif

#include "lwip/tcp.h"
#include "xil_cache.h"

//////////////////////////////////////////////////////////////////////////////
#include "xgpio.h"
#include "xllfifo.h"
#include "xstatus.h"

#define MAX_FRAME_SIZE 1506
#define WORD_SIZE 4
//////////////////////////////////////////////////////////////////////////////

#if LWIP_IPV6==1
#include "lwip/ip.h"
#else
#if LWIP_DHCP==1
#include "lwip/dhcp.h"
#endif
#endif

/* defined by each RAW mode application */
void print_app_header();
int start_application();
int transfer_data();
void tcp_fasttmr(void);
void tcp_slowtmr(void);

/* missing declaration in lwIP */
void lwip_init();

#if LWIP_IPV6==0
#if LWIP_DHCP==1
extern volatile int dhcp_timoutcntr;
err_t dhcp_start(struct netif *netif);
#endif
#endif

extern volatile int TcpFastTmrFlag;
extern volatile int TcpSlowTmrFlag;
static struct netif server_netif;
struct netif *echo_netif;

#if LWIP_IPV6==1
void print_ip6(char *msg, ip_addr_t *ip)
{
	print(msg);
	xil_printf(" %x:%x:%x:%x:%x:%x:%x:%x\n\r",
			IP6_ADDR_BLOCK1(&ip->u_addr.ip6),
			IP6_ADDR_BLOCK2(&ip->u_addr.ip6),
			IP6_ADDR_BLOCK3(&ip->u_addr.ip6),
			IP6_ADDR_BLOCK4(&ip->u_addr.ip6),
			IP6_ADDR_BLOCK5(&ip->u_addr.ip6),
			IP6_ADDR_BLOCK6(&ip->u_addr.ip6),
			IP6_ADDR_BLOCK7(&ip->u_addr.ip6),
			IP6_ADDR_BLOCK8(&ip->u_addr.ip6));

}
#else
void
print_ip(char *msg, ip_addr_t *ip)
{
	print(msg);
	xil_printf("%d.%d.%d.%d\n\r", ip4_addr1(ip), ip4_addr2(ip),
			ip4_addr3(ip), ip4_addr4(ip));
}

void
print_ip_settings(ip_addr_t *ip, ip_addr_t *mask, ip_addr_t *gw)
{

	print_ip("Board IP: ", ip);
	print_ip("Netmask : ", mask);
	print_ip("Gateway : ", gw);
}
#endif

#if defined (__arm__) && !defined (ARMR5)
#if XPAR_GIGE_PCS_PMA_SGMII_CORE_PRESENT == 1 || XPAR_GIGE_PCS_PMA_1000BASEX_CORE_PRESENT == 1
int ProgramSi5324(void);
int ProgramSfpPhy(void);
#endif
#endif

#ifdef XPS_BOARD_ZCU102
#ifdef XPAR_XIICPS_0_DEVICE_ID
int IicPhyReset(void);
#endif
#endif

int main()
{
#if LWIP_IPV6==0
	ip_addr_t ipaddr, netmask, gw;

#endif
	/* the mac address of the board. this should be unique per board */
	unsigned char mac_ethernet_address[] =
	{ 0x00, 0x0a, 0x35, 0x00, 0x01, 0x02 };

	echo_netif = &server_netif;
#if defined (__arm__) && !defined (ARMR5)
#if XPAR_GIGE_PCS_PMA_SGMII_CORE_PRESENT == 1 || XPAR_GIGE_PCS_PMA_1000BASEX_CORE_PRESENT == 1
	ProgramSi5324();
	ProgramSfpPhy();
#endif
#endif

/////////////////////////////////////////////////////////////////
	printf("-1-\n");
	XGpio gpio_0;
	XGpio gpio_1;

	XGpio_Initialize(&gpio_0, XPAR_AXI_GPIO_0_DEVICE_ID);
	XGpio_Initialize(&gpio_1, XPAR_AXI_GPIO_1_DEVICE_ID);

	// Write IP Address
	// 192  C0
	// 168  A8
	//   1   1
	//  60  3C
	u32 ip_addr = (  ((u32)192 << 24) | ((u32)168 << 16) | ((u32)1 << 8) | ((u32)60)   );
	XGpio_DiscreteWrite(&gpio_0, 2, ip_addr); // ip address
	printf("-2-Setting IP Address to: 0x%x\n", ip_addr);

	// Write Port
	u16 port = 0x1771;
	XGpio_DiscreteWrite(&gpio_0, 1, port); // port
	printf("-3-Setting Port to: 0x%x\n", port);

	// Write MAC Address
	// 00-0A-35-00-01-02
	u32 mac_3_0 = 0x35000102;
	u16 mac_5_4 = 0x000a;
	XGpio_DiscreteWrite(&gpio_1, 1, mac_3_0); // mac3-0
	printf("-4-Setting MAC Address to: %x%x\n", mac_5_4, mac_3_0);
	XGpio_DiscreteWrite(&gpio_1, 2, mac_5_4); // mac5-4


/////////////////////////////////////////////////////////////////
/* Define this board specific macro in order perform PHY reset on ZCU102 */
#ifdef XPS_BOARD_ZCU102
	if(IicPhyReset()) {
		xil_printf("Error performing PHY reset \n\r");
		return -1;
	}
#endif

	init_platform();

#if LWIP_IPV6==0
#if LWIP_DHCP==1
    ipaddr.addr = 0;
	gw.addr = 0;
	netmask.addr = 0;
#else
	/* initliaze IP addresses to be used */
	IP4_ADDR(&ipaddr,  192, 168,   1, 10);
	IP4_ADDR(&netmask, 255, 255, 255,  0);
	IP4_ADDR(&gw,      192, 168,   1,  1);
#endif
#endif
	print_app_header();

	lwip_init();

#if (LWIP_IPV6 == 0)
	/* Add network interface to the netif_list, and set it as default */
	if (!xemac_add(echo_netif, &ipaddr, &netmask,
						&gw, mac_ethernet_address,
						PLATFORM_EMAC_BASEADDR)) {
		xil_printf("Error adding N/W interface\n\r");
		return -1;
	}
#else
	/* Add network interface to the netif_list, and set it as default */
	if (!xemac_add(echo_netif, NULL, NULL, NULL, mac_ethernet_address,
						PLATFORM_EMAC_BASEADDR)) {
		xil_printf("Error adding N/W interface\n\r");
		return -1;
	}
	echo_netif->ip6_autoconfig_enabled = 1;

	netif_create_ip6_linklocal_address(echo_netif, 1);
	netif_ip6_addr_set_state(echo_netif, 0, IP6_ADDR_VALID);

	print_ip6("\n\rBoard IPv6 address ", &echo_netif->ip6_addr[0].u_addr.ip6);

#endif
	netif_set_default(echo_netif);

	/* now enable interrupts */
	platform_enable_interrupts();

	/* specify that the network if is up */
	netif_set_up(echo_netif);

#if (LWIP_IPV6 == 0)
#if (LWIP_DHCP==1)
	/* Create a new DHCP client for this interface.
	 * Note: you must call dhcp_fine_tmr() and dhcp_coarse_tmr() at
	 * the predefined regular intervals after starting the client.
	 */
	dhcp_start(echo_netif);
	dhcp_timoutcntr = 24;

	while(((echo_netif->ip_addr.addr) == 0) && (dhcp_timoutcntr > 0))
		xemacif_input(echo_netif);

	if (dhcp_timoutcntr <= 0) {
		if ((echo_netif->ip_addr.addr) == 0) {
			xil_printf("DHCP Timeout\r\n");
			xil_printf("Configuring default IP of 192.168.1.10\r\n");
			IP4_ADDR(&(echo_netif->ip_addr),  192, 168,   1, 10);
			IP4_ADDR(&(echo_netif->netmask), 255, 255, 255,  0);
			IP4_ADDR(&(echo_netif->gw),      192, 168,   1,  1);
		}
	}

	ipaddr.addr = echo_netif->ip_addr.addr;
	gw.addr = echo_netif->gw.addr;
	netmask.addr = echo_netif->netmask.addr;
#endif

	print_ip_settings(&ipaddr, &netmask, &gw);

#endif
	//////////////////////////////////////////////////////////////////////////////
	XLlFifo fifo_1, fifo_2;
	int Status;
	XLlFifo_Config *Config;

	Status = XST_SUCCESS;

	// Initialize FIFO #1
	Config = XLlFfio_LookupConfig(XPAR_AXI_FIFO_0_DEVICE_ID);
	if (!Config)
	{
		print("Error looking up config\n\r");
		return -1;
	}
	Status = XLlFifo_CfgInitialize(&fifo_1, Config, Config->BaseAddress);
	if (Status != XST_SUCCESS)
	{
		print("Error running fifo config\n\r");
		return -2;
	}
	// Initialize FIFO #2
	Config = XLlFfio_LookupConfig(XPAR_AXI_FIFO_1_DEVICE_ID);
	if (!Config)
	{
		print("Error looking up config\n\r");
		return -1;
	}
	Status = XLlFifo_CfgInitialize(&fifo_2, Config, Config->BaseAddress);
	if (Status != XST_SUCCESS)
	{
		print("Error running fifo config\n\r");
		return -2;
	}

	u32 recv_len;
	char buffer[MAX_FRAME_SIZE];
	char pkt_buffer[MAX_FRAME_SIZE * 6];
	//////////////////////////////////////////////////////////////////////////////
	/* start the application (web server, rxtest, txtest, etc..) */
	start_application();

	/* receive and process packets */
	while (1) {
		if (TcpFastTmrFlag) {
			tcp_fasttmr();
			TcpFastTmrFlag = 0;
		}
		if (TcpSlowTmrFlag) {
			tcp_slowtmr();
			TcpSlowTmrFlag = 0;
		}
		xemacif_input(echo_netif);
		transfer_data();
		//////////////////////////////////////////////////////////////////////////////
		recv_len = (XLlFifo_iRxGetLen(&fifo_1))/WORD_SIZE;
		if(recv_len > 0) {
			XLlFifo_Read(&fifo_1, buffer, (recv_len * WORD_SIZE));

			if((buffer[48] == 0x08 && buffer[52] == 0x06)) {
				printf("ARP: 0x%.2x - 0x%.2x\n\r", buffer[48], buffer[52]);
			}
			else if((buffer[48] == 0x08) && (buffer[52] == 0x00)) {

				if((unsigned char)buffer[120] == 192 && (unsigned char)buffer[124] == 168 && (unsigned char)buffer[128] == 1 && (unsigned char)buffer[132] == 60) {
					printf("IPv4: 0x%.2x - 0x%.2x\n\r", (unsigned char)buffer[48], (unsigned char)buffer[52]);
					printf("DST_IP: %d.%d.%d.%d\n\r", (unsigned char)buffer[120], (unsigned char)buffer[124], (unsigned char)buffer[128], (unsigned char)buffer[132]);
					size_t offset = 0;
					pkt_buffer[0] = '\0';
					int j=0;
					for(j = 0; j < recv_len; j++) {
						int index = (j*4);
						offset = strlen(pkt_buffer);
						if(offset > 1000) {
							printf("ERROR!!! offset=%d\n", offset);
							printf("offset: %d, value: %.2x\n", offset, (unsigned char)buffer[index+0]);
							break;
						} else {
							sprintf(pkt_buffer + offset, "%.2x, ", (unsigned char)buffer[index+0]);
						}
					}
					printf("%s\n", pkt_buffer);
				}
				continue;
			} else {
				//printf("[FIFO #2] Other: recv_len = %d (0x%x)\n\r", recv_len, recv_len);
				continue;
			}

		}
		recv_len = (XLlFifo_iRxGetLen(&fifo_2))/WORD_SIZE;
		if(recv_len > 0) {
			XLlFifo_Read(&fifo_2, buffer, (recv_len * WORD_SIZE));
			printf("[FIFO #2] recv_len = %d (0x%x)\n\r", recv_len, recv_len);

			int j=0;
			for(j = 0; j < recv_len; j++) {
				int index = (j*4);
//						printf("[FIFO #2] word[%3d], [index=%3d] = %.2x-%.2x-%.2x-%.2x\n", j, index, (unsigned char)buffer[index+0], (unsigned char)buffer[index+1], (unsigned char)buffer[index+2], (unsigned char)buffer[index+3]);
			}
		}
		//////////////////////////////////////////////////////////////////////////////
	}

	/* never reached */
	cleanup_platform();

	return 0;
}
