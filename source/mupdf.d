module mupdf;

version(Posix)
    public import mupdf_posix;
else version(Win64)
    public import mupdf_win64;
else
    static assert(false, "Platform isn't supported");
