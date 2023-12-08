require 'benchmark'

class Day8
    
    attr_accessor :intstructions, :nodes
    
    def initialize
        self.intstructions, space, *raw_nodes = File.read("input.txt").split("\n")
        self.nodes = compute_nodes(raw_nodes)
    end
    
    def first_puzzle
        node = self.nodes["AAA"]
        steps = process_dirs(node)
    end

    def process_dirs(node)
        step = 0
        self.intstructions.each_char.with_index(1) do |dir, i|
            step += 1
            if dir == "L"
                break if node.first == "ZZZ"
                node = self.nodes[node.first]
            else
                break if node.last == "ZZZ"
                node = self.nodes[node.last]
            end
            step += process_dirs(node) if i == self.intstructions.length
        end
        step
    end
    
    def second_puzzle
        nodes_a = self.nodes.select{|k,v| k.end_with?("A")}
        steps = process_dirs_part_2(nodes_a)
    end

    def process_dirs_part_2(nodes_a)

        step_for_first_z = []
        nodes_a.each do |k,v|

            step = 0
            found_z = nil

            dirs = self.intstructions.chars
            steps = []

            while true
                while step == 0 || !k.end_with?("Z")
                    step += 1
                    if dirs[0] == "L"
                        k = self.nodes[k].first
                    else
                        k = self.nodes[k].last
                    end
                    dirs = dirs.rotate(1)
                end

                steps << step

                if found_z.nil?
                    found_z = k
                    step = 0
                elsif found_z == k
                    break
                end
            end
            step_for_first_z << steps
        end

        res = step_for_first_z.map(&:first)
        res.reduce(&:lcm)
        
    end
    
    def compute_nodes(raw_nodes)
        nodes = {}
        raw_nodes.each do |l|
            key, left, right = l.scan(/[A-Z0-9]{3}/)
            nodes[key] = [left, right]
        end
        nodes
    end
    
end

duration = Benchmark.realtime do 
    d = Day8.new
    puts d.first_puzzle
    puts d.second_puzzle
end
puts duration * 1000