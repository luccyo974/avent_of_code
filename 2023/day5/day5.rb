require 'benchmark'
class Day5

    TYPE_ORDER = [
        "seed-to-soil",
        "soil-to-fertilizer",
        "fertilizer-to-water",
        "water-to-light",
        "light-to-temperature",
        "temperature-to-humidity",
        "humidity-to-location"
    ]
    
    def initialize
        #seed_str, *@lines = File.read("input.txt").split("\n\n")
        @lines = File.read("input.txt").split("\n\n")
        @type_converts = []
        init_map_data
    end

    def init_map_data
        @lines.each do |l|
            next if !l.match(/(seeds:)/).nil?
            data = l.split("\n")
            tc = TypeConvert.new(data.first)
            data.each do |d|
                next if d.match(/(map:)/)
                values = d.split(" ").map(&:to_i)
                map = MapData.new(values[0], values[1], values[2])
                tc.map_datas << map
            end
            @type_converts << tc
        end
    end

    def first_puzzle
        @seeds = @lines.first.scan(/\d+/).map(&:to_i)
        seed_locations = {}
        @seeds.each do |s|
            source = s
            seed_locations[s] = s
            TYPE_ORDER.each do |type|
                tc = @type_converts.detect{|md| type == md.type}
                md = tc.map_datas.detect{|d| source>=d.s_start && source<= d.s_end}
                unless md.nil?
                    source = md.d_start + (source-md.s_start)
                    seed_locations[s] = source
                end
            end
        end
        seed_locations.values.min
    end

    def second_puzzle
        @seeds = []
        compute_second_seeds()
        seed_locations = {}
        @seeds.each do |range|
            range.each do |s|
                source = s
                seed_locations[s] = s
                TYPE_ORDER.each do |type|
                    tc = @type_converts.detect{|md| type == md.type}
                    md = tc.map_datas.detect{|d| source>=d.s_start && source<= d.s_end}
                    unless md.nil?
                        source = md.d_start + (source-md.s_start)
                        seed_locations[s] = source
                    end
                end
            end
        end
        seed_locations.values.min
    end

    def compute_second_seeds
        numbers = @lines.first.scan(/\d+/).map(&:to_i)
        @seeds <<  numbers.each_slice(2).to_a
    end

end

class TypeConvert
    attr_accessor :type, :map_datas

    def initialize(type_data)
        self.type = type_data.split(" ").first
        self.map_datas = []
    end
end

class MapData
    attr_accessor :s_start, :s_end, :d_start, :range

    def initialize(d_start, s_start, range)
        self.s_start = s_start
        self.s_end = s_start + (range - 1)
        self.d_start = d_start
        self.range = range
    end
end

duration = Benchmark.realtime do 
    d = Day5.new
    puts d.first_puzzle
    #puts d.second_puzzle
end
puts duration * 1000