class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages, id: :uuid do |t|
      t.references :user, index: true, foreign_key: true, null: false, type: :uuid
      t.references :channel, index: true, foreign_key: true, null: false, type: :uuid
      t.string :message_type, default: 'plain', null: false
      t.text :text

      t.timestamps
    end
  end
end
