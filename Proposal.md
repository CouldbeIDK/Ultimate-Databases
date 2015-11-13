###Overview/Abstract

After experiencing an outdated version of a third party web application for the game League of Legends I wanted to create a new updated version of said app. This app in its basic form takes items from the game and rearranges them into crazy, outlandish, “builds” which can make your game experience extremely difficult if you follow it’s instructions.


###Background

Some material I have reviewed in relation to the project is Ruby syntax and a little about databases in general. Related software would be the original site[1]. I have worked with SQL once in Survey of Computer science but other than that no experience in Databases.


###Signiﬁcance

The reason I want to remake this web app is because the current one is outdated with the latest version of the game. If I remake and release this app it will benefit those who used the old one as they will be able to enjoy a new current version. Also because I still play this game and find it enjoyable I wanted to pick a topic for my database project that would interest me so naturally making a database about the game I enjoyed the most was the obvious choice. I also hope to learn a lot about databases through this project.


###Deliverables

####Skeleton: 

 - Database of all the item names, champions, and summoner spells. Information will be retrieved directly from the League of Legends API, meaning that the database will always be up to date with the current champions, items, and summoner spells.
 - Picks out and sorts random items into into a list of 6. Doesn’t care if there are duplicates also picks a random champion. Outputs in text form to console.



####Basic:

 - No longer pick duplicate items into a build, each item will be unique, and there will be no conflicts with one item preventing the purchase of another. (For example, building one gold income item will prevent you from building another gold income item, as that would break League of Legend's rules)
 - The user will now be able to select maps other than the "Summoner's Rift", so the program will generate builds from the items available for that map, so they don't end up with a build that won't work for them.
 - Will indicate what "Keystone Mastery" the player is supposed to obtain, the other mastery points are for them to decide.

####Solid: 
 
 - Includes the ability the champion is forced to maximize first. (Q, W, E) 
 - Include 2 summoner spells with each build, also following the game rule of no duplicate spells in a single build.
 - Allow the user to filter through the champions based on their preferred role, (Bruiser, Caster, etc.) so the program will generate a build only including their specified type of champion.

####Awesome: 
 
 - Builds will now have titles that reflect the items and champion generated for the match.
 - In a special case where the Summoner Spell: Smite is chosen, the first item will be replaced with a “Jungle” item and this item will be chosen according to the role of the champion. 

 ###Tools
 
 - Ruby
 - Ruby Gems
 - Sequel[2]

 ###Possible Problems
 - Special cases in which a champion starts off with an item because of the games design.
 - Some champions which are required to level a certain ability first because of the games design.
 - Due to these cases and more we will need to design our database to be flexible.

 ###References


[1] Ultimate-bravery.com, 'Ultimate Bravery | League of Legends', 2015. [Online]. Available: http://www.ultimate-bravery.com/. [Accessed: 30- Sep- 2015]

[2] Sequel.jeremyevans.net, 'Sequel: The Database Toolkit for Ruby', 2015. [Online]. Available: http://sequel.jeremyevans.net/. [Accessed: 30- Sep- 2015]

