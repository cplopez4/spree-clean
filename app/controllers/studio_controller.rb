class StudioController < Spree::BaseController
	require 'twitter-text'
	include Twitter::Autolink
	layout '/spree/layouts/spree_application'
	helper '/spree/base'
	helper '/spree/products'

	def index
		@artists = Artist.all
	end

	def show
		@products = Spree::Product.all
		@artist = Artist.find(params[:id])

		@twitter = @artist.twitter_entries_clean(1)
		if @twitter.length > 0
			@twitter.first[:text] = auto_link(@twitter.first[:text], :username_include_symbol => true)
		end

		@instagram = @artist.instagram_entries(1)
	end
end