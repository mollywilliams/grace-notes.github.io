---
---
$ = jQuery

$(document).ready ->

  books = '(Gen(esis)?|Ex(odus)?|Lev(iticus)?|Num(bers)?|Deut?(eronomy)?|Jos?(hua)?|Jud(ges)?|Ru(th?)?|(1(st)?|I) ?Sa(m(uel)?)?|(2(nd)?|II) ?Sa(m(uel)?)?|(1(st)?|I) ?Ki(ngs)?|(2(nd)?|II) ?Ki(ngs)?|(1(st)?|I) ?Chr(on(icles)?)?|(2(nd)?|II) ?Chr(on(icles)?)?|Ez(ra)?|Ne(h(emiah)?)?|Es(t(her)?)?|Job|Ps(alms?)?|Pro(v(erbs)?)?|Ecc(lesiastes)?|Sg|Song of Songs|Song of Sol(omon)?|Is(a(iah)?)?|Je(r(emiah)?)?|La(m(entations)?)?|Ez(e(k(iel)?)?)?|Da(n(iel)?)?|Ho(s(ea)?)?|Joel|Jl|Am(os)?|Ob(a(d(iah)?)?)?|Jon(ah)?|Mi(c(ah)?)?|Na(h(um)?)?|Hb|Ha(b(akkuk)?)?|Zep(haniah)?|Hg|Hag(gai)?|Zec(h(ariah)?)?|Mal(achi)?|Mt|Matt(hew)?|M(ar)?k|Luke|Lk|John|Jn|Acts|Rom(ans)?|(1(st)?|I) ?Cor(inthians)?|(2(nd)?|II) ?Cor(inthians)?|Ga(l(atians)?)?|Eph(esians)?|Phil(ippians)?|Col(ossians)?|(1(st)?|I) ?Thess(alonians)?|(2(nd)?|II) ?Thess(alonians)?|(1(st)?|I) ?Tim(othy)?|(2(nd)?|II) ?Tim(othy)?|Tit(us)?|Philem(on)?|Phlm|Heb(rews)?|Ja(me)?s|((1(st)?|I)|(2(nd)?|II)) ?(Peter|Pt|Pet)|((1(st)?|I)|(2(nd)?|II)|(3(rd)?|III)) ?(John|Jn)|Jude?|Jd|Rev(elation)?)'
  replacement = '<a href="http://www.biblegateway.com/passage/?search=$1&version=nasb" data-bibleref="$1">$1</a>'
  $("p,li,dd,dt,td").html (index, html)->
    return html
    .replace(XRegExp('([\\p{InGreek_and_Coptic}\\p{InGreek_Extended}]+)', 'g'), '<span class="greek">$1</span>')
    .replace(RegExp('('+books+'\.? [0-9]{1,3}([0-9 -:;,]+[0-9])?)', 'gi'), replacement)

  $('body').on 'focus click', 'a[data-bibleref]', (e)->
    e.preventDefault()
    return if $(this).data('bibletext')
    that = this
    
    $(that).css("cursor", "progress")
    $.ajax
      url:'http://getbible.net/json'
      dataType: 'jsonp'
      jsonp: 'getbible'
      data: 'v=nasb&p='+$(this).data('bibleref').replace(/Deut\.?/gi, "Deuteronomy")
    .then (data)->
      html = ''
      if data.book?
        for book in data.book
          html += '<h3>'+book.book_name+' '+book.chapter_nr+'</h3>'
          for own key, verse of book.chapter
            html += '<p><b>'+key+'</b> ' + verse.verse + '</p>'
        $(that).data("bibletext", html)
        $(that).popover
          html: true
          content: html
          placement: 'auto top'
          container: '.wrap'
          trigger: 'focus click'
        .popover('show')
      else
        html = "<div class='alert alert-warning'>Could not retrieve bible text.</div>"
        $(that).data("bibletext", html)
        $(that).popover
          html: true
          title: 'Error'
          content: html
          placement: 'auto top'
          container: '.wrap'
          trigger: 'focus click'
        .popover('show')
    .fail ->
      html = "<div class='alert alert-warning'>Could not retrieve bible text.</div>"
      $(that).data("bibletext", html)
      $(that).popover
        html: true
        title: 'Error'
        content: html
        placement: 'auto top'
        container: '.wrap'
        trigger: 'focus click'
      .popover('show')
    .always ->
      $(that).css("cursor", "default")

  $('body').on 'click', '.greek', (e)->
    word = $(e.target)

    if word.data("alternate")
      alt = word.data("alternate")
      word.data("alternate", $(e.target).text())
      word.text(alt)

    else
      url = escape('http://transliterate.com/Home/Transliterate?input=' + word.text())
      $.ajax
        url: 'https://jsonp.nodejitsu.com/?url=' + url
        dataType: 'json'
        cache: true
        success: (data)->
          if data.sbl?
            word.data('alternate', word.text())
            word.text(data.sbl)

          else
            word.toggleClass('greek')

  letters = unique $(".topics-list li").map(-> $(this).data("letter"))
  key = $("<div class='topics-key'><a data-filter='*' href='#filter-all'>all</a></div>").prependTo(".topics-list")
  key.append($("<a>"+l+"</a>").attr("href", "#filter-#{l}").data("filter", l)) for l in letters
  key.click (e)->
    e.preventDefault()
    f = $(e.target).data('filter')
    $('.topics-list').css('min-height', $('.topics-list').innerHeight())
    if f is "*"
      $(".topics-list li").show()
      setTimeout -> $('.topics-list').css('min-height', 0)
    else
      $(".topics-list li[data-letter!='#{f}']").hide()
      setTimeout ->
        $(".topics-list li[data-letter='#{f}']").show()
        setTimeout -> $('.topics-list').css('min-height', 0)

unique = (a)->
  o = {}
  r = []
  o[i] = i for i in a
  r = (i for i of o)

