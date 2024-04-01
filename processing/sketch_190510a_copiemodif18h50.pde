

BufferedReader reader;
String line;
int[] colors= new int[23];

String inputFile="lastBestSolutionProcessing_pieces_05x05.txt";
boolean afficherCorrect =true;
boolean afficherErreur =true;
// Set the size of the window
int x_window = 800;
int y_window = 800;
int t=min(x_window/18, y_window/18);

void setup() {
  size(1000, 1000);
  clear();

  // Draw a white background
  background(255, 255, 255);
}

void draw() {
  clear();
  int c1=0, c2=0, c3=0, c4=0; //4 couleurs
  int l=0, h=0; //largeur, hauteur
  int nbColor; // nombre de couleurs diffÃ©rentes
  Piece[] tab = new Piece[0]; //tableau contenant toutes les piÃ¨ces
  int[] c={0};
  String[] decoupe;//Utile pour rÃ©cuperer les diffÃ©rents Ã©lÃ©ments de chaque ligne du fichier d'entrÃ©e

  reader = createReader(inputFile); //Ouverture du fichier d'entrÃ©e
  line="";
  int cpt=0;
  int d=0;
  while (line != null) {
    try {
      line = reader.readLine(); //lecture ligne par ligne
    }
    catch (IOException e) {
      e.printStackTrace();
      line = null;
    }
    if (line != null) {
      // Stop reading because of an error or file is empty
      noLoop();
      if (cpt==0) { //on recupere le format du puzzle
        decoupe = split(line, "\t");
        l = int(decoupe[0]);
        h = int(decoupe[1]);
        tab = new Piece[l*h];
        cpt++;
      } else if (cpt==1) { //on recupere le nombre de couleurs du puzzle
        decoupe = split(line, "\t");
        nbColor = int(decoupe[0]);
        cpt++;
      } else { //on recupere les couleurs de chaque piece

        decoupe = split(line, "\t");
        c1 = int(decoupe[0]);
        c2 = int(decoupe[1]);
        c3 = int(decoupe[2]);
        c4 = int(decoupe[3]);
        int s = l*h;
        int rest = cpt-2;
        if (rest<s) {
          tab[cpt-2]=new Piece(c1, c2, c3, c4);//crÃ©ation d'une nouvelle piÃ¨ce avec les 4 couleurs rÃ©cupÃ©rÃ©es*/
        }

        cpt++;
      }
    }
  }

  //Affichage des triangles de couleurs de chaque piÃ¨ce

  int dec_xcube = (x_window - (t*l))/2; //decalage;
  int dec_ycube = (y_window - (t*h))/2; //decalage;

  for (int i=0; i<l; i++) {
    for (int j=0; j<h; j++) {

      String nomFonction ="";
      //haut

      nomFonction = "formeh"+ tab[j+i*l].c2;
      selectForm(nomFonction, (i*t)+dec_xcube, (j*t)+dec_ycube);


      //gauche

      nomFonction = "formeg"+tab[j+i*l].c1;
      selectForm(nomFonction, (i*t)+dec_xcube, (j*t)+dec_ycube);

      //bas

      nomFonction = "formeb"+tab[j+i*l].c4;
      selectForm(nomFonction, (i*t)+dec_xcube, (j*t)+dec_ycube);

      //droite

      nomFonction = "formed"+tab[j+i*l].c3;
      selectForm(nomFonction, (i*t)+dec_xcube, (j*t)+dec_ycube);
    }
  }

  //Affichage des bonnes et mauvaise correspondances
  for (int i=0; i<l; i++) {
    for (int j=0; j<h; j++) {
      if (i<(l-1)) {
        if (tab[(j+i*l)].c3 == tab[(j+(i+1)*l)].c1) { //correspondance gauche/droite
          if (afficherCorrect) {//affichage rond vert
            fill(0, 255, 0);
            circle((i*t+t)+dec_xcube, (j*t+t/2)+dec_ycube, t/10);
          }
        } else {
          if (afficherErreur) {//affichage rond rouge
            fill(255, 0, 0);
            circle((i*t+t)+dec_xcube, (j*t+t/2)+dec_ycube, t/10);
          }
        }
      }
      if (j<(h-1)) {
        if (tab[i*l+j].c4 == tab[j+1+i*l].c2) { //correspondance haut/bas
          if (afficherCorrect) {//affichage rond vert
            fill(0, 255, 0);
            circle((i*t+t/2)+dec_xcube, (j*t+t)+dec_ycube, t/10);
          }
        } else {
          if (afficherErreur) {//affichage rond rouge
            fill(255, 0, 0);
            circle((i*t+t/2)+dec_xcube, (j*t+t)+dec_ycube, t/10);
          }
        }
      }
    }
  }
  //Test d'ajout d'une forme
  //forme7(100,0,64);
}

//Test d'une forme libre

void forme1(int a, int b, int t) {
  fill(100, 200, 0);
  beginShape();
  vertex(a, a+5);
  vertex(a+27, a+32);
  vertex(a, a+59);
  vertex(a, a+49);
  vertex(a+17, a+32);
  vertex(a, a+15);
  endShape(CLOSE);
}

//Test d'une forme libre
void forme7(int x1, int y1, int x2, int y2, int x3, int y3) {

  int a = x1;
  fill(100, 200, 0);
  beginShape();
  vertex(a, a+10);
  vertex(a+5, a+5);
  vertex(a+4, a+13);
  vertex(a+15, a+20);
  vertex(a+4, a+27);
  vertex(a+5, a+35);
  vertex(a, a+30);
  endShape(CLOSE);
}


//Classe Piece contenant pour l'instant uniquement les 4 couleurs
class Piece {
  public int c1, c2, c3, c4;
  Piece(int _c1, int _c2, int _c3, int _c4) {
    c1=_c1; //haut
    c2=_c2; //gauche
    c3=_c3; //bas
    c4=_c4; //droite
  }
}


void formeg0(int a, int b) {

  fill(255, 255, 0);
  triangle(a, b, a, b+t, a+t/2, b+t/2);
}
void formeh0(int a, int b) {

  fill(255, 255, 0);
  triangle(a, b, a+t, b, a+t/2, b+t/2);
}
void formeb0(int a, int b) {

  fill(255, 255, 0);
  triangle(a+t, b+t, a, b+t, a+t/2, b+t/2);
}
void formed0(int a, int b) {

  fill(255, 255, 0);
  triangle(a+t, b, a+t, b+t, a+t/2, b+t/2);
}
//_------------------------------ forme 1 ------------------------
//Test d'une forme libre
void formeg1(int a, int b) {

  fill(255, 255, 0);
  triangle(a, b, a, b+t, a+t/2, b+t/2);
  fill(100, 200, 0);
  beginShape();
  vertex(a, b+t/6);
  vertex(a+t/3, b+t/2);
  vertex(a, b+5*t/6);
  vertex(a, b+2*t/3);
  vertex(a+t/6, b+t/2);
  vertex(a, b+t/3);
  endShape(CLOSE);
}
void formeh1(int a, int b) {

  fill(255, 255, 0);
  triangle(a, b, a+t, b, a+t/2, b+t/2);
  fill(100, 200, 0);
  beginShape();
  vertex(a+t/6, b);
  vertex(a+t/2, b+t/3);
  vertex(a+5*t/6, b);
  vertex(a+2*t/3, b);
  vertex(a+t/2, b+t/6);
  vertex(a+t/3, b);
  endShape(CLOSE);
}
void formeb1(int a, int b) {

  fill(255, 255, 0);
  triangle(a+t, b+t, a, b+t, a+t/2, b+t/2);
  fill(100, 200, 0);
  beginShape();
  vertex(a+t/6, b+t);
  vertex(a+t/2, b+2*t/3);
  vertex(a+5*t/6, b+t);
  vertex(a+2*t/3, b+t);
  vertex(a+t/2, b+5*t/6);
  vertex(a+t/3, b+t);
  endShape(CLOSE);
}
void formed1(int a, int b) {

  fill(255, 255, 0);
  triangle(a+t, b, a+t, b+t, a+t/2, b+t/2);
  fill(100, 200, 0);
  beginShape();
  vertex(a+t, b+t/6);
  vertex(a+2*t/3, b+t/2);
  vertex(a+t, b+5*t/6);
  vertex(a+t, b+2*t/3);
  vertex(a+5*t/6, b+t/2);
  vertex(a+t, b+t/3);
  endShape(CLOSE);
}

//_------------------------------ forme 2 ------------------------

void formeg2(int a, int b) {
  fill(38, 108, 121);
  triangle(a, b, a, b+t, a+t/2, b+t/2);
  fill(115, 206, 206);
  beginShape();
  vertex(a, b+t/6);
  vertex(a+t/3, b+t/2);
  vertex(a, b+5*t/6);
  vertex(a, b+2*t/3);
  vertex(a+t/6, b+t/2);
  vertex(a, b+t/3);
  endShape(CLOSE);
}
void formed2(int a, int b) {
  fill(38, 108, 121);
  triangle(a+t, b+t, a+t, b, a+t/2, b+t/2);
  fill(115, 206, 206);
  beginShape();
  vertex(a+t, b+t/6);
  vertex(a+2*t/3, b+t/2);
  vertex(a+t, b+5*t/6);
  vertex(a+t, b+2*t/3);
  vertex(a+5*t/6, b+t/2);
  vertex(a+t, b+t/3);
  endShape(CLOSE);
}
void formeh2(int a, int b) {

  fill(38, 108, 121);
  triangle(a, b, a+t, b, a+t/2, b+t/2);
  fill(115, 206, 206);
  beginShape();
  vertex(a+t/6, b);
  vertex(a+t/2, b+t/3);
  vertex(a+5*t/6, b);
  vertex(a+2*t/3, b);
  vertex(a+t/2, b+t/6);
  vertex(a+t/3, b);
  endShape(CLOSE);
}
void formeb2(int a, int b) {

  fill(38, 108, 121);
  triangle(a+t, b+t, a, b+t, a+t/2, b+t/2);
  fill(115, 206, 206);
  beginShape();
  vertex(a+t/6, b+t);
  vertex(a+t/2, b+2*t/3);
  vertex(a+5*t/6, b+t);
  vertex(a+2*t/3, b+t);
  vertex(a+t/2, b+5*t/6);
  vertex(a+t/3, b+t);
  endShape(CLOSE);
}


//------------------------------ forme 3 ---------------------------------------

void formeg3(int a, int b) {
  fill(255, 174, 1);
  triangle(a, b, a, b+t, a+t/2, b+t/2);

  push();
  noStroke();
  fill(80, 100, 255);
  arc(a, b+t/2, t/2, t/2, -PI/2, PI/2);
  fill(255, 174, 1);

  arc(a+t/6, b+5*t/16, t/4, t/4, 0, 6*PI/4);
  arc(a+t/6, b+11*t/16, t/4, t/4, 2*PI/4, 8*PI/4);
  pop();
}
void formed3(int a, int b) {


  fill(255, 174, 1);
  triangle(a+t, b+t, a+t, b, a+t/2, b+t/2);

  push();
  noStroke();
  fill(80, 100, 255);
  arc(a+t, b+t/2, t/2, t/2, PI/2, 3*PI/2);
  fill(255, 174, 1);

  arc(a+5*t/6, b+5*t/16, t/4, t/4, -PI/4, 3*PI/4);
  arc(a+5*t/6, b+11*t/16, t/4, t/4, -3*PI/4, PI/4);
  pop();
}
void formeh3(int a, int b) {


  fill(255, 174, 1);
  triangle(a, b, a+t, b, a+t/2, b+t/2);

  push();
  noStroke();
  fill(80, 100, 255);
  arc(a+t/2, b, t/2, t/2, 0, PI);
  fill(255, 174, 1);

  arc(a+5*t/16, b+t/6, t/4, t/4, -3*PI/4, PI/4);
  arc(a+11*t/16, b+t/6, t/4, t/4, 3*PI/4, 7*PI/4);
  pop();
}
void formeb3(int a, int b) {


  fill(255, 174, 1);
  triangle(a+t, b+t, a, b+t, a+t/2, b+t/2);

  push();
  noStroke();
  fill(80, 100, 255);
  arc(a+t/2, b+t, t/2, t/2, PI, 2*PI);
  fill(255, 174, 1);

  arc(a+5*t/16, b+5*t/6, t/4, t/4, -PI/4, 3*PI/4);
  arc(a+11*t/16, b+5*t/6, t/4, t/4, PI/4, 5*PI/4);
  pop();
}
void formeg4(int a, int b) {
  fill(149, 11, 80);
  triangle(a, b, a, b+t, a+t/2, b+t/2);
  push();
  noStroke();


  fill(242, 227, 6);

  beginShape();
  vertex(a, b+t/5);
  vertex(a+t/16, b+t/5);
  vertex(a+t/16, b+2*t/5);
  vertex(a+t/4, b+2*t/5);
  vertex(a+t/4, b+3*t/5);
  vertex(a+t/16, b+3*t/5);
  vertex(a+t/16, b+7*t/10);
  vertex(a, b+4*t/5);
  endShape(CLOSE);
  arc(a, b+t/5, t/5, t/5, -PI/2, PI/2);
  arc(a, b+4*t/5, t/5, t/5, -PI/2, PI/2);
  ellipse(a+t/4, b+t/2, t/4, t/4);
  pop();
}
void formed4(int a, int b) {
  fill(149, 11, 80);
  triangle(a+t, b+t, a+t, b, a+t/2, b+t/2);
  push();
  noStroke();
  fill(242, 227, 6);
  beginShape();
  vertex(a+t, b+t/5);
  vertex(a+15*t/16, b+t/5);
  vertex(a+15*t/16, b+2*t/5);
  vertex(a+3*t/4, b+2*t/5);
  vertex(a+3*t/4, b+3*t/5);
  vertex(a+15*t/16, b+3*t/5);
  vertex(a+15*t/16, b+7*t/10);
  vertex(a+t, b+4*t/5);
  endShape(CLOSE);
  arc(a+t, b+t/5, t/5, t/5, PI/2, 3*PI/2);
  arc(a+t, b+4*t/5, t/5, t/5, PI/2, 3*PI/2);
  ellipse(a+3*t/4, b+t/2, t/4, t/4);
  pop();
}
void formeh4(int a, int b) {
  fill(149, 11, 80);
  triangle(a, b, a+t, b, a+t/2, b+t/2);
  push();
  noStroke();
  fill(242, 227, 6);
  beginShape();
  vertex(a+t/5, b);
  vertex(a+t/5, b+t/16);
  vertex(a+2*t/5, b+t/16);
  vertex(a+2*t/5, b+t/4);
  vertex(a+3*t/5, b+t/4);
  vertex(a+3*t/5, b+t/16);
  vertex(a+7*t/10, b+t/16);
  vertex(a+4*t/5, b);
  endShape(CLOSE);
  arc(a+t/5, b, t/5, t/5, 0, PI);
  arc(a+4*t/5, b, t/5, t/5, 0, PI);
  ellipse(a+t/2, b+t/4, t/4, t/4);
  pop();
}
void formeb4(int a, int b) {
  fill(149, 11, 80);
  triangle(a+t, b+t, a, b+t, a+t/2, b+t/2);
  push();
  noStroke();
  fill(242, 227, 6);
  beginShape();
  vertex(a+t/5, b+t);
  vertex(a+t/5, b+15*t/16);
  vertex(a+2*t/5, b+15*t/16);
  vertex(a+2*t/5, b+3*t/4);
  vertex(a+3*t/5, b+3*t/4);
  vertex(a+3*t/5, b+15*t/16);
  vertex(a+7*t/10, b+15*t/16);
  vertex(a+4*t/5, b+t);
  endShape(CLOSE);
  arc(a+t/5, b+t, t/5, t/5, PI, 2*PI);
  arc(a+4*t/5, b+t, t/5, t/5, PI, 2*PI);
  ellipse(a+t/2, b+3*t/4, t/4, t/4);
  pop();
}


// ------------------------------------forme 5-------------------------------------------


void formeg5(int a, int b) {
  fill(38, 108, 121);
  triangle(a, b, a, b+t, a+t/2, b+t/2);
  push();
  noStroke();
  fill(255, 174, 1);
  beginShape();
  vertex(a, b+t/5);
  vertex(a+t/16, b+t/5);
  vertex(a+t/16, b+2*t/5);
  vertex(a+t/4, b+2*t/5);
  vertex(a+t/4, b+3*t/5);
  vertex(a+t/16, b+3*t/5);
  vertex(a+t/16, b+7*t/10);
  vertex(a, b+4*t/5);
  endShape(CLOSE);
  arc(a, b+t/5, t/5, t/5, -PI/2, PI/2);
  arc(a, b+4*t/5, t/5, t/5, -PI/2, PI/2);
  ellipse(a+t/4, b+t/2, t/4, t/4);
  pop();
}
void formed5(int a, int b) {
  fill(38, 108, 121);
  triangle(a+t, b+t, a+t, b, a+t/2, b+t/2);
  push();
  noStroke();
  fill(255, 174, 1);
  beginShape();
  vertex(a+t, b+t/5);
  vertex(a+15*t/16, b+t/5);
  vertex(a+15*t/16, b+2*t/5);
  vertex(a+3*t/4, b+2*t/5);
  vertex(a+3*t/4, b+3*t/5);
  vertex(a+15*t/16, b+3*t/5);
  vertex(a+15*t/16, b+7*t/10);
  vertex(a+t, b+4*t/5);
  endShape(CLOSE);
  arc(a+t, b+t/5, t/5, t/5, PI/2, 3*PI/2);
  arc(a+t, b+4*t/5, t/5, t/5, PI/2, 3*PI/2);
  ellipse(a+3*t/4, b+t/2, t/4, t/4);
  pop();
}
void formeh5(int a, int b) {
  fill(38, 108, 121);
  triangle(a, b, a+t, b, a+t/2, b+t/2);
  push();
  noStroke();
  fill(255, 174, 1);
  beginShape();
  vertex(a+t/5, b);
  vertex(a+t/5, b+t/16);
  vertex(a+2*t/5, b+t/16);
  vertex(a+2*t/5, b+t/4);
  vertex(a+3*t/5, b+t/4);
  vertex(a+3*t/5, b+t/16);
  vertex(a+7*t/10, b+t/16);
  vertex(a+4*t/5, b);
  endShape(CLOSE);
  arc(a+t/5, b, t/5, t/5, 0, PI);
  arc(a+4*t/5, b, t/5, t/5, 0, PI);
  ellipse(a+t/2, b+t/4, t/4, t/4);
  pop();
}
void formeb5(int a, int b) {
  fill(38, 108, 121);
  triangle(a+t, b+t, a, b+t, a+t/2, b+t/2);
  push();
  noStroke();
  fill(255, 174, 1);
  beginShape();
  vertex(a+t/5, b+t);
  vertex(a+t/5, b+15*t/16);
  vertex(a+2*t/5, b+15*t/16);
  vertex(a+2*t/5, b+3*t/4);
  vertex(a+3*t/5, b+3*t/4);
  vertex(a+3*t/5, b+15*t/16);
  vertex(a+7*t/10, b+15*t/16);
  vertex(a+4*t/5, b+t);
  endShape(CLOSE);
  arc(a+t/5, b+t, t/5, t/5, PI, 2*PI);
  arc(a+4*t/5, b+t, t/5, t/5, PI, 2*PI);
  ellipse(a+t/2, b+3*t/4, t/4, t/4);
  pop();
}


//-----------------------------------forme 6 ----------------------------------------------

void formeg6(int a, int b) {
  fill(6, 22, 80);
  triangle(a, b, a, b+t, a+t/2, b+t/2);
  fill(242, 227, 6);
  push();
  noStroke();
  arc(a, b+t/3, t/6, t/3, -PI/2, PI/2);

  arc(a, b+2*t/3, t/6, t/3, -PI/2, PI/2);
  ellipse(a+t/8, b+t/2, t/5, t/3);

  fill(6, 22, 80);
  arc(a, b+t/2, t/7, t/3, -PI/2, PI/2);
  pop();
}
void formed6(int a, int b) {
  fill(6, 22, 80);
  triangle(a+t, b+t, a+t, b, a+t/2, b+t/2);
  fill(242, 227, 6);
  push();
  noStroke();
  arc(a+t, b+t/3, t/6, t/3, PI/2, 3*PI/2);

  arc(a+t, b+2*t/3, t/6, t/3, PI/2, 3*PI/2);
  ellipse(a+7*t/8, b+t/2, t/5, t/3);

  fill(6, 22, 80);
  arc(a+t, b+t/2, t/7, t/3, PI/2, 3*PI/2);
  pop();
}
void formeh6(int a, int b) {
  fill(6, 22, 80);
  triangle(a, b, a+t, b, a+t/2, b+t/2);
  fill(242, 227, 6);
  push();
  noStroke();
  arc(a+t/3, b, t/3, t/6, 0, PI);

  arc(a+2*t/3, b, t/3, t/6, 0, PI);
  ellipse(a+t/2, b+t/8, t/3, t/5);

  fill(6, 22, 80);
  arc(a+t/2, b, t/3, t/7, 0, PI);
  pop();
}
void formeb6(int a, int b) {
  fill(6, 22, 80);
  triangle(a, b+t, a+t, b+t, a+t/2, b+t/2);
  fill(242, 227, 6);
  push();
  noStroke();
  arc(a+t/3, b+t, t/3, t/6, PI, 2*PI);

  arc(a+2*t/3, b+t, t/3, t/6, PI, 2*PI);
  ellipse(a+t/2, b+7*t/8, t/3, t/5);

  fill(6, 22, 80);
  arc(a+t/2, b+t, t/3, t/7, PI, 2*PI);
  pop();
}

//------------------------------------- forme 7 ------------------------------------


void formeg7(int a, int b) {
  fill(144, 58, 42);
  triangle(a, b, a, b+t, a+t/2, b+t/2);
  fill(245, 227, 6);
  beginShape();
  vertex(a, b+t/4);
  vertex(a+5*t/36, b+t/6);
  vertex(a+4*t/36, b+3*t/8);
  vertex(a+t/3, b+t/2);
  vertex(a+4*t/36, b+5*t/8);
  vertex(a+5*t/36, b+5*t/6);
  vertex(a, b+3*t/4);
  endShape(CLOSE);
}
void formed7(int a, int b) {
  fill(144, 58, 42);
  triangle(a+t, b+t, a+t, b, a+t/2, b+t/2);
  fill(245, 227, 6);
  beginShape();
  vertex(a+t, b+t/4);
  vertex(a+31*t/36, b+t/6);
  vertex(a+32*t/36, b+3*t/8);
  vertex(a+2*t/3, b+t/2);
  vertex(a+32*t/36, b+5*t/8);
  vertex(a+31*t/36, b+5*t/6);
  vertex(a+t, b+3*t/4);
  endShape(CLOSE);
}
void formeh7(int a, int b) {
  fill(144, 58, 42);
  triangle(a, b, a+t, b, a+t/2, b+t/2);
  fill(245, 227, 6);
  beginShape();
  vertex(a+t/4, b);
  vertex(a+t/6, b+5*t/36);
  vertex(a+3*t/8, b+4*t/36);
  vertex(a+t/2, b+t/3);
  vertex(a+5*t/8, b+4*t/36);
  vertex(a+5*t/6, b+5*t/36);
  vertex(a+3*t/4, b);
  endShape(CLOSE);
}
void formeb7(int a, int b) {
  fill(144, 58, 42);
  triangle(a, b+t, a+t, b+t, a+t/2, b+t/2);
  fill(245, 227, 6);
  beginShape();
  vertex(a+t/4, b+t);
  vertex(a+t/6, b+31*t/36);
  vertex(a+3*t/8, b+32*t/36);
  vertex(a+t/2, b+2*t/3);
  vertex(a+5*t/8, b+32*t/36);
  vertex(a+5*t/6, b+31*t/36);
  vertex(a+3*t/4, b+t);
  endShape(CLOSE);
}


//--------------------------------forme 8 -----------------------
void formeg8(int a, int b) {
  fill(149, 11, 80);
  triangle(a, b, a, b+t, a+t/2, b+t/2);
  push();
  noStroke();
  fill(100, 181, 236);
  beginShape();
  vertex(a, b+t/4);
  vertex(a+t/9, b+t/4);
  vertex(a+t/4, b+5*t/12);
  vertex(a+t/4, b+7*t/12);
  vertex(a+t/9, b+3*t/4);
  vertex(a, b+3*t/4);
  vertex(a, b+2*t/3);
  vertex(a+t/6, b+t/2);
  vertex(a, b+t/3);
  endShape(CLOSE);
  fill(149, 11, 80);
  arc(a+13*t/72, b+4*t/12, 7*t/36, t/6, 0, 6*PI/4);
  arc(a+13*t/72, b+2*t/3, 7*t/36, t/6, 2*PI/4, 8*PI/4);
  pop();
}
void formed8(int a, int b) {
  fill(149, 11, 80);
  triangle(a+t, b+t, a+t, b, a+t/2, b+t/2);
  push();
  noStroke();
  fill(100, 181, 236);
  beginShape();
  vertex(a+t, b+t/4);
  vertex(a+8*t/9, b+t/4);
  vertex(a+3*t/4, b+5*t/12);
  vertex(a+3*t/4, b+7*t/12);
  vertex(a+8*t/9, b+3*t/4);
  vertex(a+t, b+3*t/4);
  vertex(a+t, b+2*t/3);
  vertex(a+5*t/6, b+t/2);
  vertex(a+t, b+t/3);
  endShape(CLOSE);
  fill(149, 11, 80);
  arc(a+59*t/72, b+4*t/12, 7*t/36, t/6, PI/3, 7*PI/3);
  arc(a+59*t/72, b+2*t/3, 7*t/36, t/6, -3*PI/4, 5*PI/4);
  pop();
}
void formeh8(int a, int b) {
  fill(149, 11, 80);
  triangle(a, b, a+t, b, a+t/2, b+t/2);
  push();
  noStroke();
  fill(100, 181, 236);
  beginShape();
  vertex(a+t/4, b);
  vertex(a+t/4, b+t/9);
  vertex(a+5*t/12, b+t/4);
  vertex(a+7*t/12, b+t/4);
  vertex(a+3*t/4, b+t/9);
  vertex(a+3*t/4, b);
  vertex(a+2*t/3, b);
  vertex(a+t/2, b+t/6);
  vertex(a+t/3, b);
  endShape(CLOSE);
  fill(149, 11, 80);
  arc(a+4*t/12, b+13*t/72, t/6, 7*t/36, 2*PI/2, 7*PI/2);
  arc(a+2*t/3, b+13*t/72, t/6, 7*t/36, 3*PI/4, 8*PI/4);
  pop();
}
void formeb8(int a, int b) {
  fill(149, 11, 80);
  triangle(a, b+t, a+t, b+t, a+t/2, b+t/2);
  push();
  noStroke();
  fill(100, 181, 236);
  beginShape();
  vertex(a+t/4, b+t);
  vertex(a+t/4, b+8*t/9);
  vertex(a+5*t/12, b+3*t/4);
  vertex(a+7*t/12, b+3*t/4);
  vertex(a+3*t/4, b+8*t/9);
  vertex(a+3*t/4, b+t);
  vertex(a+2*t/3, b+t);
  vertex(a+t/2, b+5*t/6);
  vertex(a+t/3, b+t);
  endShape(CLOSE);
  fill(149, 11, 80);
  arc(a+4*t/12, b+59*t/72, t/6, 7*t/36, -PI/3, 4*PI/4);
  arc(a+2*t/3, b+59*t/72, t/6, 7*t/36, PI/5, 7*PI/4);
  pop();
}

//---------------------- forme 9 --------------------------------------


void formeg9(int a, int b) {
  fill(75, 24, 100);
  triangle(a, b, a, b+t, a+t/2, b+t/2);
  push();
  noStroke();
  fill(249, 252, 36);
  arc(a, b+t/2, t/2, t/2, -PI/2, PI/2);
  fill(75, 24, 100);
  beginShape();
  vertex(a, b+3*t/8);
  vertex(a+t/12, b+5*t/16);
  vertex(a+2*t/12, b+3*t/8);
  vertex(a+t/30, b+t/2);
  vertex(a+2*t/12, b+5*t/8);
  vertex(a+t/12, b+11*t/16);
  vertex(a, b+5*t/8);
  endShape(CLOSE);
  pop();
}
void formed9(int a, int b) {
  fill(75, 24, 100);
  triangle(a+t, b+t, a+t, b, a+t/2, b+t/2);
  push();
  noStroke();
  fill(249, 252, 36);
  arc(a+t, b+t/2, t/2, t/2, PI/2, 3*PI/2);
  fill(75, 24, 100);
  beginShape();
  vertex(a+t, b+3*t/8);
  vertex(a+11*t/12, b+5*t/16);
  vertex(a+10*t/12, b+3*t/8);
  vertex(a+29*t/30, b+t/2);
  vertex(a+10*t/12, b+5*t/8);
  vertex(a+11*t/12, b+11*t/16);
  vertex(a+t, b+5*t/8);
  endShape(CLOSE);
  pop();
}
void formeh9(int a, int b) {
  fill(75, 24, 100);
  triangle(a, b, a+t, b, a+t/2, b+t/2);
  push();
  noStroke();
  fill(249, 252, 36);
  arc(a+t/2, b, t/2, t/2, 0, PI);
  fill(75, 24, 100);
  beginShape();
  vertex(a+3*t/8, b);
  vertex(a+5*t/16, b+t/12);
  vertex(a+3*t/8, b+2*t/12);
  vertex(a+t/2, b+t/30);
  vertex(a+5*t/8, b+2*t/12);
  vertex(a+11*t/16, b+t/12);
  vertex(a+5*t/8, b);
  endShape(CLOSE);
  pop();
}
void formeb9(int a, int b) {
  fill(75, 24, 100);
  triangle(a, b+t, a+t, b+t, a+t/2, b+t/2);
  push();
  noStroke();
  fill(249, 252, 36);
  arc(a+t/2, b+t, t/2, t/2, PI, 2*PI);
  fill(75, 24, 100);
  beginShape();
  vertex(a+3*t/8, b+t);
  vertex(a+5*t/16, b+11*t/12);
  vertex(a+3*t/8, b+10*t/12);
  vertex(a+t/2, b+29*t/30);
  vertex(a+5*t/8, b+10*t/12);
  vertex(a+11*t/16, b+11*t/12);
  vertex(a+5*t/8, b+t);
  endShape(CLOSE);
  pop();
}

//-------------------------  forme 10  ---------------------------------------------


void formeg10(int a, int b) {
  fill(90, 37, 75);
  triangle(a, b, a, b+t, a+t/2, b+t/2);
  push();
  noStroke();
  fill(124, 199, 189);
  beginShape();
  vertex(a, b+5*t/28);
  vertex(a+t/14, b+t/4);
  vertex(a+t/28, b+3*t/7);
  vertex(a+3*t/14, b+5*t/14);
  vertex(a+9*t/28, b+t/2);
  vertex(a+3*t/14, b+17*t/28);
  vertex(a+t/28, b+15*t/28);
  vertex(a+t/14, b+3*t/4);
  vertex(a, b+23*t/28);
  endShape(CLOSE);
  pop();
}
void formed10(int a, int b) {
  fill(90, 37, 75);
  triangle(a+t, b, a+t, b+t, a+t/2, b+t/2);
  push();
  noStroke();
  fill(124, 199, 189);
  beginShape();
  vertex(a+t, b+5*t/28);
  vertex(a+13*t/14, b+t/4);
  vertex(a+27*t/28, b+3*t/7);
  vertex(a+11*t/14, b+5*t/14);
  vertex(a+19*t/28, b+t/2);
  vertex(a+11*t/14, b+17*t/28);
  vertex(a+27*t/28, b+15*t/28);
  vertex(a+13*t/14, b+3*t/4);
  vertex(a+t, b+23*t/28);
  endShape(CLOSE);
  pop();
}
void formeh10(int a, int b) {
  fill(90, 37, 75);
  triangle(a, b, a+t, b, a+t/2, b+t/2);
  push();
  noStroke();
  fill(124, 199, 189);
  beginShape();
  vertex(a+5*t/28, b);
  vertex(a+t/4, b+t/14);
  vertex(a+3*t/7, b+t/28);
  vertex(a+5*t/14, b+3*t/14);
  vertex(a+t/2, b+9*t/28);
  vertex(a+17*t/28, b+3*t/14);
  vertex(a+15*t/28, b+t/28);
  vertex(a+3*t/4, b+t/14);
  vertex(a+23*t/28, b);
  endShape(CLOSE);
  pop();
}
void formeb10(int a, int b) {
  fill(90, 37, 75);
  triangle(a, b+t, a+t, b+t, a+t/2, b+t/2);
  push();
  noStroke();
  fill(124, 199, 189);
  beginShape();
  vertex(a+5*t/28, b+t);
  vertex(a+t/4, b+13*t/14);
  vertex(a+3*t/7, b+27*t/28);
  vertex(a+5*t/14, b+11*t/14);
  vertex(a+t/2, b+19*t/28);
  vertex(a+17*t/28, b+11*t/14);
  vertex(a+15*t/28, b+27*t/28);
  vertex(a+3*t/4, b+13*t/14);
  vertex(a+23*t/28, b+t);
  endShape(CLOSE);
  pop();
}

//------------------------------------------ forme 11 ---------------------------------------------------------


void formeg11(int a, int b) {
  fill(90, 37, 75);
  triangle(a, b, a, b+t, a+t/2, b+t/2);
  fill(155, 0, 0);
  push();
  noStroke();
  beginShape();
  curveVertex(a, b+t/8);
  curveVertex(a, b+t/8);
  curveVertex(a+t/16, b+t/4);
  curveVertex(a+t/5, b+3*t/8);
  curveVertex(a+t/5, b+5*t/8);
  curveVertex(a+t/16, b+3*t/4);
  curveVertex(a, b+7*t/8);
  curveVertex(a, b+7*t/8);
  endShape(CLOSE);
  fill(90, 37, 75);
  beginShape();
  curveVertex(a, b+3*t/8);
  curveVertex(a, b+3*t/8);
  curveVertex(a+t/5, b+t/2);
  curveVertex(a, b+5*t/8);
  curveVertex(a, b+5*t/8);
  endShape(CLOSE);
  fill(155, 0, 0);
  arc(a+t/5, b+t/2, t/3, t/4, 3*PI/2, 5*PI/2);
  pop();
}
void formed11(int a, int b) {
  fill(90, 37, 75);
  triangle(a+t, b, a+t, b+t, a+t/2, b+t/2);
  fill(155, 0, 0);
  push();
  noStroke();
  beginShape();
  curveVertex(a+t, b+t/8);
  curveVertex(a+t, b+t/8);
  curveVertex(a+15*t/16, b+t/4);
  curveVertex(a+4*t/5, b+3*t/8);
  curveVertex(a+4*t/5, b+5*t/8);
  curveVertex(a+15*t/16, b+3*t/4);
  curveVertex(a+t, b+7*t/8);
  curveVertex(a+t, b+7*t/8);
  endShape(CLOSE);
  fill(90, 37, 75);
  beginShape();
  curveVertex(a+t, b+3*t/8);
  curveVertex(a+t, b+3*t/8);
  curveVertex(a+4*t/5, b+t/2);
  curveVertex(a+t, b+5*t/8);
  curveVertex(a+t, b+5*t/8);
  endShape(CLOSE);
  fill(155, 0, 0);
  arc(a+4*t/5, b+t/2, t/3, t/4, PI/3, 5*PI/3);
  pop();
}
void formeh11(int a, int b) {
  fill(90, 37, 75);
  triangle(a, b, a+t, b, a+t/2, b+t/2);
  fill(155, 0, 0);
  push();
  noStroke();
  beginShape();
  curveVertex(a+t/8, b);
  curveVertex(a+t/8, b);
  curveVertex(a+t/4, b+t/16);
  curveVertex(a+3*t/8, b+t/5);
  curveVertex(a+5*t/8, b+t/5);
  curveVertex(a+3*t/4, b+t/16);
  curveVertex(a+7*t/8, b);
  curveVertex(a+7*t/8, b);
  endShape(CLOSE);
  fill(90, 37, 75);
  beginShape();
  curveVertex(a+3*t/8, b);
  curveVertex(a+3*t/8, b);
  curveVertex(a+t/2, b+t/5);
  curveVertex(a+5*t/8, b);
  curveVertex(a+5*t/8, b);
  endShape(CLOSE);
  fill(155, 0, 0);
  arc(a+t/2, b+t/5, t/4, t/3, -PI/4, 5*PI/4);
  pop();
}
void formeb11(int a, int b) {
  fill(90, 37, 75);
  triangle(a, b+t, a+t, b+t, a+t/2, b+t/2);
  fill(155, 0, 0);
  push();
  noStroke();
  beginShape();
  curveVertex(a+t/8, b+t);
  curveVertex(a+t/8, b+t);
  curveVertex(a+t/4, b+15*t/16);
  curveVertex(a+3*t/8, b+4*t/5);
  curveVertex(a+5*t/8, b+4*t/5);
  curveVertex(a+3*t/4, b+15*t/16);
  curveVertex(a+7*t/8, b+t);
  curveVertex(a+7*t/8, b+t);
  endShape(CLOSE);
  fill(90, 37, 75);
  beginShape();
  curveVertex(a+3*t/8, b+t);
  curveVertex(a+3*t/8, b+t);
  curveVertex(a+t/2, b+4*t/5);
  curveVertex(a+5*t/8, b+t);
  curveVertex(a+5*t/8, b+t);
  endShape(CLOSE);
  fill(155, 0, 0);
  arc(a+t/2, b+4*t/5, t/4, t/3, 3*PI/4, 8*PI/4);
  pop();
}


//-------------------------------- forme 12 -------------------------------------------------


void formeg12(int a, int b) {
  fill(245, 227, 6);
  triangle(a, b, a, b+t, a+t/2, b+t/2);
  fill(100, 181, 236);
  beginShape();
  vertex(a, b+t/4);
  vertex(a+5*t/36, b+t/6);
  vertex(a+4*t/36, b+3*t/8);
  vertex(a+t/3, b+t/2);
  vertex(a+4*t/36, b+5*t/8);
  vertex(a+5*t/36, b+5*t/6);
  vertex(a, b+3*t/4);
  endShape(CLOSE);
}
void formed12(int a, int b) {
  fill(245, 227, 6);
  triangle(a+t, b+t, a+t, b, a+t/2, b+t/2);
  fill(100, 181, 236);
  beginShape();
  vertex(a+t, b+t/4);
  vertex(a+31*t/36, b+t/6);
  vertex(a+32*t/36, b+3*t/8);
  vertex(a+2*t/3, b+t/2);
  vertex(a+32*t/36, b+5*t/8);
  vertex(a+31*t/36, b+5*t/6);
  vertex(a+t, b+3*t/4);
  endShape(CLOSE);
}
void formeh12(int a, int b) {
  fill(245, 227, 6);
  triangle(a, b, a+t, b, a+t/2, b+t/2);
  fill(100, 181, 236);
  beginShape();
  vertex(a+t/4, b);
  vertex(a+t/6, b+5*t/36);
  vertex(a+3*t/8, b+4*t/36);
  vertex(a+t/2, b+t/3);
  vertex(a+5*t/8, b+4*t/36);
  vertex(a+5*t/6, b+5*t/36);
  vertex(a+3*t/4, b);
  endShape(CLOSE);
}
void formeb12(int a, int b) {
  fill(245, 227, 6);
  triangle(a, b+t, a+t, b+t, a+t/2, b+t/2);
  fill(100, 181, 236);
  beginShape();
  vertex(a+t/4, b+t);
  vertex(a+t/6, b+31*t/36);
  vertex(a+3*t/8, b+32*t/36);
  vertex(a+t/2, b+2*t/3);
  vertex(a+5*t/8, b+32*t/36);
  vertex(a+5*t/6, b+31*t/36);
  vertex(a+3*t/4, b+t);
  endShape(CLOSE);
}

//----------------------------------- forme 13 -----------------------------------
void formeg13(int a, int b) {
  fill(47, 124, 41);
  triangle(a, b, a, b+t, a+t/2, b+t/2);
  fill(30, 35, 88);
  beginShape();
  vertex(a, b+t/4);
  vertex(a+t/9, b+t/4);
  vertex(a+t/4, b+5*t/12);
  vertex(a+t/4, b+7*t/12);
  vertex(a+t/9, b+3*t/4);
  vertex(a, b+3*t/4);
  endShape(CLOSE);
  fill(47, 124, 41);
  arc(a, b+t/2, t/4, t/4, -PI/2, PI/2);
}
void formed13(int a, int b) {
  fill(47, 124, 41);
  triangle(a+t, b, a+t, b+t, a+t/2, b+t/2);
  fill(30, 35, 88);
  beginShape();
  vertex(a+t, b+t/4);
  vertex(a+8*t/9, b+t/4);
  vertex(a+3*t/4, b+5*t/12);
  vertex(a+3*t/4, b+7*t/12);
  vertex(a+8*t/9, b+3*t/4);
  vertex(a+t, b+3*t/4);
  endShape(CLOSE);
  fill(47, 124, 41);
  arc(a+t, b+t/2, t/4, t/4, PI/2, 3*PI/2);
}
void formeh13(int a, int b) {
  fill(47, 124, 41);
  triangle(a, b, a+t, b, a+t/2, b+t/2);
  fill(30, 35, 88);
  beginShape();
  vertex(a+t/4, b);
  vertex(a+t/4, b+t/9);
  vertex(a+5*t/12, b+t/4);
  vertex(a+7*t/12, b+t/4);
  vertex(a+3*t/4, b+t/9);
  vertex(a+3*t/4, b);
  endShape(CLOSE);
  fill(47, 124, 41);
  arc(a+t/2, b, t/4, t/4, 0, PI);
}
void formeb13(int a, int b) {
  fill(47, 124, 41);
  triangle(a, b+t, a+t, b+t, a+t/2, b+t/2);
  fill(30, 35, 88);
  beginShape();
  vertex(a+t/4, b+t);
  vertex(a+t/4, b+8*t/9);
  vertex(a+5*t/12, b+3*t/4);
  vertex(a+7*t/12, b+3*t/4);
  vertex(a+3*t/4, b+8*t/9);
  vertex(a+3*t/4, b+t);
  endShape(CLOSE);
  fill(47, 124, 41);
  arc(a+t/2, b+t, t/4, t/4, PI, 2*PI);
}


//------------------------------------ forme 14 ------------------------------------------
void formeg14(int a, int b) {
  fill(38, 108, 121);
  triangle(a, b, a, b+t, a+t/2, b+t/2);
  push();
  noStroke();
  fill(149, 11, 80);
  arc(a, b+t/2, t/2, t/2, -PI/2, PI/2);
  fill(38, 108, 121);
  beginShape();
  vertex(a, b+3*t/8);
  vertex(a+t/12, b+5*t/16);
  vertex(a+2*t/12, b+3*t/8);
  vertex(a+t/30, b+t/2);
  vertex(a+2*t/12, b+5*t/8);
  vertex(a+t/12, b+11*t/16);
  vertex(a, b+5*t/8);
  endShape(CLOSE);
  pop();
}
void formed14(int a, int b) {
  fill(38, 108, 121);
  triangle(a+t, b+t, a+t, b, a+t/2, b+t/2);
  push();
  noStroke();
  fill(149, 11, 80);
  arc(a+t, b+t/2, t/2, t/2, PI/2, 3*PI/2);
  fill(38, 108, 121);
  beginShape();
  vertex(a+t, b+3*t/8);
  vertex(a+11*t/12, b+5*t/16);
  vertex(a+10*t/12, b+3*t/8);
  vertex(a+29*t/30, b+t/2);
  vertex(a+10*t/12, b+5*t/8);
  vertex(a+11*t/12, b+11*t/16);
  vertex(a+t, b+5*t/8);
  endShape(CLOSE);
  pop();
}
void formeh14(int a, int b) {
  fill(38, 108, 121);
  triangle(a, b, a+t, b, a+t/2, b+t/2);
  push();
  noStroke();
  fill(149, 11, 80);
  arc(a+t/2, b, t/2, t/2, 0, PI);
  fill(38, 108, 121);
  beginShape();
  vertex(a+3*t/8, b);
  vertex(a+5*t/16, b+t/12);
  vertex(a+3*t/8, b+2*t/12);
  vertex(a+t/2, b+t/30);
  vertex(a+5*t/8, b+2*t/12);
  vertex(a+11*t/16, b+t/12);
  vertex(a+5*t/8, b);
  endShape(CLOSE);
  pop();
}
void formeb14(int a, int b) {
  fill(38, 108, 121);
  triangle(a, b+t, a+t, b+t, a+t/2, b+t/2);
  push();
  noStroke();
  fill(149, 11, 80);
  arc(a+t/2, b+t, t/2, t/2, PI, 2*PI);
  fill(38, 108, 121);
  beginShape();
  vertex(a+3*t/8, b+t);
  vertex(a+5*t/16, b+11*t/12);
  vertex(a+3*t/8, b+10*t/12);
  vertex(a+t/2, b+29*t/30);
  vertex(a+5*t/8, b+10*t/12);
  vertex(a+11*t/16, b+11*t/12);
  vertex(a+5*t/8, b+t);
  endShape(CLOSE);
  pop();
}

// ------------------------- forme 15 --------------------------------------
void formeg15(int a, int b) {
  fill(100, 26, 12);
  triangle(a, b, a, b+t, a+t/2, b+t/2);
  fill(100, 200, 0);
  beginShape();
  vertex(a, b+t/16);
  vertex(a+t/8, b+t/6);
  vertex(a+t/24, b+t/4);
  vertex(a+t/4, b+11*t/24);
  vertex(a+t/3, b+3*t/8);
  vertex(a+29*t/64, b+t/2);
  vertex(a+t/3, b+5*t/8);
  vertex(a+t/4, b+13*t/24);
  vertex(a+t/24, b+3*t/4);
  vertex(a+t/8, b+5*t/6);
  vertex(a, b+15*t/16);
  endShape(CLOSE);
}
void formed15(int a, int b) {
  fill(100, 26, 12);
  triangle(a+t, b, a+t, b+t, a+t/2, b+t/2);
  fill(100, 200, 0);
  beginShape();
  vertex(a+t, b+t/16);
  vertex(a+7*t/8, b+t/6);
  vertex(a+23*t/24, b+t/4);
  vertex(a+3*t/4, b+11*t/24);
  vertex(a+2*t/3, b+3*t/8);
  vertex(a+35*t/64, b+t/2);
  vertex(a+2*t/3, b+5*t/8);
  vertex(a+3*t/4, b+13*t/24);
  vertex(a+23*t/24, b+3*t/4);
  vertex(a+7*t/8, b+5*t/6);
  vertex(a+t, b+15*t/16);
  endShape(CLOSE);
}
void formeh15(int a, int b) {
  fill(100, 26, 12);
  triangle(a, b, a+t, b, a+t/2, b+t/2);
  fill(100, 200, 0);
  beginShape();
  vertex(a+t/16, b);
  vertex(a+t/6, b+t/8);
  vertex(a+t/4, b+t/24);
  vertex(a+11*t/24, b+t/4);
  vertex(a+3*t/8, b+t/3);
  vertex(a+t/2, b+29*t/64);
  vertex(a+5*t/8, b+t/3);
  vertex(a+13*t/24, b+t/4);
  vertex(a+3*t/4, b+t/24);
  vertex(a+5*t/6, b+t/8);
  vertex(a+15*t/16, b);
  endShape(CLOSE);
}
void formeb15(int a, int b) {
  fill(100, 26, 12);
  triangle(a, b+t, a+t, b+t, a+t/2, b+t/2);
  fill(100, 200, 0);
  beginShape();
  vertex(a+t/16, b+t);
  vertex(a+t/6, b+7*t/8);
  vertex(a+t/4, b+23*t/24);
  vertex(a+11*t/24, b+3*t/4);
  vertex(a+3*t/8, b+2*t/3);
  vertex(a+t/2, b+35*t/64);
  vertex(a+5*t/8, b+2*t/3);
  vertex(a+13*t/24, b+3*t/4);
  vertex(a+3*t/4, b+23*t/24);
  vertex(a+5*t/6, b+7*t/8);
  vertex(a+15*t/16, b+t);
  endShape(CLOSE);
}


// ------------------------------ forme 16 ----------------------------

void formeg16(int a, int b) {
  fill(255, 174, 1);
  triangle(a, b, a, b+t, a+t/2, b+t/2);
  fill(128, 0, 255);
  beginShape();
  vertex(a, b+t/4);
  vertex(a+5*t/36, b+t/6);
  vertex(a+4*t/36, b+3*t/8);
  vertex(a+t/3, b+t/2);
  vertex(a+4*t/36, b+5*t/8);
  vertex(a+5*t/36, b+5*t/6);
  vertex(a, b+3*t/4);
  endShape(CLOSE);
}
void formed16(int a, int b) {
  fill(255, 174, 1);
  triangle(a+t, b+t, a+t, b, a+t/2, b+t/2);
  fill(128, 0, 255);
  beginShape();
  vertex(a+t, b+t/4);
  vertex(a+31*t/36, b+t/6);
  vertex(a+32*t/36, b+3*t/8);
  vertex(a+2*t/3, b+t/2);
  vertex(a+32*t/36, b+5*t/8);
  vertex(a+31*t/36, b+5*t/6);
  vertex(a+t, b+3*t/4);
  endShape(CLOSE);
}
void formeh16(int a, int b) {
  fill(255, 174, 1);
  triangle(a, b, a+t, b, a+t/2, b+t/2);
  fill(128, 0, 255);
  beginShape();
  vertex(a+t/4, b);
  vertex(a+t/6, b+5*t/36);
  vertex(a+3*t/8, b+4*t/36);
  vertex(a+t/2, b+t/3);
  vertex(a+5*t/8, b+4*t/36);
  vertex(a+5*t/6, b+5*t/36);
  vertex(a+3*t/4, b);
  endShape(CLOSE);
}
void formeb16(int a, int b) {
  fill(255, 174, 1);
  triangle(a, b+t, a+t, b+t, a+t/2, b+t/2);
  fill(128, 0, 255);
  beginShape();
  vertex(a+t/4, b+t);
  vertex(a+t/6, b+31*t/36);
  vertex(a+3*t/8, b+32*t/36);
  vertex(a+t/2, b+2*t/3);
  vertex(a+5*t/8, b+32*t/36);
  vertex(a+5*t/6, b+31*t/36);
  vertex(a+3*t/4, b+t);
  endShape(CLOSE);
}

// -------------------------- forme  17 ---------------------------------------
void formeg17(int a, int b) {
  fill(100, 181, 236);
  triangle(a, b, a, b+t, a+t/2, b+t/2);
  push();
  noStroke();
  fill(149, 11, 80);
  beginShape();
  vertex(a, b+5*t/28);
  vertex(a+t/14, b+t/4);
  vertex(a+t/28, b+3*t/7);
  vertex(a+3*t/14, b+5*t/14);
  vertex(a+9*t/28, b+t/2);
  vertex(a+3*t/14, b+17*t/28);
  vertex(a+t/28, b+15*t/28);
  vertex(a+t/14, b+3*t/4);
  vertex(a, b+23*t/28);
  endShape(CLOSE);
  pop();
}
void formed17(int a, int b) {
  fill(100, 181, 236);
  triangle(a+t, b, a+t, b+t, a+t/2, b+t/2);
  push();
  noStroke();
  fill(149, 11, 80);
  beginShape();
  vertex(a+t, b+5*t/28);
  vertex(a+13*t/14, b+t/4);
  vertex(a+27*t/28, b+3*t/7);
  vertex(a+11*t/14, b+5*t/14);
  vertex(a+19*t/28, b+t/2);
  vertex(a+11*t/14, b+17*t/28);
  vertex(a+27*t/28, b+15*t/28);
  vertex(a+13*t/14, b+3*t/4);
  vertex(a+t, b+23*t/28);
  endShape(CLOSE);
  pop();
}
void formeh17(int a, int b) {
  fill(100, 181, 236);
  triangle(a, b, a+t, b, a+t/2, b+t/2);
  push();
  noStroke();
  fill(149, 11, 80);
  beginShape();
  vertex(a+5*t/28, b);
  vertex(a+t/4, b+t/14);
  vertex(a+3*t/7, b+t/28);
  vertex(a+5*t/14, b+3*t/14);
  vertex(a+t/2, b+9*t/28);
  vertex(a+17*t/28, b+3*t/14);
  vertex(a+15*t/28, b+t/28);
  vertex(a+3*t/4, b+t/14);
  vertex(a+23*t/28, b);
  endShape(CLOSE);
  pop();
}
void formeb17(int a, int b) {
  fill(100, 181, 236);
  triangle(a, b+t, a+t, b+t, a+t/2, b+t/2);
  push();
  noStroke();
  fill(149, 11, 80);
  beginShape();
  vertex(a+5*t/28, b+t);
  vertex(a+t/4, b+13*t/14);
  vertex(a+3*t/7, b+27*t/28);
  vertex(a+5*t/14, b+11*t/14);
  vertex(a+t/2, b+19*t/28);
  vertex(a+17*t/28, b+11*t/14);
  vertex(a+15*t/28, b+27*t/28);
  vertex(a+3*t/4, b+13*t/14);
  vertex(a+23*t/28, b+t);
  endShape(CLOSE);
  pop();
}

// ----------------------- forme 18 -----------------------------------
void formeg18(int a, int b) {
  fill(47, 124, 41);
  triangle(a, b, a, b+t, a+t/2, b+t/2);
  push();
  noStroke();
  fill(255, 174, 1);
  beginShape();
  vertex(a, b+5*t/28);
  vertex(a+t/14, b+t/4);
  vertex(a+t/28, b+3*t/7);
  vertex(a+3*t/14, b+5*t/14);
  vertex(a+9*t/28, b+t/2);
  vertex(a+3*t/14, b+17*t/28);
  vertex(a+t/28, b+15*t/28);
  vertex(a+t/14, b+3*t/4);
  vertex(a, b+23*t/28);
  endShape(CLOSE);
  pop();
}
void formed18(int a, int b) {
  fill(47, 124, 41);
  triangle(a+t, b, a+t, b+t, a+t/2, b+t/2);
  push();
  noStroke();
  fill(255, 174, 1);
  beginShape();
  vertex(a+t, b+5*t/28);
  vertex(a+13*t/14, b+t/4);
  vertex(a+27*t/28, b+3*t/7);
  vertex(a+11*t/14, b+5*t/14);
  vertex(a+19*t/28, b+t/2);
  vertex(a+11*t/14, b+17*t/28);
  vertex(a+27*t/28, b+15*t/28);
  vertex(a+13*t/14, b+3*t/4);
  vertex(a+t, b+23*t/28);
  endShape(CLOSE);
  pop();
}
void formeh18(int a, int b) {
  fill(47, 124, 41);
  triangle(a, b, a+t, b, a+t/2, b+t/2);
  push();
  noStroke();
  fill(255, 174, 1);
  beginShape();
  vertex(a+5*t/28, b);
  vertex(a+t/4, b+t/14);
  vertex(a+3*t/7, b+t/28);
  vertex(a+5*t/14, b+3*t/14);
  vertex(a+t/2, b+9*t/28);
  vertex(a+17*t/28, b+3*t/14);
  vertex(a+15*t/28, b+t/28);
  vertex(a+3*t/4, b+t/14);
  vertex(a+23*t/28, b);
  endShape(CLOSE);
  pop();
}
void formeb18(int a, int b) {
  fill(47, 124, 41);
  triangle(a, b+t, a+t, b+t, a+t/2, b+t/2);
  push();
  noStroke();
  fill(255, 174, 1);
  beginShape();
  vertex(a+5*t/28, b+t);
  vertex(a+t/4, b+13*t/14);
  vertex(a+3*t/7, b+27*t/28);
  vertex(a+5*t/14, b+11*t/14);
  vertex(a+t/2, b+19*t/28);
  vertex(a+17*t/28, b+11*t/14);
  vertex(a+15*t/28, b+27*t/28);
  vertex(a+3*t/4, b+13*t/14);
  vertex(a+23*t/28, b+t);
  endShape(CLOSE);
  pop();
}

// ------------------------------ forme   19 -------------------------------
void formeg19(int a, int b) {
  fill(100, 181, 236);
  triangle(a, b, a, b+t, a+t/2, b+t/2);
  fill(149, 11, 80);
  beginShape();
  vertex(a, b+t/16);
  vertex(a+t/8, b+t/6);
  vertex(a+t/24, b+t/4);
  vertex(a+t/4, b+11*t/24);
  vertex(a+t/3, b+3*t/8);
  vertex(a+29*t/64, b+t/2);
  vertex(a+t/3, b+5*t/8);
  vertex(a+t/4, b+13*t/24);
  vertex(a+t/24, b+3*t/4);
  vertex(a+t/8, b+5*t/6);
  vertex(a, b+15*t/16);
  endShape(CLOSE);
}
void formed19(int a, int b) {
  fill(100, 181, 236);
  triangle(a+t, b, a+t, b+t, a+t/2, b+t/2);
  fill(149, 11, 80);
  beginShape();
  vertex(a+t, b+t/16);
  vertex(a+7*t/8, b+t/6);
  vertex(a+23*t/24, b+t/4);
  vertex(a+3*t/4, b+11*t/24);
  vertex(a+2*t/3, b+3*t/8);
  vertex(a+35*t/64, b+t/2);
  vertex(a+2*t/3, b+5*t/8);
  vertex(a+3*t/4, b+13*t/24);
  vertex(a+23*t/24, b+3*t/4);
  vertex(a+7*t/8, b+5*t/6);
  vertex(a+t, b+15*t/16);
  endShape(CLOSE);
}
void formeh19(int a, int b) {
  fill(100, 181, 236);
  triangle(a, b, a+t, b, a+t/2, b+t/2);
  fill(149, 11, 80);
  beginShape();
  vertex(a+t/16, b);
  vertex(a+t/6, b+t/8);
  vertex(a+t/4, b+t/24);
  vertex(a+11*t/24, b+t/4);
  vertex(a+3*t/8, b+t/3);
  vertex(a+t/2, b+29*t/64);
  vertex(a+5*t/8, b+t/3);
  vertex(a+13*t/24, b+t/4);
  vertex(a+3*t/4, b+t/24);
  vertex(a+5*t/6, b+t/8);
  vertex(a+15*t/16, b);
  endShape(CLOSE);
}
void formeb19(int a, int b) {
  fill(100, 181, 236);
  triangle(a, b+t, a+t, b+t, a+t/2, b+t/2);
  fill(149, 11, 80);
  beginShape();
  vertex(a+t/16, b+t);
  vertex(a+t/6, b+7*t/8);
  vertex(a+t/4, b+23*t/24);
  vertex(a+11*t/24, b+3*t/4);
  vertex(a+3*t/8, b+2*t/3);
  vertex(a+t/2, b+35*t/64);
  vertex(a+5*t/8, b+2*t/3);
  vertex(a+13*t/24, b+3*t/4);
  vertex(a+3*t/4, b+23*t/24);
  vertex(a+5*t/6, b+7*t/8);
  vertex(a+15*t/16, b+t);
  endShape(CLOSE);
}

// --------------------------------------- forme 20 ------------------------------------
void formeg20(int a, int b) {
  fill(149, 11, 80);
  triangle(a, b, a, b+t, a+t/2, b+t/2);
  fill(255, 255, 0);
  beginShape();
  vertex(a, b+t/16);
  vertex(a+t/8, b+t/6);
  vertex(a+t/24, b+t/4);
  vertex(a+t/4, b+11*t/24);
  vertex(a+t/3, b+3*t/8);
  vertex(a+29*t/64, b+t/2);
  vertex(a+t/3, b+5*t/8);
  vertex(a+t/4, b+13*t/24);
  vertex(a+t/24, b+3*t/4);
  vertex(a+t/8, b+5*t/6);
  vertex(a, b+15*t/16);
  endShape(CLOSE);
}
void formed20(int a, int b) {
  fill(149, 11, 80);
  triangle(a+t, b, a+t, b+t, a+t/2, b+t/2);
  fill(255, 255, 0);
  beginShape();
  vertex(a+t, b+t/16);
  vertex(a+7*t/8, b+t/6);
  vertex(a+23*t/24, b+t/4);
  vertex(a+3*t/4, b+11*t/24);
  vertex(a+2*t/3, b+3*t/8);
  vertex(a+35*t/64, b+t/2);
  vertex(a+2*t/3, b+5*t/8);
  vertex(a+3*t/4, b+13*t/24);
  vertex(a+23*t/24, b+3*t/4);
  vertex(a+7*t/8, b+5*t/6);
  vertex(a+t, b+15*t/16);
  endShape(CLOSE);
}
void formeh20(int a, int b) {
  fill(149, 11, 80);
  triangle(a, b, a+t, b, a+t/2, b+t/2);
  fill(255, 255, 0);
  beginShape();
  vertex(a+t/16, b);
  vertex(a+t/6, b+t/8);
  vertex(a+t/4, b+t/24);
  vertex(a+11*t/24, b+t/4);
  vertex(a+3*t/8, b+t/3);
  vertex(a+t/2, b+29*t/64);
  vertex(a+5*t/8, b+t/3);
  vertex(a+13*t/24, b+t/4);
  vertex(a+3*t/4, b+t/24);
  vertex(a+5*t/6, b+t/8);
  vertex(a+15*t/16, b);
  endShape(CLOSE);
}
void formeb20(int a, int b) {
  fill(149, 11, 80);
  triangle(a, b+t, a+t, b+t, a+t/2, b+t/2);
  fill(255, 255, 0);
  beginShape();
  vertex(a+t/16, b+t);
  vertex(a+t/6, b+7*t/8);
  vertex(a+t/4, b+23*t/24);
  vertex(a+11*t/24, b+3*t/4);
  vertex(a+3*t/8, b+2*t/3);
  vertex(a+t/2, b+35*t/64);
  vertex(a+5*t/8, b+2*t/3);
  vertex(a+13*t/24, b+3*t/4);
  vertex(a+3*t/4, b+23*t/24);
  vertex(a+5*t/6, b+7*t/8);
  vertex(a+15*t/16, b+t);
  endShape(CLOSE);
}

//------------------------------- forme 21 --------------------------------------------------

void formeg21(int a, int b) {
  fill(47, 124, 41);
  triangle(a, b, a, b+t, a+t/2, b+t/2);
  push();
  noStroke();
  fill(149, 11, 80);
  beginShape();
  vertex(a, b+t/5);
  vertex(a+t/16, b+t/5);
  vertex(a+t/16, b+2*t/5);
  vertex(a+t/4, b+2*t/5);
  vertex(a+t/4, b+3*t/5);
  vertex(a+t/16, b+3*t/5);
  vertex(a+t/16, b+7*t/10);
  vertex(a, b+4*t/5);
  endShape(CLOSE);
  arc(a, b+t/5, t/5, t/5, -PI/2, PI/2);
  arc(a, b+4*t/5, t/5, t/5, -PI/2, PI/2);
  ellipse(a+t/4, b+t/2, t/4, t/4);
  pop();
}
void formed21(int a, int b) {
  fill(47, 124, 41);
  triangle(a+t, b+t, a+t, b, a+t/2, b+t/2);
  push();
  noStroke();
  fill(149, 11, 80);
  beginShape();
  vertex(a+t, b+t/5);
  vertex(a+15*t/16, b+t/5);
  vertex(a+15*t/16, b+2*t/5);
  vertex(a+3*t/4, b+2*t/5);
  vertex(a+3*t/4, b+3*t/5);
  vertex(a+15*t/16, b+3*t/5);
  vertex(a+15*t/16, b+7*t/10);
  vertex(a+t, b+4*t/5);
  endShape(CLOSE);
  arc(a+t, b+t/5, t/5, t/5, PI/2, 3*PI/2);
  arc(a+t, b+4*t/5, t/5, t/5, PI/2, 3*PI/2);
  ellipse(a+3*t/4, b+t/2, t/4, t/4);
  pop();
}
void formeh21(int a, int b) {
  fill(47, 124, 41);
  triangle(a, b, a+t, b, a+t/2, b+t/2);
  push();
  noStroke();
  fill(149, 11, 80);
  beginShape();
  vertex(a+t/5, b);
  vertex(a+t/5, b+t/16);
  vertex(a+2*t/5, b+t/16);
  vertex(a+2*t/5, b+t/4);
  vertex(a+3*t/5, b+t/4);
  vertex(a+3*t/5, b+t/16);
  vertex(a+7*t/10, b+t/16);
  vertex(a+4*t/5, b);
  endShape(CLOSE);
  arc(a+t/5, b, t/5, t/5, 0, PI);
  arc(a+4*t/5, b, t/5, t/5, 0, PI);
  ellipse(a+t/2, b+t/4, t/4, t/4);
  pop();
}
void formeb21(int a, int b) {
  fill(47, 124, 41);
  triangle(a+t, b+t, a, b+t, a+t/2, b+t/2);
  push();
  noStroke();
  fill(149, 11, 80);
  beginShape();
  vertex(a+t/5, b+t);
  vertex(a+t/5, b+15*t/16);
  vertex(a+2*t/5, b+15*t/16);
  vertex(a+2*t/5, b+3*t/4);
  vertex(a+3*t/5, b+3*t/4);
  vertex(a+3*t/5, b+15*t/16);
  vertex(a+7*t/10, b+15*t/16);
  vertex(a+4*t/5, b+t);
  endShape(CLOSE);
  arc(a+t/5, b+t, t/5, t/5, PI, 2*PI);
  arc(a+4*t/5, b+t, t/5, t/5, PI, 2*PI);
  ellipse(a+t/2, b+3*t/4, t/4, t/4);
  pop();
}

// -------------------------------------------- forme 22 -------------------------------------------


void formeg22(int a, int b) {
  fill(245, 227, 6);
  triangle(a, b, a, b+t, a+t/2, b+t/2);
  push();
  noStroke();
  fill(47, 124, 41);
  arc(a, b+t/2, t/2, t/2, -PI/2, PI/2);
  fill(245, 227, 6);
  beginShape();
  vertex(a, b+3*t/8);
  vertex(a+t/12, b+5*t/16);
  vertex(a+2*t/12, b+3*t/8);
  vertex(a+t/30, b+t/2);
  vertex(a+2*t/12, b+5*t/8);
  vertex(a+t/12, b+11*t/16);
  vertex(a, b+5*t/8);
  endShape(CLOSE);
  pop();
}
void formed22(int a, int b) {
  fill(245, 227, 6);
  triangle(a+t, b+t, a+t, b, a+t/2, b+t/2);
  push();
  noStroke();
  fill(47, 124, 41);
  arc(a+t, b+t/2, t/2, t/2, PI/2, 3*PI/2);
  fill(245, 227, 6);
  beginShape();
  vertex(a+t, b+3*t/8);
  vertex(a+11*t/12, b+5*t/16);
  vertex(a+10*t/12, b+3*t/8);
  vertex(a+29*t/30, b+t/2);
  vertex(a+10*t/12, b+5*t/8);
  vertex(a+11*t/12, b+11*t/16);
  vertex(a+t, b+5*t/8);
  endShape(CLOSE);
  pop();
}
void formeh22(int a, int b) {
  fill(245, 227, 6);
  triangle(a, b, a+t, b, a+t/2, b+t/2);
  push();
  noStroke();
  fill(47, 124, 41);
  arc(a+t/2, b, t/2, t/2, 0, PI);
  fill(245, 227, 6);
  beginShape();
  vertex(a+3*t/8, b);
  vertex(a+5*t/16, b+t/12);
  vertex(a+3*t/8, b+2*t/12);
  vertex(a+t/2, b+t/30);
  vertex(a+5*t/8, b+2*t/12);
  vertex(a+11*t/16, b+t/12);
  vertex(a+5*t/8, b);
  endShape(CLOSE);
  pop();
}
void formeb22(int a, int b) {
  fill(245, 227, 6);
  triangle(a, b+t, a+t, b+t, a+t/2, b+t/2);
  push();
  noStroke();
  fill(47, 124, 41);
  arc(a+t/2, b+t, t/2, t/2, PI, 2*PI);
  fill(245, 227, 6);
  beginShape();
  vertex(a+3*t/8, b+t);
  vertex(a+5*t/16, b+11*t/12);
  vertex(a+3*t/8, b+10*t/12);
  vertex(a+t/2, b+29*t/30);
  vertex(a+5*t/8, b+10*t/12);
  vertex(a+11*t/16, b+11*t/12);
  vertex(a+5*t/8, b+t);
  endShape(CLOSE);
  pop();
}


void selectForm(String nameForm, int a, int b) {

  //String nomFonction = "formeh"+rand;
  switch(nameForm)
  {
    /* form haut */
  case "formeh1":
    formeh1(a, b);
    break;
  case "formeh2":
    formeh2(a, b);
    break;
  case "formeh3":
    formeh3(a, b);
    break;
  case "formeh4":
    formeh4(a, b);
    break;
  case "formeh5":
    formeh5(a, b);
    break;
  case "formeh6":
    formeh6(a, b);
    break;
  case "formeh7":
    formeh7(a, b);
    break;
  case "formeh8":
    formeh8(a, b);
    break;
  case "formeh9":
    formeh9(a, b);
    break;
  case "formeh10":
    formeh10(a, b);
    break;
  case "formeh11":
    formeh11(a, b);
    break;
  case "formeh12":
    formeh12(a, b);
    break;
  case "formeh13":
    formeh13(a, b);
    break;
  case "formeh14":
    formeh14(a, b);
    break;
  case "formeh15":
    formeh15(a, b);
    break;
  case "formeh16":
    formeh16(a, b);
    break;
  case "formeh17":
    formeh17(a, b);
    break;
  case "formeh18":
    formeh18(a, b);
    break;
  case "formeh19":
    formeh19(a, b);
    break;
  case "formeh20":
    formeh20(a, b);
    break;
  case "formeh21":
    formeh21(a, b);
    break;
  case "formeh22":
    formeh22(a, b);
    break;

    /* form bas */
  case "formeb1":
    formeb1(a, b);
    break;
  case "formeb2":
    formeb2(a, b);
    break;
  case "formeb3":
    formeb3(a, b);
    break;
  case "formeb4":
    formeb4(a, b);
    break;
  case "formeb5":
    formeb5(a, b);
    break;
  case "formeb6":
    formeb6(a, b);
    break;
  case "formeb7":
    formeb7(a, b);
    break;
  case "formeb8":
    formeb8(a, b);
    break;
  case "formeb9":
    formeb9(a, b);
    break;
  case "formeb10":
    formeb10(a, b);
    break;
  case "formeb11":
    formeb11(a, b);
    break;
  case "formeb12":
    formeb12(a, b);
    break;
  case "formeb13":
    formeb13(a, b);
    break;
  case "formeb14":
    formeb14(a, b);
    break;
  case "formeb15":
    formeb15(a, b);
    break;
  case "formeb16":
    formeb16(a, b);
    break;
  case "formeb17":
    formeb17(a, b);
    break;
  case "formeb18":
    formeb18(a, b);
    break;
  case "formeb19":
    formeb19(a, b);
    break;
  case "formeb20":
    formeb20(a, b);
    break;
  case "formeb21":
    formeb21(a, b);
    break;
  case "formeb22":
    formeb22(a, b);
    break;


    /* form Gauche */
  case "formeg1":
    formeg1(a, b);
    break;
  case "formeg2":
    formeg2(a, b);
    break;
  case "formeg3":
    formeg3(a, b);
    break;
  case "formeg4":
    formeg4(a, b);
    break;
  case "formeg5":
    formeg5(a, b);
    break;
  case "formeg6":
    formeg6(a, b);
    break;
  case "formeg7":
    formeg7(a, b);
    break;
  case "formeg8":
    formeg8(a, b);
    break;
  case "formeg9":
    formeg9(a, b);
    break;
  case "formeg10":
    formeg10(a, b);
    break;
  case "formeg11":
    formeg11(a, b);
    break;
  case "formeg12":
    formeg12(a, b);
    break;
  case "formeg13":
    formeg13(a, b);
    break;
  case "formeg14":
    formeg14(a, b);
    break;
  case "formeg15":
    formeg15(a, b);
    break;
  case "formeg16":
    formeg16(a, b);
    break;
  case "formeg17":
    formeg17(a, b);
    break;
  case "formeg18":
    formeg18(a, b);
    break;
  case "formeg19":
    formeg19(a, b);
    break;
  case "formeg20":
    formeg20(a, b);
    break;
  case "formeg21":
    formeg21(a, b);
    break;
  case "formeg22":
    formeg22(a, b);
    break;


    /* form Droite */
  case "formed1":
    formed1(a, b);
    break;
  case "formed2":
    formed2(a, b);
    break;
  case "formed3":
    formed3(a, b);
    break;
  case "formed4":
    formed4(a, b);
    break;
  case "formed5":
    formed5(a, b);
    break;
  case "formed6":
    formed6(a, b);
    break;
  case "formed7":
    formed7(a, b);
    break;
  case "formed8":
    formed8(a, b);
    break;
  case "formed9":
    formed9(a, b);
    break;
  case "formed10":
    formed10(a, b);
    break;
  case "formed11":
    formed11(a, b);
    break;
  case "formed12":
    formed12(a, b);
    break;
  case "formed13":
    formed13(a, b);
    break;
  case "formed14":
    formed14(a, b);
    break;
  case "formed15":
    formed15(a, b);
    break;
  case "formed16":
    formed16(a, b);
    break;
  case "formed17":
    formed17(a, b);
    break;
  case "formed18":
    formed18(a, b);
    break;
  case "formed19":
    formed19(a, b);
    break;
  case "formed20":
    formed20(a, b);
    break;
  case "formed21":
    formed21(a, b);
    break;
  case "formed22":
    formed22(a, b);
    break;

    /*case 'valeur3':'valeur4':
     action3;
     break;*/
  default:
    //action4;
    break;
  }
}
