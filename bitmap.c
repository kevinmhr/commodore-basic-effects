/*
** bitmap using cc65.
**
** k1mhr;
**
*/



#include <stdlib.h>
#include <string.h>
#include <conio.h>
#include <dbg.h>
 


/*****************************************************************************/
/*                                   Data                                    */
/*****************************************************************************/



static const char Text [] = "Hello world!";

unsigned int val;

/*****************************************************************************/
/*                                   Code                                    */
/*****************************************************************************/
#  define outb(addr,val)        (*(addr) = (val))
#  define inb(val,addr)        ((val)=*(addr))
int defx;
int k=1;
int xbit;
int i=0;
int j=0;
unsigned int x=30;
unsigned int y=50;
int yadd;
int xadd;
int y2;
int y1=4;
int x1=0;
int roll=20;
int position;
int xpos[]={1,2,4,8,16,32,64,128,256};
int main (void)
{
x=0;
y=0;
//textcolor (COLOR_BLACK);
//bordercolor (COLOR_WHITE);
bgcolor (COLOR_WHITE);
outb((char*)0xD011,59);
//outb((char*)0xD016,8);
outb((char*)0xD018,24);
memset((char*)(8192),0,8000);
x=100;
y=10;
y1=100;
xbit=1;
x1=1;
y2=1;
while (k==1){
y2++;
if (y2>16){y2=0;}
 for (i=0;i<1000;i++){
outb((char*)(0x0400)+(i),y2);
 
 }
   
 
 
for (y=100;y<=150;y++){
 


 
for (x=100;x<150;x++){
  
 


 j=((y/8)*320)+(y&7);
 i=((x/8)*8);
  

 
 

 
position=j+i;
inb(x1,(char*)(8192+(position)));

xbit=(xpos[7-(x&7)]|x1);

outb((char*)(8192+(position)),xbit);
 
  
}}

}
//(void) cgetc ();


//return EXIT_SUCCESS;

}

 

