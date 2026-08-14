require "http/client"
require "json"
require "uri"

module CrystalVersions
  Log = ::Log.for("crystal_versions")

  FALLBACK        = [Snippet::DEFAULT_CRYSTAL_VERSION]
  TTL             = 1.hour
  RETRY_INTERVAL  = 1.minute
  ENDPOINT        = URI.parse("https://carc.in")
  LANGUAGES_PATH  = "/languages"
  CONNECT_TIMEOUT = 3.seconds
  READ_TIMEOUT    = 5.seconds

  @@mutex = Mutex.new
  @@versions : Array(String) = FALLBACK.dup
  @@refresh_after : Time = Time.unix(0)
  @@refreshing : Bool = false
  @@fetcher : Proc(Array(String)) = -> { fetch_from_carc_in }

  def self.all : Array(String)
    refresh_if_due
    @@mutex.synchronize { @@versions }
  end

  def self.valid?(version : String) : Bool
    all.includes?(version)
  end

  def self.fetcher=(callable : Proc(Array(String)))
    @@mutex.synchronize { @@fetcher = callable }
  end

  def self.reset!(versions : Array(String) = FALLBACK.dup) : Nil
    @@mutex.synchronize do
      @@versions = versions
      @@refresh_after = Time.unix(0)
      @@refreshing = false
    end
  end

  private def self.refresh_if_due : Nil
    claimed = @@mutex.synchronize do
      if @@refreshing || Time.utc < @@refresh_after
        false
      else
        @@refreshing = true
        true
      end
    end
    return unless claimed

    fetcher = @@mutex.synchronize { @@fetcher }

    begin
      versions = fetcher.call
      @@mutex.synchronize do
        @@versions = versions
        @@refresh_after = Time.utc + TTL
      end
      Log.info { "refreshed #{versions.size} crystal versions from carc.in" }
    rescue ex
      Log.warn { "carc.in refresh failed (#{ex.class}: #{ex.message}); keeping the cached list" }
      @@mutex.synchronize { @@refresh_after = Time.utc + RETRY_INTERVAL }
    ensure
      @@mutex.synchronize { @@refreshing = false }
    end
  end

  private def self.fetch_from_carc_in : Array(String)
    body = HTTP::Client.new(ENDPOINT) do |client|
      client.connect_timeout = CONNECT_TIMEOUT
      client.read_timeout = READ_TIMEOUT

      response = client.get(LANGUAGES_PATH)
      raise "carc.in returned HTTP #{response.status_code}" unless response.success?
      response.body
    end

    languages = JSON.parse(body)["languages"].as_a
    crystal = languages.find { |lang| lang["name"].as_s == "crystal" }
    raise "carc.in response contained no crystal entry" if crystal.nil?

    versions = crystal["versions"].as_a.map(&.as_s)
    raise "carc.in returned an empty crystal version list" if versions.empty?
    versions
  end
end
