#ifndef Drawing
#define Drawing

#include <epd_driver.h>

struct Drawing {
protected:
public:
    Rect_t area = {.x = 0, .y = 0, .width = EPD_WIDTH, .height = EPD_HEIGHT};
    Rect_t rect;
    struct Circle {
        public:
            void setX(int valX) { area.x = valX; };
            // int getX() { return pos.getX(); };
            // int getY() { return pos.getY(); };
            Rect_t getRect() {};
    };
    
};

#endif