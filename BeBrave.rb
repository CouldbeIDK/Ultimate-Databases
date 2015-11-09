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
	end #initialize
	
	def selectChampion #choose a random champion and set it as the @champion for this build
		championList = []
		champs = UDB.fetch('SELECT * FROM champions') do |champ|
			championList << champ[:name]
		end
		@champion = championList[rand(championList.length)]
	end #selectChampion
	
	def selectItems #choose a set of 6 items and set it as the @items for this build
		itemList = []
		items = UDB.fetch('SELECT * FROM items WHERE name NOT LIKE "Enchantment%" AND name NOT LIKE "%Trinket%" AND name NOT LIKE "%Sightstone%"') do |item|
			itemList << item[:name]
		end
		for i in 0..5
			@items << itemList[rand(itemList.length)]
		end
	end #selectItems
	
	def printBuild
		pp "Champion: " + @champion
		pp "Items: ", @items
	end #printBuild
	
end #class Build

newBuild = Build.new
newBuild.selectChampion
newBuild.selectItems
newBuild.printBuild