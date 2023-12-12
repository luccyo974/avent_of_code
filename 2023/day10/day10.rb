require 'benchmark'

class Day10
    
    attr_accessor :lines, :pipeline
    
    def initialize
        self.lines = File.read("input_test_2.txt").split("\n").map(&:chars)
    end
    
    def first_puzzle

        pipes = []
        p = find_s
        pipe = get_next_pipe_from_s(p)
        #puts "#{pipe.char} / #{pipe.x} , #{pipe.y}"
        pipes << p
        pipes << pipe

        while pipe.char != "S"
            next_p = get_next_pipe(pipe)
            pipes << next_p
            pipe = next_p
        end

        self.pipeline = pipes
        pipes.count / 2
    end

    def get_next_pipe_from_s(s)
        first_p = nil
        if %w( L F - ).include?(lines[s.y][s.x - 1])
            c = lines[s.y][s.x - 1]
            first_p = Pipe.new(c, (s.x - 1), s.y, s.x, s.y)
        elsif %w( 7 J - ).include?(lines[s.y][s.x + 1])
            c = lines[s.y][s.x + 1]
            first_p = Pipe.new(c, (s.x + 1), s.y, s.x, s.y)
        elsif %w( 7 F - ).include?(lines[s.y - 1][s.x])
            c = lines[s.y - 1][s.x]
            first_p = Pipe.new(c, s.x, (s.y - 1), s.x, s.y)
        else
            c = lines[s.y + 1][s.x]
            first_p = Pipe.new(c, s.x, (s.y + 1), s.x, s.y)
        end
        first_p
    end

    def get_next_pipe(p)
        case p.char
        when "|"
            y = p.from_y > p.y ? p.y - 1 : p.y + 1
            x = p.x
        when "-"
            x = p.from_x > p.x ? p.x - 1 : p.x + 1
            y = p.y
        when "L"
            if p.x == p.from_x
                x = p.x+1
                y = p.y
            elsif p.y == p.from_y
                y = p.y - 1
                x = p.x
            end
        when "J"
            if p.x == p.from_x
                x = p.x - 1
                y = p.y
            elsif p.y == p.from_y
                y = p.y - 1
                x = p.x
            end
        when "7"
            if p.x == p.from_x
                x = p.x - 1
                y = p.y
            elsif p.y == p.from_y
                y = p.y + 1
                x = p.x
            end
        when "F"
            if p.x == p.from_x
                x = p.x + 1
                y = p.y
            elsif p.y == p.from_y
                y = p.y + 1
                x = p.x
            end
        end
        c = lines[y][x]
        n_p = Pipe.new(c, x, y, p.x, p.y)
        n_p
    end

    def find_s
        s = nil
        lines.each_with_index do |l, y|
            l.each_with_index do |c, x|
                if c == "S"
                    s = Pipe.new(c, x, y)
                end
            end
        end
        s
    end
        
    def second_puzzle
        off_pipes = get_off_pipes
        puts "in pipe : #{pipeline.count} / off pipe : #{off_pipes.count}"
        # find which one of those are inside .......
    end

    def get_off_pipes
        off_pipes = []
        lines.each_with_index do |l, y|
            l.each_with_index do |c, x|
                found_p = pipeline.detect{|p| p.x == x && p.y == y && c == p.char}
                if found_p.nil?
                    off_p = Pipe.new(c, x, y)
                    off_pipes << off_p
                end
            end
        end
        off_pipes
    end

end

class Pipe 
    attr_accessor :y, :x, :from_y, :from_x, :char

    def initialize(char, x, y, from_x=nil, from_y=nil)
        self.char = char
        self.x = x
        self.y = y
        self.from_x = from_x
        self.from_y = from_y
    end
end

duration = Benchmark.realtime do 
    d = Day10.new
    puts d.first_puzzle
    puts d.second_puzzle
end
puts duration * 1000