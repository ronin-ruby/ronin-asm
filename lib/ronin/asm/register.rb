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

require 'ronin/asm/immediate'

module Ronin
  module ASM
    class Register < Struct.new(:name, :width)

      def [](index)
        Immediate.new(self,self.width,index)
      end

      def +(offset)
        case offset
        when Immediate
          Immediate.new(self,offset.offset,offset.scale)
        else
          Immediate.new(self,offset,nil)
        end
      end

      def *(index)
        Immediate.new(nil,self,index)
      end

    end
  end
end
