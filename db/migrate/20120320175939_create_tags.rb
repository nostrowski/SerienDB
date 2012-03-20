class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :acronym
      t.text :comment
      t.string :color

      t.timestamps
    end
  end
end
