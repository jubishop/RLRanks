require 'rstruct'

class Ranks
  include Enumerable

  Rank = RStruct.new(:playlist, :rank) {
    include Comparable

    def <=>(other)
      return rank <=> other.rank
    end
  }
  private_constant :Rank

  attr_reader :id, :account, :platform, :ranks, :best

  def initialize(id, account, platform = :steam,
                 standard: nil,
                 doubles: nil,
                 duel: nil,
                 solo_standard: nil,
                 rumble: nil,
                 dropshot: nil,
                 hoops: nil,
                 snow_day: nil)
    @id, @account, @platform = id, account, platform.to_sym
    @ranks = {
      standard: Rank.new('Standard', standard),
      doubles: Rank.new('Doubles', doubles),
      duel: Rank.new('Duel', duel),
      solo_standard: Rank.new('Solo Standard', solo_standard),
      rumble: Rank.new('Rumble', rumble),
      dropshot: Rank.new('Dropshot', dropshot),
      hoops: Rank.new('Hoops', hoops),
      snow_day: Rank.new('Snow Day', snow_day)
    }.reject { |_, rank| rank.rank.nil? }
    @best = @ranks.values.max
  end

  def unranked?
    return @ranks.empty?
  end

  def each_pair
    @ranks.each_pair { |column, rank| yield column, rank }
  end

  def each
    @ranks.each_value { |rank| yield rank }
  end

  def rank(column)
    @ranks[column]
  end

  def ==(other)
    @ranks == other&.ranks
  end
end
