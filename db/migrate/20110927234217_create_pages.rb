class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.string :tags
      t.text :content
      t.string :content_type
      t.boolean :published
      t.string :url

      t.timestamps
    end
  end
end
