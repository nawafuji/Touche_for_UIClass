#include <SPI.h>

//const byte 

#define N 200

bool isStarted = false;
const int ssPin = 10;
const int ctrPin = 7;
const int incPin = 5;
const int buttonPin = 6;
const int mvPin = DAC0;
const int adcPin = 8;
int val[N];
int freq[N];
int sizeOfArray = N;
int num;

void setup() {
  // put your setup     code here, to run once:
  pinMode(buttonPin, INPUT);
  pinMode(ctrPin, OUTPUT);
  pinMode(incPin, INPUT);
  digitalWrite(ctrPin, LOW);
  analogWrite(mvPin, 0);
  
  analogReadResolution(12);
  
  Serial.begin(57600);
  while(!Serial);
    
  pinMode(ssPin, OUTPUT);
  digitalWrite(ssPin ,HIGH);
  
  SPI.begin();
  

  
  SPI.setClockDivider(84);
  SPI.setDataMode(SPI_MODE2);
  SPI.setBitOrder(MSBFIRST);
  
  delay(500);
  
  initializeAd5932();
  
  
  for(int i=0; i<N; i++){
    val[i] = 0;
    freq[i] = 0;
  }
  num = 0;
  //Serial.println("setup");
  Serial.write(1);
}

void initializeAd5932(){
  
  delay(100);
  spiWrite(B00001111, B11111111);
  
  delay(100);
  
  //spiWrite(B11000011, B01000111);//fstart lsb = 1k 839
  //delay(100);
  //spiWrite(B11010000, B00000000);//fstart msb
  spiWrite(B11000110, B01100110); // fstart lsb = 500k 419430
  delay(100);
  spiWrite(B11010000, B01100110);//fstart msb
  
  delay(100);
  
  //spiWrite(B00101001, B01011000);//deltaf lsb = 17.5k 14680
  //delay(100);
  //spiWrite(B00110000, B00000011);//deltaf msb
  spiWrite(B00100001, B00100111);//deltaf lsb = 15k 12583
  delay(100);
  spiWrite(B00110000, B00000011);//deltaf msb
  
  delay(100);  
  spiWrite(B00010000, B11000111);//N = 199
  
  delay(100);
  spiWrite(B01111111, B11111111);//*T = 2047
  
  delay(100);
  
  //SPI.end();
  
}

void spiWrite(byte msb, byte lsb){
  
  digitalWrite(ssPin, LOW);
  delayMicroseconds(1);
  SPI.transfer(msb);
  SPI.transfer(lsb);
  digitalWrite(ssPin, HIGH);
}

void loop() {
  
  // When button is pushed, activate touche
  if(digitalRead(buttonPin) == HIGH){
    digitalWrite(ctrPin, HIGH);
    //Serial.println("high");
    digitalWrite(ctrPin, LOW);
    isStarted = true;
  }
  
  // Check increment of AD5932
  if(digitalRead(incPin) == HIGH){
    //Serial.println("End Sweep");
  }
  
  // Read analog voltage value (0~1023) resolution
  // Send them to serial with frequency (1~200)
  if(isStarted == true){
    val[num] = analogRead(adcPin);
    if(num==199){
    //Serial.println(val[num]);
    //SerialUSB.println(num);
    //SerialUSB.println("aaa");
    }
    freq[num] = num;
    num++;
    // toggle increment
    digitalWrite(ctrPin, HIGH);
    digitalWrite(ctrPin, LOW);
    // Send data to serial when iteration reached 200 times
    if(num == 200){
      num = 0;
      PlotArray(freq, val);
    }
  }
}
