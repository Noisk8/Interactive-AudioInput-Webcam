
//llama la libreria del audio que habilita la tarjeta de audio 
import  ddf.minim.*;
import processing.video.*;
Capture webcam;



Minim minim;

AudioInput in;

//Llama la libreria que abre la imagen

PImage img;


//Empieza la configuración 

void setup () 
{

  //Tamaño de pantalla 
  
  size(480, 480);
  
  minim=new Minim(this);
  
  in = minim.getLineIn();
  
  webcam = new Capture(this,640,480); 
  String[] devices = Capture.list();
  //println(devices);
  webcam.start();
  
  //cargar imagen
  //img = loadImage("img.jpg");
 
  background(0);
  
  stroke(255);
  
  noFill();

}

// Acá va lo que va a mostrar o imprimir 

void draw ()
{

  
  
background (0);

stroke (255);

fill(255);

//variable para la "energia" del audio en ese momento
float energia = 0;
for(int i = 0; i < in.bufferSize() -1; i++)
{

//ellipse(255,256,in.right.get(i)*2000,in.right.get(i)*2000);

  //agregar los valores del buffer de audio
  energia += abs(in.right.get(i));
}

 //tamaño de pixeles = energia de audio
 if (webcam.available() == true) {
    webcam.read();
    image(webcam ,0,0);
  }
  saveFrame("line.bmp");
 
 //acceder los pixeles uno por uno, dibujar un rectangulo 
  float pixSize = energia;
  for (int i = 0; i < webcam.width; i+=pixSize){
    for (int j = 0; j < webcam.height; j+=pixSize){
      color pix = webcam.get(i, j);
    
      fill(pix);
      noStroke();
      ellipse(i+1,j+1,pixSize-1,pixSize-1);
  }
}
}