Table cameraTable;
Table carsTable;
Table dataset; 
String filePathData = "cameras-cleaned.tsv";
//String filePathData = "cars-cleaned.tsv";

int widthOfScreen = 1300;
int heigthOfScreen = 750;
Attribute[] attributes; 

void setup() {
  size(1300, 750);
  pixelDensity(displayDensity());
  loadData();
}

void draw() {
  background(255);
  //Attribute sample = new Attribute(400, 400, 50, 50);
  
   for(int i = 0; i<attributes.length; i++){
     attributes[i].display();
     //println(attributes[i]);
  }
  //sample.display();
  
}

void loadData() {
  //cameraTable = loadTable("cameras-cleaned.tsv", "header");
  //carsTable =  loadTable("cars-cleaned.tsv", "header");
  dataset = loadTable(filePathData);
  attributes = new Attribute[dataset.getColumnCount()];
  Item[] items = new Item[dataset.getRowCount()];
  //printArray(attributes);
  //attributes[0] = new Attribute(dataset.getString(0,0));
  // initialize array of items
  int count = 0;
  for (TableRow row : dataset.rows()){
    items[count] = new Item(row.getString(0));
    count++;
  }
  
  
  float startingXValue = 50.0;
  int offset = widthOfScreen/ attributes.length;
  
  //initialize attribute rectangles
  for(int i = 0; i<dataset.getColumnCount(); i++){
    
    attributes[i] = new Attribute(startingXValue, 75.0, 5.0, 600.0, dataset.getString(0,i));
    attributes[i].max = findMax(dataset.getStringColumn(i));
    attributes[i].min = findMin(dataset.getStringColumn(i));
    startingXValue = startingXValue + offset;
    //Attribute(float tempX1, float tempY1, float Width, float Height
  }
  
  
  for (int i = 1; i< items.length; i++){
    for (int j = 1; j < attributes.length; j++){
      items[i].addEntry(attributes[j].label, dataset.getFloat(i, j));
    }
    //printArray(items[i].dataPoints.values().toArray());
  }
  
  
  //bubbles = new Bubble[table.getRowCount()];


  //for (int i = 0; i<table.getRowCount(); i++) {
  //  // Iterate over all the rows in a table.
  //  TableRow row = table.getRow(i);  
  //  // Access the fields via their column name (or index).
  //  float x = row.getFloat("x");
  //  float y = row.getFloat("y");
  //  float d = row.getFloat("diameter");
  //  String n = row.getString("name");
  //  // Make a Bubble object out of the data from each row.
  //  bubbles[i] = new Bubble(x, y, d, n);
}
//String[] nameOfColumns(int n) {
//  String[] nameOfColumns = new String[n];
//  for (int i = 0; i < n; i++) {
//    xstartingXValue = xstartingXValue + 2.0;
//    String xstartingXValueString = str(xstartingXValue);
//    arrayTextXPoints[i] = xstartingXValueString;
//  }
//  return arrayTextXPoints;
//}

float scalePoint(float max, float min, float point){
  float yStartPoint = 75;
  float yEndPoint = 675;
  float heighOfBar = 600;
  float interval = heighOfBar/ (max-min); 
  float positionOnBar = ((max - point) * interval) + ystartingPoint;
  return positionOnBar; // this represents the y coordinate on the screen
}

float findMax(String[] valuesInColumns) { 
  float maxValue = 0.0;
  for (int i = 0; i < valuesInColumns.length; i++) {
    float value = Float.valueOf(valuesInColumns[i]);
    if (value > maxValue){
      maxValue = value;
    }
  }
  return maxValue;
}

float findMin(String[] valuesInColumns) { 
  float minValue = 0.0;
  for (int i = 0; i < valuesInColumns.length; i++) {
    float value = Float.valueOf(valuesInColumns[i]);
    if (value > minValue){
      minValue = value;
    }
  }
  return minValue;
}