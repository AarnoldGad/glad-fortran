#if defined(__APPLE__)
#define GLhandleARB c_ptr
#else
#define GLhandleARB integer(kind=c_int)
#endif
