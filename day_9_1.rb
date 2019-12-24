class Computer
  public
  attr_accessor :array

  def initialize(array)
    @array = array
    @array.map! do |e| e.to_i end
  end

  def program(*input)
    @used_input = 0 if @used_input.nil?
    @i = 0 if @i.nil?
    @relative_base = 0 if @relative_base.nil?
    @break = "no"
    loop do
      modes(@array[@i])
      operation(@array[@i])
      execute(@modes, input)
      if @break == "yes"
        return @output
      end
    end
  end

  private
  def operation(element)
    element = element.to_s
    @op = element[-2]
    @op ||= element[-1]
    @op << element[-1] unless element[-2].nil?
    @op = @op.to_i
  end

  def modes(element)
    @modes = element.to_s
    @modes[-1] = '' 
    @modes[-1] = '' unless @modes == ''
    @modes = @modes.split('').reverse
    @modes[0] ||= 0
    @modes[1] ||= 0
    @modes[2] ||= 0
    j = 1
    @target_index = []
    @modes.map! do |e|
      e = e.to_i
      selected = 0
      case e
      when 1
        expansor(@i + j)
        @target_index.push('N/A')
        e = @array[@i + j]

      when 2
        expansor(@relative_base + @array[@i + j])
        @target_index.push(@relative_base + @array[@i + j])
        e = @array[@relative_base + @array[@i + j]]

      else
        expansor(@array[@i + j])
        @target_index.push(@array[@i + j])
        e = @array[@array[@i + j]]
      end
      j += 1
      e
    end
  end

  def expansor(index)
    loop do
      break if index <= @array.length
      @array.push(0)
    end
  end

  def execute(array_of_modes, input)
    case @op
    when 1
      @array[@target_index[2]] = array_of_modes[0] + array_of_modes[1]
      @i += 4
      
    when 2
      @array[@target_index[2]] = array_of_modes[0] * array_of_modes[1]
      @i += 4

    when 3
      @array[@target_index[0]] = input[0] if @used_input == 0
      @array[@target_index[0]] = input[1] if @used_input > 0
      @used_input += 1
      @i += 2

    when 4
      @output = array_of_modes[0]
      p @output
      @i += 2

    when 5
      unless array_of_modes[0].zero?
        @i = array_of_modes[1]
      else
        @i += 3
      end

    when 6
      if array_of_modes[0].zero?
        @i = array_of_modes[1]
      else
        @i += 3
      end

    when 7
      if array_of_modes[0] < array_of_modes[1]
        @array[@target_index[2]] = 1
      else
        @array[@target_index[2]] = 0
      end
      @i += 4

    when 8
      if array_of_modes[0] == array_of_modes[1]
        @array[@target_index[2]] = 1
      else
        @array[@target_index[2]] = 0
      end
      @i += 4

    when 9
      @relative_base += array_of_modes[0]
      @i += 2


    when 99
      @break = "yes"

    end
  end
end

input = File.read("inputs/day9.txt").chomp.split(',')
new_intcode = Computer.new(input)
new_intcode.program(1)