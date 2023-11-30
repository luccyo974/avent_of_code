
class Knot
    attr_accessor :row, :column, :visited, :visited_end

    def initialize(row, column, visited=false, visited_end=false)
        self.row = row
        self.column = column
        self.visited = visited
        self.visited_end = visited_end
    end

end

class Day9

    attr_accessor :lines, :knots, :head_knot, :next_knot, :current_knot, :knot_positions

    def initialize
        self.lines = File.read("input_test_2.txt").split("\n")
        self.knots = []
        self.knot_positions = []
    end

    def first_puzzle
        process_moves
        puts knots.select{|k| k.visited }.count
    end

    def process_moves
        start_knot = Knot.new(0,0,true)
        self.knots << start_knot
        self.next_knot = start_knot
        self.current_knot = start_knot
        lines.each do |line|
            dir, steps = line.split(" ")
            move_head(dir, steps)
        end
    end

    def move_head(dir, steps)
        (1..steps.to_i).each do |i|
            self.current_knot = move_head_one_step(dir, current_knot)
            #puts "head : #{head_knot.row}, #{head_knot.column}"
            if tail_need_to_move?(current_knot, next_knot)
                #puts "move tail"
                self.next_knot = move_tail(dir, current_knot, next_knot)
            end
        end
    end

    def move_head_one_step(dir, current_knot)
        h = current_knot
        case dir
        when "U"
            k = find_or_create_knot(h.row + 1, h.column)
        when "D"
            k = find_or_create_knot(h.row - 1, h.column)
        when "L"
            k = find_or_create_knot(h.row, h.column - 1)
        when "R"
            k = find_or_create_knot(h.row, h.column + 1)
        end
        k
    end

    def move_tail(dir, current, next_k)
        max_steps = [-1,0,1]
        h = current
        t = next_k
        row = h.row
        column = h.column
        if !max_steps.include?(h.row - t.row)
            row = dir == "D" ? t.row - 1 : t.row + 1
            column = h.column
        elsif !max_steps.include?(h.column - t.column)
            column = dir == "L" ? t.column - 1 : t.column + 1
            row = h.row
        end

        knot = find_or_create_knot(row, column)
        knot.visited = true
        knot
    end

    def tail_need_to_move?(current, next_k)
        max_steps = [-1,0,1]
        h = current
        t = next_k
        !max_steps.include?(h.column - t.column) || !max_steps.include?(h.row - t.row)
    end

    def find_or_create_knot(row, column)
        knot = find_knot(row, column)
        unless knot
            knot = Knot.new(row, column)
            self.knots << knot
        end
        knot
    end

    def find_knot(row, column)
        self.knots.select{|k| k.row == row && k.column == column}.first
    end

    def second_puzzle
        process_moves_2
        puts knots.select{|k| k.visited_end }.count
    end

    def process_moves_2
        start_knot = Knot.new(0,0,true, true)
        (0..9).each do |i|
            self.knot_positions << Knot.new(0,0)
        end
        lines.each do |line|
            dir, steps = line.split(" ")
            move_rope(dir, steps)
        end
    end

    def move_rope(dir, steps)

        (1..steps.to_i).each do |i|
            current = knot_positions[0]
            next_k = knot_positions[1]
            current = move_head_one_step(dir, current)
            self.knot_positions[0] = current
            if tail_need_to_move?(current, next_k)
                next_k = move_tail(dir, current, next_k)
                self.knot_positions[1] = next_k
            end
            (1..8).each do |j|
                current = self.knot_positions[j]
                next_k = self.knot_positions[j+1]
                if tail_need_to_move?(current, next_k)
                    next_k = move_tail(dir, current, next_k)
                    if j == 8
                        next_k.visited_end = true
                    end
                    self.knot_positions[j+1] = next_k
                end
            end
        end
    end

end

Day9.new.first_puzzle
Day9.new.second_puzzle