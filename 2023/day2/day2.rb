require 'benchmark'
class Day2

    attr_accessor :lines, :calibration_sum, :numbers
    
    
    def initialize
        self.lines = File.read("input.txt").split("\n")
    end

    def first_puzzle
        sum = 0
        lines.each do |l|
            id = l.match(/Game (.*): /)[1]&.to_i
            max_green = l.scan(/(\d*) green/).flatten.map(&:to_i).max
            max_blue = l.scan(/(\d*) blue/).flatten.map(&:to_i).max
            max_red = l.scan(/(\d*) red/).flatten.map(&:to_i).max

            sum += id if max_green <= 13 && max_red <= 12 && max_blue <= 14
        end
        sum  
    end

    def second_puzzle
        sum = 0
        lines.each do |l|
            min_green = l.scan(/(\d*) green/).flatten.map(&:to_i).max
            min_blue = l.scan(/(\d*) blue/).flatten.map(&:to_i).max
            min_red = l.scan(/(\d*) red/).flatten.map(&:to_i).max
            power = min_green * min_blue * min_red
            sum += power
        end
        sum
    end

end

duration = Benchmark.realtime do 
    puts Day2.new.first_puzzle
    puts Day2.new.second_puzzle
end
puts duration