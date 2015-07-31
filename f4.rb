def neighbours(x, y, z)
  [ [x-1, y  , z  ], [x+1, y  , z  ],
    [x  , y-1, z  ], [x  , y+1, z  ],
    [x  , y  , z-1], [x  , y  , z+1],
  ].reject do |x, y, z|
    x < 0 || x > 5 ||
    y < 0 || y > 5 ||
    z < 0 || z > 5
  end
end

$i = 0
$log = File.open "/Users/josh/deleteme/conways-game-of-life/rgb_path.json", "w"
at_exit { $log.close }

def fill(path, seen, outof)
  $i+=1
  if $i % 10000 == 0
    p [$i, seen.length]
    outof.each_slice(36).with_index { |slice1, i|
      slice1.each_slice(6) { |slice2|
        puts ("  " * i) << slice2.map { |n, d| "#{n}/#{d}" }.join(" ")
      }
    }
  end

  if path.length == 216
    seen << path
    $log.puts seen.inspect
    return seen
  end

  neighbours = neighbours(*path.last).reject { |cell| path.include? cell }.shuffle
  neighbours.each_with_index do |neighbour, i|
    future = path.dup << neighbour
    outof.push [i, neighbour.length]
    fill future, seen, outof
    outof.pop
  end

  seen
end

seen = fill [[0, 0, 0]], [], []

require "pry"
binding.pry
