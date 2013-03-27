class AddintervalTranslate < ActiveRecord::Migration
  def up
    Interval.create_translation_table!({
      :interval_name => :string
    }, {
      :migrate_data => true
    })

  end

  def down
  end
end
