require 'csv'
class Cookbook
  def initialize(csv_file_path)
    @filepath = csv_file_path
    # @csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
    @recipes = []
    CSV.foreach(@filepath) do |row|
      @recipes << Recipe.new(row[0], row[1], row[2], row[3] == "true")
    end
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    write_csv
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    write_csv
  end

  def mark_as_done(recipe_index)
    @recipes[recipe_index].done = true
    write_csv
  end

  def write_csv
    CSV.open(@filepath, 'wb') do |csv|
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.duration, recipe.done]
      end
    end
  end
end
