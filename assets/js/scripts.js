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
        var url = 'http://pdr.bbaw.de/pdrws/g2l?ruleset=en19&method=greekToLatin&token=' + word.text() + '&output=json';
        $.jsonp({
          url: url,
          corsSupport: false,
          jsonpSupport: false,
          success: function(data) {
            if (data.result) {
              word.data('alternate', word.text());
              word.text(data.result);
            } else {
              word.toggleClass('greek');
            }
          }
        });
      }
    });
  });
})(jQuery);
