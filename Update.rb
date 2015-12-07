#!/usr/bin/ruby
require 'rubygems'
require 'bundler/setup'
require 'json'
require 'sequel'
require 'httparty'

#Connect to the database
Sequel.extension :migration

def tables_init(database)
  Sequel::Migrator.apply(database, './Versions', 0)
  Sequel::Migrator.apply(database, './Versions')
end

def meets_item_conditions?(properties)
  onTheRift = properties["maps"]["11"] == true
  hasComponents = properties["from"] != nil
  isFinalStage = properties["into"] == nil
  hasTags = properties["tags"] != nil
  if hasTags
    vision = properties["tags"].include?("Vision")
    consumable = properties["tags"].include?("Consumable")
  end
  if (onTheRift and hasComponents and isFinalStage and (not hasTags or (not vision and not consumable)))
    return true
  else
    return false
  end
end

def populate_champions(database, data)
  data.each do |champ, properties| 
    database[:champions].insert(:name => properties["name"])
    properties["tags"].each do |tag|
      database[:tags].insert(:id => properties["id"],  :tag => tag)
    end
  end
end

def populate_items(database, data)
  data.each do |item, properties|
    if meets_item_conditions?(properties)
      database[:items].insert(:id => properties["id"], :name => properties["name"])
      if properties["requiredChampion"] != nil
        database[:tags].insert(:id => properties["id"], :tag => properties["requiredChampion"])
      elsif properties["tags"] != nil
        properties["tags"].each do |tag|
          database[:tags].insert(:id => properties["id"], :tag => tag)
        end
      elsif properties["group"] != nil
        if properties["group"][0...4] == "Boots"
          database[:tags].insert(:id => properties["id"], :tag => "BootsEnchantment")
        elsif properties["group"] == "JungleItems"
          database[:tags].insert(:id => properties["id"], :tag => "JungleItem")
        end
      end
    end
  end
end

def populate_maps(database, data)
  data.each do |map, properties|
    database[:maps].insert(
    :id => properties["id"], 
    :name => properties["name"])
  end
end

def populate_spells(database, data)
  data.each do |spell, properties|
    if properties["modes"].include?("CLASSIC")
      database[:summonerspells].insert(
        :name => properties["name"], 
        :level => properties["summonerLevel"])
    end
  end
end

def get_champObj
  champions = HTTParty.get("https://global.api.pvp.net/api/lol/static-data/na/v1.2/champion?locale=en_US&champData=all&api_key=" + $KEY)
  return JSON.parse(champions.body)
end

def get_itemObj
  items = HTTParty.get("https://global.api.pvp.net/api/lol/static-data/na/v1.2/item?locale=en_US&itemListData=all&api_key=" + $KEY)
  return JSON.parse(items.body)
end

def get_mapObj
  maps = HTTParty.get("https://global.api.pvp.net/api/lol/static-data/na/v1.2/map?locale=en_US&api_key=" + $KEY)
  return JSON.parse(maps.body)
end

def get_spellObj
  summonerspells = HTTParty.get("https://global.api.pvp.net/api/lol/static-data/na/v1.2/summoner-spell?locale=en_US&spellData=all&api_key=" + $KEY)
  return JSON.parse(summonerspells.body)
end

def tables_populate(database)
  champObj = get_champObj
  itemObj = get_itemObj
  mapObj = get_mapObj
  spellObj = get_spellObj
  
  populate_champions(database, champObj["data"])
  populate_items(database, itemObj["data"])
  populate_maps(database, mapObj["data"])
  populate_spells(database, spellObj["data"])
end