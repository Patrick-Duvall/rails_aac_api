class CreateIncidentTags < ActiveRecord::Migration[6.1]
  def change
    create_table :incident_tags do |t|
      t.references :incident, foreign_key: true
      t.references :tag, foreign_key: true

      t.timestamps
    end
  end
end
