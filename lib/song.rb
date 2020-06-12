class Song
    attr_accessor :song, :name, :artist, :genre

    @@all = []

    def initialize(name, artist = nil, genre = nil)
        @name = name
        self.artist = artist if artist
        self.genre = genre if genre
    end

    def self.all
        @@all
    end

    def self.destroy_all
        all.clear
    end

    def save
        @@all << self
    end

    def self.create(name, artist = nil, genre = nil)
        Song.new(name, artist, genre).tap {|song| song.save}
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def genre=(genre)
        @genre = genre
        genre.songs << self unless genre.songs.include?(self)
    end

    def self.find_by_name(name)
        self.all.find {|song| song.name == name}
    end

    def self.find_or_create_by_name(name)
        self.find_by_name(name) || self.create(name)
    end

    def self.new_from_filename(filename)
        artist_name, song_name, genre_name = filename.split(" - ")
        artist = Artist.find_or_create_by_name(artist_name)
        genre = Genre.find_or_create_by_name(genre_name.split(".")[0])
        new_song = self.new(song_name, artist, genre)
    end

    def self.create_from_filename(filename)
        song = self.new_from_filename(filename)
        song.save
    end
end