class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_taxonomies
  
  def set_taxonomies
	@taxonomies = Spree::Taxonomy.includes(root: :children)
  end

end
