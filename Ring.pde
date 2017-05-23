class Ring {
  float x, y;          // X-coordinate, y-coordinate
  float diameter;      // Diameter of the ring
  boolean on = false;  // Turns the display on and off
  float ringCount;
  float max_d;
  float ypos;
  float w;
  
  int r = 255;
  int g = 0;
  int b = 0;
  int c = 5;
  
  float old_x;
  float old_y;
  
  color bg;
 
  void start(float xpos, float ypos) {
    x = xpos;
    y = ypos;
    max_d = 2000-y;
    w = 6;
    old_x = 0;
    old_y = 0;
    
    ringCount = 1;
    diameter = 100;
    on = true;
  }
  
  void grow() {
    if (on == true) {
      diameter += 30;
      if (diameter > max_d) {
        on = false;
        diameter = 1;
      }
      
    }
  }
  
  void display() {
    if (on == true) {
      noFill();
      strokeWeight(w);
      //colorMode(HSB);
      
      for (int i = 1; i < 5; i++) {
        //stroke((x*255/width)/i, (y*255/height)/i, 255/i);
        //stroke(200, 255, 255);
        //stroke(x*255/width, 255, y*height/255);
        //colorMode(HSB, width, 100, 100);
        //bg = color(x, 100/(5-i), 100);
        //stroke(bg);
        stroke((x*255/width)/(5-i), (y*255/height)/(5-i), (255)/(5-i), (max_d+100-diameter)*255/max_d);
        ellipse(x, y, diameter+2*w*i, diameter+2*w*i);
        //stroke(200, 255, 255);
        //ellipse(x, y, diameter+2*w*(i-1), diameter+2*w*(i-1));
      }
      for (int i = 5; i < 8; i++) {
        //colorMode(HSB, width, 100, 100);
        //bg = color(x, 100/(i-3), 100);
        //stroke(bg);
        stroke((x*255/width)/(i-3), (y*255/height)/(i-3), (255)/(i-3), 1);
        ellipse(x, y, diameter+2*w*i, diameter+2*w*i);
      }
    }
  }
}
