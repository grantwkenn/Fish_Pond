class BezierFish
{
  PVector[] vertices;
  float _width;
  float _length;
  float tailx1, tailx2, taily1, taily2;
  float tailAngle = 0;
  float tailTipX, tailTipY;
  Body _body;
  
  float tipAngle;

  
  
  //TAIL
  float tailSpeed = 5;
    float tailBoundary = 20;
      int[] tailBounds = { 15, 20, 20 };
        int tailDirection = 1;
  
  BezierFish(int wid, Body b)
  {
    _width = wid;
    _length = wid * 2.5;
    _body = b;
    
    vertices = new PVector[18];
    for(int i=0; i<18; i++)
    {
       vertices[i] = new PVector(0,0); 
    }
  }
  
  void plot()
  {
    tailx1 = (-_length/2)+((_length*0.58)*sin(-PI/2 + (PI/2*(tailAngle+5)/90)));
    taily1 = (-(_length*0.58)*cos(-PI/2 + (PI/2*(tailAngle+5)/90)));
  
    tailx2 = (-_length/2)+((_length*0.58)*sin(-PI/2 + (PI/2*(tailAngle-5)/90)));
    taily2 = (-(_length*0.58)*cos(-PI/2 + (PI/2*(tailAngle-5)/90)));
    
    tailTipX = (-_length/2)+ ((_length*0.58)*sin(-PI/2 + (PI/2*(tailAngle)/90)));
    tailTipY = (-(_length*0.58)*cos(-PI/2 + (PI/2*(tailAngle)/90)));
    
    tailTipY -= (_length/3*sin((PI*2*(tailAngle)/360)*1.45));
    tailTipX -= (_length/3*cos((PI*2*(tailAngle)/360)*1.45));
    
    vertices[0].x = 0; vertices[0].y = -_width/2;
    vertices[1].x = _width*0.75; vertices[1].y = -_width/2;
    vertices[2].x = _length/2; vertices[2].y = -_width/4;  //c
    vertices[3].x = _length/2; vertices[3].y = 0; //point
    vertices[4].x = _length/2; vertices[4].y = _width/4; //c
    vertices[5].x = _width*0.75; vertices[5].y = _width/2; //c
    vertices[6].x = 0; vertices[6].y = _width/2; //p
    
    vertices[7].x = -_width*0.75; vertices[7].y = _width/2;
    vertices[8].x = tailx2 + 100*cos(2*PI*tailAngle/360); vertices[8].y = taily2 + 100*sin(2*PI*tailAngle/360); //c///////////////////
    vertices[9].x = tailx2; vertices[9].y = taily2;  //p
    
    vertices[11].x = 0; vertices[11].y = -_length/2;
    vertices[12].x = tailTipX; vertices[12].y = tailTipY;
    vertices[13].x = 0; vertices[13].y = -_length/2; 
    vertices[15].x = tailx1; vertices[15].y = taily1; //////////////////
    vertices[16].x = tailx1 + 100*cos(2*PI*tailAngle/360); vertices[16].y = taily1 + 100*sin(2*PI*tailAngle/360);///////////////////
    vertices[17].x = -_width*0.75; vertices[17].y = -_width/2; // 
    
    vertices[10].x = vertices[9].x + (_length/5*sin(-PI/2+ (2*PI*tailAngle/360))); vertices[10].y = vertices[9].y-10+(_length/5*cos(-PI/2- (2*PI*_body.angle/360)));
    vertices[14].x = vertices[15].x + (_length/5*sin(-PI/2+ (2*PI*tailAngle/360))); vertices[14].y = vertices[15].y+10+(_length/5*cos(-PI/2- (2*PI*_body.angle/360)));
    
    vertices[11].x = tailTipX; vertices[11].y = tailTipY;
    vertices[13].x = tailTipX; vertices[13].y = tailTipY;
    
  if(_body.angle > 0)
  {
    vertices[8].x = -(_length/1.4) - (_length/11)*(1.0*tailAngle/90.0);
    vertices[8].y = (_length/12) + (_length/25)*(1.0*tailAngle/90.0);
  
    vertices[16].x = -(_length/1.4) - (_length/4.2)*(1.0*tailAngle/-90.0);
    vertices[16].y = -(_width/4.85) + (_length/22)*(tailAngle/-90.0);
  }
  else 
  {
    vertices[16].x = -(_length/1.4) + (_length/11)*(1.0*tailAngle/90.0);
    vertices[16].y = -(_length/12) + (_length/25)*(1.0*tailAngle/90.0);
  
    vertices[8].x = -(_length/1.4) + (_length/4.2)*(1.0*tailAngle/-90.0);
    vertices[8].y = (_width/4.85) + (_length/22)*(tailAngle/-90.0);
    }
    
      vertices[10].x = vertices[9].x + ((vertices[9].x - vertices[8].x)/3);
  vertices[10].y = vertices[9].y + ((vertices[9].y - vertices[8].y)/3);
  
  vertices[14].x = vertices[15].x + ((vertices[15].x - vertices[16].x)/3);
  vertices[14].y = vertices[15].y + ((vertices[15].y - vertices[16].y)/3);
  
  PVector tv = new PVector(vertices[15].x-vertices[9].x, vertices[15].y-vertices[9].y);
  tipAngle = tv.heading();
  
  }
  
  void update()
  {
    tailUpdate();
    plot();
  }
  
  void draw()
  {
    beginShape();
    vertex(vertices[0].x, vertices[0].y);
    bezierVertex(vertices[1].x, vertices[1].y, vertices[2].x, vertices[2].y, vertices[3].x, vertices[3].y);
    bezierVertex(vertices[4].x, vertices[4].y, vertices[5].x, vertices[5].y, vertices[6].x, vertices[6].y);    
    bezierVertex(vertices[7].x, vertices[7].y, vertices[8].x, vertices[8].y, vertices[9].x, vertices[9].y);
    bezierVertex(vertices[10].x, vertices[10].y, vertices[11].x, vertices[11].y, vertices[12].x, vertices[12].y);
    bezierVertex(vertices[13].x, vertices[13].y, vertices[14].x, vertices[14].y, vertices[15].x, vertices[15].y);
    bezierVertex(vertices[16].x, vertices[16].y, vertices[17].x, vertices[17].y, vertices[0].x, vertices[0].y);
    endShape();
  }
  
  void tailUpdate()
  {
    switch (_body.getTurnSignal())
    {
       case(0):           
          
          if(_body.totalDistance == 0) return;
          tailBoundary = tailBounds[1] * (_body.distanceRemaining/_body.totalDistance);
          
          if(tailAngle >= tailBoundary)
          {
            tailDirection = -1;
          }
          else if(tailAngle <= 0-tailBoundary)
          {
            tailDirection = 1;
          }
          tailAngle += tailDirection * (tailBoundary/10.0);
          break;
          
          /*
          if(_body.speed > 0  && _body.acceleration.mag() > 0.0)
          {
            println("1");
            tailAngle += 1* tailDirection*tailSpeed;
            tailBoundary = tailBounds[1]*(4/(_body.speed));
      
              if(tailAngle >= tailBoundary)
              {
                tailAngle--;
                tailDirection = -1;
              }
              if(tailAngle <= -tailBoundary)
              {
                tailAngle++;
                tailDirection = 1;
              }
          }
      
          else //not accelerating?
          {
            //TODO HERE make tail recover faster from turn. if tail angle > xx larger spring back
             println("2"); 
            //println("HHE");
            tailAngle += (tailBounds[0]/60.0)* tailDirection;
            tailBoundary = tailBounds[0];
            if(tailAngle >= tailBoundary)
            {
              tailAngle-= 1;        
              tailDirection = -1;
            }
            if(tailAngle <= -tailBoundary)
            {
              if(_body.speed == 0 || _body.speed == _body.maxSpeed)
                tailAngle +=1;
              else
                tailAngle+= 1;
              tailDirection = 1;
            }
          }
               
          break;*/
       
       case(1): //RIGHT TURN
        tailDirection = -1;
        tailAngle += tailDirection*_body.speed/2.0;
        if (tailAngle < -1*tailBounds[2])
        {
          tailAngle = -1*tailBounds[2]; 
        }   
        break;
       
       case(-1): //LEFT TURN
          tailDirection = 1;
          tailAngle += tailDirection*_body.speed/2.0;
          if (tailAngle > tailBounds[2])
            tailAngle = tailBounds[2];      
          break;
       
    }
  }
  

  
}
