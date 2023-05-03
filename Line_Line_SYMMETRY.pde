
// Line Symmetry created by Data Flaw (R.ASTOURIC)
// March / April 2023
//
// LINKS : https://www.liinks.co/dataflaw
// INSTA : @data.flaw - https://www.instagram.com/data.flaw/
//
// The function displayed here needs a line (x1,y1,x2,y2)
// to compute a symmetry from this line with another line i.e : 
// any (blue) line here will have its (red) symmetric counterpart
// based on the reference line (white)



//+++++++++++++++++++++++++++++++++++++ INIT +++++++++++++++++++++++++++++++++++++


float x1_ref,y1_ref,x2_ref,y2_ref;
float x1_p,y1_p,x2_p,y2_p;

// +++++++++++++++++++++++++++++++++++ SET UP +++++++++++++++++++++++++++++++++++++
void setup(){
  
 size(500,500);
  
 noFill();
 stroke(255);
 //strokeWeight(2);


 pixelDensity(displayDensity());
 background(0);
 
 x1_ref = random(0.1*width, width*(1-0.1));
 y1_ref = random(0.1*width, width*(1-0.1));
 x2_ref = random(0.1*width, width*(1-0.1));
 y2_ref = random(0.1*width, width*(1-0.1));
 
 x1_p = random(0.3*width, width*(1-0.3));
 y1_p = random(0.3*width, width*(1-0.3));
 x2_p = random(0.3*width, width*(1-0.3));
 y2_p = random(0.3*width, width*(1-0.3));
 
}// +++++++++++++++++++++++++++++++++ (SET UP) +++++++++++++++++++++++++++++++++++++

// ++++++++++++++++++++++++++++++++++++ DRAW +++++++++++++++++++++++++++++++++++++
void draw(){
  noLoop();
  background(0);
  
  
  strokeWeight(2);
  stroke(0,0,255);
  line(x1_p,y1_p,x2_p,y2_p);
  
  line_symmetry(x1_p,y1_p,x2_p,y2_p, x1_ref,y1_ref,x2_ref,y2_ref);
 
  
}// +++++++++++++++++++++++++++++++++++ (DRAW) +++++++++++++++++++++++++++++++++++++


// LINE SYMMETRY WITH (x1,y1,x2,y2) LINE
// Needs 2 lines, the symmetric reference one, and the one we want to find a symmetry of
// Will create a new one (the symmetric)
void line_symmetry(float x_p1, float y_p1, float x_p2, float y_p2, float x1_, float y1_, float x2_, float y2_)
{
// float x_p1, float y_p1, float x_p2, float y_p2 : The Line that will get a symmetric counterpart
// float x1_, float y1_, float x2_, float y2_ : The REFERENCE line


// Here is of this algorithm works :
// It will compare the distance between my point (x_p,y_p) and all the points of my line (y = ax + b)
// The minimal distance is the orthogonal projection : point (x_orth,y_orth)

// Then, it will use this point to create its symmetric :
// Storing the distance between (x_p,y_p)(x_orth,y_orth)
// Calculating the angle between the line and (x_p,y_p)(x_orth,y_orth)
// Knowing these distance and angle, it computes a new point (x_s,_s) 
// from (x_p,y_p) using the same angle and 2 times the distance

  float x_orth1 = 0; // Orthogonal projection of my point on the symmetry line
  float y_orth1 = 0;
  float x_orth2 = 0; // Orthogonal projection of my point on the symmetry line
  float y_orth2 = 0;
  
  float x_s1 = 0; // Symmetry point for the (x_p,y_p) point and the symmetry line
  float y_s1 = 0;
  float x_s2 = 0; // Symmetry point for the (x_p,y_p) point and the symmetry line
  float y_s2 = 0;
  
  float minDistance1 = 0; // Stores the evolving distance values during the algorithm to to find the minimum
  float minDistance2 = 0;
  
  float angle1 = 0; // Angle between the x_p,y_p point and its orthogonal on the reference line
  float angle2 = 0;
  
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
      
      minDistance1 = dist(x_p1, y_p1, x_line_START, y_line_START); // Initialising the first value of minDistance
      minDistance2 = dist(x_p2, y_p2, x_line_START, y_line_START);
      
      // Finding the distance between my point (x_p,y_p) and all the points of my line (y = ax + b)
      // Storing the minimal distance and the according point
      for (float x = 0; x < width; x++)
      {
        float y = (a*x + b); //
         
        float distance1 = dist(x_p1, y_p1, x, y);
        float distance2 = dist(x_p2, y_p2, x, y);
        
        if(distance1 < minDistance1)
        {
          minDistance1 = distance1; 
          // If the new computed value is less than my minDistance reference value, 
          // it is the new minDistance reference value
          
          // So, it will also stores the accodind point
          x_orth1 = x;
          y_orth1 = y;
        }
        
        // ---
        
        if(distance2 < minDistance2)
        {
          minDistance2 = distance2; 
          // If the new computed value is less than my minDistance reference value, 
          // it is the new minDistance reference value
          
          // So, it will also stores the accodind point
          x_orth2 = x;
          y_orth2 = y;
        }
      }
      
    // ---
        
        // Calculating the angle
        angle1 = atan2(y_orth1 - y_p1, x_orth1 - x_p1); 
        angle2 = atan2(y_orth2 - y_p2, x_orth2 - x_p2); 
        
        //
        x_s1 = x_p1 + 2*minDistance1*cos(angle1);
        y_s1 = y_p1 + 2*minDistance1*sin(angle1);
        
        x_s2 = x_p2 + 2*minDistance2*cos(angle2);
        y_s2 = y_p2 + 2*minDistance2*sin(angle2);
        
        //strokeWeight(10);
        //stroke(255,0,0);
        //point(x_s1,y_s1);
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
  
    
    minDistance1 = dist(x_p1, y_p1, x_line_START, y_line_START); // Initialising the first value of minDistance
    minDistance2 = dist(x_p2, y_p2, x_line_START, y_line_START);
    
    // Finding the distance between my point (x_p,y_p) and all the points of my line (y = ax + b)
    // Storing the minimal distance and the according point
    for (float y = 0; y < height; y++)
    {
      float x = x_line_START;
       
      float distance1 = dist(x_p1, y_p1, x, y);
      float distance2 = dist(x_p2, y_p2, x, y);
      
      if(distance1 < minDistance1)
      {
        minDistance1 = distance1; 
        // If the new computed value is less than my minDistance reference value, 
        // it is the new minDistance reference value
        
        // So, it will also stores the according point
        x_orth1 = x;
        y_orth1 = y;
      }
      
      // ---
      
      if(distance2 < minDistance2)
      {
        minDistance2 = distance2; 
        // If the new computed value is less than my minDistance reference value, 
        // it is the new minDistance reference value
        
        // So, it will also stores the according point
        x_orth2 = x;
        y_orth2 = y;
      }
    }
    
    //print(minDistance);
      
      // Calculating the angle
      angle1 = atan2(y_orth1 - y_p1, x_orth1 - x_p1); 
      angle2 = atan2(y_orth2 - y_p2, x_orth2 - x_p2);
      
      //
      x_s1 = x_p1 + 2*minDistance1*cos(angle1);
      y_s1 = y_p1 + 2*minDistance1*sin(angle1);
      
      x_s2 = x_p2 + 2*minDistance2*cos(angle2);
      y_s2 = y_p2 + 2*minDistance2*sin(angle2);
      
      //strokeWeight(10);
      //stroke(255,0,0);
      //point(x_s,y_s);
  }
  
  strokeWeight(2);
  stroke(255,0,0);
  line(x_s1, y_s1, x_s2, y_s2);

}
