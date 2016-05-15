require 'nokogiri'
require 'faraday'

url = 'https://github.com/blueplanet'

SCHEDULER.every '600s', first_in: 0 do
  doc = Nokogiri::XML(Faraday.get(url).body)
  days = doc.css('#contributions-calendar .contrib-number').last.text.match /\d*/

  send_event 'last_days', { current: days }
  send_event 'process', { value: days }
end
