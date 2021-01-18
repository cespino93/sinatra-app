# Here is where i will create some seed data to work with and test associations

# Create 2 Users

chris = User.create(name: "Chris", email: "chrisl.espino@gmail.com", password: "password")
crystal = User.create(name: "Crystal", email: "crystal@crystal.com", password: "password")

# Create some Recipes

Recipe.create(content: "This is my first recipe!", user_id: chris.id)

# Use Active Record to pre-associate data:

chris.recipes.create(content: "MMMM, I cannot wait to try this.")

crystals_recipe = crystal.recipes.build(content: "INGREDIENTS ounces dried fettuccine pasta, boneless, skinless chicken breasts about pound total, teaspoon kosher salt")
crystals_recipe.save