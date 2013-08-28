class CreateSmartbars < ActiveRecord::Migration
  def change
    create_table :smartbars do |t|
      t.string :name
      t.integer :customer_id
      t.string :url
      t.string :url_regex
      t.text :html
      t.text :minified_html
      t.text :css
      t.text :minified_css
      t.string :position_element, default: "body"
      t.boolean :position_prepend, default: true
      t.string :callback_url
      t.string :status

      t.timestamps
    end

    add_index :smartbars, :customer_id
    add_index :smartbars, :url
  end
end
