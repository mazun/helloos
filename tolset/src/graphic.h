#ifndef GRAPHIC_H
#define GRAPHIC_H

#define COL8_000000	0
#define COL8_FF0000	1
#define COL8_00FF00	2
#define COL8_FFFF00	3
#define COL8_0000FF	4
#define COL8_FF00FF	5
#define COL8_00FFFF	6
#define COL8_FFFFFF	7
#define COL8_C6C6C6	8
#define COL8_840000	9
#define COL8_008400	10
#define COL8_848400	11
#define COL8_000084	12
#define COL8_840084	13
#define COL8_008484	14
#define COL8_848484	15

extern void init_palette(void);
extern void set_palette(int start, int end, unsigned char *rgb);
extern void boxfill8(unsigned char *vram, int xsize, unsigned char c, int x0, int y0, int x1, int y1);
extern void init_screen(char *vram, int x, int y);
extern void putfont8(char *vram, int xsize, int x, int y, char c, char *font);
extern void putfonts8_asc(char *vram, int xsize, int x, int y, char c, unsigned char *s);
extern void init_mouse_cursor8(char *mouse, char bc);
extern void putblock8_8(char *vram, int vxsize, int pxsize, int pysize, int px0, int py0, char *buf, int bxsize);

#endif
