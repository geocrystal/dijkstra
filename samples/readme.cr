require "../src/dijkstra"

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

puts gr.shortest_path('a', 'e')
# Undirected : a -> c(9) -> f(11) -> e(20)
# Directed   : a -> c(9) -> d(20) -> e(26)
