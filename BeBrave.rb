#!/usr/bin/ruby
require 'rubygems'
require 'json'
require 'sequel'

class Build
	
	def initialize(database)
		@items = []
		@goldgen = false
    @jungle = false
		@champion = nil
    @UDB = database
    self.selectChampion
    self.selectItems
	end
	
	#choose a random champion and set it as the @champion for this build
	def selectChampion 
		championList = []
		champs = @UDB[:champions].each do |champ|
			championList << champ[:name]
		end
		@champion = championList[rand(championList.length)]
	end
	
	#choose a set of 6 items and set it as the @items for this build
	def selectItems 
    items_tags = @UDB[:items].join(:tags, :id => :id)#.exclude(:tag => "Vision").or(:tag => "Boots").or(:tag => "Trinket").or(:tag => "BootsEnchantment")
    itemList = items_tags.map(:name).uniq
		for i in 0..5
      item = self.pickItem(itemList)
      @items << item
		end
	end
  
  def pickItem(itemList)
    index = rand(itemList.length)
    item = itemList[index]
    itemList.delete_at(index)
    return item
  end
	
	def returnChampion
		return @champion
	end
  
  def returnItems
    return @items
   end
	
end