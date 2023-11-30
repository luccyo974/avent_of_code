class Day5

    attr_accessor :pile_count, :lines, :moves, :stacks

    def initialize
        self.lines = File.read('input.txt').split("\n")
        self.pile_count = lines.first.chars.each_slice(4).count
        self.moves = get_moves_from_lines
        self.stacks = get_stacks
    end

    def first_puzzle
        moves.each do |move|
            move_stack(move[0], move[1], move[2]) 
        end;
        stacks.values.map(&:first).join()
    end

    def second_puzzle
        moves.each do |move|
            move_stack_2(move[0], move[1], move[2]) 
        end;
        stacks.values.map(&:first).join()
    end

    def get_moves_from_lines
        i = 0
        lines.each_with_index do |l, index|
            i = index if l.empty?
        end
        arr = lines.slice(i+1, lines.size)
        moves = []
        arr.each do |ar|
            data = ar.split(" ")
            moves << [data[1].to_i, data[3].to_i, data[5].to_i]
        end
        moves
    end

    def get_stacks
        i = 0
        stacks = {}
        lines.each_with_index do |l, index|
            i = index if l.empty?
        end;
        arr = lines.slice(0, i-1)
        (1..pile_count).each do |index|
            stacks[index] = []
            arr.each_with_index do |c, ind|
                chars = c.chars
                key = ((index -1) * 4) + 1
                stacks[index] << chars[key] unless chars[key] == " "
            end;
        end;
        stacks
    end

    def move_stack(number,from, to)   
        from_stack = stacks[from]
        to_stack = stacks[to]
        (1..number).each do |n|
            from_stack = stacks[from]
            letter_to_move =  from_stack.first
            from_stack.shift
            to_stack.unshift(letter_to_move)
        end
        stacks[from] = from_stack.compact
        stacks[to] = to_stack.compact
    end

    def move_stack_2(number,from, to)
        from_stack = stacks[from].join()
        to_stack = stacks[to].join()
        str_to_move = from_stack[0, number]
        to_stack = "#{str_to_move}#{to_stack}"
        stacks[from] = from_stack[number,from_stack.size].chars
        stacks[to] = to_stack.chars
    end

end

puts Day5.new.first_puzzle
puts Day5.new.second_puzzle