input = File.read("input.txt")

elves = [] of Int32

input.each_line do |line|
  if elves.size == 0
    elves << line.to_i
  else
    if line.strip != ""
      elves[elves.size - 1] += line.to_i
    else
      elves << 0
    end
  end
end

puts "The Elf carrying the most calories has `#{elves.max}` calories."
