class CreateBridNodes < ActiveRecord::Migration[7.1]
  def change
    create_table :brid_nodes do |t|
      t.string :bird

      t.timestamps
    end
  end
end
