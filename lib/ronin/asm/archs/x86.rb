#
# Ronin ASM - A Ruby DSL for crafting Assembly programs and Shellcode.
#
# Copyright (c) 2007-2012 Hal Brodigan (postmodern.mod3 at gmail.com)
#
# This file is part of Ronin ASM.
#
# Ronin is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Ronin is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Ronin.  If not, see <http://www.gnu.org/licenses/>
#

module Ronin
  module ASM
    module Archs
      module X86
        def al;  reg(:al);  end
        def ah;  reg(:ah);  end
        def ax;  reg(:ax);  end
        def eax; reg(:eax); end

        def bl;  reg(:bl);  end
        def bh;  reg(:bh);  end
        def bx;  reg(:bx);  end
        def ebx; reg(:ebx); end

        def cl;  reg(:cl);  end
        def ch;  reg(:ch);  end
        def cx;  reg(:cx);  end
        def ecx; reg(:ecx); end

        def dl;  reg(:dl);  end
        def dh;  reg(:dh);  end
        def dx;  reg(:dx);  end
        def edx; reg(:edx); end

        def sb;  reg(:sb); end
        def esb; reg(:esb); end
        def sp;  reg(:sp); end
        def esp; reg(:esp); end
        def ip;  reg(:ip); end
        def eip; reg(:eip); end

        def sil; reg(:sil); end
        def si;  reg(:si); end
        def esi; reg(:esi); end

        def dil; reg(:dil); end
        def di;  reg(:di); end
        def edi; reg(:edi); end

        def cs; reg(:cs); end
        def ds; reg(:ds); end
        def es; reg(:es); end
        def fs; reg(:fs); end
        def gs; reg(:gs); end
        def ss; reg(:ss); end

        def syscall_int(number); instruction(:int, 0x80); end

        def stack_base; ebp; end
        def stack_pointer; esp; end
        def stack_push(op); instruction(:push,op); end
        def stack_pop(op); instruction(:pop,op); end

        def reg_clear(name); instruction(:xor,reg(name),reg(name)); end
        def reg_set(value,name); instruction(:mov,value,reg(name)); end
        def reg_save(name); stack_push(reg(name)); end
        def reg_load(name); stack_pop(reg(name)); end

        protected

        def initialize_arch
          general_purpose = lambda { |name|
            define_register "#{name}l",  1
            define_register "#{name}h",  1
            define_register "#{name}x",  2
            define_register "e#{name}x", 4, true
          }

          general_purpose[:a]
          general_purpose[:b]
          general_purpose[:c]
          general_purpose[:d]

          define_register :sil, 1
          define_register :si,  2
          define_register :esi, 4, true

          define_register :dil, 1
          define_register :di,  2
          define_register :edi, 4, true

          define_register :bpl, 1
          define_register :bp,  2
          define_register :ebp, 4

          define_register :spl, 1
          define_register :sp,  2
          define_register :esp, 4

          define_register :cs, 2
          define_register :ds, 2
          define_register :es, 2
          define_register :fs, 2
          define_register :gs, 2
          define_register :ss, 2

          define_register :eip, 4
        end

      end
    end
  end
end
