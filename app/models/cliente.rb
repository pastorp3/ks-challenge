class Cliente < ApplicationRecord
  has_many :cuentas, dependent: :destroy

  enum gender: { hombre: 'Hombre', mujer: 'Mujer' }

  validates :first_name, :last_name_paternal, :last_name_maternal, 
            :email, :age, :gender, :date_of_birth, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  
  validates :curp, presence: true, uniqueness: true, 
            length: { is: 18 },
            format: { with: /\A[A-Z0-9]+\z/, message: "solo debe contener letras mayúsculas y números." }
  validate :validate_curp_format

  def full_name
    "#{first_name} #{last_name_paternal} #{last_name_maternal}".strip
  end

  private

  def validate_curp_format
    return unless curp.present? && required_fields_present?

    expected_curp = construct_expected_curp
    validate_curp(expected_curp)
  end

  def required_fields_present?
    date_of_birth.present? && first_name.present? && last_name_paternal.present?
  end

  def construct_expected_curp
    first_last_name = construct_first_last_name
    first_name_initial = extract_first_name_initial(first_name)
    birthdate_part = date_of_birth.strftime("%y%m%d")
    gender_part = gender_initial
    internal_consonants = internal_consonants_part

    "#{first_last_name}#{first_name_initial}#{birthdate_part}#{gender_part}#{internal_consonants}"
  end

  def construct_first_last_name
    last_name_paternal[0].upcase + first_vowel(last_name_paternal.upcase) + last_name_maternal[0].upcase
  end

  def gender_initial
    gender == "hombre" ? "H" : "M"
  end

  def validate_curp(expected_curp)
    unless curp[0..10] == expected_curp[0..10] && curp[13..15] == expected_curp[11..13]
      errors.add(:curp, "no es válido. Debe seguir el formato correcto.")
    end
  end

  def first_vowel(name)
    name =~ /[AEIOU]/ ? name[1..-1].match(/[AEIOU]/).to_s : "X"
  end

  def extract_first_name_initial(name)
    names = name.split
    return names[0][0].upcase if names.empty?
  
    normalized_first_name = names[0].unicode_normalize(:nfd).gsub(/[^\x00-\x7F]/, '').downcase
  
    if normalized_first_name == 'maria' || normalized_first_name == 'jose'
      return names[1][0].upcase if names[1]
    end
  
    names[0][0].upcase
  end

  def internal_consonants_part
    consonants = []
    consonants << last_name_paternal.upcase[1..-1].scan(/[BCDFGHJKLMNPQRSTVWXYZ]/).first
    consonants << last_name_maternal.upcase[1..-1].scan(/[BCDFGHJKLMNPQRSTVWXYZ]/).first
    consonants << first_name.upcase[1..-1].scan(/[BCDFGHJKLMNPQRSTVWXYZ]/).first
    consonants.compact.join
  end
end
