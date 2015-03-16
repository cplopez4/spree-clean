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

			def update
				if(params[:artist][:picture])
					params[:artist][:picture] = Photo.upload_file(params[:artist][:picture])
				end
				
			    invoke_callbacks(:update, :before)
			    if @object.update_attributes(permitted_resource_params)
			      invoke_callbacks(:update, :after)
			      flash[:success] = flash_message_for(@object, :successfully_updated)
			      respond_with(@object) do |format|
			        format.html { redirect_to location_after_save }
			        format.js   { render :layout => false }
			      end
			    else
			      invoke_callbacks(:update, :fails)
			      respond_with(@object)
			    end
			end

			def create
				if(params[:artist][:picture])
					params[:artist][:picture] = Photo.upload_file(params[:artist][:picture])
				end
			    invoke_callbacks(:create, :before)
			    @object.attributes = permitted_resource_params

			    if @object.save
			      invoke_callbacks(:create, :after)
			      flash[:success] = flash_message_for(@object, :successfully_created)
			      respond_with(@object) do |format|
			        format.html { redirect_to location_after_save }
			        format.js   { render :layout => false }
			      end
			    else
			      invoke_callbacks(:create, :fails)
			      respond_with(@object)
			    end
			end

			def model_class
			  Artist
			end
		end
	end
end