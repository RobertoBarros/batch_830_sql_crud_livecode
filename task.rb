class Task
  attr_accessor :id, :title, :description, :done

  def initialize(attributes = {})
    @id = attributes[:id]
    @title = attributes[:title]
    @description = attributes[:description]
    @done = attributes[:done] || false
  end

  def self.find(id)
    result = DB.execute('SELECT * FROM tasks WHERE id=?', id).first
    Task.new(id: result['id'], title: result['title'], description: result['description'], done: result['done'] == 1)
  end

  def self.all
    tasks = []
    results = DB.execute('SELECT * FROM tasks')
    results.each do |result|
      tasks << Task.new(id: result['id'], title: result['title'], description: result['description'], done: result['done'] == 1)
    end
    tasks
  end

  def create
    DB.execute("INSERT INTO tasks (title, description, done) VALUES (?, ?, ?)", @title, @description, @done ? 1 : 0)
    @id = DB.last_insert_row_id
  end

  def update
    DB.execute("UPDATE tasks SET title=?, description=?, done=? WHERE id=?", @title, @description, @done ? 1 : 0, @id)
  end

  def save
    @id ? update : create
  end

  def destroy
    DB.execute("DELETE FROM tasks WHERE id=?", @id)
  end
end
