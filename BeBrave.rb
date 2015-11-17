#!/usr/bin/ruby
require 'rubygems'
require 'json'
require 'sequel'
require 'pp'


UDB = Sequel.sqlite('Ultimate_Database.db') #Connect to the database

class Build
	
	def initialize
		@champion = nil
		@items = []
		@goldgen = false
	end
	
	#choose a random champion and set it as the @champion for this build
	def selectChampion 
		championList = []
		champs = UDB[:champions].each do |champ|
			championList << champ[:name]
		end
		@champion = championList[rand(championList.length)]
	end
	
	#choose a set of 6 items and set it as the @items for this build
	def selectItems 
    items_tags = UDB[:items].join(:tags, :id => :id)#.exclude(:tag => "Vision").or(:tag => "Boots").or(:tag => "Trinket").or(:tag => "BootsEnchantment").sql
    itemList = items_tags.map(:name).uniq
		for i in 0..5
      index = rand(itemList.length)
      item = itemList[index]
      itemList.delete_at(index)
      itemList
			@items << item
		end
	end
	
	def printBuild
		pp "Champion: " + @champion
		pp "Items: ", @items
	end
	
end

newBuild = Build.new
newBuild.selectChampion
newBuild.selectItems
newBuild.printBuild