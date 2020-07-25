# components.cr - Given edges, enumerates components in multiple ways.

def vertex_applicator(&block : (Int32, Proc(Int32, Nil)) -> Nil)
  block
end

def vertex_consumer(&block : Int32 -> Nil)
  block
end

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
  def each_component_by_dfs_rec(&block)
    vis = [false] * order

    dfs = vertex_applicator { }
    dfs = vertex_applicator do |src, action|
      next if vis[src]
      vis[src] = true
      action.call(src)
      @adj[src].each { |dest| dfs.call(dest, action) }
    end

    (0...order).each do |start|
      component = [] of Int32
      dfs.call(start, vertex_consumer { |vertex| component << vertex })
      yield component.sort! unless component.empty?
    end
  end

  # Recursive DFS, collected into an array of components.
  def components_by_dfs_rec
    #components = [] of Array(Int32)
    #each_component_by_dfs_rec { |component| components << component }
    #components
    
    #collect_to_array do |components|
    #  each_component_by_dfs_rec { |component| components << component }
    #end

    #collect_to_array(&.each_component_by_dfs_rec)

    collect_to_array(->{ each_component_by_dfs_rec { |x| yield x } })
  end

  private def collect_to_array(proc)
    elems = [] of Array(Int32)
    proc.call { |elem| elems << elem }
    elems
  end
end

# A list of undirected edges.
class EdgeList
  @edges = [] of Tuple(Int32, Int32)
  @max_vertex = -1

  # The number of edges.
  def size
    @edges.size
  end

  # The number of vertices, assuming contiguity.
  # That is, if n is an endpoint, it assumes all vertices in (0..n) exist.
  def order
    @max_vertex + 1
  end

  def add(vertex1, vertex2)
    raise "vertices must be nonnegative" if vertex1 < 0 || vertex2 < 0
    @edges << {vertex1, vertex2}
    @max_vertex = {@max_vertex, vertex1, vertex2}.max
  end

  def each(&block)
    @edges.each { |edge| yield edge }
  end

  def each
    @edges.each
  end

  def to_graph
    graph = Graph.new(order)
    each { |edge| graph.add_edge(*edge) }
    graph
  end
end

def read_edges(io = ARGF)
  edges = EdgeList.new

  io.each_line
    .map(&.split)
    .tap { |tokens| raise "wrong record length" if tokens.size != 2 }
    .map(&.map(&.to_i))
    .each { |endpoints| edges.add(endpoints[0], endpoints[1]) }

  edges
end

def regular_pluralize(count, word)
  count == 1 ? "#{count} #{word}" : "#{count} #{word}s"
end

edges = read_edges
puts "Got #{edges.order} vertices and #{edges.size} edges. The edges are:"
edges.each { |edge| pp edge }
puts

graph = edges.to_graph

dfs_rec = graph.components_by_dfs_rec
puts "Found #{regular_pluralize(dfs_rec.size, "component")} by recursive DFS:"
dfs_rec.each { |component| pp component }
