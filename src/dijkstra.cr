module Dijkstra
  VERSION = {{ `shards version #{__DIR__}`.chomp.stringify }}

  class Error < Exception
  end

  class Graph(T)
    def initialize(@directed = false)
      # {node1 => {edge1 => weight, edge2 => weight}, node2 => {...}, ...}
      @neighbours = Hash(T, Hash(T, Int32)).new { |h, k| h[k] = Hash(T, Int32).new }

      @vertices = Set(T).new
      @infinity = Int32::MAX

      @dist = {} of T => Int32
      @prev = {} of T => T?
    end

    def add_edge(source : T, target : T, weight : Int32)
      @neighbours[source][target] = weight
      @neighbours[target][source] = weight unless @directed

      @vertices << source << target
    end

    # Based of wikipedia's pseudocode: https://en.wikipedia.org/wiki/Dijkstra's_algorithm
    private def dijkstra(source : T)
      raise Dijkstra::Error.new("Missing source node: '#{source}'") unless @vertices.includes?(source)

      @vertices.each do |i|
        @dist[i] = @infinity
        @prev[i] = nil
      end

      @dist[source] = 0
      q = @vertices.dup

      while !q.empty?
        u = @dist.select(q).min[0]
        q.delete(u)

        break if @dist[u] == @infinity

        next unless @neighbours.has_key?(u)

        @neighbours[u].each do |v, weight|
          alt = @dist[u] + weight

          if alt < @dist[v]
            @dist[v] = alt
            @prev[v] = u
          end
        end
      end
    end

    def shortest_paths(source : T) : Array(Tuple(T, T, Int32?, Array(T)?))
      dijkstra(source)

      (@vertices - [source]).map do |target|
        if @dist[target] != @infinity
          {source, target, @dist[target], path_to(target)}
        else
          {source, target, nil, nil}
        end
      end
    end

    def shortest_path(source : T, target : T) : {Int32, Array(T)}?
      dijkstra(source)

      raise Dijkstra::Error.new("Missing target node: '#{target}'") unless @vertices.includes?(target)

      if @dist[target] != @infinity
        {@dist[target], path_to(target)}
      else
        nil
      end
    end

    # Full shortest route to a node
    private def path_to(target, path = [] of T) : Array(T)
      if (node = @prev[target])
        path_to(node, path)
      end

      path << target
    end
  end
end
