class Card

  attr_reader :is_face_up, :face_value

  def initialize(face_value)
    @face_value = face_value
    @is_face_up = false
  end

  def display
    if @is_face_up
      @face_value
    else
      ' '
    end
  end

  def hide
    @is_face_up = false
  end

  def reveal
    @is_face_up = true
  end

  def to_s
    @face_value
  end

  def ==(other_card)
    @face_value == other_card.face_value
  end

end
