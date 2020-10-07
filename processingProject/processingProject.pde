Table table; //Declare a table for our data
TestWine testWine;
int pressCount = 6;

float[][] variablesDataframe = new float[13][6497]; //Create 2D array for our data


void setup() {
  size(600, 600);
  table = loadTable("/data/winequalityN.csv", "header"); //Importing our dataset and load it into our table
  println(table.getRowCount() + " total rows in table"); //Print the number of rows in the table
  println(table.getColumnCount() + " total columns in table"); //Print the number of columns in the table

  //Fill our 2D array with our data
  for (int i = 0; i < table.getColumnCount(); i++) {
    for (int j = 0; j < table.getRowCount(); j++) {
      variablesDataframe[i][j] = table.getFloat(j, i);
    }
  }

  //Compare variable means for red and white wine 
  println("white wines : red wines fixedAcidity average = ", average(variablesDataframe[1], 0, 4897), ":", average(variablesDataframe[1], 4898, 6496));
  println("white wines : red wines volatileAcidity average = ", average(variablesDataframe[2], 0, 4897), ":", average(variablesDataframe[2], 4898, 6496));
  println("white wines : red wines citricAcid average = ", average(variablesDataframe[3], 0, 4897), ":", average(variablesDataframe[3], 4898, 6496));
  println("white wines : red wines residualSugar average = ", average(variablesDataframe[4], 0, 4897), ":", average(variablesDataframe[4], 4898, 6496));
  println("white wines : red wines chlorides = ", average(variablesDataframe[5], 0, 4897), ":", average(variablesDataframe[5], 4898, 6496));
  println("white wines : red wines freeSulfurDioxide average = ", average(variablesDataframe[6], 0, 4897), ":", average(variablesDataframe[6], 4898, 6496));
  println("white wines : red wines totalSulfurDioxide average = ", average(variablesDataframe[7], 0, 4897), ":", average(variablesDataframe[7], 4898, 6496));
  println("white wines : red wines density average = ", average(variablesDataframe[8], 0, 4897), ":", average(variablesDataframe[8], 4898, 6496));
  println("white wines : red wines pH average = ", average(variablesDataframe[9], 0, 4897), ":", average(variablesDataframe[9], 4898, 6496));
  println("white wines : red wines sulphates average = ", average(variablesDataframe[10], 0, 4897), ":", average(variablesDataframe[10], 4898, 6496));
  println("white wines : red wines alcohol average = ", average(variablesDataframe[11], 0, 4897), ":", average(variablesDataframe[11], 4898, 6496));
  println("white wines : red wines quality average = ", average(variablesDataframe[12], 0, 4897), ":", average(variablesDataframe[12], 4898, 6496));

  //Replace missing values in our dataset with the mean of the same column (variable)
  for (int i = 0; i < table.getColumnCount()-1; i++) {
    for (int j = 0; j < table.getRowCount()-1; j++) {
      if (nf(variablesDataframe[i][j]) == "NaN") {
        variablesDataframe[i][j] = average(variablesDataframe[i], 0, 6496);
      }
    }
  }

  //Check for correlations with quality
  for (int i = 1; i < table.getColumnCount() - 1; i++) {
    println((table.getRow(0).getColumnTitle(i)), "CC with quality: ", pearsonCorrelation(variablesDataframe[i], variablesDataframe[12]));
  }
  
  testWine = new TestWine(7,0.22,0.3,1.8,0.065,16,20,0.99672,3.61,0.82,10,6);
  println(testWine.meanDistanceClassifier());
}

void draw() {
  background(225,225,225);
  scatterPlot(variablesDataframe[6], variablesDataframe[7]);

}

//Method used for calculating Pearson's Correlation Coefficient 
float pearsonCorrelation(float[] xVariable, float[] yVariable) {
  float Ex = 0;
  float Ey = 0;
  float n = xVariable.length;
  float numerator = 0;
  float denomenator = 0;

  for (int i = 0; i <= xVariable.length-1; i++) {
    Ex += xVariable[i];
  }
  for (int i = 0; i<= yVariable.length-1; i++) {
    Ey += yVariable[i];
  }

  float xMean = Ex/n;
  float yMean = Ey/n;

  for (int i = 0; i <= xVariable.length-1; i++) {
    numerator += (xVariable[i] - xMean) * (yVariable[i] - yMean);
  } 
  for (int i = 0; i <= xVariable.length-1; i++) {
    denomenator += (sqrt(((xVariable[i] - xMean) * (xVariable[i] - xMean))))*(sqrt(((yVariable[i] - yMean) * (yVariable[i] - yMean))));
  }  
  return (numerator/denomenator);
}

//Method for normalizing arrays between -1, 1
float[] normalize(float[] x) {
  float Xmin = min(x);
  float Xmax = max(x);
  float[] normalizedX = new float[x.length];

  for (int i = 0; i < x.length; i++) {
    normalizedX[i] = (x[i]-Xmin)/(Xmax-Xmin);
  }
  return normalizedX;
}

//Method for drawing scatter plot
void scatterPlot(float[] x, float[] y) {
  for (int i = 0; i < table.getRowCount(); i++) {
    if (i >= 4898) {
      fill(255, 0, 0, 40);
    } else {
      fill(#FFFFFF, 40);
    }
    circle(normalize(x)[i]*width, normalize(y)[i]*width, width/20);
  }
}

//Method used for claculating the mean of an array, ignores NaN/null values
float average(float[] array, int start, int stop) {
  float arraySum = 0;
  int nullCount = 0;
  for (int i = start; i <= stop; i++) {
    if (nf(array[i]) != "NaN") {
      arraySum += array[i];
    } else {
      nullCount += 1;
    }
  }
  return arraySum/(start-stop-nullCount);
}
