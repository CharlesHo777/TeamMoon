class Participant < ApplicationRecord
  has_many :participants
  # belongs_to :buddy_scheme
  FACULTIES = ["Arts & Humanities", "King's Business School", "Dentistry, Oral & Craniofacial Sciences", "Law", "Life Sciences & Medicine", "Natural & Mathematical Sciences", "Nursing, Midwifery & Palliative Care", "Psychiatry, Psychology & Neuroscience", "Social Science & Public Policy"]

  DEPARTMENTS = ["Classics", "Comparative Literature", "Culture, Media & Creative Industries", "Digital Humanities", "English", "Film Studies", "French", "German", "History", "Liberal Arts", "Music", "Philosophy", "Spanish, Portuguese & Latin American Studies", "Theology & Religious Studies", "King's Digital Lab", "Modern Language Centre", "King's Business School", "Dentistry, Oral & Craniofacial Sciences", "Law", "Basic & Medical Biosciences", "Biomedical Engineering & Imaging Sciences", "Cancer & Pharmaceutical Sciences", "Cardiovascular Medicine & Sciences", "Immunology & Microbial Sciences", "Life Course Sciences", "Population Health & Environmental Sciences", "Chemistry", "Engineering", "Informatics", "Mathematics", "Physics", "Palliative Care, Policy & Rehabilitation", "Adult Nursing", "Child & Family Health", "Mental Health Nursing", "Midwifery", "Applied Technologies for Clinical Care", "Care for Long Term Conditions", "Methodologies", "Academic Psychiatry", "Neuroscience", "Psychology & Systems Sciences", "International School for Government", "Education, Communication & Society", "African Leadership Centre", "Geography", "Global Health & Social Medicine", "International Development", "Brazil Institute", "India Institute", "China Institute", "Australia Institute", "European & International Studies", "Political Economy", "Russia Institute", "Defence Studies", "War Studies", "Policy Institute"]

  YEARS = [1, 2, 3, 4, 5]

  def self.faculties
    FACULTIES.sort
  end

  def self.departments
    DEPARTMENTS.sort
  end

  def self.years
    YEARS
  end

  def self.buddy_scheme_map(scheme_id)
    if BuddyScheme.exists?(id: [scheme_id])
      BuddyScheme.find(scheme_id).name
    else
      "(None)"
    end
  end

  def self.buddy_map(buddy_id)
    if Participant.exists?(id: [buddy_id])
      Participant.find(buddy_id).name
    elsif buddy_id == -2
      "(Multiple Buddies)"
    else
      "(Not Paired)"
    end
  end

  def self.gender_map(n)
    if n == 0
      "Other"
    elsif n == 1
      "Male"
    elsif n == 2
      "Female"
    else
      ""
    end
  end

  def self.gender_preference_map(n)
    if n == 0
      "Any"
    elsif n == 1
      "Same Gender"
    elsif n == 2
      "Different Gender"
    else
      ""
    end
  end

end
