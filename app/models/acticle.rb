class Acticle < ActiveRecord::Base
def self.searchActicle(search)
	if search and !search.blank? and !search.nil?
		search
	else
		"i257"
	end
end
end
