class Map
  public
  def initialize(input)
    @map = input
  end

  def object_visibility
    @reference_i = 0
    @reference_j = 0
    loop do
      loop do
        unless @map[@reference_i][@reference_j] == '.'
          @map[@reference_i][@reference_j] = 0 if @map[@reference_i][@reference_j] == '#'
          p '------------------'
          p @map[@reference_i][@reference_j]
          check_row
          p @map[@reference_i][@reference_j] #1
          check_column
          p @map[@reference_i][@reference_j] #2
          check_right_diagonal
          p @map[@reference_i][@reference_j] #3
          check_left_diagonal
          p @map[@reference_i][@reference_j] #3
          check_right_lower_diagonals
          p @map[@reference_i][@reference_j]
          check_left_lower_diagonals
          p @map[@reference_i][@reference_j]
          check_right_upper_diagonals
          p @map[@reference_i][@reference_j]
          check_left_upper_diagonals
          p @map[@reference_i][@reference_j]
        end
        @reference_j += 1
        break if @reference_j >= @map[@reference_i].length
      end
      @reference_i += 1
      @reference_j = 0
      break if @reference_i >= @map.length
    end
    @map.each do |e| p e end
  end

  private
  def check_row
    i = @reference_i
    j = @reference_j + 1
    loop do
      break if j >= @map[@reference_i].length
      unless @map[i][j] == '.'
        @map[i][j] = 0 if @map[i][j] == '#'
        @map[@reference_i][@reference_j] += 1
        @map[i][j] += 1
        break
      end
      j += 1
    end
  end

  def check_column
    i = @reference_i + 1
    j = @reference_j
    loop do
      break if i >= @map.length
      unless @map[i][j] == '.'
        @map[i][j] = 0 if @map[i][j] == '#'
        @map[@reference_i][@reference_j] += 1
        @map[i][j] += 1
        break
      end
      i += 1
    end
  end

  def check_right_diagonal
    i = @reference_i + 1
    j = @reference_j + 1
    loop do
      break if i >= @map.length || j >= @map[@reference_i].length
      unless @map[i][j] == '.'
        @map[i][j] = 0 if @map[i][j] == '#'
        @map[@reference_i][@reference_j] += 1
        @map[i][j] += 1
        break
      end
      i += 1
      j += 1
    end
  end

  def check_left_diagonal
    i = @reference_i + 1
    j = @reference_j - 1
    loop do
      break if i >= @map.length || j < 0
      unless @map[i][j] == '.'
        @map[i][j] = 0 if @map[i][j] == '#'
        @map[@reference_i][@reference_j] += 1
        @map[i][j] += 1
        break
      end
      i += 1
      j -= 1
    end
  end

  def check_right_lower_diagonals
    increment = 2
    i = 0
    j = 0
    loop do
      i = @reference_i + 1
      j = @reference_j + increment
      loop do
        break if i >= @map.length || j >= @map[@reference_i].length
        unless @map[i][j] == '.'
          @map[i][j] = 0 if @map[i][j] == '#'
          @map[@reference_i][@reference_j] += 1
          @map[i][j] += 1
          break
        end
        i += 1
        j += increment
      end
      increment += 1
      break if @reference_j + increment >= @map[@reference_i].length
    end
  end

  def check_left_lower_diagonals
    decrease = 2
    i = 0
    j = 0
    loop do
      i = @reference_i + 1
      j = @reference_j - decrease
      loop do
        break if i >= @map.length || j < 0
        unless @map[i][j] == '.'
          @map[i][j] = 0 if @map[i][j] == '#'
          @map[@reference_i][@reference_j] += 1
          @map[i][j] += 1
          break
        end
        i += 1
        j -= decrease
      end
      decrease += 1
      break if @reference_j + decrease >= @map[@reference_i].length
    end
  end

  def check_right_upper_diagonals
    increment = 2
    i = 0
    j = 0
    loop do
      i = @reference_i + 1
      j = @reference_j + increment
      loop do
        break if i >= @map.length || j >= @map[@reference_i].length
        unless @map[i][j] == '.'
          @map[i][j] = 0 if @map[i][j] == '#'
          @map[@reference_i][@reference_j] += 1
          @map[i][j] += 1
          break
        end
        i += 1
        j += increment
      end
      increment += 1
      break if @reference_j + increment >= @map[@reference_i].length
    end
  end

  def check_left_upper_diagonals
    decrease = 2
    i = 0
    j = 0
    loop do
      i = @reference_i + 1
      j = @reference_j - decrease
      loop do
        break if i >= @map.length || j < 0
        unless @map[i][j] == '.'
          @map[i][j] = 0 if @map[i][j] == '#'
          @map[@reference_i][@reference_j] += 1
          @map[i][j] += 1
          break
        end
        i += 1
        j -= decrease
      end
      decrease += 1
      break if @reference_j + decrease >= @map[@reference_i].length
    end
  end
end

input = ".#..#
.....
#####
....#
...##"
input = input.split("\n")
input.map! do |e| e.split('') end

new_base = Map.new(input)
new_base.object_visibility