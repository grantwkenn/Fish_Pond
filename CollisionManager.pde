class CollisionManager
{
   Fish[] school;
   int size;
  
  CollisionManager(Fish[] s)
  {
    school = s;
    size = school.length;
  }
  
  void update()
  {
    for(int i=0; i<size; i++)
    {
       for(int j=i+1; j<size; j++) 
       {
         collisionCheck(school[i], school[j]);
       }
    }
  }
  
  void collisionCheck(Body b1, Body b2)
  {
    float distance = PVector.sub(b1.position, b2.position).mag();
    if(distance <= 150)
    {
      if(!b1.isEscaping());
        //b1.setEscape();
      //if(!b2.isEscaping())
        //b2.setEscape();
    }
  }
  
  
  
  
}
