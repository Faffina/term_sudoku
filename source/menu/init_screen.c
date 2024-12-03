#include "menu.h"
#include <ncurses.h>

void init_screen() {
    initscr();
    raw();
    keypad(stdscr, TRUE);
    noecho();
}
