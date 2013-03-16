class TranslateTypes < ActiveRecord::Migration
  def self.up
    Type.create_translation_table!({
      :title => :string
    }, {
      :migrate_data => true
    })
  end

  def self.down
    Type.drop_translation_table! :migrate_data => true
  end
end

