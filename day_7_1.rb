class Computer
  public
  attr_reader :array

  def initialize(array)
    @array = array
  end

  def program(input1, input2)
    @used_input = 0
    @i = 0
    @break = "no"
    loop do
      modes(@array[@i])
      operation(@array[@i])
      execute(@modes, input1, input2)
      if @break == "yes"
        return @output
      end
    end
  end

  private
  def operation(element)
    element = element.to_s
    op = element[-2]
    op ||= element[-1]
    op << element[-1] unless element[-2].nil?
    op = op.to_i
    @array[@i] = op
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
      @array[@i + j] ||= 0
      if e.to_i.zero?
        e = @array[@array[@i + j]]
      else
        e = @array[@i + j]
      end
      j += 1
      e
    end
  end

  def execute(array_of_modes, pass_input1, pass_input2)
    case @array[@i]
    when 1
      @array[@array[@i + 3]] = array_of_modes[0] + array_of_modes[1]
      @i += 4

    when 2
      @array[@array[@i + 3]] = array_of_modes[0] * array_of_modes[1]
      @i += 4

    when 3
      @array[@array[@i + 1]] = pass_input1 if @used_input == 0
      @array[@array[@i + 1]] = pass_input2 if @used_input == 1
      @used_input +=1
      @i += 2

    when 4
      @i += 2
      @output = array_of_modes[0]

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
        @array[@array[@i + 3]] = 1
      else
        @array[@array[@i + 3]] = 0
      end
      @i += 4

    when 8
      if array_of_modes[0] == array_of_modes[1]
        @array[@array[@i + 3]] = 1
      else
        @array[@array[@i + 3]] = 0
      end
      @i += 4

    when 99
      @break = "yes"

    end
  end
end

settings = (0..4).to_a.permutation.to_a
outputs = Hash.new
settings.each_with_index do |combination, index|
  sum = 0
  combination.each do |order|
    santas_computer = Computer.new([3,15,3,16,1002,16,10,16,1,16,15,15,4,15,99,0,0])
    sum += santas_computer.program(order, sum)
  end
  outputs[index] = sum
end

p outputs