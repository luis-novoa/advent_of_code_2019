class Map
  public

  attr_reader :map, :planets
  def initialize(map)
    @map = map
    @map.map! do |e|
      e.split(')')
    end
    @planets = @map.flatten
    @planets.uniq!
  end

  def orbits
    remaining_orbits = @map.clone
    orbits_sum = 0
    @orbit_chains = [["COM"]]
    @planets.length.times {
      @orbit_chains.each do |chain|
        remaining_orbits.map do |orbit|
          if orbit[0] == chain.last
            chain.push(orbit[1])
            remaining_orbits.delete(orbit)
            orbits_sum += chain.length - 1
          elsif chain.include?(orbit[0])
            index = chain.rindex(orbit[0])
            new_branch = chain.clone
            new_branch = new_branch[0..index]
            new_branch.push(orbit[1])
            orbits_sum += new_branch.length - 1
            @orbit_chains.push(new_branch)
            remaining_orbits.delete(orbit)
          end
        end
      end
    }
    # @orbit_chains.each do |chain|
    #   orbits_sum += (1..chain.length).inject(:+)
    # end
    p orbits_sum
  end
end

input = File.read("inputs/day6.txt").split
galaxy = Map.new(input)
galaxy.orbits