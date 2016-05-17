module StatusesHelper
		def statuses_for_select
  		Status.all.collect { |c| [c.name, c.id] }
	end
end
