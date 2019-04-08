require 'pry'

class Song
  attr_accessor :name, :artist_name
  @@all = []

  def self.all
    @@all
  end

  def self.create
    song = self.new
    song.save
    song
  end

  def self.new_by_name(song_name)
    song = self.create
    song.name = song_name
    song
  end

  def self.create_by_name(song_name)
    new_by_name(song_name)
  end

  def self.find_by_name(song_name)
    self.all.collect do |x|
      if x.name == song_name
        return x
      end
    end
    return nil
  end

  def self.find_or_create_by_name(song_name)
      if find_by_name(song_name) == nil
        create_by_name(song_name)
      else
        find_by_name(song_name)
      end
  end

  def self.alphabetical
    self.all.sort_by {|song_name| song_name.name}
  end

  def self.new_from_filename(file_name) #"Thundercat - For Love I Come.mp3"
    artist = file_name.split("-").collect {|x| x.strip!}
    song_name_part = artist[1].partition(/...[.mp3]\z/)
    song = find_or_create_by_name(song_name_part[0])
    song.artist_name = artist[0]
    song
  end

  def self.create_from_filename(file_name)
    new_from_filename(file_name)
  end

  def self.destroy_all
    self.all.clear
  end

  def save
    self.class.all << self
  end



end
