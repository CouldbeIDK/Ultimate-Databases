#!/usr/bin/ruby
require 'rubygems'
require 'bundler/setup'
require 'json'
require 'sequel'
require 'httparty'
require 'prettyprint'
require './Update.rb'
require './BeBrave.rb'

$key = 

def database_present()
  if File.file?("Ultimate_Database.db")
    return true
  else
    puts("Database not present")
    sleep(1)
    return false
  end
end

def ask_for_create()
  print("
    The program needs to create a database of the current state of League of Legends.\
  This will require connection to the internet, as well as an api key. Continue? (y/n) \n
  ")
  input = gets.chomp.downcase()
  case input
    when "y"
      puts "This could take a while \n"
      tables_drop()
      tables_init()
      tables_populate()
      return true
    when "n"
      system "clear" or system "cls"
      puts("This program can no longer continue without the necessary database.")
      sleep(2)
      puts "Now closing"
      sleep(1)
      Kernel.exit(false)
    else
      return false
  end
end

def menu()
  puts("
    Would you like to... \n
    1. Generate a new build?\n
    2. Update the database?\n
    3. Exit?
  ")
  input = gets.chomp()
  clear_terminal()
  case input
    when "1"
      generate_build()
      gets()
    when "2"
      create_database?()
    when "3"
      Kernel.exit(false)
    else
      puts("You gave me: \"#{input}\" -- that was not a valid option")
      sleep(2)
  end
  clear_terminal()
end

def generate_build()
  newBuild = Build.new(UDB)
  puts("The Champion you will be playing is: #{newBuild.returnChampion} \n\n")
  puts("The items that you will build (in order) are: \n \n")
  for i in 0..5
    puts("\s\s#{newBuild.returnItems[i]}")
  end
end

def clear_terminal()
  system "clear" or system "cls"
end

def create_database?()
  usercooperation = false
  while usercooperation == false
    usercooperation = ask_for_create()
    clear_terminal()
  end
end


def run_program()
  if database_present() == false
    create_database?()
  end
  while true
    menu()
  end
end

run_program()