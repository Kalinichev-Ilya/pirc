class CreateChannels < ActiveRecord::Migration[5.2]
  def change
    create_table :channels, id: :uuid do |t|
      t.string :name, limit: 30
      t.references :owner, index: true, foreign_key: { to_table: :users }, null: false, type: :uuid

      t.timestamps
    end
  end
end
