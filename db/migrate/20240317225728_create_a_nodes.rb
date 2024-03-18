class CreateANodes < ActiveRecord::Migration[7.1]
  def change
    create_table :a_nodes do |t|
      t.integer :value
      t.integer :previous

      t.timestamps
    end
  end
end
