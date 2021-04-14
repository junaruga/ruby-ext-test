require 'mkmf'

# Examples:
# https://github.com/sparklemotion/nokogiri/blob/main/ext/nokogiri/extconf.rb
# https://github.com/junaruga/byebug/blob/master/ext/byebug/extconf.rb
# https://github.com/brianmario/mysql2/blob/master/ext/mysql2/extconf.rb

if ENV['TESTJ_DEBUG']
  CONFIG['debugflags'] = '-ggdb3'
  CONFIG['optflags'] = '-O0'

  # C extention
  $CFLAGS.gsub!(/-O[123]/, '-O0')
  # It looks the flags maximize the debug info for gdb debugging.
  $CFLAGS << ' -g3 -ggdb3 -gdwarf-4 -O0'
  # C++ extention
  # $CXXFLAGS.gsub!(/-O[123]/, '-O0')
  # $CXXFLAGS << ' -O0 -gdwarf-2 -ggdb3 -g'
end

# always include debugging information
append_cflags('-/g')

create_makefile('testj/testj')
