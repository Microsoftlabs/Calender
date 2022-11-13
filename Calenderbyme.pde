
import java.text.DecimalFormat;



//This program can show date,day,month,year of any year
//as long as it is smaller than <double> datatype size <307 place of digits >
//Based purely on Gregonian Calendar(not Julian calendar)
// Hence no account for 11 days in September 1752
final String[] months={"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};
int[] monthLength={31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
final String[] days={"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"};
final String dayOn1Jan2019=days[2];//Tuesday

PFont font;
int date=day();
int month=month();
double year=year();
int st=3;
boolean ke=false, mke=false;

boolean smartCheck=true;//Saves times and resource
//Based on assumption that every 400 year days are repeated

void setup() {
  size(400, 580);
  background(25);
  textSize(45);
  textAlign(CENTER, CENTER);
  text("Loading...\nPlease be Patient!", 0, 0, width, height);
  calculate(month, year);
  surface.setResizable(true);
}

void draw() {
  background(255);
  font=createFont("segoe print", 40);

  nullCheck();
  Events();
  design();
  leapCheck(year);
  st();
  datesdesg();
}

void datesdesg() {
  fill(#E0D9D9);
  rect(0, 145, width, height-330);
  noStroke();
  int rw=(width>=400)?(width-75)/7:45;
  int rh=(height>=520)?(height-395)/6:30;
  int tsize=15+(min(rw, rh)-30)/10;
  textSize(tsize);

  for (int i=0; i<=6; i++) {
    fill(#0F83A7);
    textAlign(CENTER, CORNER);
    text(days[i].substring(0, 3), 5+i*(rw+10), 115, rw, 2*tsize);

    for (int j=0; j<=5; j++) {

      int cellno=(i+1)+7*j;
      int date=cellno+1-st;

      if (date<=monthLength[month-1] && date>0) {
        fill(12);
        if (mouseX>5+i*(rw+10) && mouseX<rw+5+i*(rw+10) && mouseY>155+j*(rh+10) && mouseY<rh+155+j*(rh+10)) {
          fill(12, 220);
          if (mousePressed) {
            this.date=date;
            delay(200);
          }
        }

        if (this.date==date) {
          fill(0, 0, 255);
        }

        rect(5+i*(rw+10), 155+j*(rh+10), rw, rh, 10);
        fill(255);
        textAlign(CENTER, CENTER);
        text(date, 5+rw/2+i*(rw+10), 150+rh/2+j*(rh+10));
      }
    }
  }
  textSize(15);
}

void st() {
  st=(st==0)?7:st;
}


void calculate(int month, double year) {
  long sum=0;
  if (smartCheck) {
    year=year%400;
  }
  int m1;
  if (year>=2019) {
    for (long h=2019; h<=year; h++) {
      leapCheck(h);
      if (h==year) {
        m1=month-1;
      } else
      {
        m1=12;
      }
      for (int i=1; i<=m1; i++) {
        sum=sum+monthLength[i-1];
      }
    }
    st=(int)((st+(sum%7))%7);
  } else
  {
    for (long h=2018; h>=year; h--) {
      leapCheck(h);
      nullCheck();
      if (h==year) {
        m1=month;
      } else
      {
        m1=1;
      }
      for (int i=12; i>=m1; i--) {

        sum=sum+monthLength[(i-1+12)%12];
      }
    }
    st=(int)(st-(sum%7)+7)%7;
  }
}



void nullCheck() {
  if (date>monthLength[(month-1+12)%12]) {
    date=date%monthLength[(month-1+12)%12];
    month++;
  } else if (date<1) {
    date=monthLength[(month-2+12)%12];
    month--;
  }
  if (month>12) {
    month=month%12;
    year++;
  } else if (month<1) {
    month=12;
    year--;
  }
}



void leapCheck(double year) {
  if ((year%4==0&&year%100!=0)||(year%400==0)) {
    monthLength[1]=29;
  } else {
    monthLength[1]=28;
  }
}



void design() {
  background(0);
  noStroke();
  fill(0);
  rect(0, 0, width, 30);
  fill(255);
  textFont(font);
  textAlign(CENTER);
  textSize(15);
  text("Calender by ©LAB Studios", width/2, 20);
  fill(60);
  rect(0, 30, width, 30);
  fill(100, 0, 0);
  rect(0, 60, width, 30);
  fill(140);
  rect(0, 90, width, 30);
  fill(180);
  rect(0, 120, width, 30);
  fill(255);

  textAlign(CORNER);
  text("Today:"+day()+" , "+months[(month()-1+12)%12]+" , "+year()+" "+((year()>=0)?"AD":"BC"), 10, 45);
  String y= new DecimalFormat("##").format(Math.abs(year));
  text("Seeing:"+date+" , "+months[(month-1+12)%12]+" , "+y+" "+((year>=0)?"AD":"BC"), 10, 75);
  fill(255);
  text("<Previous month", 5, 110);
  text("Next month>", width-105, 110);
  text("Today", width/2-20, 110);


  noStroke();
  fill(0);
  rect(0, height-180, width, 30);
  fill(30);
  rect(0, height-150, width, 30);
  fill(60);
  rect(0, height-120, width, 30);
  fill(90);
  rect(0, height-90, width, 30);
  fill(120);
  rect(0, height-60, width, 30);
  fill(160);
  rect(0, height-30, width, 30);
  fill(255);
  text("<Previous year", 5, height-160);
  text("<Previous decade", 5, height-130);
  text("<Previous century", 5, height-100);
  text("<Previous millennium", 5, height-70);
  text("<Previous megaannum", 5, height-40);
  text("<Previous gigaannum", 5, height-10);


  text("Next year>", width-90, height-160);
  text("Next decade>", width-110, height-130);
  text("Next century>", width-115, height-100);
  text("Next millennium>", width-140, height-70);
  text("Next megaannum>", width-150, height-40);
  text("Next gigaannum>", width-140, height-10);
}



void Events() {
  if (mke) {
    if (mouseX>=0 && mouseY>=90 && mouseX<=130 && mouseY<=120) {
      month--;
    } else if (mouseX>=width-105 && mouseY>=90 && mouseX<=width && mouseY<=120) {
      month++;
    } else if (mouseX>=width/2-20 && mouseY>=90 && mouseX<=width/2+25 && mouseY<=120) {
      month=month();
      date=day();
      year=year();
    } else if (mouseX>=0 && mouseX<=110 && mouseY>=height-180 && mouseY<=height-150) {
      year--;
    } else if (mouseX>=0 && mouseX<=135 && mouseY>=height-150 && mouseY<=height-120) {
      year-=10;
    } else if (mouseX>=0 && mouseX<=140 && mouseY>=height-120 && mouseY<=height-90) {
      year-=100;
    }  else if (mouseX>=width-90 && mouseX<=width && mouseY>=height-180 && mouseY<=height-150) {
      year++;
    } else if (mouseX>=width-110 && mouseX<=width && mouseY>=height-150 && mouseY<=height-120) {
      year+=10;
    } else if (mouseX>=width-115 && mouseX<=width && mouseY>=height-120 && mouseY<=height-90) {
      year+=100;
    } else if (mouseX>=0 && mouseX<=165 && mouseY>=height-90 && mouseY<=height-60) {
      year-=1000;
    } else if (mouseX>=width-140 && mouseX<=width && mouseY>=height-90 && mouseY<=height-60) {
      year+=1000;
    }
    else if (mouseX>=0 && mouseX<=175 && mouseY>=height-60 && mouseY<=height-30) {
      year-=1000000;
    } else if (mouseX>=width-150 && mouseX<=width && mouseY>=height-60 && mouseY<=height-30) {
      year+=1000000;
    } else if (mouseX>=0 && mouseX<=165 && mouseY>=height-30 && mouseY<=height) {
      year-=1000000000;
    } else if (mouseX>=width-140 && mouseX<=width && mouseY>=height-30 && mouseY<=height) {
      year+=1000000000;
    }

    st=3;
    calculate(month, year);
    mke=false;
  }
  if (ke) {
    if (keyCode==RIGHT) {
      month++;
    } else if (keyCode==LEFT) {
      month--;
    }
    st=3;
    ke=false;
    calculate(month, year);
  }

  nullCheck();
}


void keyReleased() {
  ke=true;
}
void mouseReleased() {
  mke=true;
}
