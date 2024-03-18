class CreateNodes < ActiveRecord::Migration[7.1]
  def change
    create_table :nodes do |t|
      t.integer :value
      t.references :parent, null: false, foreign_key: true

      t.timestamps
    end
  end
end
