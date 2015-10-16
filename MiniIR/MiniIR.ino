#include <RFduinoBLE.h>
//Include the Rfduino Library

// Serial pins for RFduino
int txPin = 5;
int rxPin = 4;

String val= "";  
double multiplier = 100; 
//The value for multiplier needs to be set based on the type of sensor. Value has been sent for the Sprint IR 100% Sensor
uint8_t buffer[25]; 
uint8_t ind =0;

void setup()
{ 
Serial.begin(9600, rxPin, txPin); 

//Starts the UART at 9600 with RX on GPIO 4 and TX on GPIO 3. Start Serial. 
  
 RFduinoBLE.deviceName="CO2 Sensor";
  
  //Sets the device name to be CO2 Sensor. 
  
 RFduinoBLE.advertisementData = "temp";
  
  //Advertize the Data from the RFduino Microcontroller.
  
 RFduinoBLE.begin();
  
  //Start Advertizing the Data from Bluetooth to the Sensor
} 

void loop() 
{ 
while(buffer[ind-1] != 0x0A)
{ 
if(Serial.available())
{ 
buffer[ind] = Serial.read(); 
ind++; } 
} 
report(); 

}
 
void report() 
{ 
 
for(int i=0; i < ind+1; i++) 
{ 
if(buffer[i] == 'z') 
break; 
if((buffer[i] != 0x5A)&&(buffer[i] != 0x20)) 
{ 
val += buffer[i]-48; 
}
}

float co2 = ((multiplier * val.toInt()))/100;  
//Needed to divide value by 100 according to software manual. 
Serial.write( "Co2 = "); 
Serial.write(co2); 
Serial.write("ppm"); 
ind=0;  
val="";




RFduinoBLE.sendFloat(co2);
} 

