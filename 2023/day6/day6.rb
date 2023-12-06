require 'benchmark'
class Day6

    
    def initialize
        time_str, dist_str = File.read("input.txt").split("\n")
        times = time_str.scan(/\d+/)
        dists = dist_str.scan(/\d+/)
        @races = compute_races(times, dists)
        @last_race = Race.new(times.join.to_i, dists.join.to_i)
    end

    def compute_races(times, dists)
        times = times.map(&:to_i)
        dists = dists.map(&:to_i)
        races = []
        times.each_with_index do | t, i |
            r = Race.new(t, dists[i])
            races << r
        end
        races
    end

    def first_puzzle
        num_win = []
        @races.each do |r|
            num_win << run(r)
        end
        num_win.inject(:*)
    end

    def second_puzzle
        run(@last_race)
    end

    def run(r)
        res = 0
        (0..r.time).each do |run|
            dist_run = run * (r.time - run)
            if dist_run > r.dist
                res = ((r.time + 1) - (run * 2))
                break
            end
        end
        res
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