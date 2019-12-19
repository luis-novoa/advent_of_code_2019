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
      # p @i
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
    # p @op
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
    # p @op
    case @op
    when 1
      # p @array
      # p array_of_modes
      @array[@array[@i + 3]] = array_of_modes[0] + array_of_modes[1]
      @i += 4
      # p @array
      # p '======================='


    when 2
      # p @array
      # p array_of_modes
      @array[@array[@i + 3]] = array_of_modes[0] * array_of_modes[1]
      @i += 4
      # p @array
      # p '======================='


    when 3
      # p @array
      # p array_of_modes
      @array[@array[@i + 1]] = pass_input1 if @used_input == 0
      @array[@array[@i + 1]] = pass_input2 if @used_input == 1
      @used_input += 1
      @i += 2
      # p @array
      # p '======================='
      # p @i


    when 4
      # p @array
      # p array_of_modes
      @i += 2
      @output = array_of_modes[0]
      @break = "yes"
      # p @array
      # p '======================='


    when 5
      # p @array
      # p array_of_modes
      unless array_of_modes[0].zero?
        @i = array_of_modes[1]
      else
        @i += 3
      end
      # p @array
      # p '======================='


    when 6
      # p @array
      # p array_of_modes
      if array_of_modes[0].zero?
        @i = array_of_modes[1]
      else
        @i += 3
      end
      # p @array
      # p '======================='


    when 7
      # p @array
      # p array_of_modes
      if array_of_modes[0] < array_of_modes[1]
        @array[@array[@i + 3]] = 1
      else
        @array[@array[@i + 3]] = 0
      end
      @i += 4
      # p @array
      # p '======================='


    when 8
      # p @array
      # p array_of_modes
      if array_of_modes[0] == array_of_modes[1]
        @array[@array[@i + 3]] = 1
      else
        @array[@array[@i + 3]] = 0
      end
      @i += 4
      # p @array
      # p '======================='


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
# counter = 0
settings.each_with_index do |combination, index|
  # break if counter == 1
  # p combination
  amp_a = Computer.new(amp_software.clone)
  amp_b = Computer.new(amp_software.clone)
  amp_c = Computer.new(amp_software.clone)
  amp_d = Computer.new(amp_software.clone)
  amp_e = Computer.new(amp_software.clone)
  output = 0
  loop do
    # p "a"
    last_output_a = amp_a.program(combination[0], output) unless last_output_a == "finished"
    output = last_output_a unless last_output_a == "finished"
    # p output
    # p last_output_a
    # break if counter == 0
    # p 'b'
    last_output_b = amp_b.program(combination[1], output) unless last_output_b == "finished"
    output = last_output_b unless last_output_b == "finished"
    # p output
    # p last_output_b
    # p 'c'
    last_output_c = amp_c.program(combination[2], output) unless last_output_c == "finished"
    output = last_output_c unless last_output_c == "finished"
    # p output
    # p last_output_c
    # p 'd'
    last_output_d = amp_d.program(combination[3], output) unless last_output_d == "finished"
    output = last_output_d unless last_output_d == "finished"
    # p output
    # p last_output_d
    # p 'e'
    last_output_e = amp_e.program(combination[4], output) unless last_output_e == "finished"
    # counter += 1
    break if last_output_a == "finished" && last_output_b == "finished" && last_output_c == "finished" && last_output_d == "finished" && last_output_e == "finished"
    output = last_output_e unless last_output_e == "finished"
    # p output
    break if output == 21
    # p last_output_e
  end
  # counter += 1
  p output
  outputs[output] = index
  p outputs
end

p outputs.max