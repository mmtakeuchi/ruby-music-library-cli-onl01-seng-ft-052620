class MusicLibraryController
    def initialize(path = './db/mp3s')
        @path = MusicImporter.new(path).import
    end

    def call
        puts "Welcome to your music library!"
        puts "To list all of your songs, enter 'list songs'."
        puts "To list all of the artists in your library, enter 'list artists'."
        puts "To list all of the genres in your library, enter 'list genres'."
        puts "To list all of the songs by a particular artist, enter 'list artist'."
        puts "To list all of the songs of a particular genre, enter 'list genre'."
        puts "To play a song, enter 'play song'."
        puts "To quit, type 'exit'."
        puts "What would you like to do?"

        input = gets.strip
        self.call unless input == 'exit'

        case input
        when 'list songs'
            self.list_songs
        when 'list artists'
            self.list_artists
        when 'list genres'
            self.list_genres
        when 'list artist'
            self.list_songs_by_artist
        when 'list genre'
            self.list_songs_by_genre
        when 'play song'
            self.play_song
        end
    end

    def list_songs
        Song.all.sort_by{|s| s.name}.map.with_index(1) {|s, i| puts "#{i}. #{s.artist.name} - #{s.name} - #{s.genre.name}"}
    end

    def list_artists
        Artist.all.sort_by{|a| a.name}.map.with_index(1) {|a, i| puts "#{i}. #{a.name}"}
    end

    def list_genres
        Genre.all.sort_by{|g| g.name}.map.with_index(1) {|g, i| puts "#{i}. #{g.name}"}
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:" 
        input = gets.strip

        if artist = Artist.find_by_name(input)
            artist.songs.sort_by{|s| s.name}.map.with_index(1) {|s, i| puts "#{i}. #{s.name} - #{s.genre.name}"}
        end
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:" 
        input = gets.strip

        if genre = Genre.find_by_name(input)
            genre.songs.sort_by{|s| s.name}.map.with_index(1) {|s, i| puts "#{i}. #{s.artist.name} - #{s.name}"}
        end
    end

    def play_song
        puts "Which song number would you like to play?"
        input = gets.strip.to_i

        if (0..Song.all.length).include?(input)
            Song.all.sort_by{|s| s.name}.map.with_index(1) {|s, i| puts "Playing #{s.name} by #{s.artist.name}" if i == input}
        end
    end
end