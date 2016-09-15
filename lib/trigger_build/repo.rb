require 'git'

module TriggerBuild
  class Repo
    def initialize(directory = Dir.pwd)
      @git = Git.open(directory) rescue nil
    end

    def name
      @git.dir.path.split('/').last
    end

    def last_commit_message
      @git.gcommit(@git.log.first).message
    end

    def valid?
      !@git.nil?
    end
  end
end
