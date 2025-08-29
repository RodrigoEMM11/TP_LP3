#include <stdio.h>

#if defined(_WIN32) || defined(_WIN64)
#include <stdlib.h>
#define ENVIRON _environ    // Windows usa _environ
#else
extern char** environ;      // Linux/Unix
#define ENVIRON environ
#endif

int main()
{
    char** var;
    for (var = ENVIRON; *var != NULL; ++var)
        printf("%s\n", *var);

    return 0;
}
