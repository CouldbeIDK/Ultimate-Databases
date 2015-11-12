



###Overview/Abstract

	After experiencing an outdated version of a third party web application for the game League of Legends I wanted to create a new updated version of said app. This app in its basic form takes items from the game and rearranges them into crazy, outlandish, “builds” which can make your game experience extremely difficult if you follow it’s instructions.


###Background

	Some material I have reviewed in relation to the project is Ruby syntax and a little about databases in general. Related software would be the original site[1]. I have worked with SQL once in Survey of Computer science but other than that no experience in Databases.


###Signiﬁcance

	The reason I want to remake this web app is because the current one is outdated with the latest version of the game. If I remake and release this app it will benefit those who used the old one as they will be able to enjoy a new current version. Also because I still play this game and find it enjoyable I wanted to pick a topic for my database project that would interest me so naturally making a database about the game I enjoyed the most was the obvious choice. I also hope to learn a lot about databases through this project.


###Deliverables

####Skeleton: 

 - Database of all the item names, champions, and summoner spells. Information will be retrieved from the League of Legends API.


 - Picks out and sorts random items into into a list of 6. Doesn’t care if there are duplicates also picks a random champion. Outputs in text form to console.



####Basic:

 - No longer pick duplicate items into a build


 - Allows user to choose map because certain items are map specific.



-Solid: 

 - Includes the ability the champion is forced to max. (Q, W, E,) 

 - Includes summoner spells as a new table.

 - Ability to filter through champions. (Based on roles)



-Awesome: 

 - Generates a title for your build depending on which items get chosen.  

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

