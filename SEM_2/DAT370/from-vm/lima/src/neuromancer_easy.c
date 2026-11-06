/*Compile with gcc -O2 -D BINARY=PATH no_aslr.c -o no_aslr
 Can be used with setuid because it uses execv
 */
#include <stdio.h>
#include <unistd.h>
#include <sys/personality.h>

#define S(x) #x
#define SX(x) S(x)

int main(int argc, char * argv[]) {
  int psnl = personality(0xffffffff);
  if (psnl == -1) {
    fputs("Couldn't retrieve personality\n",stderr);
  } else if ((psnl & ADDR_NO_RANDOMIZE) != ADDR_NO_RANDOMIZE) {
    if (personality(psnl|ADDR_NO_RANDOMIZE) == -1) {
      fputs("Failed to disable ASLR\n",stderr);
    }
  }
  execv(SX(BINARY), argv);
  fputs("Failed to run\n",stderr);
  return 1;
}
