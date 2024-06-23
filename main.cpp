#include "TAL.h"

/* STL */
#include <chrono>
#include <iostream>
#include <thread>

int main(int argc, char* argv[])
{
    const char* device = "4458";
    auto ctrlIdx = 0u;

    TAL_SessionHandleType sessionHandle;

    /*
     * Start the device
     */
    TAL_ReturnType nTALRet =
        TAL_StartupDefault(&sessionHandle,
            TAL_EB2200,
            TAL_USB,
            device,
            TAL_TRUE,
            TAL_TRUE);

    if (nTALRet != TAL_SUCCESS)
    {
        std::cout<< "Failed to start the device." << TAL_ReturnType2Str(nTALRet)<<std::endl;
        return 1;
    }
    std::cout << "[i] Successfully connected to device." << std::endl; 

        nTALRet = TAL_InspConfigureEth(sessionHandle,
            ctrlIdx,
            TAL_BM_ETH_SPEED_1000_MBPS;
            TAL_BM_ETH_DUPLEX_FULL;
            0,
            0,
            0);

    if (nTALRet != TAL_SUCCESS)
    {
        std::cout << "Error in TAL_InspConfigureEth." << TAL_ReturnType2Str(nTALRet) << std::endl;
        TAL_ResetAndDeleteSession(sessionHandle);
        return 1;
    }
    std::cout << "[i] Successfully configured ethernet controller." << std::endl;
    // Array of data to send

    uint8_t data[] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x02, 0x84, 0xcf, 0x3b, 0xbe, 0x00, 0x8e, 0x81, 0x00, 0x00, 0x49, 0x08, 0x06, 0x00, 0x01 };

    std::cout << "[i] Starting to send..." << std::endl;

    /*
     * Send raw Ethernet frames
     */
    while (true)
    {
        nTALRet = TAL_SendEthMsgTimed(sessionHandle,  // Handle of the established session
            ctrlIdx,        // Ethernet controller index
            0,              // Target-Timestamp when the given message should be transmitted. Zero for immediately
            data,           // Pointer to data buffer
            sizeof(data));  // Length of the data (in bytes) in pBuffer

        if (nTALRet != TAL_SUCCESS)
        {
            std::cout << "Error in TAL_SendEthMsgTimed: " << TAL_ReturnType2Str(nTALRet) << std::endl;

            /*
             * Delete the session
             */
            TAL_ResetAndDeleteSession(sessionHandle);

            return 1;
        }
        std::this_thread::sleep_for(std::chrono::seconds(2));

    }
    TAL_ResetAndDeleteSession(sessionHandle);
    return 0;
}