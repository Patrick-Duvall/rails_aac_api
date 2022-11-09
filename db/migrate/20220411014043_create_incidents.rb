class CreateIncidents < ActiveRecord::Migration[6.1]
  def change
    create_table :incidents do |t|
      t.string :title
      t.integer :year
      t.string :location
      t.text :description
      t.text :analysis

      t.timestamps
    end
  end
end
