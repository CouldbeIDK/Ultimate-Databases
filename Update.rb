#!/usr/bin/ruby
require 'rubygems'
require 'bundler/setup'
require 'json'
require 'sequel'
require 'httparty'

#Connect to the database
UDB = Sequel.sqlite('Ultimate_Database.db')

def tables_init
  UDB.create_table! :tags do 
    String :id
    String :tag
  end

  UDB.create_table! :champions do 
    String :name, :primary_key=>true
  end

  UDB.create_table! :items do
    Integer :id, :primary_key=>true
    String :name
  end

  UDB.create_table! :maps do 
    Integer :id, :primary_key=>true
    String :name
  end

  UDB.create_table! :summonerspells do 
    String  :name, :primary_key=>true
    Integer :level
  end
end

def tables_populate()

  champions = HTTParty.get("https://global.api.pvp.net/api/lol/static-data/na/v1.2/champion?locale=en_US&champData=all&api_key=" + $key)
  items = HTTParty.get("https://global.api.pvp.net/api/lol/static-data/na/v1.2/item?locale=en_US&itemListData=all&api_key=" + $key)
  maps = HTTParty.get("https://global.api.pvp.net/api/lol/static-data/na/v1.2/map?locale=en_US&api_key=" + $key)
  summonerspells = HTTParty.get("https://global.api.pvp.net/api/lol/static-data/na/v1.2/summoner-spell?locale=en_US&spellData=all&api_key=" + $key)

  champObj = JSON.parse(champions.body)
  itemObj = JSON.parse(items.body)
  mapObj = JSON.parse(maps.body)
  spellObj = JSON.parse(summonerspells.body)

  champObj["data"].each do |champ, properties| 

    UDB[:champions].insert(:name => properties["name"])
    properties["tags"].each do |tag|
    
      UDB[:tags].insert(:id => properties["id"],  :tag => tag)
    end
  end

  itemObj["data"].each do |item, properties|

    if properties["maps"]["11"] == true and properties["from"] != nil and properties["into"] == nil
    
      UDB[:items].insert(:id => properties["id"], :name => properties["name"])
      if properties["requiredChampion"] != nil
        UDB[:tags].insert(:id => properties["id"], :tag => properties["requiredChampion"])
      elsif properties["tags"] != nil
        properties["tags"].each do |tag|
          UDB[:tags].insert(:id => properties["id"], :tag => tag)
        end
      elsif properties["group"] != nil
        if properties["group"][0...4] == "Boots"
          UDB[:tags].insert(:id => properties["id"], :tag => "BootsEnchantment")
        elsif properties["group"] == "JungleItems"
          UDB[:tags].insert(:id => properties["id"], :tag => "JungleItem")
        end
      end
    end
  end
    
  mapObj["data"].each do |map, properties|
    UDB[:maps].insert(
    :id => properties["id"], 
    :name => properties["name"])
  end

  spellObj["data"].each do |spell, properties|

    if properties["modes"].include?("CLASSIC")
      UDB[:summonerspells].insert(
        :name => properties["name"], 
        :level => properties["summonerLevel"])
    end
  end
end

def tables_drop()
  UDB.drop_table?(:champions)
  UDB.drop_table?(:items)
  UDB.drop_table?(:tags)
  UDB.drop_table?(:maps)
  UDB.drop_table?(:summonerspells)
end