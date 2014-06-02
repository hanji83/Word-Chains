require 'set'

class WordChain
  def initialize(*args)
    @dictionary = Set.new
    @dictionary = File.readlines("dictionary.txt").map(&:chomp)
    @candidate_words = Set.new
    @candidate_words.add(@dictionary.select do |word|
      word.length == @source.length
    end
    @source = args[0]
    @end = args[1]
    @words_to_expand, @reachable_words = []
    @words_to_expand << @source
    @reachable_words << @source
  end #init

  def adjacent_words(word, dictionary)
    candidates = Array.new
    (0...word.length).each do |idx|
      temp = word.dup
      temp[idx] = "."
      candidates = dictionary.select { |letter| letter == Regexp.new(temp) }

    end
  end # adjacent_words

  def explore_words(source, dictionary)
    found = false
    until found
      current_word = @words_to_expand.shift
      adjacent_words(current_word, @ca1ndidate_words).each do |child|
        @candidate_words.delete(child)
        @words_to_expand << child
      end
    end
  end # explore_words

  def run
  end # run
end # WordChains