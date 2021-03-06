/*
 * image_send.c
 *
 *  Created on: 2021?~3??22??
 *      Author: user
 */


#include <stdio.h>
#include <stdlib.h>
#include "platform.h"
#include "xil_printf.h"
#include "xuartns550.h"
#include "xuartns550_i.h"
#include "sleep.h"

#define imageSize 512*512
#define headerSize 1078
#define fileSize 1862


int main()
{

    init_platform();

    //xil_printf("%s","Hello World\n\r");
    print("Successfully ran image filter application\n\r");

    u8 *imageData;
    u32 Receive_byte=0;
    u32 Total_Receive_byte=0;
    u32 totalTransmittedBytes=0;
    u32 transmittedBytes=0;
    u32 status;
    XUartNs550_Config *myUartConfig;
    XUartNs550 myUart;
    imageData = malloc(sizeof(u8)*(fileSize));
    myUartConfig=XUartNs550_LookupConfig(XPAR_AXI_UART16550_0_DEVICE_ID);
    status=XUartNs550_CfgInitialize(&myUart,myUartConfig,myUartConfig->BaseAddress);
    if (status!=XST_SUCCESS)
    	print("Uart initialization fail \n \r");

    status=XUartNs550_SetBaudRate(&myUart , 9600);
    if (status!=XST_SUCCESS)
    	print("Setbaud initialization fail \n \r");

    while(Total_Receive_byte<fileSize){
    	Receive_byte=XUartNs550_Recv(&myUart, (u8*)&imageData[Total_Receive_byte],100);
    	Total_Receive_byte+=Receive_byte;
    }
    /*
    for(int i =0;i<10;i++){
    	xil_printf("%0x",imageData[i]);
    }
*/
    for (int i=headerSize;i<fileSize;i++){
    	imageData[i]=255-imageData[i];
    }
    while(totalTransmittedBytes<fileSize){
    	transmittedBytes=XUartNs550_Send(&myUart,(u8*)&imageData[totalTransmittedBytes],1);
    	totalTransmittedBytes+=transmittedBytes;
    	usleep(2000);
    }
    cleanup_platform();
    return 0;
}

