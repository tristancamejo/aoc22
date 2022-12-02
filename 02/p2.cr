input = File.read("input.txt")

round_map = Hash(Int32, Array(String)).new

line_index = 0

input.each_line do |line|
  plays = line.split(" ")
  round_map[line_index] = plays
  line_index += 1
end

struct OppPlay
  Rock     = "A"
  Paper    = "B"
  Scissors = "C"
end

struct PlayerPlay
  Rock     = "X"
  Paper    = "Y"
  Scissors = "Z"
end

struct MustEnd
  Lose = "X"
  Tie  = "Y"
  Win  = "Z"
end

struct Result
  Win  = "Win"
  Loss = "Loss"
  Tie  = "Tie"
end

struct PlayPoints
  Rock     = 1
  Paper    = 2
  Scissors = 3
end

struct ResultPoints
  Win  = 6
  Loss = 0
  Tie  = 3
end

def play_round(opp_play, my_play)
  case opp_play
  when OppPlay::Rock
    case my_play
    when PlayerPlay::Rock
      return Result::Tie
    when PlayerPlay::Paper
      return Result::Win
    when PlayerPlay::Scissors
      return Result::Loss
    end
  when OppPlay::Paper
    case my_play
    when PlayerPlay::Rock
      return Result::Loss
    when PlayerPlay::Paper
      return Result::Tie
    when PlayerPlay::Scissors
      return Result::Win
    end
  when OppPlay::Scissors
    case my_play
    when PlayerPlay::Rock
      return Result::Win
    when PlayerPlay::Paper
      return Result::Loss
    when PlayerPlay::Scissors
      return Result::Tie
    end
  end
end

def calculate_play(opp_play, must_end)
  case must_end
  when MustEnd::Lose
    case opp_play
    when OppPlay::Rock
      return PlayerPlay::Scissors
    when OppPlay::Paper
      return PlayerPlay::Rock
    when OppPlay::Scissors
      return PlayerPlay::Paper
    end
  when MustEnd::Tie
    case opp_play
    when OppPlay::Rock
      return PlayerPlay::Rock
    when OppPlay::Paper
      return PlayerPlay::Paper
    when OppPlay::Scissors
      return PlayerPlay::Scissors
    end
  when MustEnd::Win
    case opp_play
    when OppPlay::Rock
      return PlayerPlay::Paper
    when OppPlay::Paper
      return PlayerPlay::Scissors
    when OppPlay::Scissors
      return PlayerPlay::Rock
    end
  end
end

def get_play_points(play)
  case play
  when PlayerPlay::Rock
    return PlayPoints::Rock
  when PlayerPlay::Paper
    return PlayPoints::Paper
  when PlayerPlay::Scissors
    return PlayPoints::Scissors
  end

  return 0
end

def get_result_points(result)
  case result
  when Result::Win
    return ResultPoints::Win
  when Result::Loss
    return ResultPoints::Loss
  when Result::Tie
    return ResultPoints::Tie
  end

  return 0
end

my_points = 0

round_map.each do |_, plays|
  opp_play = plays[0]
  must_end = plays[1]

  my_play = calculate_play(opp_play, must_end)
  result = play_round(opp_play, my_play)

  my_points += get_play_points(my_play) + get_result_points(result)

  puts "Opponent played #{opp_play} and I played #{my_play} - #{result}"
end

puts "----"
puts "My points: #{my_points}"
