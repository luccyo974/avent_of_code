require 'benchmark'
class Day4

    attr_accessor :lines
    
    
    def initialize
        self.lines = File.read("input.txt").split("\n")
    end

    def first_puzzle
        sum = 0
        lines.each do |l|
            numbers = l.split(":").last.split("|")
            winning_numbers = numbers.first.scan(/\d+/)
            my_numbers = numbers.last.scan(/\d+/)
            match_numbers = winning_numbers & my_numbers
            card_worth = 1.upto(match_numbers.count).reduce { |s| s * 2 }
            sum += card_worth unless card_worth.nil?
        end
        sum
    end

    def second_puzzle
        sum = 0
        copies = {}
        lines.each do |l|
            split = l.split(":")
            numbers = split.last.split("|")
            card_number = split.first.scan(/\d+/).first.to_i
            runs = copies[card_number].nil? ? 1 : copies[card_number]+1
            winning_numbers = numbers.first.scan(/\d+/)
            my_numbers = numbers.last.scan(/\d+/)
            match_numbers = winning_numbers & my_numbers
            next if match_numbers.empty?
            (1..match_numbers.count).each do |i|
                copie_num = card_number+i
                copies[copie_num].nil? ? copies[copie_num] = runs : copies[copie_num] += runs
            end
        end
        sum = lines.count + copies.values.sum
    end


end

duration = Benchmark.realtime do 
    d = Day4.new
    puts d.first_puzzle
    puts d.second_puzzle
end
puts duration * 1000