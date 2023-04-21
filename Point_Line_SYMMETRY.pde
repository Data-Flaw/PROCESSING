
// Point Symmetry created by Data Flaw (R.ASTOURIC)
// March / April 2023
//
// LINKS : https://www.liinks.co/dataflaw
// INSTA : @data.flaw - https://www.instagram.com/data.flaw/
//
// The function displayed here needs a line (x1,y1,x2,y2)
// to compute a symmetry from this line with a point i.e : 
// any (blue) point here will have its (red) symmetric counterpart
// based on the reference line (white)


//+++++++++++++++++++++++++++++++++++++ INIT +++++++++++++++++++++++++++++++++++++

float x1,y1,x2,y2;

// +++++++++++++++++++++++++++++++++++ SET UP +++++++++++++++++++++++++++++++++++++
void setup(){
  
 size(500,500);
  
 noFill();
 stroke(255);
 //strokeWeight(2);


 pixelDensity(displayDensity());
 background(0);
 
 x1 = random(0.1*width, width*(1-0.1));
 y1 = random(0.1*width, width*(1-0.1));
 x2 = random(0.1*width, width*(1-0.1));
 y2 = random(0.1*width, width*(1-0.1));
 
}// +++++++++++++++++++++++++++++++++ (SET UP) +++++++++++++++++++++++++++++++++++++

// ++++++++++++++++++++++++++++++++++++ DRAW +++++++++++++++++++++++++++++++++++++
void draw(){
  
  background(0);
  
  
  strokeWeight(10);
  stroke(0,0,255);
  point(mouseX,mouseY);
  
  point_symmetry(mouseX,mouseY,x1,y1,x2,y2);
 
  
}// +++++++++++++++++++++++++++++++++++ (DRAW) +++++++++++++++++++++++++++++++++++++



// +++++++++++++++++++++++++++++++++++ FUNCTIONS +++++++++++++++++++++++++++++++++++++


// SYMMETRY WITH (x1,y1,x2,y2) LINE
void point_symmetry(float x_p, float y_p, float x1_, float y1_, float x2_, float y2_)
{// Computing point symmetry for lines (ax + b)

// Here is of this algorithm works :
// It will compare the distance between my point (x_p,y_p) and all the points of my line (y = ax + b)
// The minimal distance is the orthogonal projection : point (x_orth,y_orth)

// Then, it will use this point to create its symmetric :
// Storing the distance between (x_p,y_p)(x_orth,y_orth)
// Calculating the angle between the line and (x_p,y_p)(x_orth,y_orth)
// Knowing these distance and angle, it computes a new point (x_s,_s) 
// from (x_p,y_p) using the same angle and 2 times the distance

  float x_orth = 0; // Orthogonal projection of my point on the symmetry line
  float y_orth = 0;
  
  float x_s = 0; // Symmetry point for the (x_p,y_p) point and the symmetry line
  float y_s = 0;
  
  float x_line_START = 0; // START point for the symmetry line
  float y_line_START = 0;
  
  float x_line_END = 0; // END point for the symmetry line
  float y_line_END = 0;
  
  stroke(255);
  strokeWeight(1);
  line(x1_,y1_,x2_,y2_);

// IF THE LINE ISN'T VERTICAL :

  if ((x2_-x1_) != 0) // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
  {
    // Calculating my (y = aX + b) a and b values
      float a = (y2_ - y1_)/(x2_ - x1_);
      
      // y2 = a*x2 + b
      // y1 = a*x1 + b
      float b = y2_ - a*x2_;
    
    // ---
      
      x_line_START = 0; // First point for the symmetry line
      y_line_START = b;
      
      x_line_END = width; // Last point for the symmetry line
      y_line_END = a*width + b;
      
      stroke(255,100);
      strokeWeight(1);
      line(x_line_START, y_line_START, x_line_END, y_line_END);
      
      // ---
      
      float minDistance = dist(x_p, y_p, x_line_START, y_line_START); // Initialising the first value of minDistance
      
      // Finding the distance between my point (x_p,y_p) and all the points of my line (y = ax + b)
      // Storing the minimal distance and the according point
      for (float x = 0; x < width; x++)
      {
        float y = (a*x + b); //
         
        float distance = dist(x_p, y_p, x, y);
        
        if(distance < minDistance)
        {
          minDistance = distance; 
          // If the new computed value is less than my minDistance reference value, 
          // it is the new minDistance reference value
          
          // So, it will also stores the accodind point
          x_orth = x;
          y_orth = y;
        }
      }
      
    // ---
        
        // Calculating the angle
        float angle = atan2(y_orth - y_p,x_orth - x_p); 
        
        //
        x_s = x_p + 2*minDistance*cos(angle);
        y_s = y_p + 2*minDistance*sin(angle);
        
        strokeWeight(10);
        stroke(255,0,0);
        point(x_s,y_s);
  }

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

  else // IF THE LINE IS VERTICAL :
  {
    
    x_line_START = x1_; // First point for the symmetry line
    y_line_START = 0;
    
    x_line_END = x1_; // Last point for the symmetry line
    y_line_END = width;
    
    stroke(255,100);
    strokeWeight(1);
    line(x_line_START, y_line_START, x_line_END, y_line_END);
  
    
    float minDistance = dist(x_p, y_p, x_line_START, y_line_START); // Initialising the first value of minDistance
    
    // Finding the distance between my point (x_p,y_p) and all the points of my line (y = ax + b)
    // Storing the minimal distance and the according point
    for (float y = 0; y < height; y++)
    {
      float x = x_line_START;
       
      float distance = dist(x_p, y_p, x, y);
      
      if(distance < minDistance)
      {
        minDistance = distance; 
        // If the new computed value is less than my minDistance reference value, 
        // it is the new minDistance reference value
        
        // So, it will also stores the accodind point
        x_orth = x;
        y_orth = y;
      }
    }
    
    print(minDistance);
      
      // Calculating the angle
      float angle = atan2(y_orth - y_p,x_orth - x_p); 
      
      //
      x_s = x_p + 2*minDistance*cos(angle);
      y_s = y_p + 2*minDistance*sin(angle);
      
      strokeWeight(10);
      stroke(255,0,0);
      point(x_s,y_s);
  }

}
