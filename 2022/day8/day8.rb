class Tree
    attr_accessor :row, :column, :visible, :height, :score

    def initialize(row, column, height)
        self.row = row
        self.column = column
        self.height = height
        self.visible = false
        self.score = 0
    end
end


class Day8

    attr_accessor :rows, :columns, :coor_hash, :trees
    
    def initialize
        self.rows = File.read("input.txt").split("\n")
        self.trees = []
        self.columns = compute_columns
        compute_grid
    end

    def compute_columns
        cols = []
        (0..(rows.first.size - 1)).each do |i|
            cols[i] = rows.map{|r| r[i]}.join()
        end
        cols
    end

    def compute_grid
        rows.each_with_index do |r, i|
            r.chars.each_with_index do |c, j|
                trees << Tree.new(i,j, c.to_i)
            end
        end
        hash
    end

    def tree_is_visible?(tree)
        visible = compare_string_to_height(all_tree_above(tree), tree.height) || compare_string_to_height(all_tree_bellow(tree), tree.height) || compare_string_to_height(all_tree_right(tree), tree.height) || compare_string_to_height(all_tree_left(tree), tree.height)
        tree.visible = visible
    end

    def compare_string_to_height(str, height)
        heights = str.chars.map(&:to_i)
        has_higher_tree = heights.detect{|h| h >= height}
        return false if has_higher_tree
        true
    end

    def all_tree_above(tree)
        col_index = tree.column
        index = tree.row
        col = columns[col_index]
        str = col[0,index]
    end

    def all_tree_bellow(tree)
        col_index = tree.column
        index = tree.row
        col = columns[col_index]
        str = col[index +1 ,col.size]
    end

    def all_tree_right(tree)
        index = tree.column
        row_index = tree.row
        row = rows[row_index]
        str = row[index +1 ,row.size]
    end

    def all_tree_left(tree)
        index = tree.column
        row_index = tree.row
        row = rows[row_index]
        str = row[0,index]
    end

    def first_puzzle
        trees.map{|t| tree_is_visible?(t)}
        puts trees.select{|t| t.visible }.count
    end

    def get_trees_visible(str, height)
        tree_index = 0
        arr = str.chars.map(&:to_i)
        first_taller_tree = arr.detect{|c| c >= height}
        if first_taller_tree.nil?
            tree_index = str.size
        else
            tree_index = arr.index(first_taller_tree) + 1
        end
        tree_index
    end

    def compute_tree_score(tree)
        height = tree.height
        top = get_trees_visible(all_tree_above(tree).reverse, height)
        down = get_trees_visible(all_tree_bellow(tree), height)
        right = get_trees_visible(all_tree_right(tree), height)
        left = get_trees_visible(all_tree_left(tree).reverse, height)
        tree.score = (top * down * right * left)
    end

    def second_puzzle
        trees.map{|t| compute_tree_score(t)}
        puts trees.map{|t| t.score }.max
    end
end

day8 = Day8.new
day8.first_puzzle
day8.second_puzzle
