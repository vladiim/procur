$( document ).ready( ->

  $( '.service' ).on 'click', ( event ) ->
    $target = $( event.target )
    service = $target.data( 'service' )
    $( ".#{ service }-votes" ).toggleClass 'hidden'

  $( '.profile-pic' ).popover({
    title: '<a href="/">Vlad Mehakovic</a>',
    html: 'true',
    content: "Head of CX, Holler"
  })

  $( '.profile-pic' ).on 'click', ( event ) ->
    $( '.profile-pic' ).not( this ).popover( 'hide' )

)