require 'rubygems'
require 'minitest/autorun'
require './Update'
require './BeBrave'
require 'sequel'
require 'json'

class BuildTest < MiniTest::Test
  def setup
    @DB = Sequel.sqlite('Testing.db')
    initialize_test_database
    populate_test_database
    @test_build1 = Build.new(@DB)
    @test_build2 = Build.new(@DB)
    @test_build3 = Build.new(@DB)
  end
  
  def initialize_test_database
    @DB.create_table! :champions do
      String :name, :primary_key => true
    end
    @DB.create_table! :items do
      String :name
      Integer :id
    end
    @DB.create_table! :tags do
      String :tag
      Integer :id
    end
  end
  
  def insert_champions
    @DB[:champions].insert(:name => "Garen")
  end
  
  def insert_items
    @DB[:items].insert(:name => "Warmog's Armor", :id => "1")
    @DB[:items].insert(:name => "Thornmail", :id => "2")
    @DB[:items].insert(:name => "Infinity Edge", :id => "3")
    @DB[:items].insert(:name => "The Black Cleaver", :id => "4")
    @DB[:items].insert(:name => "Dead Man's Plate", :id => "5")
    @DB[:items].insert(:name => "Blood Thirster", :id => "6")
    @DB[:items].insert(:name => "Enchantment: Alacrity", :id => "7")
    @DB[:items].insert(:name => "Berserker's Greaves", :id => "8")
  end
  
  def insert_tags
    @DB[:tags].insert(:tag => "Health", :id => "1")
    @DB[:tags].insert(:tag => "Health Regen", :id => "1")
    @DB[:tags].insert(:tag => "Armor", :id => "2")
    @DB[:tags].insert(:tag => "Attack Damage", :id => "3")
    @DB[:tags].insert(:tag => "Critical Strike Chance", :id => "3")
    @DB[:tags].insert(:tag => "Armor", :id => "5")
    @DB[:tags].insert(:tag => "NonbootsMovement", :id => "5")
    @DB[:tags].insert(:tag => "Attack Damage", :id => "6")
    @DB[:tags].insert(:tag => "Life Steal", :id => "6")
    @DB[:tags].insert(:tag => "BootsEnchantment", :id => "7")
    @DB[:tags].insert(:tag => "Boots", :id => "8")
  end
  
  def populate_test_database
    insert_champions
    insert_items
    insert_tags
  end

  def test_champion_select
    assert_equal "Garen", @test_build1.returnChampion
    assert_equal "Garen", @test_build2.returnChampion
    assert_equal "Garen", @test_build3.returnChampion
  end

  def test_item_select
    refute @test_build1.returnItems.include?("Enchantment: Alactrity")
    refute @test_build1.returnItems.include?("Berserker's Greaves")
    assert_equal @test_build1.returnItems.length, 6
    #Testing the item list to make sure there are no duplicates.
    assert_equal @test_build1.returnItems.uniq.length, @test_build1.returnItems.length
    
    refute @test_build2.returnItems.include?("Enchantment: Alactrity")
    refute @test_build2.returnItems.include?("Berserker's Greaves")
    assert_equal @test_build2.returnItems.length, 6
    assert_equal @test_build2.returnItems.uniq.length, @test_build2.returnItems.length
    
    refute @test_build3.returnItems.include?("Enchantment: Alactrity")
    refute @test_build3.returnItems.include?("Berserker's Greaves")
    assert_equal @test_build3.returnItems.length, 6
    assert_equal @test_build3.returnItems.uniq.length, @test_build3.returnItems.length
  end
  
  def test_pick_item
    a1 = [1,2,4,8,3,6]
    a2 = [1, 2, 0, -1]
    a3 = [62.5, 83.9, -256.38]
    b1 = [1,2,4,8,3,6]
    b2 = [1, 2, 0, -1]
    b3 = [62.5, 83.9, -256.38]
    #since Build::pickItem is destructive and we want to make sure that the items it takes
    #out were actually in the list, we are making two identical lists and comparing them
    test1 = Build.pickItem(b1)
    test2 = Build.pickItem(b2)
    test3 = Build.pickItem(b3)
    #making sure the item was in the list to begin with.
    assert a1.include?(test1)
    assert a2.include?(test2)
    assert a3.include?(test3)
    #making sure the item was taken out of the list
    refute b1.include?(test1)
    refute b2.include?(test2)
    refute b3.include?(test3)
  end
end