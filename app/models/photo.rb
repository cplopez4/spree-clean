class Photo < ActiveRecord::Base
	def self.upload_file(file_up)

		## Upload photos to Windows Azure Blob Storage

		photos_container = WAZ::Blobs::Container.find('antora')
	    
	    filename = rand(36**32).to_s(36) + File.extname(file_up.original_filename)
	    
	    photos_container.store(filename, file_up.read, file_up.content_type)
	    url = photos_container[filename].url
    end
end
