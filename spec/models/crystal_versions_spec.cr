require "../spec_helper"

private def test_versions : Array(String)
  ["1.21.0", "1.20.3", "1.19.1"]
end

describe CrystalVersions do
  before_each do
    CrystalVersions.fetcher = ->{ test_versions }
    CrystalVersions.reset!
  end

  # Leave a safe offline stub behind for every other spec file.
  after_each do
    CrystalVersions.fetcher = ->{ CrystalVersions::FALLBACK.dup }
    CrystalVersions.reset!
  end

  describe ".all" do
    it "refreshes on first use" do
      CrystalVersions.all.should eq(test_versions)
    end

    it "does not refetch within the TTL" do
      calls = 0
      CrystalVersions.fetcher = ->{ calls += 1; test_versions }
      CrystalVersions.reset!

      3.times { CrystalVersions.all }
      calls.should eq(1)
    end

    it "never returns an empty list" do
      CrystalVersions.all.should_not be_empty
    end
  end

  describe "when carc.in is unreachable" do
    it "keeps the last good list instead of falling back" do
      warm = CrystalVersions.all
      warm.should eq(test_versions)

      CrystalVersions.fetcher = ->{ raise "carc.in is down" }
      CrystalVersions.reset!(warm) # stale, but the good list is still cached

      CrystalVersions.all.should eq(test_versions)
    end

    # The old code's real defect: one outage pinned the list to FALLBACK forever.
    it "recovers once carc.in returns" do
      CrystalVersions.fetcher = ->{ raise "carc.in is down" }
      CrystalVersions.reset!
      CrystalVersions.all.should eq(CrystalVersions::FALLBACK)

      CrystalVersions.fetcher = ->{ test_versions }
      CrystalVersions.reset!
      CrystalVersions.all.should eq(test_versions)
    end

    it "does not retry on every request" do
      calls = 0
      CrystalVersions.fetcher = ->{ calls += 1; raise "carc.in is down" }
      CrystalVersions.reset!

      3.times { CrystalVersions.all }
      calls.should eq(1)
    end
  end

  describe ".valid?" do
    it "accepts a cached version" do
      CrystalVersions.valid?("1.20.3").should be_true
    end

    it "rejects an unknown version" do
      CrystalVersions.valid?("9.9.9").should be_false
    end

    it "rejects an empty string" do
      CrystalVersions.valid?("").should be_false
    end
  end
end
