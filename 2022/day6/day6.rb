class Day6

    attr_accessor :line

    def initialize
        self.line = File.read('input.txt')
    end

    def first_puzzle
        get_first_index_after_x_uniq(4)
    end

    def second_puzzle
        get_first_index_after_x_uniq(14)
    end

    def get_first_index_after_x_uniq(x)
        (0..line.size).detect{|i| all_uniq?(line[i, x]) } + x
    end

    def all_uniq?(str)
        str.chars.uniq.count == str.size
    end

end

puts Day6.new.first_puzzle
puts Day6.new.second_puzzle