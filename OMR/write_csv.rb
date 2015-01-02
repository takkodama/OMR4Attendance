require 'csv'
# Write results to CSV file
class WriteCSV
	def write(filename, results)
	  CSV.open(filename,"wb") do |csv|
		title = ['no.','ID']
		csv << title

	 	results.each do |id|
	 		csv << id
	  	end
	  end
	end
end