class Day1

    attr_accessor :lines, :calibration_sum, :numbers
    
    
    def initialize
        self.lines = File.read("input.txt").split("\n")
        self.calibration_sum = 0
    end

    def first_puzzle
        
        lines.each do |l|
            scan_res = l.scan(/(?=(\d|one|two|three|four|five|six|seven|eight|nine))/).flatten
            digits = process_numbers(scan_res)
            calibration_value =  "#{digits.first}#{digits.last}".to_i
            self.calibration_sum += calibration_value
        end;
        puts calibration_sum
    end

    def process_numbers(digits)
        n = ["one","two","three","four","five","six","seven","eight","nine"]
        processed_digits = []
        digits.each do |d|
            if n.include?(d)
                processed_digits << n.find_index(d)+1
            else
                processed_digits << d
            end
        end
        processed_digits
    end

end

Day1.new.first_puzzle