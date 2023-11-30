class Day4

    def section_include_another?(line)
        first_section, second_section = line.split(",")
        first_min, first_max = first_section.split("-").map(&:to_i)
        second_min, second_max = second_section.split("-").map(&:to_i)

        return true if first_min <= second_min && first_max >= second_max
        return true if second_min <= first_min && second_max >= first_max
        false
    end

    def section_overlap_another?(line)
        first_section, second_section = line.split(",")
        first_min, first_max = first_section.split("-").map(&:to_i)
        second_min, second_max = second_section.split("-").map(&:to_i)

        return true if first_min >= second_min && first_min <= second_max
        return true if second_min >= first_min && second_min <= first_max
        return true if first_max >= second_min && first_max <= second_max
        return true if second_max >= first_min && second_max <= first_max
        false
    end

    def first_puzzle
        lines = File.read('input.txt').split("\n")
        included = 0
        lines.each do |line|
            included += 1 if section_include_another?(line)
        end
        included
    end

    def second_puzzle
        lines = File.read('input.txt').split("\n")
        overlap = 0
        lines.each do |line|
            overlap += 1 if section_overlap_another?(line)
        end
        overlap
    end

end

puts Day4.new.first_puzzle
puts Day4.new.second_puzzle