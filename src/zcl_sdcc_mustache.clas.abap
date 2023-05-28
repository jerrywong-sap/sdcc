CLASS zcl_sdcc_mustache DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .

    TYPES:
      BEGIN OF gty_film_list,
        rank        TYPE i,
        title       TYPE string,
        distributor TYPE string,
        gross       TYPE wrbtr_cs,
        currency    TYPE waers,
        amount      TYPE string,
      END OF gty_film_list.

    TYPES:
      gtt_film_list TYPE STANDARD TABLE OF gty_film_list WITH DEFAULT KEY.

    TYPES:
      BEGIN OF gty_year_list,
        year   TYPE c length 4,
        source TYPE string,
        t_list TYPE gtt_film_list,
      END OF gty_year_list.

    TYPES:
      gtt_year_list TYPE STANDARD TABLE OF gty_year_list WITH DEFAULT KEY.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_sdcc_mustache IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA(lt_item) = VALUE gtt_year_list(
                      ( year   = '2022'
                        source = 'https://en.wikipedia.org/wiki/2022_in_film'
                        t_list = VALUE #(
                                   ( rank = 1  title = 'Avatar: The Way of Water' distributor = '20th Century / Disney' gross = '2320250281'  )
                                   ( rank = 2  title = 'Top Gun: Maverick' distributor = 'Paramount' gross = '1493491858'  )
                                   ( rank = 3  title = 'Jurassic World Dominion' distributor = 'Universal' gross = '1003700604'  )
                                   ( rank = 4  title = 'Doctor Strange in the Multiverse of Madness' distributor = 'Disney' gross = '955775804'  )
                                   ( rank = 5  title = 'Minions: The Rise of Gru' distributor = 'Universal' gross = '939628210'  )
                                   ( rank = 6  title = 'Black Panther: Wakanda Forever' distributor = 'Disney' gross = '859208836'  )
                                   ( rank = 7  title = 'The Batman' distributor = 'Warner Bros.' gross = '770962583'  )
                                   ( rank = 8  title = 'Thor: Love and Thunder' distributor = 'Disney' gross = '760928081'  )
                                   ( rank = 9  title = 'The Battle at Lake Changjin II' distributor = 'Huaxia' gross = '626571697'  )
                                   ( rank = 10 title = 'Puss in Boots: The Last Wish' distributor = 'Universal' gross = '484423608'  )
                       ) )
                      ( year   = '2021'
                        source = 'https://en.wikipedia.org/wiki/2021_in_film'
                        t_list = VALUE #(
                                   ( rank = 1  title = 'Spider-Man: No Way Home' distributor = 'Sony Pictures' gross = '1922233593'  )
                                   ( rank = 2  title = 'The Battle at Lake Changjin' distributor = 'Huaxia' gross = '911666236'  )
                                   ( rank = 3  title = 'Hi Mom' distributor = 'Lian Ray' gross = '841674419'  )
                                   ( rank = 4  title = 'No Time to Die' distributor = 'MGM / Universal' gross = '774253007'  )
                                   ( rank = 5  title = 'F9' distributor = 'Universal' gross = '726229501'  )
                                   ( rank = 6  title = 'Detective Chinatown 3' distributor = 'Wanda' gross = '686257563'  )
                                   ( rank = 7  title = 'Venom: Let There Be Carnage' distributor = 'Sony Pictures' gross = '506863592'  )
                                   ( rank = 8  title = 'Godzilla vs. Kong' distributor = 'Warner Bros. / Toho' gross = '470116094'  )
                                   ( rank = 9  title = 'Shang-Chi and the Legend of the Ten Rings' distributor = 'Disney' gross = '432243292'  )
                                   ( rank = 10 title = 'Sing 2' distributor = 'Universal' gross = '408396446'  )
                       ) )
                    ).
    SORT lt_item BY year.

    LOOP AT lt_item ASSIGNING FIELD-SYMBOL(<ls_item>).
      LOOP AT <ls_item>-t_list ASSIGNING FIELD-SYMBOL(<ls_list>).
        <ls_list>-amount = |{ <ls_list>-gross COUNTRY = 'US ' }|.
      ENDLOOP.
    ENDLOOP.

    TRY.
        DATA(lo_mustache) = zcl_mustache=>create(
          'Top 10 Highest-grossing films in {{year}} - source: {{source}}' && cl_abap_char_utilities=>newline &&
          '{{#t_list}}' && cl_abap_char_utilities=>newline &&
          '#{{rank}} - {{title}} - {{distributor}} - {{amount}} USD' && cl_abap_char_utilities=>newline &&
          '{{/t_list}}' ).

        DATA(lv_text) = lo_mustache->render( lt_item ).
        out->write( lv_text ).

      CATCH zcx_mustache_error INTO DATA(lo_e).
        out->write( lo_e->get_text( ) ).
    ENDTRY.

  ENDMETHOD.
ENDCLASS.
