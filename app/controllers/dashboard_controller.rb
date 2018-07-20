class DashboardController < ApplicationController
  before_action :authenticate_user!

  def show
    @user_info = SpotifyConnection.new(current_user).user_information
    @user_playlists = SpotifyConnection.new(current_user).user_playlists
  end

  def playlist_info
    @playlist = SpotifyConnection.new(current_user).playlists_tracks(params[:id])
  end

  def top_tracks
    @list = SpotifyConnection.new(current_user).top_tracks
  end

  def export_to_transfer
    @user_playlists = SpotifyConnection.new(current_user).user_playlists
    items_to_export = []
    @user_playlists.each do |pl|
      item = {}
      item[:link] = pl['external_urls']['spotify']
      if pl['images'].any?
        item[:image] = image_to_tempfile(pl['images'].first['url'], pl['name'])
      end
      item[:title] = "Playlist: #{pl['name']}"
      items_to_export << item
    end
    url = TransferExporter.new(items_to_export).create_transfer
    redirect_to dashboard_path, notice: "Your playlist is uploaded here: #{url}"
  end

  def export_selected_playlists
    playlist_ids = selected_playlists_params['ids'].values
    items_to_export = []
    playlist_ids.each do |pl_id|
      item = {}
      resp = SpotifyConnection.new(current_user).playlist_info(pl_id)
      item[:link] = resp['external_urls']['spotify']
      if resp['images'].any?
        item[:image] = image_to_tempfile(resp['images'].first['url'], resp['name'])
      end
      item[:title] = "Playlist: #{resp['name']}"
      items_to_export << item
    end
    url = TransferExporter.new(items_to_export).create_transfer
    redirect_to dashboard_path, notice: "Your playlist is uploaded here: #{url}"
  rescue
    redirect_to dashboard_path, alert: "Nothing selected"  and return
  end

  def export_selected_tracks
    track_ids = selected_tracks_params['ids'].values
    items_to_export = []
    track_ids.each do |pl_id|
      item = {}
      resp = SpotifyConnection.new(current_user).track_info(pl_id)
      item[:link] = resp['external_urls']['spotify']
      if resp['album']['images'].any?
        item[:image] = image_to_tempfile(resp['album']['images'].first['url'], "#{resp['artists'][0]['name']} - #{resp['name']}")
      end
      item[:title] = "Track: #{resp['artists'][0]['name']} - #{resp['name']}"
      items_to_export << item
    end
    url = TransferExporter.new(items_to_export).create_transfer
    redirect_to dashboard_path, notice: "The selected tracks are uploaded here: #{url}"
  rescue
    redirect_to dashboard_path, alert: "Nothing selected"  and return
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

  def selected_playlists_params
    params.require(:playlist_ids).permit(ids:{})
  end

  def selected_tracks_params
    params.require(:track_ids).permit(ids:{})
  end
end