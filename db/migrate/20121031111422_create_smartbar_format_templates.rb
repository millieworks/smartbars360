class CreateSmartbarFormatTemplates < ActiveRecord::Migration
  def change
    create_table :smartbar_format_templates do |t|
      t.string :name
      t.text :html
      t.text :css

      t.timestamps
    end
  end
end
