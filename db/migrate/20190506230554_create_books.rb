class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :title
      t.integer :page_count
      t.integer :year_published
      t.string :thumbnail

      t.timestamps
    end
  end
end