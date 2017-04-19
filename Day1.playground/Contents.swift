import Foundation

guard let path = Bundle.main.path(forResource: "input", ofType: "txt"),
  let input = try? String(contentsOfFile: path, encoding: .utf8)
  else { fatalError("Couldn't open file") }

enum Turn: String {
  case l = "L"
  case r = "R"
}

enum Direction {
  case north, south, east, west
}

func solution(input: String) -> Int {
  var x: Int = 0
  var y: Int = 0
  var currentDirection: Direction = .north

  let input = input.trimmingCharacters(in: CharacterSet(charactersIn: "\n"))
  let instructions = input.components(separatedBy: ", ")

  for instruction in instructions {
    guard let first = instruction.characters.first,
      let steps = Int(String(instruction.characters.dropFirst())),
      let turn = Turn(rawValue: String(first))
      else { return 0 }

    switch (turn, currentDirection) {
    case (.l, .north):
      x -= steps
      currentDirection = .west
    case (.l, .south):
      x += steps
      currentDirection = .east
    case (.l, .east):
      y += steps
      currentDirection = .north
    case (.l, .west):
      y -= steps
      currentDirection = .south
    case (.r, .north):
      x += steps
      currentDirection = .east
    case (.r, .south):
      x -= steps
      currentDirection = .west
    case (.r, .east):
      y -= steps
      currentDirection = .south
    case (.r, .west):
      y += steps
      currentDirection = .north
    }
  }
  return abs(x) + abs(y)
}

solution(input: input)

