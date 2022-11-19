class RenameGenreIdColumnToItems < ActiveRecord::Migration[6.1]
  def change
    rename_column :items, :genreID, :genre_id
  end
end
