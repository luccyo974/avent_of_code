require 'benchmark'
class Day1

    attr_accessor :lines, :calibration_sum, :numbers
    
    
    def initialize
        self.lines = File.read("input.txt").split("\n")
        self.calibration_sum = 0
    end

    def first_puzzle
        lines.each do |l|
            scan_res = l.scan(/(?=(\d))/).flatten
            calibration_value =  "#{scan_res.first}#{scan_res.last}".to_i
            self.calibration_sum += calibration_value
        end;
        puts calibration_sum
    end

    def second_puzzle
        lines.each do |l|
            scan_res = l.scan(/(?=(\d|one|two|three|four|five|six|seven|eight|nine))/).flatten
            calibration_value =  "#{process_numbers(scan_res.first)}#{process_numbers(scan_res.last)}".to_i
            self.calibration_sum += calibration_value
        end;
        puts calibration_sum
    end

    def process_numbers(d)
        n = ["one","two","three","four","five","six","seven","eight","nine"]
        if n.include?(d)
            return n.find_index(d)+1
        else
            return d
        end
    end
end

duration = Benchmark.realtime do 
    Day1.new.first_puzzle
    Day1.new.second_puzzle
end
puts duration