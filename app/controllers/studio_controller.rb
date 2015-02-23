class StudioController < Spree::BaseController
	layout '/spree/layouts/spree_application'
	helper '/spree/base'
	helper '/spree/products'

	def index
		@artists = Artist.all
	end

	def show
		@products = Spree::Product.all
		@artist = Artist.find(params[:id])
	end
end