
class Dir
    attr_accessor :files, :folders, :name, :path, :parent

    def initialize(name, path, parent=nil)
        self.name = name
        self.path = path
        self.parent = parent
        self.files = []
        self.folders = []
    end

    def folder_size
        file_size = self.files.sum(&:size)
        child_dir_size = self.folders.map(&:folder_size).sum
        file_size + child_dir_size
    end
end

class Fil
    attr_accessor :size, :name

    def initialize(name, size)
        self.name = name
        self.size = size.to_i
    end
end

class Day7
    attr_accessor :root_folder, :lines, :current_path, :flat_hash, :dir_count

    def initialize
        self.lines = File.read("input.txt").split("\n")
        self.dir_count = 0
        self.flat_hash = {}
        self.root_folder = compute_folder_tree
        compute_flat_hash
    end

    def compute_folder_tree
        root_dir = Dir.new("root", "")
        self.dir_count = 1
        current_dir = root_dir
        lines.each do |line|
            next if line == "$ ls" || line == "$ cd /"
            line_split = line.split(" ")
            if line_split[0] == "$"
                if line_split[1] == "cd"
                    current_dir = line_split[2] == ".." ? back_one_folder(current_dir) : down_one_folder(current_dir, line_split[2])
                end
            elsif line_split[0] == "dir"
                self.dir_count += 1
                f = Dir.new(line_split[1], "#{current_dir.path}/#{line_split[1]}", current_dir)
                current_dir.folders << f
            else
                file = Fil.new(line_split[1], line_split[0])
                current_dir.files << file
            end
        end
        root_dir
    end

    def back_one_folder(current)
        return current.parent
    end

    def down_one_folder(current, name)
        new_path = "#{current.path}/#{name}"
        current.folders.select{|f| f.path == new_path}.first
    end

    def compute_folder_size(folder)
        flat_hash[folder.path] = folder.folder_size
        folder.folders.each do |f|
            compute_folder_size(f)
        end
    end

    def compute_flat_hash
        flat_hash["root"] = self.root_folder.folder_size
        folders = self.root_folder.folders
        folders.each do |f|
            compute_folder_size(f)
        end
    end

    def first_puzzle
        #puts self.root_folder.folder_size
        puts flat_hash.values.select{|v| v <= 100000}.sum
    end

    def second_puzzle
        size_to_delete = 30000000 - (70000000 - self.root_folder.folder_size)
        #puts size_to_delete
        arr = flat_hash.values.select{|v| v > size_to_delete}
        puts arr.sort.first
    end
end


day7 = Day7.new
day7.first_puzzle
day7.second_puzzle
