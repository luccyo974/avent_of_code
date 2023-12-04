require 'benchmark'
class Day3

    attr_accessor :lines, :sym_positions, :num_positions, :star_positions
    
    
    def initialize
        self.lines = File.read("input.txt").split("\n")
        self.num_positions = get_num_positions
    end

    def first_puzzle
        self.sym_positions = get_symbol_positions
        sum = 0
        num_positions.each do |k,v|
            v.each do |n_pos|
                num = n_pos.first
                pos = n_pos.last
                pos_max = pos + (num.size - 1)
                (k-1..k+1).each do |p_index|
                    a = sym_positions[p_index]
                    next if a.nil?
                    sum += num.to_i if (pos-1..pos_max+1).detect{|n| a.include?(n)}
                end
            end
        end
        sum 
    end

    def second_puzzle
        self.star_positions = get_star_positions
        sum = 0
        star_positions.each do |k,stars_pos|
            next if stars_pos.empty?
            stars_pos.each do |v|
                gears = []
                (k-1..k+1).each do |p_index|
                    nums = num_positions[p_index]
                    next if nums.nil?
                    nums.each do |n,i|
                        i_min = i-1
                        i_max = i+ (n.size)
                        gears << n.to_i  if (i_min..i_max).include?(v)
                    end
                end
                sum += gears.inject(:*) if gears.count == 2
            end
            #sum += ratio
        end
        sum
    end

    def get_symbol_positions
        positions = {}
        lines.each_with_index do | l, i |
            positions[i] = l.each_char.each_with_index.inject([]) do |indices, (char, idx)|
                indices << idx if char != "." && char.match(/\D/)
                indices
            end
        end
        positions
    end

    def get_num_positions
        positions = {}
        lines.each_with_index do | l, i |
            ps = l.enum_for(:scan, /\d+/).map { Regexp.last_match.begin(0) }
            nums = l.scan(/\d+/).flatten
            if ps.count == nums.count
                nums.each_with_index do |n,j|
                    positions[i] = [] if positions[i].nil?
                    positions[i] << [n, ps[j]]
                end
            end
        end
        positions
    end

    def get_star_positions
        positions = {}
        lines.each_with_index do | l, i |
            positions[i] = l.each_char.each_with_index.inject([]) do |indices, (char, idx)|
                indices << idx if char.match(/(\*)/)
                indices
            end
        end
        positions
    end

end

duration = Benchmark.realtime do 
    puts Day3.new.first_puzzle
    puts Day3.new.second_puzzle
end
puts duration