require 'benchmark'
class Day6

    
    def initialize
        time_str, dist_str = File.read("input.txt").split("\n")
        @races = compute_races(time_str, dist_str)
        @last_race = Race.new(time_str.scan(/\d+/).join.to_i, dist_str.scan(/\d+/).join.to_i)
    end

    def compute_races(time_str, dist_str)
        times = time_str.scan(/\d+/).map(&:to_i)
        dist = dist_str.scan(/\d+/).map(&:to_i)
        races = []
        times.each_with_index do | t, i |
            r = Race.new(t, dist[i])
            races << r
        end
        races
    end

    def first_puzzle
        num_win = []
        @races.each do |r|
            (0..r.time).each do |run|
                dist_run = run * (r.time - run)
                if dist_run > r.dist
                    num_win << ((r.time + 1) - (run * 2))
                    break
                end
            end
        end
        num_win.inject(:*)
    end

    def second_puzzle
        num_win = 0
        r = @last_race
        (0..r.time).each do |run|
            dist_run = run * (r.time - run)
            if dist_run > r.dist
                num_win = ((r.time + 1) - (run * 2))
                break
            end
        end
        num_win
    end
end

class Race
    attr_accessor :time, :dist

    def initialize(time, dist)
        self.time = time
        self.dist = dist
    end
end

duration = Benchmark.realtime do 
    d = Day6.new
    puts d.first_puzzle
    puts d.second_puzzle
end
puts duration * 1000