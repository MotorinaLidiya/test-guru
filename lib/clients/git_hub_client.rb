require 'octokit'

class GitHubClient
  def initialize
    @client = Octokit::Client.new(access_token: ENV['ACCESS_TOKEN'])
  end

  def create_gist(params)
    @client.create_gist(params)
  rescue StandardError => e
    Rails.logger.error("Failed to create gist: #{e.message}")
    nil
  end
end
