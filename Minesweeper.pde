import de.bezier.guido.*;
public static final int NUM_ROWS=15;
public static final int NUM_COLS=15;
public static final int NUM_MINES=22;
public  int tilesClicked=0;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList<MSButton>(); //ArrayList of just the minesweeper buttons that are mined
void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
      buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int i=0;i<NUM_ROWS;i++){
      
      for(int j=0;j<NUM_COLS;j++){
        
        buttons[i][j]=new MSButton(i,j);
        
      }
      
    }

    
    setMines();
}
public void setMines()
{
  for(int i=0;i<NUM_MINES;i++){
  int randrow,randcol;
     randrow=(int)(Math.random()*NUM_ROWS);
     randcol=(int)(Math.random()*NUM_COLS);
     if(mines.contains(buttons[randrow][randcol])){
       randrow=(int)(Math.random()*NUM_ROWS);
     randcol=(int)(Math.random()*NUM_COLS);
     }
      if (!mines.contains(buttons[randrow][randcol]))
    {
      mines.add(buttons[randrow][randcol]);
  
    }
    
  }
}

public void draw ()
{
    background( 0 );
    if(isWon() == true)
        displayWinningMessage();
}
public boolean isWon()
{
    int sum=0;
 
    for(int j=0;j<NUM_ROWS;j++){
    
    for(int i=0;i<NUM_COLS;i++){
     if(buttons[j][i].clicked)
     sum++;
    }
  }
      for(int j=0;j<NUM_ROWS;j++){
    
    for(int i=0;i<NUM_COLS;i++){
     if(buttons[j][i].flagged)
     sum--;
    }
  }
  
  if(NUM_ROWS*NUM_COLS-NUM_MINES==sum){
    return true;
  }
  return false;
}
public void displayLosingMessage()
{
     for(int j=0;j<NUM_ROWS;j++){
    
    for(int i=0;i<NUM_COLS;i++){
     buttons[j][i].setLabel("L");
    }
  }
      for(int j=0;j<NUM_ROWS;j++){
    
    for(int i=0;i<NUM_COLS;i++){
     if(buttons[j][i].flagged)
     buttons[j][i].flagged=false;
    }
  }
    for(int j=0;j<NUM_ROWS;j++){
    
    for(int i=0;i<NUM_COLS;i++){
     buttons[j][i].setClicked();
    }
  }
}
public void displayWinningMessage()
{
    if(isWon()==true){
      for(int j=0;j<NUM_ROWS;j++){
    
    for(int i=0;i<NUM_COLS;i++){
     buttons[j][i].setLabel("W");
     if(mines.contains(buttons[j][i])){
       
       buttons[j][i].setClicked();
     }
    }
  }
    }
   
}
public boolean isValid(int r, int c)
{
     if (r>=0 && r<NUM_ROWS && c>=0 && c<NUM_COLS)
      return true;
    else
    return false;
}
public int countMines(int row, int col)
{
  int numMines = 0;
  for (int i = row-1; i<row+2; i++)
  {
    for (int j = col-1; j<col+2; j++)
    {
      if (isValid(i, j)==true)
      {
        if (mines.contains(buttons[i][j]))
        {
          numMines++;
        }
      }
    }
  }
  if (mines.contains(buttons[row][col]))
  {
    numMines--;
  }
  return numMines;
}
public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        
        Interactive.add( this ); // register it with the manager
        
    }

    // called by manager
    public void mousePressed () 
    {
        clicked = true;
        
      
          tilesClicked++;
        
       
        if(mouseButton==RIGHT){
          if(flagged==true){
          flagged=false;
          clicked=false;
          }
          else if(flagged==false)
          flagged=true;
        }
        else if(mines.contains(this)&&isWon()==false){
          displayLosingMessage();
        }
        else if((countMines(myRow,myCol))>0){
          this.setLabel(countMines(myRow,myCol));
        }
        else{
         for (int i = myRow-1; i<myRow+2; i++) {
    for (int j = myCol-1; j<myCol+2; j++)
    {
      if (isValid(i, j)==true)
      {
        if (!buttons[i][j].clicked)
        {
          buttons[i][j].mousePressed();
        }
      

          
        }
    }
         }
        }
    }
        
    
    public void draw () 
    {    
        if (flagged)
            fill(0);
         else if( clicked && mines.contains(this) ) 
             fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
    public void setClicked(){
      clicked=true;
    }
  
}
