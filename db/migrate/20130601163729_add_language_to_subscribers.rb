class AddLanguageToSubscribers < ActiveRecord::Migration
  def change
    add_column :subscribers, :lang, :string, default: "lv"
  end
end
