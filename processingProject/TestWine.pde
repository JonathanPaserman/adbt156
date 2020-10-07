class TestWine{
  float[] testingArray = new float[12];
  float[] meansArray = new float[24];
  
  TestWine(){
    
  }
  
  TestWine(float a, float b, float c, float d, float e, float f, float g, float h, float i, float j, float k, float l){
      //completing our testing array
      testingArray[0] = a; 
      testingArray[1] = b; 
      testingArray[2] = c; 
      testingArray[3] = d; 
      testingArray[4] = e; 
      testingArray[5] = f; 
      testingArray[6] = g; 
      testingArray[7] = h; 
      testingArray[8] = i; 
      testingArray[9] = j; 
      testingArray[10] = k; 
      testingArray[11] = l; 
      //completing our normalized means array
      meansArray[0] = -0.25175062;
      meansArray[1] = -0.13181768;
      meansArray[2] = -0.20123203;
      meansArray[3] = -0.08879937;
      meansArray[4] = -0.061056472;
      meansArray[5] = -0.119149484;
      meansArray[6] = -0.30504054;
      meansArray[7] = -0.13338676;
      meansArray[8] = -0.36198473;
      meansArray[9] = -0.15149975;
      meansArray[10] = -0.36446068;
      meansArray[11] = -0.47974893;
      meansArray[12] = -0.3730275;
      meansArray[13] = -0.29830542;
      meansArray[14] = -0.1632384;
      meansArray[15] = -0.029754955;
      meansArray[16] = -0.13042463;
      meansArray[17] = -0.051681362;
      meansArray[18] = -0.09330136;
      meansArray[19] = -0.18590109;
      meansArray[20] = -0.45717472;
      meansArray[21] = -0.24564959;
      meansArray[22] = -0.35137677;
      meansArray[23] = -0.439611;     
  }
  
  String meanDistanceClassifier(){
    float WhiteDistance = 0;
    float RedDistance = 0;
    for (int i = 0; i < testingArray.length; i++){
      WhiteDistance += dist(testingArray[i], 0, meansArray[i], 0);  
    }
    for (int i = 11; i < testingArray.length; i++){
      RedDistance += dist(testingArray[i], 0, meansArray[i], 0);  
    }
    
    if(WhiteDistance < RedDistance){
      return "white";  
    }
    else if(RedDistance < WhiteDistance){
      return "red";  
    }
    else{
      return "Mix of both?";  
    }
  }
  
//  String knnClassifier(){
        
//  }

//  float errorCalculator(){
    
//  }
}
