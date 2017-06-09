#include <stdio.h>
#include <time.h>

int main(int argc, char** argv){
  /* Write current date time to s variable */
  time_t t = time(NULL);
  struct tm *tm = localtime(&t);
  char s[64];
  strftime(s, sizeof(s), "%c", tm);

  /* Greet the world */
  printf("Hello world!!\nCurrent time is %s\n", s);
}
