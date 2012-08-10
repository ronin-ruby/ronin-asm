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

require 'ronin/asm/config'

module Ronin
  module ASM
    module OS
      module Linux
        DATA_DIR = File.join('ronin','asm','linux')

        SYSCALLS = {
          :x86 => Config.load_yaml_file(File.join(DATA_DIR,'x86','syscalls.yml')),
          :amd64 => Config.load_yaml_file(File.join(DATA_DIR,'amd64','syscalls.yml'))
        }

        def syscall(name,*arguments)
          name = name.to_sym
          number = SYSCALLS[@arch][name]

          unless number
            raise(ArgumentError,"unknown syscall: #{name}")
          end

          if arguments.length > 6
            regs = @general_registers[1,1]

            critical_region(regs) do
              arguments.reverse_each { |arg| stack_push(arg) }

              reg_set stack_pointer, regs[0]
              reg_set number, @general_registers[0]
              syscall_int(number)
            end
          else
            regs = @general_registers[1,arguments.length]

            critical_region(regs) do
              (arguments.length - 1).downto(0) do |index|
                reg_set(arguments[index],regs[index])
              end

              reg_set number, @general_registers[0]
              syscall_int(number)
            end
          end
        end
      end
    end
  end
end
