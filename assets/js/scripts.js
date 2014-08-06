(function($){
  $(document).ready(function() {
    $("p,li").html(function(index, html) {
      return html.replace(XRegExp('([\\p{InGreek_and_Coptic}\\p{InGreek_Extended}]+)', 'g'), '<span class="greek">$1</span>');
    });

    $('body').on('click', '.greek', function(e) {
      var word = $(e.target);
      if (word.data("alternate")) {
        var alt = word.data("alternate");
        word.data("alternate", $(e.target).text());
        word.text(alt);
      } else {
        var url = escape('http://transliterate.com/Home/Transliterate?input=' + word.text());
        $.ajax({
          url: 'https://jsonp.nodejitsu.com/?url='+url,
          dataType: 'json',
          cache: true,
          success: function(data) {
            console.log(data);
            if (data.sbl) {
              word.data('alternate', word.text());
              word.text(data.sbl);
            } else {
              word.toggleClass('greek');
            }
          }
        });
      }
    });
  });
})(jQuery);
