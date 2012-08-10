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

require 'ronin/asm/syntax/common'

module Ronin
  module ASM
    module Syntax
      class Intel < Common

        WIDTHS = {
          1 => 'BYTE',
          2 => 'WORD',
          4 => 'DWORD',
          8 => 'QWORD'
        }

        def self.emit_label(name)
          "#{name}:"
        end

        def self.emit_register(reg)
          reg.name.to_s
        end

        def self.emit_literal(literal)
          width  = WIDTHS[literal.width]
          format = if literal.value > 0
                     "0x%x"
                   else
                     "%d"
                   end

          return "#{width} #{format % literal.value}"
        end

        def self.emit_immediate(imm)
          base, offset, scale = *imm

          if (offset && scale)
            '[' + emit(base) + '+' + emit(offset) + '*' + emit(scale) + ']'
          elsif scale
            '[' + emit(base) + '*' + emit(scale) + ']'
          elsif offset
            '[' + emit(base) + '+' + emit(offset) + ']'
          else
            '[' + emit(base) + ']'
          end
        end

        def self.emit_operands(operands)
          if operands.length > 1
            [operands[-1], *operands[0..-2]].map { |op|
              emit_operand(op)
            }.join(",\t")
          else
            super(operands)
          end
        end

        def self.emit_instruction(ins)
          line = emit_keyword(ins.name)

          if ins.operands
            line << "\t" << emit_operands(ins.operands)
          end

          return line
        end

        def self.emit_program(program)
          asm = super(program)

          # prepend the `BITS 64` directive for YASM
          if program.arch == :amd64
            asm = ["BITS 64", '', asm].join($/)
          end

          return asm
        end

      end
    end
  end
end
