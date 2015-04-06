class Artist < ActiveRecord::Base
	def full_name
		first_name + " " + last_name
	end

	def instagram_entries(num)
	    begin
	      id = Instagram.user_search(instagram).first.id
	      Instagram.user_recent_media(id, {:count => num})
	    rescue
	      []
	    end   
  	end

  	def twitter_entries_clean(num)
	    if twitter && twitter != ""
	      	timeline = Twitter.user_timeline(twitter, :count => num, :exclude_replies => true)
	      	if timeline.length > 0
	      		return [{ text: timeline.first.text }]
	  	  	else
	  	  		return []
	  		end
	    else
	      []
	    end
	  end

end
