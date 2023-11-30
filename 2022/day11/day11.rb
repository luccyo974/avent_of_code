class Day11

    attr_accessor :notes, :monkeys

    def initialize
        self.notes = File.read("input.txt").split("\n\n").map{|l| l.strip.split("\n")}
        self.monkeys = []
        init_monkeys
    end

    def init_monkeys
        notes.each do |n|
            regex = /Monkey(.*):Startingitems:(.*)Operation:new=old(\*|\+)(.*)Test:divisibleby(.*)Iftrue:throwtomonkey(.*)Iffalse:throwtomonkey(.*)/
            line = n.join.gsub(" ","")
            md = regex.match(line)
            id = md[1]
            items = create_items(md[2])
            operator = md[3]
            operand = md[4]
            test_div = md[5].to_i
            m_true = md[6]
            m_false = md[7]
            self.monkeys << Monkey.new(id, items, operator, operand, test_div, m_true, m_false)
        end
    end

    def create_items(item_array)
        items = []
        item_array.split(",").each do |i|
            items << Item.new(i.to_i)
        end
        items
    end

    def first_puzzle
        20.times do
            process_notes(1)
        end
        puts self.monkeys.map(&:inspect_item_count).sort.last(2).inject(:*)
    end

    def process_notes(part)
        self.monkeys.each do |m|
            m.items.each do |i|
                m.inspect_item_count += 1
                wl = i.worry_lvl.to_i
                operand = m.operand == "old" ? wl : m.operand.to_i
                wl = wl.public_send(m.operator, operand)
                wl = part == 1 ? wl / 3  : wl % lcm
                i.worry_lvl = wl
                test_true = (wl % m.test_div.to_i) == 0
                receiver_id = test_true ? m.m_true : m.m_false
                m_receiver = self.monkeys.detect{|monkey| monkey.id == receiver_id}
                m_receiver.items.push(i)
            end
            m.items = []
        end

    end

    def second_puzzle
        10000.times do
            process_notes(2)
        end
        #puts self.monkeys.map{|m| m.items.count}
        puts self.monkeys.map(&:inspect_item_count).sort.last(2).inject(:*)
    end

    def lcm
        @lcm ||= self.monkeys.map(&:test_div).reduce(:lcm)
    end
end

class Monkey
    attr_accessor :items, :inspect_item_count, :id, :operator, :operand, :test_div, :m_true, :m_false

    def initialize(id, items, operator, operand, test_div, m_true, m_false)
        self.items = items
        self.id = id
        self.inspect_item_count = 0
        self.operator = operator
        self.operand = operand
        self.test_div = test_div
        self.m_true = m_true
        self.m_false = m_false
    end
end

class Item

    attr_accessor :worry_lvl

    def initialize(worry_lvl=nil)
        self.worry_lvl = worry_lvl
    end

end


Day11.new.first_puzzle
Day11.new.second_puzzle