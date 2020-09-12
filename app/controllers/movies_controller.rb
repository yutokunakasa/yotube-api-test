class MoviesController < ApplicationController
	def new
	end

	def create
		@movie = Movie.new
		@movie.save
		if @movie.update(movie_params)
			redirect_to 'microposts#search'
		end
	end

	def show
		@movie = Movie.find(params[:id])
	end

	def index
		@movies = Movie.all
	end

	private
	def movie_params
		params.require(:movie).permit(:title, :movie_url_id, :introducer_comment)
	end


end
