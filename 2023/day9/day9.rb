require 'benchmark'

class Day9
    
    attr_accessor :lines, :nodes
    
    def initialize
        self.lines = File.read("input.txt").split("\n").map{|l| l.split(" ").map(&:to_i)} 
    end
    
    def first_puzzle
        res = 0
        self.lines.each do |l|
            next_val = find_next_val(l)
            res += next_val
        end
        res
    end

    def find_next_val(nums)
        interval = []
        value = 0
        nums.each_with_index do |n,i|
            interval << nums[i+1] - n unless nums[i+1].nil?
        end

        if interval.uniq.count == 1
            value = nums[-1] + interval[0]
        else
            value = nums[-1] + find_next_val(interval)
        end
        value
    end
        
    def second_puzzle
        res = 0
        self.lines.each do |l|
            next_val = find_previous_val(l)
            res += next_val
        end
        res
    end

    def find_previous_val(nums)
        interval = []
        value = 0
        nums.each_with_index do |n,i|
            interval << nums[i+1] - n unless nums[i+1].nil?
        end

        if interval.uniq.count == 1
            value = nums[0] - interval[0]
        else
            value = nums[0] - find_previous_val(interval)
        end
        value
    end

end

duration = Benchmark.realtime do 
    d = Day9.new
    puts d.first_puzzle
    puts d.second_puzzle
end
puts duration * 1000