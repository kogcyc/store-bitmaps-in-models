class CreateElements < ActiveRecord::Migration
  def change
    create_table :elements do |t|
      t.binary :bitmap
      t.string :caption

      t.timestamps
    end
  end
end
