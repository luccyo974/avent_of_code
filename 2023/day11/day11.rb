require 'benchmark'

class Day11
    
    attr_accessor :lines, :cols, :empty_lines, :empty_cols, :galaxies
    
    def initialize
        self.lines = File.read("input.txt").split("\n").map(&:chars)
        self.galaxies = []
        init_data
        expand_space 
    end

    def init_data
        cols = {}
        lines.each_with_index do |l,i|
            l.each_with_index do |c,j|
                cols[j] = [] if cols[j].nil?  
                cols[j] << c
                self.galaxies << Galaxy.new(j,i) if c == "#"
            end
        end
        self.cols = cols.values
    end

    def expand_space
        self.empty_lines = []
        self.empty_cols = []
        line = nil
        col = nil
        self.lines.each_with_index do |l,i|
            empty_lines << i unless l.include?("#")
        end
        self.cols.each_with_index do |c,j|
            empty_cols << j unless c.include?("#")
        end
    end

    def count_step(g, next_g)
        x_step = (g.x - next_g.x).abs
        y_step = (g.y - next_g.y).abs
        x_step + y_step
    end
    
    def first_puzzle
        res = 0
        gs = expand_all_galaxies(1)
        gs.each_with_index do |g, i|
            ((i + 1)..(gs.size - 1)).each do |j|
                next_g = gs[j]
                steps = count_step(g,next_g)
                res += steps
            end
        end
        res
    end

    def expand_all_galaxies(part)
        gs = []
        galaxies.each do |g|
            gdup = g.dup
            gdup.handle_expand(empty_cols, empty_lines, part)
            gs << gdup
        end
        gs
    end

        
    def second_puzzle
        res = 0
        gs = expand_all_galaxies(2)
        gs.each_with_index do |g, i|
            ((i + 1)..(gs.size - 1)).each do |j|
                next_g = gs[j]
                steps = count_step(g,next_g)
                res += steps
            end
        end
        res
    end

end

class Galaxy
    attr_accessor :x, :y
    def initialize(x,y)
        self.x = x
        self.y = y
    end

    def handle_expand(empty_cols, empty_lines, part=1)
        if part == 1
            step_cols = empty_cols.index{|v| v >= x}.nil? ? empty_cols.size : empty_cols.index{|v| v >= x}
            step_lines = empty_lines.index{|v| v >= y}.nil? ? empty_lines.size : empty_lines.index{|v| v >= y}

            self.x += step_cols
            self.y += step_lines
        else
            part_multiple = 1000000
            step_cols = empty_cols.index{|v| v >= x}.nil? ? empty_cols.size : empty_cols.index{|v| v >= x}
            step_lines = empty_lines.index{|v| v >= y}.nil? ? empty_lines.size : empty_lines.index{|v| v >= y}

            self.x += (step_cols  * part_multiple) - step_cols
            self.y += (step_lines * part_multiple) - step_lines
        end
    end
end

duration = Benchmark.realtime do 
    d = Day11.new
    puts d.first_puzzle
    puts d.second_puzzle
end
puts duration * 1000