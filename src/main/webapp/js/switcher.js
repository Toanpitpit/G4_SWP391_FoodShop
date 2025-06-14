window.console =
  window.console ||
  (function () {
    var e = {};
    e.log =
      e.warn =
      e.debug =
      e.info =
      e.error =
      e.time =
      e.dir =
      e.profile =
      e.clear =
      e.exception =
      e.trace =
      e.assert =
        function () {};
    return e;
  })();

$(document).ready(function () {
    var e =
        '<div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRight">' +
            '<div class="offcanvas-header">' +
                '<h6 id="offcanvasRightLabel">Theme Colors</h6>' +
                '<button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>' +
            '</div>' +
            '<div class="offcanvas-body">' +
                '<div class="widget-content-tab">' +
                    '<div class="widget-content-inner active">' +
                        '<form class="form-theme-color">' +
                            '<fieldset class="menu-color">' +
                                '<div class="body-title mb-10">Menu Background color</div>' +
                                '<div class="select-colors-theme colors-menu mb-10">' +
                                    '<div class="item color-fff active default"></div>' +
                                    '<div class="item color-1E293B"></div>' +
                                    '<div class="item color-1B1B1C"></div>' +
                                    '<div class="item color-3A3043"></div>' +
                                '</div>' +
                            '</fieldset>' +

                            '<fieldset>' +
                                '<div class="body-title mb-10">Header Background color</div>' +
                                '<div class="select-colors-theme colors-header mb-10">' +
                                    '<div class="item color-fff active default"></div>' +
                                    '<div class="item color-1E293B"></div>' +
                                    '<div class="item color-1B1B1C"></div>' +
                                    '<div class="item color-3A3043"></div>' +
                                '</div>' +
                            '</fieldset>' +

                            '<fieldset>' +
                                '<div class="body-title mb-10">Theme Primary color</div>' +
                                '<div class="select-colors-theme colors-theme-primary mb-10">' +
                                    '<div class="item color-2377FC active default"></div>' +
                                    '<div class="item color-DE6E49"></div>' +
                                    '<div class="item color-35988D"></div>' +
                                    '<div class="item color-7047D6"></div>' +
                                    '<div class="item color-189D72"></div>' +
                                '</div>' +
                            '</fieldset>' +

                            '<fieldset>' +
                                '<div class="body-title mb-10">Theme Background color</div>' +
                                '<div class="select-colors-theme colors-theme-background mb-10">' +
                                    '<div class="item color-F2F7FB active default"></div>' +
                                    '<div class="item color-252E3A"></div>' +
                                    '<div class="item color-1E1D2A"></div>' +
                                    '<div class="item color-1B2627"></div>' +
                                    '<div class="item color-1F2027"></div>' +
                                '</div>' +
                            '</fieldset>' +

                            '<fieldset>' +
                                '<div class="body-title mb-10">Menu with background image</div>' +
                                '<div class="select-colors-theme image-menu-background mb-10">' +
                                    '<div class="item image img-1"><img src="images/bg-menu/img-1.jpg" alt=""></div>' +
                                    '<div class="item image img-2"><img src="images/bg-menu/img-2.jpg" alt=""></div>' +
                                    '<div class="item image img-3"><img src="images/bg-menu/img-3.jpg" alt=""></div>' +
                                    '<div class="item image img-4"><img src="images/bg-menu/img-4.jpg" alt=""></div>' +
                                    '<div class="item image img-5"><img src="images/bg-menu/img-5.jpg" alt=""></div>' +
                                '</div>' +
                            '</fieldset>' +

                            '<div class="tf-button cursor-pointer w-full button-clear-select">Clear all</div>' +
                        '</form>' +
                    '</div>' +
                '</div>' +
            '</div>' +
        '</div>';

    $("#wrapper").append(e);
});


window.console =
  window.console ||
  (function () {
    var x = {};
    x.log =
      x.warn =
      x.debug =
      x.info =
      x.error =
      x.time =
      x.dir =
      x.profile =
      x.clear =
      x.exception =
      x.trace =
      x.assert =
        function () {};
    return x;
  })();

$(document).ready(function () {
    var x =

    '<div class="divider"></div>' +
    '<div class="setting cursor-pointer" data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight">' +
        '<i class="icon-settings"></i>' +
    '</div>' ;
    
  $(".header-grid").append(x);
});
