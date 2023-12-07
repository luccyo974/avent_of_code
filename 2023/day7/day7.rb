require 'benchmark'
KINDS = ["five-of-a-kind", "four-of-a-kind", "full-house", "three-of-a-kind", "two-pairs", "one_pair", "high_card"]
STRENGTH = ["A", "K", "Q", "J", "T", "9", "8", "7", "6", "5", "4", "3", "2"]
STRENGTH_2 = ["A", "K", "Q", "T", "9", "8", "7", "6", "5", "4", "3", "2", "J"]

class Day7

    def initialize(part = 1)
        lines = File.read("input.txt").split("\n").map{|l| l.split(" ")}
        @hands = []
        lines.each do |l|
            h = Hand.new(part, l.first, l.last)
            @hands << h
        end
    end

    def first_puzzle
        grouped = @hands.group_by{ |i| i.kind }
        grouped.each do |k,v|
            v.sort!
        end
        arr = grouped.values_at(*KINDS.reverse).flatten.compact
        result = 0
        arr.each_with_index{|hand, i| result += hand.bid * (i+1)}
        result
    end

    def second_puzzle
        grouped = @hands.group_by{ |i| i.kind }
        grouped.each do |k,v|
            v.sort!
        end
        arr = grouped.values_at(*KINDS.reverse).flatten.compact
        result = 0
        arr.each_with_index{|hand, i| result += hand.bid * (i+1)}
        result
    end

end

class Hand
    include Comparable
    attr_accessor :cards, :kind, :bid, :part

    def initialize(part, cards, bid)
        self.cards = cards
        self.bid = bid.to_i
        self.part = part
        self.kind = part == 1 ? compute_kind(cards) : compute_kind_part_two(cards)
    end

    def compute_kind(cards)
        cf = cards.each_char.with_object(Hash.new(0)) {|c, m| m[c]+=1}.values
        get_kind(cf)
    end

    def compute_kind_part_two(cards)
        if cards.include?("J")
            h = cards.each_char.with_object(Hash.new(0)) {|c, m| m[c]+=1}
            full_hash = h
            j_count = h.delete("J")
            max_key = h.invert.max&.last
            full_hash[max_key] += j_count
            cf = full_hash.values
            get_kind(cf)
        else
            compute_kind(cards)
        end
    end

    def get_kind(cf)
        if cf.count(5) == 1
            "five-of-a-kind"
        elsif cf.count(4) == 1
            "four-of-a-kind"
        elsif cf.count(3) == 1
            if cf.count(2) == 1 
                "full-house"
            else
                "three-of-a-kind"
            end
        elsif cf.count(2) == 2
            "two-pairs"
        elsif cf.count(2) == 1
            "one_pair"
        else
            "high_card"
        end
    end

    def <=>(other)
        strengh = part == 1 ? STRENGTH : STRENGTH_2
        compare = 0
        (0..4).each do |i|
            compare = strengh.index(other.cards[i]) <=> strengh.index(self.cards[i])
            break unless compare == 0
        end
        compare
    end 
end

duration = Benchmark.realtime do 
    d = Day7.new
    puts Day7.new.first_puzzle
    puts Day7.new(2).second_puzzle
end
puts duration * 1000