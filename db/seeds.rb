# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


cs = Category.create(title: 'Computer Science')
aqua = Category.create(title: 'Aquatic Animals')
memes = Category.create(title: 'Memes')
basketball = Category.create(title: 'Basketball')
lit = Category.create(title: 'Contemporary Literature')
music = Category.create(title: 'Music')

cs.trophy = Trophy.create(icon_path: "images/trophies/computer_science.png")
aqua.trophy = Trophy.create(icon_path: "images/trophies/aquatic_animals.png")
memes.trophy = Trophy.create(icon_path: "images/trophies/memes.png")
basketball.trophy = Trophy.create(icon_path: "images/trophies/basketball.png")
lit.trophy = Trophy.create(icon_path: "images/trophies/contemporary_literature.png")
music.trophy = Trophy.create(icon_path: "images/trophies/music.png")

basketball_question1 = basketball.questions.create(title: "What team won the very first NBA game?", rating: 1)
basketball_question2 = basketball.questions.create(title: "What NBA player scored 100 points on 3/2/62?", rating: 1)

aqua_question1 = aqua.questions.create(title: "What type of fish was Dory in ""Finding Nemo""?", rating: 1)
aqua_question2 = aqua.questions.create(title: "Which of the following is most toxic to aquarium fish?", rating: 1)

memes_question1 = memes.questions.create(title: "Which of the following memes is currently the name of a type of cryptocurrency?", rating: 1)
memes_question2 = memes.questions.create(title: "What video game is the quote, ""All your base are belong to us"" from?", rating: 1)

cs_question1 = cs.questions.create(title: "Who is considered to have written the first software?", rating: 1)
cs_question2 = cs.questions.create(title: "Who first used the term ""bug"" to describe a computer malfunction?", rating: 1)

lit_question1 = lit.questions.create(title: "Which author married their first cousin?", rating: 1)
lit_question2 = lit.questions.create(title: "Who wrote ""The Great Gatsby""?", rating: 1)

music_question1 = music.questions.create(title: "Who won ""Album of the Year"" at the 2014 Grammys?", rating: 1)
music_question2 = music.questions.create(title: "Which of the following was a member of the ""Highwaymen""?", rating: 1)

basketball_question1.answers.create(title: "The New York Knicks", is_correct: true)
basketball_question1.answers.create(title: "Chicago Stags", is_correct: false)
basketball_question1.answers.create(title: "Boston Browns", is_correct: false)
basketball_question1.answers.create(title: "Chicago Bulls", is_correct: false)
basketball_question2.answers.create(title: "Wilt Chamberlain", is_correct: true)
basketball_question2.answers.create(title: "Bill Russell", is_correct: false)
basketball_question2.answers.create(title: "John Doe", is_correct: false)
basketball_question2.answers.create(title: "Bill John", is_correct: false)

aqua_question1.answers.create(title: "Blue Hippo Tang", is_correct: true)
aqua_question1.answers.create(title: "Tomini Tang", is_correct: false)
aqua_question1.answers.create(title: "Clown fish", is_correct: false)
aqua_question1.answers.create(title: "Kole Tang", is_correct: false)
aqua_question2.answers.create(title: "Ammonia", is_correct: true)
aqua_question2.answers.create(title: "Nitrate", is_correct: false)
aqua_question2.answers.create(title: "Phosphate", is_correct: false)
aqua_question2.answers.create(title: "Carbon dioxide", is_correct: false)

memes_question1.answers.create(title: "Doge", is_correct: true)
memes_question1.answers.create(title: "Grumpy Cat", is_correct: false)
memes_question1.answers.create(title: "Neckbeard", is_correct: false)
memes_question1.answers.create(title: "Dinosaur", is_correct: false)
memes_question2.answers.create(title: "Zero Wing", is_correct: true)
memes_question2.answers.create(title: "Metroid", is_correct: false)
memes_question2.answers.create(title: "Super Mario Bros", is_correct: false)
memes_question2.answers.create(title: "F Zero", is_correct: false)

cs_question1.answers.create(title: "Ada Lovelace", is_correct: true)
cs_question1.answers.create(title: "Alan Turing", is_correct: false)
cs_question1.answers.create(title: "Bill Gates", is_correct: false)
cs_question1.answers.create(title: "Grace Hopper", is_correct: false)
cs_question2.answers.create(title: "Grace Hopper", is_correct: true)
cs_question2.answers.create(title: "Alan Turing", is_correct: false)
cs_question2.answers.create(title: "Charles Babbage", is_correct: false)
cs_question2.answers.create(title: "J Presper Eckert", is_correct: false)

lit_question1.answers.create(title: "Edgar Allan Poe", is_correct: true)
lit_question1.answers.create(title: "Ernest Hemmingway", is_correct: false)
lit_question1.answers.create(title: "F Scott Fitzgerald", is_correct: false)
lit_question1.answers.create(title: "James Joyce", is_correct: false)
lit_question2.answers.create(title: "F Scott Fitzgerald", is_correct: true)
lit_question2.answers.create(title: "James Joyce", is_correct: false)
lit_question2.answers.create(title: "Ernest Hemmingway", is_correct: false)
lit_question2.answers.create(title: "Harper Lee", is_correct: false)

music_question1.answers.create(title: "Beck", is_correct: true)
music_question1.answers.create(title: "Beyonce", is_correct: false)
music_question1.answers.create(title: "Kanye West", is_correct: false)
music_question1.answers.create(title: "Taylor Swift", is_correct: false)
music_question2.answers.create(title: "Johnny Cash", is_correct: true)
music_question2.answers.create(title: "Keith Whitley", is_correct: false)
music_question2.answers.create(title: "Bob Dylan", is_correct: false)
music_question2.answers.create(title: "Shooter Jennings", is_correct: false)

