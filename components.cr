# components.cr - Given edges, enumerates components in multiple ways.

require "deque"

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

  # Gets an array of graph components, via recursive DFS.
  def components_by_dfs_rec
    components = [] of Array(Int32)
    vis = [false] * order

    dfs = vertex_applicator { }
    dfs = vertex_applicator do |src, action|
      next if vis[src]
      vis[src] = true
      action.call(src)
      @adj[src].each { |dest| dfs.call(dest, action) }
    end

    each_vertex do |start|
      out = [] of Int32
      dfs.call(start, vertex_consumer { |vertex| out << vertex })
      components << out.sort! unless out.empty?
    end

    components
  end

  # Gets an array of graph components, via iterative DFS.
  def components_by_dfs
    vis = [false] * order
    stack = [] of Int32

    dfs = ->(start : Int32) do
      raise "Internal error: already visited component" if vis[start]
      out = [] of Int32
      
      push = ->(src : Int32) do
        vis[src] = true
        stack.push(src)
        out << src
      end

      push.call(start)
      until stack.empty?
        @adj[stack.pop].reject { |dest| vis[dest] }.each(&push)
      end

      out.sort!
    end

    each_vertex.reject { |start| vis[start] }.map(&dfs).to_a
  end

  # Gets an array of graph components, via BFS.
  def components_by_bfs
    vis = [false] * order
    queue = Deque(Int32).new

    bfs = ->(start : Int32) do
      raise "Internal error: already visited component" if vis[start]
      out = [] of Int32
      
      push = ->(src : Int32) do
        vis[src] = true
        queue.push(src)
        out << src
      end

      push.call(start)
      until queue.empty?
        @adj[queue.shift].reject { |dest| vis[dest] }.each(&push)
      end

      out.sort!
    end

    each_vertex.reject { |start| vis[start] }.map(&bfs).to_a
  end

  # Call a block for each vertex.
  private def each_vertex(&block)
    (0...order).each { |vertex| yield vertex }
  end

  # Lazy sequence of vertices.
  private def each_vertex
    (0...order).each
  end
end

# Disjoint set union data structure.
class DisjointSets
  @elems : Array(Int32)

  # Does *count* "makeset" operations, creating singletons *0* to *count - 1*.
  def initialize(count)
    @elems = [-1] * count
  end

  def union(elem1, elem2)
    # Find the ancestors. Stop if they are already the same.
    elem1 = find_set(elem1)
    elem2 = find_set(elem2)
    return if elem1 == elem2

    # Unite by rank.
    if @elems[elem2] < @elems[elem1]
      # elem2 has superior (more negative) rank. It will remain the parent.
      @elems[elem1] = elem2
    else
      # If elem1 and elem2 are of the same rank, promote elem1.
      @elems[elem1] -= 1 if @elems[elem1] == @elems[elem2]

      # elem1 has superior (more negative) rank. It will remain the parent.
      @elems[elem2] = elem1
    end

    nil
  end

  def components
    buckets = range.map { [] of Int32 }
    range.each { |elem| buckets[find_set(elem)] << elem }
    buckets.reject(&.empty?).sort_by!(&.first)
  end

  private def find_set(elem)
    # Find the ancestor.
    leader = elem
    while @elems[leader] >= 0
      leader = @elems[leader]
    end

    # Compress the path.
    while elem != leader
      parent = @elems[elem]
      @elems[elem] = leader
      elem = parent
    end

    leader
  end

  private def range
    0...@elems.size
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

  def to_disjoint_sets
    sets = DisjointSets.new(order)
    each { |edge| sets.union(*edge) }
    sets
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

# FIXME: Factor out the repetition in the following stanzas.

graph = edges.to_graph

dfs_rec = graph.components_by_dfs_rec
puts "Found #{regular_pluralize(dfs_rec.size, "component")} by recursive DFS:"
dfs_rec.each { |component| pp component }
puts

dfs_iter = graph.components_by_dfs
puts "Found #{regular_pluralize(dfs_iter.size, "component")} by iterative DFS:"
dfs_iter.each { |component| pp component }
puts

bfs = graph.components_by_bfs
puts "Found #{regular_pluralize(bfs.size, "component")} by BFS:"
bfs.each { |component| pp component }
puts

uf = edges.to_disjoint_sets.components
puts "Found #{regular_pluralize(uf.size, "component")} by union-find:"
uf.each { |component| pp component }
puts

if dfs_rec == dfs_iter == bfs == uf
  puts "I'm happy to say those results are all the same."
else
  puts "Oh NO! Those results are NOT all the same! :("
end
