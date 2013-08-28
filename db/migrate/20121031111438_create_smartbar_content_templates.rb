class CreateSmartbarContentTemplates < ActiveRecord::Migration
  def change
    create_table :smartbar_content_templates do |t|
      t.string :name
      t.text :html
      t.text :css

      t.timestamps
    end
  end
end
