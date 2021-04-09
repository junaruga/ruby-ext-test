#include "testj_ext.h"

VALUE mTestj;

static VALUE
Hello(VALUE self)
{
  printf("Hello\n");

  return Qnil;
}

void
Init_testj()
{
  mTestj = rb_define_module("Testj");

  rb_define_module_function(mTestj, "hello", Hello, 0);
}
