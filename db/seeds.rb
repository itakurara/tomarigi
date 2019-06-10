require 'csv'

CSV.foreach('db/birds.csv', headers: true) do |row|
  Bird.create(ja_name: row[0])
end
