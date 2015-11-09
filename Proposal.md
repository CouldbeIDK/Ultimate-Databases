



###Overview/Abstract

	After experiencing an outdated version of a third party web application for the game League of Legends I wanted to create a new updated version of said app. This app in its basic form takes items from the game and rearranges them into crazy, outlandish, “builds” which can make your game experience extremely difficult if you follow it’s instructions.


###Background

	Some material I have reviewed in relation to the project is Ruby syntax and a little about databases in general. Related software would be the original site[1]. I have worked with SQL once in Survey of Computer science but other than that no experience in Databases.


###Signiﬁcance

	The reason I want to remake this web app is because the current one is outdated with the latest version of the game. If I remake and release this app it will benefit those who used the old one as they will be able to enjoy a new current version. Also because I still play this game and find it enjoyable I wanted to pick a topic for my database project that would interest me so naturally making a database about the game I enjoyed the most was the obvious choice. I also hope to learn a lot about databases through this project.


###Deliverables

####Skeleton: 

 - Database of all the item names.


 - Picks out and sorts random items into into a list of 6. Doesn’t care if there are duplicates.


####Basic:

 - Now sorts the items by attributes. The attributes are Health, Health Regen, Mana, Mana Regen, Attack Damage, Ability Power, Armor, Magic Resist, Attack Speed, Critical Strike Movement Speed, Life Steal, Spell Vamp, Cooldown Reduction.


 - No longer picks duplicates into the builds and each build will have one and only one boot item which is a specific case and boots will have a separate table from the rest of the items.


 - Allows user to choose map because certain items are map specific.



-Solid: 

 - Includes champions(characters) as a new table. This champion table will also include the champions associated race, role (Marksman, Assassin, Mage, Support, Tank, Fighter), and abilities specific to each champion. (Each champion has four abilities but only 3 can be chosen to be maxed.)


 - Includes the ability the champion is forced to max. (Q, W, E,) 


 - Includes summoner spells as a new table.



-Awesome: 

 - Generates a title for your build depending on which items get chosen.  


 - Ability to filter through champions.


 - In a special case where the Summoner Spell: Smite is chosen, the first item will be replaced with a “Jungle” item and this item will be chosen according to the role of the champion. 


 - We will need to create a separate table just like with Boots for the Jungle items.


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

