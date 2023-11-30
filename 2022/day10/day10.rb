class Day10

    attr_accessor :lines, :signal_strengh, :markers, :x, :cycles, :x_values, :crt

    def initialize
        self.lines = File.read("input.txt").split("\n");
        self.signal_strengh = 0
        self.x = 1
        self.markers = [20,60,100,140,180,220]
        self.cycles = 0
        self.x_values = {}
        self.crt = []
    end

    def first_puzzle
        compute_x_value
        puts signal_strengh
    end

    def compute_x_value
        lines.each do |line|
            self.cycles += 1
            self.x_values[self.cycles] = x
            if markers.include?(cycles)
                self.signal_strengh += (x * cycles)
            end
            if line == "noop"
                next
            else
                self.cycles += 1
                self.x_values[self.cycles] = x
                if markers.include?(cycles)
                    self.signal_strengh += (x * cycles)
                end
                value = line.split(" ").last.to_i
                self.x += value
            end
        end
    end

    def second_puzzle
        compute_x_value
        draw_on_crt
        #puts self.x_values
    end

    def draw_on_crt


        self.x_values.each_slice(40).each_with_index do |arr, index|
            line = ""
            arr.each do |cycle, x|
                c = cycle - (40 * index) -1
                to_draw = [x, x-1, x+1].include?(c)
                line += to_draw ? "#" : "."
            end
            puts line
            self.crt << line
        end

    end

end


Day10.new.first_puzzle
Day10.new.second_puzzle


#self.x_values.each do |cycle,x|
#    to_draw = [x, x-1, x+1].include?(cycle-1)
#    self.crt += to_draw ? "#" : "."
#end