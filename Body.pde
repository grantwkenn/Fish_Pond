class Body
{
  float _2PI = 2*PI;
  
  int wanderDirection =0;
  
  //NEW
  float wanderHeading = 0.0;
  float wanderDistance = 0.0;
  float wanderDelta = 0.0;
  int wanderDegrees = 4;
  float wanderRotation = (2*PI* (wanderDegrees/360.0));
  
  float heading = 0.00;
  
  float radToDeg = 360*(1/_2PI);
  float degtoRad = _2PI*(1/360.0);
  
  
  PVector position;
  PVector velocity;
  PVector acceleration;
  PVector destination;
  PVector destVector;
  PVector angularAcceleration;
  
  float totalDistance =0;
  float halfDistance =0;
  float distanceRemaining;
  
  float linearAcceleration = 0.1;
  
  float rotationVal = (40/360.0) * 2 * PI;

  float speed;
  float maxSpeed;
  float angle=0;
  
  float _length;
  
  float angularVelocity =0;
  float rotation = (2/360.0)*2*PI;

  
  int turnSignal;
  
  PVector turnVector;
  
  boolean hasDestination = false;
  
  boolean escape = false;
  
  boolean wandering= false;
  
  
  //TODO make speed proportional to body size and Dist to Target  
  Body(PVector p, float max, float len)
  {
    this.position = p;
    velocity = new PVector(1,0);
    acceleration = new PVector(0,0);
    maxSpeed = max;
    destination = new PVector(0,0);
    //destHeading = 0;
    destVector = new PVector(0,0);
    angularAcceleration = new PVector(0,0);
    //velocity.x = 1;
    heading = 0;
    speed = 0;
    _length = len;
    
  }
  
  void update()
  {                  
    if(wandering)
      wander();
  }
  




  
  void setWander(int x, int y)
  {
    destination = new PVector(x,y);
    destVector = PVector.sub(destination, position); //Vector from pos, to dest
    wanderHeading = destVector.heading(); //-PI <-- 0 --> PI
    
    //turn signal for this wander instance
    //does it change ever? it should..//////////////~!!!!!!!!!!!!
    if(heading < wanderHeading)
    {
      if((wanderHeading - heading) < PI) { wanderDirection = 1; }
      else                             { wanderDirection = -1; }
    }
    else if(heading > wanderHeading)
    {
      if(heading - wanderHeading < PI) { wanderDirection = -1; }
      else                           { wanderDirection = 1; }
    }
    else //heading == destHeading??
      wanderDirection = 0;
      
    wandering = true;
  }
  
  void wander()
  {   
    heading = velocity.heading();
    destVector = PVector.sub(destination, position);
    if(destVector.mag() < 50) //STOP CONDITION
    {
      wandering = false;
      println("3");
      return;
    }
     
    
    if(PVector.angleBetween(velocity, destVector) > wanderRotation)
    {
      println("1"); 
      heading += wanderDirection * rotation;
    }
      
    else
    {       
      println(velocity);
      println("2");              
      heading = destVector.heading();
      println(int(heading*radToDeg));
      println(int(heading*radToDeg));
    }
      
    
    speed += linearAcceleration;
    if(speed > maxSpeed)
      speed = maxSpeed;
    
    velocity = PVector.fromAngle(heading).mult(speed);
    position.add(velocity);
    
    
  }
  
  //GETTERS////////////////////////////////////////////////////////////
    int getTurnSignal()
  {
    return turnSignal;
  }
  
  boolean isEscaping() { return escape; }
  
  
}
