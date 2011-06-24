class Git::Changelog::CLI
  def process
    @io = IO.popen("git log --summary --stat --no-merges --date=short") 
    parser = Git::Changelog::Parser.new(@io)
    parser.generate_changelog
    @io.close
  end

  def self.process!
    new.process
  end
end
