class Computer
  public
  attr_reader :array

  def initialize(array)
    @array = array
  end

  def program(input1, input2)
    @used_input = 0
    @i = 0 if @i.nil?
    p @i
    p @array
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
    # p @i
    # p @array
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
      @break = "yes"

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
      @output = "finished"
      @break = "yes"

    end
  end
end

settings = (5..9).to_a.permutation.to_a
outputs = Hash.new
amp_software = [3,26,1001,26,-4,26,3,27,1002,27,2,27,1,27,26,
27,4,27,1001,28,-1,28,1005,28,6,99,0,0,5]
settings.each_with_index do |combination, index|
  amp_a = Computer.new(amp_software)
  amp_b = Computer.new(amp_software)
  amp_c = Computer.new(amp_software)
  amp_d = Computer.new(amp_software)
  amp_e = Computer.new(amp_software)
  output = 0
  output_a = amp_a.program(combination[0], 0)
  loop do
    # p output_a
    p "a"
    output_b = amp_b.program(combination[1], output_a)
    p 'b'
    # p output_b
    output_c = amp_c.program(combination[2], output_b)
    p 'c'
    # p output_c
    output_d = amp_d.program(combination[3], output_c)
    p 'd'
    # p output_d
    output_e = amp_e.program(combination[4], output_d)
    p 'e'
    # p output_e
    if output_a == "finished" && output_b == "finished" && output_c == "finished" && output_d == "finished"
      output = output_e
      break
    else
      output_a = amp_a.program(combination[0], output_e)
    end
  end
  outputs[output] = index
end

p outputs.max

[3, 26, 1, 26, -4, 26, 3, 27, 2, 27, 2, 27, 1, 27, 26, 27, 4, 27, 1, 28, -1, 28, 5, 28, 6, 99, 108, 113, 4]