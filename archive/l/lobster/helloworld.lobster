import std
import vec
import color

fatal(gl_window("Hello World", 640, 480))

while gl_frame() and gl_button("escape") != 1:
    gl_clear(color_black)
    check(gl_set_font_name("data/fonts/US101/US101.TTF") and gl_set_font_size(32), "can\'t load font!")
    gl_text("Hello World!")