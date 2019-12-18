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

  def shortest_path(place_A, place_B)
    orbits
    orbit_A = []
    orbit_B = []
    @orbit_chains.each do |chain|
      orbit_A = chain if chain.any?(place_A)
      orbit_B = chain if chain.any?(place_B)
    end
    orbit_A = orbit_A[0...orbit_A.rindex(place_A)]
    orbit_B = orbit_B[0...orbit_B.rindex(place_B)]
    orbit_A.reverse_each do |a|
      orbit_B.reverse_each do |b|
        if a == b
          orbit_A = orbit_A[orbit_A.rindex(a)...orbit_A.length]
          orbit_B = orbit_B[orbit_B.rindex(b)...orbit_B.length]
          break
        end
      end
    end
    p orbit_A.length + orbit_B.length - 2
  end

  private

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
  end

end

input = File.read("inputs/day6.txt").split
galaxy = Map.new(input)
galaxy.shortest_path('YOU', 'SAN')