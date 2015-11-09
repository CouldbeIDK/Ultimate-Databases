#!/usr/bin/ruby
require 'rubygems'
require 'json'
require 'sequel'


championdata = File.read('ChampionData.json') #Stored the results from the RiotAPI in a file so that I wouldn't have to learn HTML as well.
itemdata = File.read('ItemData.json')
mapdata = File.read('MapData.json')
summonerspells = File.read('SummonerSpells.json')

champObj = JSON.parse(championdata)
itemObj = JSON.parse(itemdata)
mapObj = JSON.parse(mapdata)
spellObj = JSON.parse(summonerspells)


UDB = Sequel.sqlite('Ultimate_Database.db') #Connect to the database


UDB.create_table! :tags do #I'm putting the tags in a join table, since there can be multiple values for each champion,item,etc.
  String :name
	String :tag
end


UDB.create_table! :champions do #Put the Relevant ChampionData into the "Ultimate Database"
	String :name, :primary_key=>true
end

champObj["data"].each do |champ, properties| 

	UDB[:champions].insert(:name => properties["name"])
	properties["tags"].each do |tag|
	
		UDB[:tags].insert(:name => properties["name"],  :tag => tag)
	end
end


UDB.create_table! :items do
	Integer :id, :primary_key=>true
	String :name
end

itemObj["data"].each do |item, properties|

	if properties["maps"]["11"] == true and properties["from"] != nil and properties["into"] == nil
	
		UDB[:items].insert(:id => properties["id"], :name => properties["name"])
	end
end


UDB.create_table! :maps do #As well as the MapData
	Integer :id, :primary_key=>true
	String :name
end

mapObj["data"].each do |map, properties|

	UDB[:maps].insert(:id => properties["id"], :name => properties["name"])
end


UDB.create_table! :summonerspells do #Lastly, the SummonerSpells
	String  :name, :primary_key=>true
	Integer :level
end

spellObj["data"].each do |spell, properties|

	if properties["modes"].include?("CLASSIC")
	
		UDB[:summonerspells].insert(:name => properties["name"], :level => properties["summonerLevel"])
	end
end
