require 'set'

class WordChain
  def initialize(source, target)
    @dictionary = File.readlines("dictionary.txt").map(&:chomp)
    @candidate_words = @dictionary.select do |word|
      word.length == source.length
    end
    @source = source
    @target = target
  end #init

  def adjacent_words(word)
    candidates = []
    (0...word.length).each do |lett_idx|
      reg_str = word.dup
      reg_str[lett_idx] = "."
      candidates += @candidate_words.select {
        |c_word| c_word =~ Regexp.new(reg_str)
      }
    end
    candidates
  end # adjacent_words

  def explore_words(source)
    words_to_expand = [source]
    words_explored = []
    @parents = {}

    found = false
    until found
      current_word = words_to_expand.shift
      adjacent_words(current_word).each do |child|
        next if words_to_expand.include?(child) ||
                words_explored.include?(child)
        @candidate_words.delete(child)
        @parents[child] = current_word
        return if child == @target
        words_to_expand << child
        words_explored << current_word
      end
    end
  end # explore_words

  def print_path(target)
    print_path(@parents[target]) unless target == @source
    puts target
  end # print_path

  def run
    explore_words(@source)
    print_path(@target)
  end # run

end # WordChains

WordChain.new("duck","ruby").run