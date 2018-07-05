class DashboardController < ApplicationController
  before_action :authenticate_user!

  def show
    @user_info = SpotifyCollector.new(current_user).user_information
    @user_playlists = SpotifyCollector.new(current_user).user_playlists
  end

  def export_to_transfer
    @user_playlists = SpotifyCollector.new(current_user).user_playlists
    items_to_export = []
    @user_playlists['items'].each do |pl|
      item = {}
      item[:link] = pl['external_urls']['spotify']
      item[:image] = image_to_tempfile(pl['images'].first['url'], pl['name'])
      item[:title] = "Playlist: #{pl['name']}"
      items_to_export << item
    end
    url = TransferExporter.new(items_to_export).create_transfer
    redirect_to dashboard_path, notice: "Your playlist is uploaded here: #{url}"
  end

  private

  def image_to_tempfile(image_url, name)
    file_path = URI.extract(image_url).first
    file_name = name.parameterize
    t = Tempfile.new([file_name, ".jpg"])
    t.write(open(file_path).read.force_encoding("UTF-8"))
    t.flush
    t.close
    t.path
    File.absolute_path(t)
  end
end