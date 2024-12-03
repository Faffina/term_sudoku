#include "menu.h"
#include <ncurses.h>

enum state menu() {
    printf("hello\n");
    getch();

    return MENU;
}
