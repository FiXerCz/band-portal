class AddAttachmentHeaderToBands < ActiveRecord::Migration
  def self.up
    change_table :bands do |t|
      t.attachment :header
    end
  end

  def self.down
    remove_attachment :bands, :header
  end
end
