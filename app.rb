require 'sinatra'
require 'http'
require 'json'

response = HTTP.get 'http://api.nobelprize.org/v1/laureate.json'
DATABASE = JSON.parse(response)

get '/laureates' do
  filtered_laureates = DATABASE['laureates'].select do |laureate|
    laureate['prizes'].find { |prize| prize['category'] == params['category'] }
  end

  [200, {laureates: filtered_laureates}.to_json]
end