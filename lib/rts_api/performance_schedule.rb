module RtsApi

  class PerformanceSchedule < Response
    
    def file_version
      get_text_node('FileVersion') 
    end

    def rts_version
      get_text_node('RtsVersion') 
    end

    def link_prefix
      get_text_node('LinkPreFix')
    end

    def tickets
      get_node_set('Tickets').map do |ticket|
        Ticket.new({
          code:   ticket.at('Code').text, 
          name:   ticket.at('Name').text,
          price:  ticket.at('Price').text,
          tax:    ticket.at('Tax').text
        })
      end
    end

    def films
      get_node_set('Films').map do |film|
        Film.new({
          title:        film.at('Title').text,
          title_short:  film.at('TitleShort').text,
          length:       film.at('Length').text,
          rating:       film.at('Rating').text,
          website:      film.at('WebSite').text,
          film_code:    film.at('FilmCode').text,
          mt_film_code: film.at('MtFilmCode').text,
          shows:        get_shows_from_film(film)
        })  
      end
    end

    private

    def get_shows_from_film(film)
      film.at('Shows').children.map do |show|
        Show.new({
          datetime:           show.at('DT').text,
          auditorium:         show.at('Aud').text,
          performance_id:     show.at('ID').text,
          sale_link:          show.at('SaleLink').text,
          seats_remaining:    show.at('RE').text,
          seats_sold:         show.at('Sold').text,
          sold_out?:          show.at('SO').text == 1,
          low_seats?:         show.at('LI').text == 1,
          ticket_type_codes:  get_ticket_type_codes_from_show(show)
        })
      end
    end

    def get_ticket_type_codes_from_show(show)
      show.at('TIs').children.map do |ti|
        ti.at('C').text
      end
    end

  end

end
