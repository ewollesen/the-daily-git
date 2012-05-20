require "time"
require "pry"

class Daily

  SECONDS_IN_A_DAY = 86400

  def initialize(repo_path, options={})
    @repo_path = repo_path
    @now = Time.now
    process_options(options)
  end

  def generate
    Dir.chdir(@repo_path)
    `git log --color --patch --since="#{since}" --until="#{midnight}"`
  end


  private

  def midnight
    Time.local(@now.year, @now.month, @now.day)
  end

  def since
    Time.local(@now.year, @now.month, @now.day) - SECONDS_IN_A_DAY
  end

  def process_options(options)
    if options.include?(:date)
      @now = Time.parse(options[:date])
    end
  end
end
