byte yMSB=0, yLSB=0, xMSB=0, xLSB=0; 
 
// Send 2 integer data with 4 times writing of 1 byte data
void SendData(unsigned int yValue,unsigned int xValue){
    
  yLSB=lowByte(yValue);
  yMSB=highByte(yValue);
  xLSB=lowByte(xValue);
  xMSB=highByte(xValue);             

  Serial.write(byte(yMSB));         // Y value's most significant byte  
  Serial.write(byte(yLSB));         // Y value's least significant byte   
  Serial.write(byte(xMSB));         // X value's most significant byte  
  Serial.write(byte(xLSB));         // X value's least significan
}

// Sending 2 array of integer whose size must be sizeOfArray
void PlotArray(int Array1[],int Array2[]){
   
   // Tell PC an array is about to be sent by 4 byte of 255
   for(int i=0; i<4; i++){
      Serial.write(byte(255));
   }               
   delay(1);
   // Send Data
   for(int x=0;  x < sizeOfArray;  x++){     // Send the arrays 
     SendData(Array1[x],Array2[x]);
     //delay(1);
   }
}

