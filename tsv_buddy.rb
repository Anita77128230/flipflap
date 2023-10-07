# frozen_string_literal: true

# Module that can be included (mixin) to take and output TSV data
module TsvBuddy
  # Converts a String with TSV data into internal data structure @data
  TAB = "\t"
  NEWLINE = "\n"

  def take_tsv(tsv)
    @data = []
    lines = tsv.split(NEWLINE)
    headers = lines.shift.split(TAB)

    lines.each do |line|
      values = line.split(TAB)
      row = {}
      headers.each_with_index { |header, index| row[header] = values[index] }
      @data << row
    end
  end

  # Converts @data into tsv string
  # returns: String in TSV format
  def to_tsv
    headers = @data.first.keys
    tsv = @data.reduce([headers.join(TAB)]) do |result, row|
      result << headers.map { |header| row[header] }.join(TAB)
    end
    tsv.join(NEWLINE) + NEWLINE
  end
end
