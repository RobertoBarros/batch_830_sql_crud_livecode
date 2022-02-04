
require "sqlite3"
DB = SQLite3::Database.new("database.db")
DB.results_as_hash = true
require_relative "task"

def list_all_tasks
  tasks = Task.all
  tasks.each do |task|
    puts "#{task.done ? "[x]" : "[ ]"} #{task.title}  - #{task.description}"
  end
end


# READ ONE
# task = Task.find(1)
# puts "#{task.title} - #{task.description}"

# READ ALL
# list_all_tasks

# CREATE
# task = Task.new({ title: "Flashcards", description: "Don't forget your flashcards" })
# task.save
# list_all_tasks

# UPDATE
# task = Task.find(4)

# task.title = "Drink More"
# task.description = "You really deserve"
# task.done = true
# task.save

# list_all_tasks


# DELETE
task = Task.find(3)
task.destroy
list_all_tasks
