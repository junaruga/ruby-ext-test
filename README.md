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

### Run `gdb` with interactive mode.

```
$ gdb --help
```

```
$ gdb -q --args ruby -I lib -e 'require "testj"; Testj::hello'
Reading symbols from ruby...

(gdb) set breakpoint pending on

(gdb) b Hello
Function "Hello" not defined.
Breakpoint 1 (Hello) pending.

(gdb) r
Starting program: /usr/local/ruby-3.0.0/bin/ruby -I lib -e require\ \"testj\"\;\ Testj::hello
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib64/libthread_db.so.1".

Breakpoint 1, Hello (self=7494880) at ../../../../ext/testj/testj_ext.c:8
8	  printf("Hello\n");
Missing separate debuginfos, use: dnf debuginfo-install gmp-6.2.0-5.fc33.x86_64 libxcrypt-4.4.18-1.fc33.x86_64 zlib-1.2.11-23.fc33.x86_64
```

### Run `gdb` with a ruby file.

```
$ cat test.rb
require "testj"

Testj::hello
```

```
$ gdb -q --args ruby -I lib test.rb
Reading symbols from ruby...

(gdb) set breakpoint pending on

(gdb) b Hello
Function "Hello" not defined.
Breakpoint 1 (Hello) pending.

(gdb) r
Starting program: /usr/local/ruby-3.0.0/bin/ruby -I lib test.rb
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib64/libthread_db.so.1".

Breakpoint 1, Hello (self=7494360) at ../../../../ext/testj/testj_ext.c:8
8	  printf("Hello\n");
Missing separate debuginfos, use: dnf debuginfo-install gmp-6.2.0-5.fc33.x86_64 libxcrypt-4.4.18-1.fc33.x86_64 zlib-1.2.11-23.fc33.x86_64
```

### Run `gdb` with some gdb commands.

```
$ gdb -q -ex 'set breakpoint pending on' -ex 'b Hello' -ex r --args ruby -I lib -e 'require "testj"; Testj::hello'
Reading symbols from ruby...
Function "Hello" not defined.
Breakpoint 1 (Hello) pending.
Starting program: /usr/local/ruby-3.0.0/bin/ruby -I lib -e require\ \"testj\"\;\ Testj::hello
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib64/libthread_db.so.1".

Breakpoint 1, Hello (self=7494880) at ../../../../ext/testj/testj_ext.c:8
8   printf("Hello\n");
Missing separate debuginfos, use: dnf debuginfo-install gmp-6.2.0-5.fc33.x86_64 libxcrypt-4.4.18-1.fc33.x86_64 zlib-1.2.11-23.fc33.x86_64
```

### Set break point with `file:function`.

```
(gdb) b ext/testj/testj_ext.c:Hello
No source file named ext/testj/testj_ext.c.
Breakpoint 1 (ext/testj/testj_ext.c:Hello) pending.
```

### Set break point with `file:line_number`.

```
(gdb) b ext/testj/testj_ext.c:8
No source file named ext/testj/testj_ext.c.
Breakpoint 1 (ext/testj/testj_ext.c:8) pending.
```

### Caution: ruby in rubypick RPM.

When you are using `ruby` command by `rubypick` RPM package, `gdb` can not read symbols and execute by the message `not in executable format: file format not recognized`.


```
$ rpm -qf /usr/bin/ruby
rubypick-1.1.1-13.fc33.noarch

$ gdb -q --args /usr/bin/ruby
"0x7fff95453d60s": not in executable format: file format not recognized
```

This is because the `ruby` is shell script that can call `/usr/bin/ruby-mri` internally. Not a binary file.

```
$ file /usr/bin/ruby
/usr/bin/ruby: Bourne-Again shell script, ASCII text executable

$ head -3 /usr/bin/ruby
#!/usr/bin/bash
declare -A INTERPRETER_LIST
INTERPRETER_LIST=([_jruby_]=/usr/bin/jruby [_mri_]=/usr/bin/ruby-mri)
```

Try the `ruby-mri` command to read symbols in this case.

```
$ rpm -qf /usr/bin/ruby-mri
ruby-2.7.2-135.fc33.x86_64

$ file /usr/bin/ruby-mri
/usr/bin/ruby-mri: ELF 64-bit LSB pie executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, BuildID[sha1]=f1f73707ee8fdb0ccc6fe7d8c9eacb2ed19e9e39, for GNU/Linux 3.2.0, stripped

$ gdb -q --args /usr/bin/ruby-mri
Reading symbols from /usr/bin/ruby-mri...
Reading symbols from .gnu_debugdata for /usr/bin/ruby-mri...
(No debugging symbols found in .gnu_debugdata for /usr/bin/ruby-mri)
Missing separate debuginfos, use: dnf debuginfo-install ruby-2.7.2-135.fc33.x86_64
```
