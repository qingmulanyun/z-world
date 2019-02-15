 class Zombie
   attr_accessor :x, :y

   def initialize(zombie_seed)
     @x = zombie_seed[0]
     @y = zombie_seed[1]
   end

   def move(m, dimensions)
     grid_max = dimensions - 1
     case m
       when 'L'
         x.zero? ? @x = x + grid_max : @x -= 1
       when 'R'
         x == grid_max ? @x = 0 : @x += 1
       when 'U'
         y.zero? ? @y = y + grid_max : @y -= 1
       when 'D'
         y == grid_max ? @y = 0 : @y += 1
     end
   end
 end