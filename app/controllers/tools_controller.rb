class ToolsController < ApplicationController
	def export_xls
		@orders = JSON.parse(params[:orders]) || []

		respond_to do |format|
	      format.xls { headers["Content-Disposition"] = "attachment; filename=\"ordenes_del_dia.xls\"" }
	    end
	end

	def export_xls_correos
		@orders = JSON.parse(params[:orders]) || []

		respond_to do |format|
	      format.xls { headers["Content-Disposition"] = "attachment; filename=\"ordenes_correos.xls\"" }
	    end
	end

	def export_xls_chilexpress
		@orders = JSON.parse(params[:orders]) || []

		respond_to do |format|
	      format.xls { headers["Content-Disposition"] = "attachment; filename=\"ordenes_chilexpress.xls\"" }
	    end
	end
end
