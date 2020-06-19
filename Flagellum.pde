class Flagellum {
  
  int numNodes;
  
  float[][] spine;
  
  float MUSCLE_RANGE   = 0.1;
  float muscleFreq  = 0.08;
  
  float sizeW, sizeH;
  float spaceX, spaceY;
  float theta;
  float count;
  
  PVector[] vertices;
  
  
  
  Flagellum( float _sizeW, float _sizeH, int _numNodes ) {
    
    sizeW    = _sizeW;
    sizeH    = _sizeH;
    
    numNodes  = _numNodes;
    
    spine     = new float[numNodes][2];
    
    spaceX     = sizeW / float(numNodes + 1);
    spaceY     = sizeH / 2.0;
    
    count     = 0;
    theta     = PI;

    
    
    // Initialize spine positions
    for ( int n = 0; n < numNodes; n++ ) {
      float x  = spaceX * n;
      float y = spaceY;
      
      spine[n][0] = x;
      spine[n][1] = y;
    }
    
    vertices = new PVector[20];
    for(int i=0; i<20; i++) { vertices[i] = new PVector(0,0); }
  }
  
  
  void swim() {
    spine[0][0] = cos( theta );
    spine[0][1] = sin( theta );
    
    count += muscleFreq;
    float thetaMuscle = MUSCLE_RANGE * sin( count );
    
    spine[1][0] = -spaceX * cos( theta + thetaMuscle ) + spine[0][0];
    spine[1][1] = -spaceX * sin( theta + thetaMuscle ) + spine[0][1];
    
    for ( int n = 2; n < numNodes; n++ ) {
      float x  = spine[n][0] - spine[n - 2][0];
      float y = spine[n][1] - spine[n - 2][1];
      float l = sqrt( (x * x) + (y * y) );
      
      if ( l > 0 ) {
        spine[n][0] = spine[n - 1][0] + (x * spaceX) / l;
        spine[n][1] = spine[n - 1][1] + (y * spaceX) / l;
      }
    }
  }
  
  
  void debugRender() {
    for ( int n = 0; n < numNodes; n++ ) {
      stroke( 0 );
      if ( n < numNodes - 1 ) {
        line( spine[n][0], spine[n][1], spine[n + 1][0], spine[n + 1][1] );
      }
      fill( 90 );
      ellipse( spine[n][0], spine[n][1], 6, 6 );
    }
  }
  
void render()
{  

  //rotate(2*PI*(tailAngle+180)/360);
    //beginShape( TRIANGLE_STRIP );
    for ( int n = 0; n < numNodes; n++ ) {
      float dx, dy;
      if ( n == 0 ) {
        dx = spine[1][0] - spine[0][0];
        dy = spine[1][1] - spine[0][1];
      }
      else {
        dx = spine[n][0] - spine[n - 1][0];
        dy = spine[n][1] - spine[n - 1][1];
      }
      
      float theta = -atan2( dy, dx );
      
      float t   = n / float(numNodes - 1);
      float b    = bezierPoint( 3, sizeH * 0.5, sizeH * 0.25, 2, t );
      
      float x1  = spine[n][0] - sin( theta ) * b;
      float y1   = spine[n][1] - cos( theta ) * b;
      
      float x2   = spine[n][0] + sin( theta ) * b;
      float y2   = spine[n][1] + cos( theta ) * b;
      
      vertices[n].x = x1;
      vertices[n].y = y1;
      
      vertices[19-n].x = x2;
      vertices[19-n].y = y2;
      
      //vertex( x1, y1 );
      //vertex( x2, y2 );
    }

    //endShape();
    
    
    beginShape();
    for(int i=0; i<20; i++)
    {
      vertex(vertices[i].x,vertices[i].y);
    }

    endShape();
    //popMatrix();
}
  
}
