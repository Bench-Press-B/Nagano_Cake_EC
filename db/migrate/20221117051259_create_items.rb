class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.integer :genreID,  null: false
      t.string :name,  null: false
      t.text :explanation,  null: false
      t.integer :non_taxed_price,  null: false
      t.boolean :is_active,  null: false, default: "false"

      t.timestamps
    end
  end
end
