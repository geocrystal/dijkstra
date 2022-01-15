require "./spec_helper"

describe Dijkstra::Graph do
  edges = [
    {'a', 'b', 7},
    {'a', 'c', 9},
    {'a', 'f', 14},
    {'b', 'c', 10},
    {'b', 'd', 15},
    {'c', 'd', 11},
    {'c', 'f', 2},
    {'d', 'e', 6},
    {'e', 'f', 9},
  ]

  describe "#shortest_path" do
    it "should find shortests directed path" do
      gr = Dijkstra::Graph(Char).new(directed: true)

      edges.each do |source, target, weight|
        gr.add_edge(source, target, weight)
      end

      gr.shortest_path('a', 'e').should eq({26, ['a', 'c', 'd', 'e']})
    end

    it "should find shortests undirected path" do
      gr = Dijkstra::Graph(Char).new

      edges.each do |source, target, weight|
        gr.add_edge(source, target, weight)
      end

      gr.shortest_path('a', 'e').should eq({20, ['a', 'c', 'f', 'e']})
    end

    it "should return nil if no path" do
      gr = Dijkstra::Graph(Char).new

      edges.each do |source, target, weight|
        gr.add_edge(source, target, weight)
      end

      gr.add_edge('x', 'y', 1)

      gr.shortest_path('a', 'x').should eq(nil)
    end

    it "should raise exception when source node not found" do
      gr = Dijkstra::Graph(Char).new

      edges.each do |source, target, weight|
        gr.add_edge(source, target, weight)
      end

      expect_raises Dijkstra::Error, "Missing source node: 'x'" do
        gr.shortest_path('x', 'a')
      end
    end

    it "should raise exception when target node not found" do
      gr = Dijkstra::Graph(Char).new

      edges.each do |source, target, weight|
        gr.add_edge(source, target, weight)
      end

      expect_raises Dijkstra::Error, "Missing target node: 'x'" do
        gr.shortest_path('a', 'x')
      end
    end
  end

  describe "#shortest_paths" do
    it "should find shortests directed paths" do
      gr = Dijkstra::Graph(Char).new(directed: true)

      edges.each do |source, target, weight|
        gr.add_edge(source, target, weight)
      end

      gr.shortest_paths('a').should eq(
        [
          {'a', 'b', 7, ['a', 'b']},
          {'a', 'c', 9, ['a', 'c']},
          {'a', 'f', 11, ['a', 'c', 'f']},
          {'a', 'd', 20, ['a', 'c', 'd']},
          {'a', 'e', 26, ['a', 'c', 'd', 'e']},
        ]
      )
    end

    it "should find shortests undirected paths" do
      gr = Dijkstra::Graph(Char).new

      edges.each do |source, target, weight|
        gr.add_edge(source, target, weight)
      end

      gr.shortest_paths('a').should eq(
        [
          {'a', 'b', 7, ['a', 'b']},
          {'a', 'c', 9, ['a', 'c']},
          {'a', 'f', 11, ['a', 'c', 'f']},
          {'a', 'd', 20, ['a', 'c', 'd']},
          {'a', 'e', 20, ['a', 'c', 'f', 'e']},
        ]
      )
    end

    it "should raise exception when source node not found" do
      gr = Dijkstra::Graph(Char).new

      edges.each do |source, target, weight|
        gr.add_edge(source, target, weight)
      end

      expect_raises Dijkstra::Error, "Missing source node: 'x'" do
        gr.shortest_paths('x')
      end
    end
  end
end
