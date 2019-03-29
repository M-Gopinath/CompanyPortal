module EarningsHelper
  def full_earnings(m)
    m.basic_pay + m.hra + m.try(:medical_allowance) + m.try(:telephone_allowance) + m.special_allowance
  end

  def actual_earnings(a)
    (a.lop_basic ? a.lop_basic : a.basic_pay) + (a.lop_hra ? a.lop_hra : a.hra) + a.try(:medical_allowance) + a.try(:telephone_allowance) + (a.lop_special_allowance ? a.lop_special_allowance : a.special_allowance)
  end

  def total_deduction(d)
    d.pf_employeer_contribution + d.try(:tax_deduction).to_i + d.professonal_tax
  end
end
