class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|
      t.string :label
      t.string :category

      t.timestamps
    end
  end
end

