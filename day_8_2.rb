class String
  def black; "\e[30m#{self}\e[0m" end
  def red; "\e[31m#{self}\e[0m" end
  def green; "\e[32m#{self}\e[0m" end
  def brown; "\e[33m#{self}\e[0m" end
  def blue; "\e[34m#{self}\e[0m" end
  def magenta; "\e[35m#{self}\e[0m" end
  def cyan; "\e[36m#{self}\e[0m" end
  def gray; "\e[37m#{self}\e[0m" end
  def bg_black; "\e[40m#{self}\e[0m" end
  def bg_red; "\e[41m#{self}\e[0m" end
  def bg_green; "\e[42m#{self}\e[0m" end
  def bg_brown; "\e[43m#{self}\e[0m" end
  def bg_blue; "\e[44m#{self}\e[0m" end
  def bg_magenta; "\e[45m#{self}\e[0m" end
  def bg_cyan; "\e[46m#{self}\e[0m" end
  def bg_gray; "\e[47m#{self}\e[0m" end
  def blink; "\e[5m#{self}\e[25m" end
end

class Image
  def initialize(array)
    @array = array
  end

  def img_processor(length, height)
    @layers = []
    @array.each_slice(length*height) do |layer|
      @layers.push(layer)
    end
    final_img = @layers[0]
    @layers.each do |layer|
      layer.each_with_index do |element, index|
        if final_img[index] == '2'
          final_img[index] = element
        end
      end
    end
    final_img.each_slice(length) do |row|
      row.each do |element|
        case element
        when '0'
          print element.red.bg_red

        when '1'
          print element.green.bg_green

        when '2'
          print element.black.bg_black

        end
      end
      print "\n"
    end
  end
end

input = File.read("inputs/day8.txt").chomp
input = input.split('')
mars_img = Image.new(input)
mars_img.img_processor(25, 6)