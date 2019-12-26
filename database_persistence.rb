# frozen_string_literal: true

require 'pg'
require 'sinatra/base'

# Interface to sinatra application for storage and data manipulation
class DatabasePersistence
  def initialize(logger)
    @logger = logger
    @db = if Sinatra::Base.production?
            PG.connect(ENV['DATABASE_URL'])
          else
            PG.connect(dbname: 'todos')
          end
  end

  def disconnect
    @db.close
  end

  def find_list(id)
    tuple = query(<<~SQL, id).first
      SELECT *
        FROM lists
       WHERE id = $1;
    SQL

    id = tuple['id'].to_i
    todos = find_todos_for_list(id)
    { id: id, name: tuple['name'], todos: todos }
  end

  def all_lists
    result = query(<<~SQL)
      SELECT lists.*,
             COUNT(todos.id) AS todos_count,
             COUNT(NULLIF(todos.completed, true)) AS todos_remaining_count
        FROM lists
             LEFT OUTER JOIN todos
             ON lists.id = todos.list_id
       GROUP BY lists.id
       ORDER BY lists.name;
    SQL

    result.map do |tuple|
      { id: tuple['id'].to_i,
        name: tuple['name'],
        todos_count: tuple['todos_count'].to_i,
        todos_remaining_count: tuple['todos_remaining_count'].to_i }
    end
  end

  def create_new_list(list_name)
    query(<<~SQL, list_name)
      INSERT INTO lists (name)
      VALUES ($1);
    SQL
  end

  def delete_list(id)
    query(<<~SQL, id)
      DELETE FROM lists
       WHERE id = $1;
    SQL
  end

  def update_list_name(id, new_name)
    query(<<~SQL, id, new_name)
      UPDATE lists
         SET name = $2
       WHERE id = $1;
    SQL
  end

  def create_new_todo(list_id, todo_name)
    query(<<~SQL, list_id, todo_name)
      INSERT INTO todos (name, list_id)
      VALUES ($2, $1);
    SQL
  end

  def delete_todo_from_list(list_id, todo_id)
    query(<<~SQL, list_id, todo_id)
      DELETE FROM todos
       WHERE id = $2
             AND list_id = $1;
    SQL
  end

  def update_todo_status(list_id, todo_id, new_status)
    query(<<~SQL, list_id, todo_id, new_status)
      UPDATE todos
         SET completed = $3
       WHERE id = $2
             AND list_id = $1;
    SQL
  end

  def mark_all_todos_as_completed(list_id)
    query(<<~SQL, list_id)
      UPDATE todos
         SET completed = true
       WHERE list_id = $1;
    SQL
  end

  private

  def query(statement, *params)
    @logger.info "#{statement}: #{params}"
    @db.exec_params(statement, params)
  end

  def find_todos_for_list(list_id)
    query(<<~SQL, list_id).map do |tuple|
      SELECT *
        FROM todos
       WHERE list_id = $1;
    SQL
      { id: tuple['id'].to_i,
        name: tuple['name'],
        completed: tuple['completed'] == 't' }
    end
  end
end
