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

top_three = elves.sort.reverse[0..2]

puts "The top three elves are carrying a total of `#{top_three.sum}` calories."
