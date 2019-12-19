class Computer
  public
  attr_reader :array

  def initialize(array)
    @array = array
  end

  def program(input1, input2)
    # p @i
    # p @array
    @used_input = 0
    @i = 0 if @i.nil?
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
      @array[@i + j] ||= 0
      if e.to_i.zero?
        e = @array[@array[@i + j]].clone
      else
        e = @array[@i + j].clone
      end
      j += 1
      e
    end
  end

  def execute(array_of_modes, pass_input1, pass_input2)
    # p @i
    # p @array
    case @op
    when 1
      p array_of_modes
      @array[@array[@i + 3]] = array_of_modes[0] + array_of_modes[1]
      @i += 4
      p @array


    when 2
      p array_of_modes
      @array[@array[@i + 3]] = array_of_modes[0] * array_of_modes[1]
      @i += 4
      p @array


    when 3
      p array_of_modes
      @array[@array[@i + 1]] = pass_input1 if @used_input == 0
      @array[@array[@i + 1]] = pass_input2 if @used_input == 1
      @used_input +=1
      @i += 2
      p @array


    when 4
      p array_of_modes
      @i += 2
      @output = array_of_modes[0]
      @break = "yes"
      p @array


    when 5
      p array_of_modes
      unless array_of_modes[0].zero?
        @i = array_of_modes[1]
      else
        @i += 3
      end
      p @array


    when 6
      p array_of_modes
      if array_of_modes[0].zero?
        @i = array_of_modes[1]
      else
        @i += 3
      end
      p @array


    when 7
      p array_of_modes
      if array_of_modes[0] < array_of_modes[1]
        @array[@array[@i + 3]] = 1
      else
        @array[@array[@i + 3]] = 0
      end
      @i += 4
      p @array


    when 8
      p array_of_modes
      if array_of_modes[0] == array_of_modes[1]
        @array[@array[@i + 3]] = 1
      else
        @array[@array[@i + 3]] = 0
      end
      @i += 4
      p @array


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
  last_output = 0
  output = 0
  loop do
    last_output = amp_a.program(combination[0], output)
    output = last_output unless last_output == "finished"
    # p output
    p "a"
    last_output = amp_b.program(combination[1], output)
    output = last_output unless last_output == "finished"
    p 'b'
    # p output
    last_output = amp_c.program(combination[2], output)
    output = last_output unless last_output == "finished"
    p 'c'
    # p output
    last_output = amp_d.program(combination[3], output)
    output = last_output unless last_output == "finished"
    p 'd'
    # p output
    last_output = amp_e.program(combination[4], output)
    break if last_output == "finished"
    output = last_output
    p 'e'
    p output
  end
  outputs[output] = index
end

p outputs.max