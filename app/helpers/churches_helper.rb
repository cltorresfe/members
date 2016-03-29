module ChurchesHelper
	def churches_for_select
  		Church.all.collect { |c| [c.name, c.id] }
	end
end
