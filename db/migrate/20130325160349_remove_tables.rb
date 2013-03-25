class RemoveTables < ActiveRecord::Migration
  def up
  	drop_table :rs_evaluations
  	drop_table :rs_reputations
  	drop_table :rs_reputation_messages
  	drop_table :searches

  	remove_column :roles, :created_at
  	remove_column :roles, :updated_at
  	remove_column :contacts, :updated_at
  	remove_column :type_translations, :created_at
  	remove_column :type_translations, :updated_at
  	remove_column :place_translations, :created_at
  	remove_column :place_translations, :updated_at
  	remove_column :places, :slug

  end

  def down
  end
end
