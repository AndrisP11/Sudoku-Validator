class Validator
  def initialize(puzzle_string)
    @puzzle_string = puzzle_string
  end

  def self.validate(puzzle_string)
    new(puzzle_string).validate
  end

  def validate
   onlyCharacters = @puzzle_string.gsub(/[|\n+\s-]/, "")
   
    # check if there are more or less than 81 characters
    if onlyCharacters.size > 81 || onlyCharacters.size < 81
      return "Sudoku is invalid."
    end

    grid = onlyCharacters.chars.map(&:to_i).each_slice(9).to_a

    columns = grid.transpose

    grid_new = [[grid[0][0], grid[0][1], grid[0][2], grid[1][0], grid[1][1], grid[1][2], grid[2][0], grid[2][1], grid[2][2]],
    [grid[0][3], grid[0][4], grid[0][5], grid[1][3], grid[1][4], grid[1][5], grid[2][3], grid[2][4], grid[2][5]],
    [grid[0][6], grid[0][7], grid[0][8], grid[1][6], grid[1][7], grid[1][8], grid[2][6], grid[2][7], grid[2][8]],
    [grid[3][0], grid[3][1], grid[3][2], grid[4][0], grid[4][1], grid[4][2], grid[5][0], grid[5][1], grid[5][2]],
    [grid[3][3], grid[3][4], grid[3][5], grid[4][3], grid[4][4], grid[4][5], grid[5][3], grid[5][4], grid[5][5]],
    [grid[3][6], grid[3][7], grid[3][8], grid[4][6], grid[4][7], grid[4][8], grid[5][6], grid[5][7], grid[5][8]],
    [grid[6][0], grid[6][1], grid[6][2], grid[7][0], grid[7][1], grid[7][2], grid[8][0], grid[8][1], grid[8][2]],
    [grid[6][3], grid[6][4], grid[6][5], grid[7][3], grid[7][4], grid[7][5], grid[8][3], grid[8][4], grid[8][5]],
    [grid[6][6], grid[6][7], grid[6][8], grid[7][6], grid[7][7], grid[7][8], grid[8][6], grid[8][7], grid[8][8]]]

    # check if the grid is 9x9 and that it is filled only with numbers 0 to 9
    if  grid.size != 9 || grid[0].size != 9 || !grid.flatten.any? { |i| (0..9).include? i }
        return "Sudoku is invalid."
    end

    # check if the rows don't have duplicate numbers
    if grid.any? { |grid| (grid - [0]).uniq.size != (9 - grid.count(0)) }
      return "Sudoku is invalid."
    end

   # check if the columns don't have duplicate numbers
    if columns.any? { |row| (row - [0]).uniq.size != (9 - row.count(0)) }
       return "Sudoku is invalid."
    end
    
    # check if the squares don't have duplicate numbers
    if grid_new.any? { |grid_new| (grid_new - [0]).uniq.size != (9 - grid_new.count(0)) }
      return "Sudoku is invalid."
    end

    # check if the grid can be completed
    if grid.flatten.include? 0
        return "Sudoku is valid but incomplete."
    else
        return "Sudoku is valid."
    end
  end
end
