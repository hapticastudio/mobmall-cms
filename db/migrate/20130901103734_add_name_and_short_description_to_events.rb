class AddNameAndShortDescriptionToEvents < ActiveRecord::Migration
  def change
    add_column :events, :name, :string
    add_column :events, :short_description, :string
  end
end
