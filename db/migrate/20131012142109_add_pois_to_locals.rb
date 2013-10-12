class AddPoisToLocals < ActiveRecord::Migration
  def change
    add_column :locals, :poi, :integer
  end
end
