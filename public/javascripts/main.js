(function() {
  $( document ).ready( function() {

    // companies/show.haml

    $( '.profile-pic' ).popover({
      title: '<a href="/">Vlad Mehakovic</a>',
      html: 'true',
      content: "Head of CX, Holler"
    });

    $( '.profile-pic' ).on( 'click', function( event ) {
      $( '.profile-pic' ).not( this ).popover( 'hide' );
    })

    $( '.service' ).on( 'click', function( event ) {
      target = $( event.target );
      service = target.data( 'service' );
      $( '.' + service + '-votes' ).toggleClass( 'hidden' );
    })

  })
}).call(this);