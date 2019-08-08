charlotte = User.create(name: "Charlotte", email: "charlotte@charlotte.com", password: "password")
micah =  User.create(name: "Micah", email: "micah@micah.com", password: "helloworld")

charlotte.entries.create(glucose: 150, carbs: 24, insulin: 4.5)
charlotte.entries.create(glucose: 102, carbs: 0, insulin: 0)

micah.entries.create(glucose: 74, carbs: 60, insulin: 3)
micah.entries.create(glucose: 184, carbs: 0, insulin: 2.75)