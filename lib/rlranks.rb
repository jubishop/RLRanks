require 'rstruct'

class RLRanks
  include Enumerable

  class Rank
    include Comparable

    attr_reader :playlist, :rank, :mmr

    def initialize(playlist, rank = nil, mmr = nil)
      @playlist = playlist.to_s
      @rank = rank.to_i unless rank.nil?
      @mmr = mmr.to_i unless mmr.nil?
    end

    def <=>(other)
      return rank <=> other.rank
    end

    def to_i
      rank
    end
  end
  private_constant :Rank

  attr_reader :id, :account, :platform, :ranks

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
      standard: Rank.new('Standard', *standard),
      doubles: Rank.new('Doubles', *doubles),
      duel: Rank.new('Duel', *duel),
      solo_standard: Rank.new('Solo 3s', *solo_standard),
      rumble: Rank.new('Rumble', *rumble),
      dropshot: Rank.new('Dropshot', *dropshot),
      hoops: Rank.new('Hoops', *hoops),
      snow_day: Rank.new('Snow Day', *snow_day)
    }.reject { |_, rank| rank.rank.nil? }
  end

  def unranked?(playlists = [])
    return @ranks.empty? if playlists.empty?

    return playlists.any? { |playlist| @ranks.key?(playlist) }
  end

  def best(playlists = [])
    return @ranks.values.max if playlists.empty?

    filtered_ranks = @ranks.values_at(*playlists)
    filtered_ranks.compact!
    return filtered_ranks.max
  end

  def each(&block)
    @ranks.each(&block)
  end

  def rank(playlist)
    @ranks[playlist]
  end

  def ==(other)
    @ranks == other&.ranks
  end
end
