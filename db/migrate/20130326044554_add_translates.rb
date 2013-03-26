class AddTranslates < ActiveRecord::Migration
  def up
  	Location.create_translation_table!({
      :city => :string
    }, {
      :migrate_data => true
    })

    remove_column :places, :city
  end

  def down
  end
end
