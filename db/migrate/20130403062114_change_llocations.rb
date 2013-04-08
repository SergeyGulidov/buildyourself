class ChangeLlocations < ActiveRecord::Migration
  def up
  	    create_table :cities do |t|
  	    	t.string :city_name_lv
  	    	t.string :city_name_ru
  	    	t.string :city_slug
    	end

    	create_table :countries do |t|
  	    	t.string :country_name_lv
  	    	t.string :country_name_ru
  	    	t.string :country_slug
    	end

    	add_column :places, :city_id, :integer
    	add_column :places, :country_id, :integer
  end

  def down
  end
end
