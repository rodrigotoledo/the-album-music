class CreateArtists < ActiveRecord::Migration[7.0]
  def change
    create_table :artists do |t|
      t.string :name, null: false
      t.references :user, null: true, foreign_key: true

      t.timestamps
    end
  end
end
