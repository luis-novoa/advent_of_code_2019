class Computer
  public
  attr_accessor :array

  def initialize(array)
    @array = array
  end

  def program(*input)
    @used_input = 0 if @used_input.nil?
    @i = 0 if @i.nil?
    @relative_base = 0 if @relative_base.nil?
    @break = "no"
    loop do
      # p @i
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
    @modes.map! do |e|
      selected = 0
      case e
      when "1"
        e = @array[@i + j]

      when "2"
        selected = rotator(@relative_base + @array[@i + j])
        e = @array[selected]

      else
        selected = rotator(@array[@i + j])
        e = @array[selected]
      end
      j += 1
      e
    end
  end

  def rotator(index)
    new_index = index
    length = @array.length.clone
    loop do
      p length if new_index < 0 #Note: this calculates negative numbers, but it shouldn't.
      break if new_index < length
      # p 'what' if new_index < 0
      new_index -= length
    end
    new_index
  end

  def execute(array_of_modes, input)
    selected_3 = rotator(@array[@i + 3])
    # p @array
    # p @array[@i]
    # p array_of_modes
    @break = 'yes' if @array[4] == 218
    case @op
    when 1
      @array[selected_3] = array_of_modes[0] + array_of_modes[1]
      @i += 4
      # @break = 'yes'

    when 2
      @array[selected_3] = array_of_modes[0] * array_of_modes[1]
      @i += 4

    when 3
      selected_1 = rotator(@array[@i + 1])
      @array[selected_1] = input[0] if @used_input == 0
      @array[selected_1] = input[1] if @used_input > 0
      @used_input += 1
      @i += 2

    when 4
      @i += 2
      @output = array_of_modes[0]
      p @output
      # @break = "yes" if @output == 204

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
        @array[selected_3] = 1
      else
        @array[selected_3] = 0
      end
      @i += 4

    when 8
      if array_of_modes[0] == array_of_modes[1]
        @array[selected_3] = 1
      else
        @array[selected_3] = 0
      end
      @i += 4

    when 9
      # p @array
      # p @i
      # p @array[@i]
      # p array_of_modes
      # @break = 'yes' if array_of_modes[0].zero?
      @relative_base += array_of_modes[0]
      @i += 2
      # p @array


    when 99
      # @output = "finished"
      @break = "yes"

    end
  end
end

# input = File.read("inputs/day9.txt").chomp.split(',')
# new_intcode = Computer.new(input)
new_intcode = Computer.new([109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99])
# new_intcode = Computer.new([1102,34915192,34915192,7,4,7,99,0]) #works
# new_intcode = Computer.new([104,1125899906842624,99]) #works
new_intcode.program