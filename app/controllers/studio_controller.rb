class StudioController < Spree::BaseController
	layout '/spree/layouts/spree_application'
	helper '/spree/base'
	helper '/spree/products'

	def index
	end

	def show
		@products = Spree::Product.all
	end
end