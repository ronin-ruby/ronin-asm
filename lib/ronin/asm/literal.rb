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
    class Literal < Struct.new(:value, :width)

      def initialize(value,width=nil)
        value   = value.to_i
        width ||= if (value >= (2 ** 32))    then 8
                  elsif (value >= (2 ** 16)) then 4
                  elsif (value >= (2 ** 8))  then 2
                  else                            1
                  end

        super(value,width)
      end

      def to_i
        self.value
      end

    end
  end
end
