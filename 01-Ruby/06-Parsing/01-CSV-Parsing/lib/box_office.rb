require 'csv'

def most_successful(number, max_year, file_path)
  # TODO: return an array of most successful movies before `max_year`
  return_array = []
  lines = CSV.read(file_path)
  sorted_lines = lines.sort_by { |line| line[2].to_i }.reverse
  sorted_lines.each do |csv|
    return_array << { name: csv[0], year: csv[1].to_i, earnings: csv[2].to_i } if csv[1].to_i < max_year
  end
  return_array.first(number)
end
