# frozen_string_literal: true

class Record
  attr_accessor :created_at, :material, :thickness, :width, :length, :height,
                :surface, :comment, :amount

  def formatted_created_at
    return nil unless created_at

    DateTime.parse(created_at).strftime("%d.%m.%Y um %k:%M")
  end
end
