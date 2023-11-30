class Day1

    attr_accessor :elves_calories
    
    def initialize
        file = File.open("input.txt")
        data = file.readlines.map(&:chomp)
        @elves_calories = group_by_elves(data)
    end

    def get_max_calories
        max_cal = @elves_calories.max_by{|k,v| v}
    end

    def get_max_3_calories
        mac_cal3 = 0
        3.times do 
            max_elve = @elves_calories.max_by{|k,v| v}
            mac_cal3 += max_elve.last
            @elves_calories.delete(max_elve.first)
        end
        mac_cal3
    end

    def group_by_elves(file_data)
        elves = {}
        i = 1
        file_data.each do |data|
            if data != ""
                elves[i].present? ? elves[i] += data.to_i : elves[i] = data.to_i
            else
                i += 1
            end;
        end;

    end
end

Day1.new.get_max_calories
Day1.new.get_max_3_calories