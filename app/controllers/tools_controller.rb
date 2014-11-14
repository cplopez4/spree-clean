class ToolsController < ApplicationController
	def export_xls
		@orders = JSON.parse(params[:orders]) || []

		respond_to do |format|
	      format.xls
	    end
	end
end
