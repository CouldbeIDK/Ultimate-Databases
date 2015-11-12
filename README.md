## Ultimate Bravery

####Disclaimer
The Ultimate Database isn’t endorsed by Riot Games and doesn’t reflect the views or opinions of Riot Games or anyone officially involved in producing or managing League of Legends. League of Legends and Riot Games are trademarks or registered trademarks of Riot Games, Inc. League of Legends © Riot Games, Inc.

This program was made possible through the Riot Games API, and uses it extensively.

###Overview
Ultimate Bravery was a community-made custom game mode for the game League of Legends. It would randomly pick out a champion for a player, as well as a random assortment of items for the player to build. I am hoping to make the program as well, hopefully with a few improvements. 

###Setup
First you will need to make sure you are using Ruby 2.1.1 or above. next you will need to install the required gems for these programs.
```sh
$gem install prettyprint
$gem install sqlite3
$gem install json
$gem install sequel
$gem install httparty
```
Next, you will need to run the Entry script to populate the database.
```sh
$ruby Entry.rb
```
###Run
To run the the Ultimate Bravery generator at this point, you simply need to tell ruby to BeBrave!
```sh
$ruby BeBrave.rb
```
Run it as many times as you want from here, and it will continue to generate builds for you.

####References
[Ultimate Bravery Website](http://www.ultimate-bravery.com/)