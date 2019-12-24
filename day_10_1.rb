class Map
  def initialize(input)
    @map = input
  end

  def base_location
    i1 = 0
    i2 = 0
    j1 = 0
    j2 = 0
    loop do
      loop do
        unless @array[i1][j1] == '.'
          @array[i1][j1] = 0 if @array[i1][j1] == '#'
          j2 = j1
          i2 = i1
        end
        break if j1 == @array[i1].length
        j1 += 1
      end
      break if i1 == @map.length
      i1 += 1
    end
  end
end

input = "......#.#.
#..#.#....
..#######.
.#.#.###..
.#..#.....
..#....#.#
#..#....#.
.##.#..###
##...#..#.
.#....####"
input = input.split("\n")
input.map! do |e| e.split('') end
p input[1][2]