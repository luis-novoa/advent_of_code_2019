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
      # p @array
      # p '1'
      modes(@array[@i])
      # p '2'
      operation(@array[@i])
      # p '3'
      execute(@modes, input)
      # p '4'
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
    # p '================='
    # p @i
    # p @modes
    # p element
    @modes[-1] = '' 
    @modes[-1] = '' unless @modes == ''
    # p @modes
    @modes = @modes.split('').reverse
    @modes[0] ||= 0
    @modes[1] ||= 0
    @modes[2] ||= 0
    # p @modes
    j = 1
    @modes.map! do |e|
      # p @modes
      e = e.to_i
      selected = 0
      # p e
      case e
      when 1
        # p 'case 1'
        e = @array[@i + j]

      when 2
        # p @relative_base
        # p @array[@i+j]
        # p @i
        # p 'case 2'
        selected = rotator(@relative_base + @array[@i + j])
        e = @array[selected]

      else
        # p 'case 3.1'
        selected = rotator(@array[@i + j])
        e = @array[selected]
      end
      j += 1
      # p e
      # p @modes
      e
    end
  end

  def rotator(index)
    index ||= 0
    new_index = index % @array.length
    # p new_index
    new_index
  end

  def execute(array_of_modes, input)
    selected_3 = rotator(@array[@i + 3])
    p '=================='
    p @array
    p @array[@i]
    p array_of_modes
    # p selected_3
    @break = 'yes' if @array[@i] == 16 # @array[4] == 218
    # p @op
    # p @modes
    # p @i
    case @op
    when 1
      @array[selected_3] = array_of_modes[0] + array_of_modes[1]
      @i += 4
      # @break = 'yes'
      
    when 2
      @array[selected_3] = array_of_modes[0] * array_of_modes[1]
      # p @array[selected_3]
      # p @array
      @i += 4

    when 3
      selected_1 = rotator(@array[@i + 1])
      @array[selected_1] = input[0] if @used_input == 0
      @array[selected_1] = input[1] if @used_input > 0
      @used_input += 1
      @i += 2

    when 4
      @output = array_of_modes[0]
      p @output
      @i += 2
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
new_intcode.program(1)