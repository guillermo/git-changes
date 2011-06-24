class Git::Changelog::Parser
  def initialize(io)
    @io = io
  end

  def generate_changelog
    commit = nil
    @io.each_line do |line|

      case line
      when /^commit ([0123456789abcdef]{6,40})$/
        process_commit(commit) if commit
        commit = {:id => $1}
      when /^Author: (.*)/
        commit[:author] = $1
      when /^Date:\s+(.*)$/
        commit[:date] = $1
      when / (delete mode|create mode) \d{3,6} ([\S]+)\s*$/, /^( )([^\s]*)\s+\|\s+\d+ [-+]*\s*$/,/^ mode change \d+ => (\d+) ([\S]*)\s*$/ 
        commit[:files] ||= []
        file = File.basename($3 || $3 || $3 || $2)
        commit[:files] << file unless commit[:files].include?(file)
      when /.*files changed.*insertions.*deletions/
      when /^    (.*)$/
        commit[:message] ||= ""
        commit[:message] << $1 << "\n"
      end
    end
    process_commit(commit) if commit
  end

protected

  def process_commit(commit)
    current_commit_info = [commit[:author], commit[:date]]
    if @last_commit_info != current_commit_info
      puts "#{commit[:date]} #{commit[:author]}\n\n"
      @last_commit_info = current_commit_info
    end
    puts "    * #{commit[:files].join(", ")}: #{commit[:message].split("\n").first}\n\n"
  end
end
