class Role < ApplicationRecord
	has_many :employees
  scope :all_roles, -> {where.not(id: [1,2])}
  def admin?
    self.name == "ADMIN"
  end


  def manager?
    self.name == "MANAGER"
  end

  def team_lead?
    self.name == "TEAM LEAD"
  end

  def software_engineers?
    senior_sofware_engineer? || software_engineer? || software_engineer_trainee?
  end

  def senior_sofware_engineer?
    self.name == 'SENIOR SOFTWARE ENGINEER'
  end

  def software_engineer?
    self.name == 'SOFTWARE ENGINEER'
  end

  def software_engineer_trainee?
    self.name == 'SOFTWARE ENGINEER TRAINEE'
  end
end
