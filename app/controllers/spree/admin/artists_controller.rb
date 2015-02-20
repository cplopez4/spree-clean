module Spree
	module Admin
		class ArtistsController < Spree::Admin::ResourceController
			helper '/spree/base'

			def index
				@artists = Artist.order(:last_name).page(params[:page]).per(10)
				@search = Artist.ransack(params[:q])
			end

			def new
				
			end

			def model_class
			  Artist
			end
		end
	end
end