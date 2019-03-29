class CreateProjectsSkills < ActiveRecord::Migration[5.0]
  def change
    create_table :projects_skills do |t|
      t.string :project_id
      t.string :skill_id

      t.timestamps
    end
  end
end
