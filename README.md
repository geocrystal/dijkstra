# dijkstra

Dijkstra's Algorithm in Crystal.

[Dijkstra's algorithm](https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm) is an algorithm for finding the shortest paths between nodes in a graph, which may represent, for example, road networks.

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     dijkstra:
       github: geocrystal/dijkstra
   ```

2. Run `shards install`

## Usage

```crystal
require "dijkstra"

gr = Dijkstra::Graph(Char).new(directed: true)

gr.add_edge('a', 'b', 7)
gr.add_edge('a', 'c', 9)
gr.add_edge('a', 'f', 14)
gr.add_edge('b', 'c', 10)
gr.add_edge('b', 'd', 15)
gr.add_edge('c', 'd', 11)
gr.add_edge('c', 'f', 2)
gr.add_edge('d', 'e', 6)
gr.add_edge('e', 'f', 9)

gr.shortest_path('a', 'e')

# Directed   : a -> c(9) -> d(20) -> e(26)
# Undirected : a -> c(9) -> f(11) -> e(20)
```

## Contributing

1. Fork it (<https://github.com/geocrystal/dijkstra/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Anton Maminov](https://github.com/mamantoha) - creator and maintainer