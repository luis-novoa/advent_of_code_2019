class Image
  def initialize(array)
    @array = array
  end

  def img_processor(length, height)
    @layers = []
    @array.each_slice(length*height) do |layer|
      @layers.push(layer)
    end
    zero_count = @layers[0].count("0")
    answer = 0
    @layers.each do |layer|
      if layer.count("0") < zero_count
        zero_count = layer.count("0")
        answer = layer.count("1") * layer.count("2")
      end
    end
    p answer
  end
end

input = File.read("inputs/day8.txt").chomp
input = input.split('')
mars_img = Image.new(input)
mars_img.img_processor(25, 6)