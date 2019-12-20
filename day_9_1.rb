class Computer
  public
  attr_accessor :array

  def initialize(array)
    @array = array
  end

  def program(input1, input2)
    @used_input = 0 if @used_input.nil?
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
        e = @array[@array[@i + j]]
      else
        e = @array[@i + j]
      end
      j += 1
      e
    end
  end

  def execute(array_of_modes, pass_input1, pass_input2)
    case @op
    when 1
      @array[@array[@i + 3]] = array_of_modes[0] + array_of_modes[1]
      @i += 4


    when 2
      @array[@array[@i + 3]] = array_of_modes[0] * array_of_modes[1]
      @i += 4


    when 3
      @array[@array[@i + 1]] = pass_input1 if @used_input == 0
      @array[@array[@i + 1]] = pass_input2 if @used_input > 0
      @used_input += 1
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
amp_software = [3,8,1001,8,10,8,105,1,0,0,21,38,55,64,81,106,187,268,349,430,99999,3,9,101,2,9,9,1002,9,2,9,101,5,9,9,4,9,99,3,9,102,2,9,9,101,3,9,9,1002,9,4,9,4,9,99,3,9,102,2,9,9,4,9,99,3,9,1002,9,5,9,1001,9,4,9,102,4,9,9,4,9,99,3,9,102,2,9,9,1001,9,5,9,102,3,9,9,1001,9,4,9,102,5,9,9,4,9,99,3,9,1002,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,101,1,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,1001,9,2,9,4,9,3,9,101,1,9,9,4,9,3,9,1001,9,1,9,4,9,99,3,9,1002,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,1,9,9,4,9,3,9,101,2,9,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,1,9,9,4,9,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,99,3,9,1002,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,101,1,9,9,4,9,99,3,9,102,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,3,9,101,1,9,9,4,9,3,9,101,1,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,102,2,9,9,4,9,99,3,9,101,1,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,1,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,1,9,9,4,9,3,9,102,2,9,9,4,9,99]
settings.each_with_index do |combination, index|
  amp_a = Computer.new(amp_software.clone)
  amp_b = Computer.new(amp_software.clone)
  amp_c = Computer.new(amp_software.clone)
  amp_d = Computer.new(amp_software.clone)
  amp_e = Computer.new(amp_software.clone)
  output = 0
  loop do
    last_output_a = amp_a.program(combination[0], output) unless last_output_a == "finished"
    output = last_output_a unless last_output_a == "finished"
    last_output_b = amp_b.program(combination[1], output) unless last_output_b == "finished"
    output = last_output_b unless last_output_b == "finished"
    last_output_c = amp_c.program(combination[2], output) unless last_output_c == "finished"
    output = last_output_c unless last_output_c == "finished"
    last_output_d = amp_d.program(combination[3], output) unless last_output_d == "finished"
    output = last_output_d unless last_output_d == "finished"
    last_output_e = amp_e.program(combination[4], output) unless last_output_e == "finished"
    break if last_output_a == "finished" && last_output_b == "finished" && last_output_c == "finished" && last_output_d == "finished" && last_output_e == "finished"
    output = last_output_e unless last_output_e == "finished"
  end
  outputs[output] = index
end

p outputs.max