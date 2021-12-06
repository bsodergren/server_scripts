#ifndef STASSID
#define STASSID "MLSC-Wifi"
#define STAPSK  "sofie2013"
#endif

#ifndef MLSC_CLIENT_IP

  #define USE_DHCP 1
  #define NUM_LEDS 60
  #ifdef MLSC_CLIENT_HOSTNAME
       char* host = MLSC_CLIENT_HOSTNAME; 
  #endif
    
#endif
 
#if MLSC_CLIENT_IP==11
  const char* host = "Closet";
 #define MLSC_CLIENT_HOSTNAME 1
  #define NUM_LEDS 120

#elif MLSC_CLIENT_IP==12
#define MLSC_CLIENT_HOSTNAME 1
  const char* host = "Center";
  #define NUM_LEDS 120

#elif MLSC_CLIENT_IP==13
#define MLSC_CLIENT_HOSTNAME 1
  const char* host = "Wall";
  #define NUM_LEDS 120

#elif MLSC_CLIENT_IP==14
#define MLSC_CLIENT_HOSTNAME 1
  const char* host = "Left-Center";
  #define NUM_LEDS 120

#elif MLSC_CLIENT_IP==15
#define MLSC_CLIENT_HOSTNAME 1
  const char* host = "Right-Center";
  #define NUM_LEDS 120
#endif


#define BUFFER_LEN 1024
#define PRINT_FPS 0
#define LED 2

const uint8_t PixelPin = 3;
unsigned int localPort = 7777;


char packetBuffer[BUFFER_LEN];
const char* ssid = STASSID;
const char* password = STAPSK;
