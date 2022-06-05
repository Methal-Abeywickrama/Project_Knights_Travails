
# This class represents a knight which can be represented as a node in the given data structure
class Knight
  attr_accessor :moves, :ancestors
  attr_reader :position

  def initialize(position, ancestors = [Array.new([position])], moves = nil)
    @position = position
    @ancestors = ancestors
    @moves = moves
  end
end

# This class represents the data structure where a single node is a possible position of knight
class Board
  attr_accessor :root, :target

  @@transformations = [[2, 1], [2, -1], [-2, 1], [-2, -1], [1, 2], [1, -2], [-1, 2], [-2, -1]]

  def initialize(position, target)
    p 'initialized'
    new_array_2 = [position[0], position[1]]
    @root = Knight.new(position, [Array.new(new_array_2)])
    @target = target
    @order = [@root]
    flow
  end

  def fill_moves_2(node)
    moves = @@transformations.map do |move|
      [move[0] + node.position[0], move[1] + node.position[1]]
    end
    collection = []
    moves.each do |move|
      ancestor = node.ancestors
      if move[0].between?(0, 7) && move[1].between?(0, 7)
        new_ancestor = ancestor.push(move).clone
        new_knight = Knight.new(move, new_ancestor)
        collection.push(new_knight)
        ancestor.pop
      else
        0
      end
    end
    collection
    
  end

  def flow
    found = check
    until found
      @order = transform(@order)
      found = check
    end
    p @order[0].ancestors
  end


  def knight_moves(node = @root)
    if node.moves.nil?
      node.moves = fill_moves(node.position)
    else
      node.moves.each { |move| knight_moves(move) unless move == 0 }
    end
  end

  def transform(array)
    new_array = []
    array.each { |x| new_array.push(fill_moves_2(x))}
    new_array.flatten(1)
  end

  def check(array = @order)
    array.any? { |knight| knight.position == @target }
  end
end

def knight_travails(final, target)
  Board.new(final, target)
end

knight_travails([0,0], [3, 3])
