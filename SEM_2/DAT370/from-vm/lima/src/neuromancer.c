// vi:ft=c
// A palindrome checker written in C for Ethical Hacking.
#include <stdio.h>
#include <string.h>

const int BUFFERLEN=128;

int isPalindrome(char * p) {
  char * index, * reverse;

  index = p;

  while ( * index != '\0') {
    ++index;
  }
  --index;

  for (reverse = p; index >= reverse;) {
    if ( * index == * reverse) {
      --index;
      reverse++;
    } else {
      break;
    }
  }

  if (reverse > index) {
    return 1;
  } else {
    return 0;
  }
}

int main(int argc, char * argv[]) {
  if (argc == 1) {
    printf("=== Ethical Hacking palindrome checker ===\n\nGive me a string and I will check if it is a palindrome\n");
    return 1;
  }

  char buf[BUFFERLEN];

  char * word = argv[1];
  if (!isPalindrome(word)) {
    printf("The string \"%s\" is not a palindrome\n", word);
  } else {
    strcpy(buf, word);
    printf("The string is a palindrome and was written to the memory address %p.\n", & buf);
  }

  return 0;
}
