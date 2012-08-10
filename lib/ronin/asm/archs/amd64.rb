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

require 'ronin/asm/archs/x86'

module Ronin
  module ASM
    module Archs
      module AMD64
        include X86

        def rax; reg(:rax); end
        def rbx; reg(:rbx); end
        def rcx; reg(:rcx); end
        def rdx; reg(:rdx); end

        def rsb; reg(:rsb); end
        def rsp; reg(:rsp); end

        def rsi; reg(:rsi); end
        def rdi; reg(:rdi); end

        def r8;  reg(:r8); end
        def r9;  reg(:r9); end
        def r10; reg(:r10); end
        def r11; reg(:r11); end
        def r12; reg(:r12); end
        def r13; reg(:r13); end
        def r14; reg(:r14); end
        def r15; reg(:r15); end

        def syscall_int(number); instruction(:syscall); end

        protected

        def initialize_arch
          super

          general_purpose = lambda { |name|
            define_register "#{name}b", 1, true
            define_register "#{name}w", 2, true
            define_register "#{name}d", 4, true
            define_register name,       8, true
          }

          define_register :rax, 8, true
          define_register :rbx, 8, true
          define_register :rcx, 8, true
          define_register :rdx, 8, true

          define_register :rsi, 8
          define_register :rdi, 8

          define_register :rsp, 8
          define_register :rbp, 8

          general_purpose[:r8]
          general_purpose[:r9]

          general_purpose[:r10]
          general_purpose[:r11]
          general_purpose[:r12]
          general_purpose[:r13]
          general_purpose[:r14]
          general_purpose[:r15]

          @word_size = 8
        end
      end
    end
  end
end
