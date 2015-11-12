#!/usr/bin/ruby
require 'rubygems'
require 'json'
require 'sequel'
require 'open-uri'

championdata = open(https://na.api.pvp.net/api/lol/na/v1.2/champion?api_key=45bc22be-d60d-4e92-9701-d0dab2ef71ed)
itemdata = open(https://global.api.pvp.net/api/lol/static-data/na/v1.2/item?api_key=45bc22be-d60d-4e92-9701-d0dab2ef71ed)
mapdata = open(https://global.api.pvp.net/api/lol/static-data/na/v1.2/map?api_key=45bc22be-d60d-4e92-9701-d0dab2ef71ed)
summonerspells = open(https://global.api.pvp.net/api/lol/static-data/na/v1.2/summoner-spell?api_key=45bc22be-d60d-4e92-9701-d0dab2ef71ed)

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
