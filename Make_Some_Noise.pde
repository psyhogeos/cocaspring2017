import processing.sound.*;
FFT fft;
AudioIn in;
int bands = 1024;
float[] spectrum = new float[bands];
float threshold;
float[] map = new float[bands];

Ring[] rings;
int numRings = 10;
int currentRing = 0;

float lastRingX;
int reset = 0;
//float lastRingY;

int scl = 10;
int str = 3;

void setup() {
  fullScreen();
  //size(2500, 1600);
  background(0);
    
  // Create an Input stream which is routed into the Amplitude analyzer
  fft = new FFT(this, bands);
  in = new AudioIn(this, 0);
  
  // start the Audio Input
  in.start();
  
  // patch the AudioIn
  fft.input(in);
  
  rings = new Ring[numRings];
  for(int i=0 ; i<rings.length ; i++){
    rings[i] = new Ring();
  }
  
} 
void draw() { 
  
  //scale(1,-1);
  //translate(0,-height);
  
  frameRate(20);
  background(0);
  
  reset++;
  if(reset == 10){
    reset = 0;
    lastRingX = 0;
  }
  
  fft.analyze(spectrum);
   
  for (int i = 0; i < bands; i++) {
    map[i] = height-spectrum[i]*(height-120)*2;
    if(map[i] < 250){
      map[i] = 250;
    }
  }
  float min_total = height;
  float min = height;
  int min_val = width;
  float min2 = height;
  int min_val2 = width;
  
  for (int i = 0; i < bands/(scl-2); i++) {
    //stroke(10,i*10,255,80);
    //stroke(130);
    stroke(((str*i*scl+50)*255/width), ((height-map[i])*255/height), 255);
    strokeWeight(5);
    line(str*i*scl+50, height, str*i*scl+50, map[i]);
    if (map[i] < min) {
      min = map[i];
      min_val = i;
    } 
  }
  
  if (min < min_total) min_total = min;
  if (min < (height-150) && min_val*str*scl+50 - lastRingX > 50) { //min_total / min >= 0.9 
    createRing(min_val*str*scl+50, min);
    lastRingX = min_val*str*scl+50;
    fill(10,min*10,255,150);
  }
  
    if (min2 < (height-150) && min_val2*str*scl+50 - lastRingX > 50) { //min_total / min >= 0.9 
    createRing(min_val*str*scl+50, min);
    lastRingX = min_val*str*scl+50;
    fill(10,min*10,255,150);
  }
  
  for(int i=0 ; i<rings.length ; i++){
    rings[i].grow();
    rings[i].display();
  }
}

void createRing(float x, float y)
{
  rings[currentRing].start(x,y);
  currentRing++;
  if (currentRing >= numRings) {
    currentRing = 0;
  }
}
