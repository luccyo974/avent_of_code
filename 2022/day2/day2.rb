class Day2

    def first_puzzle
        runs = File.read('input.txt').split("\n")
        runs.map{|run| get_run_result(run)}.sum
    end

    def second_puzzle
        runs = File.read('input.txt').split("\n")
        runs.map{|run| get_second_run_result(run)}.sum
    end

    def get_run_result(run)
        his_shape, my_shape = run.split(" ")
        my_shape = transform(my_shape)
        shape_value = values(my_shape)
        score = score(my_shape, his_shape)
        shape_value + score
    end

    def get_second_run_result(run)
        his_shape, result = run.split(" ")
        score = score_value(result)
        shape_value = get_my_shape_value(his_shape, result)
        shape_value + score
    end

    def values(shape)
        case shape
        when "A"
            1
        when "B"
            2
        when "C"
            3
        end
    end

    def score_value(result)
        case result
        when "X"
            0
        when "Y"
            3
        when "Z"
            6
        end
    end

    def score(my_shape, his_shape)
        return 3 if my_shape == his_shape 
        case my_shape
        when "A"
            return his_shape == "B" ? 0 : 6
        when "B"
            return his_shape == "C" ? 0 : 6
        when "C"
            return his_shape == "A" ? 0 : 6
        end
    end

    def get_my_shape_value(his_shape, result)
        return values(his_shape) if result == "Y"
        case result
        when "X" 
            his_shape == "A" ? 3 : his_shape == "B" ? 1 : 2
        when "Z"
            his_shape == "A" ? 2 : his_shape == "B" ? 3 : 1
        end
    end

    def transform(my_shape)
        case my_shape
        when "X"
            return "A"
        when "Y"
            return "B"
        when "Z"
            return "C"
        end
    end

    def comparaison

    end

end

puts Day2.new.first_puzzle
puts Day2.new.second_puzzle