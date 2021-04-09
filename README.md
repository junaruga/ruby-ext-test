# ruby-ext-test

## Compile

```
$ rake clean

$ rake compile
```

## Run

```
$ ruby -I lib -r testj -e 'p Testj::VERSION'
"1.0.0"

$ ruby -I lib -r testj -e 't = Testj; t.hello'
Hello
```

## Debug

```
$ gdb -q -ex 'set breakpoint pending on' -ex 'b Hello' -ex run --args ruby -I lib -e 'require "testj"; Testj::hello'
Reading symbols from ruby...
Function "Hello" not defined.
Breakpoint 1 (Hello) pending.
Starting program: /usr/local/ruby-3.0.0/bin/ruby -I lib -e require\ \"testj\"\;\ Testj::hello
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib64/libthread_db.so.1".

Breakpoint 1, Hello (self=7494880) at ../../../../ext/testj/testj_ext.c:8
8   printf("Hello\n");
Missing separate debuginfos, use: dnf debuginfo-install gmp-6.2.0-5.fc33.x86_64 libxcrypt-4.4.18-1.fc33.x86_64 zlib-1.2.11-23.fc33.x86_64

(gdb) l
3	VALUE mTestj;
4
5	static VALUE
6	Hello(VALUE self)
7	{
8	  printf("Hello\n");
9
10	  return Qnil;
11	}
12
(gdb)
```
