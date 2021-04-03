require 'rlranks'

RSpec.describe(RLRanks) {
  it('is unranked when no ranks') {
    ranks = RLRanks.new(1, 'account')
    expect(ranks.unranked?).to(be(true))
  }

  it('stores your platform or defaults to :steam') {
    ranks = RLRanks.new(1, 'account')
    expect(ranks.platform).to(eq(:steam))

    ranks = RLRanks.new(1, 'account', :epic)
    expect(ranks.platform).to(eq(:epic))
  }

  context('full set of ranks') {
    before {
      @ranks = RLRanks.new(1, 'account',
                           standard: 10,
                           doubles: 5,
                           duel: 4,
                           rumble: 3,
                           hoops: 15,
                           snow_day: 11,
                           tournament: 1)
    }

    it('still defaults to :steam platform') {
      expect(@ranks.platform).to(eq(:steam))
    }

    it('finds your best rank properly') {
      expect(@ranks.best.rank).to(eq(15))
      expect(@ranks.best.playlist).to(eq('Hoops'))
    }

    it('finds your best rank among a smaller set of playlists') {
      expect(@ranks.best(%i[rumble doubles snow_day dropshot]).rank).to(eq(11))
      expect(@ranks.best(%i[rumble doubles snow_day dropshot]).playlist).to(
          eq('Snow Day'))
    }

    it('calls you unranked if playlists are limited') {
      expect(@ranks.unranked?([:dropshot])).to(be(true))
    }

    it('calls you ranked if playlists include one') {
      expect(@ranks.unranked?([:rumble])).to(be(false))
    }
  }

  it('works with MMR in an array') {
    ranks = RLRanks.new(1, 'account',
                        standard: [10, 700])
    expect(ranks.best.mmr).to(eq(700))
    expect(ranks.rank(:standard).mmr).to(eq(700))
  }
}
