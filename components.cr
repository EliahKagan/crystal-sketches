# components.cr - Given edges, enumerates components in multiple ways.

# An adjacency-list representation of an unweighted undirected graph.
class Graph
  # Initializes a graph with no edges and *order* vertices.
  def initialize(order)
    @adj = Array(Array(Int32)).new(order) { [] of Int32 }
  end

  # Gets the number of vertices in the graph.
  def order
    @adj.size
  end

  # Adds an undirected edge to the graph.
  def add_edge(vertex1, vertex2)
    # Look up the rows first, so no change is made if an exception is thrown.
    row1 = @adj[vertex1]
    row2 = @adj[vertex2]

    # Add the vertices to each other's rows.
    row1 << vertex2
    row2 << vertex1
  end

  # Recursive DFS to perform an operation on each component.
  def each_component_dfs_rec(&block)
    vis = [false] * order

    dfs = ->(src : Int32, action : Proc(Int32, Nil)) do
      return if vis[src]
      vis[src] = true
      action.call(src)
      @adj[src].each { |dest| dfs.call(dest, action) }
    end

    (0...order).each do |start|
      component = [] of Int32
      dfs.call(start, ->(vertex : Int32) { component << vertex })
      yield component.sort! unless component.empty?
    end
  end

  # Recursive DFS, collected into an array of components.
  def each_component_dfs_rec
    components = [] of Array(Int32)
    each_component_dfs_rec { |component| components << component }
    components
  end
end

def read_edges(io)
  io.each_line
    .map &.split
    .tap { |tokens| raise "wrong record length" if tokens.size != 2 }
    .map &.map(&.to_i)
    .map { |values| {values[0], values[1]} }
    .to_a
end

read_edges(ARGF).each { |edge| pp edge }
