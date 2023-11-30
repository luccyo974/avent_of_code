
class Day3

    attr_accessor :h_values

    def initialize
        self.h_values = init_values
    end

    def init_values
        h_values = {}
        ("a".."z").each_with_index do |char, index|
            h_values[char] = index + 1
        end
        ("A".."Z").each_with_index do |char, index|
            h_values[char] = index + 27
        end
        h_values
    end

    def cut_string_half(str)
        half_size = str.size / 2
        first,second = str.partition(/.{#{half_size}}/)[1,2]
        [first,second]
    end 

    def find_matching_char(str1, str2)
        str1.chars.select{|c| str2.include?(c)}
    end

    def get_item_value(item)
        item1, item2 = cut_string_half(item)
        cat_char = find_matching_char(item1, item2).first
        value = h_values[cat_char]
    end

    def first_puzzle
        items = File.read('input.txt').split("\n")
        items.map{|item| get_item_value(item)}.sum
    end

    def second_puzzle
        sum_second = 0
        File.foreach("input.txt").each_slice(3) do |three_lines|
            # eight_lines is an array containing 8 lines.
            # at this point you can iterate over these filenames
            # and spawn off your processes/threads
            sum_second += get_badge_value(three_lines)
        end
        sum_second
        #items = File.read('input.txt').split("\n")
        #items.map{|item| get_item_value(item)}.sum
    end

    def get_badge_value(three_lines)
        one_and_two_char = find_matching_char(three_lines[0], three_lines[1]).join("")
        char = find_matching_char(one_and_two_char, three_lines[2]).first
        value = h_values[char]
    end
end

puts Day3.new.first_puzzle
puts Day3.new.second_puzzle