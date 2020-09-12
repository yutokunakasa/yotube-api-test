class MicropostsController < ApplicationController
	def search

		# if !params[:keyword].blank?
		# 	require 'google/apis/youtube_v3'
		# 	youtube = Google::Apis::YoutubeV3::YouTubeService.new
		# 	youtube.key = "AIzaSyCA9IgBCOaN84daaDYcmKDRzl8LUXWX3iw"
		# 	youtube_search_list = youtube.list_searches("id, snippet", type: "video", q: params[:keyword],max_results:5)
		# 	search_result = youtube_search_list.to_h
		# 	@movies = search_result[:itemss]
		# 	if !@movies.nil?
		# 		respond_to do |format|
		# 			format.html { render 'input'}
		# 			format.js
		# 		end
		# 	else
		# 		flash[:warning] = "検索結果はありません"
		# 		respond_to do |format|
		# 			format.html { render 'input'}
		# 			format.js
		# 		end
		# 	end
		# else
		# 	flash.now[:warning] = "検索に空白は使えません"
		# 	respond_to do |format|
		# 		format.html { render 'input'}
		# 		format.js
		# 	end
		# end
		puts params[:keyword]
		@movies = find_videos(params[:keyword])
		@movie = Movie.new
	end

require 'google/apis/youtube_v3'
require 'active_support/all'

GOOGLE_API_KEY="" #上記で作成したキー

def find_videos(keyword, after: 1.months.ago, before: Time.now) #検索キーワードと検索範囲を変えれるように引数に値を取っています
  service = Google::Apis::YoutubeV3::YouTubeService.new
  service.key = GOOGLE_API_KEY
  next_page_token = nil
  opt = {
    q: keyword,
    type: 'video',
    max_results: 2,
    order: :date,
    page_token: next_page_token,
    published_after: after.iso8601,
    published_before: before.iso8601
  }
  results = service.list_searches(:snippet, opt)
  results.items.each do |item|
    id = item.id
    snippet = item.snippet
    puts "\"#{snippet.title}\" by #{snippet.channel_title} (id: #{id.video_id}) (#{snippet.published_at})"
  end
  return results.items
end

def show
	
end


end
