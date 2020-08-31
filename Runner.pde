class Runner extends Mover{
  
  boolean isDying = false;
  boolean isDead = false;
  boolean isCrawling = false;
  boolean isOnGround = false;;
  
  Runner(float x, float y){
    super(x,y);
    Width=16;
    Height = 32;
  }
  
  void died(){
    speed.x = 0;
    speed.y = 5;
    isDying = true;
  }
  
  void move(int dir){
   super.move(dir);
   //states
  }
}