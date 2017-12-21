#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>
#include <MicroGear.h>

const char* ssid = "Reva iPhone"; // replace SSID with your WiFi name
const char* password = "88888888"; // replace PASSWORD with your WiFi password port D0 on the board is the output

//The unit for delay method is millisecond.

// In case there is no password leave the line as “”
#define APPID "FallingIOT" // Replace YOUR_APPID with your NETPIE AppID
#define KEY "Go4ojQ0kYgLOjyw" // Replace YOUR_KEY with your NETPIE application key
#define SECRET "mLY4GVhnPTUsvI1vPnNrjSgHp" // Replace YOUR_SECRET with your NETPIE application secret

#define ALIAS "signal" // Replace pieblink with any name you want to define it as
WiFiClient client;
int timer = 0;
int pin = 4;
int pin2 = 5;
int data;
int data2;
int state = 0;
MicroGear microgear(client); // Create Microgear object
// Event that will handle incoming message
void onMsghandler(char *topic, uint8_t* msg, unsigned int msglen) {
Serial.print("Incoming message -->");
msg[msglen] = '\0';
Serial.println((char *)msg);
// if the incoming message is 1 turn on the light
// if the incoming message is 0 turn off the light
/*if(*(char *)msg == '1'){
digitalWrite(LED_BUILTIN, LOW); // LED on
}else{
digitalWrite(LED_BUILTIN, HIGH); // LED off
}*/
}
// Event handler that will be call when NETPIE connect to this device

void onConnected(char *attribute, uint8_t* msg, unsigned int msglen) {
  Serial.println("Connected to NETPIE...");
  // we can use this to change the define name here or subscribe to any channel to receive message specific channel
  microgear.setAlias(ALIAS);
}
void setup() {
  // if there is an incoming message microgear will call onMsghandler function above
  microgear.on(MESSAGE,onMsghandler);
  // Print that the device is connected to the server in the console
  microgear.on(CONNECTED,onConnected);
  Serial.begin(115200);
  Serial.println("Starting...");
  pinMode(LED_BUILTIN, OUTPUT);
  // initiate Wifi
  if (WiFi.begin(ssid, password)) {
    while (WiFi.status() != WL_CONNECTED) {
      delay(500);
      Serial.print(".");
    }
  }
  pinMode(pin, INPUT);
  pinMode(pin2, INPUT);
  Serial.println("WiFi connected");
  Serial.println("IP address: ");
  Serial.println(WiFi.localIP());

  // initialize variables in microgear
  microgear.init(KEY,SECRET,ALIAS);
  // Connect NETPIE to AppID
  microgear.connect(APPID); // Connect NETPIE function
}

void loop() {
  // Check that the device is still connect to NETPIE
  if (microgear.connected()) { // Check connection status
    Serial.println("connected"); // If connected type connected in the console
    // Call loop to repeat this process once in a while to maintain its connectivity
    microgear.loop();
    if (timer >= 1000) {
      Serial.println("Publish..."); // Sending data to NETPIE server
      // Send message to itself with the opposite state
      data = digitalRead(pin);
      Serial.println("pin1");
      Serial.println(data);
      data2 = digitalRead(pin2);
      Serial.println("pin2");
      Serial.println(data2);
      if(WiFi.status() == WL_CONNECTED){
        Serial.println("state");
        Serial.println(state);
        if(data == 1 && state == 0){
          microgear.chat("WEB","I am FINE");
          Serial.println( "SEND 1 TO SERVER");
          HTTPClient http;    
          http.begin("http://172.20.10.5:3000/send/basic");

          int httpCode = http.POST("Message from ESP8266");
          String payload = http.getString();

          Serial.println(httpCode);
          Serial.println(payload);

          http.end();
          state = 1;
          Serial.println( "SEND 1 TO POST");
        }else if(data2 == 1 && state == 1){
          microgear.chat("WEB","FALLEN");
          Serial.println( "SEND 1 TO SERVER");
          HTTPClient http;    
          http.begin("http://172.20.10.5:3000/send/ok");

          int httpCode = http.POST("Message from ESP8266");
          String payload = http.getString();

          Serial.println(httpCode);
          Serial.println(payload);
          http.end();
          state = 0;
        }else{}
    }else{
      Serial.println("Error in WIFI connection");
    }
    //delay(100);
    timer = 0;
    }
     else timer += 100;
    }
  else {
    Serial.println("connection lost, reconnect...");

    if (timer >= 5000) {
      microgear.connect(APPID);
      timer = 0;
    }
    else timer += 100;
  }
  //delay(100);
}
