class Mover{
  PVector position;
  PVector speed;
  PVector acc;
  int Width;
  int Height;
  boolean hitTestEnabled = false;
  boolean isSolid = false;
  boolean toKill = false;
  
  Mover(float x, float y){
     position = new PVector(x,y);
     speed = new PVector();
     acc = new PVector();
     Width = xs;
     Height = ys;
  }
    
  void applyForce(PVector force){
    acc.add(force.copy());
  }
  
  void move(int dir){
     
     speed.add(acc);
     acc.mult(0);
     PVector d = speed.copy();
     if (dir == 0)
       d.y = 0;
     if (dir == 1)
       d.x = 0;
     position.add(d);
     if (position.y < baseLevel){
       position.y = baseLevel;
       speed.y = 0;
     }
  }
  
  void draw(){
    rect(position.x, position.y, Width, Height);
  }
  
  boolean isCollided(float bx1, float bx2, float by1, float by2){
    //println(position.x + " " + other.position.x + " " + (position.x + moverWidth()) + " " + (other.position.x + other.moverWidth()));
    float ax1 = position.x;
    float ax2 = position.x+Width;
    float ay1 = position.y;
    float ay2 = position.y+Height;
    return ax1 < bx2 && ax2 > bx1 && ay1 < by2 && ay2 > by1;
  }
  
  void resolveCollision(int collision, float x , float y, float w, float h){
        if (collision == 0 && speed.x > 0) position.x = x - w;
        if (collision == 0 && speed.x < 0) position.x = x + w;
        if (collision == 1 && speed.y > 0) position.y = y - h;
        if (collision == 1 && speed.y < 0) position.y = y + h;
  }
  
}