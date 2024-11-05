require 'zlib'
require 'yaml'
require 'uri'
require 'open-uri'
require 'nokogiri'
require 'cgi'
require 'rubygems'
require 'json'
require 'crack'

xmlData = File.open("appstream.xml").read
componentsData = Nokogiri::XML(xmlData,&:noblanks)

parsedXML  = Crack::XML.parse(xmlData)
convertedToJSON = parsedXML.to_json

File.open("_data/apps.json", "w+") do |file|
  file.write(convertedToJSON)
end

template = '---
app_id: ((id))
title: "((title))"
summary: "((summary))"
dist: flatpak
screenshots:
((screenshots))
redirect_from: ((redirect))
---

((description))'

componentsData.css("components component").each do |component|
  next unless (component.get_attribute("type") == "desktop" || component.get_attribute("type") == "desktop-application")

puts "\nGenerating #{component.at_css('name').content}"

  appFile = template.dup

  name = component.at_css('name')
  appFile.sub!('((title))', CGI.escapeHTML(name.content))

  summary = component.at_css('summary')
  appFile.sub!('((summary))', CGI.escapeHTML(summary.content))

  description = component.at_css('description')
  appFile.sub!('((description))', description.inner_html)

  id = component.at_css('id').content.sub(/\.desktop$/, '')
  puts "  id: #{id}"
  appFile.sub!('((id))', id)
  appFile.sub!('((redirect))', "/" + id + ".desktop/")

  screenshots = ''
  image = component.at_css('image')
  if not image.nil?
    screenshots += '  - ' + image.content + "\n"

  end
  # TODO: multiple screenshots
  appFile.sub!('((screenshots))', screenshots.rstrip)

  File.open("_apps/#{id}.md", "w+") do |file|
    file.write(appFile)
  end
end
