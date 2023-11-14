require 'nokogiri'
require 'open-uri'
require 'csv'

URL = 'https://www.hospitalsafetygrade.org/all-hospitals'

html = URI.open(URL)
document = Nokogiri::HTML(html)

result = []

document.css('div#BlinkDBContent_849210 ul li a').each do |hospital|
    result << hospital.text
end

CSV.open('hospitals.csv', 'w') do |csv|
    csv << ['id', 'hospital_name']

    id = 1
    result.each do |item|
        csv << [id, item]

    id += 1
    end
end